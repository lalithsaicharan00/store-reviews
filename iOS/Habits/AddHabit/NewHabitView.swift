import SwiftUI

/// What the user wants to make: the form each choice opens. Build or maintain asks how to track it first
/// (the user tried one screen on 29 Sep and kept the two steps); the form shows only that type's rows.
enum ItemType: String, CaseIterable, Identifiable {
    case doIt, amount, time, checklist, cutBack, quit, task
    var id: Self { self }

    /// The form's title. Copy from "Habit Flow Copy — Deep Research Report" (28 Sep): "Track an amount"
    /// replaces "Count it" because amounts can be decimals and units like km, not only counts.
    var title: String {
        switch self {
        case .doIt: "Check it off"
        case .amount: "Track an amount"
        case .time: "Time it"
        case .checklist: "Checklist"
        case .cutBack: "Cut down"
        case .quit: "Quit"
        case .task: "Task"
        }
    }

    /// One plain line under the title on the choice screens.
    var summary: String {
        switch self {
        case .doIt: "Done or not done."
        case .amount: "How many or how much."
        case .time: "How long, with a timer."
        case .checklist: "A short list to tick off."
        case .cutBack: "Set a maximum and log how much."
        case .quit: "Stop completely. Track time since you stopped."
        case .task: "Something to get done."
        }
    }

    /// A common habit that can only be recorded one way (copy report, 28 Sep): a bed is never counted or
    /// timed, water is counted in glasses, meditation is timed.
    var example: String {
        switch self {
        case .doIt: "Make your bed"
        case .amount: "Drink 8 glasses of water"
        case .time: "Meditate for 10 minutes"
        case .checklist: "Clean kitchen — dishes, sink, floor"
        case .cutBack: "Log coffees, up to 2 a day"
        case .quit: "Time since you last smoked"
        case .task: "Pay the rent"
        }
    }

    /// The name field's hint.
    var namePlaceholder: String {
        switch self {
        case .doIt: "Name, e.g. Make bed"
        case .amount: "Name, e.g. Drink water"
        case .time: "Name, e.g. Meditate"
        case .checklist: "Name, e.g. Clean kitchen"
        case .cutBack: "Name, e.g. Coffee"
        case .quit: "e.g. Smoking"
        case .task: "e.g. Pay the rent"
        }
    }

    /// A plain SF Symbol for the choice rows (research: "Goal Screen Round 2", T1). Monochrome.
    var icon: String {
        switch self {
        case .doIt: "checkmark.circle"
        case .amount: "number"
        case .time: "timer"
        case .checklist: "list.bullet.clipboard"
        case .cutBack: "gauge.with.dots.needle.33percent"
        case .quit: "nosign"
        case .task: "calendar"
        }
    }

    /// Everything except tasks counts toward the free habit limit.
    var isHabit: Bool { self != .task }
    /// The four ways to build or maintain a habit.
    var isBuild: Bool { [.doIt, .amount, .time, .checklist].contains(self) }
}

/// The screen behind +: "What do you want to do?", then, for habits, how to track it; then one
/// form. Each question is its own list, pushed in the same sheet, so every step looks and moves
/// the same way (spec: iOS/Docs/Specs/New Habit Goal and Time of Day.md §1).
struct NewItemView: View {
    /// The group Today is filtered to: a habit made while looking at it goes in it.
    var group: UUID? = nil
    /// Called with the new habit's ID, so Today can show where it went.
    var onAdded: (UUID) -> Void = { _ in }
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss

    private enum Kind: Hashable { case good, bad }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink(value: Kind.good) {
                        ChoiceLabel(icon: "chart.line.uptrend.xyaxis", title: "Build or maintain", detail: "A habit you want to start or keep doing.")
                    }
                    NavigationLink(value: Kind.bad) {
                        ChoiceLabel(icon: "chart.line.downtrend.xyaxis", title: "Quit or cut down", detail: "A habit you want to stop or do less.")
                    }
                    NavigationLink {
                        form(.task)
                    } label: {
                        ChoiceLabel(icon: ItemType.task.icon, title: "Add a task", detail: "Something to get done, once or on repeat. No habit progress, streaks or stats.")
                    }
                } header: {
                    // No examples on this screen: the labels name what the user wants to do (copy report).
                    QuestionHeader("What do you want to do?")
                } footer: {
                    if !store.isPlus {
                        Text("\(store.activeHabitCount) of \(HabitStore.freeHabitLimit) free habits used. Tasks are always free.").formNote()
                    }
                }
            }
            .navigationDestination(for: Kind.self) { kind in
                switch kind {
                case .good: question("How do you want to track it?", [.doIt, .amount, .time, .checklist])
                case .bad: question("What do you want to do?", [.quit, .cutBack])
                }
            }
            .navigationTitle("New")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
            }
        }
    }

    /// The second question: the same list style as the first.
    private func question(_ text: String, _ types: [ItemType]) -> some View {
        List {
            Section {
                ForEach(types) { type in
                    NavigationLink {
                        form(type)
                    } label: {
                        ChoiceLabel(icon: type.icon, title: type.title, detail: type.summary, example: type.example)
                    }
                }
            } header: {
                QuestionHeader(text)
            }
        }
        .navigationTitle(types.contains(.quit) ? "Quit or cut down" : "Build or maintain")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func form(_ type: ItemType) -> some View {
        if type.isHabit && !store.canAddHabit {
            PlusView()
        } else {
            HabitForm(type: type, group: group, onSaved: { onAdded($0); dismiss() })
        }
    }
}

/// The question at the top of a choice list, in plain words, large enough to read first.
struct QuestionHeader: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.title3.weight(.semibold))
            .foregroundStyle(Color.primary)
            .textCase(nil)
            .padding(.bottom, 2)
            .accessibilityAddTraits(.isHeader)
    }
}

/// A choice row: a plain icon in a fixed column, the title, one plain line and (on the second screens) a
/// marked example. The separator starts at the text, as in Settings (research: "Goal Screen Round 2", T2).
struct ChoiceLabel: View {
    let icon: String
    let title: String
    let detail: String
    var example: String? = nil

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 22, weight: .regular))
                .foregroundStyle(Color.primary)
                .frame(width: 30)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.body.weight(.semibold))
                Text(detail).font(.subheadline).foregroundStyle(.secondary)
                if let example { Text("Example: \(example)").font(.subheadline).foregroundStyle(.secondary) }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .alignmentGuide(.listRowSeparatorLeading) { $0[.leading] }
        }
        .padding(.vertical, 8)
        .accessibilityElement(children: .combine)
    }
}

/// The form for one type, laid out like the Round 3 mockup (the user's choice, 29 Sep): the habit read back
/// as a sentence; name, icon and colour; How much, Each + adds and How often (only the rows the type needs);
/// Time of Day and Reminders; then Starts and Ends. Every row starts filled with a suggestion
/// (`HabitDefaults`), and the line under the sentence says which ones. Anything needing its own page is
/// pushed, never a sheet, so the whole flow moves one way.
struct HabitForm: View {
    enum Field: Hashable { case name, description, amount, unit, increment, minutes, item(UUID) }

    /// One reminder. `part` is the time of day it's for (nil for Anytime); its time stays inside that part.
    struct DraftTime: Identifiable, Hashable {
        var id = UUID()
        var time: Date
        var part: String?
    }

    let type: ItemType
    let onSaved: (UUID) -> Void
    /// Editing: the group as saved.
    private let originalGroup: UUID?
    /// Editing: the habit as saved. The form opens filled in, shows only what can change (how it's tracked is
    /// fixed and never shown, spec §8) and saves with Save.
    private let original: Habit?

    @Environment(HabitStore.self) private var store
    @Environment(ReminderScheduler.self) private var scheduler
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    /// What counts, how to do it, why it matters: optional, shown in the routine player (notes report, 29 Sep).
    @State private var descriptionText = ""
    /// The description as saved, when editing.
    private var originalDescription = ""
    @State private var symbol: String
    @State private var pickedSymbol = false
    @State private var color: HabitColor
    @State private var showAppearance = false

