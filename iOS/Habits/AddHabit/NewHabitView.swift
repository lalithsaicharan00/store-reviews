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
        case .doIt: "Check It Off"
        case .amount: "Track an Amount"
        case .time: "Time It"
        case .checklist: "Checklist"
        case .cutBack: "Cut Down"
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
        case .checklist: "One habit, several steps."
        case .cutBack: "Set a maximum and log how much."
        case .quit: "Stop completely. Track the time since you stopped."
        case .task: "Something to get done."
        }
    }

    /// A common habit that can only be recorded one way (copy report, 28 Sep): a bed is never counted or
    /// timed, water is counted in glasses, meditation is timed.
    var example: String {
        switch self {
        case .doIt: "Make your bed"
        case .amount: "8 glasses of water"
        case .time: "Meditate 10 min"
        case .checklist: "Workout: push-ups, squats"
        case .cutBack: "Coffee, 2 a day"
        case .quit: "Smoking"
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
        case .checklist: "checklist"
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
    /// A name already chosen: Search's Add “yoga” (Figma's Search page, No match), filled into the form.
    var name = ""
    /// Called with the new habit's ID, so Today can show where it went.
    var onAdded: (UUID) -> Void = { _ in }
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            NewItemChoices(name: name, onAdded: { onAdded($0); dismiss() })
                .toolbar {
                    // Figma 1061:2016: a glass ✕, as every sheet in the app closes (Day details, the timer).
                    ToolbarItem(placement: .cancellationAction) { Button("Close", systemImage: "xmark") { dismiss() } }
                }
        }
    }
}

/// "What do you want to do?" and every screen after it, in whichever stack shows it: New's own sheet, or onboarding's
/// "Create my own habit" (Current Work 73.1), which pushes it as its next page, so a new person makes their first habit
/// exactly as they will every other time. The stack needs a `NavigationPath` (or none), as its pages push their own
/// values.
struct NewItemChoices: View {
    /// The name the form starts with (empty but for Search's Add “yoga”).
    var name = ""
    /// Called with the new item's ID once it's saved. The caller closes whatever the flow is in.
    let onAdded: (UUID) -> Void
    @Environment(HabitStore.self) private var store
    /// At 5 of 5: the 6th-habit sheet, for the choice that opened it (Current Work 80).
    @State private var sixthHabit: Kind?
    /// Plus bought or room made in that sheet: the choice goes ahead once the sheet has closed.
    @State private var unlocked: Kind?
    @State private var pushed: Kind?
    /// A routine made from Add a Routine: its banner floats here once New Routine closes.
    @State private var createdRoutine: CreatedRoutine?

    private enum Kind: Hashable, Identifiable {
        case good, bad
        var id: Self { self }
    }

    /// Figma 1061:2016. The heading is the page's first row, not a section header and not a navigation title: iOS
    /// fades and capitalises a section header, and Figma's bar has no title (Rulebook, 19 Nov: a line that introduces
    /// a `List` is an ordinary clear row). Habits and tasks share one card; a routine is its own thing (the user,
    /// 10 Nov 2026), so Add a Routine has a card of its own.
    var body: some View {
        List {
            Section {
                PageHeading("What Do You Want to Do?")
            }
            Section {
                habitChoice(.good, ChoiceLabel(icon: "chart.line.uptrend.xyaxis", title: "Build or Maintain", detail: "A habit you want to start or keep doing."))
                habitChoice(.bad, ChoiceLabel(icon: "chart.line.downtrend.xyaxis", title: "Quit or Cut Down", detail: "A habit you want to stop or do less."))
                NavigationLink {
                    taskKinds
                } label: {
                    ChoiceLabel(icon: "calendar.badge.checkmark", title: "Add a Task", detail: "Something to get done, once or on repeat.")
                }
            }
            Section {
                NavigationLink {
                    SectionEditor(existing: nil) { createdRoutine = $0 }
                } label: {
                    ChoiceLabel(icon: "list.bullet", title: "Add a Routine", detail: "Habits you do together, like a bedtime routine.")
                }
                .accessibilityIdentifier("new-routine")
            }
        }
        .listSectionSpacing(24)
        .contentMargins(.top, 0, for: .scrollContent)
        // The heading row is one line of Title 2; the list's 44-point minimum row would add 16 under it.
        .environment(\.defaultMinListRowHeight, 0)
        .navigationDestination(for: Kind.self) { kind in questions(kind) }
        .navigationDestination(item: $pushed) { kind in questions(kind) }
        .sheet(item: $sixthHabit, onDismiss: {
            guard let unlocked else { return }
            self.unlocked = nil
            pushed = unlocked
        }) { kind in
            SixthHabitSheet(reason: .sixth) { unlocked = kind }
        }
        .routineCreatedBanner($createdRoutine)
        .onPerfCommand { action in if action == .openSixthHabit { sixthHabit = .good } }
        .analyticsScreen(.newHabit)
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func questions(_ kind: Kind) -> some View {
        switch kind {
        case .good: question("How Do You Want to Track It?", [.doIt, .amount, .time, .checklist])
        case .bad: question("Quit or Cut Down?", [.quit, .cutBack])
        }
    }

    /// Build or maintain, Quit or cut down. At 5 of 5 free habits the 6th-habit sheet opens straight away (the user,
    /// 10 Oct 2026: no "5 of 5" screen first); the row still looks like it leads on.
    @ViewBuilder
    private func habitChoice(_ kind: Kind, _ label: ChoiceLabel) -> some View {
        if store.canAddHabit {
            NavigationLink(value: kind) { label }
        } else {
            Button { sixthHabit = kind } label: {
                HStack(spacing: 8) {
                    label
                    Image(systemName: "chevron.right")
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(.tertiary)
                        .accessibilityHidden(true)
                }
                .contentShape(Rectangle())
            }
            .foregroundStyle(Color.primary)
        }
    }

    /// The second question: the same page as the first, its heading the question (Figma 1061:2101, 1062:2).
    private func question(_ text: String, _ types: [ItemType]) -> some View {
        List {
            Section {
                PageHeading(text)
            }
            Section {
                ForEach(types) { type in
                    NavigationLink {
                        BuiltWhenShown { form(type) }
                    } label: {
                        ChoiceLabel(icon: type.icon, title: type.title, detail: type.summary, example: type.example)
                    }
                }
            }
        }
        .listSectionSpacing(24)
        .contentMargins(.top, 0, for: .scrollContent)
        .environment(\.defaultMinListRowHeight, 0)
        .navigationBarTitleDisplayMode(.inline)
    }

    /// What Kind of Task? (Figma 1109:2): the same choice page as the habit questions, two rows. Once or On Repeat
    /// is the first thing that shapes a task, so it's asked before the form, as a habit's type is (the user, 21 Nov
    /// 2026); the form then opens already set to it.
    private var taskKinds: some View {
        List {
            Section {
                PageHeading("What Kind of Task?")
            }
            Section {
                NavigationLink {
                    BuiltWhenShown { HabitForm(type: .task, name: name, onSaved: onAdded) }
                } label: {
                    ChoiceLabel(icon: "calendar", title: "Once", detail: "On one day, or with no date.", example: "Pick up parcel")
                }
                NavigationLink {
                    BuiltWhenShown { HabitForm(type: .task, name: name, repeats: true, onSaved: onAdded) }
                } label: {
                    ChoiceLabel(icon: "calendar.badge.clock", title: "On Repeat", detail: "Comes back on the days you pick, or a while after it’s done.", example: "Water plants, every 3 days")
                }
            }
        }
        .listSectionSpacing(24)
        .contentMargins(.top, 0, for: .scrollContent)
        .environment(\.defaultMinListRowHeight, 0)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func form(_ type: ItemType) -> some View {
        HabitForm(type: type, name: name, onSaved: onAdded)
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

/// A choice's example (Figma's Tag: "e.g. Smoking"): Footnote in Label on a Secondary System Fill capsule. iOS has no
/// chip on iPhone, and this isn't one: it can't be tapped, it only reads. A capsule rather than "Example: …" text so
/// the example reads apart from the description above it.
struct ExampleTag: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.footnote)
            .foregroundStyle(Color.primary)
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(Color(.secondarySystemFill), in: Capsule())
    }
}

/// A page's own heading as the first row of a `List` (Figma's create new pages: Title 2 Bold, Label, 16 from the
/// edge, the first card 24 under it). A clear row with the list's own leading inset, so it lines up with the cards'
/// edge at every text size; its own Section so the gap under it is the list's section spacing.
struct PageHeading: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.title2.bold())
            .foregroundStyle(Color.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .accessibilityAddTraits(.isHeader)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

/// A choice row (Figma's List item · two lines): the symbol in Secondary Label at Title 3 in a fixed column, the title
/// in Body, one Subheadline line in Secondary Label and (on the second screens) an example. The separator starts at
/// the text, as in Settings.
struct ChoiceLabel: View {
    let icon: String
    let title: String
    let detail: String
    var example: String? = nil
    @ScaledMetric(relativeTo: .title3) private var iconColumn = 24.0

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(.secondary)
                .frame(width: iconColumn)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 0) {
                Text(title).font(.body).foregroundStyle(Color.primary)
                Text(detail).font(.subheadline).foregroundStyle(.secondary)
                if let example { ExampleTag(text: "e.g. \(example)").padding(.top, 8) }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .alignmentGuide(.listRowSeparatorLeading) { $0[.leading] }
        }
        .accessibilityElement(children: .combine)
    }
}

