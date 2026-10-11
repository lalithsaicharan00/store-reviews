import SwiftUI
import WatchKit

/// A section run as a routine (R1–R9): its unfinished habits, chosen when it started, one at a time.
struct RoutineSession: Identifiable, Equatable {
    let id = UUID()
    let part: String
    let title: String
    let day: LocalDay
    let habits: [Habit]
    /// Open at this habit (the iPhone's timer tapped in the Smart Stack, R8).
    var startAt: UUID? = nil

    static func == (a: RoutineSession, b: RoutineSession) -> Bool { a.id == b.id }
}

/// The routine player on the Watch (C): full screen, one habit per vertical page; the Crown or a swipe moves and never
/// logs or skips (R5); nothing advances by itself. The place is this device's own and survives the app being closed (R2).
/// Timers are start times in the database, so wrist down or a restart loses nothing; their end alert is a scheduled
/// notification (R3). Never a workout (R6).
struct RoutineScreen: View {
    let session: RoutineSession
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var index = 0
    @State private var list = false
    @State private var details: UUID?
    @State private var finished = false

    private var placeKey: String { "routine.place.\(session.part).\(session.day.key)" }

    var body: some View {
        NavigationStack {
            Group {
                if finished {
                    RoutineDone(session: session, close: close)
                } else {
                    TabView(selection: $index) {
                        ForEach(Array(session.habits.enumerated()), id: \.element.id) { i, habit in
                            RoutinePage(habit: habit, day: session.day)
                                .tag(i)
                        }
                    }
                    .tabViewStyle(.verticalPage)
                    .toolbar { bar }
                }
            }
            .containerBackground(Color.black, for: .navigation)
            .navigationTitle(finished ? session.title : "\(session.title) \(index + 1)/\(session.habits.count)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: close) { Image(systemName: "xmark") }
                        .accessibilityLabel("Close")
                        .accessibilityIdentifier("routine-close")
                }
            }
            .sheet(isPresented: $list) { RoutineList(session: session, index: $index) }
            .sheet(item: Binding(get: { details.map(DetailsTarget.init) }, set: { details = $0?.id })) { target in
                NavigationStack { DayDetailsScreen(habitID: target.id) }
            }
        }
        .onAppear {
            TimerPresence.playerOpen = true
            if let start = session.startAt, let i = session.habits.firstIndex(where: { $0.id == start }) {
                index = i
            } else {
                index = min(UserDefaults.standard.integer(forKey: placeKey), session.habits.count - 1)
            }
        }
        .onDisappear { TimerPresence.playerOpen = false }
        .background {
            #if DEBUG
            // Speed runs only: the driver pages as the Crown would (WatchPerfControl).
            Color.clear.onChange(of: WatchPerfControl.shared.pageStep) { _, _ in
                withAnimation { index = (index + 1) % max(1, session.habits.count) }
            }
            #endif
        }
        .onChange(of: index) { _, new in UserDefaults.standard.set(new, forKey: placeKey) }
        .background(Color.black.ignoresSafeArea())
        .accessibilityIdentifier("routine")
    }

    private struct DetailsTarget: Identifiable { let id: UUID }

    /// ✕ never stops a timer or loses the place: the section's ▶ resumes it (C6).
    private func close() {
        TimerPresence.playerOpen = false
        dismiss()
    }

    @ToolbarContentBuilder
    private var bar: some ToolbarContent {
        let habit = session.habits[min(index, session.habits.count - 1)]
        ToolbarItemGroup(placement: .bottomBar) {
            Button { list = true } label: { Image(systemName: "list.bullet") }
                .accessibilityLabel("The routine's habits")
                .accessibilityIdentifier("routine-list")
            RoutineMainButton(habit: habit, day: session.day, last: index == session.habits.count - 1,
                              next: { withAnimation { index = min(index + 1, session.habits.count - 1) } },
                              finish: { withAnimation { finished = true } })
            Button { details = habit.id } label: { Image(systemName: "ellipsis") }
                .accessibilityLabel("Day details")
                .accessibilityIdentifier("routine-details")
        }
    }
}

/// One habit's page: its dial, with its name, as Day details shows it.
struct RoutinePage: View {
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store
    @Environment(\.isLuminanceReduced) private var wristDown

