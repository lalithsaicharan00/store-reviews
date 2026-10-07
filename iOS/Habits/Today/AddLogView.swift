import SwiftUI

/// One Add screen for every kind of habit, the same shape wherever it opens (7 October 2026 redesign; Rulebook U18,
/// U22): Day details' Log manually, History's Add, a Today row and its menu, a Home Screen widget, the timer screen and
/// the routine player. It replaces "Add Entry" and "Log Amount" / "Log Time": the app says "log".
///
/// Top to bottom: ✕ and a one-line title (the screen's job only); one card with Habit · [icon] name, Date ("Today" and a
/// compact date picker; any day from the habit's start to today) and Time (now by default, inside the chosen day as the
/// app counts it, never later than now); then the main thing for the kind; a footer that says exactly what will happen;
/// and the one filled button at the bottom, riding above the keyboard.
///
///   Add log (amount)    AMOUNT: one large typed number, the unit under it, the decimal pad up
///   Add log (time)      HOW LONG: hours, min, sec; the clock row is "Finished at"
///   Add a check         nothing to type: one check per add (no Times stepper, U19)
///   Mark a day done     nothing to type; off when that day is already done, and the footer says so
///   Tick steps          STEPS: tick or take back each step; Save
///   Add slip            the card's Date and Time are the slip's
struct AddLogView: View {
    let habit: Habit
    var source: EntrySource = .manual
    /// Told the new log's ID once it's on screen (a slip's Undo on Today and the habit page).
    var onAdded: ((UUID) -> Void)? = nil
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @Environment(\.dynamicTypeSize) private var typeSize
    @State private var day: LocalDay
    @State private var time: Date
    @State private var draft: ProgressValueDraft
    /// A checklist's steps as the person has set them on this screen, by ID; nil until one is tapped.
    @State private var ticked: Set<UUID>?
    @State private var confirmingDiscard = false
    @State private var focusedOnce = false
    @State private var room = ScreenRoom()
    @FocusState private var focus: RecordField?
    @ScaledMetric(relativeTo: .largeTitle) private var numberSize: CGFloat = 48
    @ScaledMetric(relativeTo: .title) private var durationSize: CGFloat = 32

    init(habit: Habit, day: LocalDay, at time: Date? = nil, source: EntrySource = .manual, onAdded: ((UUID) -> Void)? = nil) {
        self.habit = habit
        self.source = source
        self.onAdded = onAdded
        _day = State(initialValue: day)
        _time = State(initialValue: time ?? .distantPast)
        _draft = State(initialValue: ProgressValueDraft(kind: habit.kind))
    }

    private var current: Habit { store.habits.first { $0.id == habit.id } ?? habit }
    private var first: LocalDay { habit.kind == .quit ? store.quitStartDay(of: current) : store.startDay(of: current) }
    private var keyboardUp: Bool { focus != nil }
    /// The chosen time; until the screen has set it, now (or the same clock time on the day it opened on).
    private var chosenTime: Date { time == .distantPast ? defaultTime(on: day) : time }

