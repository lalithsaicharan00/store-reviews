#if DEBUG
import Foundation
import UserNotifications

private enum ReminderTestError: Error { case scheduling }

final class FakeReminderNotifications: ReminderNotifications {
    var status: UNAuthorizationStatus = .authorized
    var requests: [String: UNNotificationRequest] = [:]
    var deliveredRequests: [UNNotificationRequest] = []
    var registered: Set<UNNotificationCategory> = []
    var permissionCalls = 0, additions = 0, failures = 0
    var dropAdds = false, suspendOnce = false
    var suspended: CheckedContinuation<Void, Never>?
    var inFlight = 0, maximumInFlight = 0
    func authorizationStatus() async -> UNAuthorizationStatus { status }
    func requestPermission() async -> Bool { permissionCalls += 1; status = .authorized; return true }
    func pending() async -> [UNNotificationRequest] { Array(requests.values) }
    func delivered() async -> [UNNotificationRequest] { deliveredRequests }
    func categories(_ categories: Set<UNNotificationCategory>) { registered = categories }
    func removePending(_ ids: [String]) { for id in ids { requests.removeValue(forKey: id) } }
    func removeDelivered(_ ids: [String]) { deliveredRequests.removeAll { ids.contains($0.identifier) } }
    func add(_ request: UNNotificationRequest) async throws {
        additions += 1; inFlight += 1; maximumInFlight = max(maximumInFlight, inFlight)
        defer { inFlight -= 1 }
        if suspendOnce { suspendOnce = false; await withCheckedContinuation { suspended = $0 } }
        if failures > 0 { failures -= 1; throw ReminderTestError.scheduling }
        if !dropAdds { requests[request.identifier] = request }
    }
}
final class FakeReminderAlarms: ReminderAlarms {
    var isAuthorized = false, isDenied = false, fail = false
    var problem: String?
    var budget = 30
    var latest: [ReminderScheduler.Alert] = []
    func requestPermission() async -> Bool { isAuthorized = !isDenied; return isAuthorized }
    func reconcile(_ alerts: [ReminderScheduler.Alert], keepRinging: Set<String>, store: HabitStore) async -> Set<String> {
        latest = alerts
        return fail ? [] : Set(alerts.prefix(budget).map(\.id))
    }
}

enum ReminderFixture {
    static func install(in store: HabitStore) async {
        guard store.habits.isEmpty else { return }
        let items = [
            Habit(name: "Water reminders", symbol: "drop", color: .blue, kind: .amount(unit: "L", increment: 0.25), goal: 2,
                  reminders: [ReminderTime(hour: 9, minute: 0)], remind: true),
            Habit(name: "Task reminder", symbol: "calendar", color: .green, kind: .task, dueDay: store.today().adding(days: 1),
                  reminders: [ReminderTime(hour: 10, minute: 30)], remind: true),
            Habit(name: "No reminder", symbol: "star", color: .orange, kind: .check, remind: false)
        ]
        for item in items { store.add(item) }
        await store.flush()
    }
}

