import Core
import Foundation
import Observation
import SwiftUI

/// Speed runs on the Watch (S2): launched by `Tools/perf/measure_watch_perf.sh` with
/// `-uitest -perf-meter -perf-drive <scenario>` and no UI test attached. The app drives itself while `MainThreadMeter`
/// records every main-thread stall of 17 ms or more; the driver writes each measured window ("# WINDOW name|start|end"),
/// each opening ("# OPEN …") and its notes into the same record (the iPhone's format, read by `analyze_stalls.py`).
@MainActor
enum WatchPerf {
    private static var started = false

    static func startIfAsked(model: WatchModel, navigation: WatchNavigation) {
        #if DEBUG
        let arguments = ProcessInfo.processInfo.arguments
        guard !started, WatchModel.testLaunch, let flag = arguments.firstIndex(of: "-perf-drive"), flag + 1 < arguments.count else { return }
        started = true
        let scenario = arguments[flag + 1]
        Task { @MainActor in
            await pause(6)
            MainThreadMeter.mark("# MEASURING")
            await run(scenario, model: model, navigation: navigation)
            MainThreadMeter.mark("# DONE")
        }
        #endif
    }

    /// Today drew for the first time: the script times a launch from `simctl launch` to this line.
    static func todayAppeared() {
        #if DEBUG
        guard !readyMarked else { return }
        readyMarked = true
        MainThreadMeter.mark(String(format: "# READY %.3f", Date.now.timeIntervalSince1970))
        #endif
    }
    private static var readyMarked = false

    #if DEBUG
    private static let window: Double = 12

    private static func run(_ scenario: String, model: WatchModel, navigation: WatchNavigation) async {
        let store = model.store
        let control = WatchPerfControl.shared
        switch scenario {
        case "launch":
            await pause(2) // the script reads READY
        case "tap-today":
            guard let water = store.habits.first(where: { $0.name == "Water" }) else { return note("no Water") }
            await measure("Today: +1 (tap to filled button)") {
                await repeatFor(window) {
                    withAnimation(.snappy(duration: 0.25)) { store.increment(water, on: store.today(), source: .watch) }
                    await pause(0.4)
                }
            }
            await measure("Today: ✓ and Undo") {
                guard let read = store.habits.first(where: { $0.name == "Read" }) else { return }
                await repeatFor(window) {
                    withAnimation(.snappy(duration: 0.25)) { store.toggleCheck(read, on: store.today(), source: .watch) }
                    await pause(0.4)
                }
            }
        case "scroll-today":
            await measure("Today: scrolling 30 habits") {
                await repeatFor(window) {
                    control.scrollStep &+= 1
                    await pause(0.1)
                }
            }
        case "day-details":
            guard let water = store.habits.first(where: { $0.name == "Water" || $0.name == "Habit 2" }) else { return note("no habit") }
            // The control (S2): a blank page pushed the same way in the same run; an opening adds under 50 ms to it.
            await open("Blank page (control, first)") { navigation.path = [.blank] }
            navigation.path = []
            await pause(1.2)
            await open("Blank page (control, again)") { navigation.path = [.blank] }
            navigation.path = []
            await pause(1.2)
            await open("Day details (first)") { navigation.path = [.day(water.id)] }
            navigation.path = []
            await pause(1.2)
            await open("Day details (again)") { navigation.path = [.day(water.id)] }
            await measure("Day details: +1") {
                await repeatFor(window) {
                    withAnimation(.snappy(duration: 0.25)) { store.increment(water, on: store.today(), source: .watch) }
                    await pause(0.4)
                }
            }
            navigation.path = []
        case "crown":
            guard let water = store.habits.first(where: { $0.name == "Water" }) else { return note("no Water") }
            await open("Log manually") { navigation.path = [.day(water.id), .logManually(water.id)] }
            await measure("Log manually: turning the Crown") {
                await repeatFor(window) {
                    control.crownStep &+= 1
                    await pause(0.05)
                }
            }
            navigation.path = []
        case "routine":
            let plan = TodayPlan.make(store)
            guard let section = plan.sections.first(where: { !$0.isQuitting && $0.rows.count > 1 }) else { return note("no section") }
            // The control (S2): an empty full-screen cover, presented the same way.
            await open("Blank cover (control, first)") { navigation.blankCover = true }
            navigation.blankCover = false
            await pause(1.2)
            await open("Blank cover (control, again)") { navigation.blankCover = true }
            navigation.blankCover = false
            await pause(1.2)
            await open("Routine (open)") {
                navigation.routine = RoutineSession(part: section.id, title: section.title, day: plan.day, habits: section.rows.map(\.habit))
            }
            await measure("Routine: paging with the Crown") {
                await repeatFor(window) {
                    control.pageStep &+= 1
                    await pause(0.6)
                }
            }
            navigation.routine = nil
        case "incoming-batch":
            await measure("Today: a 5,000-change batch from the iPhone arrives") {
                await applyBatch(model: model, logs: 5_000)
                await pause(3)
            }
        case "complication":
            await measure("Writing the complication snapshot (10 times)") {
                for _ in 0..<10 { await model.widgets.publish(store) }
            }
        case "first-fill-extreme":
            await firstFill(years: 15)
        case "first-fill-year":
            await firstFill(years: 1)
        default:
            note("unknown scenario \(scenario)")
        }
    }

