import Foundation
import Observation
import UserNotifications

/// Keeps the system's pending notifications (and, on iOS 26, alarms) exactly in step with the habits.
///
/// Reminders are not written once and forgotten: every change re-plans the next few days and
/// reconciles against what is pending, removing completed, deleted and no-longer-due alerts and
/// replacing edited times. System failures are surfaced (Feature Ledger C039). Rules:
/// "Times, Day Sections and Reminders" §3.4 and iOS/Docs/Specs/Pending to Implement.md §6.
@MainActor @Observable
final class ReminderScheduler {
    @ObservationIgnored private let center: ReminderNotifications
    @ObservationIgnored private let alarmDelivery: ReminderAlarms
    @ObservationIgnored private var reconciliation: Task<Void, Never>?
    var problem: String?
    var scheduledThrough: Date?

    init(notifications: ReminderNotifications = SystemReminderNotifications(), alarms: ReminderAlarms = SystemReminderAlarms()) {
        center = notifications; alarmDelivery = alarms
    }

    func notificationStatus() async -> UNAuthorizationStatus { await center.authorizationStatus() }
    var alarmsAuthorized: Bool { alarmDelivery.isAuthorized }
    private static let prefix = "reminder."
    /// iOS keeps at most 64 pending notifications per app; stay under it.
    private static let limit = 60
    private static let horizonDays = 30
    /// Remind Again repeats at most this many times after the time itself.
    static let maxFollowUps = 3
    @ObservationIgnored private var pendingWork: Task<Void, Never>?

