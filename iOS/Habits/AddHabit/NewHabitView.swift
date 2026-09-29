import SwiftUI

/// What the user wants to make: the form each choice opens. Build or maintain goes straight to one form
/// whose How much decides how it's tracked (Round 3 design §2.6): no amount → ✓, minutes → ▶, any other
/// unit → +, steps → a checklist. The old type screen (Check it off · Track an amount · Time it · Checklist) is gone.
enum ItemType: String, CaseIterable, Identifiable {
    case build, cutBack, quit, task
    var id: Self { self }

    var title: String {
        switch self {
        case .build: "New Habit"
        case .cutBack: "Cut down"
        case .quit: "Quit"
        case .task: "Task"
        }
    }

    /// One plain line under the title on the Quit or cut down screen, from the copy report.
    var summary: String {
        switch self {
        case .build: "A habit you want to start or keep doing."
        case .cutBack: "Set a maximum and log how much."
        case .quit: "Stop completely. Track time since you stopped."
        case .task: "Something to get done."
        }
    }

    var example: String {
        switch self {
        case .build: "Read 2 chapters a week"
        case .cutBack: "Log coffees, up to 2 a day"
        case .quit: "Time since you last smoked"
        case .task: "Pay the rent"
        }
    }

    /// The name field's hint.
    var namePlaceholder: String {
        switch self {
        case .build: "Name, e.g. Read"
        case .cutBack: "Name, e.g. Coffee"
        case .quit: "e.g. Smoking"
        case .task: "e.g. Pay the rent"
        }
    }