/// The form for one type, laid out like the Round 3 mockup (the user's choice, 29 Sep): the habit read back
/// as a sentence; name, icon and colour; How much, Each + adds and How often (only the rows the type needs);
/// Time of Day and Reminders; then Starts and Ends. Every row starts filled with a suggestion
/// (`HabitDefaults`), and the line under the sentence says which ones. Anything needing its own page is
/// pushed, never a sheet, so the whole flow moves one way.
struct HabitForm: View {
    enum Field: Hashable { case name, description, amount, unit, increment, minutes, reminderText, item(UUID) }

    /// One reminder. `part` is the time of day it's for (nil for Anytime); its time stays inside that part.
    struct DraftTime: Identifiable, Hashable {
        var id = UUID()
        var time: Date
        var part: String?
    }

    let type: ItemType
    let onSaved: (UUID) -> Void
    /// Editing: the group as saved.
    /// Editing: the habit as saved. The form opens filled in, shows only what can change (how it's tracked is
    /// fixed and never shown, spec §8) and saves with Save.
    private let original: Habit?

    @Environment(HabitStore.self) private var store
    @Environment(ReminderScheduler.self) private var scheduler
    @Environment(\.dismiss) private var dismiss

    /// The name as typed. Only the name field reads its text while drawing (`TypedName`), so a letter redraws the
    /// field and nothing else (PERFORMANCE.md rule 11): when the form read it, every letter rebuilt the whole form
    /// and its preview row (profile, 1 Oct 2026). Saving always reads it live, so nothing typed is ever lost.
    @State private var typed = TypedName("")
    private var name: String { typed.text }
    /// The name as the previews show it: the preview row, the sentence and the icon suggestion catch up when typing
    /// pauses. Redrawing and re-animating them on every letter kept the main thread 92 % busy while typing (30 Sep).
    @State private var shownName = ""
    /// What counts, how to do it, why it matters: optional, shown in the routine player (notes report, 29 Sep).
    @State private var descriptionText = ""
    /// "Reminder says…" (Current Work 58): typed in its own field (`ReminderSaysField`), so a letter redraws only it (S11).
    @State private var reminderWords = ReminderWords("")
    /// The description as saved, when editing.
    private var originalDescription = ""
    @State private var symbol: String
    @State private var pickedSymbol = false
    @State private var color: HabitColor
    @State private var showAppearance = false
    /// The 6th-habit sheet, and whether to add the habit once it closes (Plus bought or room made).
    @State private var sixthHabit = false
    @State private var addAfterSheet = false
    /// The name as it was when Add was tapped: the sheet never reads the typed text, so typing never redraws the form
    /// for it (S11).
    @State private var sixthName = ""

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
    /// A routine made from the Time of Day page: its banner floats there once New Routine closes.
    @State private var createdRoutine: CreatedRoutine?
    /// A checklist's steps.
    @State private var items: [Step] = []
    @State private var quitSince = Date.now
    @State private var taskDate = Date.now
    @State private var taskHasTime = false
    /// A one-time task with a date (Figma's Date switch, on by default). Off is "No date" (U38), which the model
    /// can't store yet: saved with its date for now (Create New checklist, "Left for the logic pass").
    @State private var taskHasDate = true
    @State private var pickingTaskDate = false
    @State private var pickingTaskTime = false
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

    @State private var notificationsDenied = false
    /// The reminder whose wheel is open on the Reminders page, if any.
    @State private var editingTime: UUID?
    @State private var alarmsDenied = false
    @State private var confirmDiscard = false
    @FocusState private var focus: Field?

    /// A new habit or task: nothing is saved until Add, and amounts stay empty (C203, C292).
    /// `repeats`: a task opened from What Kind of Task?'s On Repeat (Figma 1109:2) starts on a schedule.
    init(type: ItemType, name: String = "", repeats: Bool = false, onSaved: @escaping (UUID) -> Void) {
        self.type = type
        self.onSaved = onSaved
        original = nil
        _taskRepeats = State(initialValue: type == .task && repeats)
        let name = TextLimit.clean(name, TextLimit.name)
        _color = State(initialValue: .blue)
        let plainSymbol = type == .quit ? "nosign" : type == .task ? "calendar" : "star.fill"
        _symbol = State(initialValue: plainSymbol)
        _typed = State(initialValue: TypedName(name))
        _shownName = State(initialValue: name)
        // Amounts start empty (left out of the sentence): the right amount depends on the person. How often starts
        // as every day and Time of Day as Anytime (the user, 29 Sep).
        let start = HabitDefaults.suggest(type, name: name)
        _amountText = State(initialValue: "")
        _unit = State(initialValue: "")
        _hours = State(initialValue: "0")
        _minutes = State(initialValue: "0")
        var draft = OftenDraft()
        draft.choose(start.often)
        _often = State(initialValue: draft)
    }

