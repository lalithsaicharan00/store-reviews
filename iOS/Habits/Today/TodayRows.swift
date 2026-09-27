import SwiftUI

/// "3/8 glasses", "12/20 min", "2/3 this week", "1/4 items", "0/2 cups max": one format for every habit.
func goalLine(_ habit: Habit, progress: Double, goal: Double) -> String {
    let unit: String
    switch habit.kind {
    case .amount(let u, _): unit = " " + u
    case .duration: unit = " min"
    case .checklist: unit = " items"
    case .check, .quit, .task: unit = ""
    }
    let shown = habit.kind == .duration ? progress.rounded(.down) : progress
    let period = switch habit.frequency {
    case .perWeek: " this week"
    case .perMonth: " this month"
    case .perYear: " this year"
    default: ""
    }
    let max = habit.atMost ? " max" : ""
    return "\(Format.amount(shown))/\(Format.amount(goal))\(unit)\(max)\(period)"
}

/// One-time tasks: the time if set, and where it came from if it moved forward.
func taskLine(_ habit: Habit, shownOn day: LocalDay, calendar: Calendar) -> String {
    var parts: [String] = []
    if let due = habit.dueDay, due < day {
        parts.append("From " + due.date(calendar: calendar).formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)))
    }
    if let minute = habit.dueMinute {
        let time = calendar.date(bySettingHour: minute / 60, minute: minute % 60, second: 0, of: .now)!
        parts.append(time.formatted(date: .omitted, time: .shortened))
    }
    return parts.isEmpty ? "Task" : parts.joined(separator: " · ")
}

struct HabitRow: View {
    /// Names on Today show this many characters, then "…", so every row stays on one line.
    static let nameShown = 15
    let habit: Habit
    let day: LocalDay
    let isToday: Bool
    /// For a habit in several day sections: the section this row ticks.
    var slot: String? = nil
    @Binding var stepsOpen: Bool
    @Environment(HabitStore.self) private var store

    var body: some View {
        let progress = store.progress(of: habit, on: day)
        let goal = store.goal(of: habit)
        // A cut-back habit is "met" while under its maximum, but never shown as finished.
        let done = slot.map { store.isSlotDone(habit, slot: $0, on: day) } ?? (store.isDone(habit, on: day) && !habit.atMost)
        let streak = store.streak(of: habit, asOf: day)
        HStack(spacing: 12) {
            HabitIcon(symbol: habit.symbol, color: habit.color)
            VStack(alignment: .leading, spacing: 1) {
                // One line always: names show 15 characters, then "…".
                Text(habit.name.capped(HabitRow.nameShown)).font(.body).foregroundStyle(done ? .secondary : .primary).lineLimit(1)
                    .accessibilityLabel(habit.name) // VoiceOver reads it in full
                Text(habit.kind == .task ? taskLine(habit, shownOn: day, calendar: store.calendar) : goalLine(habit, progress: progress, goal: goal))
                    .font(.subheadline).foregroundStyle(.secondary)
                    .monospacedDigit()
                    .lineLimit(1)
            }
            Spacer(minLength: 8)
            if streak > 0 { StreakLabel(count: streak, unit: habit.frequency.streakUnit, onFill: progress / max(goal, 1) >= 0.7) }
            actionButton(done: done)
                .disabled(habit.kind != .checklist && day > store.today())
        }
        // The same spacing as the Quitting rows.
        .padding(.vertical, 2)
        .listRowBackground(ProgressFill(progress: progress / max(goal, 1), color: habit.color))
    }