enum ReminderCheck {
    static var planningSummary = ""
    static func run() async -> [String] {
        var failures: [String] = []
        func expect(_ value: Bool, _ name: String) { if !value { failures.append(name) } }
        var utc = Calendar(identifier: .gregorian); utc.timeZone = TimeZone(secondsFromGMT: 0)!
        let persistence = Persistence.inMemory()
        let store = HabitStore(repository: persistence.repository, calendar: utc)
        await store.load()
        let day = store.today(), now = ReminderClock.date(on: day, hour: 0, minute: 0, calendar: utc)!
        let notes = FakeReminderNotifications(), alarms = FakeReminderAlarms()
        let scheduler = ReminderScheduler(notifications: notes, alarms: alarms)
        var habit = Habit(name: "Check", symbol: "checkmark", color: .blue, kind: .check,
                          reminders: [ReminderTime(hour: 9, minute: 0)], remind: true, startsOn: day.adding(days: -10))
        store.add(habit); await store.flush()
        expect(scheduler.plan(store, now: now).count == 30, "30 calendar days are planned without a background refresh")
        expect(Set(scheduler.plan(store, now: now).map(\.id)).count == 30, "identifiers are unique and stable")
        expect(scheduler.plan(store, now: now).map(\.id) == scheduler.plan(store, now: now).map(\.id), "planning is deterministic")
        await scheduler.reconcile(store, now: now)
        expect(notes.requests.count == 30, "notification schedule installed")
        expect(notes.permissionCalls == 0, "reconciliation never prompts for permission")
        let originalAdds = notes.additions
        await scheduler.reconcile(store, now: now)
        expect(notes.additions == originalAdds, "unchanged schedules do no system writes")
        expect(notes.registered.contains { $0.identifier == "habit.single" && $0.actions.first?.identifier == ReminderScheduler.doneAction }, "Done category registered")

        habit.followUpMinutes = 15; store.update(habit); await store.flush()
        var plan = scheduler.plan(store, now: now)
        expect(plan.filter { $0.followUp > 0 }.count == 6, "three follow-ups on today and tomorrow only")
        expect(plan.filter { $0.day == day && $0.followUp > 0 }.map { utc.component(.minute, from: $0.fire) } == [15, 30, 45], "follow-up clock offsets")
        habit.reminders.append(ReminderTime(hour: 9, minute: 20)); store.update(habit); await store.flush()
        plan = scheduler.plan(store, now: now)
        expect(plan.filter { $0.day == day && $0.time.hour == 9 && $0.time.minute == 0 && $0.followUp > 0 }.count == 1, "follow-ups stop at the next reminder")
        habit.reminders = [ReminderTime(hour: 23, minute: 50)]; store.update(habit); await store.flush()
        expect(scheduler.plan(store, now: now).allSatisfy { $0.followUp == 0 }, "follow-ups stop at logical day end")
        habit.reminders = [ReminderTime(hour: 9, minute: 0), ReminderTime(hour: 9, minute: 0)]
        habit.followUpMinutes = nil; store.update(habit); await store.flush()
        expect(scheduler.plan(store, now: now).count == 30, "duplicate minutes do not double alerts")
        habit.reminders = [habit.reminders[0]]; store.update(habit); await store.flush()
        store.toggleCheck(habit, on: day); await store.flush()
        expect(!scheduler.plan(store, now: now).contains { $0.day == day }, "done today's reminders suppressed, tomorrow preserved")
        store.toggleCheck(habit, on: day); await store.flush()
        store.setSkipped(habit, on: day, true); await store.flush()
        expect(!scheduler.plan(store, now: now).contains { $0.day == day }, "skipped day suppressed")
        store.setSkipped(habit, on: day, false); store.pause(habit, from: day, through: day.adding(days: 2)); await store.flush()
        expect(scheduler.plan(store, now: now).allSatisfy { $0.day > day.adding(days: 2) }, "paused interval suppressed")
        store.resume(habit); await store.flush()
        store.archive([habit]); await store.flush()
        expect(scheduler.plan(store, now: now).isEmpty, "archived items suppressed")
        store.restore(store.habits.first!); await store.flush()
        habit.archived = false; habit.remind = false; store.update(habit); await store.flush()
        expect(scheduler.plan(store, now: now).isEmpty, "reminder switch off")
        habit.remind = true; habit.startsOn = day.adding(days: 2); habit.endsOn = day.adding(days: 4)
        store.update(habit); await store.flush()
        expect(scheduler.plan(store, now: now).map(\.day) == [2,3,4].map { day.adding(days: $0) }, "inclusive start/end dates")
        habit.startsOn = day.adding(days: -10); habit.endsOn = nil
        habit.frequency = .weekdays([utc.component(.weekday, from: day.date(calendar: utc))]); store.update(habit); await store.flush()
        expect(scheduler.plan(store, now: now).allSatisfy { utc.component(.weekday, from: $0.fire) == utc.component(.weekday, from: day.date(calendar: utc)) }, "selected weekdays only")
        habit.frequency = .daily; store.update(habit); await store.flush()

        // Same-minute grouping, limits and independent amount actions.
        var amount = Habit(name: "Water", symbol: "drop", color: .blue, kind: .amount(unit: "L", increment: 0.25), goal: 2,
                           reminders: [ReminderTime(hour: 9, minute: 0)], remind: true, startsOn: day.adding(days: -2))
        store.add(amount); await store.flush()
        var requests = scheduler.requests(for: scheduler.plan(store, now: now), store: store)
        expect(requests.count == 30 && requests.allSatisfy { $0.identifier.contains("group") }, "same-minute habits use one notification per day")
        expect(requests.allSatisfy { $0.content.categoryIdentifier == "habit.group" }, "grouped alerts have no ambiguous Done action")
        amount.reminders = [ReminderTime(hour: 10, minute: 0)]; amount.followUpMinutes = 15
        store.update(amount); await store.flush(); await scheduler.reconcile(store, now: now)
        expect(notes.requests.count == 60, "nearest reminders stay inside 60 slots")
        let category = notes.registered.first { $0.identifier == "habit.add." + amount.id.uuidString }
        expect(category?.actions.first?.title.contains("0.25") == true, "amount action names its saved increment")
        amount.atMost = true; store.update(amount); await store.flush()
        expect(scheduler.plan(store, now: now).filter { $0.habit.id == amount.id }.allSatisfy { $0.followUp == 0 }, "limits never nag")
        store.addProgress(amount, value: 2, on: day); await store.flush()
        expect(scheduler.plan(store, now: now).contains { $0.habit.id == amount.id && $0.day == day }, "limit reminders remain after consumption")
        amount.atMost = false; amount.followUpMinutes = nil; store.update(amount); await store.flush()
        expect(!scheduler.plan(store, now: now).contains { $0.habit.id == amount.id && $0.day == day }, "met amount goal suppresses today's reminder")
        amount.frequency = .perWeek(1); amount.goal = 1; store.update(amount); await store.flush()
        expect(!scheduler.plan(store, now: now).contains { $0.habit.id == amount.id && $0.day == day }, "met weekly goal suppresses reminder")
        amount.frequency = .flexible(.week, 1); amount.goal = 1; store.update(amount); await store.flush()
        expect(!scheduler.plan(store, now: now).contains { $0.habit.id == amount.id && $0.day == day }, "met flexible quota suppresses reminder")

        // Future, overdue and after-completion tasks, quit habits, duration and checklist categories.
        var task = Habit(name: "Task", symbol: "calendar", color: .green, kind: .task, dueDay: day.adding(days: 5),
                         reminders: [ReminderTime(hour: 11, minute: 0)], remind: true)
        store.add(task); await store.flush()
        expect(scheduler.plan(store, now: now).filter { $0.habit.id == task.id }.map(\.day) == [day.adding(days: 5)], "one-time future task only on its date")
        task.dueDay = day.adding(days: -2); store.update(task); await store.flush()
        expect(scheduler.plan(store, now: now).filter { $0.habit.id == task.id }.map(\.day) == [day], "overdue task rolls to the actual planning day")
        store.toggleCheck(task, on: day); await store.flush()
        expect(!scheduler.plan(store, now: now).contains { $0.habit.id == task.id }, "completed one-time task has no future alerts")
        task.dueDay = nil; task.frequency = .afterCompletion(3, .day); task.startsOn = day.adding(days: -10)
        store.update(task); await store.flush()
        expect(scheduler.plan(store, now: now).filter { $0.habit.id == task.id }.allSatisfy { $0.day >= day.adding(days: 3) }, "task next due shifts from actual completion")
        for kind in [HabitKind.quit, .duration, .checklist] {
            let item = Habit(name: "Kind", symbol: "star", color: .blue, kind: kind, reminders: [ReminderTime(hour: 12, minute: 0)], remind: true)
            store.add(item); await store.flush()
            let itemPlan = scheduler.plan(store, now: now).filter { $0.habit.id == item.id }
            if kind == .quit { expect(itemPlan.isEmpty, "quit habits do not alert") }
            else { expect(scheduler.requests(for: itemPlan, store: store).allSatisfy { $0.content.categoryIdentifier.isEmpty }, "duration/checklist open the app instead of a fake Done") }
        }

        // Permission recovery, unrelated pending notifications, errors and alarm routing.
        let foreign = UNNotificationRequest(identifier: "timer.keep", content: UNMutableNotificationContent(), trigger: nil)
        notes.requests[foreign.identifier] = foreign
        notes.status = .denied; await scheduler.reconcile(store, now: now)
        expect(notes.requests.keys.allSatisfy { !$0.hasPrefix("reminder.") } && notes.requests[foreign.identifier] != nil, "denial clears own alerts and preserves timer alerts")
        expect(!(await scheduler.requestPermission()) && notes.permissionCalls == 0, "denial does not repeatedly ask permission")
        notes.status = .notDetermined; expect(await scheduler.requestPermission(), "permission can be requested from explicit action")
        expect(notes.permissionCalls == 1, "one explicit authorization request")
        for status in [UNAuthorizationStatus.authorized, .provisional, .ephemeral] {
            notes.status = status; await scheduler.reconcile(store, now: now)
            expect(notes.requests.keys.contains { $0.hasPrefix("reminder.") }, "permission schedules: \(status.rawValue)")
        }
        notes.failures = 1; notes.requests = [foreign.identifier: foreign]; await scheduler.reconcile(store, now: now)
        expect(scheduler.problem == nil && notes.requests.count > 1, "transient add error is retried")
        notes.failures = 1000; notes.requests = [foreign.identifier: foreign]; await scheduler.reconcile(store, now: now)
        expect(scheduler.problem != nil && notes.requests.count == 1, "persistent scheduling failure is visible")
        notes.failures = 0; notes.dropAdds = true; await scheduler.reconcile(store, now: now)
        expect(scheduler.problem != nil, "success callback without a kept request is detected")
        notes.dropAdds = false
        for i in 0..<10 { notes.requests["foreign.\(i)"] = UNNotificationRequest(identifier: "foreign.\(i)", content: UNMutableNotificationContent(), trigger: nil) }
        await scheduler.reconcile(store, now: now)
        expect(notes.requests.count <= 64, "pending budget includes unrelated app alerts")
        var alarmHabit = habit; alarmHabit.alert = .alarm; store.update(alarmHabit); await store.flush()
        alarms.isAuthorized = true; await scheduler.reconcile(store, now: now)
        expect(!alarms.latest.isEmpty && !notes.requests.values.contains { ($0.content.userInfo["habit"] as? String) == habit.id.uuidString }, "authorized alarms avoid duplicate notifications")
        alarms.fail = true; await scheduler.reconcile(store, now: now)
        expect(notes.requests.values.contains { ($0.content.userInfo["habit"] as? String) == habit.id.uuidString } || notes.requests.keys.contains { $0.contains("group") }, "failed alarms fall back to notifications")
        alarms.fail = false; alarms.budget = 1; await scheduler.reconcile(store, now: now)
        expect(scheduler.problem != nil, "alarm capacity fallback is disclosed")

        if #available(iOS 26, *) {
            expect(AlarmScheduler.actionLabel(amount)?.contains("0.25") == true, "alarm amount action names increment")
            expect(AlarmScheduler.actionLabel(Habit(name: "Timer", symbol: "timer", color: .blue, kind: .duration)) == nil, "alarm timer has Stop without a misleading Done")
            expect(AlarmScheduler.actionLabel(Habit(name: "Steps", symbol: "list.bullet", color: .blue, kind: .checklist)) == nil, "alarm checklist has no misleading Done")
        }
        if let alert = scheduler.plan(store, now: now).first(where: { $0.habit.id == alarmHabit.id }) {
            let record = AlarmReminderRecord(alert)
            expect(record.isCurrent(in: store, now: now), "saved ringing alarm belongs to current configuration")
            let data = try? JSONEncoder().encode(record)
            let decoded = data.flatMap { try? JSONDecoder().decode(AlarmReminderRecord.self, from: $0) }
            expect(decoded?.matches(alert) == true, "alarm ownership survives a cold-launch serialization")
            alarmHabit.remind = false; store.update(alarmHabit); await store.flush()
            expect(!record.isCurrent(in: store, now: now), "turning reminders off stops a ringing alarm")
        }