    /// Opens the form on a saved habit, every row as it is now.
    init(editing habit: Habit, weekStart: Int, description: String = "", onSaved: @escaping (UUID) -> Void) {
        type = ItemType(habit)
        self.onSaved = onSaved
        original = habit
        originalDescription = description
        _descriptionText = State(initialValue: description)
        _typed = State(initialValue: TypedName(habit.name))
        _reminderWords = State(initialValue: ReminderWords(habit.reminderText ?? ""))
        _shownName = State(initialValue: habit.name)
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
    private func edited(name: String) -> Habit? {
        guard let original else { return nil }
        var habit = makeHabit(name: name)
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
        // The saved name here, and the name field's own "changed": the typed text is never read while drawing.
        (edited(name: original?.name ?? "").map { $0 != original } ?? false) || typed.isChanged || reminderWords.isChanged || TextLimit.clean(descriptionText, TextLimit.descriptionText) != originalDescription
    }

    private var trimmedName: String { TextLimit.clean(name, TextLimit.name) }
    private var shownTrimmedName: String { TextLimit.clean(shownName, TextLimit.name) }
    private var filledItems: [Step] {
        items.compactMap { item in
            let name = TextLimit.clean(item.name, TextLimit.checklistPart)
            return name.isEmpty ? nil : Step(id: item.id, name: name)
        }
    }
    private var remind: Bool { remindOn && !times.isEmpty }
    /// Something the person typed (U18: Cancel asks first only then).
    private var hasChanges: Bool { editing ? editChanged : typed.isChanged || !filledItems.isEmpty }
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
        guard typed.isFilled else { return false }
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
        // Figma's Create new form (1065:2597): the name card, then the type's own card, then Routine and Reminders,
        // then Starts and Ends. No preview card and no sentence any more: the rows say what's chosen.
        Form {
            nameSection
            switch type {
            case .quit:
                quitSection
            case .task:
                taskSection
                Section {
                    timeOfDayRow
                    remindersRow
                }
                if taskRepeats { startEndSection }
            default:
                planSection
                if type == .cutBack {
                    // A limit has no routine: it's logged only when it happens, so on Today it sits under Quit or
                    // Cut Down, never in a routine where it reads as something to do (the user, 5 Oct 2026).
                    Section { remindersRow }
                } else {
                    Section {
                        timeOfDayRow
                        remindersRow
                    }
                }
                startEndSection
            }
            if editing { editOutcomeSection }
        }
        // Figma's 16 between cards and above the first; iOS's own default is about twice that.
        .listSectionSpacing(16)
        .contentMargins(.top, 16, for: .scrollContent)
        .accessibilityIdentifier("habit-form")
        .analyticsScreen(editing ? .habitDetail : type == .task ? .newTask : .newHabit)
        .navigationTitle(editing ? (type == .task ? "Edit Task" : "Edit Habit") : type == .task ? "New Task" : "New Habit")
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
        // Figma's bar is ‹ and Add. iOS's own back button stays while nothing is typed; once something is, the same ‹
        // asks first, so a swipe or a tap never loses a typed habit (U18).
        .navigationBarBackButtonHidden(hasChanges)
        .toolbar {
            if hasChanges {
                ToolbarItem(placement: .cancellationAction) {
                    Button(editing ? "Cancel" : "Back", systemImage: editing ? "xmark" : "chevron.backward") { confirmDiscard = true }
                        .confirmationDialog("Discard this?", isPresented: $confirmDiscard, titleVisibility: .hidden) {
                            Button("Discard Changes", role: .destructive) { dismiss() }
                            Button("Keep Editing", role: .cancel) {}
                        }
                }
            } else if editing {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") { dismiss() }
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
        // Adding a 6th habit on the free plan (a form opened before the limit was reached): the
        // 6th-habit sheet, and the form is kept whatever happens there. Saved once there's Plus or room; ✕ comes back
        // here (Current Work 80).
        .sheet(isPresented: $sixthHabit, onDismiss: {
            guard addAfterSheet else { return }
            addAfterSheet = false
            addNew()
        }) {
            SixthHabitSheet(reason: .adding(sixthName)) { addAfterSheet = true }
        }
        // Icon and colour are quick picks, so they pop up over the form (the user's choice).
        .sheet(isPresented: $showAppearance) {
            // The page's own ✕ and Done (Figma 1074:932); Done saves the ring's icon and closes.
            NavigationStack {
                IconSheet(symbol: $symbol) { pickedSymbol = true }
            }
        }
        // Figma's Colour (1074:161496): a short sheet floating on glass with ✕ and the title, then the swatches. A tap
        // picks and closes, so there's no Done. One height, so iOS draws no drag handle.
        .sheet(isPresented: $showColors) {
            ColourSheet(selection: Binding(get: { color }, set: { color = $0; showColors = false }))
        }
        // The name field's typing pause (in `NameField`) is cancelled when a screen opens over the form, so the previews catch up at once when the
        // form is back, or when the name field is left: never "Enter a habit name" under a typed name (merge, 1 Oct).
        .onAppear { catchUpName() }
        .onChange(of: focus) { if focus != .name { catchUpName() } }
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
                // The app's today, as on Today: between midnight and a 3 AM day start the calendar already says
                // tomorrow, and a habit started then stayed off Today until 3 AM (Current Work 52, 6 Oct 2026).
                startDate = trackingToday; endDate = trackingToday; taskDate = trackingToday
                color = store.suggestedColor()
                if name.isEmpty && PerfSwitches.focusFormName { focus = .name }
                if type != .quit { syncReminders(force: true) }
            }
            notificationsDenied = await scheduler.isDenied()
            alarmsDenied = scheduler.alarmsDenied()
        }
    }

    // MARK: Name, icon, colour

    @Environment(\.dynamicTypeSize) private var textSize

    /// Figma's first card: Name, Description (optional), then Icon | Colour, every type alike (quit too).
    private var nameSection: some View {
        Section {
            NameField(typed: typed, placeholder: type.namePlaceholder, focus: $focus, onPause: catchUpName)
            TextField("Description (optional)", text: $descriptionText, axis: .vertical)
                .lineLimit(1...4)
                .focused($focus, equals: .description)
                .limitText($descriptionText, to: TextLimit.descriptionText)
                .accessibilityIdentifier("description-field")
            // Two buttons in one row, each taking its own tap (`.borderless`), as decided on 6 Nov 2026. At the
            // accessibility sizes they stack as two rows (Figma's 200 % variant): chosen from the text size, not
            // `ViewThatFits`, which lays out both (S10).
            if textSize.isAccessibilitySize {
                iconButton
                colourButton
            } else {
                HStack(spacing: 0) {
                    iconButton
                    Divider().frame(height: 28).padding(.horizontal, 12)
                    colourButton
                }
            }
        } footer: {
            NameFooter(typed: typed, describing: focus == .description)
        }
    }

