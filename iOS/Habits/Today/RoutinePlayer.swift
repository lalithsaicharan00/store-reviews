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
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @ScaledMetric(relativeTo: .title) private var numberSize = CustomText.clockSize
    /// The habit the manual-entry sheet is for, fixed when it opens: the sheet never changes habit under the person.
    @State private var logHabitID: UUID?
    @State private var analyticsFlow = Analytics.shared.ticket
    @State private var order: [Habit]
    @State private var index = 0
    @State private var busy = false
    @State private var reviewed: Set<UUID> = []
    @State private var showQueue = false
    /// Your Routine opened as Change Order (from ⋯), or switched to it with Edit.
    @State private var queueEditing = false
    /// Milestones reached during this run, for the end page.
    @State private var reached: [HabitStore.MilestoneOffer] = []
    @State private var showLog = false
    /// The current habit's Day details, the same sheet a row opens on Today (U23).
    @State private var showDayDetails = false
    @State private var showNote = false
    /// The habit the note is for: the current one, or the one just skipped (the banner's Add Note).
    @State private var noteHabitID: UUID?
    @State private var manualEntryIDs: Set<UUID> = []
    /// The timer was running when Add Time opened; it runs again when the sheet closes (Cancel included).
    @State private var resumeAfterLog = false
    /// Entries that existed before the routine started: Undo in the player only touches this session's own.
    @State private var entriesBefore: Set<UUID> = []
    @State private var undoID: UUID?
    @State private var feedback: String?
    @State private var feedbackCount = 0
    @State private var expired = false
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
                        Label("A New Day Has Started", systemImage: "sunrise")
                    } description: {
                        Text("Your routine’s progress is saved to its own day. Go back to Today to carry on.")
                    } actions: {
                        Button { close() } label: { Text("Back to Today").foregroundStyle(Color.onInk) }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                    }
                } else {
                    pager
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Figma's title menu: the routine's name with ⌄, "1 of 3" under it; a tap opens Your Routine.
                ToolbarItem(placement: .principal) {
                    Button { queueEditing = false; showQueue = true } label: {
                        VStack(spacing: 0) {
                            HStack(spacing: 4) {
                                Text(store.section(session.part).name).font(.headline).lineLimit(1)
                                Image(systemName: "chevron.down").font(.footnote.weight(.semibold)).foregroundStyle(.secondary)
                            }
                            Text("\(min(index + 1, order.count)) of \(order.count)")
                                .font(.caption).monospacedDigit().foregroundStyle(.secondary)
                        }
                        .frame(minHeight: 44)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("\(store.section(session.part).name) routine, " +
                        (index < order.count ? "habit \(index + 1) of \(order.count)" : "the end"))
                    .accessibilityHint("Shows your routine")
                    .accessibilityIdentifier("routine-queue")
                    .disabled(expired)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", systemImage: "xmark") { close() }
                }
                ToolbarItem(placement: .primaryAction) {
                    // For the whole routine only; actions on one habit sit on its page (the user, 29 Sep).
                    Menu {
                        if let first = remaining.first, let position = order.firstIndex(where: { $0.id == first.id }), position != index {
                            Button("Go to First Unfinished", systemImage: "arrow.uturn.backward") { navigate(to: position) }
                        }
                        Button("Change Order", systemImage: "arrow.up.arrow.down") { queueEditing = true; showQueue = true }
                        Button("End Routine", systemImage: "flag.checkered") { navigate(to: order.count) }
                    } label: {
                        Label("Routine options", systemImage: "ellipsis")
                    }
                    .disabled(expired)
                }
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
                showDayDetails = true
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
        // A milestone reached on the way is kept for the end page ("Reached in this routine"); its pop-up waits.
        .onChange(of: store.milestoneOffer?.entry) {
            guard let mark = store.milestoneOffer, mark.day == session.day,
                  order.contains(where: { $0.id == mark.habit }), !reached.contains(where: { $0.entry == mark.entry }) else { return }
            reached.append(mark)
        }
        .sheet(isPresented: $showQueue) { queue.analyticsScreen(nil) }
        // Day details for the routine's day, exactly as a row on Today opens it (U23).
        .sheet(isPresented: $showDayDetails) {
            if let habit = current { DaySheet(habit: habit, day: session.day) }
        }
        // A note is written in its own sheet, as from Today (3 Oct 2026); the bottom bar stays where it is.
        .sheet(isPresented: $showNote) {
            if let habit = order.first(where: { $0.id == noteHabitID }) ?? current {
                if store.note(of: habit, on: session.day) == nil {
                    AddNoteView(habit: habit, day: session.day)
                } else {
                    NavigationStack { NoteView(habit: habit, day: session.day, startsEditing: true) }
                        .presentationDetents([.large])
                        .presentationBackground(Color(.systemGroupedBackground))
                }
            }
        }
        .sheet(isPresented: $showLog, onDismiss: manualLogFinished) {
            if let habit = store.habits.first(where: { $0.id == logHabitID }) ?? current {
                AddLogView(habit: habit, day: session.day, source: .routine)
            }
        }
        .alert("Couldn’t Save Progress", isPresented: Binding(get: { store.problem != nil }, set: { if !$0 { store.problem = nil } })) {
            Button("OK", role: .cancel) { store.problem = nil }
        } message: { Text(store.problem ?? "") }
        // No haptic of its own for a log: the store gives every log its tap, and the completion sound only when it makes
        // the habit complete (`HabitStore+Feedback`, Current Work 18).
        .onPerfCommand { action in
            switch action {
            case .nextHabit: advance()
            case .previousHabit: navigate(to: max(0, index - 1))
            case .openDay: if !showDayDetails { showDayDetails = true }
            default: break
            }
        }
        #if DEBUG
        .task { await runFastNavigationCheck() }
        .overlay(alignment: .top) {
            if let pagerCheck { Text(pagerCheck).font(.caption2).accessibilityIdentifier("focus-pager-check") }
        }
        #endif
    }

    // MARK: The player: one habit at a time (Figma's Routine player, 17 Nov 2026)

    /// Swipe between habits, or use ‹ and ›. The end page is the last page. The bottom bar is ‹, the main action and ›,
    /// or Done alone on the end page; Saved · Undo · Add Note floats just above it, so nothing under it moves.
    private var pager: some View {
        TabView(selection: $page) {
            ForEach(Array(order.enumerated()), id: \.element.id) { position, habit in
                habitPage(store.habits.first { $0.id == habit.id } ?? habit).tag(position)
            }
            summary.tag(order.count)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .accessibilityIdentifier("routine-content")
        .overlay(alignment: .bottom) { feedbackBanner }
        .safeAreaInset(edge: .bottom, spacing: 0) { bottomBar }
        // Not .disabled(busy): that greyed the whole player for each save (found by hand 29 Sep). Every action
        // already ignores taps while a save is in progress.
        .onChange(of: page) { _, new in
            guard new != index else { return }
            // While the player's own slide runs, the pager reports pages it slides past as if chosen; obeying sent the
            // player back to them (Current Work 50). Only a swipe of the person's own, outside that slide, chooses.
            if slide.running { showPage(); return }
            navigate(to: new, reviewing: new > index && current?.atMost == true ? current?.id : nil)
        }
        .onChange(of: index) { _, new in if page != new { page = new } }
    }

    /// One habit: its icon in a circle of its colour, the name, the description and Day Details, then the value, its
    /// bar and a kept place for the status or the milestone ribbon. A time habit's value is its ring, with the icon
    /// inside; a checklist is the same identity smaller, in a card, with its steps under it.
    @ViewBuilder private func habitPage(_ habit: Habit) -> some View {
        if habit.kind == .checklist {
            checklistPage(habit)
        } else {
            GeometryReader { geometry in
                ScrollView {
                    let ring = habit.kind == .duration && !skipped(habit) && !dynamicTypeSize.isAccessibilitySize
                    VStack(spacing: 32) {
                        identity(habit, icon: ring ? nil : 112)
                        if ring {
                            FocusClock(habit: habit, day: session.day, diameter: min(max(geometry.size.width - 96, 200), 260)) { openLog() }
                        } else {
                            VStack(spacing: 12) {
                                value(habit)
                                ProgressView(value: fraction(habit))
                                    .tint(habit.atMost ? Color(.systemGray) : habit.color.color)
                                    .padding(.top, 20)
                                    .accessibilityHidden(true)
                            }
                        }
                        PlayerMilestone(habit: habit, day: session.day, status: status(habit))
                    }
                    .padding(.horizontal, 40)
                    .padding(.vertical, 24)
                    .frame(maxWidth: 540)
                    .frame(minHeight: geometry.size.height)
                    .frame(maxWidth: .infinity)
                }
                .scrollBounceBehavior(.basedOnSize)
            }
        }
    }

    /// The icon (nil: none, the ring carries it), the name, the description and Day Details.
    private func identity(_ habit: Habit, icon: CGFloat?) -> some View {
        VStack(spacing: icon == 72 ? 12 : 24) {
            if let icon { HabitIcon(symbol: habit.symbol, color: habit.color, size: icon) }
            VStack(spacing: icon == 72 ? 6 : 8) {
                Text(habit.name)
                    .font(icon == 112 && dynamicTypeSize.isAccessibilitySize ? .title.weight(.semibold) : .title2.weight(.semibold))
                    .multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
                    .accessibilityAddTraits(.isHeader)
                    .accessibilityIdentifier("focus-name")
                // The habit's description (what counts, how to do it) is at hand while doing it.
                if icon != 72, let description = store.description(of: habit) {
                    Text(description)
                        .font(.body).foregroundStyle(.secondary)
                        .multilineTextAlignment(.center).lineLimit(3)
                        .accessibilityIdentifier("focus-description")
                }
                DayDetailsButton(id: "focus-day-details") { showDayDetails = true }
            }
        }
    }

    /// "Not done" / "Done" for a once-a-day check; "3 of 8 glasses" for a count; the clock's words at large text.
    @ViewBuilder private func value(_ habit: Habit) -> some View {
        let progress = store.progress(of: habit, on: session.day)
        let goal = store.goal(of: habit)
        if skipped(habit) {
            Text("Skipped").font(CustomText.clock(numberSize)).accessibilityIdentifier("focus-quantity")
        } else if habit.kind == .duration {
            // Large text: the ring gives way to the clock's words and a bar (Figma's Habit · 200% text).
            FocusClockLine(habit: habit, day: session.day, numberSize: numberSize) { openLog() }
        } else if (habit.kind == .check || habit.kind == .task) && goal <= 1 {
            Text(progress >= 1 ? "Done" : "Not done")
                .font(CustomText.clock(numberSize))
                .accessibilityIdentifier("focus-quantity")
        } else {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text(HabitCopy.number(progress)).font(CustomText.clock(numberSize))
                Text("of " + progressTarget(habit, goal: goal) + period(habit)).font(.body).foregroundStyle(.secondary)
            }
            .multilineTextAlignment(.center)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(HabitCopy.number(progress) + " of " + progressTarget(habit, goal: goal) + period(habit))
            .accessibilityIdentifier("focus-quantity")
        }
    }

    /// " this week" after a goal counted over a week, month or year; nothing for a day's.
    private func period(_ habit: Habit) -> String {
        switch habit.frequency {
        case .perWeek: " this week"
        case .perMonth: " this month"
        case .perYear: " this year"
        default: ""
        }
    }

    private func fraction(_ habit: Habit) -> Double {
        if skipped(habit) { return 0 }
        return min(1, store.progress(of: habit, on: session.day) / max(store.goal(of: habit), 0.001))
    }

    /// The words in the status place when no milestone holds it: never red, never "missed" (U3).
    private func status(_ habit: Habit) -> String? {
        if skipped(habit) { return "Skipped for today" }
        if habit.atMost {
            let over = store.progress(of: habit, on: session.day) > store.goal(of: habit)
            return "Limit " + progressTarget(habit, goal: store.goal(of: habit)).replacingOccurrences(of: " max", with: "")
                + (over ? " · Over the limit" : " · Within the limit")
        }
        return done(habit) ? "Goal met" : nil
    }

    private func progressTarget(_ habit: Habit, goal: Double) -> String {
        if habit.kind == .duration { return Format.minutes(goal) + (habit.atMost ? " max" : "") }
        let unit: String
        switch habit.kind {
        case .amount(let name, _): unit = HabitCopy.unitWord(goal, name)
        case .check: unit = habit.checkUnit.map { HabitCopy.unitWord(goal, $0) } ?? (goal == 1 ? "time" : "times")
        case .checklist: unit = habit.frequency.isDayBased ? "steps" : "days"
        default: unit = ""
        }
        return HabitCopy.number(goal) + (unit.isEmpty ? "" : " " + unit) + (habit.atMost ? " max" : "")
    }

    /// A checklist: the identity smaller, in a card with its bar and "1 of 4 steps", then the steps as rows with
    /// Reminders' circles. Many steps scroll; the bottom bar stays.
    private func checklistPage(_ habit: Habit) -> some View {
        let progress = store.progress(of: habit, on: session.day)
        let goal = store.goal(of: habit)
        return ScrollView {
            VStack(spacing: 12) {
                VStack(spacing: 16) {
                    identity(habit, icon: 72)
                    HStack(spacing: 12) {
                        // Figma's Habit progress in the card: a 12-point capsule on System Fill.
                        GeometryReader { bar in
                            Capsule().fill(Color(.systemFill))
                                .overlay(alignment: .leading) {
                                    Capsule().fill(habit.color.color)
                                        .frame(width: fraction(habit) == 0 ? 0 : max(12, bar.size.width * fraction(habit)))
                                }
                        }
                        .frame(height: 12)
                        .accessibilityHidden(true)
                        Text(HabitCopy.number(progress) + " of " + progressTarget(habit, goal: goal))
                            .font(.subheadline.weight(.semibold)).foregroundStyle(.secondary)
                            .accessibilityIdentifier("focus-checklist-progress")
                    }
                }
                .padding(.horizontal, 24).padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 32, style: .continuous))
                VStack(spacing: 0) {
                    ForEach(habit.steps) { step in
                        let checked = store.isStepDone(step, of: habit, on: session.day)
                        Button {
                            change(checked ? "Step unchecked" : "Step saved", captureUndo: !checked) {
                                store.toggleStep(step, of: habit, on: session.day, source: .routine)
                            }
                        } label: {
                            HStack(spacing: 12) {
                                Image(systemName: checked ? "checkmark.circle.fill" : "circle")
                                    .font(.title3)
                                    .foregroundStyle(checked ? habit.color.color : Color(.tertiaryLabel))
                                // A ticked step steps back to Secondary Label, as in Reminders.
                                Text(step.name).foregroundStyle(checked ? .secondary : .primary).multilineTextAlignment(.leading)
                                Spacer(minLength: 0)
                            }
                            .padding(.horizontal, 16).frame(maxWidth: .infinity, minHeight: 44)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .disabled(skipped(habit))
                        .accessibilityLabel(checked ? "Undo \(step.name)" : "Mark \(step.name) done")
                        .accessibilityIdentifier("focus-step-" + step.name)
                        if step.id != habit.steps.last?.id { Divider().padding(.leading, 52).padding(.trailing, 16) }
                    }
                }
                .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 26, style: .continuous))
                PlayerMilestone(habit: habit, day: session.day, status: skipped(habit) ? status(habit) : nil)
            }
            .padding(.horizontal, 16).padding(.bottom, 16)
            .frame(maxWidth: 540)
            .frame(maxWidth: .infinity)
        }
        .scrollBounceBehavior(.basedOnSize)
    }

    /// "Saved · Undo · Add Note", floating just above the bottom bar: Figma's Banner.
    @ViewBuilder private var feedbackBanner: some View {
        if let feedback, let id = undoID {
            Banner(text: feedback) {
                Button("Undo") { change("Undone", captureUndo: false) { store.undoEntry(id) } }
                    .accessibilityIdentifier("focus-undo")
                // The note belongs right after logging, next to Undo; never asked for (notes UX report).
                Button("Add Note") { noteHabitID = current?.id; showNote = true }
                    .accessibilityIdentifier("focus-banner-note")
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
            .transition(.opacity.combined(with: .move(edge: .bottom)))
        }
    }

    /// ‹, the main action, ›: glass buttons either side of one Prominent capsule (Figma's Bottom bar). An unfinished
    /// checklist has no main action (its steps are it), so only the arrows show. The end page has Done alone.
    private var bottomBar: some View {
        HStack(spacing: 8) {
            if index >= order.count {
                Button { close() } label: { Label("Done", systemImage: "checkmark") }
                    .modifier(FocusPrimaryButton())
                    .accessibilityIdentifier("focus-finish")
            } else {
                Button("Previous habit", systemImage: "chevron.left") { navigate(to: max(0, index - 1)) }
                    .modifier(PlayerArrow())
                    .disabled(index == 0)
                    .accessibilityIdentifier("focus-previous")
                if let habit = current, habit.kind != .checklist || done(habit) || skipped(habit) {
                    primary(habit)
                        .accessibilityIdentifier("focus-primary")
                        .modifier(FocusPrimaryButton())
                        .transaction { $0.animation = nil }
                } else {
                    Spacer()
                }
                Button("Next habit", systemImage: "chevron.right") { advance() }
                    .modifier(PlayerArrow())
                    .accessibilityLabel(next.map { "Next habit: \($0.name)" } ?? "Finish routine")
                    .accessibilityIdentifier("focus-up-next")
            }
        }
        .padding(.horizontal, 16).padding(.top, 12).padding(.bottom, 4)
        .disabled(expired)
        .opacity(expired ? 0 : 1)
    }

    /// Next habit (or the end page). Leaving a limit counts as having checked in on it.
    private func advance() {
        let leaving = current
        navigate(to: index + 1, reviewing: leaving?.atMost == true ? leaving?.id : nil)
    }

    /// One main action per type, always in the same place (P22): a word, or the symbol alone for Start, Pause and
    /// Resume, as on the Timer screen.
    @ViewBuilder private func primary(_ habit: Habit) -> some View {
        if skipped(habit) || (done(habit) && !habit.atMost) {
            Button { advance() } label: {
                Label(next == nil ? "Finish" : "Next", systemImage: next == nil ? "checkmark" : "arrow.right")
            }
        } else if habit.atMost {
            // Cut down: log what happened; it never becomes "done" (P23).
            Button {
                if habit.quickIncrement != nil { change("Saved") { store.increment(habit, on: session.day, source: .routine) } } else { openLog() }
            } label: {
                Text(habit.quickIncrement.map { "+" + Format.amount($0) } ?? "Log").frame(maxWidth: .infinity)
            }
            .accessibilityLabel(habit.quickIncrement.map { "Add \(HabitCopy.amount($0, amountUnit(habit))) to \(habit.name)" } ?? "Log for \(habit.name)")
        } else {
            switch habit.kind {
            case .check, .task:
                let several = habit.kind == .check && store.goal(of: habit) > 1
                Button {
                    // "Add a Check" adds one, as it says: a ✓ toggles its day (Rulebook U14), so a second tap for a
                    // 3-times-a-week habit took the first one back (found by ScheduleCheck, 4 Oct 2026).
                    change("Saved") {
                        if several { store.addProgress(habit, value: 1, on: session.day, source: .routine) }
                        else { store.toggleCheck(habit, on: session.day, source: .routine) }
                    }
                } label: {
                    Label(several ? "Add a Check" : "Mark Done", systemImage: "checkmark")
                }
                .accessibilityLabel("Mark \(habit.name) done")
            case .amount:
                Button {
                    if habit.quickIncrement != nil { change("Saved") { store.increment(habit, on: session.day, source: .routine) } }
                    else { openLog() }
                } label: {
                    // "+1", exactly as Today's round button: the step, never the unit (U16).
                    Text(habit.quickIncrement.map { "+" + Format.amount($0) } ?? "Log").frame(maxWidth: .infinity)
                }
                .accessibilityLabel(habit.quickIncrement.map { "Add \(HabitCopy.amount($0, amountUnit(habit))) to \(habit.name)" } ?? "Log an amount for \(habit.name)")
            case .duration:
                let running = store.timers[habit.id] != nil
                let started = store.progress(of: habit, on: session.day) > 0
                Button { toggleTimer(habit) } label: {
                    // The symbol alone, as wide and tall as a word would be (Figma's Button, Show label off).
                    Text(running ? "Pause" : started ? "Resume" : "Start").hidden()
                        .overlay { Image(systemName: running ? "pause.fill" : "play.fill") }
                        .frame(maxWidth: .infinity)
                }
                .accessibilityLabel(running ? "Stop \(habit.name) timer" : "Start \(habit.name) timer")
            case .checklist, .quit:
                EmptyView()
            }
        }
    }

    // MARK: The end page

    /// An Ink circle with ✓ (or ⋯ when some are left), what was done, what's left for later, and milestones reached on
    /// the way. A row left for later goes back to it.
    private var summary: some View {
        let left = remaining
        let finished = order.filter { covered($0) }
        return ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 16) {
                    Image(systemName: left.isEmpty ? "checkmark" : "ellipsis.circle")
                        .font(.system(size: 42, weight: .medium))
                        .foregroundStyle(Color.onInk)
                        .frame(width: 112, height: 112)
                        .background(Color.ink, in: Circle())
                        .accessibilityHidden(true)
                    VStack(spacing: 8) {
                        Text(left.isEmpty ? "\(store.section(session.part).name) is done" : "\(order.count - left.count) of \(order.count) done")
                            .font(.largeTitle.weight(.semibold))
                            .accessibilityIdentifier("focus-end-title")
                        Text(summaryText(left))
                            .font(.body).foregroundStyle(.secondary)
                    }
                    .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 24).padding(.vertical, 28)
                if !reached.isEmpty {
                    endSection("Reached in this routine") {
                        ForEach(reached, id: \.entry) { mark in
                            if let habit = order.first(where: { $0.id == mark.habit }) {
                                endRow(habit, subtitle: habit.name, title: mark.text, symbol: "medal.fill")
                            }
                        }
                    }
                }
                if !left.isEmpty {
                    endSection("Left for later") {
                        ForEach(left) { habit in
                            Button {
                                if let position = order.firstIndex(where: { $0.id == habit.id }) { navigate(to: position) }
                            } label: {
                                endRow(habit, subtitle: compactProgress(habit), chevron: true)
                            }
                            .buttonStyle(.plain)
                            .accessibilityIdentifier("end-later-" + habit.name)
                        }
                    }
                }
                if !finished.isEmpty {
                    endSection("Done") {
                        ForEach(finished) { habit in endRow(habit, subtitle: compactProgress(habit)) }
                    }
                }
            }
            .padding(.horizontal, 16).padding(.bottom, 16)
            .frame(maxWidth: 540)
            .frame(maxWidth: .infinity)
        }
        .scrollBounceBehavior(.basedOnSize)
    }

    private func summaryText(_ left: [Habit]) -> String {
        if left.isEmpty { return "All \(order.count) done today." }
        let names = left.map(\.name)
        let list = names.count == 1 ? names[0] : names.dropLast().joined(separator: ", ") + " and " + names.last!
        return "\(list) \(names.count == 1 ? "waits" : "wait") on Today. Pick \(names.count == 1 ? "it" : "them") up any time."
    }

    private func endSection<Rows: View>(_ title: String, @ViewBuilder rows: () -> Rows) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(.subheadline.weight(.semibold)).foregroundStyle(Color.ink).padding(.leading, 16)
                .accessibilityAddTraits(.isHeader)
            VStack(spacing: 0) {
                Group(subviews: rows()) { subviews in
                    ForEach(subviews.indices, id: \.self) { i in
                        subviews[i]
                        if i < subviews.count - 1 { Divider().padding(.leading, 56).padding(.trailing, 16) }
                    }
                }
            }
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 26, style: .continuous))
        }
    }

    /// One row on the end page: the habit's icon, its name (or a milestone's words) and how far it got.
    private func endRow(_ habit: Habit, subtitle: String, title: String? = nil, symbol: String? = nil, chevron: Bool = false) -> some View {
        HStack(spacing: 12) {
            HabitIcon(symbol: symbol ?? habit.symbol, color: habit.color, size: 32)
            VStack(alignment: .leading, spacing: 0) {
                Text(title ?? habit.name).foregroundStyle(.primary)
                Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer(minLength: 8)
            if chevron {
                Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
            }
        }
        .padding(.horizontal, 16).padding(.vertical, 11)
        .frame(minHeight: 64)
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
    }

    /// "Done", "4/10 min", "1/4 steps", "3/8 glasses", "Skipped", "Checked in": how far a habit got, in a row.
    private func compactProgress(_ habit: Habit) -> String {
        if skipped(habit) { return "Skipped" }
        if habit.atMost { return reviewed.contains(habit.id) ? "Checked in" : "Limit" }
        let progress = store.progress(of: habit, on: session.day)
        let goal = store.goal(of: habit)
        switch habit.kind {
        case .check, .task:
            if goal <= 1 { return progress >= 1 ? "Done" : "Not done" }
            return HabitCopy.number(progress) + "/" + progressTarget(habit, goal: goal)
        case .duration:
            return HabitCopy.number(progress.rounded(.down)) + "/" + Format.minutes(goal)
        default:
            return HabitCopy.number(progress) + "/" + progressTarget(habit, goal: goal)
        }
    }

    // MARK: Your Routine

    /// Your Routine: every habit with how far it got, a tap goes to it; Edit turns it into Change Order, where the rows
    /// drag. Moving never marks anything done, and the order is this run's only.
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
                            HStack(spacing: 12) {
                                HabitIcon(symbol: habit.symbol, color: habit.color, size: 32)
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(habit.name).foregroundStyle(.primary)
                                    Text(current?.id == habit.id && !queueEditing ? "Here now" : compactProgress(habit))
                                        .font(.subheadline).foregroundStyle(.secondary)
                                }
                                Spacer(minLength: 8)
                                if current?.id == habit.id && !queueEditing {
                                    Image(systemName: "play.fill").font(.footnote).foregroundStyle(.tertiary)
                                        .accessibilityLabel("Current habit")
                                }
                            }
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .accessibilityIdentifier("queue-" + habit.name)
                    }
                    .onMove { source, destination in
                        let id = current?.id
                        order.move(fromOffsets: source, toOffset: destination)
                        if let id, let position = order.firstIndex(where: { $0.id == id }) { index = position }
                    }
                } footer: {
                    Text(queueEditing ? "Drag to change the order for this run. Today’s order stays as it is."
                         : "Tap a habit to go to it. Moving never marks anything done.")
                }
            }
            .environment(\.editMode, .constant(queueEditing ? .active : .inactive))
            .navigationTitle(queueEditing ? "Change Order" : "Your Routine").navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", systemImage: "xmark") { showQueue = false }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(queueEditing ? "Done" : "Edit") { withAnimation { queueEditing.toggle() } }
                        .fontWeight(queueEditing ? .semibold : .regular)
                        .accessibilityIdentifier("queue-edit")
                }
            }
        }
        // Figma's Your Routine: Medium, one height, so no handle; an opaque grouped background, because the page behind
        // showed through the glass between the rows.
        .presentationDetents([.medium])
        .presentationBackground(Color(.systemGroupedBackground))
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
        withAnimation(animation) { feedback = nil; undoID = nil }
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
        feedback = nil; undoID = nil
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
        showQueue = false; showLog = false; showDayDetails = false
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

    /// The save message goes after a few seconds, like iOS's own undo toasts, so it never sits over the page
    /// (it covered a checklist's last step, found by hand 29 Sep). Undo stays in the ⋯ menu.
    private func hideFeedbackSoon() {
        let shown = feedbackCount
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(4))
            guard feedbackCount == shown else { return }
            withAnimation(animation) { feedback = nil; undoID = nil }
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
            .font(.body) // a native button's word is 17 Regular (Rulebook, Day details on iPhone)
            .foregroundStyle(Color.onInk)
            .frame(maxWidth: .infinity)
    }
}