    /// A plain SF Symbol for the choice rows (research: "Goal Screen Round 2", T1). Monochrome.
    var icon: String {
        switch self {
        case .build: "chart.line.uptrend.xyaxis"
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
/// the same way (spec: iOS/Docs/Specs/New Habit Goal and Time of Day.md §1).
struct NewItemView: View {
    /// Called with the new habit's ID, so Today can show where it went.
    var onAdded: (UUID) -> Void = { _ in }
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss

    private enum Kind: Hashable { case bad }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        form(.build)
                    } label: {
                        ChoiceLabel(icon: ItemType.build.icon, title: "Build or maintain", detail: "A habit you want to start or keep doing.")
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
        .navigationTitle("Quit or cut down")
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

    /// How much: Just do it, or an amount (typed, or hours and minutes when the unit is time).
    @State private var usesAmount = false
    @State private var amountText = ""
    @State private var unit = ""
    @State private var hours = "0"
    @State private var minutes = "20"
    /// Each + adds: nil keeps the suggested step, which follows the amount and unit.
    @State private var step: Double?
    @State private var often = OftenDraft()
    /// Tasks: once on a date, or on a schedule.
    @State private var taskRepeats = false
    /// A habit's optional steps (a checklist), or nothing until the user adds one.
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
    private var isHabit: Bool { type == .build || type == .cutBack }
    private var timed: Bool { unit == HabitPlan.timeUnit }
    /// A time amount can't be longer than its period ("3 h a week" is fine, "30 h a day" isn't).
    private var amountPeriod: GoalPeriod {
        if case .total(let period) = often.often(hasAmount: true), often.choice == .total { return period }
        return .day
    }
    private var amountValue: Double? {
        guard usesAmount || type == .cutBack else { return nil }
        if timed { return GoalDraft(hours: hours, minutes: minutes).duration(max: amountPeriod.maxMinutes) }
        guard let n = GoalNumber.parse(amountText), n > 0 else { return nil }
        return n
    }
    /// The habit's how much and how often, as chosen: the one source for the read-back, Today and saving.
    private var plan: HabitPlan {
        let checklist = type == .build && !filledItems.isEmpty
        let amount = checklist ? nil : amountValue
        return HabitPlan(amount: amount, unit: timed ? HabitPlan.timeUnit : TextLimit.clean(unit, TextLimit.unit), step: step,
                         often: often.often(hasAmount: amount != nil), atMost: type == .cutBack, checklist: checklist)
    }
    /// "2 chapters", "30 min": the amount as the How often choices say it.
    private var amountWords: String? {
        guard let value = plan.amount else { return nil }
        return plan.isTimed ? HabitCopy.minutes(value) : HabitCopy.amount(value, plan.unit)
    }
    private var weekStart: Int { store.settings.weekStart }
    private var canAdd: Bool {
        guard !trimmedName.isEmpty else { return false }
        switch type {
        case .build:
            if usesAmount && filledItems.isEmpty && amountValue == nil { return false }
        case .cutBack:
            if amountValue == nil { return false }
        default:
            break
        }
        if isHabit, case .weekdays(let days) = plan.often, days.isEmpty { return false }
        if isHabit, case .calendar(let rule) = plan.often {
            if rule.unit == .week && rule.weekdays.isEmpty { return false }
            if rule.unit == .month && rule.pattern == .dates && rule.dates.isEmpty { return false }
        }
        return true
    }

    var body: some View {
        Form {
            if isHabit { readBackSection }
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
            case .build, .cutBack:
                planSection
                if type == .build && !usesAmount { stepsSection }
                Section { timeOfDayRow }
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
        } footer: {
            if let note = TextLimit.note(name, TextLimit.name) { Text(note).formNote() }
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

    /// A repeating task's schedule, on its own screen (with "after it's done", which only tasks have).
    private var repeatRow: some View {
        screenRow("How often", value: schedule.summary) {
            ScheduleEditor(schedule: $schedule, goalPeriod: .constant(.day), start: startDate,
                           end: hasEnd ? endDate : nil, weekStart: weekStart,
                           hasGoal: false, checklist: false, task: true)
                .onAppear { focus = nil }
        }
    }

    // MARK: The sentence, how much and how often

    /// The habit said back big at the top, the way a person says it: "Read 2 chapters a week",
    /// "Gym every Monday and Wednesday". Built from the same saved habit Today shows.
    private var readBackSection: some View {
        Section {
            VStack(spacing: 4) {
                Text(HabitCopy.sentence(draft, weekStart: weekStart))
                    .font(.system(.title2, design: .rounded).weight(.bold))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .contentTransition(.opacity)
                    .accessibilityAddTraits(.isHeader)
                    .accessibilityIdentifier("habit-sentence")
                Text(timeOfDaySummary)
                    .font(.callout).foregroundStyle(.secondary)
                    .accessibilityLabel("Time of day: \(timeOfDaySummary)")
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 2)
            .animation(.snappy, value: HabitCopy.sentence(draft, weekStart: weekStart))
        }
        .listRowBackground(Color.clear)
    }

    /// How much, what + adds, and how often: three rows that make the sentence above.
    private var planSection: some View {
        Section {
            if filledItems.isEmpty {
                screenRow(type == .cutBack ? "Limit" : "How much", value: amountValue == nil && (usesAmount || type == .cutBack) ? "Set" : plan.howMuchLabel) {
                    HowMuchEditor(usesAmount: $usesAmount, amount: $amountText, unit: $unit, hours: $hours, minutes: $minutes,
                                  limit: type == .cutBack, usedUnits: store.usedUnits, period: amountPeriod)
                        .onAppear { focus = nil }
                }
                .accessibilityIdentifier("how-much-row")
            }
            if plan.hasStep {
                NumberRow(title: "Each + adds", value: $step, placeholder: HabitCopy.number(plan.stepValue),
                          suffix: HabitCopy.unitWord(plan.stepValue, plan.unit), focus: $focus, field: .increment)
            }
            screenRow("How often", value: plan.often.label(hasAmount: plan.hasAmount, checklist: plan.checklist, weekStart: weekStart)) {
                HowOftenEditor(draft: $often, amountText: amountWords, checklist: plan.checklist, limit: type == .cutBack,
                               start: startDate, weekStart: weekStart)
                    .onAppear { focus = nil }
            }
            .accessibilityIdentifier("how-often-row")
        } footer: {
            Text(todayNote).formNote()
        }
    }

    /// What Today will show and what one tap does, before saving: no rule the person can't see.
    private var todayNote: String {
        if plan.checklist { return "On Today, tick each step. It's done when every step is ticked." }
        guard plan.amount != nil else {
            if usesAmount || type == .cutBack { return "Type the amount in \(type == .cutBack ? "Limit" : "How much")." }
            switch plan.often {
            case .timesADay(let n): return "On Today, tap ✓ each time. It shows 1/\(n) after the first."
            case .times(let period, let n): return "On Today, tap ✓ each time you do it. \(n) this \(period.noun) meets it, on any days."
            case .days(let period, let n): return "On Today, tap ✓ once on a day you do it. \(n) different days this \(period.noun) meets it."
            default: return "On Today, tap ✓ when it's done."
            }
        }
        if plan.isTimed { return "On Today, ▶ times it, or tap the habit to type the time." }
        let adds = HabitCopy.amount(plan.stepValue, plan.unit)
        if type == .cutBack { return "On Today, + adds \(adds) each time you have one. Tap the habit to type any amount." }
        return "On Today, + adds \(adds). Tap the habit to type any amount."
    }

    /// A few steps to tick each time ("dishes, sink, floor"), for a habit that's done or not.
    private var stepsSection: some View {
        Section {
            screenRow("Steps", value: filledItems.isEmpty ? "None" : filledItems.count == 1 ? "1 step" : "\(filledItems.count) steps") {
                Form { ChecklistItemsSection(items: $items) }
                    .navigationTitle("Steps")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .accessibilityIdentifier("steps-row")
        } footer: {
            Text("Optional: a short list to tick each time, like dishes, sink, floor.").formNote()
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
        case .build, .cutBack:
            plan.apply(to: &habit)
            if plan.checklist { habit.steps = filledItems }
        case .quit:
            habit.kind = .quit
            habit.quitSince = quitSince
        case .task:
            habit.kind = .task
            // A repeating task has no date: it comes back on its schedule.
            habit.dueDay = taskRepeats ? nil : LocalDay(taskDate)
            if taskRepeats { habit.frequency = schedule.frequency }
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
            Text("A few steps to tick. They reset each time it's due, and the habit is done when every step is ticked.").formNote()
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
            // Time first: it's the most common amount people give ("30 min a day"; 35.6% of amounts,
            // "How People Describe a Habit" §3). It makes the habit timed, with ▶ on Today.
            var list: [(String, [String])] = [
                ("Drinking", ["glasses", "cups", "bottles"] + volume),
                ("Walking and running", ["steps"] + distance),
                ("Reading and writing", ["pages", "chapters", "books", "words"]),
                ("Exercise", ["reps", "sets", "push-ups", "workouts", "laps"]),
                ("Everyday", ["times", "meals", "servings", "sessions", "pills"]),
                ("Money", Self.money),
            ]
            if mode == .limit { list.insert(("Cutting down", ["cigarettes", "drinks", "coffees", "snacks"]), at: 0) }
            if mode == .amount { list.insert(("Time", [HabitPlan.timeUnit]), at: 0) }
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