    private var iconButton: some View {
        Button { focus = nil; showAppearance = true } label: {
            HStack(spacing: 10) {
                HabitIcon(symbol: symbol, color: color, size: 28)
                Text("Icon").foregroundStyle(Color.primary)
                Spacer(minLength: 4)
                RowChevron()
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.borderless)
        .accessibilityLabel("Icon")
    }

    private var colourButton: some View {
        Button { focus = nil; showColors = true } label: {
            HStack(spacing: 10) {
                Circle().fill(color.color.gradient).frame(width: 28, height: 28)
                Text("Colour").foregroundStyle(Color.primary)
                Spacer(minLength: 4)
                RowChevron()
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.borderless)
        .accessibilityLabel("Colour, \(color.name)")
    }

    // MARK: Rows that open full screens

    /// A row that opens its own full screen: the setting, and under it the choice in Subheadline Secondary Label
    /// (Figma's two-line List item, as Settings' Wi-Fi rows read). iOS draws the chevron.
    private func screenRow<Destination: View>(_ title: String, value: String, @ViewBuilder destination: @escaping () -> Destination) -> some View {
        // Built when opened, not with the form: a link's destination is otherwise made on every redraw of the form,
        // reminders, date pickers and summaries included (Edit habit's first open, 701 ms, 1 Oct).
        NavigationLink {
            BuiltWhenShown(destination)
        } label: {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                Text(value).font(.subheadline).foregroundStyle(Color(.secondaryLabel))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.vertical, 2)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title), \(value)")
    }

    /// A repeating task's How often: the habit screen without counts, plus "After it's done" (29 Sep).
    private var repeatRow: some View {
        screenRow("How Often", value: often.often(hasAmount: false).label(hasAmount: false, weekStart: weekStart)) {
            HowOftenEditor(draft: $often, amountText: nil, checklist: false, limit: false, start: startDate,
                           weekStart: weekStart, task: true)
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
        if type == .cutBack { return text }
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
        guard !shownTrimmedName.isEmpty else {
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

    /// Before an amount is set, the sentence's habit carries a stand-in amount, so it reads with its +, ▶ or ✓.
    private static let standIn = 7_777_777.0

    /// The habit as the previews show it: "Your habit" until named, and the stand-in amount until set, so
    /// the row already has its +, ▶ or ✓.
    private var previewHabit: Habit {
        var habit = draft
        habit.name = shownTrimmedName
        if habit.name.isEmpty { habit.name = type == .task ? "Your task" : "Your habit" }
        if hasAmount && amountValue == nil {
            var stand = plan
            stand.amount = Self.standIn
            stand.step = step ?? 1
            stand.apply(to: &habit)
        }
        return habit
    }

    /// How much, what + adds, and how often: the rows that make the sentence above, only as the type needs.
    private var planSection: some View {
        Section {
            switch type {
            case .amount, .cutBack:
                screenRow(type == .cutBack ? "Limit" : "How Much", value: amountValue == nil ? "Not set yet" : plan.howMuchLabel) {
                    HowMuchEditor(mode: type == .cutBack ? .limit : .amount, amount: $amountText, unit: $unit, hours: $hours,
                                  minutes: $minutes, usedUnits: store.usedUnits, period: amountPeriod,
                                  sentence: type == .cutBack ? screenText : nil, hint: amountHint,
                                  limitInMinutes: type == .cutBack ? original.map { if case .duration = $0.kind { true } else { false } } : nil,
                                  asksEachTime: type == .amount ? $asksHowMuch : nil, step: $step,
                                  stepPlaceholder: HabitCopy.number(plan.stepValue))
                        .onAppear { focus = nil }
                }
                .accessibilityIdentifier("how-much-row")
            case .time:
                screenRow("How Long", value: amountValue == nil ? "Not set yet" : plan.howMuchLabel) {
                    HowMuchEditor(mode: .time, amount: $amountText, unit: $unit, hours: $hours, minutes: $minutes,
                                  usedUnits: store.usedUnits, period: amountPeriod, sentence: screenText, hint: amountHint)
                        .onAppear { focus = nil }
                }
                .accessibilityIdentifier("how-much-row")
            case .checklist:
                screenRow("Steps", value: filledItems.isEmpty ? "None yet" : filledItems.count == 1 ? "1 step" : "\(filledItems.count) steps") {
                    Form { ChecklistItemsSection(items: $items) }
                        .listSectionSpacing(24)
                        .contentMargins(.top, 16, for: .scrollContent)
                        // Edit mode for the grabbers only (the rows have `.onMove` and no `.onDelete`, so iOS draws no
                        // ⊖ of its own); the red ⊖ is RemoveButton, which removes at once, as Figma's row does.
                        .environment(\.editMode, .constant(.active))
                        .navigationTitle("Steps")
                        .navigationBarTitleDisplayMode(.inline)
                }
                .accessibilityIdentifier("steps-row")
            default:
                EmptyView()
            }
            screenRow("How Often", value: plan.often.label(hasAmount: plan.hasAmount, checklist: plan.checklist, weekStart: weekStart)) {
                HowOftenEditor(draft: $often, amountText: amountWords, checklist: plan.checklist, limit: type == .cutBack,
                               start: startDate, weekStart: weekStart, amountExpected: hasAmount)
                    .onAppear { focus = nil }
            }
            .accessibilityIdentifier("how-often-row")
        }
    }

    /// The day Today shows, as a date: the calendar day, or the one before it until the day start (Rulebook D7).
    private var trackingToday: Date { store.today().date(calendar: store.calendar) }

    /// "Today", "Tomorrow", "Yesterday", or "Wed 1 Oct": the start as a person says it, counted from the app's today.
    private func dayWords(_ date: Date) -> String {
        let cal = Calendar.current
        let today = trackingToday
        if cal.isDate(date, inSameDayAs: today) { return "Today" }
        if let next = cal.date(byAdding: .day, value: 1, to: today), cal.isDate(date, inSameDayAs: next) { return "Tomorrow" }
        if let last = cal.date(byAdding: .day, value: -1, to: today), cal.isDate(date, inSameDayAs: last) { return "Yesterday" }
        let sameYear = cal.component(.year, from: date) == cal.component(.year, from: .now)
        return sameYear ? date.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated))
            : date.formatted(.dateTime.day().month(.abbreviated).year())
    }

    /// Figma's last card: Starts, iOS's compact date picker (the grey capsule says it can be changed), and Ends, a
    /// pop-up button (Never or On a Date, ⌃⌄ as iOS draws a menu picker). On a Date adds the end's own compact
    /// picker under it, as Calendar's Repeat › End Repeat does. No pages to open: one choice each, picked in place.
    private var startEndSection: some View {
        Section {
            // "Started" for a day in the past, as a person would say it.
            DatePicker(startDate < trackingToday ? "Started" : "Starts", selection: $startDate, displayedComponents: .date)
                .accessibilityIdentifier("starts-row")
            Picker("Ends", selection: Binding(get: { hasEnd }, set: { on in
                withAnimation {
                    if on && endDate <= startDate {
                        endDate = Calendar.current.date(byAdding: .day, value: 30, to: startDate) ?? startDate
                    }
                    hasEnd = on
                }
            })) {
                Text("Never").tag(false)
                Text("On a Date").tag(true)
            }
            .pickerStyle(.menu)
            // Figma's value is grey, as Calendar's End Repeat: a value, not the page's main action.
            .tint(Color(.secondaryLabel))
            .accessibilityIdentifier("ends-row")
            if hasEnd {
                DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
                    .accessibilityIdentifier("end-date-picker")
            }
        }
    }

    /// Figma's quit card: when it started, the day and the time as two compact pickers on one moment.
    private var quitSection: some View {
        Section {
            DatePicker("Started", selection: $quitSince, in: ...Date.now, displayedComponents: .date)
            DatePicker("Time", selection: $quitSince, in: ...Date.now, displayedComponents: .hourAndMinute)
        } footer: {
            Text("The run counts up from here. A slip starts it again.").formNote()
        }
    }

    private func catchUpName() {
        guard shownName != name else { return }
        shownName = name
        suggestIcon()
    }

    /// Editing an old task must keep its saved date, even when only its name changes.
    private var earliestTaskDate: Date {
        let today = trackingToday
        return original?.dueDay.map { min(today, Calendar.current.startOfDay(for: $0.date())) } ?? today
    }

    /// A task's own card. Once (Figma `Type=Task once`): Date and Time switches, each with its value under it
    /// once on, as Reminders' Date and Time rows; tapping the value opens the picker in a popover over the form
    /// (`Open=Date picker`). On Repeat (`Type=Task on repeat`): How Often, then the Time switch. Once or on repeat is
    /// chosen on What Kind of Task? before the form, so the old Repeat picker is gone.
    private var taskSection: some View {
        Section {
            if taskRepeats {
                repeatRow
            } else {
                Toggle(isOn: $taskHasDate.animation()) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Date")
                        if taskHasDate {
                            Button(dayWords(taskDate)) { focus = nil; pickingTaskDate = true }
                                .font(.subheadline)
                                .foregroundStyle(Color(.secondaryLabel))
                                .buttonStyle(.borderless)
                                // Under the row, as Figma's Open=Date picker. The switch's green would tint the
                                // calendar too, so it's set back to Ink, as every picker in the app.
                                .popover(isPresented: $pickingTaskDate, arrowEdge: .top) {
                                    DatePicker("Date", selection: $taskDate, in: earliestTaskDate..., displayedComponents: .date)
                                        .datePickerStyle(.graphical)
                                        .labelsHidden()
                                        .tint(.ink)
                                        .frame(width: 320)
                                        .padding(8)
                                        .presentationCompactAdaptation(.popover)
                                }
                        }
                    }
                }
                .tint(.green)
                .onChange(of: taskHasDate) { if taskHasDate { pickingTaskDate = true } }
            }
            Toggle(isOn: $taskHasTime.animation()) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Time")
                    if taskHasTime {
                        Button(taskTime.formatted(date: .omitted, time: .shortened)) { focus = nil; pickingTaskTime = true }
                            .font(.subheadline)
                            .foregroundStyle(Color(.secondaryLabel))
                            .buttonStyle(.borderless)
                            .popover(isPresented: $pickingTaskTime, arrowEdge: .top) {
                                DatePicker("Time", selection: $taskTime, displayedComponents: .hourAndMinute)
                                    .datePickerStyle(.wheel)
                                    .labelsHidden()
                                    .tint(.ink)
                                    .padding(8)
                                    .presentationCompactAdaptation(.popover)
                            }
                    }
                }
            }
            .tint(.green)
            .onChange(of: taskHasTime) { if taskHasTime { pickingTaskTime = true } }
        } footer: {
            Text(taskRepeats ? "It comes back on the days you pick."
                 : taskHasDate ? "If it isn’t done on its day, it carries over to the next day until it’s done."
                 : "With no date, it stays on Tasks and never shows on Today.").formNote()
        }
    }

    // MARK: How often, part of day, reminders

    // MARK: Time of day, reminders

    /// The habit as it would be saved, so the form's sentences use the same rules as Today.
    private var draft: Habit { makeHabit(name: shownTrimmedName) }

    /// Tapping a routine: a habit sits in one routine (the Rulebook, 6 Nov 2026; Android A118), so a tap replaces the
    /// choice. `parts` stays an array for now; the logic pass turns it into one value.
    private func choose(_ id: String) {
        timesOfDay = [id]
        syncReminders()
    }

    /// Two or more reminders put a habit in All Day by itself (Android A120). All Day isn't a routine in the model yet
    /// (see the checklist's logic pass), so the page shows it from the reminders alone.
    private var inAllDay: Bool { remindOn && times.count >= 2 }

    /// "Anytime", "Morning", or "All Day" for a habit with several reminders.
    private var timeOfDaySummary: String {
        inAllDay ? "All Day" : HabitCopy.join(timesOfDay.map { store.section($0).name })
    }

    /// The Routine page (Figma `4754:46072`): one card of Checkmark rows, All Day first, then Anytime, then the person's
    /// routines by start, each with its times; New Routine is its own row under them. One choice. A habit with several
    /// reminders is in All Day and the other rows can't be chosen; a footer says why and how to choose another.
    /// Figma's page component is a plain list here: `Form` draws the cards, lines and disabled text.
    private var timeOfDayRow: some View {
        screenRow("Routine", value: timeOfDaySummary) {
            Form {
                Section {
                    // Built in and always first. Not a routine in the model yet: chosen by the reminders, not a tap.
                    CheckRow(title: "All Day", detail: "For habits with several reminders", selected: inAllDay) {}
                        .accessibilityIdentifier("routine-all-day")
                    Group {
                        CheckRow(title: "Anytime", detail: "For habits with no set time",
                                 selected: !inAllDay && timesOfDay == [.anytime]) { choose(.anytime) }
                            .accessibilityIdentifier("routine-anytime")
                        ForEach(store.timedSections.map(\.section)) { section in
                            CheckRow(title: section.name, detail: Outcome.hours(section, store: store),
                                     selected: !inAllDay && timesOfDay == [section.id]) { choose(section.id) }
                                .accessibilityIdentifier("routine-\(section.id)")
                        }
                    }
                    .disabled(inAllDay)
                }
                Section {
                    AddRow(title: "New Routine") { focus = nil; addingSection = true }
                        .accessibilityIdentifier("routine-new")
                } footer: {
                    if inAllDay {
                        Text("It has reminders at several times, so it’s in All Day. With one reminder or none, you can choose another.")
                    }
                }
            }
            .listSectionSpacing(16)
            .contentMargins(.top, 16, for: .scrollContent)
            .navigationTitle("Routine")
            .navigationBarTitleDisplayMode(.inline)
            // Pushed from here, so saving comes back to this list with the new one ticked (attached to
            // the form, it replaced this screen and Save jumped back to the form; found 28 Sep).
            .navigationDestination(isPresented: $addingSection) {
                SectionEditor(existing: nil) { created in choose(created.id); createdRoutine = created }
            }
            .routineCreatedBanner($createdRoutine)
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
    /// Figma's Reminders page (`1100:2996`: Off, On, On with the menu open) is a page component; here it's a plain
    /// `Form`, so iOS draws the cards, headers, footers, lines and the menu. No sticky sentence (Figma has none).
    private var remindersRow: some View {
        screenRow("Reminders", value: remindersSummary) {
            Form { remindersSections }
                .listSectionSpacing(24)
                .contentMargins(.top, 16, for: .scrollContent)
                .navigationTitle("Reminders")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear { focus = nil; editingTime = nil }
        }
        .accessibilityIdentifier("reminders-row")
    }

    /// "A notification" or "An alarm": the value under Remind Me With.
    private var alertValue: String { alert == .alarm ? "An alarm" : "A notification" }

    /// "Never", "Every 15 min": the value under If Not Done, Remind Again.
    private var followUpValue: String {
        switch followUp {
        case nil: "Never"
        case 60?: "Every hour"
        case let minutes?: "Every \(minutes) min"
        }
    }

    /// Turning Remind Me on asks for notifications there and then, once (Rulebook U37): iOS's own alert is Figma's
    /// "Allow notifications?" (`1164:344717`). Not allowed, the switch goes back off and the footer says why.
    private func remindTurned(on: Bool) {
        guard on else { editingTime = nil; return }
        // Turning it on brings one reminder per chosen routine, unless the person already set their own.
        if times.isEmpty || !remindersEdited { syncReminders(force: true) }
        Task {
            let allowed = await scheduler.requestPermission()
            notificationsDenied = !allowed
            if !allowed { withAnimation { remindOn = false } }
        }
    }

    /// Reminders: Remind Me, then Remind me at (the times, Add a Time), How (with what, and again if not done), and
    /// the person's own words. Each time is a row that opens a wheel under it when tapped, as Calendar's Starts
    /// and Ends do, because Figma draws the time as the row's words, not a picker's pill; a swipe deletes it, as in
    /// Clock's alarms (Figma has no − button).
    @ViewBuilder
    private var remindersSections: some View {
        Section {
            Toggle("Remind Me", isOn: $remindOn.animation())
                .tint(.green)
                .onChange(of: remindOn) { remindTurned(on: remindOn) }
        } footer: {
            if notificationsDenied {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Notifications are off for Often Enough, so reminders can’t arrive. Turn them on in Settings.")
                    Button("Open Settings") {
                        if let url = URL(string: UIApplication.openSettingsURLString) { UIApplication.shared.open(url) }
                    }
                    .font(.footnote.weight(.semibold))
                    .tint(Color.ink)
                }
            } else if !remindOn {
                Text("Reminders are off. Turning on Remind Me asks once to send you notifications.")
            }
        }
        if remindOn {
            Section {
                ForEach($times) { $reminder in
                    ReminderTimeRow(time: Binding(get: { reminder.time }, set: { reminder.time = $0; remindersEdited = true }),
                                    range: range(for: reminder.part), label: label(for: reminder),
                                    open: editingTime == reminder.id) {
                        withAnimation { editingTime = editingTime == reminder.id ? nil : reminder.id }
                    } delete: {
                        removeReminder(reminder.id)
                    }
                }
                PlusRow(title: "Add a Time", action: addReminder)
                    .accessibilityIdentifier("add-reminder")
            } header: {
                Text("Remind me at")
            } footer: {
                // Two or more reminders put a habit in All Day by itself (Android A120); the page says so.
                if times.count >= 2 {
                    Text("You’ve added more than one reminder, so this habit goes in All Day.")
                }
            }
            if !times.isEmpty {
                Section {
                    if ReminderScheduler.alarmsAvailable {
                        MenuValueRow(title: "Remind Me With", value: alertValue) {
                            // Toggles, not a Picker: a Picker in a menu drops each choice's second line. A menu takes
                            // the title, second line and symbol from the label's own children (two Texts and an Image);
                            // wrapped in a Label, the second line was dropped too.
                            Toggle(isOn: Binding(get: { alert == .notification }, set: { if $0 { alert = .notification } })) {
                                Text("A notification"); Text("In your notifications"); Image(systemName: "bell")
                            }
                            Toggle(isOn: Binding(get: { alert == .alarm }, set: { if $0 { alert = .alarm } })) {
                                Text("An alarm"); Text("Rings until you stop it"); Image(systemName: "alarm")
                            }
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
                        MenuValueRow(title: "If Not Done, Remind Again", value: followUpValue) {
                            Picker("If Not Done, Remind Again", selection: $followUp) {
                                Text("Never").tag(Int?.none)
                                Text("Every 15 min").tag(Int?.some(15))
                                Text("Every 30 min").tag(Int?.some(30))
                                Text("Every hour").tag(Int?.some(60))
                            }
                        }
                    }
                } header: {
                    Text("How")
                } footer: {
                    if type != .cutBack { Text("Not sent on a day it’s already done.") }
                }
                // The person's own words for these reminders (Privacy & Security spec §3.7), under the times.
                Section {
                    ReminderSaysField(words: reminderWords, focus: $focus)
                } footer: {
                    Text("Shown instead of the name when names are hidden outside the app.")
                }
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
        let ids = reminderParts
        times = ids.enumerated().map { i, id in
            DraftTime(id: times.indices.contains(i) ? times[i].id : UUID(), time: Self.date(minute: defaultMinute(for: id)),
                      part: id == .anytime ? nil : id)
        }
    }

    /// Another reminder for the part of the day with the fewest, an hour after its last one if that fits.
    private func addReminder() {
        if times.isEmpty { syncReminders(force: true); return }
        remindersEdited = true
        let parts: [String?] = reminderParts == [.anytime] ? [nil] : reminderParts.map { Optional($0) }
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
        return reminderParts.contains(id) && id != .anytime ? id : nil
    }

    /// The times of day reminders follow: none for a limit, which has no time of day on the form (a limit made before
    /// 5 Oct keeps its saved one, unused by Today).
    private var reminderParts: [String] { type == .cutBack ? [.anytime] : timesOfDay }

    /// What saving will do, in one line, before Save (spec §8.4).
    @ViewBuilder private var editOutcomeSection: some View {
        if let original, let habit = edited(name: original.name), type != .quit {
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
    private func makeHabit(name: String) -> Habit {
        var habit = Habit(name: name, symbol: symbol, color: color, kind: .check)
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
        // Read live, never while drawing (`ReminderWords.current`): kept with the habit even while reminders are off.
        let words = TextLimit.clean(reminderWords.current, TextLimit.reminderText)
        habit.reminderText = words.isEmpty ? nil : words
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
        if let habit = edited(name: trimmedName) {
            if habit.remind && !habit.reminders.isEmpty { Task { _ = await scheduler.requestPermission() } }
            store.update(habit)
            store.setDescription(descriptionText, of: habit.id)
            onSaved(habit.id)
            dismiss()
            return
        }
        if type.isHabit && !store.canAddHabit {
            sixthName = trimmedName
            sixthHabit = true
            return
        }
        addNew()
    }

    private func addNew() {
        let habit = makeHabit(name: trimmedName)
        // Reminders are on by default, so permission is asked when the habit is saved, not before.
        if habit.remind && !habit.reminders.isEmpty { Task { _ = await scheduler.requestPermission() } }
        store.add(habit)
        store.setDescription(descriptionText, of: habit.id)
        onSaved(habit.id)
    }
}

// MARK: - Name

/// The name being typed. Only the name field and its note read `text` while drawing; the form reads `isFilled` and
/// `isChanged`, which change only when the name becomes empty or not, or returns to what was saved
/// (PERFORMANCE.md rule 11, 1 Oct 2026).
@Observable final class TypedName {
    var text: String { didSet { if text != oldValue { settle() } } }
    private(set) var isFilled: Bool
    private(set) var isChanged = false
    @ObservationIgnored private let saved: String

    init(_ text: String) {
        self.text = text
        saved = TextLimit.clean(text, TextLimit.name)
        isFilled = !saved.isEmpty
    }

    private func settle() {
        let clean = TextLimit.clean(text, TextLimit.name)
        if isFilled == clean.isEmpty { isFilled = !clean.isEmpty }
        if isChanged != (clean != saved) { isChanged = clean != saved }
    }
}

/// The name field on its own, so typing redraws only it. When typing pauses for 0.3 s it tells the form, and the
/// previews catch up (`HabitForm.shownName`).
private struct NameField: View {
    let typed: TypedName
    let placeholder: String
    var focus: FocusState<HabitForm.Field?>.Binding
    let onPause: () -> Void

    var body: some View {
        @Bindable var typed = typed
        TextField(placeholder, text: $typed.text, axis: .vertical)
            .lineLimit(1...2)
            .font(.body.weight(.semibold))
            .focused(focus, equals: .name)
            .limitText($typed.text, to: TextLimit.name)
            .submitLabel(.done)
            .onSubmit { focus.wrappedValue = nil }
            .accessibilityLabel("Name")
            .accessibilityIdentifier("name-field")
            .frame(minHeight: 36)
            .onChange(of: typed.text) {
                // A wrapping field puts Return into the text; treat it as Done instead.
                if typed.text.contains("\n") {
                    typed.text = typed.text.replacingOccurrences(of: "\n", with: "")
                    focus.wrappedValue = nil
                }
            }
            .task(id: typed.text) {
                try? await Task.sleep(for: .milliseconds(300)) // a new letter cancels this and starts again
                guard !Task.isCancelled else { return }
                onPause()
            }
    }
}

/// "Reminder says…" as typed. The field reads `text`; the form reads only `isChanged`, and saving reads `current`,
/// which isn't observed, so typing never redraws the form (S11).
@Observable final class ReminderWords {
    var text: String {
        didSet {
            guard text != oldValue else { return }
            current = text
            let changed = TextLimit.clean(text, TextLimit.reminderText) != saved
            if isChanged != changed { isChanged = changed }
        }
    }
    @ObservationIgnored private(set) var current: String
    private(set) var isChanged = false
    @ObservationIgnored private let saved: String

    init(_ text: String) {
        self.text = text
        current = text
        saved = TextLimit.clean(text, TextLimit.reminderText)
    }
}

/// The Reminder Says field on its own row, so typing redraws only it (S11); one line, 24 characters (U6).
/// Figma: a speech bubble, then the field across the row, its placeholder the row's name.
private struct ReminderSaysField: View {
    let words: ReminderWords
    var focus: FocusState<HabitForm.Field?>.Binding

    var body: some View {
        @Bindable var words = words
        HStack(spacing: 16) {
            Image(systemName: "bubble.left").font(.title3).foregroundStyle(.secondary).frame(width: 24)
                .accessibilityHidden(true)
            TextField("Reminder Says (optional)", text: $words.text)
                .focused(focus, equals: .reminderText)
                .limitText($words.text, to: TextLimit.reminderText)
                .submitLabel(.done)
                .onSubmit { focus.wrappedValue = nil }
                .accessibilityLabel("Reminder Says")
                .accessibilityIdentifier("reminder-says-field")
                .alignmentGuide(.listRowSeparatorLeading) { $0[.leading] }
        }
    }
}

/// One reminder on the Reminders page: a clock, then its time as the row's words (Figma `1100:2915`). A tap opens
/// a wheel under it, as Calendar's Starts does; a swipe deletes it, as Clock's alarms do.
private struct ReminderTimeRow: View {
    @Binding var time: Date
    let range: ClosedRange<Date>
    let label: String
    let open: Bool
    let toggle: () -> Void
    let delete: () -> Void

    var body: some View {
        Button(action: toggle) {
            HStack(spacing: 16) {
                Image(systemName: "clock").font(.title3).foregroundStyle(.secondary).frame(width: 24)
                Text(time.formatted(date: .omitted, time: .shortened)).foregroundStyle(Color.primary)
                    .alignmentGuide(.listRowSeparatorLeading) { $0[.leading] }
                Spacer(minLength: 0)
            }
            .contentShape(Rectangle())
        }
        .accessibilityLabel(label)
        .accessibilityValue(time.formatted(date: .omitted, time: .shortened))
        .accessibilityHint(open ? "Closes the time picker" : "Opens the time picker")
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button("Delete", systemImage: "trash", role: .destructive, action: delete)
        }
        .accessibilityAction(named: "Delete", delete)
        if open {
            DatePicker(label, selection: $time, in: range, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .frame(maxWidth: .infinity)
        }
    }
}

/// A form row whose value sits under its name, with iOS's up-and-down chevrons, opening a menu of choices from the
/// row itself (Figma's Menu row, `1100:2943`; the menu `1100:162805`). The choices are a `Picker`, so the menu ticks
/// the chosen one (a choice with a second line is a `Toggle` instead, so the line shows).
private struct MenuValueRow<Choices: View>: View {
    let title: String
    let value: String
    @ViewBuilder let choices: () -> Choices

    var body: some View {
        Menu {
            choices()
        } label: {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(title).foregroundStyle(Color.primary)
                    Text(value).font(.subheadline).foregroundStyle(.secondary)
                }
                Spacer(minLength: 0)
                Image(systemName: "chevron.up.chevron.down")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.tertiary)
            }
            .contentShape(Rectangle())
        }
        .accessibilityValue(value)
    }
}

/// Under the name: its length note at the limit, or what the description is for while it's being typed.
private struct NameFooter: View {
    let typed: TypedName
    let describing: Bool

    var body: some View {
        if let note = TextLimit.note(typed.text, TextLimit.name) { Text(note).formNote() }
        else if describing { Text("What counts, or how to do it. Shown while you do it.").formNote() }
    }
}

// MARK: - Rows

/// The checklist's steps (Figma 1104:163327): one card, each step a row with the red ⊖ before it and a grabber after
/// it, an empty one showing "Step N", then Add Step, and the note under the card. No header: the page's title says it.
/// It keeps its own focus, so Add Step puts the cursor in the new row (the form's focus doesn't reach a pushed screen;
/// found on the iPhone, 28 Sep), and return on a step adds the next one.
struct ChecklistItemsSection: View {
    @Binding var items: [Step]
    @FocusState private var focused: UUID?

    var body: some View {
        Section {
            ForEach(Array($items.enumerated()), id: \.element.id) { index, $item in
                HStack(spacing: 16) {
                    RemoveButton(label: "Remove \(item.name.isEmpty ? "step \(index + 1)" : item.name)") {
                        withAnimation { items.removeAll { $0.id == item.id } }
                    }
                    TextField("Step \(index + 1)", text: $item.name)
                        .focused($focused, equals: item.id)
                        .limitText($item.name, to: TextLimit.checklistPart)
                        .submitLabel(.next)
                        .onSubmit(addItem)
                        .alignmentGuide(.listRowSeparatorLeading) { $0[.leading] }
                        .accessibilityIdentifier("step-field")
                }
            }
            .onMove { items.move(fromOffsets: $0, toOffset: $1) }
            PlusRow(title: "Add Step", action: addItem)
                .accessibilityIdentifier("add-step")
        } footer: {
            Text("Up to \(TextLimit.checklistPart) letters a step. Each step is ticked on its own.")
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

/// A list row chosen with a checkmark, like Settings and Clock's Repeat: the whole row is the button.
struct CheckRow: View {
    let title: String
    var detail: String? = nil
    let selected: Bool
    let action: () -> Void
    @Environment(\.isEnabled) private var isEnabled

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 0) {
                    // Figma's Checkmark row, Enabled=False: both lines in Tertiary Label.
                    Text(title).foregroundStyle(isEnabled ? Color.primary : Color(.tertiaryLabel))
                    if let detail {
                        Text(detail).font(.subheadline)
                            .foregroundStyle(isEnabled ? Color(.secondaryLabel) : Color(.tertiaryLabel))
                    }
                }
                Spacer(minLength: 8)
                Image(systemName: "checkmark").fontWeight(.semibold).foregroundStyle(Color.ink).opacity(selected ? 1 : 0)
            }
            // No minimum height of its own: the list's row already gives 15 above and below (52 for one line, Figma's
            // Checkmark row), and a 44-point frame inside it made every row 74.
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

/// A row that adds one more of something to the list it ends: a plain + in Secondary Label, 16 before the words
/// (Figma's Add a Time and Create Your Own Unit rows), as Clock adds an alarm time. Its separator starts at the words.
struct PlusRow: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: "plus").font(.title3).foregroundStyle(.secondary).frame(width: 24)
                Text(title).foregroundStyle(Color.primary)
                    .alignmentGuide(.listRowSeparatorLeading) { $0[.leading] }
            }
        }
    }
}

