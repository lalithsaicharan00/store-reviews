import Foundation

/// What Today shows on the Watch, worked out from the shared store the way the iPhone's Today works it out
/// (`TodayView.content`, `PartSection`): the same habits, sections, order and words (WA9, U13). Only today (WA5): the
/// Watch has no other days.
struct TodayPlan {
    struct Row: Identifiable, Equatable {
        let habit: Habit
        let placement: HabitStore.Placement?
        var id: String { (placement?.section ?? "quit") + habit.id.uuidString }
    }

    struct Section: Identifiable {
        /// A section ID, or `quitting` for Quit or Cut Down.
        let id: String
        let title: String
        let isNow: Bool
        let rows: [Row]
        /// "3 left": habits, not ticks (U10). Nil for Quit or Cut Down, where nothing is to do.
        let left: Int?
        var isQuitting: Bool { id == Self.quitting }
        static let quitting = "quitting"
    }

    let day: LocalDay
    let sections: [Section]
    /// Paused habits, folded at the end with when they come back (H6).
    let paused: [Habit]
    let done: Int
    let total: Int

    var isEmpty: Bool { sections.isEmpty && paused.isEmpty }

    /// A habit ticked per section is done here once this section's tick is; a skipped day counts as finished here
    /// (the iPhone's `PartSection.isDone`).
    static func isDone(_ row: Row, on day: LocalDay, store: HabitStore) -> Bool {
        if store.isSkipped(row.habit, on: day) { return true }
        return row.placement?.slot.map { store.isSlotDone(row.habit, slot: $0, on: day) } ?? store.isSatisfied(row.habit, on: day)
    }

    @MainActor
    static func make(_ store: HabitStore, now: Date = .now) -> TodayPlan {
        let today = store.today(now: now)
        let active = store.habits.filter { !$0.archived && store.startDay(of: $0) <= today }
        let restraint = active.filter { habit in
            habit.kind == .quit ? !store.isPaused(habit, on: today)
                : habit.isQuitOrLimit && store.isDue(habit, on: today, countingSkips: false)
        }
        let paused = active.filter { store.isPaused($0, on: today) }
        let tracked = active.filter { !$0.isQuitOrLimit && store.isDue($0, on: today, countingSkips: false) && !store.isPaused($0, on: today) }
        var bySection: [String: [Row]] = [:]
        for habit in tracked {
            for placement in store.placements(of: habit) {
                bySection[placement.section, default: []].append(Row(habit: habit, placement: placement))
            }
        }
        let nowID = store.nowSection(now: now)?.id
        var sections: [Section] = []
        for card in store.todayCards {
            if card == .quittingCard {
                let rows = restraint.filter { !store.isPaused($0, on: today) }.map { Row(habit: $0, placement: nil) }
                if !rows.isEmpty { sections.append(Section(id: Section.quitting, title: "Quitting", isNow: false, rows: rows, left: nil)) }
                continue
            }
            guard let rows = bySection[card], !rows.isEmpty else { continue }
            let left = rows.filter { !isDone($0, on: today, store: store) }.count
            sections.append(Section(id: card, title: store.section(card).name, isNow: card == nowID, rows: rows, left: left))
        }
        let summary = store.daySummary(on: today)
        return TodayPlan(day: today, sections: sections, paused: paused, done: summary.done, total: summary.total)
    }
}
