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
            }
        }
        .tint(.ink)
        // The player has no text field (typing happens in its own sheet), so it never makes room for a keyboard.
        // A keyboard left open in the New Habit form reserved a blank band at the bottom and pushed the controls
        // up (found by the user on the iPhone, 29 Sep).
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .accessibilityIdentifier("routine-player")
        .interactiveDismissDisabled()
        .task {
            entriesBefore = Set(store.entries.map(\.id))
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
        .onAppear { TimerPresence.playerOpen = true; updateScreenAwake() }
        .onDisappear { TimerPresence.playerOpen = false; UIApplication.shared.isIdleTimerDisabled = false }
        .onChange(of: store.timers.count) { updateScreenAwake() }
        .sheet(isPresented: $showQueue) { queue }
        .sheet(isPresented: $showHabitOptions, onDismiss: habitOptionsDismissed) {
            if let habit = current { habitOptions(habit) }
        }
        .sheet(isPresented: $showEdit) { if let habit = current { EditHabitSheet(habit: habit) } }
        .sheet(isPresented: $showLog, onDismiss: manualLogFinished) {
            if let habit = current { LogProgressView(habit: habit, day: session.day) }
        }
        .alert("Couldn't save progress", isPresented: Binding(get: { store.problem != nil }, set: { if !$0 { store.problem = nil } })) {
            Button("OK", role: .cancel) { store.problem = nil }
        } message: { Text(store.problem ?? "") }
        .sensoryFeedback(.success, trigger: feedbackCount)
    }

    // MARK: The player: a playlist of habits (round 2, "Focus Player — How It Should Behave" P18–P23)

    /// Swipe between habits, or use ‹ and Up next. The finish screen is the last page.
    private var pager: some View {
        VStack(spacing: 0) {
            header
            TabView(selection: $page) {
                ForEach(Array(order.enumerated()), id: \.element.id) { position, habit in
                    habitPage(store.habits.first { $0.id == habit.id } ?? habit).tag(position)
                }
                summary.tag(order.count)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            // The save message floats over the bottom of the page, so nothing above it jumps when it appears.
            .overlay(alignment: .bottom) { if !showNote { feedbackBanner } }
            // Writing a note: the same note bar as Today, above the keyboard, in place of the controls.
            if showNote, let habit = order.first(where: { $0.id == noteHabitID }) ?? current {
                NoteBar(title: habit.name + " · " + NoteSheet.dayText(session.day, today: store.today(), calendar: store.calendar),
                        initial: store.note(of: habit, on: session.day) ?? "",
                        onSave: { store.setNote($0, of: habit, on: session.day) },
                        onClose: { withAnimation(.snappy) { showNote = false } })
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            } else if let habit = current { controls(habit) }
        }
        // Not .disabled(busy): that greyed the whole player for each save and turned the Pause/Resume button
        // dark (found by hand 29 Sep). Every action already ignores taps while a save is in progress.
        .onChange(of: page) { _, new in
            guard new != index else { return }
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
                    if habit.kind == .checklist { checklist(habit) }
                    Spacer(minLength: 48) // room for transient save/undo feedback
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
                        store.toggleStep(step, of: habit, on: session.day)
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

    /// One primary action; everything secondary has one clearly named home between the chevrons.
    private func controls(_ habit: Habit) -> some View {
        VStack(spacing: min(breathingRoom, 36)) {
            if habit.kind != .checklist || done(habit) || skipped(habit) {
                // The system's own prominent button (the user, 29 Sep: the custom style didn't feel native).
                primary(habit)
                    .accessibilityIdentifier("focus-primary")
                    .modifier(FocusPrimaryButton())
                    .frame(maxWidth: min(actionWidth, 320))
                    .frame(maxWidth: .infinity)
                    .transaction { $0.animation = nil }
            }
            navigationControls
        }
        .padding(.horizontal, 28).padding(.top, 12).padding(.bottom, 4)
        .frame(maxWidth: 540)
        .frame(maxWidth: .infinity)
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
        }
        .presentationDetents([.medium, .large])
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

    /// Navigation is visually secondary. Skip is a separate explicit action, never a chevron side effect.
    private var navigationControls: some View {
        HStack(spacing: 16) {
            Button { navigate(to: max(0, index - 1)) } label: {
                Image(systemName: "chevron.left").font(.title3.weight(.medium))
                    .frame(width: 48, height: 48).contentShape(Rectangle())
            }
            .disabled(index == 0)
            .accessibilityLabel("Previous habit")
            Spacer(minLength: 0)
            Button {
                pendingHabitAction = nil
                showHabitOptions = true
            } label: {
                Text(current?.kind == .task ? "Task options" : "Habit options")
                    .frame(minHeight: 48)
            }
            .accessibilityIdentifier("focus-habit-options")
            Spacer(minLength: 0)
            Button { advance() } label: {
                Image(systemName: "chevron.right").font(.title3.weight(.medium))
                    .frame(width: 48, height: 48).contentShape(Rectangle())
            }
            .accessibilityLabel(next.map { "Next habit: \($0.name)" } ?? "Finish routine")
            .accessibilityIdentifier("focus-up-next")
        }
        .font(.subheadline.weight(.medium))
        .buttonStyle(.borderless) // the system's highlight on press, like any toolbar button
        .foregroundStyle(.secondary)
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
                if habit.quickIncrement != nil { change("Logged") { store.increment(habit, on: session.day) } } else { openLog() }
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
                    change("Saved") { store.toggleCheck(habit, on: session.day) }
                } label: {
                    Label(store.goal(of: habit) > 1 ? "Log one" : "Mark done", systemImage: "checkmark")
                }.accessibilityLabel("Mark \(habit.name) done")
            case .amount:
                Button {
                    if habit.quickIncrement != nil { change("Saved") { store.increment(habit, on: session.day) } }
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

    private func change(_ message: String?, captureUndo: Bool = true, action: () -> Void) {
        guard !busy, !expired, session.day == store.today() else { return }
        busy = true
        let before = Set(store.entries.map(\.id))
        let habitID = current?.id
        action()
        Task { @MainActor in
            await store.flush()
            if store.problem == nil, current?.id == habitID {
                undoID = captureUndo ? store.entries.last { $0.habitID == habitID && !before.contains($0.id) }?.id : nil
                withAnimation(animation) { feedback = message }
                if message != nil { feedbackCount += 1; hideFeedbackSoon() }
            }
            busy = false
        }
    }

    /// Pause and Resume: no message and no Undo. "Paused · time saved" under the clock says what happened, and an
    /// Undo here deleted the session's time instead of un-pausing (found by hand 29 Sep).
    private func toggleTimer(_ habit: Habit) {
        // Instant, never blocked by a save in progress: each tap flips the state the person sees.
        guard !expired, session.day == store.today() else { return }
        if store.timers[habit.id] != nil { store.stopTimer(habit, on: session.day) } else { store.toggleTimer(habit) }
        withAnimation(animation) { feedback = nil; undoID = nil; undoSkipID = nil }
    }

    /// Skip today: set aside for today (neutral everywhere), and on to the next habit, with Undo.
    private func skip(_ habit: Habit) {
        guard !busy else { return }
        store.setSkipped(habit, on: session.day, true)
        let skippedID = habit.id
        navigate(to: index + 1)
        Task { @MainActor in
            await store.flush()
            withAnimation(animation) { feedback = "Skipped for today"; undoID = nil; undoSkipID = skippedID }
            feedbackCount += 1
            hideFeedbackSoon()
        }
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
            store.stopTimer(habit, on: session.day)
        }
        if let id { reviewed.insert(id) }
        feedback = nil; undoID = nil; undoSkipID = nil
        index = destination
        if page != destination { withAnimation(animation) { page = destination } }
        startCurrentTimer()
        updateScreenAwake()
    }

    private func close() {
        guard !busy else { return }
        busy = true
        Task { @MainActor in
            if let habit = current, store.timers[habit.id] != nil {
                store.stopTimer(habit, on: session.day)
            }
            await store.flush()
            busy = false
            if store.problem == nil { dismiss() }
        }
    }

    private func expire() {
        expired = true
        showQueue = false; showLog = false; showHabitOptions = false; pendingHabitAction = nil
        if let habit = current, store.timers[habit.id] != nil {
            // A routine stays on its tracking day. Do not count background time after its day ends.
            let nextDay = session.day.adding(days: 1, calendar: store.calendar).date(calendar: store.calendar)
            let end = store.calendar.date(bySettingHour: store.settings.dayEndHour, minute: 0, second: 0, of: nextDay) ?? nextDay
            store.stopTimer(habit, on: session.day, through: end)
        }
    }

    private func openLog() {
        guard !busy, !expired, session.day == store.today() else { return }
        busy = true
        Task { @MainActor in
            // Manual time and a live timer must not count the same interval twice.
            resumeAfterLog = false
            if let habit = current, habit.kind == .duration, store.timers[habit.id] != nil {
                store.stopTimer(habit, on: session.day)
                await store.flush()
                resumeAfterLog = true
            }
            busy = false
            guard store.problem == nil else { return }
            withAnimation(animation) { feedback = nil; undoID = nil }
            manualEntryIDs = Set(store.entries.map(\.id))
            showLog = true
        }
    }
    /// After Add Time / Add Amount: show what was saved, and a timer that was running runs again, Cancel included
    /// (it used to stay paused without a word, found by hand 29 Sep). Its earlier time was saved before the sheet.
    private func manualLogFinished() {
        if let habit = current, let entry = store.entries.last(where: { $0.habitID == habit.id && !manualEntryIDs.contains($0.id) }) {
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
        store.entries.last { $0.habitID == habit.id && $0.day == session.day && !entriesBefore.contains($0.id) }
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
    private func isAmount(_ habit: Habit) -> Bool { if case .amount = habit.kind { true } else { false } }
    private func amountUnit(_ habit: Habit) -> String { if case .amount(let unit, _) = habit.kind { unit } else { "" } }


}

/// The player's main button: the system's prominent button, large, in ink, full width of its slot. Native press
/// feedback and shape; the label keeps the on-ink colour so it reads in dark mode too.
private struct FocusPrimaryButton: ViewModifier {
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
private struct FocusPrimaryLabel: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 8) { configuration.icon; configuration.title }
            .font(.body.weight(.semibold))
            .foregroundStyle(Color.onInk)
            .frame(maxWidth: .infinity)
    }
}

/// The timed habit's clock, status and bar. Only this ticks, once a second, and only while its timer runs;
/// the rest of the player stays still (a full-screen timeline made the buttons flicker, found by hand 29 Sep).
private struct FocusClock: View {
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
private struct FocusProgressValue: View {
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
private struct FocusProgressCircle<Content: View>: View {
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