/// The green ⊕ row that adds to an editable list.
struct AddRow: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            // Figma's add row (New Routine): a filled ⊕ in Ink, as Contacts adds a phone, 16 before the words. The
            // chrome stays neutral (the Rulebook, 5 Nov 2026), so not iOS's green.
            HStack(spacing: 16) {
                Image(systemName: "plus.circle.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.onInk, Color.ink)
                    .font(.title3)
                Text(title).foregroundStyle(Color.primary)
            }
        }
        .accessibilityLabel(title)
    }
}

// MARK: - Pickers

/// 13 system colours as circles, like the Reminders list sheet.
/// The Colour sheet's page: its own bar (✕, Colour) over the swatches, and no background of its own, so the sheet's
/// Liquid Glass shows through as Figma's Medium sheet does. Its height is the swatches' own, measured, so it fits two
/// rows at any text size; at the largest sizes it scrolls.
struct ColourSheet: View {
    @Binding var selection: HabitColor
    @Environment(\.dismiss) private var dismiss
    @State private var height: CGFloat = 220

    var body: some View {
        NavigationStack {
            ScrollView {
                ColorGrid(selection: $selection)
                    .padding(.horizontal, 18)
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                    .onGeometryChange(for: CGFloat.self) { $0.size.height } action: { height = $0 + 64 }
            }
            .scrollBounceBehavior(.basedOnSize)
            .navigationTitle("Colour")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", systemImage: "xmark") { dismiss() }
                }
            }
        }
        .presentationDetents([.height(height)])
    }
}

