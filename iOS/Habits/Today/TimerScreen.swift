import SwiftUI

/// One habit's timer, full screen (the user, 4 Oct 2026: "it just runs in the row… it isn't intuitive"; report
/// "Timers — What People Expect When They Tap ▶"). ▶ on Today starts the timer at once and opens this. It is never a
/// trap: swipe down or ✕ puts it away and the timer keeps running in its row, in the bar at the bottom of Today and on
/// the Lock Screen. Users show both sides: a big timer to focus on is asked for, a timer screen you can't leave is a
/// complaint. ≡ → Appearance → Timers turns the screen off (▶ then only starts the timer in the row).
struct TimerScreen: View {
    let habitID: UUID
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var showLog = false
    /// Day Details, from the button under the name: the same sheet a Today row opens, for today.
    @State private var showDay = false
    /// The timer ran when Log Time opened; it runs again when that sheet closes (as in the routine player).
    @State private var resumeAfterLog = false
    /// The part of the day the timer was started for, kept so Resume counts toward the same one.
    @State private var slot: String?

    private var habit: Habit? { store.habits.first { $0.id == habitID && !$0.archived } }

    // Figma's Timer screen (705:7745): a sheet of one height (no handle), "Timer" over the day it counts toward, ✕ to put
    // it away. The name, Day Details, the ring and "Paused" under it; Log Time | ⏸ at the bottom, as on Day details.
    var body: some View {
        NavigationStack {
            Group {
                if let habit { page(habit) } else {
                    ContentUnavailableView("This habit is no longer here", systemImage: "timer")
                }
            }
            .background(Color(.systemBackground))
            .navigationTitle("Timer")
            .timerSubtitle(habit.map(FocusProgressValue.period) ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    // Putting it away, not stopping: the name says so to VoiceOver too.
                    Button("Close", systemImage: "xmark") { dismiss() }
                        .accessibilityLabel(store.timers[habitID] == nil ? "Close" : "Close, the timer keeps running")
                        .accessibilityIdentifier("timer-screen-close")
                }
            }
        }
        .tint(.ink)
        .accessibilityIdentifier("timer-screen")
        .onAppear { slot = store.timerSlots[habitID] }
        .sheet(isPresented: $showLog, onDismiss: logFinished) {
            if let habit { AddLogView(habit: habit, day: store.today(), source: .manual) }
        }
        .sheet(isPresented: $showDay) {
            if let habit { DaySheet(habit: habit, day: store.today()) }
        }
    }

    private func page(_ habit: Habit) -> some View {
        let day = store.today()
        let running = store.timers[habit.id] != nil
        let started = store.progress(of: habit, on: day) > 0
        return GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer(minLength: 16)
                VStack(spacing: 8) {
                    Text(habit.name)
                        .font(.title2.weight(.semibold))
                        .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
                        .accessibilityAddTraits(.isHeader)
                        .accessibilityIdentifier("timer-screen-name")
                    DayDetailsButton { showDay = true }
                }
                .padding(.horizontal, 24)
                Spacer(minLength: 24).frame(maxHeight: 32)
                // Figma's Timer ring is 270 across; a narrow screen keeps 36 at each side.
                FocusClock(habit: habit, day: day, diameter: min(max(geometry.size.width - 72, 200), 270),
                           showsState: false) { openLog(habit) }
                // Always in its place, unseen while it runs, so Pause moves nothing.
                Text(started ? "Paused" : "Not started")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .padding(.top, 20)
                    .opacity(running ? 0 : 1)
                    .accessibilityHidden(running)
                    .accessibilityIdentifier("timer-screen-state")
                Spacer(minLength: 16)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 8) {
                DayButton("Log Time", id: "timer-screen-log") { openLog(habit) }
                // One main button, always in the same place: ⏸ while it runs, ▶ when it doesn't (the symbol alone,
                // Android A69); it stays Ink at the goal (the habit's colour there is Today's round button's alone).
                DayButton(running ? "Pause" : started ? "Resume" : "Start", prominent: true,
                          symbol: running ? "pause.fill" : "play.fill", id: "timer-screen-primary") {
                    toggle(habit, running: running)
                }
                .transaction { $0.animation = nil }
                .accessibilityLabel(running ? "Stop \(habit.name) timer" : "Start \(habit.name) timer")
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
        }
    }

    /// Pause saves the time as an entry (with Undo on Today), exactly as ⏸ on the row does; Resume adds a new session.
    private func toggle(_ habit: Habit, running: Bool) {
        if running {
            // Its tap, or the completion if this session reaches the goal, comes from the store (`HabitStore+Feedback`).
            store.toggleTimer(habit)
        } else {
            TimerPresence.askOnNextSync = true
            TickFeedback.started()
            store.toggleTimer(habit, slot: slot)
        }
    }

    /// Typing time pauses the timer first, so the same minutes are never counted twice; Cancel or Save runs it again.
    private func openLog(_ habit: Habit) {
        resumeAfterLog = store.timers[habit.id] != nil
        if resumeAfterLog { store.toggleTimer(habit) }
        showLog = true
    }

    private func logFinished() {
        guard resumeAfterLog, let habit, store.timers[habit.id] == nil else { resumeAfterLog = false; return }
        resumeAfterLog = false
        if !store.isComplete(habit, on: store.today()) || habit.atMost { store.toggleTimer(habit, slot: slot) }
    }
}

/// Figma's Day Details button: Small, Bordered, the calendar symbol, always the words "Day Details" (never Today or a
/// date). It sits in the page under the habit's name, never in the bar.
struct DayDetailsButton: View {
    let action: () -> Void

    var body: some View {
        Button("Day Details", systemImage: "calendar", action: action)
            .font(.subheadline)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .controlSize(.small)
            .tint(.ink)
            .accessibilityIdentifier("day-details-button")
    }
}

private extension View {
    /// The day the timer counts toward, under "Timer" (iOS 26's navigation subtitle; earlier iOS shows the title alone).
    @ViewBuilder func timerSubtitle(_ text: String) -> some View {
        if #available(iOS 26, *) { navigationSubtitle(text) } else { self }
    }
}