        failures += await actionChecks(calendar: utc)
        failures += await raceChecks(calendar: utc)
        failures += await performanceChecks()
        failures += await calendarChecks()
        failures += await clockChecks()
        return failures
    }

    private static func actionChecks(calendar: Calendar) async -> [String] {
        var failures: [String] = []
        func expect(_ value: Bool, _ name: String) { if !value { failures.append(name) } }
        let persistence = Persistence.inMemory(), notes = FakeReminderNotifications()
        let store = HabitStore(repository: persistence.repository, calendar: calendar); await store.load()
        let day = store.today(), now = ReminderClock.date(on: day, hour: 12, minute: 0, calendar: calendar)!
        var water = Habit(name: "Water", symbol: "drop", color: .blue, kind: .amount(unit: "L", increment: 0.25), goal: 10,
                          reminders: [ReminderTime(hour: 9, minute: 0), ReminderTime(hour: 22, minute: 0)], remind: true,
                          startsOn: day.adding(days: -5))
        store.add(water); await store.flush()
        let signature = ReminderIdentity.signature(water)
        let first = ReminderIdentity.actionID("event.water.base"), next = ReminderIdentity.actionID("event.water.followup")
        func log(_ id: UUID, day targetDay: LocalDay? = nil, time: UUID? = nil, signature supplied: String? = nil) {
            store.logFromReminder(water, slot: nil, on: targetDay ?? day, time: time ?? water.reminders[0].id,
                                  signature: supplied ?? signature, eventID: id, now: now)
        }
        log(first); log(first); await store.flush()
        expect(store.progress(of: water, on: day) == 0.25, "duplicate amount response saved once")
        log(next); await store.flush()
        expect(store.progress(of: water, on: day) == 0.5, "separate follow-up action adds its own increment")
        store.undoEntry(first); await store.flush(); log(first); await store.flush()
        expect(store.progress(of: water, on: day) == 0.25, "replayed undone action stays undone in memory")
        let reopened = HabitStore(repository: persistence.repository, calendar: calendar); await reopened.load()
        guard let reloaded = reopened.habits.first else { return failures + ["action fixture failed to save"] }
        expect(ReminderIdentity.signature(reloaded) == signature, "signature survives millisecond date and reminder-order round trip")
        reopened.logFromReminder(reloaded, slot: nil, on: day, time: reloaded.reminders[0].id, signature: signature, eventID: first, now: now)
        await reopened.flush()
        expect(reopened.progress(of: reloaded, on: day) == 0.25, "replayed undone action stays undone after relaunch")
        log(ReminderIdentity.actionID("future"), day: day.adding(days: 1)); log(ReminderIdentity.actionID("old"), day: day.adding(days: -2))
        log(ReminderIdentity.actionID("removed time"), time: UUID()); await store.flush()
        expect(store.entries.count == 1, "future, old and removed-time actions are ignored")
        store.pause(water, from: day, through: nil); await store.flush(); log(ReminderIdentity.actionID("paused")); await store.flush()
        expect(store.entries.count == 1, "paused action is ignored")
        store.resume(water); store.archive([water]); await store.flush(); log(ReminderIdentity.actionID("archived")); await store.flush()
        expect(store.entries.count == 1, "archived action is ignored")
        store.restore(store.habits.first!); await store.flush()
        water.reminders[0].hour = 10; store.update(water); await store.flush(); log(ReminderIdentity.actionID("old configuration")); await store.flush()
        expect(store.entries.count == 1, "old configuration action cannot log after editing")
        water.remind = false; store.update(water); await store.flush(); log(ReminderIdentity.actionID("off"), signature: ReminderIdentity.signature(water)); await store.flush()
        expect(store.entries.count == 1, "turned-off reminder action is ignored")
        store.delete([water]); await store.flush(); log(ReminderIdentity.actionID("deleted")); await store.flush()
        expect(store.habits.isEmpty && store.entries.isEmpty, "deleted action cannot revive a habit")
        expect(LocalDay(key: "2024-02-29") != nil && LocalDay(key: "2025-02-29") == nil, "leap day keys validated")
        for key in ["2026-00-01", "2026-13-01", "2026-02-31", "2026-x-9-30", "-2026-09-30", "999999-01-01"] {
            expect(LocalDay(key: key) == nil, "malformed action day rejected: \(key)")
        }
        let task = Habit(name: "Done once", symbol: "checkmark", color: .blue, kind: .task, dueDay: day,
                         reminders: [ReminderTime(hour: 9, minute: 0)], remind: true)
        store.add(task); await store.flush()
        for _ in 0..<2 { store.logFromReminder(task, slot: nil, on: day, time: task.reminders[0].id, eventID: UUID(), now: now) }
        await store.flush()
        expect(store.entries.count == 1 && store.isDone(task, on: day), "Done retries never untick or duplicate a task")
        let scheduler = ReminderScheduler(notifications: notes, alarms: FakeReminderAlarms())
        let content = UNMutableNotificationContent()
        content.userInfo = ReminderTarget(habit: task.id, time: task.reminders[0].id, day: day, slot: nil, section: nil).userInfo
        notes.deliveredRequests = [UNNotificationRequest(identifier: "reminder.delivered", content: content, trigger: nil)]
        await scheduler.reconcile(store, now: now)
        expect(notes.deliveredRequests.isEmpty, "completed delivered alert is cleared")
        return failures
    }

    private static func raceChecks(calendar: Calendar) async -> [String] {
        let persistence = Persistence.inMemory()
        let store = HabitStore(repository: persistence.repository, calendar: calendar); await store.load()
        let day = store.today(), now = ReminderClock.date(on: day, hour: 0, minute: 0, calendar: calendar)!
        var habit = Habit(name: "Race", symbol: "star", color: .blue, kind: .check,
                          reminders: [ReminderTime(hour: 9, minute: 0)], remind: true)
        store.add(habit); await store.flush()
        let notes = FakeReminderNotifications(), scheduler = ReminderScheduler(notifications: notes, alarms: FakeReminderAlarms())
        notes.suspendOnce = true
        let oldPass = Task { await scheduler.reconcile(store, now: now) }
        for _ in 0..<5000 { if notes.suspended != nil { break }; await Task.yield() }
        guard let waiting = notes.suspended else { return ["race test never reached its controlled scheduling suspension"] }
        habit.reminders[0].hour = 10; store.update(habit); await store.flush()
        let newPass = Task { await scheduler.reconcile(store, now: now) }
        waiting.resume(); notes.suspended = nil
        await oldPass.value; await newPass.value
        var failures: [String] = []
        if notes.maximumInFlight != 1 { failures.append("system reconciliation writes overlapped") }
        if !notes.requests.values.allSatisfy({ ($0.trigger as? UNCalendarNotificationTrigger)?.dateComponents.hour == 10 }) {
            failures.append("an older pass put the edited time back")
        }
        // Failed replacements remove the outdated request rather than leaving a wrong time behind.
        habit.reminders[0].hour = 11; store.update(habit); await store.flush()
        notes.failures = 1000; await scheduler.reconcile(store, now: now)
        if !notes.requests.isEmpty || scheduler.problem == nil { failures.append("failed replacement kept stale pending times") }
        notes.failures = 0; await scheduler.reconcile(store, now: now)
        store.delete([habit]); await store.flush(); await scheduler.reconcile(store, now: now)
        if !notes.requests.isEmpty { failures.append("delete left pending notifications") }
        // A database failure is not permission to clear a saved schedule.
        notes.requests["reminder.keep"] = UNNotificationRequest(identifier: "reminder.keep", content: UNMutableNotificationContent(), trigger: nil)
        store.problem = "Cannot read"; await scheduler.reconcile(store, now: now)
        if notes.requests["reminder.keep"] == nil { failures.append("unavailable database cleared pending alerts") }
        try? persistence.repository.close()
        await store.load()
        if store.isStorageReady || store.problem == nil { failures.append("closed database was treated as readable") }
        store.problem = nil // acknowledging the message must not make the failed read trustworthy
        await scheduler.reconcile(store, now: now)
        if notes.requests["reminder.keep"] == nil { failures.append("acknowledging a storage error cleared saved alerts") }
        let fallback = HabitStore(repository: Persistence.inMemory().repository, databaseOpened: false)
        await fallback.load(); await scheduler.reconcile(fallback, now: now)
        if fallback.isStorageReady || notes.requests["reminder.keep"] == nil { failures.append("failed-open fallback replaced the saved schedule with an empty one") }
        return failures
    }

    private static func performanceChecks() async -> [String] {
        let store = HabitStore(repository: Persistence.inMemory().repository); await store.load(); await store.seedDemo()
        guard store.habits.filter({ $0.remind }).count >= 100, store.entries.count > 30_000 else {
            return ["performance fixture must contain 100 reminder rules and a year of history"]
        }
        let scheduler = ReminderScheduler(notifications: FakeReminderNotifications(), alarms: FakeReminderAlarms())
        let now = ReminderClock.date(on: store.today(), hour: 0, minute: 0, calendar: store.calendar)!
        var durations: [Double] = []
        var alerts: [ReminderScheduler.Alert] = []
        for _ in 0..<3 {
            let start = Date.now
            alerts = scheduler.plan(store, now: now)
            durations.append(Date.now.timeIntervalSince(start))
        }
        let median = durations.sorted()[1]
        planningSummary = String(format: "100 rules / %d entries: plan median %.1f ms, cold %.1f ms", store.entries.count, median * 1000, durations[0] * 1000)
        var failures: [String] = []
        if alerts.count < 3000 { failures.append("large fixture lost future reminder days") }
        if scheduler.requests(for: alerts, store: store).count != 60 { failures.append("large fixture exceeds pending budget or omits nearest alerts") }
        if median > 1 { failures.append("planning 100 rules blocks the main actor for over one second: " + planningSummary) }
        return failures
    }

    private static func calendarChecks() async -> [String] {
        var failures: [String] = []
        func expect(_ value: Bool, _ name: String) { if !value { failures.append(name) } }
        var utc = Calendar(identifier: .gregorian); utc.timeZone = TimeZone(secondsFromGMT: 0)!
        let store = HabitStore(repository: Persistence.inMemory().repository, calendar: utc); await store.load()
        let start = LocalDay(year: 2024, month: 1, day: 1), day = LocalDay(year: 2024, month: 2, day: 1)
        let now = ReminderClock.date(on: day, hour: 0, minute: 0, calendar: utc)!
        var month = CalendarSchedule(); month.unit = .month; month.interval = 1; month.dates = [31]; month.useLastDay = true
        var year = CalendarSchedule(); year.unit = .year; year.interval = 1; year.month = 2; year.day = 29
        var week = CalendarSchedule(); week.unit = .week; week.interval = 2; week.weekdays = [2,5]; week.anchorWeekStart = 2
        let cases: [(String, Frequency)] = [("Day interval", .everyNDays(3)), ("Week interval", .everyNWeeks(2)),
            ("Month dates", .monthDates([31])), ("Calendar month", .calendar(month)), ("Leap year", .calendar(year)),
            ("Calendar week", .calendar(week)), ("Monthly goal", .perMonth(2)), ("Yearly goal", .perYear(3))]
        for (name, frequency) in cases {
            let habit = Habit(name: name, symbol: "calendar", color: .blue, kind: .check, frequency: frequency,
                              reminders: [ReminderTime(hour: 9, minute: 0)], remind: true, startsOn: start, createdAt: start.date(calendar: utc))
            store.add(habit)
        }
        await store.flush()
        let scheduler = ReminderScheduler(notifications: FakeReminderNotifications(), alarms: FakeReminderAlarms())
        let plan = scheduler.plan(store, now: now)
        for name in ["Month dates", "Calendar month", "Leap year"] {
            expect(plan.filter { $0.habit.name == name }.map(\.day) == [LocalDay(year: 2024, month: 2, day: 29)], "leap month reminder: " + name)
        }
        for (name, interval) in [("Day interval", 3), ("Week interval", 14)] {
            let dates = plan.filter { $0.habit.name == name }.map(\.day)
            expect(!dates.isEmpty && dates.allSatisfy { (utc.dateComponents([.day], from: start.date(calendar: utc), to: $0.date(calendar: utc)).day ?? -1) % interval == 0 }, "anchored reminder: " + name)
        }
        let weekly = plan.filter { $0.habit.name == "Calendar week" }
        expect(!weekly.isEmpty && weekly.allSatisfy { [2,5].contains(utc.component(.weekday, from: $0.fire)) }, "alternate-week reminders honor selected weekdays")
        for name in ["Monthly goal", "Yearly goal"] {
            expect(plan.filter { $0.habit.name == name }.count == 30, "unmet period goal remains eligible: " + name)
        }
        return failures
    }

    private static func clockChecks() async -> [String] {
        var failures: [String] = []
        func expect(_ value: Bool, _ name: String) { if !value { failures.append(name) } }
        var pacific = Calendar(identifier: .gregorian); pacific.timeZone = TimeZone(identifier: "America/Los_Angeles")!
        let store = HabitStore(repository: Persistence.inMemory().repository, calendar: pacific); await store.load()
        let scheduler = ReminderScheduler(notifications: FakeReminderNotifications(), alarms: FakeReminderAlarms())
        let spring = LocalDay(year: 2024, month: 3, day: 10), fall = LocalDay(year: 2024, month: 11, day: 3)
        let missing = ReminderClock.date(on: spring, hour: 2, minute: 30, calendar: pacific)!
        expect(pacific.component(.hour, from: missing) == 3 && pacific.component(.minute, from: missing) == 0,
               "spring missing time uses the next valid wall-clock time")
        let repeated = ReminderClock.date(on: fall, hour: 1, minute: 30, calendar: pacific)!
        expect(pacific.timeZone.secondsFromGMT(for: repeated) == -7 * 3600, "fall repeated time alerts once at its first occurrence")
        store.settings.dayEndHour = 3
        expect(store.today(now: ReminderClock.date(on: spring, hour: 3, minute: 15, calendar: pacific)!) == spring,
               "spring day end follows wall clock instead of elapsed hours")
        expect(store.today(now: ReminderClock.date(on: fall, hour: 2, minute: 30, calendar: pacific)!) == fall.adding(days: -1, calendar: pacific),
               "fall clock before day end belongs to yesterday")
        let overnight = scheduler.fireDate(ReminderTime(hour: 2, minute: 30), on: spring.adding(days: -1, calendar: pacific), store: store)!
        expect(LocalDay(overnight, calendar: pacific) == spring && pacific.component(.hour, from: overnight) == 3,
               "overnight reminder resolves DST on the actual next day")
        var india = pacific; india.timeZone = TimeZone(identifier: "Asia/Kolkata")!
        let local = LocalDay(year: 2024, month: 6, day: 1)
        let la = ReminderClock.date(on: local, hour: 9, minute: 0, calendar: pacific)!
        let inTime = ReminderClock.date(on: local, hour: 9, minute: 0, calendar: india)!
        expect(pacific.component(.hour, from: la) == 9 && india.component(.hour, from: inTime) == 9 && la != inTime,
               "travel keeps the chosen local clock time")
        expect(scheduler.fireDate(ReminderTime(hour: 24, minute: 0), on: local, store: store) == nil, "invalid legacy reminder clock is skipped")
        return failures
    }
}
#endif