    /// How much (amounts and limits: typed, with a unit) or how long (Time it: hours and minutes).
    /// They start as the suggestion for the name, and follow it until the person changes them.
    @State private var amountText: String
    @State private var unit: String
    @State private var hours: String
    @State private var minutes: String
    /// Each + adds: nil keeps the suggested step, which follows the amount and unit.
    @State private var step: Double?
    /// Track an amount: what + does on Today, chosen here. Off: adds the step. On: asks how much (29 Sep).
    @State private var asksHowMuch = false
    @State private var often = OftenDraft()
    /// Tasks: once on a date, or on a schedule.
    @State private var taskRepeats = false
    /// A checklist's steps.
    @State private var items: [Step] = []
    @State private var quitSince = Date.now
    @State private var taskDate = Date.now
    @State private var taskHasTime = false
    @State private var taskTime = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: .now)!

    /// A repeating task's schedule (tasks keep their own Repeat screen, with "after it's done").
    @State private var schedule = ScheduleDraft()
    /// Where it shows on Today: Anytime, or one or more parts of the day.
    @State private var timesOfDay: [String] = [.anytime]
    @State private var addingSection = false
    @State private var didSetUp = false
    /// Remind Me: off by default (the user, 29 Sep; it was on with one reminder since 28 Sep). Turning it
    /// on brings one reminder per time of day.
    @State private var remindOn = false
    @State private var times: [DraftTime] = []
    @State private var showColors = false
    @State private var startDate = Calendar.current.startOfDay(for: .now)
    @State private var hasEnd = false
    @State private var endDate = Calendar.current.startOfDay(for: .now)
    /// Until the user edits a reminder, the reminders follow the chosen times of day.
    @State private var remindersEdited = false
    @State private var alert: AlertStyle = .notification
    @State private var followUp: Int?
    /// Its group (Build Plan #68): optional; the row shows once any group exists. A new habit made while Today is
    /// filtered to a group starts in it (so it doesn't vanish from the list it was added to), and the row says so.
    @State private var groupID: UUID?

    @State private var notificationsDenied = false
    @State private var alarmsDenied = false
    @State private var confirmDiscard = false
    @FocusState private var focus: Field?

    init(type: ItemType, group: UUID? = nil, onSaved: @escaping (UUID) -> Void) {
        self.type = type
        self.onSaved = onSaved
        original = nil
        originalGroup = nil
        _groupID = State(initialValue: group)
        _color = State(initialValue: .blue)
        _symbol = State(initialValue: type == .quit ? "nosign" : type == .task ? "calendar" : "star.fill")
        // Amounts start empty (left out of the sentence): the right amount depends on the person. How often starts
        // as every day and Time of Day as Anytime (the user, 29 Sep).
        let start = HabitDefaults.suggest(type, name: "")
        _amountText = State(initialValue: "")
        _unit = State(initialValue: "")
        _hours = State(initialValue: "0")
        _minutes = State(initialValue: "0")
        var draft = OftenDraft()
        draft.choose(start.often)
        _often = State(initialValue: draft)
    }

    /// Opens the form on a saved habit, every row as it is now.
    init(editing habit: Habit, weekStart: Int, description: String = "", group: UUID? = nil, onSaved: @escaping (UUID) -> Void) {
        type = ItemType(habit)
        self.onSaved = onSaved
        original = habit
        originalGroup = group
        _groupID = State(initialValue: group)
        originalDescription = description
        _descriptionText = State(initialValue: description)
        _name = State(initialValue: habit.name)
        _symbol = State(initialValue: habit.symbol)
        _pickedSymbol = State(initialValue: true)
        _color = State(initialValue: habit.color)
        var amountText = "", unit = "", hours = "0", minutes = "0"
        switch habit.kind {
        case .amount(let u, let increment):
            amountText = GoalNumber.text(habit.goal); unit = u
            _step = State(initialValue: increment > 0 ? increment : nil)
            _asksHowMuch = State(initialValue: increment <= 0)
        case .duration where habit.atMost:
            // Cut down has one amount field; minutes as its unit make it timed.
            amountText = GoalNumber.text(habit.goal); unit = HabitPlan.timeUnit
        case .duration:
            hours = String(Int(habit.goal) / 60); minutes = String(Int(habit.goal) % 60)
        default: break
        }
        _amountText = State(initialValue: amountText)
        _unit = State(initialValue: unit)
        _hours = State(initialValue: hours)
        _minutes = State(initialValue: minutes)
        let cal = Calendar.current
        let start = (habit.startsOn ?? LocalDay(habit.createdAt)).date(calendar: cal)
        var draft = OftenDraft()
        draft.seed(start: start, weekStart: weekStart)
        draft.choose(HowOften(habit))
        _often = State(initialValue: draft)
        _items = State(initialValue: habit.steps)
        _quitSince = State(initialValue: habit.quitSince ?? habit.createdAt)
        _taskRepeats = State(initialValue: habit.kind == .task && habit.dueDay == nil)
        if let due = habit.dueDay { _taskDate = State(initialValue: due.date(calendar: cal)) }
        if let minute = habit.dueMinute {
            _taskHasTime = State(initialValue: true)
            _taskTime = State(initialValue: Self.date(minute: minute))
        }
        _timesOfDay = State(initialValue: habit.parts.isEmpty ? [.anytime] : habit.parts)
        _remindOn = State(initialValue: habit.remind && !habit.reminders.isEmpty)
        _times = State(initialValue: habit.reminders.map { DraftTime(id: $0.id, time: Self.date(minute: $0.minuteOfDay), part: nil) })
        _remindersEdited = State(initialValue: true)
        _startDate = State(initialValue: cal.startOfDay(for: start))
        _hasEnd = State(initialValue: habit.endsOn != nil)
        _endDate = State(initialValue: habit.endsOn.map { $0.date(calendar: cal) } ?? cal.startOfDay(for: start))
        _alert = State(initialValue: habit.alert)
        _followUp = State(initialValue: habit.followUpMinutes)
    }

    private var editing: Bool { original != nil }
    /// The edited habit as it would be saved, keeping what the form doesn't show.
    private var edited: Habit? {
        guard let original else { return nil }
        var habit = makeHabit()
        habit.id = original.id
        habit.createdAt = original.createdAt
        habit.archived = original.archived
        // Kept as saved where the form has no row for it: a check's unit ("3 cups"), no start date on older
        // habits, and the reminder switch of a habit without reminders.
        if type == .doIt { habit.checkUnit = original.checkUnit }
        if habit.startsOn == LocalDay(habit.createdAt) && original.startsOn == nil { habit.startsOn = nil }
        if habit.reminders.isEmpty && original.reminders.isEmpty { habit.remind = original.remind }
        return habit
    }
    private var editChanged: Bool {
        (edited.map { $0 != original } ?? false) || TextLimit.clean(descriptionText, TextLimit.descriptionText) != originalDescription
            || groupID != originalGroup
    }

    private var trimmedName: String { TextLimit.clean(name, TextLimit.name) }
    private var filledItems: [Step] {
        items.compactMap { item in
            let name = TextLimit.clean(item.name, TextLimit.checklistPart)
            return name.isEmpty ? nil : Step(id: item.id, name: name)
        }
    }
    private var remind: Bool { remindOn && !times.isEmpty }
    private var hasChanges: Bool { editing ? editChanged : !trimmedName.isEmpty || !filledItems.isEmpty }
    private var isHabit: Bool { type.isBuild || type == .cutBack }
    /// How it's tracked: the type chosen before the form.
    private var kind: ItemType { type }
    private var hasAmount: Bool { kind == .amount || kind == .time || kind == .cutBack }
    private var timed: Bool { kind == .time }
    /// A time amount can't be longer than its period ("3 h a week" is fine, "30 h a day" isn't).
    private var amountPeriod: GoalPeriod {
        if case .total(let period) = often.often(hasAmount: true), often.choice == .total { return period }
        return .day
    }
    private var amountValue: Double? {
        guard hasAmount else { return nil }
        if timed { return GoalDraft(hours: hours, minutes: minutes).duration(max: amountPeriod.maxMinutes) }
        guard let n = GoalNumber.parse(amountText), n > 0 else { return nil }
        return n
    }
    /// The habit's how much and how often, as chosen: the one source for the read-back, Today and saving.
    private var plan: HabitPlan {
        var plan = HabitPlan(amount: amountValue, unit: timed ? HabitPlan.timeUnit : TextLimit.clean(unit, TextLimit.unit), step: step,
                             often: often.often(hasAmount: hasAmount), atMost: type == .cutBack, checklist: kind == .checklist)
        plan.asks = type == .amount && asksHowMuch
        return plan
    }
    /// "2 chapters", "30 min": the amount as the How often choices say it.
    private var amountWords: String? {
        guard let value = plan.amount else { return nil }
        return plan.isTimed ? HabitCopy.minutes(value) : HabitCopy.amount(value, plan.unit)
    }
    private var weekStart: Int { store.settings.weekStart }
    private var canAdd: Bool {
        guard !trimmedName.isEmpty else { return false }
        if hasAmount && amountValue == nil { return false }
        if type == .checklist && filledItems.isEmpty { return false }
        if isHabit, case .weekdays(let days) = plan.often, days.isEmpty { return false }
        if isHabit, case .calendar(let rule) = plan.often {
            if rule.unit == .week && rule.weekdays.isEmpty { return false }
            if rule.unit == .month && rule.pattern == .dates && rule.dates.isEmpty { return false }
        }
        return true
    }

    // MARK: Suggestions

    private func suggestion(for name: String) -> HabitDefaults {
        HabitDefaults.suggest(kind == .checklist ? .doIt : kind, name: name)
    }

    /// The amount the name suggests, as the amount field's hint only ("e.g. 10000"); never filled in.
    private var amountHint: String? {
        let s = HabitDefaults.suggest(type == .cutBack ? .cutBack : .amount, name: name)
        guard s.amount != 1 || !s.unit.isEmpty, s.amount != 3 || !s.unit.isEmpty else { return nil }
        return "e.g. " + GoalNumber.text(s.amount) + (s.unit.isEmpty ? "" : " " + s.unit)
    }

    var body: some View {
        Form {
            if isHabit || type == .task { previewSection }
            nameSection
            switch type {
            case .quit:
                quitSection
                if showsGroup { Section { groupRow } }
            case .task:
                taskSection
                if taskRepeats { Section { repeatRow } }
                Section {
                    timeOfDayRow
                    if showsGroup { groupRow }
                    remindersRow
                }
                if taskRepeats { startEndSection }
            default:
                planSection
                if type == .amount { tapSection }
                Section {
                    timeOfDayRow
                    if showsGroup { groupRow }
                    remindersRow
                }
                startEndSection
            }
            if editing { editOutcomeSection }
        }
        .accessibilityIdentifier("habit-form")
        .navigationTitle(editing ? (type == .task ? "Edit Task" : "Edit Habit") : isHabit && type != .cutBack ? "New Habit" : type.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
        .navigationBarBackButtonHidden(hasChanges)
        .toolbar {
            if hasChanges || editing {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { if hasChanges { confirmDiscard = true } else { dismiss() } }
                        .confirmationDialog("Discard this?", isPresented: $confirmDiscard, titleVisibility: .hidden) {
                            Button("Discard Changes", role: .destructive) { dismiss() }
                            Button("Keep Editing", role: .cancel) {}
                        }
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button(editing ? "Save" : "Add", action: save).disabled(!canAdd || editing && !editChanged).fontWeight(.semibold)
                    .accessibilityIdentifier("add-habit")
            }
            ToolbarItemGroup(placement: .keyboard) {
                if focus != nil {
                    Spacer()
                    Button("Done") { focus = nil }.fontWeight(.semibold)
                }
            }
        }
        .interactiveDismissDisabled(hasChanges)
        // Icon and colour are quick picks, so they pop up over the form (the user's choice).
        .sheet(isPresented: $showAppearance) {
            NavigationStack {
                IconSheet(symbol: $symbol, color: color) { pickedSymbol = true; showAppearance = false }
                    .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Done") { showAppearance = false } } }
            }
        }
        .sheet(isPresented: $showColors) {
            NavigationStack {
                Form { ColorGrid(selection: Binding(get: { color }, set: { color = $0; showColors = false })) }
                    .navigationTitle("Colour")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Done") { showColors = false } } }
            }
            .presentationDetents([.height(260)])
        }
        .onChange(of: name) { old, new in
            // A wrapping field puts Return into the text; treat it as Done instead.
            if name.contains("\n") { name = name.replacingOccurrences(of: "\n", with: ""); focus = nil }
            suggestIcon()
        }
        .onChange(of: startDate) { if endDate < startDate { endDate = startDate } }
        .task {
            // Runs again when a pushed page pops back; set up only once, so the
            // user's colour, cursor and reminders are never reset.
            guard !didSetUp else { return }
            didSetUp = true
            if editing {
                // Each saved reminder belongs to the time of day it falls in, so it stays inside it.
                times = times.map { var t = $0; t.part = partFor(t.time); return t }
            } else {
                color = store.suggestedColor()
                focus = .name
                if type != .quit { syncReminders(force: true) }
            }
            notificationsDenied = await scheduler.isDenied()
            alarmsDenied = scheduler.alarmsDenied()
        }
    }

    // MARK: Name, icon, colour

    /// The name on its own row; icon and colour side by side below it, each opening a quick pick.
    private var nameSection: some View {
        Section {
            TextField(type.namePlaceholder, text: $name, axis: .vertical)
                .lineLimit(1...2)
                .font(.body.weight(.semibold))
                .focused($focus, equals: .name)
                .limitText($name, to: TextLimit.name)
                .submitLabel(.done)
                .onSubmit { focus = nil }
                .accessibilityLabel("Name")
                .accessibilityIdentifier("name-field")
                .frame(minHeight: 36)
            HStack(spacing: 0) {
                Button { focus = nil; showAppearance = true } label: {
                    HStack(spacing: 10) {
                        HabitIcon(symbol: symbol, color: color, size: 28)
                        Text("Icon").foregroundStyle(Color.primary)
                        Spacer(minLength: 0)
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.borderless)
                .accessibilityLabel("Icon")
                Divider().padding(.horizontal, 12)
                Button { focus = nil; showColors = true } label: {
                    HStack(spacing: 10) {
                        Circle().fill(color.color.gradient).frame(width: 24, height: 24)
                        Text("Colour").foregroundStyle(Color.primary)
                        Spacer(minLength: 0)
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.borderless)
                .accessibilityLabel("Colour, \(color.name)")
            }
            .frame(minHeight: 44)
            if type != .quit {
                TextField("Description (optional)", text: $descriptionText, axis: .vertical)
                    .lineLimit(1...4)
                    .focused($focus, equals: .description)
                    .limitText($descriptionText, to: TextLimit.descriptionText)
                    .accessibilityIdentifier("description-field")
            }
        } footer: {
            if let note = TextLimit.note(name, TextLimit.name) { Text(note).formNote() }
            else if focus == .description { Text("What counts, or how to do it. Shown while you do it.").formNote() }
        }
    }

    // MARK: Rows that open full screens

    /// A row that opens its own full screen: the setting on the left, the choice on the right.
    private func screenRow<Destination: View>(_ title: String, value: String, @ViewBuilder destination: @escaping () -> Destination) -> some View {
        NavigationLink {
            destination()
        } label: {
            LabeledContent(title) {
                Text(value).foregroundStyle(.secondary).multilineTextAlignment(.trailing)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .accessibilityLabel("\(title), \(value)")
    }

    /// Groups are invisible until the person makes one (Day Structure report §2.8: never forced).
    private var showsGroup: Bool { !store.groups.isEmpty || groupID != nil }

    /// Group: what area of life it's in, beside Time of Day (when). Optional; None by default.
    private var groupRow: some View {
        screenRow("Group", value: groupID.flatMap { id in store.groups.first { $0.id == id }?.name } ?? "None") {
            GroupPicker(selection: $groupID)
                .onAppear { focus = nil }
        }
        .accessibilityIdentifier("group-row")
    }

    /// A repeating task's How often: the habit screen without counts, plus "After it's done" (29 Sep).
    private var repeatRow: some View {
        screenRow("How often", value: often.often(hasAmount: false).label(hasAmount: false, weekStart: weekStart)) {
            HowOftenEditor(draft: $often, amountText: nil, checklist: false, limit: false, start: startDate,
                           weekStart: weekStart, sentence: screenText, task: true)
                .onAppear { focus = nil }
        }
        .accessibilityIdentifier("how-often-row")
    }

    // MARK: The sentence, how much and how often

    /// The whole habit in one sentence: name, how much, how often and the parts of the day ("Read twice a
    /// day, morning and afternoon"). The same sentence heads every screen the form opens (the user, 29 Sep).
    private var fullSentence: String {
        if type == .task && !taskRepeats { return oneTimeTaskText(name: previewHabit.name) }
        // Before an amount is set it's simply left out ("Drink water every day, anytime"), the same as Check it
        // off: no dash anywhere (the user, 29 Sep).
        let text = HabitCopy.sentence(amountValue == nil && hasAmount ? withoutAmount(previewHabit) : previewHabit, weekStart: weekStart)
        let parts = timesOfDay == [.anytime] ? "anytime" : HabitCopy.partsPhrase(timesOfDay.map { store.section($0).name })
        return text + ", " + parts
    }

    /// The sentence heading the screens the form opens: before a name, only how much and how often ("Every
    /// day", "3 times a week", "8 glasses a day"); with a name, the whole sentence (the user, 29 Sep).
    /// "Pay rent today", "Book dentist on Wed, 1 Oct", with its time if it has one.
    private func oneTimeTaskText(name: String) -> String {
        let day = dayWords(taskDate)
        var text = name + (["Today", "Tomorrow", "Yesterday"].contains(day) ? " " + day.lowercased() : " on " + day)
        if taskHasTime { text += " at " + taskTime.formatted(date: .omitted, time: .shortened) }
        return text
    }

    private var screenText: String {
        guard !trimmedName.isEmpty else {
            // No amount yet either: just the rhythm, as the How often row says it.
            if hasAmount && amountValue == nil {
                return plan.often.label(hasAmount: true, weekStart: weekStart)
            }
            var habit = previewHabit
            habit.name = ""
            return HabitCopy.sentence(habit, weekStart: weekStart)
        }
        return fullSentence
    }

    /// The habit read as done-or-not, for the sentence before its amount is set.
    private func withoutAmount(_ habit: Habit) -> Habit {
        var habit = habit
        habit.kind = .check
        habit.goal = 1
        return habit
    }

    /// Before an amount is set, the preview card carries a stand-in amount (so it shows its + or ▶) and no line.
    private static let standIn = 7_777_777.0
    private var amountStandIn: String? {
        guard hasAmount && amountValue == nil else { return nil }
        return timed ? HabitCopy.minutes(Self.standIn) : HabitCopy.number(Self.standIn)
    }

    /// The habit as the previews show it: "Your habit" until named, and the stand-in amount until set, so
    /// the row already has its +, ▶ or ✓.
    private var previewHabit: Habit {
        var habit = draft
        if habit.name.isEmpty { habit.name = type == .task ? "Your task" : "Your habit" }
        if hasAmount && amountValue == nil {
            var stand = plan
            stand.amount = Self.standIn
            stand.step = step ?? 1
            stand.apply(to: &habit)
        }
        return habit
    }

    /// The visual preview: the habit drawn by Today's own row, under a centred "Preview" label.
    private var previewSection: some View {
        Section {
            HabitRow(habit: previewHabit, day: LocalDay(.now), isToday: true, time: remind ? previewHabit.reminders.first : nil,
                     lineOverride: amountStandIn == nil ? nil : "")
                .allowsHitTesting(false)
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Preview on Today")
                .accessibilityIdentifier("today-preview")
        } header: {
            Text("Preview")
                .frame(maxWidth: .infinity, alignment: .center)
        } footer: {
            // The text preview, right under the card: the whole habit once it has a name.
            Group {
                if trimmedName.isEmpty {
                    Text(type == .task ? "Enter a task name to see the preview." : "Enter a habit name to see the preview.")
                        .font(.callout).foregroundStyle(.secondary)
                } else {
                    Text(fullSentence)
                        .font(.system(.title3, design: .rounded).weight(.bold))
                        .foregroundStyle(Color.primary)
                        .contentTransition(.opacity)
                        .animation(.snappy, value: fullSentence)
                }
            }
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity)
            // A little air under the card, and a clear gap before the name: the previews are one group.
            .padding(.top, 10)
            .padding(.bottom, 18)
            .accessibilityAddTraits(.isHeader)
            .accessibilityIdentifier("habit-sentence")
        }
    }

    /// How much, what + adds, and how often: the rows that make the sentence above, only as the type needs.
    private var planSection: some View {
        Section {
            switch type {
            case .amount, .cutBack:
                screenRow(type == .cutBack ? "Limit" : "How much", value: amountValue == nil ? "Set" : plan.howMuchLabel) {
                    HowMuchEditor(mode: type == .cutBack ? .limit : .amount, amount: $amountText, unit: $unit, hours: $hours,
                                  minutes: $minutes, usedUnits: store.usedUnits, period: amountPeriod, sentence: screenText, hint: amountHint)
                        .onAppear { focus = nil }
                }
                .accessibilityIdentifier("how-much-row")
            case .time:
                screenRow("How long", value: amountValue == nil ? "Set" : plan.howMuchLabel) {
                    HowMuchEditor(mode: .time, amount: $amountText, unit: $unit, hours: $hours, minutes: $minutes,
                                  usedUnits: store.usedUnits, period: amountPeriod, sentence: screenText, hint: amountHint)
                        .onAppear { focus = nil }
                }
                .accessibilityIdentifier("how-much-row")
            case .checklist:
                screenRow("Steps", value: filledItems.isEmpty ? "Add" : filledItems.count == 1 ? "1 step" : "\(filledItems.count) steps") {
                    Form { ChecklistItemsSection(items: $items) }
                        .stickySentence(screenText, id: "screen-sentence")
                        .navigationTitle("Steps")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .accessibilityIdentifier("steps-row")
            default:
                EmptyView()
            }
            screenRow("How often", value: plan.often.label(hasAmount: plan.hasAmount, checklist: plan.checklist, weekStart: weekStart)) {
                HowOftenEditor(draft: $often, amountText: amountWords, checklist: plan.checklist, limit: type == .cutBack,
                               start: startDate, weekStart: weekStart, sentence: screenText, amountExpected: hasAmount)
                    .onAppear { focus = nil }
            }
            .accessibilityIdentifier("how-often-row")
        }
    }

    /// What + does on Today, chosen, never a hidden rule: add a set step ("+1 glass", good for small counts),
    /// or type the amount each time (good for big or odd amounts: steps, ml). Research: "Logging a Count — One
    /// Tap or Type" (13 reviews want one tap; "tapping +1 80 times for an 80m run is exhausting"), Round 3 §1.3
    /// (19 statements type the odd amount, 13 want a step of their own). Tapping the habit always types.
    private var tapSection: some View {
        Section {
            CheckRow(title: "Add a set amount", selected: !asksHowMuch) { withAnimation { asksHowMuch = false } }
                .accessibilityIdentifier("tap-adds-step")
            if !asksHowMuch {
                NumberRow(title: "Each tap adds", value: $step, placeholder: HabitCopy.number(plan.stepValue),
                          suffix: HabitCopy.unitWord(plan.stepValue, plan.unit), focus: $focus, field: .increment)
                    .padding(.leading, 22)
                    .font(.subheadline)
            }
            CheckRow(title: "Type the amount each time", selected: asksHowMuch) {
                focus = nil
                withAnimation { asksHowMuch = true }
            }
            .accessibilityIdentifier("tap-asks")
        } header: {
            Text("When you tap +")
        } footer: {
            Text(asksHowMuch ? "Tap + to type how much you did."
                 : "Each tap on + adds \(HabitCopy.amount(plan.stepValue, plan.unit)).").formNote()
        }
    }

    /// "Today", "Tomorrow", "Yesterday", or "Wed 1 Oct": the start as a person says it.
    private func dayWords(_ date: Date) -> String {
        let cal = Calendar.current
        if cal.isDateInToday(date) { return "Today" }
        if cal.isDateInTomorrow(date) { return "Tomorrow" }
        if cal.isDateInYesterday(date) { return "Yesterday" }
        let sameYear = cal.component(.year, from: date) == cal.component(.year, from: .now)
        return sameYear ? date.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated))
            : date.formatted(.dateTime.day().month(.abbreviated).year())
    }

    /// Starts and Ends, in words ("Today", "Never"); each opens its own screen to pick a date.
    private var startEndSection: some View {
        Section {
            // "Started" for a day in the past, as a person would say it.
            screenRow(startDate < Calendar.current.startOfDay(for: .now) ? "Started" : "Starts", value: dayWords(startDate)) {
                Form {
                    Section {
                        DatePicker("Starts", selection: $startDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .accessibilityIdentifier("start-date-picker")
                    } footer: {
                        Text("A start date in the past lets you tick the days since then.").formNote()
                    }
                    if !Calendar.current.isDateInToday(startDate) {
                        Section {
                            Button("Start Today") { startDate = Calendar.current.startOfDay(for: .now) }
                        }
                    }
                }
                .stickySentence(screenText, id: "screen-sentence")
                .navigationTitle("Starts")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear { focus = nil }
            }
            .accessibilityIdentifier("starts-row")
            screenRow("Ends", value: hasEnd ? dayWords(endDate) : "Never") {
                Form {
                    Section {
                        CheckRow(title: "Never", selected: !hasEnd) { withAnimation { hasEnd = false } }
                        CheckRow(title: "On a Date", selected: hasEnd) {
                            withAnimation {
                                if !hasEnd && endDate <= startDate {
                                    endDate = Calendar.current.date(byAdding: .day, value: 30, to: startDate) ?? startDate
                                }
                                hasEnd = true
                            }
                        }
                    }
                    if hasEnd {
                        Section {
                            DatePicker("Ends", selection: $endDate, in: startDate..., displayedComponents: .date)
                                .datePickerStyle(.graphical)
                                .accessibilityIdentifier("end-date-picker")
                        } footer: {
                            Text("After \(endDate.formatted(.dateTime.day().month(.wide))), it leaves Today. Its history stays.").formNote()
                        }
                    }
                }
                .stickySentence(screenText, id: "screen-sentence")
                .navigationTitle("Ends")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear { focus = nil }
            }
            .accessibilityIdentifier("ends-row")
        }
    }

    private var quitSection: some View {
        Section {
            DatePicker("Started", selection: $quitSince, in: ...Date.now)
        } footer: {
            Text("The counter runs from here. It shows at the top of Today under Quitting, counting up.").formNote()
        }
    }

    /// Editing an old task must keep its saved date, even when only its name changes.
    private var earliestTaskDate: Date {
        let today = Calendar.current.startOfDay(for: .now)
        return original?.dueDay.map { min(today, Calendar.current.startOfDay(for: $0.date())) } ?? today
    }

    /// A task: once on a date, or on repeat. Never progress or stats (the user's decision).
    private var taskSection: some View {
        Section {
            Picker("Repeat", selection: $taskRepeats.animation()) {
                Text("Never").tag(false)
                Text("On a schedule").tag(true)
            }
            if !taskRepeats {
                DatePicker("Date", selection: $taskDate, in: earliestTaskDate..., displayedComponents: .date)
            }
            Toggle("Time", isOn: $taskHasTime.animation()).tint(.green)
            if taskHasTime {
                DatePicker("At", selection: $taskTime, displayedComponents: .hourAndMinute)
            }
        } footer: {
            Text((taskRepeats ? "It comes back on the days you pick below."
                  : "If it isn't done, it moves forward to today until it is.") + " Tasks don't have progress or stats.").formNote()
        }
    }

    // MARK: How often, part of day, reminders

    // MARK: Time of day, reminders

    /// The habit as it would be saved, so the form's sentences use the same rules as Today.
    private var draft: Habit { makeHabit() }

    /// Tapping a time of day: the parts of the day always combine; Anytime stands alone.
    private func choose(_ id: String) {
        if id == .anytime {
            timesOfDay = [.anytime]
        } else {
            var chosen = timesOfDay.filter { $0 != .anytime }
            if let i = chosen.firstIndex(of: id) { chosen.remove(at: i) } else { chosen.append(id) }
            let order = store.sections.map(\.id)
            timesOfDay = chosen.isEmpty ? [.anytime] : chosen.sorted { (order.firstIndex(of: $0) ?? 99) < (order.firstIndex(of: $1) ?? 99) }
        }
        syncReminders()
    }

    /// "Anytime", "Morning", "Morning and Evening".
    private var timeOfDaySummary: String {
        HabitCopy.join(timesOfDay.map { store.section($0).name })
    }

    /// Where it's displayed on Today (never the goal). Its own full screen: the parts of the day, any
    /// number of them, then "Or", then Anytime (GOV.UK's exclusive-checkbox pattern).
    private var timeOfDayRow: some View {
        screenRow("Time of Day", value: timeOfDaySummary) {
            Form {
                Section {
                    ForEach(store.sections.filter { !$0.isAnytime }) { section in
                        CheckRow(title: section.name, detail: Outcome.hours(section, store: store),
                                 selected: timesOfDay.contains(section.id)) { choose(section.id) }
                    }
                } header: {
                    Text("Pick one or more")
                }
                Section {
                    CheckRow(title: "Anytime", detail: "No set time", selected: timesOfDay == [.anytime]) { choose(.anytime) }
                } header: {
                    Text("Or")
                }
                Section {
                    AddRow(title: "New Time of Day") { focus = nil; addingSection = true }
                } footer: {
                    Text(Outcome.timeOfDay(draft, store: store)).formNote()
                }
            }
            .stickySentence(isHabit || type == .task ? screenText : nil, id: "screen-sentence")
            .navigationTitle("Time of Day")
            .navigationBarTitleDisplayMode(.inline)
            // Pushed from here, so saving comes back to this list with the new one ticked (attached to
            // the form, it replaced this screen and Save jumped back to the form; found 28 Sep).
            .navigationDestination(isPresented: $addingSection) {
                SectionEditor(existing: nil) { id in choose(id) }
            }
        }
    }

    /// A reminder stays inside its time of day: Morning's reminder can only be set in the morning.
    private func range(for part: String?) -> ClosedRange<Date> {
        let day = Calendar.current.startOfDay(for: .now)
        guard let part, let timed = store.timedSections.first(where: { $0.section.id == part }) else {
            return day...day.addingTimeInterval(24 * 3600 - 60)
        }
        let start = day.addingTimeInterval(Double(timed.section.start! * 60))
        let end = day.addingTimeInterval(Double((timed.end - 1) * 60))
        return start...max(start, end)
    }

    private func label(for reminder: DraftTime) -> String {
        reminder.part.map { "\(store.section($0).name) reminder" } ?? "Reminder"
    }

    /// "9:00 AM", "9:00 AM and 6:00 PM", "3 reminders", "Off": what the Reminders row says.
    private var remindersSummary: String {
        guard remind else { return "Off" }
        let sorted = times.map(\.time).sorted { Self.minute(of: $0) < Self.minute(of: $1) }
        if sorted.count > 2 { return "\(sorted.count) reminders" }
        return HabitCopy.join(sorted.map { $0.formatted(date: .omitted, time: .shortened) })
    }

    /// Reminders on their own screen (the user's choice, 29 Sep); the row says when.
    private var remindersRow: some View {
        screenRow("Reminders", value: remindersSummary) {
            Form { remindersSections }
                .stickySentence(isHabit || type == .task ? screenText : nil, id: "screen-sentence")
                .navigationTitle("Reminders")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear { focus = nil }
        }
        .accessibilityIdentifier("reminders-row")
    }

    /// Reminders: one by default, any number more, each inside a chosen time of day. How to be reminded
    /// sits in the section right below, close together, and only while there's a reminder.
    @ViewBuilder
    private var remindersSections: some View {
        Section {
            Toggle("Remind Me", isOn: $remindOn.animation())
                .tint(.green)
                // Turning it on brings one reminder per chosen time of day, unless the person already set their own.
                .onChange(of: remindOn) { if remindOn && (times.isEmpty || !remindersEdited) { syncReminders(force: true) } }
        } header: {
            Text("Reminders")
        } footer: {
            if !remindOn { Text("No reminders. You'll see it on Today.").formNote() }
        }
        if remindOn {
            Section {
                ForEach($times) { $reminder in
                    HStack(spacing: 12) {
                        RemoveButton(label: "Remove reminder") { removeReminder(reminder.id) }
                        // Only the user's own change marks reminders as edited, not the form following Time of Day.
                        DatePicker(label(for: reminder), selection: Binding(get: { reminder.time }, set: { reminder.time = $0; remindersEdited = true }),
                                   in: range(for: reminder.part), displayedComponents: .hourAndMinute)
                    }
                }
                AddRow(title: times.isEmpty ? "Add Reminder" : "Add Another Reminder", action: addReminder)
            }
            .listSectionSpacing(.compact)
            if !times.isEmpty {
                Section {
                    if ReminderScheduler.alarmsAvailable {
                        Picker("Remind Me With", selection: $alert) {
                            Text("A Notification").tag(AlertStyle.notification)
                            Text("An Alarm").tag(AlertStyle.alarm)
                        }
                        .onChange(of: alert) {
                            guard alert == .alarm else { return }
                            Task {
                                let allowed = await scheduler.requestAlarmPermission()
                                alarmsDenied = !allowed
                                if !allowed { alert = .notification }
                            }
                        }
                    }
                    // A limit is never "not done", so it never reminds again.
                    if type != .cutBack {
                        Picker("If Not Done, Remind Again", selection: $followUp) {
                            Text("Never").tag(Int?.none)
                            Text("Every 15 min").tag(Int?.some(15))
                            Text("Every 30 min").tag(Int?.some(30))
                            Text("Every hour").tag(Int?.some(60))
                        }
                    }
                } footer: {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(Outcome.reminders(draft, store: store, alarmsAvailable: ReminderScheduler.alarmsAvailable)).formNote()
                        if notificationsDenied {
                            Text("Notifications are off for Habits, so these won't arrive. Turn them on in Settings.").formNote()
                            Button("Open Settings") {
                                if let url = URL(string: UIApplication.openSettingsURLString) { UIApplication.shared.open(url) }
                            }
                            .font(.callout.weight(.semibold))
                        }
                    }
                }
                .listSectionSpacing(.compact)
            }
        }
    }

    private static func minute(of date: Date) -> Int {
        let c = Calendar.current.dateComponents([.hour, .minute], from: date)
        return (c.hour ?? 0) * 60 + (c.minute ?? 0)
    }

    private static func date(minute: Int) -> Date {
        Calendar.current.date(bySettingHour: (minute / 60) % 24, minute: minute % 60, second: 0, of: .now)!
    }

    /// A reminder an hour into a time of day (or halfway, for a short one); 9:00 AM for Anytime.
    /// A to-do with a time is reminded at that time.
    private func defaultMinute(for id: String) -> Int {
        if type == .task && taskHasTime { return Self.minute(of: taskTime) }
        guard let timed = store.timedSections.first(where: { $0.section.id == id }) else { return 9 * 60 }
        return (timed.section.start! + min(60, (timed.end - timed.section.start!) / 2)) % (24 * 60)
    }

    /// Until the user changes a reminder, there's one per chosen time of day, at a time inside it.
    private func syncReminders(force: Bool = false) {
        guard force || (remind && !remindersEdited) else { return }
        let ids = timesOfDay
        times = ids.enumerated().map { i, id in
            DraftTime(id: times.indices.contains(i) ? times[i].id : UUID(), time: Self.date(minute: defaultMinute(for: id)),
                      part: id == .anytime ? nil : id)
        }
    }

    /// Another reminder for the part of the day with the fewest, an hour after its last one if that fits.
    private func addReminder() {
        if times.isEmpty { syncReminders(force: true); return }
        remindersEdited = true
        let parts: [String?] = timesOfDay == [.anytime] ? [nil] : timesOfDay.map { Optional($0) }
        let part = parts.min { a, b in times.filter { $0.part == a }.count < times.filter { $0.part == b }.count } ?? nil
        let range = range(for: part)
        let last = times.last { $0.part == part }?.time
        let next = last.map { min($0.addingTimeInterval(3600), range.upperBound) } ?? Self.date(minute: defaultMinute(for: part ?? .anytime))
        withAnimation { times.append(DraftTime(time: max(range.lowerBound, next), part: part)) }
    }

    private func removeReminder(_ id: UUID) {
        remindersEdited = true
        withAnimation { times.removeAll { $0.id == id } }
    }

    /// The chosen time of day a saved reminder falls in (nil for Anytime).
    private func partFor(_ time: Date) -> String? {
        let c = Calendar.current.dateComponents([.hour, .minute], from: time)
        let id = store.section(forMinute: (c.hour ?? 0) * 60 + (c.minute ?? 0)).id
        return timesOfDay.contains(id) && id != .anytime ? id : nil
    }

    /// What saving will do, in one line, before Save (spec §8.4).
    @ViewBuilder private var editOutcomeSection: some View {
        if let original, let habit = edited, type != .quit {
            Section {} footer: {
                Text(type == .task ? "Changes apply from today."
                     : store.editRestartsStreak(original, habit) ? "Your streak restarts. Your history stays."
                     : "Changes apply from today. Your history stays as it was.")
                    .formNote()
                    .accessibilityIdentifier("edit-outcome")
            }
        }
    }

    // MARK: Helpers

    private func suggestIcon() {
        guard !pickedSymbol, let suggestion = IconSuggester.symbol(for: name) else { return }
        symbol = suggestion
    }

    /// The habit as chosen. Used for the live sentences too, so the form and Today always agree.
    private func makeHabit() -> Habit {
        var habit = Habit(name: trimmedName, symbol: symbol, color: color, kind: .check)
        let cal = Calendar.current
        switch type {
        case .doIt, .amount, .time, .checklist, .cutBack:
            plan.apply(to: &habit)
            if plan.checklist { habit.steps = filledItems }
        case .quit:
            habit.kind = .quit
            habit.quitSince = quitSince
        case .task:
            habit.kind = .task
            // A repeating task has no date: it comes back on its schedule.
            habit.dueDay = taskRepeats ? nil : LocalDay(taskDate)
            if taskRepeats { habit.frequency = often.often(hasAmount: false).frequency(hasAmount: false, checklist: false) }
            if taskHasTime {
                let c = cal.dateComponents([.hour, .minute], from: taskTime)
                habit.dueMinute = (c.hour ?? 9) * 60 + (c.minute ?? 0)
            }
        }
        if type != .quit { habit.parts = timesOfDay }
        // Reminders only when Remind Me is on: one per minute, keeping each one's ID, earliest first.
        if remind && type != .quit {
            var seen = Set<Int>()
            habit.reminders = times.compactMap { draft in
                let c = cal.dateComponents([.hour, .minute], from: draft.time)
                let time = ReminderTime(id: draft.id, hour: c.hour ?? 9, minute: c.minute ?? 0)
                return seen.insert(time.minuteOfDay).inserted ? time : nil
            }
            .sorted { store.dayMinute($0.minuteOfDay) < store.dayMinute($1.minuteOfDay) }
        }
        habit.remind = remind
        // Start and end dates: for habits and repeating tasks (a one-time task has only its date).
        if isHabit || (type == .task && taskRepeats) {
            habit.startsOn = LocalDay(startDate)
            habit.endsOn = hasEnd ? LocalDay(max(endDate, startDate)) : nil
        }
        habit.alert = ReminderScheduler.alarmsAvailable ? alert : .notification
        habit.followUpMinutes = habit.atMost ? nil : followUp
        return habit
    }

    private func save() {
        guard canAdd else { return }
        focus = nil
        if let habit = edited {
            if habit.remind && !habit.reminders.isEmpty { Task { _ = await scheduler.requestPermission() } }
            store.update(habit)
            store.setDescription(descriptionText, of: habit.id)
            if groupID != originalGroup { store.setGroup(groupID, of: habit.id) }
            onSaved(habit.id)
            dismiss()
            return
        }
        let habit = makeHabit()
        // Reminders are on by default, so permission is asked when the habit is saved, not before.
        if habit.remind && !habit.reminders.isEmpty { Task { _ = await scheduler.requestPermission() } }
        store.add(habit)
        store.setDescription(descriptionText, of: habit.id)
        if let groupID, store.groups.contains(where: { $0.id == groupID }) { store.setGroup(groupID, of: habit.id) }
        onSaved(habit.id)
    }
}

// MARK: - Rows

/// The checklist's items, on the pushed Items screen. It keeps its own focus, so Add Item puts the
/// cursor in the new row (the form's focus doesn't reach a pushed screen; found on the iPhone, 28 Sep).
struct ChecklistItemsSection: View {
    @Binding var items: [Step]
    @FocusState private var focused: UUID?

    var body: some View {
        Section {
            ForEach($items) { $item in
                HStack(spacing: 12) {
                    RemoveButton(label: "Remove \(item.name.isEmpty ? "step" : item.name)") {
                        withAnimation { items.removeAll { $0.id == item.id } }
                    }
                    TextField(items.first?.id == item.id ? "e.g. Dishes" : "Next step", text: $item.name)
                        .focused($focused, equals: item.id)
                        .limitText($item.name, to: TextLimit.checklistPart)
                        .submitLabel(.next)
                        .onSubmit(addItem)
                }
            }
            .onDelete { items.remove(atOffsets: $0) }
            AddRow(title: "Add Step", action: addItem)
        } header: {
            Text("Steps")
        } footer: {
            Text("A few steps to tick. They reset each time it comes round, and the habit is done when every step is ticked.").formNote()
        }
    }

    private func addItem() {
        let item = Step(name: "")
        withAnimation { items.append(item) }
        // After the row exists, so the field can take focus.
        DispatchQueue.main.async { focused = item.id }
    }
}

extension View {
    /// The habit's sentence pinned at the top of a screen the New Habit form opens, so it stays in view while
    /// the choices scroll under it (the user, 29 Sep). Nil shows nothing.
    @ViewBuilder func stickySentence(_ text: String?, id: String) -> some View {
        if let text {
            safeAreaInset(edge: .top, spacing: 0) {
                Text(text)
                    .font(.system(.title3, design: .rounded).weight(.bold))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(.bar)
                    .overlay(alignment: .bottom) { Divider() }
                    .contentTransition(.opacity)
                    .animation(.snappy, value: text)
                    .accessibilityAddTraits(.isHeader)
                    .accessibilityIdentifier(id)
            }
        } else {
            self
        }
    }
}

extension Text {
    /// The sentences under a form group: a size people can read at a glance, not the tiny default.
    func formNote() -> some View { font(.callout).foregroundStyle(.secondary) }
}

/// A number the whole row edits: tap anywhere in the row to type. Empty until the user types;
/// the grey placeholder is only a hint.
struct NumberRow: View {
    let title: String
    @Binding var value: Double?
    let placeholder: String
    let suffix: String
    var focus: FocusState<HabitForm.Field?>.Binding
    let field: HabitForm.Field
    /// What's typed. The value follows it key by key, so the previews update as the person types (29 Sep);
    /// a number-formatted field only committed on leaving it.
    @State private var text = ""

    var body: some View {
        HStack(spacing: 6) {
            Text(title).lineLimit(1).fixedSize()
            Spacer(minLength: 16)
            // Not fixedSize: a field sized to its placeholder clipped what was typed (reported 28 Sep).
            TextField(placeholder, text: $text)
                .onAppear { text = value.map(GoalNumber.text) ?? "" }
                .onChange(of: text) { value = GoalNumber.parse(text).flatMap { $0 > 0 ? $0 : nil } }
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .focused(focus, equals: field)
                .frame(minWidth: 44, maxWidth: 160)
                .font(.body.monospacedDigit().weight(.semibold))
                .accessibilityLabel(title)
            if !suffix.isEmpty { Text(suffix).foregroundStyle(.secondary).lineLimit(1).truncationMode(.tail) }
        }
        .frame(minHeight: 44)
        .contentShape(Rectangle())
        .onTapGesture { focus.wrappedValue = field }
    }
}

/// A list row chosen with a checkmark, like Settings and Clock's Repeat: the whole row is the button.
struct CheckRow: View {
    let title: String
    var detail: String? = nil
    let selected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).foregroundStyle(Color.primary)
                    if let detail { Text(detail).font(.subheadline).foregroundStyle(.secondary) }
                }
                Spacer(minLength: 8)
                Image(systemName: "checkmark").fontWeight(.semibold).foregroundStyle(Color.ink).opacity(selected ? 1 : 0)
            }
            .frame(minHeight: 44)
            .contentShape(Rectangle())
        }
        .accessibilityLabel(title)
        .accessibilityAddTraits(selected ? .isSelected : [])
    }
}