    /// A batch of `logs` new logs made on a stand-in iPhone (its own database in memory), merged here as one batch.
    private static func applyBatch(model: WatchModel, logs: Int) async {
        let phone = HabitRepository.companion.openInMemory()
        do {
            try await phone.peerStart()
            let habits = model.store.habits.map { $0.record(position: 0) }
            let today = model.store.today()
            let entries = (0..<logs).map { i in
                Entry(habitID: model.store.habits[i % max(1, model.store.habits.count)].id,
                      day: today.adding(days: -(i / 40), calendar: model.store.calendar), value: 1, source: .today).record
            }
            try await phone.importAll(snapshot: Snapshot(habits: habits, steps: [], reminders: [], entries: entries, settings: []))
            guard let batch = try await phone.peerBatch(maxOps: Int32(logs + 100)) else { return note("no batch") }
            try await model.applyPeerBatchForTest(batch)
        } catch {
            note("batch failed: \(error)")
        }
    }

    /// The first fill of an extreme account (25,000 logs a year), on this Watch simulator: made on a stand-in iPhone
    /// database, sent part by part, checked and merged into a Watch database on disk. Reports time, size and memory.
    private static func firstFill(years: Int) async {
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent("fill-\(UUID().uuidString)")
        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: directory) }
        do {
            let phone = try HabitRepository.companion.open(path: directory.appendingPathComponent("phone.db").path)
            let watch = try HabitRepository.companion.open(path: directory.appendingPathComponent("watch.db").path)
            let habits = (0..<12).map { i in
                Habit(name: "Habit \(i)", symbol: "star.fill", color: .blue, kind: .check, remind: false,
                      createdAt: .now.addingTimeInterval(-Double(years) * 366 * 86_400)).record(position: i)
            }
            let ids = habits.map { UUID(uuidString: $0.id)! }
            let total = 25_000 * years
            let calendar = Calendar.current
            let today = LocalDay(.now)
            let made = Date.now
            for chunk in stride(from: 0, to: total, by: 25_000) {
                let entries = (chunk..<min(total, chunk + 25_000)).map { i in
                    Entry(habitID: ids[i % ids.count], day: today.adding(days: -(i / 68), calendar: calendar), value: 1, source: .today).record
                }
                try await phone.importAll(snapshot: Snapshot(habits: chunk == 0 ? habits : [], steps: [], reminders: [], entries: entries, settings: []))
            }
            try await phone.peerStart(); try await watch.peerStart()
            let madeSeconds = Date.now.timeIntervalSince(made)
            let start = Date.now
            var cursor: String?
            var parts = 0, biggest = 0, sent = 0
            var firstToday: Double?
            var peak = residentMegabytes()
            repeat {
                let part = try await phone.peerFillPart(cursor: cursor, maxRecords: 5_000)
                biggest = max(biggest, Int(part.size)); sent += Int(part.size)
                let receipt = try await watch.acceptPeerFill(base64: part.base64)
                parts += 1
                if parts == 2 && firstToday == nil { firstToday = Date.now.timeIntervalSince(start) } // habits and the newest logs
                peak = max(peak, residentMegabytes())
                cursor = receipt.next
            } while cursor != nil
            let seconds = Date.now.timeIntervalSince(start)
            let loadStart = Date.now
            let loaded = try await watch.load()
            let loadSeconds = Date.now.timeIntervalSince(loadStart)
            // What the Watch reads now: its last 400 days, quit habits and tasks whole (HabitStore.historyWindowDays).
            let windowStart = Date.now
            let window = try await watch.loadSince(day: today.adding(days: -400, calendar: calendar).key)
            let windowSeconds = Date.now.timeIntervalSince(windowStart)
            let size = ["watch.db", "watch.db-wal"].reduce(0) { sum, name in
                sum + ((try? FileManager.default.attributesOfItem(atPath: directory.appendingPathComponent(name).path)[.size] as? Int) ?? 0)
            }
            note(String(format: "first fill on the Watch simulator: %d logs (%d years) in %d parts, biggest %d KB, %.1f MB sent; %.1f s (Today right after %.1f s; the stand-in iPhone made it in %.1f s); Watch database %.0f MB; reading it all %.2f s (%d logs); reading the Watch's 400 days for Today %.2f s (%d logs); peak memory %.0f MB",
                        total, years, parts, biggest / 1024, Double(sent) / 1_048_576, seconds, firstToday ?? seconds, madeSeconds,
                        Double(size) / 1_048_576, loadSeconds, loaded.entries.count, windowSeconds, window.entries.count, peak))
            if loaded.entries.count != total { MainThreadMeter.mark("# ERROR fill merged \(loaded.entries.count) of \(total) logs") }
            try? phone.close(); try? watch.close()
        } catch {
            MainThreadMeter.mark("# ERROR first fill: \(error)")
        }
    }

    private static func residentMegabytes() -> Double {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size / MemoryLayout<natural_t>.size)
        let result = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) { task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count) }
        }
        return result == KERN_SUCCESS ? Double(info.resident_size) / 1_048_576 : 0
    }

    private static func note(_ text: String) { MainThreadMeter.mark("# NOTE \(text)") }
    private static func pause(_ seconds: Double) async { try? await Task.sleep(for: .seconds(seconds)) }
    private static var now: String { String(format: "%.3f", Date.now.timeIntervalSince1970) }

    private static func open(_ name: String, _ action: () -> Void) async {
        let start = now
        action()
        await pause(1.5)
        MainThreadMeter.mark("# OPEN \(name)|\(start)|\(now)")
    }

    private static func measure(_ name: String, _ work: () async -> Void) async {
        let start = now
        await work()
        MainThreadMeter.mark("# WINDOW \(name)|\(start)|\(now)")
        await pause(0.15)
    }

    private static func repeatFor(_ seconds: Double, _ step: () async -> Void) async {
        let end = Date.now.addingTimeInterval(seconds)
        while Date.now < end { await step() }
    }
    #else
    private static func pause(_ seconds: Double) async {}
    #endif
}

/// What a speed run moves without touching the screen: Today's scroll position, the Crown in Log manually, the
/// routine's page. Read only by those views; never set outside speed runs.
@Observable
final class WatchPerfControl {
    static let shared = WatchPerfControl()
    var scrollStep = 0
    var crownStep = 0
    var pageStep = 0
}