    @ViewBuilder
    private func actionButton(done: Bool) -> some View {
        if habit.kind == .checklist {
            // The button opens and closes the items; the checklist is done when every item is.
            RoundActionButton(symbol: stepsOpen ? "chevron.up" : "chevron.down", done: done, color: habit.color,
                              label: stepsOpen ? "Hide \(habit.name) items" : "Show \(habit.name) items") {
                withAnimation { stepsOpen.toggle() }
            }
        } else {
            switch habit.kind {
            case .check, .task:
                RoundActionButton(symbol: "checkmark", done: done, color: habit.color,
                                  label: done ? "Undo \(habit.name)" : "Mark \(habit.name) done") {
                    withAnimation {
                        if let slot { store.toggleSlot(habit, slot: slot, on: day) } else { store.toggleCheck(habit, on: day) }
                    }
                }
            case .amount(_, let increment):
                RoundActionButton(symbol: "plus", done: done, color: habit.color,
                                  label: done ? "Undo last \(habit.name)" : "Add \(Format.amount(increment)) to \(habit.name)") {
                    withAnimation { store.increment(habit, on: day) }
                }
            case .duration:
                let running = store.timers[habit.id] != nil
                RoundActionButton(symbol: running ? "pause.fill" : "play.fill", done: done && !running, color: habit.color,
                                  label: running ? "Stop \(habit.name) timer" : "Start \(habit.name) timer") {
                    withAnimation { store.toggleTimer(habit) }
                }
                .disabled(!isToday)
            case .quit, .checklist:
                EmptyView()
            }
        }
    }
}

struct StepRow: View {
    let step: Step
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store

    var body: some View {
        let done = store.isStepDone(step, of: habit, on: day)
        HStack(spacing: 12) {
            Text(step.name.capped(HabitRow.nameShown)).font(.subheadline).foregroundStyle(done ? .secondary : .primary).lineLimit(1)
                .accessibilityLabel(step.name)
            Spacer(minLength: 8)
            RoundActionButton(symbol: "checkmark", done: done, color: habit.color,
                              label: done ? "Undo \(step.name)" : "Mark \(step.name) done") {
                withAnimation { store.toggleStep(step, of: habit, on: day) }
            }
        }
        .disabled(day > store.today())
        .padding(.leading, 44)
        .padding(.vertical, -6)
    }
}

struct QuitRow: View {
    let habit: Habit
    @Environment(HabitStore.self) private var store

    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { context in
            let runs = store.quitRuns(of: habit, now: context.date)
            HStack(spacing: 12) {
                HabitIcon(symbol: habit.symbol, color: habit.color)
                VStack(alignment: .leading, spacing: 1) {
                    Text(habit.name.capped(HabitRow.nameShown)).font(.body).lineLimit(1).accessibilityLabel(habit.name)
                    Text("Best \(Format.days(runs.best))").font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
                }
                Spacer(minLength: 8)
                Text(Format.elapsed(runs.current))
                    .font(.body.monospacedDigit().weight(.semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .fixedSize()
            }
            .padding(.vertical, 2)
            .accessibilityElement(children: .combine)
        }
    }
}

/// The first row of every card: name, Now, folded icons, status (or Start) and the fold chevron.
///
/// Space goes, in order of importance: Start and the status never shrink. Folded, the name shows at
/// most 8 letters and the icons take the rest; open, the name gets whatever is left and ends in "…".
struct PartHeader: View {
    let title: String
    let habits: [Habit]
    /// Habits still to do; nil for the Quitting card, which has no status.
    let left: Int?
    let isNow: Bool
    let isOpen: Bool
    let onStart: (() -> Void)?
    let onToggle: () -> Void

    /// The width for the name, Now and the icons, and the name's full one-line width.
    @State private var room: CGFloat = 0
    @State private var titleWidth: CGFloat = 0

    /// At least this much space between the icons and "2 left" / "All done".
    static let statusGap: CGFloat = 24

    /// Starting a routine is independent of disclosure and the preferred time window.
    private var showsStart: Bool { (left ?? 0) > 0 && onStart != nil }

    private var iconCount: Int? {
        guard !isOpen, room > 0 else { return nil }
        let now: CGFloat = isNow ? 52 : 0
        return FoldedIcons.fitting(habits.count, in: room - now - titleWidth - 10)
    }

    /// Folded, the name shows at most 8 letters and "…", so the icons get the room.
    /// (A 9-letter name, like Afternoon, is shown whole: "Afternoo…" would be no shorter.)
    private var shownTitle: String {
        guard !isOpen, title.count > 9 else { return title }
        return title.prefix(8).trimmingCharacters(in: .whitespaces) + "…"
    }

    private var status: String? {
        guard let left else { return nil }
        return left == 0 ? "All done" : "\(left) left"
    }