/// The red ⊖ used by editable lists in Health and Contacts.
struct RemoveButton: View {
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "minus.circle.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .red)
                .font(.title3)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
    }
}

/// The green ⊕ row that adds to an editable list.
struct AddRow: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: "plus.circle.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .green)
                    .font(.title3)
                Text(title).foregroundStyle(Color.primary)
            }
        }
        .accessibilityLabel(title)
    }
}

// MARK: - Pickers

/// 13 system colours as circles, like the Reminders list sheet.
struct ColorGrid: View {
    @Binding var selection: HabitColor

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 7), spacing: 12) {
            ForEach(HabitColor.allCases, id: \.self) { c in
                Button { selection = c } label: {
                    Circle().fill(c.color.gradient)
                        .frame(width: 34, height: 34)
                        .overlay {
                            if c == selection {
                                Circle().stroke(Color(.systemGray3), lineWidth: 3).padding(-5)
                            }
                        }
                        .frame(width: 44, height: 44)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(c.name)
                .accessibilityAddTraits(c == selection ? .isSelected : [])
            }
        }
        .padding(.vertical, 6)
    }
}

/// Seven toggles, starting from the user's week start.
struct WeekdayPicker: View {
    @Binding var selection: Set<Int>
    let firstWeekday: Int
    @Environment(\.dynamicTypeSize) private var dynamicType

