import SwiftUI

/// What the user wants to make. Research: "New Habit Screen, Round 2 — Types, Frequency, One-Time Tasks".
enum ItemType: String, CaseIterable, Identifiable {
    case doIt, amount, time, checklist, cutBack, quit, task
    var id: Self { self }

    /// Row titles in the words reviewers use most ("New Habit Words and Units").
    var title: String {
        switch self {
        case .doIt: "Check it off"
        case .amount: "Count an amount"
        case .time: "Time it"
        case .checklist: "Checklist"
        case .cutBack: "Set a limit"
        case .quit: "Quit"
        case .task: "To-do"
        }
    }

    var summary: String {
        switch self {
        case .doIt: "Done or not done."
        case .amount: "How many or how much."
        case .time: "Minutes, with a timer."
        case .checklist: "A few items, each ticked."
        case .cutBack: "No more than an amount a day."
        case .quit: "The time since you stopped."
        case .task: "Once, on a day, with no streak."
        }
    }

    /// One short line under the title, so all seven rows fit on the smallest iPhone without scrolling.
    var example: String {
        switch self {
        case .doIt: "Take vitamins"
        case .amount: "Drink 8 glasses of water"
        case .time: "Read for 20 minutes"
        case .checklist: "Push-ups, squats, plank"
        case .cutBack: "At most 2 coffees a day"
        case .quit: "Smoking"
        case .task: "Book the dentist"
        }
    }

    /// The name field's hint.
    var namePlaceholder: String {
        switch self {
        case .doIt: "e.g. Take vitamins"
        case .amount: "e.g. Drink water"
        case .time: "e.g. Read"
        case .checklist: "e.g. Workout"
        case .cutBack: "e.g. Coffee"
        case .quit: "e.g. Smoking"
        case .task: "e.g. Book the dentist"
        }
    }

    var symbol: String {
        switch self {
        case .doIt: "checkmark.circle"
        case .amount: "number"
        case .time: "timer"
        case .checklist: "checklist"
        case .cutBack: "gauge.with.dots.needle.33percent"
        case .quit: "nosign"
        case .task: "calendar"
        }
    }

    /// Everything except one-time tasks counts toward the free habit limit.
    var isHabit: Bool { self != .task }
}

/// The sheet behind +: first choose what to make, in plain words, then a short form for that type.
struct NewItemView: View {
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                section("Build a habit", [.doIt, .amount, .time, .checklist])
                section("Break a bad habit", [.cutBack, .quit])
                section("Just once", [.task])
                if !store.isPlus {
                    Section {} footer: {
                        Text("\(store.activeHabitCount) of \(HabitStore.freeHabitLimit) free habits used. One-time tasks are always free.")
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .listSectionSpacing(.compact)
            .contentMargins(.top, 0, for: .scrollContent)
            // If the list is taller than the screen (small phones, large text), the scroll bar
            // flashes on open, and the cut-off row below shows there is more.
            .scrollIndicatorsFlash(onAppear: true)
            .navigationTitle("New")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
            }
        }
    }

    private func section(_ title: String, _ types: [ItemType]) -> some View {
        Section(title) {
            ForEach(types) { type in
                NavigationLink {
                    if type.isHabit && !store.canAddHabit {
                        PlusView()
                    } else {
                        HabitForm(type: type, onSaved: { dismiss() })
                    }
                } label: {
                    HStack(spacing: 14) {
                        // Neutral: colour belongs to habits, not to the menu.
                        Image(systemName: type.symbol)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.ink)
                            .frame(width: 32, height: 32)
                            .background(RoundedRectangle(cornerRadius: 8, style: .continuous).fill(Color(.tertiarySystemFill)))
                        VStack(alignment: .leading, spacing: 1) {
                            Text(type.title).font(.body)
                            Text("Example: \(type.example)")
                                .font(.subheadline).foregroundStyle(.secondary)
                                .lineLimit(2)
                        }
                    }
                }
                // Sized so all seven rows fit on an iPhone SE without scrolling.
                .listRowInsets(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
                .accessibilityLabel(type.title)
                .accessibilityHint("\(type.summary) Example: \(type.example)")
            }
        }
    }
}

