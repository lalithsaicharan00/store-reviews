import SwiftUI

/// One habit's timer, full screen (the user, 4 Oct 2026: "it just runs in the row… it isn't intuitive"; report
/// "Timers — What People Expect When They Tap ▶"). ▶ on Today starts the timer at once and opens this. It is never a
/// trap: swipe down or ⌄ puts it away and the timer keeps running in its row, in the bar at the bottom of Today and on
/// the Lock Screen. Users show both sides: a big timer to focus on is asked for, a timer screen you can't leave is a
/// complaint. ≡ → Appearance → Timers turns the screen off (▶ then only starts the timer in the row).
struct TimerScreen: View {
    let habitID: UUID
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @ScaledMetric(relativeTo: .title) private var numberSize = 36.0
    @ScaledMetric(relativeTo: .body) private var actionWidth = 240.0
    @ScaledMetric(relativeTo: .body) private var buttonGap = 16.0
    @State private var showLog = false
    /// The timer ran when Log Time Manually opened; it runs again when that sheet closes (as in the routine player).
    @State private var resumeAfterLog = false
    /// The part of the day the timer was started for, kept so Resume counts toward the same one.
    @State private var slot: String?

    private var habit: Habit? { store.habits.first { $0.id == habitID && !$0.archived } }

    var body: some View {
        NavigationStack {
            Group {
                if let habit { page(habit) } else {
                    ContentUnavailableView("This habit is no longer here", systemImage: "timer")
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    // Putting it away, not stopping: the name says so to VoiceOver too.
                    Button { dismiss() } label: { Label("Close", systemImage: "chevron.down") }
                        .accessibilityLabel(store.timers[habitID] == nil ? "Close" : "Close, the timer keeps running")
                        .accessibilityIdentifier("timer-screen-close")
                }
            }
        }
        .tint(.ink)
        .presentationDragIndicator(.visible)
        .accessibilityIdentifier("timer-screen")
        .onAppear { slot = store.timerSlots[habitID] }
        .sheet(isPresented: $showLog, onDismiss: logFinished) {
            if let habit { LogProgressView(habit: habit, day: store.today(), source: .manual) }
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
                    Text(FocusProgressValue.period(habit))
                        .font(.subheadline).foregroundStyle(.secondary)
                }
                .padding(.horizontal, 24)
                Spacer(minLength: 24)
                FocusClock(habit: habit, day: day, showClock: true,
                           font: .system(size: min(numberSize, 52), weight: .medium, design: .rounded).monospacedDigit(),
                           diameter: min(max(geometry.size.width - 72, 200), 300)) { openLog(habit) }
                Spacer(minLength: 24)
                VStack(spacing: buttonGap) {
                    // One main button, always in the same place: Pause while it runs, Resume (or Start) when it doesn't.
                    Button { toggle(habit, running: running) } label: {
                        Label(running ? "Pause" : started ? "Resume" : "Start", systemImage: running ? "pause.fill" : "play.fill")
                    }
                    .modifier(FocusPrimaryButton())
                    .frame(maxWidth: min(actionWidth, 320))
                    .transaction { $0.animation = nil }
                    .accessibilityLabel(running ? "Stop \(habit.name) timer" : "Start \(habit.name) timer")
                    .accessibilityIdentifier("timer-screen-primary")
                    Button("Log Time Manually") { openLog(habit) }
                        .font(.subheadline.weight(.medium))
                        .frame(minHeight: 44)
                        .accessibilityIdentifier("timer-screen-log")
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 24)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
