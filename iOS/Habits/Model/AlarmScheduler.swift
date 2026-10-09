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
                let title = alert.followUp > 0 ? "\(alert.habit.name) · not done yet" : alert.habit.name
                try await Self.schedule(id: id, title: title, action: Self.actionLabel(alert.habit), tint: alert.habit.color.color, fire: alert.fire, target: alert.target)
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

    static func actionLabel(_ habit: Habit) -> String? {
        switch habit.kind {
        case .check, .task: return "Done"
        case .amount(let unit, _): return habit.quickIncrement.map { "+" + HabitCopy.amount($0, unit) }
        default: return nil // timers and checklists require the app; no misleading Done button
        }
    }

    /// One fixed-date alarm: the habit's name, Stop, and Done (which marks the row done; Stop doesn't).
    nonisolated private static func schedule(id: UUID, title: String, action: String?, tint: Color, fire: Date, target: ReminderTarget) async throws {
        let name = LocalizedStringResource(stringLiteral: title)
        let done = action.map { AlarmButton(text: LocalizedStringResource(stringLiteral: $0), textColor: .white, systemImageName: "checkmark") }
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
        let configuration = AlarmManager.AlarmConfiguration<HabitAlarmData>.alarm(
            schedule: .fixed(fire), attributes: attributes, secondaryIntent: MarkHabitDoneIntent(target: target))
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

    nonisolated init() {}

    nonisolated init(target: ReminderTarget) {
        habit = target.habit.uuidString
        time = target.time?.uuidString
        day = target.day.key
        slot = target.slot
        signature = target.signature; event = target.event
    }

    func perform() async throws -> some IntentResult {
        #if DEBUG
        WidgetTiming.mark("alarm done: intent ran")
        #endif
        if let id = UUID(uuidString: habit), let day = LocalDay(key: day) {
            await AppModel.shared.logFromReminder(ReminderTarget(habit: id, time: time.flatMap(UUID.init(uuidString:)), day: day, slot: slot, section: nil, signature: signature, event: event))
        }
        return .result()
    }
}
