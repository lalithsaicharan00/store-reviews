import SwiftUI
import WatchKit

/// One Today row on the Watch (A1–A3, H1, H5, H6, H9): the habit's icon, name and the iPhone's own line under it, a fill
/// in the habit's colour as far as today has got, and the round button that does what Today's does (U14, WA6). Tapping
/// the row opens the habit's Day details; tapping the button logs.
struct WatchRow: View {
    let row: TodayPlan.Row
    let day: LocalDay
    let open: () -> Void
    /// Tells Today a tap happened, so nothing moves until the person pauses (U4).
    let tapped: () -> Void
    @Environment(HabitStore.self) private var store
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.dynamicTypeSize) private var textSize

    private var habit: Habit { row.habit }

    var body: some View {
        let ruled = store.rule(habit, on: day)
        let progress = store.dayProgress(of: ruled, on: day)
        let goal = store.dayGoal(of: ruled)
        let running = store.timers[habit.id] != nil
        let done = TodayPlan.isDone(row, on: day, store: store) && !store.isSkipped(habit, on: day)
        let fraction = fillFraction(ruled, progress: progress, goal: goal, done: done)
        VStack(alignment: .leading, spacing: 6) {
            if textSize.isAccessibilitySize {
                // Larger text (H20): the icon and the round button share the top line and the name and its line get
                // the row's whole width, wrapping, never cut. Chosen from the text size, never ViewThatFits (S10).
                HStack(spacing: 8) {
                    icon
                    Spacer(minLength: 4)
                    button(ruled, done: done, running: running)
                }
                words(progress: progress, goal: goal, running: running, lines: nil)
            } else {
                HStack(spacing: 8) {
                    icon
                    words(progress: progress, goal: goal, running: running, lines: 2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    button(ruled, done: done, running: running)
                }
            }
            after
        }
        .padding(.vertical, 6)
        .padding(.leading, 2)
        .contentShape(Rectangle())
        .onTapGesture(perform: open)
        .accessibilityElement(children: .contain)
        .accessibilityAction(named: "Open \(habit.name)", open)
        .listRowBackground(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(WatchPalette.platter)
                .overlay {
                    // A transform, never a geometry pass (S10): the colour layer is the row's width, scaled from the left.
                    Rectangle()
                        .fill(habit.isQuitOrLimit ? WatchPalette.limitFill : habit.color.watchFill)
                        .scaleEffect(x: fraction, y: 1, anchor: .leading)
                }
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        )
        .accessibilityIdentifier("row-\(habit.name)")
    }

    private var icon: some View {
        Image(systemName: habit.symbol)
            .font(.system(size: 17, weight: .semibold))
            .foregroundStyle(store.isSkipped(habit, on: day) ? Color.secondary : habit.color.watchColor)
            .frame(width: 24)
            .accessibilityHidden(true)
    }

    private func words(progress: Double, goal: Double, running: Bool, lines: Int?) -> some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(habit.name)
                .font(.body)
                .lineLimit(lines)
            line(progress: progress, goal: goal, running: running)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .lineLimit(lines)
        }
        .fixedSize(horizontal: false, vertical: lines == nil)
    }

    /// The share of the row filled: today's goal, or the period's for a week or month goal (U25); nothing for a quit habit.
    private func fillFraction(_ ruled: Habit, progress: Double, goal: Double, done: Bool) -> Double {
        if habit.kind == .quit || store.isSkipped(habit, on: day) { return 0 }
        if done { return 1 }
        if !ruled.frequency.isDayBased {
            let period = store.progress(of: habit, on: day), whole = store.goal(of: habit)
            return whole > 0 ? min(1, period / whole) : 0
        }
        return goal > 0 ? min(1, progress / goal) : 0
    }

    @ViewBuilder
    private func line(progress: Double, goal: Double, running: Bool) -> some View {
        if habit.kind == .quit {
            QuitRunText(habit: habit)
        } else if running, let start = store.timers[habit.id] {
            // The running clock from its start time (WA10), drawn by the system: nothing else redraws.
            Text(timerInterval: start...Date.distantFuture, countsDown: false)
                + Text("/" + Format.minutes(goal))
        } else {
            Text(store.rowLine(habit, on: day, slot: row.placement?.slot, time: nil, progress: progress, goal: goal, running: false))
        }
    }

    /// "Undo +1 glass" right under the row just logged, naming what it takes back (U14, WA7); a milestone beside it (H9).
    @ViewBuilder
    private var after: some View {
        if let offer = store.undoOffer, offer.habitID == habit.id, offer.day == day {
            VStack(alignment: .leading, spacing: 4) {
                if let mark = store.milestoneOffer, mark.entry == offer.id {
                    Text(mark.text).font(.footnote.weight(.semibold))
                        .accessibilityIdentifier("milestone")
                }
                Button(offer.undoLabel(for: store.rule(habit, on: day))) {
                    tapped()
                    WKInterfaceDevice.current().play(.click)
                    store.undoEntry(offer.id)
                }
                .font(.footnote.weight(.semibold))
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .controlSize(.small)
                .fixedSize()
                .accessibilityIdentifier("undo")
            }
            .padding(.leading, 32)
        }
    }

    // MARK: The round button

    @ViewBuilder
    private func button(_ ruled: Habit, done reached: Bool, running: Bool) -> some View {
        // A limit's button never takes the completed treatment: staying under a limit isn't an action to reward, and
        // a filled button would invite the next +1 (U2, U25, H1).
        let done = reached && !ruled.isQuitOrLimit
        switch ruled.kind {
        case .check where row.placement?.slot == nil && store.countsUp(habit, on: day):
            RoundButton(symbol: "checkmark", done: done, color: habit.color, label: "Add 1 to \(habit.name)") {
                log { store.addProgress(habit, value: 1, on: day, source: .watch) }
            }
        case .check, .task:
            let ticked = row.placement?.slot.map { store.isSlotDone(habit, slot: $0, on: day) }
                ?? (habit.kind == .task ? done : store.isTicked(habit, on: day))
            RoundButton(symbol: "checkmark", done: ticked, color: habit.color,
                        label: ticked ? "Undo \(habit.name)" : "Mark \(habit.name) done") {
                log {
                    if let slot = row.placement?.slot { store.toggleSlot(habit, slot: slot, on: day, source: .watch) }
                    else { store.toggleCheck(habit, on: day, source: .watch) }
                }
            }
            .disabled(store.isSkipped(habit, on: day))
        case .amount(let unit, _):
            if let step = habit.quickIncrement {
                RoundButton(text: "+" + Format.amount(step), done: done, color: habit.color,
                            label: "Add \(HabitCopy.amount(step, unit)) to \(habit.name)") {
                    log { store.increment(habit, on: day, source: .watch) }
                }
            } else {
                // An amount that asks how much: the row's button opens Day details to type it (B16).
                RoundButton(symbol: "plus", done: done, color: habit.color, label: "Log an amount for \(habit.name)", action: open)
            }
        case .duration:
            RoundButton(symbol: running ? "pause.fill" : "play.fill", done: done && !running, color: habit.color,
                        label: running ? "Stop \(habit.name) timer" : "Start \(habit.name) timer") {
                log {
                    if store.timers[habit.id] != nil { store.stopTimer(habit, on: day, source: .watch) }
                    else { store.startTimerOnWatch(habit, slot: row.placement?.slot) }
                }
            }
        case .checklist:
            // The steps are on Day details, one tap each (B9).
            RoundButton(symbol: "list.bullet", done: done, color: habit.color, label: "Show \(habit.name) steps", action: open)
        case .quit:
            RoundButton(symbol: "arrow.up.right", done: false, color: habit.color, label: "Open \(habit.name)", action: open)
        }
    }

    /// Every log from the row's button: Today holds still (U4), the write follows the screen (S7). The haptic comes from
    /// the store's answer (a click, or success when the goal is met), set up in `WatchApp`.
    private func log(_ change: () -> Void) {
        tapped()
        if reduceMotion { change() } else { withAnimation(.snappy(duration: 0.25)) { change() } }
    }
}