    nonisolated static let doneAction = "habit.done"
    nonisolated static let addAction = "habit.add"
    private static let singleCategory = "habit.single"
    private static let addCategoryPrefix = "habit.add."
    private static let typedCategoryPrefix = "habit.typed."
    private static let timerCategory = "habit.timer"
    /// Log Steps, Log Minutes: a number typed in iOS's reply field.
    nonisolated static let typedAction = "habit.typed"
    /// Start Timer: opens the app on the habit's running timer.
    nonisolated static let startTimerAction = "habit.startTimer"

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
            ReminderTarget(habit: habit.id, time: time.id, day: day, slot: placement.slot, section: placement.section,
                           signature: ReminderIdentity.signature(habit), event: id)
        }
    }

    // MARK: Permission

    /// Asks once, at the moment the user adds their first time with Remind Me on (Architecture 09 §4).
    func requestPermission() async -> Bool {
        switch await center.authorizationStatus() {
        case .authorized, .provisional, .ephemeral: return true
        case .notDetermined: return await center.requestPermission()
        default: return false
        }
    }

    func isDenied() async -> Bool {
        await center.authorizationStatus() == .denied
    }

    /// Whether Alarm can be offered: AlarmKit exists from iOS 26.
    static var alarmsAvailable: Bool {
        if #available(iOS 26, *) { true } else { false }
    }

    /// Asks for alarm permission when Alarm is first chosen. False below iOS 26 or when denied.
    func requestAlarmPermission() async -> Bool {
        await alarmDelivery.requestPermission()
    }

    func alarmsDenied() -> Bool {
        alarmDelivery.isDenied
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

    /// A newer pass must finish after every older pass. Cancelling a debounce never cancels an
    /// in-flight system write, which could otherwise put an old alert back after an edit.
    func reconcile(_ store: HabitStore, now: Date? = nil) async {
        guard !Task.isCancelled else { return }
        let previous = reconciliation
        let work = Task { @MainActor in
            await previous?.value
            await self.reconcileNow(store, now: now ?? .now)
        }
        reconciliation = work
        await work.value
    }

    private func reconcileNow(_ store: HabitStore, now: Date) async {
        // A temporarily unavailable database is not an empty database. Keep pending alerts intact.
        guard store.isLoaded, store.isStorageReady, store.problem == nil else { return }
        problem = nil
        let status = await center.authorizationStatus()
        let planned = perfTimed("Reminders: plan every alert") { plan(store, now: now) }
        let ring = alarmDelivery.isAuthorized ? planned.filter { $0.habit.alert == .alarm } : []
        let alarmIDs = await alarmDelivery.reconcile(ring, keepRinging: doneTimeIDs(store, now: now), store: store)
        // Failed or excess alarms get a standard notification instead of silently disappearing.
        let notes = planned.filter { !alarmIDs.contains($0.id) }
        if ring.contains(where: { !alarmIDs.contains($0.id) }) {
            problem = "Some alarms couldn’t be added. Often Enough is using notifications for them when allowed."
        }
        if let alarmProblem = alarmDelivery.problem { problem = alarmProblem }
        center.categories(Self.categories(for: store.habits, hidden: HideNames.isOn))
        let allPending = await center.pending()
        let pending = allPending.filter { $0.identifier.hasPrefix(Self.prefix) }
        // Timer goal alerts share iOS's 64 slots. Reserve for already-pending and running timers.
        let others = allPending.count - pending.count
        let pendingIDs = Set(allPending.map(\.identifier))
        let missingTimers = store.timers.keys.filter { !pendingIDs.contains(TimerPresence.prefix + $0.uuidString) }.count
        let budget = min(Self.limit, max(0, 64 - others - missingTimers))
        let wanted = Self.accepts(status) ? perfTimed("Reminders: build requests") { requests(for: notes, store: store, limit: budget) } : []
        let wantedIDs = Set(wanted.map(\.identifier))
        center.removePending(pending.map(\.identifier).filter { !wantedIDs.contains($0) })
        let current = Dictionary(pending.map { ($0.identifier, $0) }, uniquingKeysWith: { a, _ in a })
        var accepted = wanted.filter { request in current[request.identifier].map { Self.same($0, request) } ?? false }
        // Adding the same ID replaces it; unchanged requests incur no system writes.
        for request in wanted where current[request.identifier].map({ !Self.same($0, request) }) ?? true {
            do {
                do { try await center.add(request) }
                catch { try await center.add(request) } // one retry for a transient system failure
                accepted.append(request)
            } catch {
                center.removePending([request.identifier]) // never leave an old changed time behind
                problem = "Some reminders couldn’t be scheduled. Open Reminders and try scheduling again."
            }
        }
        let confirmed = await center.pending()
        let confirmedIDs = Set(confirmed.map(\.identifier))
        let acceptedIDs = Set(accepted.map(\.identifier)).intersection(confirmedIDs)
        if wanted.contains(where: { !confirmedIDs.contains($0.identifier) }), problem == nil {
            problem = "iPhone couldn’t keep all scheduled reminders. Try scheduling again."
        }
        let dates = wanted.filter { acceptedIDs.contains($0.identifier) }.compactMap { ($0.trigger as? UNCalendarNotificationTrigger)?.nextTriggerDate() }
        let alarmDates = planned.filter { alarmIDs.contains($0.id) }.map(\.fire)
        scheduledThrough = (dates + alarmDates).max()
        await clearDelivered(store, now: now)
    }

    static func accepts(_ status: UNAuthorizationStatus) -> Bool {
        status == .authorized || status == .provisional || status == .ephemeral
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
                guard store.isDue(habit, on: day, now: now) else { continue }
                var seenFires = Set<Date>()
                for placement in placements {
                    // A limit is never "not done", so it always reminds. Anything else stops once its row is done;
                    // for week and month rules, once the period's goal is met.
                    if !habit.atMost {
                        let done = placement.slot.map { store.isSlotDone(habit, slot: $0, on: day) } ?? store.isSatisfied(habit, on: day)
                        if done { continue }
                    }
                    var seenTimes = Set<Int>()
                    let times: [(time: ReminderTime, fire: Date)] = placement.times.sorted { ($0.minuteOfDay, $0.id.uuidString) < ($1.minuteOfDay, $1.id.uuidString) }
                        .filter { (0...23).contains($0.hour) && (0...59).contains($0.minute) && seenTimes.insert($0.minuteOfDay).inserted }
                        .sorted { store.dayMinute($0.minuteOfDay) < store.dayMinute($1.minuteOfDay) }
                        .compactMap { time in
                            guard let fire = fireDate(time, on: day, store: store), seenFires.insert(fire).inserted else { return nil }
                            return (time, fire)
                        }
                    // Spring-forward times can collapse onto the same actual minute. Keep one
                    // alert per item, and base follow-ups on the remaining distinct fire times.
                    for (i, pair) in times.enumerated() {
                        let time = pair.time, fire = pair.fire
                        let section = store.section(forMinute: time.minuteOfDay)
                        let base = "\(Self.prefix)\(habit.id.uuidString).\(time.id.uuidString).\(day.year)-\(day.month)-\(day.day)"
                        if fire > now {
                            alerts.append(Alert(id: base, fire: fire, habit: habit, day: day, placement: placement, time: time, followUp: 0, section: section))
                        }
                        // Remind Again: today and tomorrow only, to protect the pending budget; the reconcile
                        // and the background refresh roll the window forward. Repeats stop at the row's next
                        // time (it reminds anyway) and at the end of the day.
                        guard let every = habit.followUpMinutes, every > 0, every <= 1440, !habit.atMost, offset <= 1 else { continue }
                        let stop = i + 1 < times.count ? times[i + 1].fire : dayEnd(day, store: store)
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
        let order = Dictionary(uniqueKeysWithValues: store.habits.enumerated().map { ($1.id, $0) })
        return alerts.sorted { ($0.fire, order[$0.habit.id] ?? 0, $0.id) < ($1.fire, order[$1.habit.id] ?? 0, $1.id) }
    }

    func fireDate(_ time: ReminderTime, on day: LocalDay, store: HabitStore) -> Date? {
        let actual = time.minuteOfDay < store.settings.dayEndHour * 60 ? day.adding(days: 1, calendar: store.calendar) : day
        return ReminderClock.date(on: actual, hour: time.hour, minute: time.minute, calendar: store.calendar)
    }

    private func dayEnd(_ day: LocalDay, store: HabitStore) -> Date {
        ReminderClock.date(on: day.adding(days: 1, calendar: store.calendar), hour: store.settings.dayEndHour,
                           minute: 0, calendar: store.calendar)!
    }

    // MARK: Notifications

    /// Every habit is its own reminder, with its own action; reminders of one routine pile together (`threadIdentifier`),
    /// as iOS does (Figma, flow 266). Repeats are their own too, so each stops on its own tick.
    func requests(for alerts: [Alert], store: HabitStore, limit: Int = 60) -> [UNNotificationRequest] {
        guard limit > 0 else { return [] }
        // Select the nearest requests before encoding content. A large plan can contain thousands of alerts, but iOS keeps
        // at most 60 of ours.
        let nearest = alerts.sorted { ($0.fire, $0.id) < ($1.fire, $1.id) }.prefix(limit)
        return nearest.map { single($0, store: store) }
    }

    private func single(_ alert: Alert, store: HabitStore) -> UNNotificationRequest {
        let habit = alert.habit
        let content = UNMutableNotificationContent()
        if HideNames.isOn {
            // Names hidden outside the app (Current Work 58; spec §3.7): the person's own words, or the time; never the
            // name, a section's name or a note (U3: "Still open", never "missed").
            let words = Self.hiddenTitle(alert)
            content.title = words.title
            content.body = words.body
        } else {
            content.title = habit.name
            // Figma (flows 265–274): the line under the name is where the habit stands that day, in words, since a
            // notification has no progress bar ("Not done yet", "3 of 8 glasses", "2 of 3 this week"); a follow-up says
            // "Still to do today". The plan is re-made on every change, so today's line is current when it comes.
            var body = alert.followUp > 0 ? "Still to do today" : Self.progressLine(habit, on: alert.day, store: store)
            // A habit ticked per section says which tick this is.
            if alert.placement.slot != nil { body = "\(store.section(alert.placement.section).name) · \(body)" }
            content.body = body
        }
        content.sound = .default
        content.threadIdentifier = alert.section.id
        content.categoryIdentifier = Self.category(for: habit)
        content.userInfo = alert.target.userInfo
        return UNNotificationRequest(identifier: alert.id, content: content, trigger: trigger(alert.fire, store: store))
    }

    private func trigger(_ fire: Date, store: HabitStore) -> UNCalendarNotificationTrigger {
        let parts = store.calendar.dateComponents([.year, .month, .day, .hour, .minute], from: fire)
        return UNCalendarNotificationTrigger(dateMatching: parts, repeats: false)
    }

    static func same(_ a: UNNotificationRequest, _ b: UNNotificationRequest) -> Bool {
        a.content.title == b.content.title && a.content.body == b.content.body
            && a.content.categoryIdentifier == b.content.categoryIdentifier
            && a.content.threadIdentifier == b.content.threadIdentifier
            && NSDictionary(dictionary: a.content.userInfo).isEqual(to: b.content.userInfo)
            && (a.trigger as? UNCalendarNotificationTrigger)?.dateComponents == (b.trigger as? UNCalendarNotificationTrigger)?.dateComponents
    }

    /// A reminder's words while names are hidden (spec §3.7): "Reminder says…" or "Reminder · 8:00"; a repeat
    /// "Still open · 8:00", with the person's own words under it.
    static func hiddenTitle(_ alert: Alert) -> (title: String, body: String) {
        let clock = DaySection.clock(alert.time.minuteOfDay)
        if alert.followUp > 0 { return ("Still open · \(clock)", alert.habit.reminderText ?? "") }
        return (alert.habit.reminderText ?? "Reminder · \(clock)", "")
    }

    /// The habit's progress on that day, in Figma's words: the same numbers Today and the widgets show
    /// (`widgetItem`), said as a sentence.
    static func progressLine(_ habit: Habit, on day: LocalDay, store: HabitStore) -> String {
        if habit.kind == .task { return "Task for today" }
        let item = store.widgetItem(habit, on: day, now: .now, isToday: day == store.today(), signature: "", showStreaks: false)
        // A goal over a week, month or year: "2 of 3 this week", "3 of 8 glasses this week".
        let goal = item.goal.hasPrefix("/ ") ? String(item.goal.dropFirst(2)) : item.goal
        let periods = [" this week", " this month", " this year", " a week", " a month"]
        let period = periods.contains { goal.hasSuffix($0) }
        // An amount in full numbers, with the unit's own plural ("2,500 of 8,000 steps", "1 of 8 glasses", "$20 of $100"),
        // where the widget shortens to "8k".
        if case .amount(let unit, _) = habit.kind {
            let done = store.progress(of: habit, on: day), target = store.goal(of: store.rule(habit, on: day))
            let suffix = periods.first { goal.hasSuffix($0) } ?? ""
            let trimmed = unit.trimmingCharacters(in: .whitespaces)
            let first = HabitCopy.currencies.contains(trimmed) ? HabitCopy.amount(done, trimmed) : HabitCopy.number(done)
            return "\(first) of \(HabitCopy.amount(target, trimmed))" + suffix
        }
        // Minutes as Figma says them ("4 of 10 min"); from an hour, both in full ("1 h 12 min of 2 h").
        if habit.kind == .duration {
            let done = store.progress(of: habit, on: day), goal = store.goal(of: store.rule(habit, on: day))
            let suffix = periods.first { goal == 0 ? false : item.goal.hasSuffix($0) } ?? ""
            let line = done < 60 && goal < 60 ? "\(Int(done.rounded(.down))) of \(Format.minutes(goal))"
                                              : "\(Format.minutes(done)) of \(Format.minutes(goal))"
            return line + suffix
        }
        if period, !item.big.isEmpty { return "\(item.big) of \(goal)" }
        // A once-a-day check: "Not done yet".
        if item.value == "Not checked" || item.value == "Checked" || item.value.isEmpty { return "Not done yet" }
        return item.value
    }

    // MARK: Actions

    /// One action per kind (Figma, flows 265–272): Done on a check or a task (a week goal's Done adds one), "+1 glass" on an
    /// amount with a step, Log Steps typed on one without, Start Timer and Log Minutes on a time habit. A checklist has none
    /// (one tick would close it with steps left), nor does a limit or a quit habit (nothing invites more).
    static func category(for habit: Habit) -> String {
        if habit.atMost { return "" }
        switch habit.kind {
        case .check, .task: return singleCategory
        case .amount: return (habit.quickIncrement == nil ? typedCategoryPrefix : addCategoryPrefix) + habit.id.uuidString
        case .duration: return timerCategory
        case .checklist, .quit: return ""
        }
    }

    /// The fixed categories, set at launch so actions work before the first reconcile.
    static func registerCategories() {
        UNUserNotificationCenter.current().setNotificationCategories(categories(for: [], hidden: HideNames.isOn))
    }

    /// What a phone with previews off shows instead of the text, on every category (spec §3.7).
    static let previewPlaceholder = "Reminder"

    static func categories(for habits: [Habit], hidden: Bool) -> Set<UNNotificationCategory> {
        func category(_ id: String, _ actions: [UNNotificationAction]) -> UNNotificationCategory {
            UNNotificationCategory(identifier: id, actions: actions, intentIdentifiers: [],
                                   hiddenPreviewsBodyPlaceholder: previewPlaceholder, options: [])
        }
        // Symbols as in Figma: checkmark, plus, square.and.pencil, play.fill.
        let done = UNNotificationAction(identifier: doneAction, title: "Done", options: [],
                                        icon: UNNotificationActionIcon(systemImageName: "checkmark"))
        let startTimer = UNNotificationAction(identifier: startTimerAction, title: "Start Timer", options: [.foreground],
                                              icon: UNNotificationActionIcon(systemImageName: "play.fill"))
        var set: Set<UNNotificationCategory> = [
            category(singleCategory, [done]),
            category(timerCategory, [startTimer, typed("Log Minutes", placeholder: "Minutes")]),
        ]
        // An amount's button names its own step or unit, so each amount habit has its own category. Names hidden: "+1"
        // and "Log", without the unit (spec §3.7, U16).
        for habit in habits where !habit.archived && !habit.atMost {
            guard case .amount(let unit, _) = habit.kind else { continue }
            if let increment = habit.quickIncrement {
                let title = "+" + (hidden ? Format.amount(increment) : HabitCopy.amount(increment, unit))
                set.insert(category(addCategoryPrefix + habit.id.uuidString,
                                    [UNNotificationAction(identifier: addAction, title: title, options: [],
                                                          icon: UNNotificationActionIcon(systemImageName: "plus"))]))
            } else {
                let name = unit.trimmingCharacters(in: .whitespaces)
                let title = hidden || name.isEmpty ? "Log" : "Log " + name.prefix(1).uppercased() + name.dropFirst()
                set.insert(category(typedCategoryPrefix + habit.id.uuidString,
                                    [typed(title, placeholder: hidden || name.isEmpty ? "Amount" : name.prefix(1).uppercased() + name.dropFirst())]))
            }
        }
        return set
    }

    /// A number typed in iOS's reply field ("Log Steps": placeholder "Steps", its button "Log").
    private static func typed(_ title: String, placeholder: String) -> UNTextInputNotificationAction {
        UNTextInputNotificationAction(identifier: typedAction, title: title, options: [],
                                      icon: UNNotificationActionIcon(systemImageName: "square.and.pencil"),
                                      textInputButtonTitle: "Log", textInputPlaceholder: placeholder)
    }

    /// The number in a reply ("2,500", "2500 steps", "12.5"); nothing when there's none, so nothing is saved.
    nonisolated static func typedNumber(_ text: String) -> Double? {
        let cleaned = text.replacingOccurrences(of: ",", with: "")
        guard let range = cleaned.range(of: #"\d+(\.\d+)?"#, options: .regularExpression) else { return nil }
        return Double(cleaned[range]).flatMap { $0 > 0 ? $0 : nil }
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

    /// A row ticked: clear its reminders already on screen. A follow-up replaces the reminder before it (Figma, flow 273):
    /// iOS can't hold two waiting reminders under one identifier, so each has its own, and the earlier ones on screen go
    /// here, whenever the app runs (it re-plans on every change and on return).
    private func clearDelivered(_ store: HabitStore, now: Date) async {
        let done = doneTimeIDs(store, now: now)
        let delivered = await center.delivered()
        let latest = Self.latestOfEach(delivered.map(\.identifier))
        let stale = delivered.filter { request in
            let id = request.identifier
            if id.hasPrefix(Self.prefix), let target = ReminderTarget(userInfo: request.content.userInfo),
               !store.canActOnReminder(target, now: now) { return true }
            if id.hasPrefix(Self.prefix), !latest.contains(id) { return true }
            return done.contains(where: { id.hasPrefix($0) })
        }
        center.removeDelivered(stale.map(\.identifier))
    }

    /// Of a reminder and its follow-ups (`….f1`, `….f2`), the newest one's identifier.
    nonisolated static func latestOfEach(_ ids: [String]) -> Set<String> {
        var best: [String: (k: Int, id: String)] = [:]
        for id in ids {
            var base = id, k = 0
            if let dot = id.lastIndex(of: "."), id[id.index(after: dot)...].hasPrefix("f"),
               let n = Int(id[id.index(dot, offsetBy: 2)...]) { base = String(id[..<dot]); k = n }
            if (best[base]?.k ?? -1) < k { best[base] = (k, id) }
        }
        return Set(best.values.map(\.id))
    }
}