    var body: some View {
        let today = store.today()
        let ruled = store.rule(current, on: day)
        let kind = RecordKind(current, on: day, store: store)
        let range = min(first, today)...today
        let bounds = timeBounds(kind)
        NavigationStack {
            Form {
                Section {
                    RecordHabitRow(habit: current)
                    RecordDateRow(day: $day, range: range, time: Binding(get: { chosenTime }, set: { time = $0 }), timeRange: bounds,
                                  timeTitle: kind == .time ? "Finished at" : "Time",
                                  compact: room.isSmall && keyboardUp)
                } footer: {
                    if kind != .amount && kind != .time && kind != .steps { footer(kind, ruled: ruled) }
                }
                mainSection(kind, ruled: ruled)
            }
            .accessibilityIdentifier("log-form")
            .selectsNumbersOnFocus()
            .scrollDismissesKeyboard(.interactively)
            .measuresRoom($room)
            .navigationTitle(kind.addTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    RecordCancelButton { if changed { confirmingDiscard = true } else { dismiss() } }
                }
            }
            .safeAreaInset(edge: .bottom) {
                RecordBottomBar {
                    DayButton(kind.addButton, prominent: true, id: "record-add") { add(kind, ruled: ruled) }
                        .disabled(!canAdd(kind, ruled: ruled))
                }
            }
            .alert("Discard this \(kind == .slip ? "slip" : "log")?", isPresented: $confirmingDiscard) {
                Button("Keep Editing", role: .cancel) {}
                Button("Discard Changes", role: .destructive) { dismiss() }
            }
            .task {
                if time == .distantPast { time = defaultTime(on: day) }
                guard !focusedOnce else { return }
                focusedOnce = true
                // Typing is the job: the field has the keyboard as the screen opens (minutes for a time habit). Asked
                // again once the sheet has arrived: focus asked for while a sheet slides in was sometimes dropped
                // (HabitPageUITests, 5 Oct 2026).
                let field: RecordField? = kind == .amount ? .amount : kind == .time ? .minutes : nil
                guard let field else { return }
                focus = field
                try? await Task.sleep(for: .milliseconds(400))
                if focus == nil && !draft.edited { focus = field }
            }
            .onChange(of: day) { old, new in
                // Another day keeps the same clock time, inside that day (design decisions §8, "The time of a log").
                time = store.sameClockTime(as: time == .distantPast ? defaultTime(on: old) : time, on: new)
                ticked = nil
            }
            .onPerfCommand { action in
                switch action {
                case .closeLog: dismiss()
                case .hideLogKeyboard: focus = nil
                default: break
                }
            }
        }
        .presentationDetents([.large])
        .presentationBackground(Color(.systemGroupedBackground))
        .interactiveDismissDisabled(draft.edited || ticked != nil)
    }

    // MARK: The main thing

    @ViewBuilder private func mainSection(_ kind: RecordKind, ruled: Habit) -> some View {
        switch kind {
        case .amount:
            let unit = HabitCopy.unit(of: ruled).trimmingCharacters(in: .whitespaces)
            let currency = HabitCopy.currencies.contains(unit) ? unit : nil
            Section {
                VStack(spacing: 2) {
                    AmountNumberField(draft: draft, currency: currency, size: min(numberSize, 64), focus: $focus,
                                      label: unit.isEmpty || currency != nil ? "Amount" : "Amount, in \(unit)")
                    if currency == nil && !unit.isEmpty { AmountUnitLine(draft: draft, unit: unit) }
                }
                .padding(.vertical, 12)
                .contentShape(Rectangle())
                .onTapGesture { focus = .amount }
            } header: {
                Text("Amount")
            } footer: {
                typingFooter(kind, ruled: ruled)
            }
        case .time:
            Section {
                DurationFields(draft: draft, size: min(durationSize, 44), focus: $focus)
                    .padding(.vertical, 6)
            } header: {
                Text("How long")
            } footer: {
                typingFooter(kind, ruled: ruled)
            }
        case .steps:
            let chosen = ticked ?? doneSteps(ruled)
            Section {
                ForEach(Array(ruled.steps.enumerated()), id: \.element.id) { index, step in
                    let on = chosen.contains(step.id)
                    Button {
                        var next = chosen
                        if on { next.remove(step.id) } else { next.insert(step.id) }
                        ticked = next
                    } label: {
                        Label {
                            Text(step.name).foregroundStyle(.primary)
                        } icon: {
                            Image(systemName: on ? "checkmark.circle.fill" : "circle")
                                .font(.title3)
                                .foregroundStyle(on ? current.color.color : Color.secondary)
                        }
                    }
                    .accessibilityValue(on ? "Done" : "Not done")
                    .accessibilityAddTraits(on ? .isSelected : [])
                    .accessibilityIdentifier("record-step-\(index)")
                }
            } header: {
                Text("Steps")
            } footer: {
                footer(kind, ruled: ruled)
            }
        case .check, .dayDone, .slip:
            EmptyView()
        }
    }

    /// The amount's and the session's footer: what Add does, or why the number can't be saved. Hidden while typing
    /// wherever it would reach the button (the iPhone SE and mini).
    @ViewBuilder private func typingFooter(_ kind: RecordKind, ruled: Habit) -> some View {
        if let problem = draft.problem {
            Text(problem).accessibilityIdentifier("record-problem")
        } else if !keyboardUp || room.keepsFooterWhileTyping {
            footer(kind, ruled: ruled)
        }
    }

    // MARK: Words

    /// Exactly what will happen (design decisions §8), then the paused and skipped days' notes (U5: kept from Add Entry).
    private func footer(_ kind: RecordKind, ruled: Habit) -> some View {
        Text(footerText(kind, ruled: ruled)).accessibilityIdentifier("record-footer")
    }

    private func footerText(_ kind: RecordKind, ruled: Habit) -> String {
        let c = store.calendar
        let date = DayWords.short(day, calendar: c).replacingOccurrences(of: ",", with: "")
        let clock = DayWords.clock(store.logTime(chosenTime, on: day), calendar: c)
        var text: String
        switch kind {
        case .amount:
            text = ruled.atMost ? "Records what happened. Your limit stays the same." : "Adds a new log. Other logs stay as they are."
        case .time:
            text = ruled.atMost ? "Records what happened. Your limit stays the same." : "Adds one session. Other logs stay as they are."
        case .check:
            text = "Adds one check to \(date) at \(clock). Checks already there stay."
            if !ruled.frequency.isDayBased {
                let thisPeriod = store.periodRange(ruled, containing: day)?.contains(store.today()) ?? false
                let period = DayActivity.periodWord(ruled.frequency).trimmingCharacters(in: .whitespaces)
                if !period.isEmpty { text += " It counts toward \(thisPeriod ? period : period.replacingOccurrences(of: "this", with: "that"))." }
            }
        case .dayDone:
            if store.isDayMet(ruled, on: day) {
                text = "\(date) is already done. To take it back, open that day's details."
            } else {
                text = "Marks \(date) as done at \(clock)."
                let period = DayActivity.periodWord(ruled.frequency).replacingOccurrences(of: " this ", with: "")
                if ruled.frequency.isFlexible && !period.isEmpty { text += " It counts toward that \(period)." }
            }
        case .steps:
            text = "Saves these steps for \(date) at \(clock)."
        case .slip:
            text = slipLimits.lower <= slipLimits.upper
                ? "A slip is recorded with its time. You can change or remove it later."
                : "This day is before this run started."
        }
        if store.isPaused(current, on: day) {
            text += " This day is paused. A log still goes into your history."
        } else if store.isSkipped(current, on: day) {
            text += " This day is skipped. Adding keeps the skip; undo it in the day's details."
        }
        return text
    }

    // MARK: Time

    /// Now on today; the same clock time on another day; always inside that day and never later than now.
    private func defaultTime(on day: LocalDay) -> Date {
        day == store.today() ? store.logTime(store.clock(), on: day) : store.sameClockTime(as: store.clock(), on: day)
    }

    private func timeBounds(_ kind: RecordKind) -> ClosedRange<Date> {
        if kind == .slip { let slip = slipLimits; return slip.lower...max(slip.lower, slip.upper) }
        let bounds = store.dayBounds(day)
        return bounds.lowerBound...max(bounds.lowerBound, min(bounds.upperBound, store.clock()))
    }

    /// A slip is never before its quit run began, nor later than now. `lower > upper`: the day is before the run.
    private var slipLimits: (lower: Date, upper: Date) {
        let bounds = store.dayBounds(day)
        return (max(bounds.lowerBound, min(current.quitSince ?? current.createdAt, current.createdAt)),
                min(bounds.upperBound, store.clock()))
    }

    // MARK: Adding

    private func doneSteps(_ ruled: Habit) -> Set<UUID> {
        Set(ruled.steps.filter { store.isStepDone($0, of: ruled, on: day) }.map(\.id))
    }

    /// Something typed or ticked: ✕ asks first. Worked out on a tap.
    private var changed: Bool { draft.differs || ticked != nil }

    private func canAdd(_ kind: RecordKind, ruled: Habit) -> Bool {
        guard day <= store.today() else { return false }
        switch kind {
        case .amount, .time: return draft.isValid
        case .check: return true
        case .dayDone: return !store.isDayMet(ruled, on: day)
        case .steps: return ticked.map { $0 != doneSteps(ruled) } ?? false
        case .slip: return slipLimits.lower <= slipLimits.upper
        }
    }

    private func add(_ kind: RecordKind, ruled: Habit) {
        guard canAdd(kind, ruled: ruled) else { return }
        focus = nil
        let before = Set(store.entries(of: current.id, on: day).map(\.id))
        let at = store.logTime(chosenTime, on: day)
        switch kind {
        case .amount, .time:
            if let value = draft.value { store.addProgress(current, value: value, on: day, at: at, source: source) }
        case .check:
            // One check per add (the user, 7 Oct 2026: "the whole point of check is checking it individually").
            store.addProgress(current, value: 1, on: day, at: at, source: source)
        case .dayDone:
            store.setDayDone(true, of: current, on: day, at: at, source: source)
        case .steps:
            let wanted = ticked ?? doneSteps(ruled)
            for step in ruled.steps where wanted.contains(step.id) != store.isStepDone(step, of: ruled, on: day) {
                store.toggleStep(step, of: ruled, on: day, at: at, source: source)
            }
        case .slip:
            let slip = slipLimits
            store.slip(current, on: day, at: min(max(chosenTime, slip.lower), slip.upper), source: source)
        }
        if let onAdded, let id = store.entries(of: current.id, on: day).last(where: { !before.contains($0.id) })?.id { onAdded(id) }
        // The log is on screen at once and the write follows (Rulebook S7); a failed write reloads and says so on the
        // screen underneath.
        dismiss()
    }
}