/// Figma's Colour swatch (1074:161495): a 34 circle in a 44 touch area, seven to a row, 12 between rows. The chosen
/// one has the 3 pt System Gray 3 ring and a white checkmark on the colour, so it reads without the ring too.
/// A fixed palette, so not iOS's `ColorPicker`.
struct ColorGrid: View {
    @Binding var selection: HabitColor

    var body: some View {
        // A plain Grid, never a lazy one: 13 swatches, sized up front (S13).
        let colors = HabitColor.allCases
        Grid(horizontalSpacing: 0, verticalSpacing: 12) {
            ForEach(Array(stride(from: 0, to: colors.count, by: 7)), id: \.self) { start in
                GridRow {
                    ForEach(colors[start..<min(start + 7, colors.count)], id: \.self) { c in
                        swatch(c).frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }

    private func swatch(_ c: HabitColor) -> some View {
        Button { selection = c } label: {
            Circle().fill(c.color)
                .frame(width: 34, height: 34)
                .overlay {
                    if c == selection {
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                        Circle().stroke(Color(.systemGray3), lineWidth: 3).padding(-5)
                    }
                }
                .frame(width: 44, height: 44)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(c.name)
        .accessibilityAddTraits(c == selection ? .isSelected : [])
    }
}

/// Figma's Day toggle, Week (`1075:1966`): seven 40-point circles from the person's week start, never stretched, the
/// space left between them. A button that acts as a toggle, as Apple says to use outside a list: Tertiary System Fill,
/// chosen Ink with the letter in On Ink. At the accessibility sizes the letters become the days' names, one under
/// another, so they never shrink or clip.
struct WeekdayPicker: View {
    @Binding var selection: Set<Int>
    let firstWeekday: Int
    @Environment(\.dynamicTypeSize) private var dynamicType

    var body: some View {
        let symbols = Calendar.current.veryShortStandaloneWeekdaySymbols
        let full = Calendar.current.standaloneWeekdaySymbols
        let order = (0..<7).map { (firstWeekday - 1 + $0) % 7 + 1 }
        let big = dynamicType.isAccessibilitySize
        let layout = big ? AnyLayout(VStackLayout(alignment: .leading, spacing: 8)) : AnyLayout(HStackLayout(spacing: 0))
        layout {
            ForEach(Array(order.enumerated()), id: \.element) { index, day in
                let on = selection.contains(day)
                if index > 0 && !big { Spacer(minLength: 0) }
                Button {
                    if on { if selection.count > 1 { selection.remove(day) } } else { selection.insert(day) }
                } label: {
                    Text(big ? full[day - 1] : symbols[day - 1])
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(on ? Color.onInk : Color.primary)
                        .padding(.horizontal, big ? 16 : 0)
                        .frame(minWidth: 40, minHeight: 40)
                        .background(Capsule().fill(on ? Color.ink : Color(.tertiarySystemFill)))
                        .contentShape(Capsule())
                }
                .buttonStyle(.plain)
                .accessibilityLabel(full[day - 1])
                .accessibilityAddTraits(on ? .isSelected : [])
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

/// Figma's Day toggle, Date (`1075:1966`): 1–31 seven a row, as iOS's graphical date picker draws a month: the number
/// alone until chosen, then Body Medium in On Ink on a 40-point Ink circle; 8 between rows, the space left between
/// columns. A plain `Grid`, never a lazy grid in a list row (S13). Four a row at the accessibility sizes.
struct MonthDatePicker: View {
    @Binding var selection: Set<Int>
    @Environment(\.dynamicTypeSize) private var dynamicType

    var body: some View {
        let perRow = dynamicType.isAccessibilitySize ? 4 : 7
        Grid(horizontalSpacing: 0, verticalSpacing: 8) {
            ForEach(Array(stride(from: 1, through: 31, by: perRow)), id: \.self) { start in
                GridRow {
                    ForEach(start..<(start + perRow), id: \.self) { date in
                        if date <= 31 {
                            dateButton(date).frame(maxWidth: .infinity)
                        } else {
                            Color.clear.frame(maxWidth: .infinity, maxHeight: 1)
                        }
                    }
                }
            }
        }
    }

    private func dateButton(_ date: Int) -> some View {
        let on = selection.contains(date)
        return Button {
            if on { if selection.count > 1 { selection.remove(date) } } else { selection.insert(date) }
        } label: {
            Text("\(date)")
                .font(on ? .body.weight(.medium) : .body)
                .monospacedDigit()
                .foregroundStyle(on ? Color.onInk : Color.primary)
                .frame(minWidth: 40, minHeight: 40)
                .background(Circle().fill(on ? Color.ink : Color.clear))
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Day \(date)")
        .accessibilityAddTraits(on ? .isSelected : [])
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
    /// A limit can be time ("Social media: at most 30 min a day"): users show time limits for screens, TV and games are
    /// a real need (report "Time Limits — Should Cut Down Allow Time?", 4 Oct 2026). Not when editing a counted limit.
    var allowsTime = false
    @State private var creating = false
    @State private var custom = ""
    @State private var search = ""
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
            if mode == .limit {
                list.insert(("Cutting down", ["cigarettes", "drinks", "coffees", "snacks"]), at: 0)
                if allowsTime { list.insert(("Time", [HabitPlan.timeUnit]), at: 1) }
            }
            return list
        }
    }

    /// The person's own units: ones used before that aren't in the lists, and the one just made here.
    private var own: [String] {
        let known = Set(groups.flatMap(\.1))
        var list = used.reversed().filter { !known.contains($0) && !["minutes", "hours"].contains($0) }
        let chosen = unit.trimmingCharacters(in: .whitespaces)
        if !chosen.isEmpty, !known.contains(chosen), !list.contains(chosen) { list.append(chosen) }
        return list
    }

    private var query: String { search.trimmingCharacters(in: .whitespaces) }

    private func matches(_ value: String) -> Bool { value.localizedCaseInsensitiveContains(query) }

    /// Figma's Unit page (1102:3316): search, Your own (No unit, the person's units, Create Your Own Unit), then the
    /// usual units by kind. Its four variants are this one list's states: nothing typed, a unit being made (the field
    /// opens above Create Your Own Unit), a search (only the matching units, under their kinds) and a unit just made
    /// (it joins Your own, ticked). Choosing moves the tick and stays on the page, as Settings' choice lists do; Back
    /// returns to How Much. The search is iOS's own (`searchable`, always shown under the bar), as on the Icon page.
    var body: some View {
        List {
            if query.isEmpty {
                ownSection
                ForEach(groups, id: \.0) { group in
                    Section(group.0) { ForEach(group.1, id: \.self, content: row) }
                }
            } else {
                let mine = own.filter(matches)
                if !mine.isEmpty { Section("Your own") { ForEach(mine, id: \.self, content: row) } }
                ForEach(groups, id: \.0) { group in
                    let hits = group.1.filter(matches)
                    if !hits.isEmpty { Section(group.0) { ForEach(hits, id: \.self, content: row) } }
                }
            }
        }
        .overlay {
            if !query.isEmpty, !own.contains(where: matches), !groups.contains(where: { $0.1.contains(where: matches) }) {
                ContentUnavailableView.search(text: query)
            }
        }
        .listSectionSpacing(24)
        .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search units")
        .navigationTitle("Unit")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var ownSection: some View {
        Section {
            if allowsNone {
                choiceRow("No unit", chosen: unit.trimmingCharacters(in: .whitespaces).isEmpty) { unit = "" }
                    .accessibilityIdentifier("no-unit")
            }
            ForEach(own, id: \.self, content: row)
            if creating {
                HStack(spacing: 16) {
                    TextField("e.g. prayers", text: $custom)
                        .focused($typing)
                        .limitText($custom, to: TextLimit.unit)
                        .submitLabel(.done)
                        .onSubmit(useCustom)
                        .accessibilityIdentifier("custom-unit")
                        .alignmentGuide(.listRowSeparatorLeading) { $0[.leading] }
                    // Borderless, so only the word takes its tap and the field keeps the rest of the row.
                    Button("Done", action: useCustom)
                        .buttonStyle(.borderless)
                        .disabled(custom.trimmingCharacters(in: .whitespaces).isEmpty)
                        .tint(Color.ink)
                }
            }
            PlusRow(title: "Create Your Own Unit") {
                withAnimation { creating = true }
                typing = true
            }
            .accessibilityIdentifier("create-unit")
        } header: {
            Text("Your own")
        } footer: {
            Text(TextLimit.note(custom, TextLimit.unit) ?? "Anything you count, in a word or two: prayers, laps, sets.")
        }
    }

    private func row(_ value: String) -> some View {
        choiceRow(value, chosen: value == unit) { unit = value }
    }

    private func choiceRow(_ title: String, chosen: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title).foregroundStyle(Color.primary).lineLimit(1)
                Spacer(minLength: 16)
                Image(systemName: "checkmark").fontWeight(.semibold).foregroundStyle(Color.ink).opacity(chosen ? 1 : 0)
            }
        }
        .accessibilityAddTraits(chosen ? .isSelected : [])
    }

    /// The new unit joins Your own, ticked, and the field closes; the page stays (Figma's Own unit added).
    private func useCustom() {
        let value = TextLimit.clean(custom, TextLimit.unit)
        guard !value.isEmpty else { return }
        unit = value
        custom = ""
        typing = false
        withAnimation { creating = false }
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

/// A screen made only when it's shown. `NavigationLink { … }` builds its destination with the link, so every redraw of
/// the screen holding the link built every screen it could open (PERFORMANCE.md rule 8).
struct BuiltWhenShown<Content: View>: View {
    private let build: () -> Content
    init(_ build: @escaping () -> Content) { self.build = build }
    var body: some View { build() }
}

/// The chevron a list draws on a link, for a button that leads on but isn't a `NavigationLink` (Icon and Colour
/// open sheets). Footnote Semibold in Tertiary Label, as iOS draws its own.
struct RowChevron: View {
    var body: some View {
        Image(systemName: "chevron.forward")
            .font(.footnote.weight(.semibold))
            .foregroundStyle(Color(.tertiaryLabel))
            .accessibilityHidden(true)
    }
}
