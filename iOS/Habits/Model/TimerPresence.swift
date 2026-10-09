import ActivityKit
import Foundation
import UserNotifications

/// A running timer, outside the app: a Live Activity on the Lock Screen and in the Dynamic Island, and
/// one notification when the goal is reached. Kept exactly in step with `HabitStore.timers` after every
/// change, like reminders.
///
/// Research: "Timing a Habit — Start, See and Stop" (28 Sep). People leave the app while they time
/// something and want to see it from there (73 reviews). They want one alert at the goal (53), never a
/// ping every second (12). And the Live Activity must end the moment the timer stops.
@MainActor
final class TimerPresence {
    static let prefix = "timer."
    private let center = UNUserNotificationCenter.current()
    private var askedPermission = false
    /// The full-screen routine player is open: never interrupt it with the permission prompt (a pop-up over
    /// the timer, found by hand 29 Sep). The first timer started from Today asks instead.
    static var playerOpen = false
    /// Set when the person taps ▶ on Today: the only moment the prompt makes sense. Restoring a timer at launch
    /// or inside the player never asks (a prompt over Today at launch, found by hand 29 Sep).
    static var askOnNextSync = false
    /// UI tests leave the Lock Screen and notifications alone unless a test asks (-timer-presence).
    private let enabled: Bool = {
        let arguments = ProcessInfo.processInfo.arguments
        return !arguments.contains("-uitest") || arguments.contains("-timer-presence")
    }()

    /// One running timer, as the Lock Screen and the notification show it.
    nonisolated struct Running: Sendable {
        let habit: Habit
        let section: String?
        let goal: Double
        let attributes: HabitTimerAttributes
        let state: HabitTimerAttributes.ContentState
        /// When the goal is reached; nil when it already is.
        let goalReached: Date?
    }

    func sync(_ store: HabitStore, now: Date = .now) async {
        guard enabled else { return }
        let running = runningTimers(store, now: now)
        await syncNotifications(running, day: store.today(now: now))
        // ≡ → Appearance → Timers → Show on Lock Screen, read here on the main actor.
        await Self.syncActivities(running, shown: UserDefaults.standard.bool(forKey: Preferences.timerLiveActivity))
    }

    private func runningTimers(_ store: HabitStore, now: Date) -> [Running] {
        let today = store.today(now: now)
        return store.timers.compactMap { id, _ in
            guard let habit = store.habits.first(where: { $0.id == id && !$0.archived }) else { return nil }
            // Minutes so far today (or this week…), including the running session.
            let progress = store.progress(of: habit, on: today, now: now)
            let goal = store.goal(of: habit)
            let clockStart = now.addingTimeInterval(-progress * 60)
            let goalAt = clockStart.addingTimeInterval(goal * 60)
            let slot = store.timerSlots[id]
            let placements = store.placements(of: habit)
            let section = (placements.first { slot != nil && $0.slot == slot } ?? placements.first)?.section
            return Running(
                habit: habit, section: section, goal: goal,
                attributes: HabitTimerAttributes(habitID: id.uuidString, name: habit.name, symbol: habit.symbol,
                                                 color: habit.color.rawValue, goalLabel: Self.goalLabel(habit, goal: goal)),
                state: .init(clockStart: clockStart, goalAt: goalAt),
                goalReached: goalAt > now ? goalAt : nil)
        }
    }

    /// "20 min", "3 h this week", "1 h max": the goal as the row shows it.
    static func goalLabel(_ habit: Habit, goal: Double) -> String {
        Format.minutes(goal) + (habit.atMost ? " max" : "") + period(habit)
    }

    private static func period(_ habit: Habit) -> String {
        switch habit.frequency {
        case .perWeek: " this week"
        case .perMonth: " this month"
        case .perYear: " this year"
        default: ""
        }
    }