    var body: some View {
        let symbols = Calendar.current.veryShortStandaloneWeekdaySymbols
        let full = Calendar.current.standaloneWeekdaySymbols
        let order = (0..<7).map { (firstWeekday - 1 + $0) % 7 + 1 }
        let layout = dynamicType.isAccessibilitySize ? AnyLayout(VStackLayout(alignment: .leading, spacing: 6)) : AnyLayout(HStackLayout(spacing: 2))
        layout {
            ForEach(order, id: \.self) { day in
                let on = selection.contains(day)
                Button {
                    if on { if selection.count > 1 { selection.remove(day) } } else { selection.insert(day) }
                } label: {
                    Text(dynamicType.isAccessibilitySize ? full[day - 1] : symbols[day - 1])
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(on ? Color.onInk : Color.primary)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(Capsule().fill(on ? Color.ink : Color(.tertiarySystemFill)))
                        .overlay(alignment: .topTrailing) {
                            if on { Image(systemName: "checkmark.circle.fill").font(.caption2).foregroundStyle(Color.ink, Color(.systemBackground)).accessibilityHidden(true) }
                        }
                }
                .buttonStyle(.plain)
                .accessibilityLabel(full[day - 1])
                .accessibilityValue(on ? "Selected" : "Not selected")
                .accessibilityAddTraits(on ? .isSelected : [])
            }
        }
        .padding(.vertical, 4)
    }
}

