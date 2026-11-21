import ActivityKit
import AlarmKit
import AppIntents
import SwiftUI

/// Alarm-style reminders through AlarmKit (iOS 26): they ring on silent and in a Focus, full screen,
/// until stopped. Reconciled in the same pass as notifications (`ReminderScheduler.reconcile`).
///
/// Each alarm's ID is derived from the reminder's own ID, so a reconcile can cancel exactly what is
/// no longer wanted (done, edited, deleted, archived or switched to Notification) using locally saved ownership metadata.
@available(iOS 26, *)
final class AlarmScheduler {
    static let shared = AlarmScheduler()
    private let manager = AlarmManager.shared
    /// AlarmKit refuses more than a per-app maximum (it throws `maximumLimitReached`; the number isn't
    /// published). Keep the nearest ones well below any plausible limit.
    private static let limit = 30
    private var records: [UUID: AlarmReminderRecord] = AlarmReminderRecord.load()
    var problem: String?

    var isAuthorized: Bool { manager.authorizationState == .authorized }
    var isDenied: Bool { manager.authorizationState == .denied }

    func requestAuthorization() async -> Bool {
        switch manager.authorizationState {
        case .authorized: return true
        case .denied: return false
        default: return await Self.authorize() == .authorized
        }
    }

    // AlarmManager isn't Sendable, so its async calls run off the main actor from Sendable values.
    nonisolated private static func authorize() async -> AlarmManager.AuthorizationState {
        (try? await AlarmManager.shared.requestAuthorization()) ?? .denied
    }

    /// A ringing alarm keeps its ownership record and stays only while its target remains current.
    func reconcile(_ alerts: [ReminderScheduler.Alert], keepRinging done: Set<String>, store: HabitStore) async -> Set<String> {
        let wanted = Dictionary(alerts.prefix(Self.limit).map { (Self.alarmID($0.id), $0) }, uniquingKeysWith: { a, _ in a })
        problem = nil
        // Opening Reminders without ever choosing an alarm is a normal state. Some OS
        // versions reject reading alarms before authorization; there is nothing to clean up.
        guard isAuthorized || !records.isEmpty else { return [] }
        guard let existing = try? manager.alarms else {
            problem = "Alarms couldn’t be checked. Open Reminders and try scheduling again."
            return []
        }
        var kept = Set(existing.map(\.id))
        for alarm in existing {
            if let alert = wanted[alarm.id], alarm.schedule == .fixed(alert.fire), records[alarm.id]?.matches(alert) == true { continue }
            // A ringing alert is retained only while its saved target still matches today's item.
            // Unknown, deleted, paused, completed or edited alarms cannot ring forever.
            if alarm.state == .alerting, let record = records[alarm.id], record.isCurrent(in: store) { continue }
            do {
                do { try manager.cancel(id: alarm.id) }
                catch { try manager.cancel(id: alarm.id) }
                records.removeValue(forKey: alarm.id)
                kept.remove(alarm.id)
            } catch {
                problem = "An old alarm couldn’t be cancelled. Check your alarms and try scheduling again."
            }
        }
        for (id, alert) in wanted.sorted(by: { $0.value.fire < $1.value.fire }) where !kept.contains(id) {
            // Persist ownership before the system call; a process ending during schedule still
            // leaves enough information to cancel the alarm safely on the next launch.
            records[id] = AlarmReminderRecord(alert)
            AlarmReminderRecord.save(records)
            do {
                // The tint is the habit's light shade, which reads on the alarm's black (Notifications and Alarms §5).
                try await Self.schedule(id: id, title: AlarmReminderRecord.title(alert), action: Self.action(alert.habit),
                                        tint: alert.habit.color.gradientTop, fire: alert.fire, target: alert.target)
            } catch AlarmManager.AlarmError.maximumLimitReached {
                records.removeValue(forKey: id)
                break
            } catch {
                records.removeValue(forKey: id)
                continue
            }
        }
        guard let actual = try? manager.alarms else {
            problem = "iPhone couldn’t confirm the scheduled alarms. Try scheduling again."
            AlarmReminderRecord.save(records)
            return Set(wanted.compactMap { id, alert in records[id]?.matches(alert) == true ? alert.id : nil })
        }
        let actualIDs = Set(actual.map(\.id))
        records = records.filter { actualIDs.contains($0.key) }
        AlarmReminderRecord.save(records)
        return Set(wanted.compactMap { id, alert in
            guard actual.contains(where: { $0.id == id && $0.schedule == .fixed(alert.fire) }), records[id]?.matches(alert) == true else { return nil }
            return alert.id
        })
    }

