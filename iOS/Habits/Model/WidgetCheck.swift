#if DEBUG
import Core
import Foundation
import SwiftUI
import WidgetKit

/// Runs inside the actual iPhone app against the Kotlin repository, not a mock log implementation.
enum WidgetFixture {
    static func install(in store: HabitStore) async {
        guard store.habits.isEmpty else { return }
        let start = store.today().adding(days: -40, calendar: store.calendar)
        let longLabels = ProcessInfo.processInfo.arguments.contains("-widget-long-labels")
        let items = [
            Habit(name: "Widget check", symbol: "checkmark", color: .blue, kind: .check, startsOn: start),
            Habit(name: longLabels ? "Widget water with a longer personal habit name" : "Widget water", symbol: "drop", color: .blue,
                  kind: .amount(unit: longLabels ? "large glasses of water" : "glasses", increment: 1), goal: 8, startsOn: start),
            Habit(name: "Widget cut down", symbol: "cup.and.saucer", color: .orange, kind: .amount(unit: "cups", increment: 1), goal: 3, atMost: true, startsOn: start),
            Habit(name: "Widget quit", symbol: "leaf", color: .green, kind: .quit, startsOn: start, quitSince: start.date(calendar: store.calendar)),
            Habit(name: "Widget timer", symbol: "timer", color: .blue, kind: .duration, goal: 10, startsOn: start)
        ]
        for item in items { store.add(item) }
        for i in 1...24 { store.add(Habit(name: "Widget task \(i)", symbol: "checkmark", color: .blue, kind: .task, dueDay: store.today(), startsOn: start)) }
        await store.flush()
    }
}
enum WidgetCheck {
    static func run() async -> [String] {
        var failures: [String] = []
        func expect(_ value: Bool, _ name: String) { if !value { failures.append(name) } }
        let persistence = Persistence.inMemory()
        let store = HabitStore(repository: persistence.repository)
        await store.load(); await WidgetFixture.install(in: store)
        let now = Date.now, day = store.today(now: now)
        func item(_ name: String) -> Habit { store.habits.first { $0.name == name }! }
        func row(_ name: String) -> WidgetItem { store.widgetSnapshot(now: now).frames.first!.items.first { $0.name == name }! }
        var tiny = row("Widget water")
        tiny.value = 0.01; tiny.goal = 0.05
        expect(tiny.displayedValue == 0.01.formatted(.number.precision(.fractionLength(0...2)))
               && tiny.compactProgress.hasPrefix(tiny.displayedValue + "/"), "Compact widgets preserve hundredths instead of showing zero")
        let snapshot = store.widgetSnapshot(now: now)
        expect(snapshot.frames.count == 7, "Seven logical days precomputed")
        expect(snapshot.frames.first?.items.filter(\.isTask).count == 24, "All unlimited tasks survive snapshot")
        expect(snapshot.frames.first?.agenda(completed: false).prefix(5).allSatisfy { !$0.isTask } == true,
               "All free habits stay together ahead of a long task list")
        expect(store.activeHabitCount == 5 && !store.canAddHabit, "Quit and cut down share five habit cap; tasks excluded")
        expect(row("Widget quit").action == nil && row("Widget quit").counterStart != nil, "Quit has a counter and no destructive action")
        expect(row("Widget timer").action == nil, "Duration opens existing controls")
        expect(row("Widget cut down").ongoing && row("Widget cut down").status.contains("so far"), "Limit remains ongoing, no premature success")
        expect(row("Widget task 1").history.isEmpty, "Tasks have no habit history")
        expect(row("Widget water").history.count == 31, "Habit history bounded to 31 days")
        expect(snapshot.frames.allSatisfy { frame in
            let history = frame.items.first { $0.name == "Widget water" }!.history
            return history.count == 31 && history.last?.id == frame.day && history.last?.state == "open"
        }, "Every future timeline day retains a full recent-history window")
        expect(snapshot.frames[1].items.first { $0.name == "Widget water" }?.history.first { $0.id == day.key }?.state == "missed",
               "Unlogged days change from open to past when the timeline advances")
        let timer = item("Widget timer"), unchanged = row("Widget water").token
        store.startTimer(timer); await store.flush()
        let timerStart = store.timers[timer.id]!
        expect(row("Widget water").token == unchanged, "Starting a timer preserves unrelated widget projections")
        store.stopTimer(timer, on: day, through: timerStart.addingTimeInterval(60)); await store.flush()
        expect(row("Widget timer").value == 1 && row("Widget water").token == unchanged,
               "Stopping a timer publishes saved minutes without invalidating unrelated widgets")
        let water = item("Widget water"), event = UUID(), signature = HabitStore.widgetSignature(water)
        for _ in 0..<3 { store.logFromWidget(id: water.id, day: day, event: event, signature: signature, now: now) }
        await store.flush()
        expect(store.dayProgress(of: water, on: day) == 1, "Replayed rendered event logs only once")
        let freshRows = store.widgetSnapshot(now: now).frames.first!.items
        expect(freshRows.first { $0.id == water.id.uuidString }?.value == 1 && freshRows.first { $0.id == water.id.uuidString }?.token != snapshot.frames.first?.items.first { $0.id == water.id.uuidString }?.token,
               "Changed habit invalidates projection and receives a fresh action token")
        expect(freshRows.first { $0.name == "Widget check" }?.token == snapshot.frames.first?.items.first { $0.name == "Widget check" }?.token,
               "An unrelated entry preserves cached item projections")
        let loaded = HabitStore(repository: persistence.repository); await loaded.load()
        let persistedWater = loaded.habits.first { $0.id == water.id }!
        expect(HabitStore.widgetSignature(persistedWater) == signature, "Database timestamp precision preserves action signature")
        var unordered = water; unordered.frequency = .weekdays([2, 4, 6])
        unordered.reminders = [ReminderTime(hour: 18, minute: 0), ReminderTime(hour: 8, minute: 0)]
        var reordered = unordered; reordered.frequency = .weekdays(Set([6, 4, 2]))
        reordered.reminders.reverse()
        expect(HabitStore.widgetSignature(unordered) == HabitStore.widgetSignature(reordered), "Weekday sets and reminder order preserve action signature")
        expect(loaded.dayProgress(of: water, on: day) == 1 && loaded.entries(of: water.id).first?.source == .widget, "Widget entry persists with source")
        loaded.logFromWidget(id: water.id, day: day, event: event, signature: signature, now: now); await loaded.flush()
        expect(loaded.dayProgress(of: water, on: day) == 1, "Cold repository reopen deduplicates callback")
        let coldEvent = UUID()
        loaded.logFromWidget(id: water.id, day: day, event: coldEvent, signature: signature, now: now); await loaded.flush()
        expect(loaded.problem == nil && loaded.dayProgress(of: water, on: day) == 2, "Fresh rendered action survives cold launch")
        loaded.undoEntry(coldEvent); await loaded.flush()
        store.undoEntry(event); await store.flush()
        store.logFromWidget(id: water.id, day: day, event: event, signature: signature, now: now); await store.flush()
        expect(store.dayProgress(of: water, on: day) == 0, "Tombstone prevents replay after undo")
        for _ in 0..<3 { store.logFromWidget(id: water.id, day: day, event: UUID(), signature: signature, now: now) }
        store.addProgress(water, value: 1, on: day, source: .today)
        await store.flush()
        expect(store.dayProgress(of: water, on: day) == 4, "Concurrent queued app/widget additions retain all entries")
        let check = item("Widget check")
        for _ in 0..<3 { store.logFromWidget(id: check.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(check), now: now) }
        await store.flush()
        expect(store.dayProgress(of: check, on: day) == 1, "Completed check does not toggle or duplicate")
        expect(!store.widgetSnapshot(now: now).frames.first!.agenda(completed: false).contains { $0.id == check.id.uuidString }, "Remaining agenda hides completed")
        expect(store.widgetSnapshot(now: now).frames.first!.agenda(completed: true).contains { $0.id == check.id.uuidString }, "Configured agenda keeps completed")
        let cut = item("Widget cut down")
        for _ in 0..<4 { store.logFromWidget(id: cut.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(cut), now: now) }
        await store.flush()
        expect(store.dayProgress(of: cut, on: day) == 4 && row("Widget cut down").action != nil, "Limit keeps recording above threshold")
        let before = store.dayProgress(of: water, on: day)
        store.logFromWidget(id: water.id, day: day.adding(days: -1), event: UUID(), signature: signature, now: now); await store.flush()
        expect(store.dayProgress(of: water, on: day) == before && store.problem != nil, "Old-day action rejected without writing")
        store.problem = nil
        var edited = water; edited.name = "Renamed water"; store.update(edited); await store.flush()
        store.logFromWidget(id: water.id, day: day, event: UUID(), signature: signature, now: now); await store.flush()
        expect(store.dayProgress(of: edited, on: day) == before && store.problem != nil, "Edited item rejects stale configuration")
        store.problem = nil
        store.setSkipped(edited, on: day, true); await store.flush()
        store.logFromWidget(id: edited.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(edited), now: now); await store.flush()
        expect(store.dayProgress(of: edited, on: day) == before, "Skipped item cannot be revived")
        store.problem = nil
        UserDefaults.standard.set(true, forKey: WidgetDisk.privacyKey)
        store.logFromWidget(id: cut.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(cut), now: now); await store.flush()
        expect(store.dayProgress(of: cut, on: day) == 4, "Privacy disables widget logging")
        UserDefaults.standard.removeObject(forKey: WidgetDisk.privacyKey); store.problem = nil
        expect(store.widgetSnapshot(now: now, hidden: true).frames.allSatisfy { $0.items.isEmpty }, "Private snapshot contains no names or progress")
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent("WidgetCheck-" + UUID().uuidString)
        defer { try? FileManager.default.removeItem(at: directory) }
        let file = directory.appendingPathComponent("snapshot.json")
        do {
            try WidgetDisk.write(snapshot, to: file)
            expect(WidgetDisk.read(from: file)?.frames.first?.items.count == snapshot.frames.first?.items.count, "Atomic disk round trip")
            try Data("{".utf8).write(to: file, options: .atomic)
            expect(WidgetDisk.read(from: file) == nil, "Corrupt snapshot gives unavailable")
            var future = snapshot; future.version = 999
            expect(WidgetDisk.decode(try JSONEncoder().encode(future)) == nil, "Unknown schema rejected")
            var invalid = snapshot; invalid.frames[0].items[0].id = "invalid\nitem"
            expect(WidgetDisk.decode(try JSONEncoder().encode(invalid)) == nil, "Malformed item identities cannot crash URL rendering")
            var duplicate = snapshot; duplicate.frames[0].items.append(duplicate.frames[0].items[0])
            expect(WidgetDisk.decode(try JSONEncoder().encode(duplicate)) == nil, "Duplicate snapshot rows are rejected")
            var badAction = snapshot; badAction.frames[0].items[0].token = "invalid-event"
            expect(WidgetDisk.decode(try JSONEncoder().encode(badAction)) == nil, "Malformed action event is rejected before display")
        } catch { failures.append("Disk round trip: \(error)") }
        expect(WidgetDisk.decode(Data(repeating: 0, count: WidgetDisk.maximumBytes + 1)) == nil, "Oversized snapshot rejected")
        expect(snapshot.frame(at: now, timeZone: "invalid") == nil, "Travel invalidates old timezone snapshot")
        expect(snapshot.frame(at: now, locale: "invalid") == nil, "Locale change invalidates old formatted values")
        let pagingKey = "widget-check." + UUID().uuidString
        expect(WidgetDisk.page(key: pagingKey, set: 100_001) == 100_000 && WidgetDisk.page(key: pagingKey, set: -1) == 0,
               "Shared pagination clamps invalid values")
        expect(snapshot.frame(at: snapshot.frames.last!.end) == nil, "Expired outlook never carries old data")
        let quitID = item("Widget quit").id.uuidString
        let late = now.addingTimeInterval(30 * 86400)
        expect(PhoneWidgetTimeline.itemEntries(snapshot: snapshot, selection: quitID, now: late).first?.selected?.counterStart != nil,
               "Stable quit clock keeps running after agenda outlook expires")
        var bounded = snapshot
        for i in bounded.frames.indices {
            if let j = bounded.frames[i].items.firstIndex(where: { $0.id == quitID }) {
                bounded.frames[i].items[j].counterValidUntil = now.addingTimeInterval(10 * 86400)
            }
        }
        expect(PhoneWidgetTimeline.itemEntries(snapshot: bounded, selection: quitID, now: late).first?.selected == nil,
               "Known quit pause or end stops the extended counter")
        let quit = item("Widget quit")
        var endingQuit = quit; endingQuit.endsOn = day.adding(days: 1)
        store.update(endingQuit); await store.flush()
        let endedSnapshot = store.widgetSnapshot(now: now)
        expect(endedSnapshot.frames[2].items.first { $0.id == quitID }?.planned == false,
               "Quit end date removes the counter from future agendas")
        expect(endedSnapshot.frames.first?.items.first { $0.id == quitID }?.counterValidUntil == store.dayBounds(day.adding(days: 1)).upperBound.addingTimeInterval(1),
               "Quit counter ends at the saved wall-clock boundary")
        store.update(quit); await store.flush()
        let timeline = PhoneWidgetTimeline.entries(snapshot: snapshot, now: now)
        expect(timeline.count == 8 && timeline.last?.frame == nil, "Timeline includes explicit expired state")
        expect(zip(timeline, timeline.dropFirst()).allSatisfy { $0.date < $1.date }, "Timeline dates strictly increase")
        for (month, date) in [(3, 8), (11, 1)] {
            var calendar = Calendar(identifier: .gregorian); calendar.timeZone = TimeZone(identifier: "America/New_York")!
            let dstStore = HabitStore(repository: Persistence.inMemory().repository, calendar: calendar)
            await dstStore.load(); dstStore.settings.dayEndHour = 4
            let dst = LocalDay(year: 2026, month: month, day: date)
            let bounds = dstStore.dayBounds(dst)
            expect(calendar.component(.hour, from: bounds.lowerBound) == 4 && calendar.component(.hour, from: bounds.upperBound.addingTimeInterval(1)) == 4,
                   "04:00 wall-clock boundaries across DST \(month)")
            expect(dstStore.today(now: bounds.lowerBound) == dst && dstStore.today(now: bounds.lowerBound.addingTimeInterval(-1)) == dst.adding(days: -1), "Custom day starts exactly at boundary \(month)")
        }
        let repeating = Habit(name: "Repeating widget task", symbol: "checkmark", color: .blue, kind: .task,
                              frequency: .afterCompletion(2, .day), startsOn: day.adding(days: -5))
        store.add(repeating); await store.flush()
        store.logFromWidget(id: repeating.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(repeating), now: now); await store.flush()
        expect(!store.isDue(repeating, on: day.adding(days: 1)) && store.isDue(repeating, on: day.adding(days: 2)), "Task repeats from actual widget completion")
        let triple = Habit(name: "Three checks", symbol: "star", color: .blue, kind: .check, goal: 3, startsOn: day)
        store.add(triple); await store.flush()
        store.logFromWidget(id: triple.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(triple), now: now); await store.flush()
        expect(store.dayProgress(of: triple, on: day) == 1 && !store.isDone(triple, on: day), "One repeated-goal tap adds one, never completes whole goal")
        let weekly = Habit(name: "Weekly checks", symbol: "star", color: .blue, kind: .check, frequency: .perWeek(3), startsOn: day)
        store.add(weekly); await store.flush()
        for _ in 0..<2 { store.logFromWidget(id: weekly.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(weekly), now: now) }
        await store.flush()
        expect(store.dayProgress(of: weekly, on: day) == 2 && store.isSatisfied(weekly, on: day), "Weekly extra ticks remain additive after daily satisfaction")
        let weeklyRow = store.widgetSnapshot(now: now).frames.first!.items.first { $0.id == weekly.id.uuidString }!
        expect(weeklyRow.goal == 3 && weeklyRow.status.contains("this week"), "Weekly widget uses the period goal and names its period")
        let list = Habit(name: "Checklist", symbol: "checklist", color: .blue, kind: .checklist, steps: [Step(name: "One"), Step(name: "Two")], startsOn: day)
        store.add(list); await store.flush()
        expect(store.widgetSnapshot(now: now).frames.first!.items.first { $0.id == list.id.uuidString }?.action == nil, "Checklist has no complete-all shortcut")
        store.pause(triple, from: day, through: nil, now: now); await store.flush()
        store.logFromWidget(id: triple.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(triple), now: now); await store.flush()
        expect(store.dayProgress(of: triple, on: day) == 1, "Paused habit rejects a cached action")
        store.problem = nil
        store.archive([weekly]); await store.flush()
        store.logFromWidget(id: weekly.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(weekly), now: now); await store.flush()
        expect(store.dayProgress(of: weekly, on: day) == 2, "Archived habit rejects old action")
        store.problem = nil
        store.delete([list]); await store.flush()
        store.logFromWidget(id: list.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(list), now: now); await store.flush()
        expect(!store.habits.contains { $0.id == list.id }, "Deleted item cannot be revived by widget")
        store.problem = nil
        store.isPlus = true
        expect(store.widgetSnapshot(now: now).plus, "Verified entitlement input enables extra layouts")
        store.isPlus = false
        expect(!store.widgetSnapshot(now: now).plus, "Entitlement loss restores free fallback")
        let missing = HabitStore(repository: Persistence.inMemory().repository, databaseOpened: false)
        await missing.load()
        missing.logFromWidget(id: cut.id, day: day, event: UUID(), signature: HabitStore.widgetSignature(cut), now: now); await missing.flush()
        expect(missing.entries.isEmpty && !missing.isStorageReady, "Failed database open cannot log")
        do {
            try WidgetDisk.write(snapshot, to: file)
            let publisher = WidgetPublisher(file: file)
            await publisher.publish(missing)
            expect(WidgetDisk.read(from: file)?.generated == snapshot.generated, "Unread database preserves last good widget snapshot")
            let failed = WidgetPublisher(file: directory)
            await failed.publish(store)
            expect(failed.problem != nil, "Snapshot publication failure is visible and recoverable")
        } catch { failures.append("Publication failure fixture: \(error)") }
        let sharedPublisher = WidgetPublisher()
        await sharedPublisher.publish(store)
        expect(sharedPublisher.problem == nil && WidgetDisk.read()?.frames.first?.items.count == store.habits.filter { !$0.archived }.count,
               "Actual app App Group publishes a readable shared snapshot")
        // Privacy can change while preparation yields to the UI. Both publications must finish
        // without an older visible projection replacing the newer redacted projection.
        do {
            let racingStore = HabitStore(repository: Persistence.inMemory().repository)
            await racingStore.load(); await WidgetFixture.install(in: racingStore)
            let visiblePublisher = WidgetPublisher(file: file)
            let older = Task { await visiblePublisher.publish(racingStore) }
            await Task.yield()
            UserDefaults.standard.set(true, forKey: WidgetDisk.privacyKey)
            await WidgetPublisher(file: file).publish(racingStore)
            await older.value
            let privateSnapshot = WidgetDisk.read(from: file)
            expect(privateSnapshot?.hidden == true && privateSnapshot?.frames.allSatisfy { $0.items.isEmpty } == true,
                   "Privacy during asynchronous preparation never republishes names")
            UserDefaults.standard.removeObject(forKey: WidgetDisk.privacyKey)
            let preserved = privateSnapshot?.generated
            let cancelled = Task { await visiblePublisher.publish(racingStore) }
            cancelled.cancel(); await cancelled.value
            expect(WidgetDisk.read(from: file)?.generated == preserved, "Cancelled publication preserves the last durable snapshot")
        }
        // A real closed repository exercises the failed commit path, rather than a mock callback.
        let failingPersistence = Persistence.inMemory()
        let failingStore = HabitStore(repository: failingPersistence.repository)
        await failingStore.load(); await WidgetFixture.install(in: failingStore)
        let failedHabit = failingStore.habits.first { $0.name == "Widget water" }!
        do {
            let prior = failingStore.widgetSnapshot(now: now)
            try WidgetDisk.write(prior, to: file)
            try failingPersistence.repository.close()
            failingStore.logFromWidget(id: failedHabit.id, day: failingStore.today(now: now), event: UUID(),
                                       signature: HabitStore.widgetSignature(failedHabit), now: now)
            await failingStore.flush()
            expect(failingStore.problem != nil && failingStore.entries.isEmpty, "Failed database write never displays a successful widget check")
            await WidgetPublisher(file: file).publish(failingStore)
            expect(WidgetDisk.read(from: file)?.generated == prior.generated, "Failed commit preserves last durable snapshot")
        } catch { failures.append("Failed-write fixture: \(error)") }
        return failures
    }
}