/// The milestone ribbon under the player's progress (Figma's Milestone ribbon): what this habit's last tap reached,
/// for as long as the store offers it. Only this reads the store's milestone, so the page doesn't redraw for it (S6).
/// Its 32 points are kept while there's none, so the page never jumps; with no milestone it holds the habit's status
/// ("Goal met", "Skipped for today"), in the same place.
private struct PlayerMilestone: View {
    let habit: Habit
    let day: LocalDay
    var status: String? = nil
    @Environment(HabitStore.self) private var store
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            if let mark = store.milestoneOffer, mark.habit == habit.id, mark.day == day {
                MilestoneRibbon(text: mark.text, color: habit.color)
                    .id(mark.entry)
                    .transition(reduceMotion ? .opacity : .opacity.combined(with: .offset(y: 10)))
            } else if let status {
                Text(status).font(.subheadline).foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .accessibilityIdentifier("focus-status")
            }
        }
        .frame(minHeight: 32)
        .animation(.snappy(duration: 0.25), value: store.milestoneOffer?.entry)
    }
}

/// ‹ and › in the player's bottom bar: 48-point glass circles (Figma's Glass button, Bottom 48).
private struct PlayerArrow: ViewModifier {
    @ScaledMetric(relativeTo: .body) private var size = 48.0
    func body(content: Content) -> some View {
        let circle = content
            .labelStyle(.iconOnly)
            .font(.body.weight(.medium))
            .frame(width: size, height: size)
            .contentShape(Circle())
        if #available(iOS 26, *) {
            circle.buttonStyle(.plain).glassEffect(.regular.interactive(), in: Circle()).foregroundStyle(Color.ink)
        } else {
            circle.buttonStyle(.plain).background(.regularMaterial, in: Circle()).foregroundStyle(Color.ink)
        }
    }
}

