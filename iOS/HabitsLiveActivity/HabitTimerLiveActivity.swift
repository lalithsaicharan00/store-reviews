import ActivityKit
import AppIntents
import SwiftUI
import WidgetKit

@main
struct HabitsLiveActivityBundle: WidgetBundle {
    var body: some Widget {
        HabitTimerLiveActivity()
        ItemPhoneWidget()
        TodayPhoneWidget()
        WeekPhoneWidget()
        TasksPhoneWidget()
        LockTodayPhoneWidget()
    }
}

/// A running habit timer on the Lock Screen and in the Dynamic Island: the habit, a clock counting up
/// (today's total, not just this session), a bar filling to the goal and Pause, like the iPhone's own Clock timer.
/// Tapping it opens that habit's timer. It updates itself, with no notifications, and ends the moment the timer stops.
/// Research: "Timing a Habit — Start, See and Stop" (28 Sep), "Timers — What People Expect When They Tap ▶" (4 Oct).
struct HabitTimerLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: HabitTimerAttributes.self) { context in
            LockScreenTimer(attributes: context.attributes, state: context.state)
                .padding(16)
                .activityBackgroundTint(nil)
                .widgetURL(TimerLink.url(context.attributes.habitID))
        } dynamicIsland: { context in
            let color = TimerColor.named(context.attributes.color)
            return DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    TimerIcon(symbol: context.attributes.symbol, color: color, size: 40)
                        .padding(.leading, 4)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Clock(start: context.state.clockStart)
                        .font(.title2.weight(.semibold))
                        .frame(maxWidth: 110, alignment: .trailing)
                        .padding(.trailing, 4)
                }
                DynamicIslandExpandedRegion(.center) {
                    Text(context.attributes.name).font(.headline).lineLimit(1)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack(spacing: 12) {
                        GoalBar(state: context.state, color: color, label: context.attributes.goalLabel)
                        PauseButton(habitID: context.attributes.habitID, color: color)
                    }
                    .padding(.horizontal, 4)
                }
            } compactLeading: {
                Image(systemName: context.attributes.symbol)
                    .foregroundStyle(color)
            } compactTrailing: {
                Clock(start: context.state.clockStart)
                    .font(.caption.weight(.semibold))
                    .frame(maxWidth: 52)
            } minimal: {
                Image(systemName: context.attributes.symbol)
                    .foregroundStyle(color)
            }
            .widgetURL(TimerLink.url(context.attributes.habitID))
        }
    }
}

private struct LockScreenTimer: View {
    let attributes: HabitTimerAttributes
    let state: HabitTimerAttributes.ContentState

    var body: some View {
        let color = TimerColor.named(attributes.color)
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 12) {
                TimerIcon(symbol: attributes.symbol, color: color, size: 40)
                Text(attributes.name).font(.headline).lineLimit(1)
                Spacer(minLength: 8)
                Clock(start: state.clockStart)
                    .font(.title.weight(.semibold))
                    .frame(maxWidth: 140, alignment: .trailing)
            }
            HStack(spacing: 12) {
                GoalBar(state: state, color: color, label: attributes.goalLabel)
                PauseButton(habitID: attributes.habitID, color: color)
            }
        }
    }
}

/// Opens the app on that habit's timer (`oftenenough://timer/<id>`, handled in `HabitsApp`).
private enum TimerLink {
    static func url(_ habitID: String) -> URL? { URL(string: "oftenenough://timer/" + habitID) }
}

/// Stops the timer and saves its time without opening the app (`StopTimerIntent`), as the Clock timer's Pause does.
private struct PauseButton: View {
    let habitID: String
    let color: Color

    var body: some View {
        Button(intent: StopTimerIntent(habitID: habitID)) {
            Image(systemName: "pause.fill")
                .font(.body.weight(.semibold))
                .frame(width: 44, height: 44)
                .background(Circle().fill(color.opacity(0.25)))
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Pause timer")
    }
}

/// Counts up from the clock's start, drawn by the system every second without waking the app.
private struct Clock: View {
    let start: Date

    var body: some View {
        Text(timerInterval: start...Date.distantFuture, countsDown: false)
            .monospacedDigit()
            .multilineTextAlignment(.trailing)
    }
}

/// Fills to the goal as time passes, then stays full; the goal is written under it.
private struct GoalBar: View {
    let state: HabitTimerAttributes.ContentState
    let color: Color
    let label: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ProgressView(timerInterval: state.clockStart...max(state.goalAt, state.clockStart.addingTimeInterval(1)),
                         countsDown: false, label: { EmptyView() }, currentValueLabel: { EmptyView() })
                .tint(color)
            Text("Goal \(label)").font(.caption).foregroundStyle(.secondary)
        }
    }
}

private struct TimerIcon: View {
    let symbol: String
    let color: Color
    let size: CGFloat

    var body: some View {
        Image(systemName: symbol)
            .font(.system(size: size * 0.48, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: size, height: size)
            .background(RoundedRectangle(cornerRadius: size * 0.28, style: .continuous).fill(color.gradient))
    }
}

/// The app's habit colours (`HabitColor`), by name.
private enum TimerColor {
    static func named(_ name: String) -> Color {
        switch name {
        case "red": .red
        case "orange": .orange
        case "yellow": .yellow
        case "green": .green
        case "mint": .mint
        case "teal": .teal
        case "cyan": .cyan
        case "indigo": .indigo
        case "purple": .purple
        case "pink": .pink
        case "brown": .brown
        case "gray": .gray
        default: .blue
        }
    }
}
