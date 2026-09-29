import Foundation
import Observation
import UserNotifications

/// Keeps the system's pending notifications (and, on iOS 26, alarms) exactly in step with the habits.
///
/// Reminders are not written once and forgotten: every change re-plans the next few days and
/// reconciles against what is pending. So a reminder never fires for a row that is done, a habit
/// that is deleted or not due, and a changed time always takes (Feature Ledger C039). Rules:
/// "Times, Day Sections and Reminders" §3.4 and iOS/Docs/Specs/Pending to Implement.md §6.
@MainActor @Observable
final class ReminderScheduler {
    @ObservationIgnored private let center = UNUserNotificationCenter.current()
    private static let prefix = "reminder."
    /// iOS keeps at most 64 pending notifications per app; stay under it.
    private static let limit = 60
    private static let horizonDays = 7
    /// Remind Again repeats at most this many times after the time itself.
    static let maxFollowUps = 3
    @ObservationIgnored private var pendingWork: Task<Void, Never>?

    nonisolated static let doneAction = "habit.done"
    nonisolated static let addAction = "habit.add"
    private static let singleCategory = "habit.single"
    private static let groupCategory = "habit.group"
    private static let addCategoryPrefix = "habit.add."

    /// One planned alert: a time of one row on one day, or one of its repeats.
    struct Alert {
        let id: String
        let fire: Date
        let habit: Habit
        let day: LocalDay
        let placement: HabitStore.Placement
        let time: ReminderTime
        /// 0 for the time itself; 1…3 for Remind Again.
        let followUp: Int
        /// The section the time falls in (for a spread habit in Anytime, its own part of the day).
        let section: DaySection

        var target: ReminderTarget {
            ReminderTarget(habit: habit.id, time: time.id, day: day, slot: placement.slot, section: placement.section)
        }
    }

    // MARK: Permission

    /// Asks once, at the moment the user adds their first time with Remind Me on (Architecture 09 §4).
    func requestPermission() async -> Bool {
        let settings = await center.notificationSettings()
        switch settings.authorizationStatus {
        case .authorized, .provisional, .ephemeral: return true
        case .notDetermined: return (try? await center.requestAuthorization(options: [.alert, .sound, .badge])) ?? false
        default: return false
        }
    }

    func isDenied() async -> Bool {
        await center.notificationSettings().authorizationStatus == .denied
    }

    /// Whether Alarm can be offered: AlarmKit exists from iOS 26.
    static var alarmsAvailable: Bool {
        if #available(iOS 26, *) { true } else { false }
    }

    /// Asks for alarm permission when Alarm is first chosen. False below iOS 26 or when denied.
    func requestAlarmPermission() async -> Bool {
        if #available(iOS 26, *) { return await AlarmScheduler.shared.requestAuthorization() }
        return false
    }

    func alarmsDenied() -> Bool {
        if #available(iOS 26, *) { return AlarmScheduler.shared.isDenied }
        return false
    }

    // MARK: Reconcile

    /// Coalesces bursts of changes into one reconcile.
    func scheduleReconcile(_ store: HabitStore) {
        pendingWork?.cancel()
        pendingWork = Task {
            try? await Task.sleep(for: .milliseconds(300))
            guard !Task.isCancelled else { return }
            await reconcile(store)
        }
    }

    func reconcile(_ store: HabitStore, now: Date = .now) async {
        let planned = plan(store, now: now)
        // Alarms go to AlarmKit when it's there and allowed; otherwise they fall back to notifications.
        var notes = planned
        if #available(iOS 26, *) {
            let alarms = AlarmScheduler.shared
            let ring = alarms.isAuthorized ? planned.filter { $0.habit.alert == .alarm } : []
            notes = alarms.isAuthorized ? planned.filter { $0.habit.alert != .alarm } : planned
            await alarms.reconcile(ring, keepRinging: doneTimeIDs(store, now: now), store: store)
        }

