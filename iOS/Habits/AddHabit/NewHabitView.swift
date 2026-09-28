import SwiftUI

/// What the user wants to make: the form each choice opens.
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

    /// One plain line under the title. Build screen: kept as it was (the user's decision, 28 Sep).
    /// Quit screen: says how it's recorded, from the copy report.
    var summary: String {
        switch self {
        case .doIt: "Done or not done."
        case .amount: "How many or how much."
        case .time: "How long, with a timer."
        case .checklist: "A short list to tick off."
        case .cutBack: "Set a daily maximum and log how much."
        case .quit: "Stop completely. Track time since you stopped."
        case .task: "Something to get done."
        }
    }

    /// A common habit that can only be recorded one way, so the example shows the type without
    /// implying reading or walking belong to one (copy report, 28 Sep; review counts in Research
    /// Temp/goals/example_scan.py): making a bed is never counted or timed, water is counted in
    /// glasses and never timed, meditation is timed and never counted.
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
        case .doIt: "e.g. Walk"
        case .amount: "e.g. Read"
        case .time: "e.g. Practise piano"
        case .checklist: "e.g. Clean kitchen"
        case .cutBack: "e.g. Coffee"
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
}

/// The screen behind +: "What do you want to do?", then, for habits, how to track it; then one
/// form. Each question is its own list, pushed in the same sheet, so every step looks and moves
/// the same way (spec: iOS/New Habit Goal and Time of Day.md §1).
struct NewItemView: View {
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
            HabitForm(type: type, onSaved: { onAdded($0); dismiss() })
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

/// The form for one type, on one screen: icon, name and colour; How Often; the goal; Time of Day;
/// Reminders. Choices are menus; anything needing its own page (icon, unit, a new time of day) is
/// pushed, never a sheet, so the whole flow moves one way (spec §1–6).
struct HabitForm: View {
    enum HowOften: String, CaseIterable, Identifiable {
        case everyDay = "Every Day", certainDays = "On Certain Days", everyFewDays = "Every Few Days"
        case everyFewWeeks = "Every Few Weeks", monthDates = "On Dates of the Month"
        case perWeek = "A Few Times a Week", perMonth = "A Few Times a Month", perYear = "A Few Times a Year"
        case weekTotal = "A Weekly Total", monthTotal = "A Monthly Total"
        var id: Self { self }
        var isDayBased: Bool { Self.fixedDays.contains(self) }
        /// "Daily", "Weekly" or "Monthly": the period the goal is for.
        var goalPeriod: String { self == .weekTotal ? "Weekly" : self == .monthTotal ? "Monthly" : "Daily" }
        static let fixedDays: [HowOften] = [.everyDay, .certainDays, .everyFewDays, .everyFewWeeks, .monthDates]
        /// Check it off and checklists: a number of times, on any days.
        static let anyDays: [HowOften] = [.perWeek, .perMonth, .perYear]
        /// Amounts, minutes and limits: a total over the week or month, on any days.
        static let totals: [HowOften] = [.weekTotal, .monthTotal]
    }

    enum Field: Hashable { case name, amount, unit, increment, minutes, item(UUID) }

    /// One reminder. `part` is the time of day it's for (nil for Anytime); its time stays inside that part.
    struct DraftTime: Identifiable, Hashable {
        var id = UUID()
        var time: Date
        var part: String?
    }

    let type: ItemType
    let onSaved: (UUID) -> Void

    @Environment(HabitStore.self) private var store
    @Environment(ReminderScheduler.self) private var scheduler
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var symbol: String
    @State private var pickedSymbol = false
    @State private var color: HabitColor
    @State private var showAppearance = false

    @State private var amount: Double?
    @State private var unit = ""
    @State private var increment: Double? = 1
    @State private var goal = GoalDraft()
    /// Tasks: once on a date, or on a schedule.
    @State private var taskRepeats = false
    /// Empty until the user taps Add Item.
    @State private var items: [Step] = []
    @State private var quitSince = Date.now
    @State private var taskDate = Date.now
    @State private var taskHasTime = false
    @State private var taskTime = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: .now)!

