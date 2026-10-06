import SwiftUI

struct RoutineSession: Identifiable {
    let id = UUID()
    let startedAt = Date.now
    let part: String
    let day: LocalDay
    let habits: [Habit]
}

/// One thing at a time. Habit entries/timers remain the source of truth; navigation never logs work.
struct RoutinePlayer: View {
    let session: RoutineSession
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @ScaledMetric(relativeTo: .title) private var numberSize = 36.0
    @ScaledMetric(relativeTo: .body) private var breathingRoom = 24.0
    @ScaledMetric(relativeTo: .body) private var actionWidth = 240.0
    /// Between the main button and the bottom bar: room enough that neither is tapped for the other.
    @ScaledMetric(relativeTo: .body) private var navigationGap = 24.0
    /// The main button's slot, measured: each page keeps this much room at its end (with the gap) so its last step
    /// scrolls clear of the button floating over it.
    @State private var actionHeight: CGFloat = 52
    /// Fitted to the options sheet's own list, so every option shows without scrolling (the user, 4 Oct 2026).
    @State private var optionsHeight: CGFloat = 0
    @State private var optionsDetent: PresentationDetent = .medium
    /// The habit the manual-entry sheet is for, fixed when it opens: the sheet never changes habit under the person.
    @State private var logHabitID: UUID?
    @State private var analyticsFlow = Analytics.shared.ticket
    @State private var order: [Habit]
    @State private var index = 0
    @State private var busy = false
    @State private var reviewed: Set<UUID> = []
    @State private var showQueue = false
    @State private var showLog = false
    @State private var showHabitOptions = false
    @State private var pendingHabitAction: HabitAction?
    private enum HabitAction { case log, skip, unskip, undo(UUID), timer, edit, note }
    @State private var showNote = false
    /// The habit the note is for: the current one, or the one just skipped (the banner's Add Note).
    @State private var noteHabitID: UUID?
    @State private var showEdit = false
    @State private var manualEntryIDs: Set<UUID> = []
    /// The timer was running when Add Time opened; it runs again when the sheet closes (Cancel included).
    @State private var resumeAfterLog = false
    /// Entries that existed before the routine started: Undo in the player only touches this session's own.
    @State private var entriesBefore: Set<UUID> = []
    @State private var undoID: UUID?
    /// "Skipped · Undo": the habit to un-skip (and return to) if Undo is tapped.
    @State private var undoSkipID: UUID?
    @State private var feedback: String?
    @State private var feedbackCount = 0
    @State private var expired = false
    @State private var showClock = true
    /// The page on screen. It follows `index`; a swipe changes it first and goes through `navigate`, so the
    /// timer of the habit left behind is saved and the next one's starts, exactly as with the buttons.
    @State private var page = 0
    /// The slide the player started (‹ ›, the queue, Skip), until it ends. Not observed: nothing redraws for it.
    @State private var slide = PagerSlide()
    #if DEBUG
    /// The fast ‹ › check's result (`PagerProbe`), shown only during that check.
    @State private var pagerCheck: String?
    #endif

    init(session: RoutineSession) {
        self.session = session
        _order = State(initialValue: session.habits)
    }

    private var current: Habit? {
        guard order.indices.contains(index) else { return nil }
        return store.habits.first { $0.id == order[index].id } ?? order[index]
    }
    private var next: Habit? { order.indices.contains(index + 1) ? order[index + 1] : nil }
    private var animation: Animation? { reduceMotion ? nil : .easeInOut(duration: 0.25) }
    /// Nothing more is asked: the main button moves on. A "3 times a week" habit ticked once today still offers
    /// "Log one", because every ✓ counts toward the week.
    private func done(_ habit: Habit) -> Bool {
        !habit.atMost && (store.slots(of: habit).isEmpty ? store.isComplete(habit, on: session.day)
            : store.isSlotDone(habit, slot: session.part, on: session.day))
    }
    /// Done for today: what the progress segments and the queue show. A week or month goal is done for the day once
    /// something is logged that day (Build Plan #60a).
    private func doneToday(_ habit: Habit) -> Bool {
        !habit.atMost && (store.slots(of: habit).isEmpty ? store.isSatisfied(habit, on: session.day)
            : store.isSlotDone(habit, slot: session.part, on: session.day))
    }
    private func skipped(_ habit: Habit) -> Bool { store.isSkipped(habit, on: session.day) }
    private func covered(_ habit: Habit) -> Bool { habit.atMost ? reviewed.contains(habit.id) : doneToday(habit) || skipped(habit) }
    private var remaining: [Habit] { order.filter { !covered($0) } }