    var body: some View {
        let _ = perfTimed("Count: a routine page drawn") { 0 }
        let live = store.habits.first { $0.id == habit.id } ?? habit
        let ruled = store.rule(live, on: day)
        ZStack {
            if ruled.kind == .checklist {
                ScrollView { ChecklistSteps(habit: live, ruled: ruled, day: day, locked: false) }
            } else {
                // The name inside the dial, under its icon; the title is the routine and its place (C1). The dial fits
                // between the title and the bottom bar (it ran into the buttons, run 38108831710).
                DayDial(habit: live, ruled: ruled, day: day, skipped: store.isSkipped(live, on: day),
                        paused: store.isPaused(live, on: day), dimmed: wristDown, name: live.name)
                    .frame(maxWidth: .infinity)
                    .frame(height: max(110, WKInterfaceDevice.current().screenBounds.height - 96))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            // Black, as the designs: never Today showing through. A running timer tints the page in its colour (C2).
            if store.timers[habit.id] != nil && !wristDown {
                LinearGradient(colors: [live.color.watchColor.opacity(0.85), live.color.watchColor.opacity(0.25), .black],
                               startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            } else {
                Color.black.ignoresSafeArea()
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("routine-page-\(live.name)")
    }
}

/// The page's main action, as the iPhone's player: Start/Pause, +step, Mark done; once the goal is met, Next, or Finish
/// on the last (C1–C3). Moving never logs (R5).
struct RoutineMainButton: View {
    let habit: Habit
    let day: LocalDay
    let last: Bool
    let next: () -> Void
    let finish: () -> Void
    @Environment(HabitStore.self) private var store

    var body: some View {
        let live = store.habits.first { $0.id == habit.id } ?? habit
        let ruled = store.rule(live, on: day)
        let running = store.timers[live.id] != nil
        let met = !running && (store.isSatisfied(live, on: day) || store.isSkipped(live, on: day))
        Button {
            if met { last ? finish() : next(); return }
            withAnimation(.snappy(duration: 0.25)) { act(live, ruled: ruled, running: running) }
        } label: {
            Group {
                if met { Text(last ? "Finish" : "Next") }
                else if let symbol = symbol(ruled, running: running) { Label(title(ruled, running: running), systemImage: symbol) }
                else { Text(title(ruled, running: running)) }
            }
            .lineLimit(1).minimumScaleFactor(0.7)
            .foregroundStyle(Color.black)
        }
        .buttonStyle(.borderedProminent)
        .tint(.white)
        .handGestureShortcut(.primaryAction)
        .accessibilityIdentifier("routine-main")
    }

    private func title(_ ruled: Habit, running: Bool) -> String {
        switch ruled.kind {
        case .duration: running ? "Pause" : "Start"
        case .amount(let unit, _): ruled.quickIncrement.map { "+" + HabitCopy.amount($0, unit) } ?? "Log amount"
        case .check where store.countsUp(habit, on: day): "Add a check"
        case .checklist: "Next"
        default: "Mark done"
        }
    }

    private func symbol(_ ruled: Habit, running: Bool) -> String? {
        ruled.kind == .duration ? (running ? "pause.fill" : "play.fill") : nil
    }

    private func act(_ habit: Habit, ruled: Habit, running: Bool) {
        let source = EntrySource.routine
        switch ruled.kind {
        case .duration:
            if running { store.stopTimer(habit, on: day, source: .watch) } else { store.startTimerOnWatch(habit) }
        case .amount:
            if ruled.quickIncrement != nil { store.increment(habit, on: day, source: source) }
        case .check where store.countsUp(habit, on: day):
            store.addProgress(habit, value: 1, on: day, source: source)
        case .check, .task:
            store.setDayDone(true, of: habit, on: day, source: source)
        case .checklist:
            last ? finish() : next()
        case .quit:
            break
        }
    }
}

/// The routine's list (C4): the touch backup for the Crown. Tap a habit to jump to it; nothing here logs.
struct RoutineList: View {
    let session: RoutineSession
    @Binding var index: Int
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List(Array(session.habits.enumerated()), id: \.element.id) { i, habit in
            Button { index = i; dismiss() } label: {
                HStack(spacing: 8) {
                    Image(systemName: habit.symbol).foregroundStyle(habit.color.watchColor).frame(width: 22)
                    VStack(alignment: .leading, spacing: 1) {
                        Text(habit.name).lineLimit(1)
                        Text(state(habit)).font(.footnote).foregroundStyle(.secondary)
                    }
                    Spacer(minLength: 0)
                    if store.isSatisfied(habit, on: session.day) {
                        Image(systemName: "checkmark.circle.fill").foregroundStyle(habit.color.watchColor)
                    }
                }
            }
            .listRowBackground(RoundedRectangle(cornerRadius: 18).fill(i == index ? Color.white.opacity(0.24) : WatchPalette.platter))
        }
        .navigationTitle(session.title)
    }

    private func state(_ habit: Habit) -> String {
        if store.isSatisfied(habit, on: session.day) { return "Done" }
        if let start = store.timers[habit.id] { return "Now · " + Format.clock(Date.now.timeIntervalSince(start) / 60) }
        return "Not yet"
    }
}

/// The finish (C5, R9): everything was saved as it happened, so Done only closes. Anything left is "still open on Today",
/// never "missed" (U3).
struct RoutineDone: View {
    let session: RoutineSession
    let close: () -> Void
    @Environment(HabitStore.self) private var store

    var body: some View {
        let done = session.habits.filter { store.isSatisfied($0, on: session.day) }.count
        let minutes = session.habits.filter { $0.kind == .duration }
            .flatMap { store.entries(of: $0.id, on: session.day) }.reduce(0) { $0 + $1.value }
        ScrollView {
            VStack(spacing: 8) {
                Image(systemName: "checkmark")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.black)
                    .frame(width: 60, height: 60)
                    .background(Circle().fill(.white))
                Text("\(session.title) done").font(.title3.weight(.bold))
                Text("\(done) of \(session.habits.count)" + (minutes >= 1 ? " · " + Format.minutes(minutes) : ""))
                    .foregroundStyle(.secondary)
                if done < session.habits.count {
                    Text("\(session.habits.count - done) still open on Today").font(.footnote).foregroundStyle(.secondary)
                }
                Button("Done", action: close)
                    .buttonStyle(.borderedProminent).tint(.white).foregroundStyle(.black)
                    .padding(.top, 6)
                    .accessibilityIdentifier("routine-done")
            }
            .frame(maxWidth: .infinity)
        }
    }
}