/// The round button every row ends with (A2): grey until done, then filled in the habit's colour with white content.
struct RoundButton: View {
    var symbol: String? = nil
    var text: String? = nil
    let done: Bool
    let color: HabitColor
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Group {
                if let text {
                    Text(text).font(.system(size: 15, weight: .bold).monospacedDigit()).minimumScaleFactor(0.6).lineLimit(1)
                } else if let symbol {
                    Image(systemName: done && symbol == "checkmark" ? "checkmark" : symbol)
                        .font(.system(size: 16, weight: .bold))
                }
            }
            .foregroundStyle(.white)
            .frame(width: 40, height: 40)
            .background(Circle().fill(done ? color.watchColor : Color.white.opacity(0.2)))
        }
        .buttonStyle(.plain)
        .frame(width: 44, height: 44)
        .contentShape(Circle())
        .accessibilityLabel(label)
        .accessibilityIdentifier("button-\(label)")
    }
}

/// A quit habit's current run, "15 d 22 h" (A2, U25). Only this text moves (S3): it sleeps until the next minute.
struct QuitRunText: View {
    let habit: Habit
    @Environment(HabitStore.self) private var store
    @State private var now = Date.now

    var body: some View {
        // `now` only moves the text each minute; the run is counted to the store's clock (D7), never to an earlier
        // moment than a slip just recorded.
        Text(RunWords.short(store.quitRuns(of: habit, now: max(now, store.clock())).current))
            .task(id: now) {
                let wait = 60 - now.timeIntervalSince1970.truncatingRemainder(dividingBy: 60)
                try? await Task.sleep(for: .seconds(wait))
                now = .now
            }
    }
}