    var body: some View {
        NavigationStack {
            // No TimelineView around the whole player: it rebuilt every page and the buttons each second, and
            // changing its rate on Pause/Resume made the bottom flicker (found by hand 29 Sep). Only the clock ticks.
            Group {
                if expired {
                    ContentUnavailableView {
                        Label("A new day has started", systemImage: "sunrise")
                    } description: {
                        Text("Your routine's progress is saved to its original day. Return to Today to continue.")
                    } actions: {
                        Button { close() } label: { Text("Back to Today").foregroundStyle(Color.onInk) }
                            .buttonStyle(.borderedProminent)
                    }
                } else {
                    pager
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Button { showQueue = true } label: {
                        HStack(spacing: 6) {
                            Text(store.section(session.part).name).font(.headline)
                                .lineLimit(1).minimumScaleFactor(0.8)
                            Text("·").foregroundStyle(.tertiary)
                            Text("\(min(index + 1, order.count))/\(order.count)")
                                .font(.subheadline).monospacedDigit().foregroundStyle(.secondary)
                                .fixedSize()
                            Image(systemName: "chevron.down").font(.caption2.weight(.semibold))
                                .foregroundStyle(.secondary)
                        }
                        .frame(minHeight: 44)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("\(store.section(session.part).name) routine, " +
                        (index < order.count ? "habit \(index + 1) of \(order.count)" : "summary"))
                    .accessibilityHint("View and reorder the routine")
                    .accessibilityIdentifier("routine-queue")
                    .disabled(expired)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", systemImage: "xmark") { close() }
                }
                ToolbarItem(placement: .primaryAction) {
                    // For the whole routine only; actions on one habit sit on its page (the user, 29 Sep).
                    Menu {
                        Button("View routine", systemImage: "list.bullet") { showQueue = true }
                        if let first = remaining.first, let position = order.firstIndex(where: { $0.id == first.id }), position != index {
                            Button("Go to first unfinished", systemImage: "arrow.uturn.backward") { navigate(to: position) }
                        }
                        Button("End routine", systemImage: "flag.checkered") { navigate(to: order.count) }
                    } label: {
                        Label("Routine options", systemImage: "ellipsis")
                    }
                    .disabled(expired)
                }
                if !expired { bottomBar }
            }
        }
        .tint(.ink)
        .toggleStyle(.appSwitch) // green switches in the player and its sheets too (Rulebook U2)
        // The player has no text field (typing happens in its own sheet), so it never makes room for a keyboard.
        // A keyboard left open in the New Habit form reserved a blank band at the bottom and pushed the controls
        // up (found by the user on the iPhone, 29 Sep).
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .analyticsScreen(.routinePlayer)
        .accessibilityIdentifier("routine-player")
        .interactiveDismissDisabled()
        .task {
            entriesBefore = Set(session.habits.flatMap { store.entries(of: $0.id, on: session.day).map(\.id) })
            startCurrentTimer()
            #if DEBUG && targetEnvironment(simulator)
            if ProcessInfo.processInfo.arguments.contains("-focus-preview"),
               ProcessInfo.processInfo.arguments.contains("-focus-preview-options") {
                showHabitOptions = true
            }
            #endif
        }
        // A new day ends the session on its own day; checked twice a minute, not on every frame.
        .task {
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(30))
                if !expired && session.day != store.today() { expire() }
            }
        }
        // No permission prompt over the player; the screen stays awake while a timer runs in it (research P13:
        // "Keep Screen On" is valued by routine-app users).
        .onAppear {
            TimerPresence.playerOpen = true; updateScreenAwake()
            store.analytics.count(.routineStarted, ticket: analyticsFlow)
        }
        .onDisappear { TimerPresence.playerOpen = false; UIApplication.shared.isIdleTimerDisabled = false }
        .onChange(of: store.timers.count) { updateScreenAwake() }
        .sheet(isPresented: $showQueue) { queue.analyticsScreen(nil) }
        .sheet(isPresented: $showHabitOptions, onDismiss: habitOptionsDismissed) {
            if let habit = current { habitOptions(habit).analyticsScreen(nil) }
        }
        .sheet(isPresented: $showEdit) { if let habit = current { EditHabitSheet(habit: habit) } }
        // A note is written in its own sheet with Save, as from Today (3 Oct 2026); the bottom row stays where it is.
        .sheet(isPresented: $showNote) {
            if let habit = order.first(where: { $0.id == noteHabitID }) ?? current {
                let note = store.note(of: habit, on: session.day)
                NoteSheet(title: note == nil ? "Add Note" : "Edit Note",
                          subtitle: habit.name + " · " + NoteSheet.dayText(session.day, today: store.today(), calendar: store.calendar),
                          initial: note ?? "") { store.setNote($0, of: habit, on: session.day) }
            }
        }
        .sheet(isPresented: $showLog, onDismiss: manualLogFinished) {
            if let habit = store.habits.first(where: { $0.id == logHabitID }) ?? current {
                LogProgressView(habit: habit, day: session.day, source: .routine)
            }
        }
        .alert("Couldn't save progress", isPresented: Binding(get: { store.problem != nil }, set: { if !$0 { store.problem = nil } })) {
            Button("OK", role: .cancel) { store.problem = nil }
        } message: { Text(store.problem ?? "") }
        // No haptic of its own for a log: the store gives every log its tap, and the completion sound only when it makes
        // the habit complete (`HabitStore+Feedback`, Current Work 18). It used to play "success" for every save, a
        // skip and an undo alike.
        .onPerfCommand { action in
            if action == .nextHabit { advance() } else if action == .previousHabit { navigate(to: max(0, index - 1)) }
        }
        #if DEBUG
        .task { await runFastNavigationCheck() }
        .overlay(alignment: .top) {
            if let pagerCheck { Text(pagerCheck).font(.caption2).accessibilityIdentifier("focus-pager-check") }
        }
        #endif
    }

    // MARK: The player: a playlist of habits (round 2, "Focus Player — How It Should Behave" P18–P23)

    /// Swipe between habits, or use ‹ and ›. The finish screen is the last page.
    private var pager: some View {
        // The bottom row is the native bottom bar, as on Today (the user, 5 Oct 2026: "an actual bottom navigation, not
        // a huge block"). The main button floats over the bottom of the page, so a page that has none (an unfinished
        // checklist) uses that space for its steps, and nothing moves when it comes and goes.
        VStack(spacing: 0) {
            header
            TabView(selection: $page) {
                ForEach(Array(order.enumerated()), id: \.element.id) { position, habit in
                    habitPage(store.habits.first { $0.id == habit.id } ?? habit).tag(position)
                }
                summary.tag(order.count)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .overlay(alignment: .bottom) {
                VStack(spacing: 8) {
                    // The save message floats above the main button, so nothing under it jumps when it appears.
                    feedbackBanner
                    if let habit = current { action(habit) }
                }
                .padding(.bottom, min(navigationGap, 32))
            }
        }
        // Not .disabled(busy): that greyed the whole player for each save and turned the Pause/Resume button
        // dark (found by hand 29 Sep). Every action already ignores taps while a save is in progress.
        .onChange(of: page) { _, new in
            guard new != index else { return }
            // While the player's own slide runs, the pager reports pages it slides past as if chosen; obeying sent the
            // player back to them, so › tapped fast slid the habits back and forth (Current Work 50, CI 5 Oct 2026:
            // 6 steps back in one run). Only a swipe of the person's own, outside that slide, chooses a habit.
            if slide.running { showPage(); return }
            navigate(to: new, reviewing: new > index && current?.atMost == true ? current?.id : nil)
        }
        .onChange(of: index) { _, new in if page != new { page = new } }
    }

    /// The compact toolbar already carries position and queue access; only the progress segments live here.
    private var header: some View {
        HStack(spacing: 4) {
            ForEach(Array(order.enumerated()), id: \.element.id) { position, habit in
                Capsule()
                    .fill(position == index ? Color.ink : covered(habit) ? Color.ink.opacity(0.45) : Color(.tertiarySystemFill))
                    .frame(height: position == index ? 6 : 4)
            }
        }
        .frame(height: 6)
        .padding(.horizontal, 24).padding(.top, min(breathingRoom, 36)).padding(.bottom, 8)
        .accessibilityElement()
        .accessibilityLabel("\(order.filter(covered).count) of \(order.count) habits covered")
        .animation(animation, value: index)
    }

    /// The title stays at the top; the circle gets the available space between context and actions.
    private func habitPage(_ habit: Habit) -> some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 24) {
                    Spacer(minLength: 16)
                    VStack(spacing: 24) {
                        VStack(spacing: 8) {
                            Text(habit.name)
                                .font(.title2.weight(.semibold))
                                .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
                                .accessibilityAddTraits(.isHeader)
                                .accessibilityIdentifier("focus-name")
                            // The habit's description (what counts, how to do it) is at hand while doing it.
                            if let description = store.description(of: habit) {
                                Text(description)
                                    .font(.subheadline).foregroundStyle(.secondary)
                                    .multilineTextAlignment(.center).lineLimit(3)
                                    .accessibilityIdentifier("focus-description")
                            }
                            Text(habit.frequency.isFlexible
                                 ? HabitCopy.capitalized(HabitCopy.plan(habit, weekStart: store.settings.weekStart))
                                 : FocusProgressValue.period(habit))
                                .font(.subheadline).foregroundStyle(.secondary)
                                .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
                                .accessibilityIdentifier("focus-progress-period")
                        }
                        hero(habit, diameter: min(max(geometry.size.width - 72, 200), habit.kind == .checklist ? 236 : 272))
                    }
                    // Its place is kept while there's nothing to undo, so the circle never jumps when it appears.
                    ZStack {
                        if done(habit), let entry = latestEntry(habit) {
                            Button { TickFeedback.undone(); store.undoEntry(entry.id) } label: {
                                Text(entry.undoLabel(for: habit)).frame(minWidth: 44, minHeight: 44)
                            }
                                .buttonStyle(.borderless).font(.callout)
                                .accessibilityIdentifier("focus-persistent-undo")
                        }
                    }
                    .frame(minHeight: 44)
                    if habit.kind == .checklist { checklist(habit) }
                    // Room at the end for the main button floating over the page (and the save message above it): the
                    // last step scrolls clear of them.
                    Spacer(minLength: actionHeight + min(navigationGap, 32) + 24)
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: 540)
                .frame(minHeight: geometry.size.height)
                .frame(maxWidth: .infinity)
            }
            .accessibilityIdentifier("routine-content")
            .scrollBounceBehavior(.basedOnSize)
        }
    }

    @ViewBuilder private func hero(_ habit: Habit, diameter: CGFloat) -> some View {
        let progress = store.progress(of: habit, on: session.day)
        let goal = store.goal(of: habit)
        let big = Font.system(size: min(numberSize, 52), weight: .medium, design: .rounded).monospacedDigit()
        if habit.kind == .duration && !skipped(habit) {
            FocusClock(habit: habit, day: session.day, showClock: showClock, font: big,
                       diameter: diameter) { openLog() }
        } else {
            FocusProgressCircle(progress: progress, goal: goal, color: habit.color.color,
                                overLimit: habit.atMost && progress > goal, diameter: diameter) {
                HabitIcon(symbol: habit.symbol, color: habit.color, size: 44)
                    .accessibilityHidden(true)
                FocusProgressValue(value: HabitCopy.number(progress), target: progressTarget(habit, goal: goal),
                                   period: FocusProgressValue.period(habit), font: big,
                                   identifier: habit.kind == .checklist ? "focus-checklist-progress" : "focus-quantity")
                if skipped(habit) {
                    Text("Skipped").font(.caption).foregroundStyle(.secondary)
                } else if habit.atMost && progress > goal {
                    Text("Over limit").font(.caption).foregroundStyle(.red)
                }
            }
        }
    }

    private func progressTarget(_ habit: Habit, goal: Double) -> String {
        if habit.kind == .duration { return Format.minutes(goal) + (habit.atMost ? " max" : "") }
        let unit: String
        switch habit.kind {
        case .amount(let name, _): unit = HabitCopy.unitWord(goal, name)
        case .check: unit = habit.checkUnit.map { HabitCopy.unitWord(goal, $0) } ?? ""
        case .checklist: unit = habit.frequency.isDayBased ? "steps" : "days"
        default: unit = ""
        }
        return HabitCopy.number(goal) + (unit.isEmpty ? "" : " " + unit) + (habit.atMost ? " max" : "")
    }

    private func checklist(_ habit: Habit) -> some View {
        VStack(spacing: 0) {
            ForEach(habit.steps) { step in
                let checked = store.isStepDone(step, of: habit, on: session.day)
                Button {
                    change(checked ? "Step unchecked" : "Step saved", captureUndo: !checked) {
                        store.toggleStep(step, of: habit, on: session.day, source: .routine)
                    }
                } label: {
                    HStack(spacing: 14) {
                        Image(systemName: checked ? "checkmark.circle.fill" : "circle")
                            .font(.title2).foregroundStyle(checked ? habit.color.color : .secondary)
                        Text(step.name).foregroundStyle(.primary).multilineTextAlignment(.leading)
                        Spacer(minLength: 0)
                    }
                    .padding(16).frame(maxWidth: .infinity, minHeight: 52)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel(checked ? "Undo \(step.name)" : "Mark \(step.name) done")
                .accessibilityIdentifier("focus-step-" + step.name)
                if step.id != habit.steps.last?.id { Divider().padding(.leading, 54) }
            }
        }
        .background(Color.card, in: RoundedRectangle(cornerRadius: 20))
    }

    /// One primary action, floating over the bottom of the page; everything secondary has one clearly named home in the
    /// bottom bar. Its slot is always there, so the save message above it never moves (the user, 4 Oct 2026: "no
    /// layout shift"). An unfinished checklist leaves the slot empty: its steps are the action.
    private func action(_ habit: Habit) -> some View {
        ZStack {
            Button {} label: { Label("Next", systemImage: "arrow.right") }
                .modifier(FocusPrimaryButton())
                .hidden()
                .accessibilityHidden(true)
            if habit.kind != .checklist || done(habit) || skipped(habit) {
                // The system's own prominent button (the user, 29 Sep: the custom style didn't feel native).
                primary(habit)
                    .accessibilityIdentifier("focus-primary")
                    .modifier(FocusPrimaryButton())
                    .transaction { $0.animation = nil }
            }
        }
        .frame(maxWidth: min(actionWidth, 320))
        .onGeometryChange(for: CGFloat.self) { $0.size.height.rounded(.up) } action: { height in
            if abs(height - actionHeight) > 0.5 { actionHeight = height } // only when Dynamic Type changes it
        }
        .padding(.horizontal, 28)
    }

    private func habitOptions(_ habit: Habit) -> some View {
        NavigationStack {
            List {
                if habit.frequency.isFlexible {
                    Section("Goal") {
                        Text(HabitCopy.capitalized(HabitCopy.plan(habit, weekStart: store.settings.weekStart)))
                        FocusPeriodQuota(habit: habit, day: session.day)
                    }
                }
                if !skipped(habit) && (habit.kind == .duration || isAmount(habit)) {
                    Section {
                        Button(habit.kind == .duration ? "Log time manually" : "Log amount manually",
                               systemImage: "square.and.pencil") { selectHabitAction(.log) }
                            .accessibilityIdentifier("focus-log-manually")
                    }
                }
                if skipped(habit) || store.canSkip(habit) && !done(habit) || latestEntry(habit) != nil {
                    Section {
                        if skipped(habit) {
                            Button("Undo skip", systemImage: "arrow.uturn.backward") { selectHabitAction(.unskip) }
                                .accessibilityIdentifier("focus-unskip")
                        } else if store.canSkip(habit) && !done(habit) {
                            Button("Skip today", systemImage: "forward") { selectHabitAction(.skip) }
                                .accessibilityIdentifier("focus-skip")
                        }
                        if !skipped(habit), let entry = latestEntry(habit) {
                            Button("Undo \(entryText(entry, of: habit))", systemImage: "arrow.uturn.backward") {
                                selectHabitAction(.undo(entry.id))
                            }
                        }
                    }
                }
                if habit.kind == .duration {
                    Section {
                        if done(habit) {
                            Button(store.timers[habit.id] == nil ? "Resume timer" : "Pause timer",
                                   systemImage: store.timers[habit.id] == nil ? "play.fill" : "pause.fill") {
                                selectHabitAction(.timer)
                            }
                        }
                        Toggle("Show clock", isOn: $showClock)
                            .toggleStyle(.appSwitch)
                    }
                }
                Section {
                    Button(store.note(of: habit, on: session.day) == nil ? "Add Note" : "Edit Note", systemImage: "note.text") { selectHabitAction(.note) }
                        .accessibilityIdentifier("focus-note")
                    Button(habit.kind == .task ? "Edit Task" : "Edit Habit", systemImage: "pencil") { selectHabitAction(.edit) }
                        .accessibilityIdentifier("focus-edit-habit")
                }
            }
            .navigationTitle(habit.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { showHabitOptions = false }
                }
            }
            // The sheet is as tall as its options (with the title bar and the home indicator), so Edit Habit is never
            // hidden below the fold; a list taller than the screen still opens large and scrolls.
            .onScrollGeometryChange(for: CGFloat.self) { geometry in
                (geometry.contentSize.height + geometry.contentInsets.top + geometry.contentInsets.bottom).rounded(.up)
            } action: { _, height in
                guard height > 0, abs(height - optionsHeight) > 1 else { return }
                optionsHeight = height
                optionsDetent = .height(height)
            }
        }
        .presentationDetents(optionsHeight > 0 ? [.height(optionsHeight), .large] : [.medium, .large], selection: $optionsDetent)
        .presentationBackground(Color(.systemGroupedBackground))
        .presentationDragIndicator(.visible)
        .accessibilityIdentifier("focus-habit-options-sheet")
    }

    private func selectHabitAction(_ action: HabitAction) {
        pendingHabitAction = action
        showHabitOptions = false
    }

    /// Wait for the options sheet to dismiss before presenting manual entry or navigating after a skip.
    private func habitOptionsDismissed() {
        let action = pendingHabitAction
        pendingHabitAction = nil
        guard let action, !expired, session.day == store.today(), let habit = current else { return }
        switch action {
        case .log: openLog()
        case .skip: skip(habit)
        case .unskip: unskip(habit, stay: true)
        case .undo(let id): change("Entry removed", captureUndo: false) { store.undoEntry(id) }
        case .timer: toggleTimer(habit)
        case .edit: showEdit = true
        case .note: noteHabitID = habit.id; showNote = true
        }
    }

    /// "Amount saved · Undo", floating above the controls.
    @ViewBuilder private var feedbackBanner: some View {
        if let feedback {
            HStack(spacing: 12) {
                Label(feedback, systemImage: "checkmark.circle").font(.subheadline)
                if let id = undoSkipID, let habit = order.first(where: { $0.id == id }) {
                    Button("Undo") { unskip(habit, stay: false) }
                        .font(.subheadline.weight(.semibold))
                    // Why it was skipped, if the person wants to say (users show: Way of Life); never asked.
                    Button("Add Note") { noteHabitID = id; showNote = true }
                        .font(.subheadline.weight(.semibold))
                        .accessibilityIdentifier("focus-skip-note")
                } else if let id = undoID {
                    Button("Undo") { change("Undone", captureUndo: false) { store.undoEntry(id) } }
                        .font(.subheadline.weight(.semibold))
                        .accessibilityIdentifier("focus-undo")
                    // The note belongs right after logging, next to Undo; never asked for (notes UX report).
                    Button("Add Note") { noteHabitID = current?.id; showNote = true }
                        .font(.subheadline.weight(.semibold))
                        .accessibilityIdentifier("focus-banner-note")
                }
            }
            .padding(.horizontal, 16).frame(minHeight: 44)
            // A solid pill with a soft shadow: a material one vanished on the light background.
            .background(Capsule().fill(Color(.secondarySystemGroupedBackground)).shadow(color: .black.opacity(0.12), radius: 8, y: 2))
            .padding(.bottom, 8)
            .transition(.opacity.combined(with: .move(edge: .bottom)))
        }
    }

    /// ‹ · Habit options · ›: the standard bottom bar, the same as Today's ‹ · Today · › (the user, 5 Oct 2026). On
    /// iOS 26 each part is its own Liquid Glass item; before iOS 26 it is a plain bottom bar. It stays on the finish
    /// page too, so ‹ still goes back and the pages never change height. Skip is a separate explicit action, never a
    /// chevron side effect.
    @ToolbarContentBuilder
    private var bottomBar: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            Button("Previous habit", systemImage: "chevron.left") { navigate(to: max(0, index - 1)) }
                .disabled(index == 0)
        }
        if #available(iOS 26, *) {
            ToolbarSpacer(.flexible, placement: .bottomBar)
            ToolbarItem(placement: .bottomBar) { optionsButton }
            ToolbarSpacer(.flexible, placement: .bottomBar)
        } else {
            ToolbarItem(placement: .status) { optionsButton }
        }
        ToolbarItem(placement: .bottomBar) {
            Button("Next habit", systemImage: "chevron.right") { advance() }
                .disabled(index >= order.count)
                .accessibilityLabel(next.map { "Next habit: \($0.name)" } ?? "Finish routine")
                .accessibilityIdentifier("focus-up-next")
        }
    }

    private var optionsButton: some View {
        Button {
            pendingHabitAction = nil
            optionsDetent = optionsHeight > 0 ? .height(optionsHeight) : .medium
            showHabitOptions = true
        } label: {
            Text(current?.kind == .task ? "Task options" : "Habit options").lineLimit(1)
        }
        .disabled(current == nil)
        .accessibilityIdentifier("focus-habit-options")
    }

    /// Next habit (or the finish screen). Leaving a limit counts as having checked in on it.
    private func advance() {
        let leaving = current
        navigate(to: index + 1, reviewing: leaving?.atMost == true ? leaving?.id : nil)
    }

    /// One main action per type, always in the same place (P22).
    @ViewBuilder private func primary(_ habit: Habit) -> some View {
        if skipped(habit) {
            Button { advance() } label: {
                Label(next == nil ? "Finish routine" : "Next", systemImage: next == nil ? "checkmark" : "arrow.right")
                    .lineLimit(1)
            }
        } else if habit.atMost {
            // Cut down: log what happened; it never becomes "done" (P23).
            Button {
                if habit.quickIncrement != nil { change("Logged") { store.increment(habit, on: session.day, source: .routine) } } else { openLog() }
            } label: {
                Label(habit.quickIncrement.map { "Log " + HabitCopy.amount($0, amountUnit(habit)) } ?? "Log amount manually", systemImage: "plus")
            }
        } else if done(habit) {
            Button { advance() } label: {
                Label(next == nil ? "Finish routine" : "Next", systemImage: next == nil ? "checkmark" : "arrow.right")
                    .lineLimit(1)
            }
        } else {
            switch habit.kind {
            case .check, .task:
                Button {
                    // "Log one" adds one, as it says: a ✓ toggles its day (Rulebook U14), so a second "Log one" for a
                    // 3-times-a-week habit took the first one back (found by ScheduleCheck, 4 Oct 2026).
                    change("Saved") {
                        if habit.kind == .check && store.goal(of: habit) > 1 {
                            store.addProgress(habit, value: 1, on: session.day, source: .routine)
                        } else {
                            store.toggleCheck(habit, on: session.day, source: .routine)
                        }
                    }
                } label: {
                    Label(store.goal(of: habit) > 1 ? "Log one" : "Mark done", systemImage: "checkmark")
                }.accessibilityLabel("Mark \(habit.name) done")
            case .amount:
                Button {
                    if habit.quickIncrement != nil { change("Saved") { store.increment(habit, on: session.day, source: .routine) } }
                    else { openLog() }
                } label: {
                    Label(habit.quickIncrement.map { "Log " + HabitCopy.amount($0, amountUnit(habit)) } ?? "Log manually", systemImage: "plus")
                }.accessibilityLabel(habit.quickIncrement.map { "Add \(HabitCopy.amount($0, amountUnit(habit))) to \(habit.name)" } ?? "Log an amount for \(habit.name)")
            case .duration:
                let running = store.timers[habit.id] != nil
                let started = store.progress(of: habit, on: session.day) > 0
                Button { toggleTimer(habit) } label: {
                    Label(running ? "Pause" : started ? "Resume" : "Start", systemImage: running ? "pause.fill" : "play.fill")
                }.accessibilityLabel(running ? "Stop \(habit.name) timer" : "Start \(habit.name) timer")
            case .checklist, .quit:
                EmptyView()
            }
        }
    }

    private var summary: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Not a pause symbol: it read as a media button (found by hand 29 Sep).
                Image(systemName: remaining.isEmpty ? "checkmark.circle.fill" : "clock.arrow.circlepath")
                    .font(.system(size: 72, weight: .light)).foregroundStyle(Color.ink)
                    .accessibilityHidden(true)
                Text(remaining.isEmpty ? "Routine finished" : "End of the routine").font(.largeTitle.weight(.semibold))
                Text(summaryText).font(.body).foregroundStyle(.secondary)
                let skippedCount = order.filter { skipped($0) }.count
                if skippedCount > 0 {
                    Text("\(skippedCount) skipped for today. Skipped days don't count against you.")
                        .font(.subheadline).foregroundStyle(.secondary)
                }
                if !reviewed.isEmpty {
                    Text("\(reviewed.count) limit \(reviewed.count == 1 ? "check-in" : "check-ins"). Your limits keep tracking through the day.")
                        .font(.subheadline).foregroundStyle(.secondary)
                }
                // Done is the main way out; going back to what's left is the secondary choice.
                Button { close() } label: {
                    Text("Done").font(.body.weight(.semibold)).foregroundStyle(Color.onInk).frame(maxWidth: .infinity)
                }
                    .modifier(FocusPrimaryButton())
                if let first = remaining.first, let position = order.firstIndex(where: { $0.id == first.id }) {
                    Button("Return to unfinished", systemImage: "arrow.uturn.backward") { navigate(to: position) }
                        .buttonStyle(.bordered).controlSize(.large)
                }
                Button("Review routine", systemImage: "list.bullet") { showQueue = true }
            }
            .multilineTextAlignment(.center).padding(32).frame(maxWidth: 540)
            .frame(maxWidth: .infinity).containerRelativeFrame(.vertical, alignment: .center)
        }
    }

    private var summaryText: String {
        if remaining.isEmpty { return reviewed.isEmpty ? "All habits in this routine are done." : "Your routine is complete. Your progress is saved." }
        return "\(remaining.count) left for later. Your progress is saved."
    }

    private var queue: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(order) { habit in
                        Button {
                            guard let position = order.firstIndex(where: { $0.id == habit.id }) else { return }
                            showQueue = false
                            navigate(to: position)
                        } label: {
                            // Top-aligned like the Today rows (RowBand): a long name runs on below, the icon and mark stay up.
                            HStack(alignment: .top, spacing: 12) {
                                HabitIcon(symbol: habit.symbol, color: habit.color)
                                    .frame(height: RowBand.height)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(habit.name).foregroundStyle(.primary)
                                    Text(habit.atMost ? (reviewed.contains(habit.id) ? "Checked in" : "Limit check-in")
                                         : doneToday(habit) ? "Done" : skipped(habit) ? "Skipped for today" : "Not finished")
                                        .font(.caption).foregroundStyle(.secondary)
                                }
                                .frame(minHeight: RowBand.height)
                                Spacer()
                                Group {
                                    if current?.id == habit.id { Image(systemName: "play.fill").accessibilityLabel("Current habit") }
                                    else if skipped(habit) { Image(systemName: "forward.fill").foregroundStyle(.secondary).accessibilityLabel("Skipped") }
                                    else if covered(habit) { Image(systemName: "checkmark").accessibilityLabel(doneToday(habit) ? "Done" : "Checked in") }
                                }
                                .frame(height: RowBand.height)
                            }
                        }
                        .accessibilityIdentifier("queue-" + habit.name)
                    }
                    .onMove { source, destination in
                        let id = current?.id
                        order.move(fromOffsets: source, toOffset: destination)
                        if let id, let position = order.firstIndex(where: { $0.id == id }) { index = position }
                    }
                } footer: {
                    Text("Jump to any habit, or change the order for this routine. Moving on never marks a habit done.")
                }
            }
            .navigationTitle("Your routine").navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Done") { showQueue = false } }
                ToolbarItem(placement: .primaryAction) { EditButton() }
            }
        }
        .presentationDragIndicator(.visible)
        .disabled(busy || expired)
    }

    /// The screen changes at once and the write follows in order (Rulebook S7). Waiting for the save first showed Undo
    /// late and dropped a tap made while it ran, Undo included (FocusPlayerUITests on GitHub, 4 Oct 2026). A failed save
    /// reloads what's stored and says so (the alert).
    private func change(_ message: String?, captureUndo: Bool = true, action: () -> Void) {
        guard !expired, session.day == store.today() else { return }
        let habitID = current?.id
        let before = Set(habitID.map { store.entries(of: $0, on: session.day).map(\.id) } ?? [])
        if !captureUndo { TickFeedback.undone() } // only undoing and removing pass false
        action()
        undoID = captureUndo ? habitID.flatMap { id in store.entries(of: id, on: session.day).last { !before.contains($0.id) } }?.id : nil
        withAnimation(animation) { feedback = message }
        if message != nil { feedbackCount += 1; hideFeedbackSoon() }
    }

    /// Pause and Resume: no message and no Undo. "Paused · time saved" under the clock says what happened, and an
    /// Undo here deleted the session's time instead of un-pausing (found by hand 29 Sep).
    private func toggleTimer(_ habit: Habit) {
        // Instant, never blocked by a save in progress: each tap flips the state the person sees.
        guard !expired, session.day == store.today() else { return }
        if store.timers[habit.id] != nil { store.stopTimer(habit, on: session.day, source: .routine) } else { store.toggleTimer(habit) }
        withAnimation(animation) { feedback = nil; undoID = nil; undoSkipID = nil }
    }

    /// Skip today: set aside for today (neutral everywhere), and on to the next habit, with Undo.
    private func skip(_ habit: Habit) {
        guard !busy else { return }
        store.setSkipped(habit, on: session.day, true)
        let skippedID = habit.id
        navigate(to: index + 1)
        // At once, like every other change (S7); the write follows in order.
        withAnimation(animation) { feedback = "Skipped for today"; undoID = nil; undoSkipID = skippedID }
        TickFeedback.tapped()
        feedbackCount += 1
        hideFeedbackSoon()
    }

    /// Undo a skip: from its page (stay) or from the message after moving on (go back to it).
    private func unskip(_ habit: Habit, stay: Bool) {
        store.setSkipped(habit, on: session.day, false)
        withAnimation(animation) { feedback = nil; undoSkipID = nil }
        if !stay, let position = order.firstIndex(where: { $0.id == habit.id }) { navigate(to: position) }
    }

    private func startCurrentTimer() {
        guard !expired, session.day == store.today(), let habit = current, !skipped(habit),
              habit.kind == .duration, !done(habit), store.timers[habit.id] == nil else { return }
        store.toggleTimer(habit)
    }

    private func navigate(to position: Int, reviewing id: UUID? = nil) {
        guard !expired, session.day == store.today() else { page = index; return }
        let destination = min(max(position, 0), order.count)
        guard destination != index else { return }
        // Timer mutations are immediate in memory and persisted in order by HabitStore. Navigation must
        // never wait for disk writes (or reject a tap while an earlier habit's write is finishing).
        if let habit = current, store.timers[habit.id] != nil {
            store.stopTimer(habit, on: session.day, source: .routine)
        }
        if let id { reviewed.insert(id) }
        feedback = nil; undoID = nil; undoSkipID = nil
        #if DEBUG
        PagerProbe.shared.moved(from: index, to: destination)
        PagerProbe.shared.index = destination
        #endif
        index = destination
        showPage()
        startCurrentTimer()
        updateScreenAwake()
    }

    /// Puts the pager on `index`. A tap slides it; a tap that comes while a slide is still running jumps straight to its
    /// habit, so the pages never trail the header and never have to turn round to come back (the user tapped › to the
    /// end and ‹ straight back: the trailing pages were still sliding forward, Current Work 50).
    private func showPage() {
        guard page != index else { return }
        if slide.running || animation == nil {
            var instant = Transaction(); instant.disablesAnimations = true
            withTransaction(instant) { page = index }
        } else {
            slide.until = .now.addingTimeInterval(0.35)
            withAnimation(animation) { page = index }
        }
    }

    private func close() {
        guard !busy else { return }
        busy = true
        Task { @MainActor in
            if let habit = current, store.timers[habit.id] != nil {
                store.stopTimer(habit, on: session.day, source: .routine)
            }
            await store.flush()
            busy = false
            if store.problem == nil {
                store.analytics.count(remaining.isEmpty && index >= order.count ? .routineFinished : .routineCancelled, ticket: analyticsFlow)
                dismiss()
            }
        }
    }

    private func expire() {
        expired = true
        showQueue = false; showLog = false; showHabitOptions = false; pendingHabitAction = nil
        if let habit = current, store.timers[habit.id] != nil {
            // A routine stays on its tracking day. Do not count background time after its day ends.
            let nextDay = session.day.adding(days: 1, calendar: store.calendar).date(calendar: store.calendar)
            let end = store.calendar.date(bySettingHour: store.settings.dayEndHour, minute: 0, second: 0, of: nextDay) ?? nextDay
            store.stopTimer(habit, on: session.day, through: end, source: .routine)
        }
    }

    private func openLog() {
        guard !busy, !expired, session.day == store.today() else { return }
        busy = true
        logHabitID = current?.id
        Task { @MainActor in
            // Manual time and a live timer must not count the same interval twice.
            resumeAfterLog = false
            if let habit = current, habit.kind == .duration, store.timers[habit.id] != nil {
                store.stopTimer(habit, on: session.day, source: .routine)
                await store.flush()
                resumeAfterLog = true
            }
            busy = false
            guard store.problem == nil else { return }
            withAnimation(animation) { feedback = nil; undoID = nil }
            manualEntryIDs = Set(current.map { store.entries(of: $0.id, on: session.day).map(\.id) } ?? [])
            showLog = true
        }
    }
    /// After Add Time / Add Amount: show what was saved, and a timer that was running runs again, Cancel included
    /// (it used to stay paused without a word, found by hand 29 Sep). Its earlier time was saved before the sheet.
    private func manualLogFinished() {
        if let habit = current, let entry = store.entries(of: habit.id, on: session.day).last(where: { !manualEntryIDs.contains($0.id) }) {
            undoID = entry.id
            withAnimation(animation) { feedback = habit.kind == .duration ? "Time saved" : "Amount saved" }
            feedbackCount += 1
            hideFeedbackSoon()
        }
        if resumeAfterLog, let habit = current, habit.kind == .duration, store.timers[habit.id] == nil, !done(habit) {
            resumeAfterLog = false
            store.toggleTimer(habit)
        }
        resumeAfterLog = false
    }
    private func latestEntry(_ habit: Habit) -> Entry? {
        // Only what was logged in this routine: an entry from earlier in the day (or another day) is never
        // removed from here by accident (found by hand 29 Sep: it offered to delete the morning's 5,200 steps).
        store.entries(of: habit.id, on: session.day).last { !entriesBefore.contains($0.id) && $0.source == .routine }
    }

    /// "+1,000 steps", "12 min", "check": what Undo removes, in words.
    private func entryText(_ entry: Entry, of habit: Habit) -> String {
        switch habit.kind {
        case .duration: return Format.minutes(entry.value)
        case .amount(let unit, _): return "+" + HabitCopy.amount(entry.value, unit)
        default: return "check"
        }
    }

    /// The save message goes after a few seconds, like iOS's own undo toasts, so it never sits over the page
    /// (it covered a checklist's last step, found by hand 29 Sep). Undo stays in the ⋯ menu.
    private func hideFeedbackSoon() {
        let shown = feedbackCount
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(4))
            guard feedbackCount == shown else { return }
            withAnimation(animation) { feedback = nil; undoID = nil; undoSkipID = nil }
        }
    }

    private func updateScreenAwake() {
        UIApplication.shared.isIdleTimerDisabled = current.map { store.timers[$0.id] != nil } ?? false
    }
    #if DEBUG
    /// The fast ‹ › check (Current Work 50): › to the end and ‹ back to the start, at a tap every 0.15, 0.1 and 0.05 s,
    /// the way a quick thumb does (XCUITest waits for each slide to end, so it can't tap this fast). `PagerProbe`
    /// samples where the pages are on screen every frame meanwhile.
    private func runFastNavigationCheck() async {
        guard PagerProbe.enabled else { return }
        let probe = PagerProbe.shared
        try? await Task.sleep(for: .seconds(1.5))
        let sampler = Task { @MainActor in
            while !Task.isCancelled { probe.sample(); try? await Task.sleep(for: .milliseconds(8)) }
        }
        var verdicts: [(passed: Bool, text: String)] = []
        for interval in [150, 100, 50] {
            probe.begin(1)
            var taps = 0
            while index < order.count - 1 && taps < order.count * 4 {
                advance(); taps += 1; try? await Task.sleep(for: .milliseconds(interval))
            }
            try? await Task.sleep(for: .seconds(1.2))
            verdicts.append(probe.verdict(target: order.count - 1, label: "› \(interval) ms"))
            probe.begin(-1)
            taps = 0
            while index > 0 && taps < order.count * 4 {
                navigate(to: max(0, index - 1)); taps += 1; try? await Task.sleep(for: .milliseconds(interval))
            }
            try? await Task.sleep(for: .seconds(1.2))
            verdicts.append(probe.verdict(target: 0, label: "‹ \(interval) ms"))
        }
        // The user's own pattern: › fast to the end, then ‹ straight away, with no pause between.
        for interval in [100, 50] {
            probe.begin(1)
            var taps = 0
            while index < order.count - 1 && taps < order.count * 4 {
                advance(); taps += 1; try? await Task.sleep(for: .milliseconds(interval))
            }
            verdicts.append(probe.verdict(target: order.count - 1, label: "turn › \(interval) ms", settled: false))
            probe.begin(-1)
            taps = 0
            while index > 0 && taps < order.count * 4 {
                navigate(to: max(0, index - 1)); taps += 1; try? await Task.sleep(for: .milliseconds(interval))
            }
            try? await Task.sleep(for: .seconds(1.2))
            verdicts.append(probe.verdict(target: 0, label: "turn ‹ \(interval) ms"))
        }
        sampler.cancel()
        probe.begin(0)
        pagerCheck = "Fast navigation: " + (verdicts.allSatisfy { $0.passed } ? "passed" : "failed")
            + " · \(order.count) habits · " + verdicts.map { $0.text }.joined(separator: " · ")
    }
    #endif

    private func isAmount(_ habit: Habit) -> Bool { if case .amount = habit.kind { true } else { false } }
    private func amountUnit(_ habit: Habit) -> String { if case .amount(let unit, _) = habit.kind { unit } else { "" } }


}