    @State private var howOften: HowOften = .everyDay
    @State private var weekdays: Set<Int> = Set(1...7)
    @State private var everyDays = 2
    @State private var everyWeeks = 2
    @State private var monthDates: Set<Int> = []
    @State private var perWeek = 3
    @State private var perMonth = 4
    @State private var perYear = 4
    /// Where it shows on Today: Anytime, or one or more parts of the day.
    @State private var timesOfDay: [String] = [.anytime]
    @State private var addingSection = false
    @State private var didSetUp = false
    /// Remind Me: a switch first; the reminder rows and how to be reminded show only while it's on.
    /// On by default with one reminder (the user's decision, 28 Sep).
    @State private var remindOn = true
    @State private var times: [DraftTime] = []
    @State private var showColors = false
    @State private var startDate = Calendar.current.startOfDay(for: .now)
    @State private var hasEnd = false
    @State private var endDate = Calendar.current.startOfDay(for: .now)
    /// Until the user edits a reminder, the reminders follow the chosen times of day.
    @State private var remindersEdited = false
    @State private var alert: AlertStyle = .notification
    @State private var followUp: Int?

    @State private var notificationsDenied = false
    @State private var alarmsDenied = false
    @State private var confirmDiscard = false
    @FocusState private var focus: Field?

    init(type: ItemType, onSaved: @escaping (UUID) -> Void) {
        self.type = type
        self.onSaved = onSaved
        _color = State(initialValue: .blue)
        _goal = State(initialValue: GoalDraft.initial(for: type))
        _symbol = State(initialValue: type == .quit ? "nosign" : type == .task ? "calendar" : "star.fill")
    }

    private var trimmedName: String { TextLimit.clean(name, TextLimit.name) }
    private var filledItems: [Step] {
        items.compactMap { item in
            let name = TextLimit.clean(item.name, TextLimit.checklistPart)
            return name.isEmpty ? nil : Step(id: item.id, name: name)
        }
    }
    private var remind: Bool { remindOn && !times.isEmpty }
    private var hasChanges: Bool { !trimmedName.isEmpty || !filledItems.isEmpty }
    private var offersFrequency: Bool { type != .quit && (type != .task || taskRepeats) }
    private var hasGoalEditor: Bool { [.doIt, .amount, .time].contains(type) }
    private var canAdd: Bool {
        guard !trimmedName.isEmpty else { return false }
        switch type {
        case .doIt, .amount, .time:
            if goal.value(timed: type == .time, check: type == .doIt) == nil { return false }
        case .cutBack:
            if (amount ?? 0) <= 0 || (increment ?? 0) <= 0 || unit.trimmingCharacters(in: .whitespaces).isEmpty { return false }
        case .checklist:
            if filledItems.isEmpty { return false }
        default:
            break
        }
        if offersFrequency && (!hasGoalEditor || goal.period == .day) && howOften == .certainDays { return !weekdays.isEmpty }
        if offersFrequency && (!hasGoalEditor || goal.period == .day) && howOften == .monthDates { return !monthDates.isEmpty }
        return true
    }