/// 1–31, like the Calendar app's monthly repeat.
struct MonthDatePicker: View {
    @Binding var selection: Set<Int>
    @ScaledMetric(relativeTo: .body) private var cellSize = 44.0

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: cellSize), spacing: 2)], spacing: 6) {
            ForEach(1...31, id: \.self) { date in
                let on = selection.contains(date)
                Button {
                    if on { if selection.count > 1 { selection.remove(date) } } else { selection.insert(date) }
                } label: {
                    Text("\(date)")
                        .font(.subheadline.weight(.semibold).monospacedDigit())
                        .foregroundStyle(on ? Color.onInk : Color.primary)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(Capsule().fill(on ? Color.ink : Color(.tertiarySystemFill)))
                        .overlay(alignment: .topTrailing) {
                            if on { Image(systemName: "checkmark.circle.fill").font(.caption2).foregroundStyle(Color.ink, Color(.systemBackground)).accessibilityHidden(true) }
                        }
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Day \(date)")
                .accessibilityAddTraits(on ? .isSelected : [])
            }
        }
        .padding(.vertical, 4)
    }
}

/// Units grouped by what people track, most used first (research: "Goal Screen Round 2", T8), with
/// "Create Your Own Unit" first, in the same green ⊕ row the form uses to add things.
struct UnitPicker: View {
    /// Check it off only offers things done one at a time; Cut down adds the usual things to cut.
    enum Mode { case tick, amount, limit }

