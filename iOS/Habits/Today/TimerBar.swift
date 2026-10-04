import SwiftUI

/// A running timer whose row isn't on screen (scrolled away, or in a folded section): its icon, name
/// and live clock, pinned at the bottom of Today like the iPhone's Now Playing bar. Tapping it opens the timer full
/// screen (`TimerScreen`); ⏸ stops and saves. Research: "Timing a Habit — Start, See and Stop" (28 Sep) and "Timers —
/// What People Expect When They Tap ▶" (4 Oct): people want to see the timer while they do other things.
struct TimerBar: View {
    let habit: Habit
    let start: Date
    let onShow: () -> Void
    @Environment(HabitStore.self) private var store

    var body: some View {
        TimelineView(.periodic(from: start, by: 1)) { context in
            let progress = store.progress(of: habit, on: store.today(now: context.date), now: context.date)
            let line = goalLine(habit, progress: progress, goal: store.goal(of: habit), running: true)
            HStack(spacing: 12) {
                Button(action: onShow) {
                    HStack(spacing: 12) {
                        HabitIcon(symbol: habit.symbol, color: habit.color, size: 30)
                        VStack(alignment: .leading, spacing: 1) {
                            Text(habit.name.capped(HabitRow.nameShown)).font(.subheadline.weight(.semibold)).lineLimit(1)
                            Text(line).font(.subheadline).monospacedDigit().lineLimit(1)
                        }
                        Spacer(minLength: 8)
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("\(habit.name) timer, \(line)")
                .accessibilityHint("Opens the timer")
                .accessibilityIdentifier("timer-bar")
                RoundActionButton(symbol: "pause.fill", done: false, color: habit.color, label: "Stop \(habit.name) timer") {
                    withAnimation { store.toggleTimer(habit) }
                }
                .accessibilityIdentifier("timer-bar-stop")
            }
            .padding(.leading, 12)
            .padding(.trailing, 4)
            .padding(.vertical, 4)
            // The shadow is the shape's, not the whole bar's: this redraws every second, and a shadow over text and
            // material is an offscreen pass each time (30 Sep).
            .background {
                RoundedRectangle(cornerRadius: 20, style: .continuous).fill(.regularMaterial)
                    .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
            }
            .padding(.horizontal, 16)
        }
    }
}