        guard await center.notificationSettings().authorizationStatus == .authorized else { return }
        center.setNotificationCategories(Self.categories(for: store.habits))
        let wanted = requests(for: notes, store: store)
        let pending = await center.pendingNotificationRequests().filter { $0.identifier.hasPrefix(Self.prefix) }
        let wantedIDs = Set(wanted.map(\.identifier))
        center.removePendingNotificationRequests(withIdentifiers: pending.map(\.identifier).filter { !wantedIDs.contains($0) })
        let current = Dictionary(pending.map { ($0.identifier, $0) }, uniquingKeysWith: { a, _ in a })
        // Adding with an existing identifier replaces it, so a grouped notification whose list changed is updated.
        for request in wanted where current[request.identifier].map({ !Self.same($0, request) }) ?? true {
            try? await center.add(request)
        }
        await clearDelivered(store, now: now)
    }

    /// Every alert wanted over the next few days, nearest first.
    func plan(_ store: HabitStore, now: Date) -> [Alert] {
        let calendar = store.calendar
        let today = store.today(now: now)
        var alerts: [Alert] = []
        for habit in store.habits where !habit.archived && habit.kind != .quit && habit.remind && !habit.reminders.isEmpty {
            let placements = store.placements(of: habit)
            for offset in 0..<Self.horizonDays {
                let day = today.adding(days: offset, calendar: calendar)
                guard store.isDue(habit, on: day) else { continue }
                for placement in placements {
                    // A limit is never "not done", so it always reminds. Anything else stops once its row is done;
                    // for week and month rules, once the period's goal is met.
                    if !habit.atMost {
                        let done = placement.slot.map { store.isSlotDone(habit, slot: $0, on: day) } ?? store.isSatisfied(habit, on: day)
                        if done { continue }
                    }
                    for (i, time) in placement.times.enumerated() {
                        let fire = fireDate(time, on: day, store: store)
                        let section = store.section(forMinute: time.minuteOfDay)
                        let base = "\(Self.prefix)\(habit.id.uuidString).\(time.id.uuidString).\(day.year)-\(day.month)-\(day.day)"
                        if fire > now {
                            alerts.append(Alert(id: base, fire: fire, habit: habit, day: day, placement: placement, time: time, followUp: 0, section: section))
                        }
                        // Remind Again: today and tomorrow only, to protect the pending budget; the reconcile
                        // and the background refresh roll the window forward. Repeats stop at the row's next
                        // time (it reminds anyway) and at the end of the day.
                        guard let every = habit.followUpMinutes, every > 0, !habit.atMost, offset <= 1 else { continue }
                        let stop = i + 1 < placement.times.count ? fireDate(placement.times[i + 1], on: day, store: store) : dayEnd(day, store: store)
                        for k in 1...Self.maxFollowUps {
                            let repeatAt = fire.addingTimeInterval(Double(k * every * 60))
                            guard repeatAt < stop else { break }
                            if repeatAt > now {
                                alerts.append(Alert(id: base + ".f\(k)", fire: repeatAt, habit: habit, day: day, placement: placement,
                                                    time: time, followUp: k, section: section))
                            }
                        }
                    }
                }
            }
        }
        return alerts.sorted { $0.fire < $1.fire }
    }

    private func fireDate(_ time: ReminderTime, on day: LocalDay, store: HabitStore) -> Date {
        let calendar = store.calendar
        let fire = calendar.date(bySettingHour: time.hour, minute: time.minute, second: 0, of: day.date(calendar: calendar))!
        // Times before the day's end belong to the night after this day.
        return time.minuteOfDay < store.settings.dayEndHour * 60 ? calendar.date(byAdding: .day, value: 1, to: fire)! : fire
    }

    private func dayEnd(_ day: LocalDay, store: HabitStore) -> Date {
        let calendar = store.calendar
        let next = day.adding(days: 1, calendar: calendar).date(calendar: calendar)
        return calendar.date(bySettingHour: store.settings.dayEndHour, minute: 0, second: 0, of: next)!
    }

    // MARK: Notifications

    /// Same-minute alerts share one notification ("Morning · Meds, Stretch +2"); one on its own keeps
    /// its own, with Done or +1. Repeats are never grouped, so each stops on its own tick.
    private func requests(for alerts: [Alert], store: HabitStore) -> [UNNotificationRequest] {
        var singles: [Alert] = alerts.filter { $0.followUp > 0 }
        var groups: [[Alert]] = []
        for (_, bucket) in Dictionary(grouping: alerts.filter { $0.followUp == 0 }, by: \.fire) {
            if bucket.count == 1 { singles.append(bucket[0]) } else { groups.append(bucket) }
        }
        var requests: [(Date, UNNotificationRequest)] = singles.map { ($0.fire, single($0, store: store)) }
        requests += groups.map { ($0[0].fire, group($0, store: store)) }
        return requests.sorted { $0.0 < $1.0 }.prefix(Self.limit).map(\.1)
    }

    private func single(_ alert: Alert, store: HabitStore) -> UNNotificationRequest {
        let habit = alert.habit
        let content = UNMutableNotificationContent()
        content.title = habit.name
        var body = reminderBody(habit, store: store)
        // A habit ticked per section says which tick this is.
        if alert.placement.slot != nil { body = "\(store.section(alert.placement.section).name) · \(body)" }
        if alert.followUp > 0 { body = "Not done yet · \(body)" }
        content.body = body
        content.sound = .default
        content.threadIdentifier = alert.section.id
        content.categoryIdentifier = Self.category(for: habit)
        content.userInfo = alert.target.userInfo
        return UNNotificationRequest(identifier: alert.id, content: content, trigger: trigger(alert.fire, store: store))
    }

    private func group(_ bucket: [Alert], store: HabitStore) -> UNNotificationRequest {
        let first = bucket[0]
        let names = bucket.map(\.habit.name)
        let content = UNMutableNotificationContent()
        content.title = first.section.name
        content.body = names.prefix(3).joined(separator: ", ") + (names.count > 3 ? " +\(names.count - 3)" : "")
        content.sound = .default
        content.threadIdentifier = first.section.id
        content.categoryIdentifier = Self.groupCategory
        content.userInfo = ["section": first.section.id, "day": first.day.key,
                            "habits": bucket.map(\.habit.id.uuidString).joined(separator: ",")]
        let hhmm = String(format: "%02d%02d", first.time.hour, first.time.minute)
        let id = "\(Self.prefix)group.\(first.day.year)-\(first.day.month)-\(first.day.day).\(hhmm)"
        return UNNotificationRequest(identifier: id, content: content, trigger: trigger(first.fire, store: store))
    }

    private func trigger(_ fire: Date, store: HabitStore) -> UNCalendarNotificationTrigger {
        let parts = store.calendar.dateComponents([.year, .month, .day, .hour, .minute], from: fire)
        return UNCalendarNotificationTrigger(dateMatching: parts, repeats: false)
    }

    private static func same(_ a: UNNotificationRequest, _ b: UNNotificationRequest) -> Bool {
        a.content.title == b.content.title && a.content.body == b.content.body
            && a.content.categoryIdentifier == b.content.categoryIdentifier
            && (a.trigger as? UNCalendarNotificationTrigger)?.dateComponents == (b.trigger as? UNCalendarNotificationTrigger)?.dateComponents
    }

    private func reminderBody(_ habit: Habit, store: HabitStore) -> String {
        let goal = store.goal(of: habit)
        switch habit.kind {
        case .amount(let unit, _): return habit.atMost ? "No more than \(HabitCopy.amount(goal, unit)) today"
            : HabitCopy.capitalized(HabitCopy.plan(habit, weekStart: store.settings.weekStart))
        case .duration: return HabitCopy.capitalized(HabitCopy.plan(habit, weekStart: store.settings.weekStart))
        case .checklist: return habit.steps.count == 1 ? "1 step" : "\(habit.steps.count) steps"
        case .task: return "To-do"
        default: return "Time for \(habit.name.lowercased())"
        }
    }

    // MARK: Actions

    /// Check it off and to-dos get Done; an amount gets "+1 glass"; Time it and checklists open the app.
    private static func category(for habit: Habit) -> String {
        switch habit.kind {
        case .check, .task: singleCategory
        case .amount: addCategoryPrefix + habit.id.uuidString
        default: ""
        }
    }

    /// The fixed categories, set at launch so actions work before the first reconcile.
    static func registerCategories() {
        UNUserNotificationCenter.current().setNotificationCategories(categories(for: []))
    }

    private static func categories(for habits: [Habit]) -> Set<UNNotificationCategory> {
        var set: Set<UNNotificationCategory> = [
            UNNotificationCategory(identifier: singleCategory, actions: [UNNotificationAction(identifier: doneAction, title: "Done", options: [])],
                                   intentIdentifiers: []),
            UNNotificationCategory(identifier: groupCategory, actions: [], intentIdentifiers: []),
        ]
        // An amount's button names its own step, so each amount habit has its own category.
        for habit in habits where !habit.archived {
            guard case .amount(let unit, _) = habit.kind, let increment = habit.quickIncrement else { continue }
            let title = "+" + HabitCopy.amount(increment, unit)
            set.insert(UNNotificationCategory(identifier: addCategoryPrefix + habit.id.uuidString,
                                              actions: [UNNotificationAction(identifier: addAction, title: title, options: [])],
                                              intentIdentifiers: []))
        }
        return set
    }

    // MARK: Delivered

    /// The times whose rows are done today (and last night, before the day's end), as ID prefixes.
    private func doneTimeIDs(_ store: HabitStore, now: Date) -> Set<String> {
        let today = store.today(now: now)
        var ids = Set<String>()
        for habit in store.habits where !habit.atMost && habit.kind != .quit {
            for placement in store.placements(of: habit) {
                let done = placement.slot.map { store.isSlotDone(habit, slot: $0, on: today) } ?? store.isSatisfied(habit, on: today)
                if done { ids.formUnion(placement.times.map { "\(Self.prefix)\(habit.id.uuidString).\($0.id.uuidString)." }) }
            }
        }
        return ids
    }

    /// A row ticked: clear its reminders already on screen, and a grouped one once all its habits are done.
    private func clearDelivered(_ store: HabitStore, now: Date) async {
        let done = doneTimeIDs(store, now: now)
        let today = store.today(now: now)
        let delivered = await center.deliveredNotifications().map(\.request)
        let stale = delivered.filter { request in
            let id = request.identifier
            if done.contains(where: { id.hasPrefix($0) }) { return true }
            guard id.hasPrefix(Self.prefix + "group."), let list = request.content.userInfo["habits"] as? String else { return false }
            let ids = list.split(separator: ",").compactMap { UUID(uuidString: String($0)) }
            return ids.allSatisfy { id in store.habits.first { $0.id == id }.map { store.isSatisfied($0, on: today) } ?? true }
        }
        center.removeDeliveredNotifications(withIdentifiers: stale.map(\.identifier))
    }
}