    @Binding var unit: String
    let used: [String]
    var mode: Mode = .amount
    /// Track an amount: the unit is optional, so "No Unit" is a choice too.
    var allowsNone = false
    @Environment(\.dismiss) private var dismiss
    @State private var creating = false
    @State private var custom = ""
    @FocusState private var typing: Bool

    private static var metric: Bool { Locale.current.measurementSystem != .us }

    /// The phone's currency first.
    private static var money: [String] {
        let own = Locale.current.currency?.identifier == "INR" ? "₹" : Locale.current.currencySymbol ?? "$"
        return [own] + ["$", "€", "£", "₹"].filter { $0 != own }
    }

    var groups: [(String, [String])] {
        let volume = Self.metric ? ["ml", "litres", "oz"] : ["oz", "ml", "litres"]
        let distance = Self.metric ? ["km", "miles"] : ["miles", "km"]
        switch mode {
        case .tick:
            return [("Everyday", ["times", "meals", "pills", "sessions"]),
                    ("Drinking", ["glasses", "cups", "bottles"]),
                    ("Exercise", ["reps", "sets", "push-ups", "workouts", "laps"]),
                    ("Reading and writing", ["pages", "chapters", "books"])]
        case .amount, .limit:
            // Time isn't a unit here: Time it is its own type, with ▶ on Today.
            var list: [(String, [String])] = [
                ("Drinking", ["glasses", "cups", "bottles"] + volume),
                ("Walking and running", ["steps"] + distance),
                ("Reading and writing", ["pages", "chapters", "books", "words"]),
                ("Exercise", ["reps", "sets", "push-ups", "workouts", "laps"]),
                ("Everyday", ["times", "meals", "servings", "sessions", "pills"]),
                ("Money", Self.money),
            ]
            if mode == .limit { list.insert(("Cutting down", ["cigarettes", "drinks", "coffees", "snacks"]), at: 0) }
            return list
        }
    }

