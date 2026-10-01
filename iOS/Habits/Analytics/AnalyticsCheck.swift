#if DEBUG
import Core
import Foundation

enum AnalyticsCheck {
    static func run() async -> [String] {
        var failures: [String] = []
        func expect(_ value: Bool, _ name: String) { if !value { failures.append(name) } }
        let telemetry = Analytics(file: nil)
        let persistence = Persistence.inMemory()
        let store = HabitStore(repository: persistence.repository, analytics: telemetry)
        await store.load()
        let sentinel = "PRIVATE-NAME-NOTE-TOKEN"
        let preconsent = Habit(name: sentinel, symbol: "star", color: .blue, kind: .check)
        store.add(preconsent)
        telemetry.setConsent(true) // even an in-flight save started before consent must not be collected
        await store.flush(); telemetry.drain()
        expect(telemetry.inspect()?.outbox.isEmpty == true, "pre-consent pending creation not uploaded")
        store.toggleCheck(preconsent, on: store.today())
        expect(telemetry.inspect()?.counters["tracking_write_count"] == nil, "optimistic memory insertion not counted")
        await store.flush(); telemetry.drain()
        if ProcessInfo.processInfo.arguments.contains("-fail-entry-writes") {
            expect(store.problem != nil, "write failed")
            expect(telemetry.inspect()?.counters["tracking_write_count"] == nil, "failed save not counted")
            expect(telemetry.inspect()?.outbox.filter { $0.event == .activation }.isEmpty == true, "failed save not activation")
            return failures
        }
        expect(telemetry.inspect()?.counters["tracking_write_count"] == 1, "count after durable save")
        telemetry.setConsent(false)
        store.undoProgress(preconsent, on: store.today()); await store.flush()
        expect(telemetry.inspect() == nil, "opt-out leaves tracking functional and purges telemetry")
        telemetry.setConsent(true)
        var habits: [Habit] = []
        for kind in [HabitKind.check, .amount(unit: sentinel, increment: 2), .duration, .checklist, .quit, .task] {
            var habit = Habit(name: sentinel, symbol: "star", color: .blue, kind: kind)
            if kind == .task { habit.dueDay = store.today() }
            if kind == .checklist { habit.steps = [Step(name: sentinel)] }
            store.add(habit); habits.append(habit)
        }
        var cutDown = Habit(name: sentinel, symbol: "star", color: .blue, kind: .amount(unit: sentinel, increment: 2))
        cutDown.atMost = true; habits.append(cutDown); store.add(cutDown)
        await store.flush(); telemetry.drain()
        expect(telemetry.inspect()?.outbox.filter { $0.event == .entityCreated }.count == 7, "every type created durably")
        store.add(cutDown); await store.flush(); telemetry.drain()
        expect(telemetry.inspect()?.outbox.filter { $0.event == .entityCreated }.count == 7, "retry same creation is idempotent")
        for habit in habits {
            switch habit.kind {
            case .check, .task: store.toggleCheck(habit, on: store.today())
            case .amount, .duration: store.addProgress(habit, value: 123, on: store.today())
            case .checklist: store.toggleStep(habit.steps[0], of: habit, on: store.today())
            case .quit: _ = store.logSlip(habit, at: .now, note: sentinel)
            }
        }
        await store.flush(); telemetry.drain()
        expect(telemetry.inspect()?.counters["tracking_write_count"] == 7, "seven durable writes")
        expect(telemetry.inspect()?.counters["habit_write_cut_down"] == 1, "cut-down type")
        expect(telemetry.inspect()?.counters["habit_write_amount"] == 1, "amount separate")
        expect(telemetry.inspect()?.counters["task_write_count"] == 1, "task type")
        expect(telemetry.inspect()?.outbox.filter { $0.event == .activation }.count == 1, "one first observed activation")
        store.setNote(sentinel, of: cutDown, on: store.today()); await store.flush(); telemetry.drain()
        expect(telemetry.inspect()?.counters["note_saved_count"] == 1, "note adoption without text")
        let before = telemetry.inspect()!.counters["tracking_write_count"]
        let file = try? await store.backupFile()
        if let file {
            _ = try? await store.restore(from: file)
            telemetry.drain()
            expect(telemetry.inspect()?.counters["tracking_write_count"] == before, "restoration does not adopt or log")
            expect(telemetry.inspect()?.outbox.filter { $0.event == .entityCreated }.count == 7, "restoration does not create")
            try? FileManager.default.removeItem(at: file.deletingLastPathComponent())
        } else { failures.append("test backup unavailable") }
        do {
            let state = telemetry.inspect()!
            let payload = try AnalyticsDeliveryConfiguration().payload(state.outbox, installation: state.installation)
            let outgoing = String(decoding: payload, as: UTF8.self)
            expect(!outgoing.contains(sentinel), "names units notes absent from actual payload")
            expect(!habits.contains { outgoing.contains($0.id.uuidString) }, "no business identifiers on wire")
            let batch = (try JSONSerialization.jsonObject(with: payload) as? [String: Any])?["batch"] as? [[String: Any]] ?? []
            expect(!batch.contains { event in
                (event["properties"] as? [String: Any] ?? [:]).values.contains { ($0 as? NSNumber)?.intValue == 123 }
            }, "logged values absent")
        } catch { failures.append("wire serialization") }
        return failures
    }
}
#endif