    var body: some View {
        HStack(spacing: Self.statusGap) {
            titleArea
            controls
        }
        .frame(minHeight: 44)
    }

    private var titleArea: some View {
            HStack(spacing: 8) {
                Text(shownTitle).font(.headline).lineLimit(1)
                    .background {
                        Text(shownTitle).font(.headline).lineLimit(1).fixedSize().hidden()
                            .onGeometryChange(for: CGFloat.self) { $0.size.width } action: { titleWidth = $0 }
                    }
                if isNow { NowChip().fixedSize() }
                if let count = iconCount { FoldedIcons(habits: habits, max: count).fixedSize().padding(.leading, 2) }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .onGeometryChange(for: CGFloat.self) { $0.size.width } action: { room = $0 }
            // VoiceOver reads the header as one button; Start stays its own button.
            .accessibilityElement(children: .ignore)
            .accessibilityLabel([title, isNow ? "Now" : nil, status ?? "\(habits.count) habits"].compactMap { $0 }.joined(separator: ", "))
            .accessibilityValue(isOpen ? "Open" : "Folded")
            .accessibilityAddTraits(.isButton)
            .accessibilityHint(isOpen ? "Folds this part" : "Opens this part")
            .contentShape(Rectangle())
            .onTapGesture(perform: onToggle)
            .accessibilityAction { onToggle() }

    }

    private var controls: some View {
            HStack(spacing: 4) {
                if showsStart, let onStart {
                    Button(action: onStart) {
                        Image(systemName: "play.fill")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(Color.ink)
                            .frame(width: 34, height: 34)
                            .background(Circle().fill(isNow ? Color(.systemBackground) : Color(.tertiarySystemFill)))
                            .overlay(Circle().strokeBorder(Color.ink.opacity(isNow ? 0.18 : 0), lineWidth: 1))
                            .shadow(color: .black.opacity(isNow ? 0.1 : 0), radius: 2, y: 1)
                            .frame(width: 44, height: 44)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Start \(title) routine")
                    .accessibilityHint("Opens unfinished habits, one at a time")
                } else if left == 0 {
                    HStack(spacing: 4) { Image(systemName: "checkmark"); Text("All done") }
                        .font(.subheadline.weight(.medium)).foregroundStyle(.secondary)
                        .accessibilityHidden(true)
                } else if let status {
                    Text(status).font(.subheadline).foregroundStyle(.secondary).accessibilityHidden(true)
                }
                Button(action: onToggle) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .rotationEffect(.degrees(isOpen ? 90 : 0))
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .padding(.trailing, -12)
                .accessibilityLabel("\(isOpen ? "Fold" : "Open") \(title)")
            }
            .lineLimit(1)
            // Never squeezed: the name gives way instead.
            .fixedSize()
    }

}

struct FoldedIcons: View {
    let habits: [Habit]
    var max = 4

    /// Each icon, and the "+N" square, is 22 pt plus 4 pt spacing.
    private static let step: CGFloat = 26

    /// How many icons fit in `width`, leaving room for a "+N" square for the rest; nil when not even that fits.
    static func fitting(_ count: Int, in width: CGFloat, limit: Int = 6) -> Int? {
        for n in stride(from: min(limit, count), through: 0, by: -1) {
            let squares = CGFloat(n + (count > n ? 1 : 0))
            if squares * step - 4 <= width + 1 { return n } // 1 pt for rounding
        }
        return nil
    }

    var body: some View {
        HStack(spacing: 4) {
            ForEach(habits.prefix(max)) { HabitIcon(symbol: $0.symbol, color: $0.color, size: 22) }
            if habits.count > max {
                // The rest, as a square the same shape as the icons.
                Text("+\(habits.count - max)")
                    .font(.system(size: 11, weight: .bold).monospacedDigit())
                    .foregroundStyle(.secondary)
                    .lineLimit(1).fixedSize()
                    .padding(.horizontal, 2)
                    .frame(minWidth: 22, minHeight: 22)
                    .background(RoundedRectangle(cornerRadius: 22 * 0.28, style: .continuous).fill(Color(.tertiarySystemFill)))
            }
        }
    }
}
