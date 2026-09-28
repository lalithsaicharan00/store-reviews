import ActivityKit
import AlarmKit
import AppIntents
import CryptoKit
import SwiftUI

/// Alarm-style reminders through AlarmKit (iOS 26): they ring on silent and in a Focus, full screen,
/// until stopped. Reconciled in the same pass as notifications (`ReminderScheduler.reconcile`).
///
/// Each alarm's ID is derived from the reminder's own ID, so a reconcile can cancel exactly what is
/// no longer wanted (done, edited, deleted, archived or switched to Notification) with nothing stored.
@available(iOS 26, *)
final class AlarmScheduler {
    static let shared = AlarmScheduler()
    private let manager = AlarmManager.shared
    /// AlarmKit refuses more than a per-app maximum (it throws `maximumLimitReached`; the number isn't
    /// published). Keep the nearest ones well below any plausible limit.
    private static let limit = 30

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

    /// - Parameter keepRinging: ID prefixes of rows done today. An alarm that is ringing is left alone
    ///   (its time has passed, so it's no longer "wanted"), unless its row has since been done.
    func reconcile(_ alerts: [ReminderScheduler.Alert], keepRinging done: Set<String>, store: HabitStore) async {
        let wanted = Dictionary(alerts.prefix(Self.limit).map { (Self.alarmID($0.id), $0) }, uniquingKeysWith: { a, _ in a })
        let existing = (try? manager.alarms) ?? []
        for alarm in existing {
            if let alert = wanted[alarm.id], alarm.schedule == .fixed(alert.fire) { continue }
            if alarm.state == .alerting && !Self.ringingRowIsDone(alarm, done: done) { continue }
            try? manager.cancel(id: alarm.id)
        }
        let kept = Set(((try? manager.alarms) ?? []).map(\.id))
        for (id, alert) in wanted.sorted(by: { $0.value.fire < $1.value.fire }) where !kept.contains(id) {
            do {
                let title = alert.followUp > 0 ? "\(alert.habit.name) · not done yet" : alert.habit.name
                try await Self.schedule(id: id, title: title, tint: alert.habit.color.color, fire: alert.fire, target: alert.target)
            } catch AlarmManager.AlarmError.maximumLimitReached {
                break
            } catch {
                continue
            }
        }
    }

    private static func ringingRowIsDone(_ alarm: Alarm, done: Set<String>) -> Bool {
        // The alarm's ID can't be turned back into a reminder ID, so check each done row's IDs for today.
        let today = AppModel.shared.store.today()
        return done.contains { prefix in
            let base = prefix + "\(today.year)-\(today.month)-\(today.day)"
            return ([base] + (1...ReminderScheduler.maxFollowUps).map { base + ".f\($0)" }).contains { alarmID($0) == alarm.id }
        }
    }

    /// One fixed-date alarm: the habit's name, Stop, and Done (which marks the row done; Stop doesn't).
    nonisolated private static func schedule(id: UUID, title: String, tint: Color, fire: Date, target: ReminderTarget) async throws {
        let name = LocalizedStringResource(stringLiteral: title)
        let done = AlarmButton(text: "Done", textColor: .white, systemImageName: "checkmark")
        let alert: AlarmPresentation.Alert
        if #available(iOS 26.1, *) {
            alert = AlarmPresentation.Alert(title: name, secondaryButton: done, secondaryButtonBehavior: .custom)
        } else {
            alert = AlarmPresentation.Alert(title: name, stopButton: AlarmButton(text: "Stop", textColor: .white, systemImageName: "stop.fill"),
                                            secondaryButton: done, secondaryButtonBehavior: .custom)
        }
        let attributes = AlarmAttributes<HabitAlarmData>(presentation: AlarmPresentation(alert: alert),
                                                         metadata: HabitAlarmData(habit: target.habit.uuidString), tintColor: tint)
        let configuration = AlarmManager.AlarmConfiguration<HabitAlarmData>.alarm(
            schedule: .fixed(fire), attributes: attributes, secondaryIntent: MarkHabitDoneIntent(target: target))
        _ = try await AlarmManager.shared.schedule(id: id, configuration: configuration)
    }

    /// A stable UUID from a reminder's ID (the first 16 bytes of its SHA-256, marked as version 5).
    nonisolated static func alarmID(_ reminderID: String) -> UUID {
        var bytes = Array(SHA256.hash(data: Data(reminderID.utf8)).prefix(16))
        bytes[6] = (bytes[6] & 0x0F) | 0x50
        bytes[8] = (bytes[8] & 0x3F) | 0x80
        return UUID(uuid: (bytes[0], bytes[1], bytes[2], bytes[3], bytes[4], bytes[5], bytes[6], bytes[7],
                           bytes[8], bytes[9], bytes[10], bytes[11], bytes[12], bytes[13], bytes[14], bytes[15]))
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

    @Parameter(title: "Habit") var habit: String
    @Parameter(title: "Time") var time: String?
    @Parameter(title: "Day") var day: String
    @Parameter(title: "Section") var slot: String?

    nonisolated init() {}

    nonisolated init(target: ReminderTarget) {
        habit = target.habit.uuidString
        time = target.time?.uuidString
        day = target.day.key
        slot = target.slot
    }

    func perform() async throws -> some IntentResult {
        if let id = UUID(uuidString: habit), let day = LocalDay(key: day) {
            await AppModel.shared.logFromReminder(ReminderTarget(habit: id, time: time.flatMap(UUID.init(uuidString:)), day: day, slot: slot, section: nil))
        }
        return .result()
    }
}