/// Uses exactly the views shipped in the extension; this is a rendering test, not WidgetKit host validation.
struct WidgetRenderCheck: View {
    @State private var frame: WidgetFrame?
    @State private var selected: String?
    @State private var family = WidgetFamily.systemSmall
    @State private var layout = PhoneWidgetLayout.item
    @State private var plus = false
    @State private var dark = false
    @State private var month = false
    private let families: [WidgetFamily] = [.systemSmall, .systemMedium, .systemLarge, .accessoryInline, .accessoryCircular, .accessoryRectangular]
    var body: some View {
        VStack(spacing: 8) {
            ScrollView(.horizontal) {
                HStack { ForEach(families, id: \.rawValue) { value in
                    Button(String(describing: value)) { family = value }.accessibilityIdentifier("family-\(String(describing: value))")
                } }
            }
            HStack { ForEach(PhoneWidgetLayout.allCases, id: \.rawValue) { value in Button(value.rawValue) { layout = value } } }
            Toggle("Plus preview", isOn: $plus).accessibilityIdentifier("widget-plus")
            Toggle("Month preview", isOn: $month).accessibilityIdentifier("widget-month")
            Toggle("Dark preview", isOn: $dark).accessibilityIdentifier("widget-dark")
            if let frame {
                ScrollView(.horizontal) { HStack { ForEach(Array(frame.items.filter { !$0.isTask }.prefix(5))) { item in
                    Button(item.name) { selected = item.id }.accessibilityIdentifier("select-\(item.name)")
                } } }
                PhoneWidgetView(entry: .init(date: .now, frame: frame, plus: plus, selection: selected, month: month), layout: layout, familyOverride: family)
                    .frame(width: size.width, height: size.height)
                    .background(Color(.secondarySystemBackground))
                    .preferredColorScheme(dark ? .dark : .light)
                    .accessibilityIdentifier("widget-render")
            }
            Spacer()
        }.padding().task {
            await AppModel.shared.ensureLoaded()
            let snapshot = AppModel.shared.store.widgetSnapshot()
            frame = snapshot.frames.first; selected = frame?.items.first?.id
        }
    }
    private var size: CGSize {
        switch family {
        case .systemSmall: .init(width: 155, height: 155)
        case .systemMedium: .init(width: 329, height: 155)
        case .systemLarge: .init(width: 329, height: 345)
        case .accessoryInline: .init(width: 230, height: 26)
        case .accessoryCircular: .init(width: 62, height: 62)
        default: .init(width: 160, height: 62)
        }
    }
}
#endif