/// The form for one type. Every type starts the same way (icon, name, colour) and ends the same way
/// (when in the day, reminders); only the middle changes.
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

    struct DraftReminder: Identifiable, Hashable {
        let id = UUID()
        var time: Date
    }

    let type: ItemType
    let onSaved: () -> Void

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
    @State private var minutes: Double?
    /// Empty until the user taps Add Item.
    @State private var items: [Step] = []
    @State private var quitSince = Date.now
    @State private var taskDate = Date.now
    @State private var taskHasTime = false
    @State private var taskTime = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: .now)!
    @State private var taskRemind = false

    @State private var howOften: HowOften = .everyDay
    @State private var weekdays: Set<Int> = Set(1...7)
    @State private var everyDays = 2
    @State private var everyWeeks = 2
    @State private var monthDates: Set<Int> = []
    @State private var perWeek = 3
    @State private var perMonth = 4
    @State private var perYear = 4
    /// Day sections. Check it off can have several (a tick in each); every other type has one.
    @State private var parts: [String] = [.anytime]
    @State private var addingSection = false
    @State private var didSetUp = false
    @State private var reminders: [DraftReminder] = []

    @State private var notificationsDenied = false
    @State private var confirmDiscard = false
    @FocusState private var focus: Field?

    init(type: ItemType, onSaved: @escaping () -> Void) {
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
    private var hasChanges: Bool { !trimmedName.isEmpty || !filledItems.isEmpty || !reminders.isEmpty }
    private var offersFrequency: Bool { type != .quit && type != .task }
    private var canAdd: Bool {
        guard !trimmedName.isEmpty else { return false }
        switch type {
        case .amount, .cutBack:
            if (amount ?? 0) <= 0 || (increment ?? 0) <= 0 || unit.trimmingCharacters(in: .whitespaces).isEmpty { return false }
        case .time:
            if (minutes ?? 0) < 1 { return false }
        case .checklist:
            if filledItems.isEmpty { return false }
        default:
            break
        }
        if offersFrequency && howOften == .certainDays { return !weekdays.isEmpty }
        if offersFrequency && howOften == .monthDates { return !monthDates.isEmpty }
        return true
    }

    var body: some View {
        Form {
            headerSection
            // How often comes first: what it controls (the daily goal) sits below it, never above.
            if offersFrequency { howOftenSection }
            switch type {
            case .doIt: EmptyView()
            case .amount: amountSection(limit: false)
            case .cutBack: amountSection(limit: true)
            case .time: timeSection
            case .checklist: checklistSection
            case .quit: quitSection
            case .task: taskSection
            }
            if type != .quit { partSection }
            if offersFrequency { remindersSection }
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
                Spacer()
                Button("Done") { focus = nil }.fontWeight(.semibold)
            }
        }
        .interactiveDismissDisabled(hasChanges)
        // Sheets hang off the form, not a row: SwiftUI doesn't reliably present them from inside a list row.
        .sheet(isPresented: $addingSection) {
            SectionEditor(existing: nil) { id in
                parts = type == .doIt ? parts.filter { $0 != .anytime } + [id] : [id]
            }
        }
        .sheet(isPresented: $showAppearance) {
            IconSheet(symbol: $symbol, color: color) { pickedSymbol = true }
        }
        .onChange(of: name) {
            // A wrapping field puts Return into the text; treat it as Done instead.
            if name.contains("\n") { name = name.replacingOccurrences(of: "\n", with: ""); focus = nil }
            suggestIcon()
        }
        .task {
            // Runs again when a pushed page (Unit) pops back; set up only once, so the
            // user's colour and cursor are never reset.
            guard !didSetUp else { return }
            didSetUp = true
            color = store.suggestedColor()
            focus = .name
            notificationsDenied = await scheduler.isDenied()
        }
    }

    // MARK: Header: icon, name, colour

    private var headerSection: some View {
        Section {
            VStack(spacing: 14) {
                Button { focus = nil; showAppearance = true } label: {
                    HabitIcon(symbol: symbol, color: color, size: 64)
                        .shadow(color: color.color.opacity(0.35), radius: 8, y: 4)
                        .overlay(alignment: .bottomTrailing) {
                            Image(systemName: "pencil.circle.fill")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(Color.onInk, Color.ink)
                                .font(.system(size: 22))
                                .offset(x: 6, y: 6)
                        }
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Icon")
                // Wraps so a long name stays fully visible while typing.
                TextField(type.namePlaceholder, text: $name, axis: .vertical)
                    .lineLimit(1...3)
                    .font(.title3.weight(.semibold))
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 8)
                    .background(RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Color(.tertiarySystemFill)))
                    .focused($focus, equals: .name)
                    .limitText($name, to: TextLimit.name)
                    .submitLabel(.done)
                    .onSubmit { focus = nil }
                    .accessibilityLabel("Name")
                    .accessibilityIdentifier("name-field")
            }
            .padding(.vertical, 8)
            ColorGrid(selection: $color)
        }
    }

    // MARK: Type sections

    private func amountSection(limit: Bool) -> some View {
        Section {
            NumberRow(title: limit ? "No more than" : "Amount", value: $amount, placeholder: limit ? "2" : "8",
                      suffix: unit.isEmpty ? (limit ? "cups" : "glasses") : unit, focus: $focus, field: .amount)
            NavigationLink {
                UnitPicker(unit: $unit, used: store.usedUnits)
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
                 : "Each tap on + adds \(Format.amount(increment ?? 1)).")
        }
    }

    private var timeSection: some View {
        Section("\(howOften.goalPeriod) goal") {
            NumberRow(title: "Minutes", value: $minutes, placeholder: "20", suffix: "min", focus: $focus, field: .minutes)
        }
    }

    private var checklistSection: some View {
        Section {
            ForEach($items) { $item in
                HStack(spacing: 12) {
                    RemoveButton(label: "Remove \(item.name.isEmpty ? "item" : item.name)") {
                        withAnimation { items.removeAll { $0.id == item.id } }
                    }
                    TextField(items.first?.id == item.id ? "e.g. Push-ups" : "Next item", text: $item.name)
                        .focused($focus, equals: .item(item.id))
                        .limitText($item.name, to: TextLimit.checklistPart)
                        .submitLabel(.next)
                        .onSubmit { addItem() }
                }
            }
            .onDelete { items.remove(atOffsets: $0) }
            AddRow(title: "Add Item", action: addItem)
        } header: {
            Text("Items")
        } footer: {
            Text("One habit with a few items to tick. They reset each time it's due, and the habit is done when every item is ticked.")
        }
    }

    private var quitSection: some View {
        Section {
            DatePicker("Started", selection: $quitSince, in: ...Date.now)
        } footer: {
            Text("The counter runs from here.")
        }
    }

    private var taskSection: some View {
        Section {
            DatePicker("Date", selection: $taskDate, in: Calendar.current.startOfDay(for: .now)..., displayedComponents: .date)
            Toggle("Time", isOn: $taskHasTime.animation())
            if taskHasTime {
                DatePicker("At", selection: $taskTime, displayedComponents: .hourAndMinute)
                Toggle("Remind Me", isOn: $taskRemind)
            }
        } footer: {
            Text("If it isn't done, it moves forward to today until it is. No streaks or stats.")
        }
    }

    // MARK: How often, part of day, reminders

    private var howOftenSection: some View {
        Section {
            Picker("How Often", selection: $howOften.animation()) {
                // Two named groups, so "Every Few Days" and "A Few Times a Week" can't be mixed up.
                Section("On a set schedule") {
                    ForEach(HowOften.fixedDays) { Text($0.rawValue).tag($0) }
                }
                Section("On any days you like") {
                    ForEach(type == .doIt || type == .checklist ? HowOften.anyDays : HowOften.totals) { Text($0.rawValue).tag($0) }
                }
            }
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
            Text(howOftenSummary)
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

    private var sectionNames: String {
        parts.map { store.section($0).name }.joined(separator: ", ")
    }

    /// Check it off can sit in several sections: one tick in each.
    private func toggleSection(_ id: String) {
        if id == .anytime { parts = [.anytime]; return }
        var chosen = parts.filter { $0 != .anytime }
        if let i = chosen.firstIndex(of: id) { chosen.remove(at: i) } else { chosen.append(id) }
        // Keep the Today order, so "Morning, Evening" reads the way the day runs.
        let order = store.sections.map(\.id)
        parts = chosen.isEmpty ? [.anytime] : chosen.sorted { (order.firstIndex(of: $0) ?? 99) < (order.firstIndex(of: $1) ?? 99) }
    }

    /// Which day section on Today. The list is the user's own, and a new one can be made here.
    private var partSection: some View {
        Section {
            Menu {
                if type == .doIt {
                    // Several can be ticked; the menu stays open while choosing.
                    ForEach(store.sections) { section in
                        Toggle(section.name, isOn: Binding(get: { parts.contains(section.id) }, set: { _ in toggleSection(section.id) }))
                    }
                } else {
                    Picker("Day Section", selection: Binding(get: { parts[0] }, set: { parts = [$0] })) {
                        ForEach(store.sections) { section in
                            Text(section.name).tag(section.id)
                        }
                    }
                }
                Divider()
                Button("New Section…", systemImage: "plus") { focus = nil; addingSection = true }
            } label: {
                ValueRow(title: parts.count > 1 ? "Day Sections" : "Day Section") {
                    HStack(spacing: 6) {
                        Text(sectionNames).lineLimit(1)
                        Image(systemName: "chevron.up.chevron.down").font(.footnote)
                    }
                    .foregroundStyle(.secondary)
                }
                .contentShape(Rectangle())
            }
            .menuActionDismissBehavior(type == .doIt ? .disabled : .automatic)
            .accessibilityLabel("Day Section, \(sectionNames)")
        } footer: {
            Text(sectionFooter)
        }
    }

    private var sectionFooter: String {
        if parts.count > 1 {
            return "Done \(parts.count) times a day: it shows in \(sectionNames), each with its own tick."
        }
        // The chosen section's hours, so "Evening" means something exact.
        let when = hours(store.section(parts[0])).map { "Shows on Today from \($0)." } ?? "Shows on Today at any time of day."
        switch type {
        case .task: return when
        case .doIt: return when + " To do it more than once a day, pick more sections, like Morning and Evening."
        default: return when + " Add your own section, like Before work."
        }
    }

    private func hours(_ section: DaySection) -> String? {
        guard let start = section.start,
              let end = store.timedSections.first(where: { $0.section.id == section.id })?.end else { return nil }
        return "\(DaySection.clock(start))–\(DaySection.clock(end))"
    }

    private var remindersSection: some View {
        Section {
            ForEach($reminders) { $reminder in
                HStack(spacing: 12) {
                    RemoveButton(label: "Remove reminder") {
                        withAnimation { reminders.removeAll { $0.id == reminder.id } }
                    }
                    DatePicker("Reminder", selection: $reminder.time, displayedComponents: .hourAndMinute)
                }
            }
            .onDelete { reminders.remove(atOffsets: $0) }
            AddRow(title: "Add Reminder") {
                Task {
                    let allowed = await scheduler.requestPermission()
                    notificationsDenied = !allowed
                    withAnimation { reminders.append(DraftReminder(time: nextReminderTime())) }
                }
            }
        } header: {
            Text("Reminders")
        } footer: {
            if notificationsDenied && !reminders.isEmpty {
                Text("Notifications are off for this app. Turn them on in Settings to get these reminders.")
            }
        }
    }

    // MARK: Helpers

    private func addItem() {
        let item = Step(name: "")
        withAnimation { items.append(item) }
        focus = .item(item.id)
    }

    private func nextReminderTime() -> Date {
        if let last = reminders.last { return last.time.addingTimeInterval(3600) }
        // The first reminder is an hour into the habit's section (9:00 for Anytime).
        let minute = store.section(parts[0]).start.map { $0 + 60 } ?? 9 * 60
        return Calendar.current.date(bySettingHour: (minute / 60) % 24, minute: minute % 60, second: 0, of: .now)!
    }

    private func suggestIcon() {
        guard !pickedSymbol, let suggestion = IconSuggester.symbol(for: name) else { return }
        symbol = suggestion
    }

    private func save() {
        guard canAdd else { return }
        focus = nil
        var habit = Habit(name: trimmedName, symbol: symbol, color: color, kind: .check)
        switch type {
        case .doIt:
            habit.goal = 1
        case .amount, .cutBack:
            habit.kind = .amount(unit: TextLimit.clean(unit, TextLimit.unit), increment: increment ?? 1)
            habit.goal = amount ?? 1
            habit.atMost = type == .cutBack
        case .time:
            habit.kind = .duration
            habit.goal = (minutes ?? 1).rounded()
        case .checklist:
            habit.kind = .checklist
            habit.steps = filledItems
        case .quit:
            habit.kind = .quit
            habit.quitSince = quitSince
        case .task:
            habit.kind = .task
            habit.dueDay = LocalDay(taskDate)
            if taskHasTime {
                let c = Calendar.current.dateComponents([.hour, .minute], from: taskTime)
                habit.dueMinute = (c.hour ?? 9) * 60 + (c.minute ?? 0)
                if taskRemind { habit.reminders = [ReminderTime(hour: c.hour ?? 9, minute: c.minute ?? 0)] }
            }
        }
        if type != .quit { habit.parts = type == .doIt ? parts : [parts[0]] }
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
            let cal = Calendar.current
            habit.reminders = Array(Set(reminders.map { cal.dateComponents([.hour, .minute], from: $0.time) }))
                .map { ReminderTime(hour: $0.hour ?? 9, minute: $0.minute ?? 0) }
                .sorted { ($0.hour, $0.minute) < ($1.hour, $1.minute) }
        }
        store.add(habit)
        onSaved()
    }
}