/// Until when the player's own pager slide runs (`RoutinePlayer.showPage`).
final class PagerSlide {
    var until = Date.distantPast
    var running: Bool { Date.now < until }
}

/// The player's main button: the system's prominent button, large, in ink, full width of its slot. Native press
/// feedback and shape; the label keeps the on-ink colour so it reads in dark mode too.
struct FocusPrimaryButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .labelStyle(FocusPrimaryLabel())
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .tint(.ink)
    }
}

/// Icon and title filling the button's width, so every main button is the same size.
struct FocusPrimaryLabel: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        // One line always, so the button keeps its height from habit to habit.
        HStack(spacing: 8) { configuration.icon; configuration.title.lineLimit(1).minimumScaleFactor(0.75) }
            .font(.body.weight(.semibold))
            .foregroundStyle(Color.onInk)
            .frame(maxWidth: .infinity)
    }
}

/// The timed habit's clock, status and bar. Only this ticks, once a second, and only while its timer runs;
/// the rest of the player stays still (a full-screen timeline made the buttons flicker, found by hand 29 Sep).
struct FocusClock: View {
    let habit: Habit
    let day: LocalDay
    let showClock: Bool
    let font: Font
    let diameter: CGFloat
    let onTapClock: () -> Void
    @Environment(HabitStore.self) private var store

