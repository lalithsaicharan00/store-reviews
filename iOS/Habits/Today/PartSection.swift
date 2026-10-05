import SwiftUI

/// One time of day on Today: its header and, while open, its rows (Build Plan #58, #59).
///
/// Its own view, reading only its own fold box and Today's hold: folding or opening this part redraws this part, not
/// every row of Today. Rows unfold from under the header in one short spring (`Motion.fold`), the chevron turning with
/// them; with Reduce Motion it's a fade. Done rows sink below the rest only after the person pauses (`TodayLayout`).
struct PartSection: View {
    let part: String
    let title: String
    let items: [TodayView.TodayItem]
    let day: LocalDay
    let isToday: Bool
    let isNow: Bool
    /// Done habits go below the rest (≡ → Appearance → Done Habits; the default).
    let doneLast: Bool
    /// The Filter's "Hide Completed Habits" and "Hide Completed Tasks" (the user, 3 Oct 2026). Done rows go only when
    /// Today settles, like done rows sinking, so nothing vanishes under a finger (Rulebook U4).
    let hideDoneHabits: Bool
    let hideDoneTasks: Bool
    let highlighted: String?
    let onStart: () -> Void
    /// Opens Arrange Your Day (touch and hold on the header: a shortcut, never the only way in).
    let onArrange: () -> Void
    let visibleRows: VisibleRows
    @Environment(HabitStore.self) private var store
    @Environment(TodayLayout.self) private var layout
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    /// A habit ticked per section is done here once this section's tick is.
    /// A skipped day counts as finished here: not "left", and it settles with the done rows.
    static func isDone(_ item: TodayView.TodayItem, on day: LocalDay, store: HabitStore) -> Bool {
        if store.isSkipped(item.habit, on: day) { return true }
        return item.placement.slot.map { store.isSlotDone(item.habit, slot: $0, on: day) } ?? store.isSatisfied(item.habit, on: day)
    }

    var body: some View {
        let done = Dictionary(items.map { ($0.id, Self.isDone($0, on: day, store: store)) }, uniquingKeysWith: { a, _ in a })
        let left = done.values.filter { !$0 }.count
        // Default: the Now part and Anytime are open while anything is left; finished parts fold (after the pause).
        let open = layout.isOpen(part, rule: left > 0 && (isNow || part == .anytime || !isToday))
        // Done habits sink to the bottom, keeping their order otherwise. The row just logged stays put while it offers
        // "Add note" (or its note is being written), so the offer is where the person is looking.
        let held = store.noteOffer.flatMap { $0.day == day ? $0.habit : nil }
        let hides = hideDoneHabits || hideDoneTasks
        let shown = !hides || layout.holding ? items : items.filter { item in
            done[item.id] != true || item.habit.id == held || !(item.habit.kind == .task ? hideDoneTasks : hideDoneHabits)
        }
        let fresh = doneLast
            ? shown.filter { done[$0.id] != true || $0.habit.id == held } + shown.filter { done[$0.id] == true && $0.habit.id != held }
            : shown
        let ordered = layout.order(part, fresh: fresh)
        Section {
            PartHeader(title: title, habits: items.map(\.habit), left: left, isNow: isNow, isOpen: open,
                       onStart: isToday && items.contains(where: { done[$0.id] != true }) ? onStart : nil,
                       onToggle: { layout.setOpen(part, !open, reduceMotion: reduceMotion) },
                       subtitle: store.section(part).start.map(DaySection.startsText))
                .id(TodayView.headerKey(part))
                .contextMenu {
                    Button("Arrange Your Day", systemImage: "arrow.up.arrow.down", action: onArrange)
                    Button(open ? "Fold" : "Open", systemImage: open ? "chevron.up" : "chevron.down") {
                        layout.setOpen(part, !open, reduceMotion: reduceMotion)
                    }
                }
            if open {
                ForEach(ordered) { item in
                    let habit = item.habit
                    let key = TodayView.rowKey(part, habit.id)
                    let steps = layout.steps(habit.id)
                    HabitRow(habit: habit, day: day, isToday: isToday, slot: item.placement.slot,
                             time: item.placement.times.first, highlighted: highlighted == key, steps: steps)
                        .id(key)
                        .onAppear { visibleRows.show(key) }
                        .onDisappear { visibleRows.hide(key) }
                    if habit.kind == .checklist && steps.open == true {
                        ForEach(habit.steps) { StepRow(step: $0, habit: habit, day: day) }
                    }
                }
            }
        }
    }
}