// MARK: - Rows

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
            TextField(placeholder, value: $value, format: .number)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .focused(focus, equals: field)
                .fixedSize()
                .font(.body.monospacedDigit().weight(.semibold))
                .accessibilityLabel(title)
            if !suffix.isEmpty { Text(suffix).foregroundStyle(.secondary).lineLimit(1).truncationMode(.tail) }
        }
        .frame(minHeight: 44)
        .contentShape(Rectangle())
        .onTapGesture { focus.wrappedValue = field }
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

/// Your own unit first, then the units people name most (research: "New Habit Words and Units").
struct UnitPicker: View {
    @Binding var unit: String
    let used: [String]
    @Environment(\.dismiss) private var dismiss
    @State private var custom = ""
    @FocusState private var typing: Bool

    static let groups: [(String, [String])] = [
        ("Count", ["times", "glasses", "cups", "pages", "steps", "reps", "push-ups"]),
        ("Time", ["minutes", "hours"]),
        ("Volume", ["ml", "oz", "litres"]),
        ("Distance", ["km", "miles"]),
        ("Weight", ["kg", "lbs"]),
        ("Money", ["$", "€", "£", "₹"]),
    ]

    var body: some View {
        List {
            Section {
                HStack {
                    TextField("Your own unit, e.g. chapters", text: $custom)
                        .focused($typing)
                        .limitText($custom, to: TextLimit.unit)
                        .submitLabel(.done)
                        .onSubmit(useCustom)
                    if !custom.trimmingCharacters(in: .whitespaces).isEmpty {
                        Button("Use", action: useCustom).fontWeight(.semibold)
                    }
                }
            } footer: {
                Text("Any word works: \"chapters\", \"laps\", \"prayers\".")
            }
            let known = Set(Self.groups.flatMap(\.1))
            let mine = used.filter { !known.contains($0) }
            if !mine.isEmpty {
                Section("Yours") { ForEach(mine, id: \.self, content: row) }
            }
            ForEach(Self.groups, id: \.0) { group in
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
