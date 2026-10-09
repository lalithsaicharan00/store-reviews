import SwiftUI
import UIKit

extension Habit {
    var analyticsType: AnalyticsHabitType {
        if kind == .task { return .notApplicable }
        if atMost {
            switch kind { case .amount, .duration: return .cutDown; default: break }
        }
        switch kind {
        case .check: return .check
        case .amount: return .amount
        case .duration: return .duration
        case .checklist: return .checklist
        case .quit: return .quit
        case .task: return .notApplicable
        }
    }
}
extension EntrySource {
    var analyticsOrigin: AnalyticsOrigin {
        switch self {
        case .today: return .today
        case .manual: return .manual
        case .routine: return .routine
        case .reminder: return .reminder
        case .timer: return .timer
        case .daySheet: return .history
        case .shortcut: return .shortcut
        case .widget: return .widget
        }
    }
}
extension HabitStore {
    /// Effective historical rule is resolved before extracting only enums; no Entry or Habit enters telemetry.
    func analyticsTracked(_ entry: Entry, ticket: AnalyticsTicket?) {
        guard ticket != nil, let habit = habits.first(where: { $0.id == entry.habitID }) else { return }
        analytics.tracking(rule(habit, on: entry.day).analyticsType, origin: (entry.source ?? .manual).analyticsOrigin, ticket: ticket)
    }
    func analyticsConfiguration(reminderPermission: String? = nil) {
        guard analytics.consented else { return }
        let defaults = UserDefaults.standard
        let persisted = Bundle.main.bundleIdentifier.flatMap { defaults.persistentDomain(forName: $0) }
        func source(_ key: String) -> AnalyticsValue {
            guard let persisted else { return .text("unknown") }
            return .text(persisted[key] == nil ? "default" : "user_selected")
        }
        var properties: [String: AnalyticsValue] = [
            "account_state": .text("no_account"), "account_provider": .text("not_applicable"), "sync_state": .text("no_account"),
            "backup_primary": .text("local_only"), "primary_source": .text("automatic"), "secondary_copy": .text("disabled"),
            "effective_backup_status": .text("unknown"), "widget_privacy": .text(HideNames.isOn ? "hidden" : "visible"), "onboarding_state": .text(defaults.string(forKey: Onboarding.outcomeKey) ?? (defaults.bool(forKey: Onboarding.doneKey) ? "unknown" : "not_started")),
            "theme": .text(Theme(rawValue: defaults.string(forKey: Preferences.theme) ?? "automatic")?.rawValue ?? "automatic"),
            "widget_privacy_source": source(HideNames.key), "theme_source": source(Preferences.theme), "haptics_source": source(Preferences.haptics),
            "sound_source": source(Preferences.sound), "streaks_source": source(ProgressOptions.showStreaks), "app_lock_source": source(AppLock.launchKey),
            "haptics": .flag(defaults.object(forKey: Preferences.haptics) as? Bool ?? true), "sound": .flag(defaults.bool(forKey: Preferences.sound)),
            "streaks": .flag(defaults.object(forKey: ProgressOptions.showStreaks) as? Bool ?? true), "app_lock": .flag(AppLock.isEnabled),
            "capability_set_version": .number(2), "capability_account": .flag(false), "capability_purchase": .flag(false),
            "capability_sync": .flag(false), "capability_widgets": .flag(true), "capability_onboarding": .flag(true),
            "capability_progress": .flag(true), "capability_alarm": .flag(ReminderScheduler.alarmsAvailable)
        ]
        if let reminderPermission { properties["reminder_permission"] = .text(reminderPermission) }
        analytics.configuration(properties)
    }
}

private struct AnalyticsScreenModifier: ViewModifier {
    let screen: AnalyticsScreen?
    @State private var token = UUID()
    func body(content: Content) -> some View {
        content.onAppear { Analytics.shared.surface(token, screen: screen, appeared: true) }
            .onDisappear { Analytics.shared.surface(token, screen: screen, appeared: false) }
    }
}
extension View {
    /// A nil surface suspends attribution for an unmeasured modal. No ticking/observable telemetry state.
    func analyticsScreen(_ screen: AnalyticsScreen?) -> some View { modifier(AnalyticsScreenModifier(screen: screen)) }
}

/// Observes only that native interaction occurred. It neither recognizes a gesture nor cancels/delays touches,
/// and never reads coordinates, hit targets, key presses, text or accessibility labels.
private final class AnalyticsTouchObserver: UIGestureRecognizer {
    private var last = 0.0
    private func touched() {
        let now = ProcessInfo.processInfo.systemUptime
        guard now - last >= 1 else { return }
        last = now; Analytics.shared.interaction()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) { touched() }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) { touched() }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) { state = .failed }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) { state = .failed }
    override func canPrevent(_ preventedGestureRecognizer: UIGestureRecognizer) -> Bool { false }
    override func canBePrevented(by preventingGestureRecognizer: UIGestureRecognizer) -> Bool { false }
}
enum AnalyticsInteractionObserver {
    static func install() {
        guard Analytics.shared.consented else { return }
        for case let scene as UIWindowScene in UIApplication.shared.connectedScenes {
            for window in scene.windows where !(window.gestureRecognizers ?? []).contains(where: { $0 is AnalyticsTouchObserver }) {
                let observer = AnalyticsTouchObserver()
                observer.cancelsTouchesInView = false; observer.delaysTouchesBegan = false; observer.delaysTouchesEnded = false
                window.addGestureRecognizer(observer)
            }
        }
    }
}