    /// The alarm's second button, beside the system's Stop (Notifications and Alarms §6): Done, "+1 glass", or Open and
    /// Start for what needs the app. A limit or a quit habit has none (nothing invites more).
    nonisolated struct Action: Sendable, Equatable {
        let word: String
        let symbol: String
        /// Opens the app (Open: the habit's Day details; Start: its timer, started).
        let opens: Bool
        var starts: Bool { opens && symbol == "play.fill" }
    }

    static func action(_ habit: Habit) -> Action? {
        if habit.atMost { return nil }
        switch habit.kind {
        case .check, .task: return Action(word: "Done", symbol: "checkmark", opens: false)
        // Names hidden outside the app: "+1", without the unit (Current Work 58).
        case .amount(let unit, _):
            guard let step = habit.quickIncrement else { return Action(word: "Open", symbol: "arrow.up.forward.app", opens: true) }
            return Action(word: "+" + (HideNames.isOn ? Format.amount(step) : HabitCopy.amount(step, unit)), symbol: "plus", opens: false)
        case .duration: return Action(word: "Start", symbol: "play.fill", opens: true)
        case .checklist: return Action(word: "Open", symbol: "arrow.up.forward.app", opens: true)
        case .quit: return nil
        }
    }

    static func actionLabel(_ habit: Habit) -> String? { action(habit)?.word }

    /// One fixed-date alarm: the habit's name, the system's Stop, and our second button, which stops the alarm itself
    /// and then does its job (Stop never marks anything done). Its word is black: white doesn't read on the light tint.
    nonisolated private static func schedule(id: UUID, title: String, action: Action?, tint: Color, fire: Date, target: ReminderTarget) async throws {
        let name = LocalizedStringResource(stringLiteral: title)
        let done = action.map { AlarmButton(text: LocalizedStringResource(stringLiteral: $0.word), textColor: .black, systemImageName: $0.symbol) }
        let alert: AlarmPresentation.Alert
        if let done, #available(iOS 26.1, *) {
            alert = AlarmPresentation.Alert(title: name, secondaryButton: done, secondaryButtonBehavior: .custom)
        } else if let done {
            alert = AlarmPresentation.Alert(title: name, stopButton: AlarmButton(text: "Stop", textColor: .white, systemImageName: "stop.fill"),
                                            secondaryButton: done, secondaryButtonBehavior: .custom)
        } else if #available(iOS 26.1, *) {
            alert = AlarmPresentation.Alert(title: name)
        } else {
            alert = AlarmPresentation.Alert(title: name, stopButton: AlarmButton(text: "Stop", textColor: .white, systemImageName: "stop.fill"))
        }
        let attributes = AlarmAttributes<HabitAlarmData>(presentation: AlarmPresentation(alert: alert),
                                                         metadata: HabitAlarmData(habit: target.habit.uuidString), tintColor: tint)
        let intent: (any LiveActivityIntent)? = switch action {
        case .none: nil
        case .some(let action) where action.opens: OpenHabitFromAlarmIntent(target: target, alarm: id, start: action.starts)
        case .some: MarkHabitDoneIntent(target: target, alarm: id)
        }
        let configuration = AlarmManager.AlarmConfiguration<HabitAlarmData>.alarm(
            schedule: .fixed(fire), attributes: attributes, secondaryIntent: intent)
        _ = try await AlarmManager.shared.schedule(id: id, configuration: configuration)
    }

    /// A stable UUID from a reminder's ID (the first 16 bytes of its SHA-256, marked as version 5).
    nonisolated static func alarmID(_ reminderID: String) -> UUID {
        ReminderIdentity.actionID(reminderID)
    }
}