    /// Paused: a schedule whose first tick never comes, so the clock stands still.
    private static let never = Date.distantFuture

    var body: some View {
        // One view whether running or paused. Swapping between a timeline and a plain view on Pause rebuilt
        // the whole circle, so its text faded in again (found by hand 29 Sep).
        let start = store.timers[habit.id]
        TimelineView(.periodic(from: start ?? Self.never, by: 1)) { context in
            content(now: start == nil ? .now : context.date, running: start != nil)
        }
    }

    private func content(now: Date, running: Bool) -> some View {
        let progress = store.progress(of: habit, on: day, now: now)
        let goal = store.goal(of: habit)
        return FocusProgressCircle(progress: progress, goal: goal, color: habit.color.color,
                                   overLimit: habit.atMost && progress > goal, diameter: diameter) {
            HabitIcon(symbol: habit.symbol, color: habit.color, size: 44)
                .accessibilityHidden(true)
            if showClock {
                Button(action: onTapClock) {
                    FocusProgressValue(value: Format.clock(progress),
                                       target: Format.minutes(goal) + (habit.atMost ? " max" : ""),
                                       period: FocusProgressValue.period(habit), font: font, identifier: "focus-clock-value")
                }
                .buttonStyle(.plain)
                .accessibilityHint("Logs time manually")
                .accessibilityIdentifier("focus-clock")
            } else {
                VStack(spacing: 8) {
                    Text(Format.minutes(goal) + (habit.atMost ? " max" : ""))
                        .font(.title3)
                }
            }
            // Always there, invisible while running, so Pause doesn't push the icon and clock up.
            Text(running ? "Paused" : progress > 0 ? "Paused" : "Not started")
                .font(.caption).foregroundStyle(.secondary)
                .opacity(running ? 0 : 1)
                .accessibilityHidden(running)
            if habit.atMost && progress > goal {
                Text("Over limit").font(.caption).foregroundStyle(.red)
            }
        }
        .transaction { $0.animation = nil }
    }
}