    var body: some View {
        Form {
            nameSection
            switch type {
            case .quit:
                quitSection
            case .task:
                taskSection
                if taskRepeats { Section { repeatRow } }
                Section { timeOfDayRow }
                if taskRepeats { startEndSection }
                remindersSections
            default:
                Section {
                    if !hasGoalEditor || goal.period == .day { repeatRow }
                    timeOfDayRow
                }
                Section { goalRow }
                startEndSection
                remindersSections
            }
        }
        .accessibilityIdentifier("habit-form")
        .navigationTitle(type.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
        .navigationBarBackButtonHidden(hasChanges)
        .toolbar {
            if hasChanges {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { confirmDiscard = true }
                        .confirmationDialog("Discard this?", isPresented: $confirmDiscard, titleVisibility: .hidden) {
                            Button("Discard Changes", role: .destructive) { dismiss() }
                            Button("Keep Editing", role: .cancel) {}
                        }
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Add", action: save).disabled(!canAdd).fontWeight(.semibold)
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
        .onChange(of: name) {
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
            color = store.suggestedColor()
            focus = .name
            if type != .quit { syncReminders(force: true) }
            notificationsDenied = await scheduler.isDenied()
            alarmsDenied = scheduler.alarmsDenied()
        }
    }

    // MARK: Name, icon, colour

    /// The name on its own row; icon and colour side by side below it, each opening a quick pick.
    private var nameSection: some View {
        Section {
            TextField(type.namePlaceholder, text: $name, axis: .vertical)
                .lineLimit(1...3)
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
        }
    }

    // MARK: Rows that open full screens

    /// A row that opens its own full screen: the setting on the left, the choice on the right.
    private func screenRow<Destination: View>(_ title: String, value: String, @ViewBuilder destination: @escaping () -> Destination) -> some View {
        NavigationLink {
            destination()
        } label: {
            ValueRow(title: title) { Text(value).foregroundStyle(.secondary) }
        }
        .accessibilityLabel("\(title), \(value)")
    }

    private var repeatSummary: String {
        switch howOften {
        case .certainDays:
            let symbols = Calendar.current.shortStandaloneWeekdaySymbols
            let order = (0..<7).map { (store.settings.weekStart - 1 + $0) % 7 + 1 }
            return weekdays.count == 7 ? "Every Day" : order.filter(weekdays.contains).map { symbols[$0 - 1] }.joined(separator: ", ")
        case .everyFewDays: return "Every \(everyDays) days"
        case .everyFewWeeks: return "Every \(everyWeeks) weeks"
        case .perWeek: return "\(perWeek) times a week"
        case .perMonth: return "\(perMonth) times a month"
        case .perYear: return "\(perYear) times a year"
        default: return howOften.rawValue
        }
    }

    private var repeatRow: some View {
        screenRow("Repeat", value: repeatSummary) {
            Form {
                howOftenSection
            }
            .navigationTitle("Repeat")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    /// Starts today by default, any day past or future; ends never, or on a day from the start onward.
    private var startEndSection: some View {
        Section {
            DatePicker("Starts", selection: $startDate, displayedComponents: .date)
            Picker("Ends", selection: $hasEnd.animation()) {
                Text("Never").tag(false)
                Text("On a Date").tag(true)
            }
            if hasEnd {
                DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
            }
        } header: {
            Text("Dates")
        } footer: {
            Text(hasEnd ? "After \(endDate.formatted(.dateTime.day().month(.wide))), it leaves Today. Its history stays."
                 : "A start date in the past lets you tick the days since then.").formNote()
        }
    }

    private var goalSummary: String {
        if hasGoalEditor { return goal.summary(timed: type == .time, check: type == .doIt) ?? "Set" }
        let per = howOften == .weekTotal ? "a week" : howOften == .monthTotal ? "a month" : "a day"
        switch type {
        case .amount: return amount.map { "\(Format.amount($0)) \(unit.isEmpty ? "" : unit + " ")\(per)" } ?? "Set"
        case .cutBack: return amount.map { "At most \(Format.amount($0)) \(unit.isEmpty ? "" : unit + " ")\(per)" } ?? "Set"
        case .checklist: return filledItems.isEmpty ? "Add items" : filledItems.count == 1 ? "1 item" : "\(filledItems.count) items"
        default: return ""
        }
    }

    private var goalRow: some View {
        screenRow(type == .checklist ? "Items" : "Goal", value: goalSummary) {
            if hasGoalEditor {
                GoalEditor(goal: $goal, timed: type == .time, check: type == .doIt, usedUnits: store.usedUnits,
                           weekStart: store.settings.weekStart)
                .onAppear { focus = nil }
            } else {
                Form {
                    if type == .cutBack { amountSection(limit: true) }
                    if type == .checklist { checklistSection }
                }
                .navigationTitle(type == .checklist ? "Items" : "Goal")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }

    // MARK: Type sections

    private func amountSection(limit: Bool) -> some View {
        Section {
            NumberRow(title: limit ? "No more than" : "Amount", value: $amount, placeholder: limit ? "2" : "8",
                      suffix: unit.isEmpty ? (limit ? "cups" : "glasses") : unit, focus: $focus, field: .amount)
            NavigationLink {
                UnitPicker(unit: $unit, used: store.usedUnits, mode: .limit)
            } label: {
                ValueRow(title: "Unit") {
                    Text(unit.isEmpty ? "Choose" : unit).foregroundStyle(unit.isEmpty ? .tertiary : .secondary)
                }
            }
            NumberRow(title: "Each tap adds", value: $increment, placeholder: "1",
                      suffix: unit.isEmpty ? "" : unit, focus: $focus, field: .increment)
        } header: {
            Text("\(howOften.goalPeriod) \(limit ? "limit" : "goal")")
        } footer: {
            Text(limit
                 ? "Log each one as it happens. It counts while you stay at or under the limit."
                 : "Each tap on + adds \(Format.amount(increment ?? 1)).").formNote()
        }
    }

    private var checklistSection: some View { ChecklistItemsSection(items: $items) }

    private var quitSection: some View {
        Section {
            DatePicker("Started", selection: $quitSince, in: ...Date.now)
        } footer: {
            Text("The counter runs from here. It shows at the top of Today under Quitting, counting up.").formNote()
        }
    }

    /// A task: once on a date, or on repeat. Never progress or stats (the user's decision).
    private var taskSection: some View {
        Section {
            Picker("Repeat", selection: $taskRepeats.animation()) {
                Text("Never").tag(false)
                Text("On a schedule").tag(true)
            }
            if !taskRepeats {
                DatePicker("Date", selection: $taskDate, in: Calendar.current.startOfDay(for: .now)..., displayedComponents: .date)
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

    @ViewBuilder
    private var howOftenSection: some View {
        // Every option is shown at once, in two named groups, so "Every Few Days" and "A Few Times a
        // Week" can't be mixed up. The chosen one's details follow in their own section.
        Section("On a set schedule") {
            ForEach(HowOften.fixedDays) { option in
                CheckRow(title: option.rawValue, selected: howOften == option) { withAnimation { howOften = option } }
            }
        }
        if type != .task && !hasGoalEditor {
            Section("On any days you like") {
                ForEach(type == .doIt || type == .checklist ? HowOften.anyDays : HowOften.totals) { option in
                    CheckRow(title: option.rawValue, selected: howOften == option) { withAnimation { howOften = option } }
                }
            }
        }
        Section {
            switch howOften {
            case .everyDay:
                EmptyView()
            case .certainDays:
                WeekdayPicker(selection: $weekdays, firstWeekday: store.settings.weekStart)
            case .everyFewDays:
                Stepper(value: $everyDays, in: 2...30) { LabeledContent("Every", value: "\(everyDays) days") }
            case .everyFewWeeks:
                Stepper(value: $everyWeeks, in: 2...12) { LabeledContent("Every", value: "\(everyWeeks) weeks") }
            case .monthDates:
                MonthDatePicker(selection: $monthDates)
            case .perWeek:
                Stepper(value: $perWeek, in: 1...14) { LabeledContent("Times", value: "\(perWeek) a week") }
            case .perMonth:
                Stepper(value: $perMonth, in: 1...31) { LabeledContent("Times", value: "\(perMonth) a month") }
            case .perYear:
                Stepper(value: $perYear, in: 1...52) { LabeledContent("Times", value: "\(perYear) a year") }
            case .weekTotal, .monthTotal:
                EmptyView() // the total is the goal, set below
            }
        } footer: {
            // A set schedule not due today would look lost on Today, so say when it starts.
            Text(howOftenSummary + (Outcome.firstDue(draft, store: store).map { " First due \($0)." } ?? "")).formNote()
        }
    }

    /// One plain sentence that says exactly what was chosen. Set schedules and any-day rules
    /// start differently, so the two kinds read as different at a glance.
    private var howOftenSummary: String {
        let weekday = Date.now.formatted(.dateTime.weekday(.wide))
        let period = howOften == .perWeek || howOften == .weekTotal ? "week" : howOften == .perYear ? "year" : "month"
        switch howOften {
        case .everyDay:
            return "Due every day."
        case .certainDays:
            return "A set schedule: due only on the days you pick. Other days are hidden and never break the streak."
        case .everyFewDays:
            return "A set schedule: due every \(everyDays) days, counting from today. The days between never break the streak."
        case .everyFewWeeks:
            return "A set schedule: due every \(everyWeeks) weeks, on \(weekday)."
        case .monthDates:
            return "A set schedule: due on these dates each month. 29–31 move to the last day in shorter months."
        case .perWeek, .perMonth, .perYear:
            let n = howOften == .perWeek ? perWeek : howOften == .perMonth ? perMonth : perYear
            return type == .checklist
                ? "Any days you like: finish it on \(n) \(n == 1 ? "day" : "days") in the \(period). The streak counts \(period)s."
                : "Any days you like: tick it \(n) \(n == 1 ? "time" : "times") in the \(period), even twice in one day. The streak counts \(period)s."
        case .weekTotal, .monthTotal:
            return type == .cutBack
                ? "Any days you like: everything you log in the \(period) adds up, and it counts while the total stays at or under the limit."
                : "Any days you like: everything you log in the \(period) adds up to the goal. The streak counts \(period)s."
        }
    }

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

    private var timeOfDaySummary: String {
        timesOfDay.map { store.section($0).name }.joined(separator: ", ")
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

    /// Reminders: one by default, any number more, each inside a chosen time of day. How to be reminded
    /// sits in the section right below, close together, and only while there's a reminder.
    @ViewBuilder
    private var remindersSections: some View {
        Section {
            Toggle("Remind Me", isOn: $remindOn.animation())
                .tint(.green)
                .onChange(of: remindOn) { if remindOn && times.isEmpty { syncReminders(force: true) } }
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
        case .doIt, .amount, .time:
            break // The shared goal draft applies after the daily schedule below.
        case .cutBack:
            habit.kind = .amount(unit: TextLimit.clean(unit, TextLimit.unit), increment: increment ?? 1)
            habit.goal = amount ?? 1
            habit.atMost = type == .cutBack
        case .checklist:
            habit.kind = .checklist
            habit.steps = filledItems
        case .quit:
            habit.kind = .quit
            habit.quitSince = quitSince
        case .task:
            habit.kind = .task
            // A repeating task has no date: it comes back on its schedule.
            habit.dueDay = taskRepeats ? nil : LocalDay(taskDate)
            if taskHasTime {
                let c = cal.dateComponents([.hour, .minute], from: taskTime)
                habit.dueMinute = (c.hour ?? 9) * 60 + (c.minute ?? 0)
            }
        }
        if type != .quit { habit.parts = timesOfDay }
        if offersFrequency {
            switch howOften {
            case .everyDay: habit.frequency = .daily
            case .certainDays: habit.frequency = .weekdays(weekdays)
            case .everyFewDays: habit.frequency = .everyNDays(everyDays)
            case .everyFewWeeks: habit.frequency = .everyNWeeks(everyWeeks)
            case .monthDates: habit.frequency = .monthDates(monthDates)
            case .perWeek: habit.frequency = .perWeek(perWeek)
            case .perMonth: habit.frequency = .perMonth(perMonth)
            case .perYear: habit.frequency = .perYear(perYear)
            // Totals: the goal is the amount (or minutes) for the whole period.
            case .weekTotal: habit.frequency = .perWeek(1)
            case .monthTotal: habit.frequency = .perMonth(1)
            }
        }
        if hasGoalEditor { goal.apply(to: &habit, timed: type == .time, check: type == .doIt) }
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
        // Start and end dates: for anything with How Often (a one-time task has only its date).
        if offersFrequency {
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
        let habit = makeHabit()
        // Reminders are on by default, so permission is asked when the habit is saved, not before.
        if habit.remind && !habit.reminders.isEmpty { Task { _ = await scheduler.requestPermission() } }
        store.add(habit)
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
                    RemoveButton(label: "Remove \(item.name.isEmpty ? "item" : item.name)") {
                        withAnimation { items.removeAll { $0.id == item.id } }
                    }
                    TextField(items.first?.id == item.id ? "e.g. Push-ups" : "Next item", text: $item.name)
                        .focused($focused, equals: item.id)
                        .limitText($item.name, to: TextLimit.checklistPart)
                        .submitLabel(.next)
                        .onSubmit(addItem)
                }
            }
            .onDelete { items.remove(atOffsets: $0) }
            AddRow(title: "Add Item", action: addItem)
        } header: {
            Text("Items")
        } footer: {
            Text("One habit with a few items to tick. They reset each time it's due, and the habit is done when every item is ticked.").formNote()
        }
    }

    private func addItem() {
        let item = Step(name: "")
        withAnimation { items.append(item) }
        // After the row exists, so the field can take focus.
        DispatchQueue.main.async { focused = item.id }
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

    var body: some View {
        HStack(spacing: 6) {
            Text(title).lineLimit(1).fixedSize()
            Spacer(minLength: 16)
            // Not fixedSize: a field sized to its placeholder clipped what was typed (reported 28 Sep).
            TextField(placeholder, value: $value, format: .number)
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
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(title)
        .accessibilityAddTraits(selected ? [.isButton, .isSelected] : .isButton)
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

    var body: some View {
        let symbols = Calendar.current.veryShortStandaloneWeekdaySymbols
        let full = Calendar.current.standaloneWeekdaySymbols
        let order = (0..<7).map { (firstWeekday - 1 + $0) % 7 + 1 }
        HStack(spacing: 6) {
            ForEach(order, id: \.self) { day in
                let on = selection.contains(day)
                Button {
                    if on { selection.remove(day) } else { selection.insert(day) }
                } label: {
                    Text(symbols[day - 1])
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(on ? Color.onInk : Color.primary)
                        .frame(maxWidth: .infinity, minHeight: 36)
                        .background(Circle().fill(on ? Color.ink : Color(.tertiarySystemFill)))
                }
                .buttonStyle(.plain)
                .accessibilityLabel(full[day - 1])
                .accessibilityAddTraits(on ? .isSelected : [])
            }
        }
        .padding(.vertical, 4)
    }
}

/// 1–31, like the Calendar app's monthly repeat.
struct MonthDatePicker: View {
    @Binding var selection: Set<Int>

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 6), count: 7), spacing: 6) {
            ForEach(1...31, id: \.self) { date in
                let on = selection.contains(date)
                Button {
                    if on { selection.remove(date) } else { selection.insert(date) }
                } label: {
                    Text("\(date)")
                        .font(.subheadline.weight(.semibold).monospacedDigit())
                        .foregroundStyle(on ? Color.onInk : Color.primary)
                        .frame(maxWidth: .infinity, minHeight: 36)
                        .background(Circle().fill(on ? Color.ink : Color(.tertiarySystemFill)))
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
                Text("Anything you count: prayers, chapters, glasses of juice.")
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
                Text(value).foregroundStyle(Color.primary).lineLimit(1)
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