    /// "20 min done." / "That's your 1 h limit for today." Says what counts, never "failed" or
    /// "overdue" (Design Rules, copy).
    static func goalMessage(_ habit: Habit, goal: Double) -> String {
        let amount = Format.minutes(goal)
        let period = period(habit)
        if habit.atMost {
            return "That's your \(amount) limit for \(period.isEmpty ? "today" : String(period.dropFirst()))."
        }
        return "\(amount) done\(period). The timer keeps going until you stop it."
    }

    // MARK: Notifications

    private func syncNotifications(_ running: [Running], day: LocalDay) async {
        let pending = await center.pendingNotificationRequests().map(\.identifier).filter { $0.hasPrefix(Self.prefix) }
        center.removePendingNotificationRequests(withIdentifiers: pending)
        let due = running.filter { $0.goalReached != nil }
        guard !due.isEmpty, await allowed() else { return }
        for timer in due {
            guard let fire = timer.goalReached else { continue }
            let content = UNMutableNotificationContent()
            content.title = timer.habit.name
            content.body = Self.goalMessage(timer.habit, goal: timer.goal)
            content.sound = .default
            // Tapping it opens today's section, like a reminder.
            content.userInfo = ReminderTarget(habit: timer.habit.id, time: nil, day: day, slot: nil, section: timer.section).userInfo
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: max(1, fire.timeIntervalSinceNow), repeats: false)
            try? await center.add(UNNotificationRequest(identifier: Self.prefix + timer.habit.id.uuidString, content: content, trigger: trigger))
        }
    }

    /// Asks once, when the first timer starts, since the goal alert is what makes a timer useful away
    /// from the phone.
    private func allowed() async -> Bool {
        switch await center.notificationSettings().authorizationStatus {
        case .authorized, .provisional, .ephemeral: return true
        case .notDetermined where !askedPermission && !Self.playerOpen && Self.askOnNextSync:
            Self.askOnNextSync = false
            askedPermission = true
            return (try? await center.requestAuthorization(options: [.alert, .sound, .badge])) ?? false
        default: return false
        }
    }

    // MARK: Live Activities

    /// Off the main actor, so the system's activity objects never cross actors.
    nonisolated private static func syncActivities(_ running: [Running], shown: Bool) async {
        let activities = Activity<HabitTimerAttributes>.activities
        let wanted = Dictionary(running.map { ($0.attributes.habitID, $0) }, uniquingKeysWith: { a, _ in a })
        // `shown` off (≡ → Appearance → Timers): none at all (users show a few want it gone; Apple: give people control
        // over Live Activities). iOS's own Settings switch is checked below.
        // A stopped timer's activity goes at once: one left behind looks like time still counting.
        for activity in activities where !shown || wanted[activity.attributes.habitID] == nil {
            await activity.end(nil, dismissalPolicy: .immediate)
        }
        #if DEBUG
        WidgetTiming.mark("live activity: \(running.count) timer(s) running, \(activities.count) activit(ies), shown \(shown), allowed \(ActivityAuthorizationInfo().areActivitiesEnabled)")
        #endif
        guard shown, ActivityAuthorizationInfo().areActivitiesEnabled else { return }
        for timer in running {
            let content = ActivityContent(state: timer.state, staleDate: nil)
            let live = activities.first {
                $0.attributes.habitID == timer.attributes.habitID && ($0.activityState == .active || $0.activityState == .stale)
            }
            if let live {
                // Time added by hand while it runs moves the clock; otherwise leave it be.
                let old = live.content.state
                if abs(old.clockStart.timeIntervalSince(timer.state.clockStart)) > 1 || abs(old.goalAt.timeIntervalSince(timer.state.goalAt)) > 1 {
                    await live.update(content)
                }
            } else {
                #if DEBUG
                do {
                    _ = try Activity.request(attributes: timer.attributes, content: content, pushType: nil)
                    WidgetTiming.mark("live activity: started")
                } catch {
                    WidgetTiming.mark("live activity: couldn't start (\(error))")
                }
                #else
                _ = try? Activity.request(attributes: timer.attributes, content: content, pushType: nil)
                #endif
            }
        }
    }
}