    var body: some View {
        List {
            Section {
                if creating {
                    HStack {
                        TextField("e.g. prayers", text: $custom)
                            .focused($typing)
                            .limitText($custom, to: TextLimit.unit)
                            .submitLabel(.done)
                            .onSubmit(useCustom)
                            .accessibilityIdentifier("custom-unit")
                        Button("Done", action: useCustom).fontWeight(.semibold)
                            .disabled(custom.trimmingCharacters(in: .whitespaces).isEmpty)
                    }
                } else {
                    AddRow(title: "Create Your Own Unit") {
                        withAnimation { creating = true }
                        typing = true
                    }
                    .accessibilityIdentifier("create-unit")
                }
                if allowsNone {
                    Button {
                        unit = ""
                        dismiss()
                    } label: {
                        HStack {
                            Text("No Unit").foregroundStyle(Color.primary)
                            Spacer(minLength: 16)
                            if unit.trimmingCharacters(in: .whitespaces).isEmpty { Image(systemName: "checkmark").foregroundStyle(Color.ink).fontWeight(.semibold) }
                        }
                    }
                    .accessibilityIdentifier("no-unit")
                }
                let known = Set(groups.flatMap(\.1))
                ForEach(used.reversed().filter { !known.contains($0) && !["minutes", "hours"].contains($0) }, id: \.self, content: row)
            } header: {
                Text("Your own")
            } footer: {
                Text(TextLimit.note(custom, TextLimit.unit) ?? "Anything you count, in a word or two: prayers, laps, sets.")
            }
            ForEach(groups, id: \.0) { group in
                Section(group.0) { ForEach(group.1, id: \.self, content: row) }
            }
        }
        .navigationTitle("Unit")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func row(_ value: String) -> some View {
        Button {
            unit = value
            dismiss()
        } label: {
            HStack {
                Text(value == HabitPlan.timeUnit ? "Hours and minutes" : value).foregroundStyle(Color.primary).lineLimit(1)
                Spacer(minLength: 16)
                if value == unit { Image(systemName: "checkmark").foregroundStyle(Color.ink).fontWeight(.semibold) }
            }
        }
    }

    private func useCustom() {
        let value = TextLimit.clean(custom, TextLimit.unit)
        guard !value.isEmpty else { return }
        unit = value
        dismiss()
    }
}

extension ItemType {
    /// How a saved habit is tracked, for the edit form (fixed after creation, spec §8).
    init(_ habit: Habit) {
        switch habit.kind {
        case .check: self = .doIt
        case .amount: self = habit.atMost ? .cutBack : .amount
        case .duration: self = habit.atMost ? .cutBack : .time
        case .checklist: self = .checklist
        case .quit: self = .quit
        case .task: self = .task
        }
    }
}

extension HowOften {
    /// A saved habit's How often, the choice the form would have made (the reverse of `frequency`).
    init(_ habit: Habit) {
        let counts: Bool
        switch habit.kind {
        case .amount, .duration: counts = true
        default: counts = false
        }
        switch habit.frequency {
        case .daily:
            self = habit.kind == .check && habit.goal > 1 ? .timesADay(Int(habit.goal)) : .everyDay
        case .weekdays(let days): self = .weekdays(days)
        case .everyNDays(let n): self = .calendar(CalendarSchedule(unit: .day, interval: n))
        case .everyNWeeks(let n): self = .everyWeeks(n)
        case .monthDates(let dates): self = .calendar(CalendarSchedule(unit: .month, interval: 1, dates: dates, pattern: .dates))
        case .perWeek(let n): self = counts ? .total(.week) : .times(.week, habit.kind == .check ? Int(habit.goal) : n)
        case .perMonth(let n): self = counts ? .total(.month) : .times(.month, habit.kind == .check ? Int(habit.goal) : n)
        case .perYear(let n): self = counts ? .total(.year) : .times(.year, habit.kind == .check ? Int(habit.goal) : n)
        case .flexible(let period, let n): self = counts ? .days(period, n) : .times(period, n)
        case .calendar(let rule): self = .calendar(rule)
        case .afterCompletion(let n, let unit): self = .afterDone(n, unit)
        }
    }
}