@available(iOS 26, *)
nonisolated struct HabitAlarmData: AlarmMetadata {
    var habit: String
}

/// The alarm's Done button: marks that row done, as a tick on Today would. It only ever adds.
/// Stopping the alarm doesn't run this, so Stop never marks anything done.
struct MarkHabitDoneIntent: LiveActivityIntent {
    static let title: LocalizedStringResource = "Mark Habit Done"
    static let isDiscoverable = false
    /// An alarm mostly rings on a locked phone: Done works there without unlocking (8 Oct 2026, Current Work 70), as
    /// the Live Activity's Pause and every widget button do. Without it iOS asked for Face ID first.
    static var authenticationPolicy: IntentAuthenticationPolicy { .alwaysAllowed }

    @Parameter(title: "Habit") var habit: String
    @Parameter(title: "Time") var time: String?
    @Parameter(title: "Day") var day: String
    @Parameter(title: "Section") var slot: String?
    @Parameter(title: "Configuration") var signature: String?
    @Parameter(title: "Event") var event: String?
    @Parameter(title: "Alarm") var alarm: String?

    nonisolated init() {}

    nonisolated init(target: ReminderTarget, alarm: UUID? = nil) {
        habit = target.habit.uuidString
        time = target.time?.uuidString
        day = target.day.key
        slot = target.slot
        signature = target.signature; event = target.event
        self.alarm = alarm?.uuidString
    }

    func perform() async throws -> some IntentResult {
        #if DEBUG
        WidgetTiming.mark("alarm done: intent ran")
        #endif
        // A custom second button doesn't stop the alarm by itself: it rang on (Notifications and Alarms §5).
        stopAlarm(alarm)
        if let id = UUID(uuidString: habit), let day = LocalDay(key: day) {
            await AppModel.shared.logFromReminder(ReminderTarget(habit: id, time: time.flatMap(UUID.init(uuidString:)), day: day, slot: slot, section: nil, signature: signature, event: event))
        }
        return .result()
    }
}

/// Stops the ringing alarm a second button belongs to.
nonisolated private func stopAlarm(_ alarm: String?) {
    guard #available(iOS 26, *), let id = alarm.flatMap(UUID.init(uuidString:)) else { return }
    try? AlarmManager.shared.stop(id: id)
}

/// The alarm's Open or Start: stops the alarm, then the app opens on the habit's Day details, or on its timer, started.
struct OpenHabitFromAlarmIntent: LiveActivityIntent {
    static let title: LocalizedStringResource = "Open Habit"
    static let isDiscoverable = false
    static let openAppWhenRun = true

    @Parameter(title: "Habit") var habit: String
    @Parameter(title: "Day") var day: String
    @Parameter(title: "Alarm") var alarm: String?
    @Parameter(title: "Start") var start: Bool

    nonisolated init() {}

    nonisolated init(target: ReminderTarget, alarm: UUID, start: Bool) {
        habit = target.habit.uuidString
        day = target.day.key
        self.alarm = alarm.uuidString
        self.start = start
    }

    func perform() async throws -> some IntentResult {
        stopAlarm(alarm)
        if let id = UUID(uuidString: habit), let day = LocalDay(key: day) {
            let target = ReminderTarget(habit: id, time: nil, day: day, slot: nil, section: nil)
            if start { await AppModel.shared.startTimer(from: target) } else { await AppModel.shared.open(target, section: nil) }
        }
        return .result()
    }
}