/// The goal context sits above the circle; VoiceOver also reads the current value’s period.
struct FocusProgressValue: View {
    let value: String
    let target: String
    let period: String
    let font: Font
    let identifier: String

    static func period(_ habit: Habit) -> String {
        switch habit.frequency {
        case .perWeek: "This week"
        case .perMonth: "This month"
        case .perYear: "This year"
        default: "Today"
        }
    }

    private var fraction: some View {
        (Text(value).foregroundStyle(Color.primary) + Text(" / " + target).font(.title2).foregroundStyle(Color.secondary))
            .font(font).multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .accessibilityIdentifier(identifier)
    }

    var body: some View {
        VStack(spacing: 8) {
            fraction
                .lineLimit(2).minimumScaleFactor(0.65)
                .accessibilityValue(period)

        }
    }
}

/// The ring encodes exactly the same current/target shown inside it, across every tracking type.
struct FocusProgressCircle<Content: View>: View {
    let progress: Double
    let goal: Double
    let color: Color
    let overLimit: Bool
    let diameter: CGFloat
    @ViewBuilder var content: Content

    var body: some View {
        ZStack {
            Circle().fill(color.opacity(0.035))
            Circle().strokeBorder(color.opacity(0.12), lineWidth: 7)
            Circle()
                .trim(from: 0, to: min(max(progress / max(goal, 0.001), 0), 1))
                .stroke(overLimit ? Color.red : color, style: StrokeStyle(lineWidth: 7, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .padding(3.5)
                .accessibilityHidden(true)
            VStack(spacing: 14) { content }
                .frame(width: diameter * 0.72)
                .multilineTextAlignment(.center)
        }
        .frame(width: diameter, height: diameter)
        // A container with its own identifier: without `.contain`, the identifier replaced the children's own
        // ("focus-quantity", "focus-checklist-progress"), so VoiceOver tools and UI tests couldn't find them.
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("focus-progress-circle")
    }
}

/// A flexible schedule has a daily target and a distinct quota of days for the period.
private struct FocusPeriodQuota: View {
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store

    var body: some View {
        if let count = store.flexibleProgress(habit, on: day),
           case .flexible(let period, let target) = habit.frequency {
            Text("\(count)/\(target) days · This \(period.noun)")
                .font(.caption).foregroundStyle(.secondary)
                .accessibilityIdentifier("focus-period-progress")
        }
    }
}

#if DEBUG
/// Where the player's pages are while it moves (Current Work 50, 5 Oct 2026: tapping › fast made the pages slide back
/// and forth while the segments above were right). Only with `-focus-fast-nav-check`. Every frame it reads the pager's
/// scroll view as drawn on screen (its presentation layer), so a slide is seen mid-way whether UIKit or SwiftUI animates
/// it, and a slide back the way it came is measured, not judged by eye (Rulebook S2).
final class PagerProbe {
    static let enabled = ProcessInfo.processInfo.arguments.contains("-focus-fast-nav-check")
    static let shared = PagerProbe()
    private weak var pager: UIScrollView?
    private var direction: CGFloat = 0
    private var furthest: CGFloat?
    private var worstBack: CGFloat = 0
    private var reversals = 0
    private var midSlide = 0
    private var position: CGFloat = 0

    func begin(_ direction: CGFloat) {
        self.direction = direction; furthest = nil; worstBack = 0; reversals = 0; midSlide = 0; worstBehind = 0
    }

    /// The page on screen, in pages: 2.5 is halfway between the third and fourth.
    func sample() {
        guard let pager = pager ?? Self.findPager(), pager.bounds.width > 1 else { return }
        self.pager = pager
        let x = pager.layer.presentation()?.bounds.origin.x ?? pager.contentOffset.x
        position = (x + pager.adjustedContentInset.left) / pager.bounds.width
        guard direction != 0 else { return }
        if abs(position - position.rounded()) > 0.02 { midSlide += 1 }
        let along = position * direction
        furthest = max(furthest ?? along, along)
        worstBack = max(worstBack, (furthest ?? along) - along)
        worstBehind = max(worstBehind, abs(CGFloat(index) - position))
    }

    /// The player itself went the other way (a page it was passing reported as the one chosen).
    func moved(from old: Int, to new: Int) { if CGFloat(new - old) * direction < 0 { reversals += 1 } }

    /// A run passes when the pages never slid back more than a twentieth of a page, the player never went back, the
    /// pages settled where the player is, and the probe saw them mid-slide (so it wasn't blind).
    func verdict(target: Int, label: String, settled: Bool = true) -> (passed: Bool, text: String) {
        let passed = worstBack < 0.05 && reversals == 0 && (!settled || abs(position - CGFloat(target)) < 0.02)
            && midSlide > 0
        return (passed, label + String(format: ": slid back %.2f, %d reversals, at %.2f/%d, %d mid-slide, behind up to %.2f",
                                       worstBack, reversals, position, target, midSlide, worstBehind))
    }
    /// How far the pages trailed the player (its index) while it moved: they show an older habit than the header.
    private var worstBehind: CGFloat = 0
    var index = 0

    /// The pager: the window's one scroll view as wide as the screen whose content is several screens wide.
    private static func findPager() -> UIScrollView? {
        guard let window = UIApplication.shared.connectedScenes.compactMap({ ($0 as? UIWindowScene)?.keyWindow }).first
        else { return nil }
        func find(in view: UIView) -> UIScrollView? {
            if let scroll = view as? UIScrollView, scroll.bounds.width >= window.bounds.width * 0.9,
               scroll.contentSize.width > scroll.bounds.width * 1.5 { return scroll }
            for subview in view.subviews { if let found = find(in: subview) { return found } }
            return nil
        }
        return find(in: window)
    }
}
#endif
