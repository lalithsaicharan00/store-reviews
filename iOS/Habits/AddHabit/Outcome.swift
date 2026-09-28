import Foundation

/// The live sentences under the form's Time of Day and Reminders groups: what will happen, in plain
/// words, before the user taps Add. Built from a draft habit with the same rules Today and the
/// reminders use, so the form can't promise something the app won't do.
enum Outcome {
    /// Where it shows on Today, and for week, month and year rules, until when.
    static func timeOfDay(_ habit: Habit, store: HabitStore) -> String {
        if case .flexible(let period, let n) = habit.frequency {
            return "Reach the daily goal on \(n) different days each \(period.noun). You can still log extra days after reaching it."
        }
        let placements = store.placements(of: habit)
        let names = placements.map { store.section($0.section).name }
        var sentence: String
        if placements.count >= 2 {
            // The same row in each part, one shared progress: the goal isn't split.
            sentence = "It shows in \(list(names)). It's one \(habit.kind == .task ? "task" : "habit"): do it in any of them."
        } else {
            let section = store.section(placements.first?.section ?? .anytime)
            if let hours = hours(section, store: store) {
                sentence = "It shows in \(section.name) on Today (\(hours))."
            } else {
                sentence = "It shows in Anytime on Today, so you can do it whenever suits you."
            }
        }
        if let until = periodRule(habit) { sentence += " It stays on Today every day until " + until + "." }
        return sentence
    }

    /// What the phone will do, and when it stops.
    static func reminders(_ habit: Habit, store: HabitStore, alarmsAvailable: Bool) -> String {
        guard habit.remind && !habit.reminders.isEmpty else {
            return "No notifications. You'll see it on Today."
        }
        let alarm = habit.alert == .alarm && alarmsAvailable
        let word = alarm ? "An alarm" : "A notification"
        let times = habit.reminders.sorted { store.dayMinute($0.minuteOfDay) < store.dayMinute($1.minuteOfDay) }
        let at = "at " + list(times.map { DaySection.clock($0.minuteOfDay) })
        var sentence: String
        if habit.atMost {
            sentence = "\(word) \(at) each day it's due."
        } else if habit.kind == .task {
            sentence = "\(word) \(at) on the day. None once it's done."
        } else if let until = periodRule(habit, forReminders: true) {
            sentence = "\(word) \(at) each day until \(until)."
        } else {
            let ticks = !store.slots(of: habit).isEmpty
            sentence = "\(word) \(at) on days it's due. " + (ticks ? "None for a part of the day you've already finished." : "None once it's done for the day.")
        }
        if alarm {
            sentence += " It rings even on silent, until you stop it. Stopping it doesn't tick the habit; its Done button does."
        }
        if let every = habit.followUpMinutes, !habit.atMost {
            sentence += " If it isn't done, it reminds you again every \(every == 60 ? "hour" : "\(every) min"), up to \(ReminderScheduler.maxFollowUps) times."
        }
        // A reminder in another part of the day is allowed, but say so, so it isn't a surprise.
        let shown = Set(store.placements(of: habit).map(\.section))
        if !shown.contains(.anytime) {
            let outside = times.filter { !shown.contains(store.section(forMinute: $0.minuteOfDay).id) }
            if let first = outside.first {
                let part = store.section(forMinute: first.minuteOfDay).name
                sentence += " Note: \(DaySection.clock(first.minuteOfDay)) is in the \(part), but the habit shows in \(list(shown.sorted { a, b in (store.sections.firstIndex { $0.id == a } ?? 0) < (store.sections.firstIndex { $0.id == b } ?? 0) }.map { store.section($0).name }))."
            }
        }
        return sentence
    }

    /// "Thursday 2 Oct" when a set schedule isn't due today, so a habit missing from Today isn't a surprise.
    static func firstDue(_ habit: Habit, store: HabitStore) -> String? {
        let today = store.today()
        guard !store.isDue(habit, on: today) else { return nil }
        for offset in 1...400 {
            let day = today.adding(days: offset, calendar: store.calendar)
            if store.isDue(habit, on: day) {
                let date = day.date(calendar: store.calendar).formatted(.dateTime.weekday(.wide).day().month(.abbreviated))
                return offset == 1 ? "tomorrow, \(date)" : date
            }
        }
        return nil
    }

    /// Week, month and year rules: "you've done it 3 times this week", "you reach 180 min this week";
    /// for reminders, "the week's 3 are done". Nil for set schedules and limits.
    private static func periodRule(_ habit: Habit, forReminders: Bool = false) -> String? {
        if case .flexible(let period, let n) = habit.frequency {
            return "you reach the daily goal on \(n) different days this \(period.noun)"
        }
        let n: Int, period: String
        switch habit.frequency {
        case .perWeek(let k): n = k; period = "week"
        case .perMonth(let k): n = k; period = "month"
        case .perYear(let k): n = k; period = "year"
        default: return nil
        }
        guard !habit.atMost else { return nil }
        switch habit.kind {
        case .amount(let unit, _): return "you reach \(Format.amount(habit.goal)) \(unit) this \(period)"
        case .duration: return "you reach \(Format.amount(habit.goal)) min this \(period)"
        default: break
        }
        if forReminders { return n == 1 ? "it's done this \(period)" : "this \(period)'s \(n) are done" }
        return "you've done it \(n == 1 ? "once" : "\(n) times") this \(period)"
    }

    static func hours(_ section: DaySection, store: HabitStore) -> String? {
        guard let start = section.start,
              let end = store.timedSections.first(where: { $0.section.id == section.id })?.end else { return nil }
        return "\(DaySection.clock(start))–\(DaySection.clock(end))"
    }

    /// "Morning and Evening", "9:00 AM, 12:00 PM and 3:00 PM", in the phone's language.
    static func list(_ items: [String]) -> String {
        items.formatted(.list(type: .and))
    }
}
