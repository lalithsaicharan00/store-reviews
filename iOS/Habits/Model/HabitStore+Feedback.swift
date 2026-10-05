import Foundation

/// The completion sound and haptic (Current Work 18, the user, 5 Oct 2026): played once, at the moment a habit becomes
/// complete, whatever made it so. The last of 4 steps; the log that takes 9 glasses to 11 when the goal is 10 (a log
/// that only adds to a goal already reached plays nothing); typed time or an amount that crosses the goal, when Log or
/// Save is tapped; a running timer the moment its clock reaches the goal (or, if the app was away then, when it's
/// stopped). Never for quit habits or limits: reaching a number there isn't something to celebrate.
extension HabitStore {
    /// Quit habits and limits never play the completion: a slip, or a log toward a ceiling, isn't an achievement.
    func celebrates(_ habit: Habit, on day: LocalDay) -> Bool {
        !rule(habit, on: day).isQuitOrLimit
    }

    /// After a person's own log: the completion if this log made the habit complete, a light tap otherwise.
    /// `celebrated`: a timer whose goal moment already played it.
    func logFeedback(_ habit: Habit, on day: LocalDay, wasComplete: Bool, celebrated: Bool = false) {
        if let onLog {
            onLog(celebrates(habit, on: day) && !wasComplete && !celebrated && isComplete(habit, on: day))
        }
        if !timers.isEmpty { watchTimerGoals() }
    }

    /// Sleeps until the next running timer reaches its goal, then plays the completion: the moment the habit is done,
    /// as a kitchen timer would. One task for every timer, re-planned whenever timers or their habits' logs change.
    func watchTimerGoals(now: Date = .now) {
        timerGoalWatch?.cancel()
        timerGoalWatch = nil
        guard onLog != nil, !timers.isEmpty else { return }
        let day = today(now: now)
        var next: (id: UUID, at: Date)?
        for id in timers.keys where !timerGoalCelebrated.contains(id) {
            guard let habit = habits.first(where: { $0.id == id }), celebrates(habit, on: day), !isComplete(habit, on: day) else { continue }
            let left = goal(of: habit) - progress(of: habit, on: day, now: now)
            guard left > 0 else { continue }
            let at = now.addingTimeInterval(left * 60)
            if next.map({ at < $0.at }) ?? true { next = (id, at) }
        }
        guard let next else { return }
        timerGoalWatch = Task { [weak self] in
            // A moment past the goal, so the clock has surely reached it.
            try? await Task.sleep(for: .seconds(max(0, next.at.timeIntervalSinceNow) + 0.1))
            guard !Task.isCancelled, let self, self.timers[next.id] != nil else { return }
            // Woken late (the app was away when the goal passed): nothing now; stopping the timer plays it instead.
            if Date.now.timeIntervalSince(next.at) < 5,
               let habit = self.habits.first(where: { $0.id == next.id }), self.isComplete(habit, on: self.today()) {
                self.timerGoalCelebrated.insert(next.id)
                self.onLog?(true)
            }
            self.watchTimerGoals()
        }
    }
}