/// A time habit at large text: the clock's words and "of 10 min" in place of the ring (Figma's Habit · 200% text);
/// the bar under it is the page's. Only this ticks, and only while its timer runs (S3).
private struct FocusClockLine: View {
    let habit: Habit
    let day: LocalDay
    let numberSize: CGFloat
    let onTapClock: () -> Void
    @Environment(HabitStore.self) private var store
    private static let never = Date.distantFuture

    var body: some View {
        let start = store.timers[habit.id]
        TimelineView(.periodic(from: start ?? Self.never, by: 1)) { context in
            let progress = store.progress(of: habit, on: day, now: start == nil ? .now : context.date)
            let target = Format.minutes(store.goal(of: habit)) + (habit.atMost ? " max" : "")
            Button(action: onTapClock) {
                VStack(spacing: 4) {
                    Text(Format.clock(progress)).font(CustomText.clock(numberSize)).monospacedDigit()
                    Text("of " + target).font(.body).foregroundStyle(.secondary)
                }
            }
            .buttonStyle(.plain)
            .accessibilityLabel(Format.clock(progress) + " of " + target)
            .accessibilityHint("Logs time manually")
            .accessibilityIdentifier("focus-clock")
        }
    }
}

/// The timed habit's clock: Figma's Timer ring. Only this ticks, once a second, and only while its timer runs; the
/// rest of the screen stays still (a full-screen timeline made the buttons flicker, found by hand 29 Sep). Inside the
/// ring: the habit's icon (28, its colour), the clock (`CustomText.timer`, SF Pro Light 64, tabular figures) and its
/// goal ("of 10 min", Body, Secondary Label). A tap on the clock types time.
struct FocusClock: View {
    let habit: Habit
    let day: LocalDay
    let diameter: CGFloat
    /// The Timer screen says Paused under the ring itself (Figma's Timer screen); the player keeps it inside.
    var showsState = true
    let onTapClock: () -> Void
    @Environment(HabitStore.self) private var store
    @ScaledMetric(relativeTo: .largeTitle) private var clockSize = CustomText.timerSize

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
        let value = Format.clock(progress)
        let target = Format.minutes(goal) + (habit.atMost ? " max" : "")
        return FocusProgressCircle(progress: progress, goal: goal, color: habit.color.color, limit: habit.atMost,
                                   diameter: diameter) {
            Image(systemName: habit.symbol)
                .font(.title)
                .foregroundStyle(habit.color.color)
                .accessibilityHidden(true)
            // A time habit always shows its clock (the user, 7 Oct 2026: "Show clock" was removed). A tap types time.
            Button(action: onTapClock) {
                VStack(spacing: 0) {
                    Text(value)
                        .font(CustomText.timer(clockSize))
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    Text("of " + target)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
            }
            .buttonStyle(.plain)
            .accessibilityLabel(value + " of " + target)
            .accessibilityValue(FocusProgressValue.period(habit))
            .accessibilityHint("Logs time manually")
            .accessibilityIdentifier("focus-clock")
            // Always there, invisible while running, so Pause doesn't push the icon and clock up.
            if showsState {
                Text(running ? "Paused" : progress > 0 ? "Paused" : "Not started")
                    .font(.caption).foregroundStyle(.secondary)
                    .opacity(running ? 0 : 1)
                    .accessibilityHidden(running)
            }
            if habit.atMost && progress > goal {
                // Never red (U3): over a limit is said in words, in the same grey as the ring.
                Text("Over limit").font(.caption).foregroundStyle(.secondary)
            }
        }
        .transaction { $0.animation = nil }
    }
}

/// The period a goal counts over, for VoiceOver on a clock ("This week") and the Timer screen's subtitle.
enum FocusProgressValue {
    static func period(_ habit: Habit) -> String {
        switch habit.frequency {
        case .perWeek: "This week"
        case .perMonth: "This month"
        case .perYear: "This year"
        default: "Today"
        }
    }
}

/// The ring round the player's and the timer's middle (Figma's Timer ring): the same current ÷ goal as the words
/// inside it, for every kind of habit. A `ProgressRing`, 10 thick on System Fill (the Progress bar's track, never the
/// habit's Fill), filling clockwise from the top in the habit's colour. A limit (cut-down) is System Gray, never the
/// habit's colour or red (A41, U3).
struct FocusProgressCircle<Content: View>: View {
    let progress: Double
    let goal: Double
    let color: Color
    let limit: Bool
    let diameter: CGFloat
    @ViewBuilder var content: Content

    var body: some View {
        ZStack {
            ProgressRing(fraction: progress / max(goal, 0.001), tint: limit ? Color(.systemGray) : color,
                         size: diameter, lineWidth: 10, track: Color(.systemFill))
                .accessibilityHidden(true)
            VStack(spacing: 8) { content }
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
