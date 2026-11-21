import SwiftUI

/// How Often (Figma `1075:161386`, 21 Nov 2026): one inset-grouped list of choices, each a Checkmark row. Rhythms of
/// one kind share a card (every day and several times a day; every few days, weeks and months), the rest have one
/// each, 16 apart, with no headers: the choices' own words say what each is. A choice that isn't chosen says what kind
/// it is ("Several times a day"); once chosen it says exactly what it is ("Twice a day"), and its settings open inside
/// its card, under it, with no line between them. Choosing never changes another row and never asks to confirm.
///
/// Figma draws each option as a component with its controls stacked in one frame. Here each control is its own list
/// row, so the list keeps its own row heights, insets, Dynamic Type and VoiceOver order; the lines Figma leaves out
/// inside a chosen option are hidden per row (`inChoice`), and the lines it draws full width are moved out to the
/// card's edges (`fullWidthLine`).
struct HowOftenEditor: View {
    @Binding var draft: OftenDraft
    /// The amount as written ("2 chapters"), or nil for Just do it.
    let amountText: String?
    let checklist: Bool
    /// Cut down: only a day, a week or a month.
    let limit: Bool
    let start: Date
    let weekStart: Int
    /// An amount or time habit whose amount isn't typed yet: it still gets the amount choices.
    var amountExpected = false
    /// A repeating task: the same screen without counts (a task is ticked once each time it's due), plus
    /// "A while after it's done" (29 Sep).
    var task = false
    @Environment(\.dynamicTypeSize) private var dynamicType

    private var hasAmount: Bool { amountText != nil || amountExpected }
    private var often: HowOften { draft.often(hasAmount: hasAmount) }

    /// A choice's words: with an amount, "2 chapters a week"; without, "3 times a week".
    private func words(_ choice: HowOften) -> String {
        let phrase = choice.phrase(hasAmount: hasAmount, checklist: checklist, weekStart: weekStart)
        guard let amountText else {
            // No amount typed yet: the choice alone ("Every day", "A week", "On 3 days a week").
            if limit && choice != .everyDay { return "At most, " + phrase }
            return HabitCopy.capitalized(phrase)
        }
        if limit { return "At most \(amountText) " + (choice == .everyDay ? "a day" : phrase) }
        switch choice {
        case .everyDay: return "\(amountText) a day"
        case .days(_, 1): return "\(amountText), \(phrase)"
        default: return "\(amountText) \(phrase)"
        }
    }

    var body: some View {
        Form {
            if limit {
                Section {
                    choiceRow(.everyDay, words(.everyDay))
                    choiceRow(.total, words(.total(.week)), selected: draft.choice == .total && draft.totalPeriod == .week, id: "total-week") { draft.totalPeriod = .week }
                    choiceRow(.total, words(.total(.month)), selected: draft.choice == .total && draft.totalPeriod == .month, id: "total-month") { draft.totalPeriod = .month }
                }
            } else if hasAmount {
                amountChoices
            } else if task {
                Section { choiceRow(.everyDay, "Every day") }
            } else {
                countChoices
            }
            // A limit is a day, a week or a month (Design Rules): set days would read "at most 3 a day" anyway.
            if !limit {
                weekdayChoices
                intervalChoices
                dateChoices
            }
            if task { afterDoneChoices }
        }
        // Figma: 16 between cards and 16 above the first, as the habit form.
        .listSectionSpacing(16)
        .contentMargins(.top, 16, for: .scrollContent)
        .onAppear { draft.seed(start: start, weekStart: weekStart) }
        // Tapping a number selects it, so typing replaces it.
        .selectsNumbersOnFocus()
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle("How Often")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: Choices

    /// Just do it: every day, or several times a day; or a number of times a week, month or year.
    @ViewBuilder private var countChoices: some View {
        Section {
            choiceRow(.everyDay, "Every day")
            choiceRow(.timesADay, draft.choice == .timesADay ? words(.timesADay(max(2, draft.perDay))) : "Several times a day")
            if draft.choice == .timesADay {
                NumberStepper(title: "Times a day", value: $draft.perDay, range: 2...99)
                    .inChoice()
                    .accessibilityIdentifier("often-per-day")
            }
        }
        Section {
            choiceRow(.times, draft.choice == .times ? words(countChoice) : "Times a week, month or year")
            if draft.choice == .times { countControls(days: false) }
        }
    }

    /// An amount: that much a day, in total over a week, month or year, or on a number of days.
    @ViewBuilder private var amountChoices: some View {
        Section {
            choiceRow(.everyDay, words(.everyDay))
            ForEach([GoalPeriod.week, .month, .year]) { period in
                choiceRow(.total, words(.total(period)), selected: draft.choice == .total && draft.totalPeriod == period, id: "total-\(period.rawValue)") {
                    draft.totalPeriod = period
                }
            }
        }
        Section {
            choiceRow(.times, draft.choice == .times ? words(countChoice) : "Days a week, month or year")
            if draft.choice == .times { countControls(days: true) }
        }
    }

    /// Certain days of the week: Weekdays and Weekends (Small Bordered buttons), then the seven days.
    @ViewBuilder private var weekdayChoices: some View {
        Section {
            choiceRow(.weekdays, draft.choice == .weekdays ? words(.weekdays(draft.weekdays)) : "On certain days of the week")
            if draft.choice == .weekdays {
                VStack(alignment: .leading, spacing: 16) {
                    let quick = dynamicType.isAccessibilitySize
                        ? AnyLayout(VStackLayout(alignment: .leading, spacing: 8))
                        : AnyLayout(HStackLayout(spacing: 8))
                    quick {
                        Button("Weekdays") { draft.weekdays = [2, 3, 4, 5, 6] }
                        Button("Weekends") { draft.weekdays = [1, 7] }
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .controlSize(.small)
                    .font(.subheadline)
                    .tint(Color.ink)
                    WeekdayPicker(selection: Binding(get: { draft.weekdays }, set: { days in
                        if days.count == 7 {
                            draft.choice = .everyDay
                            UIAccessibility.post(notification: .announcement, argument: "Every day selected")
                        } else { draft.weekdays = days }
                    }), firstWeekday: weekStart)
                }
                .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 24, trailing: 16))
                .inChoice()
            }
        }
    }

    /// Every few days, weeks or months, counted from the start date. Weeks can add set days.
    @ViewBuilder private var intervalChoices: some View {
        Section {
            choiceRow(.everyDays, draft.choice == .everyDays ? HabitCopy.capitalized(HabitCopy.everyN(draft.daysInterval, "day")) : "Every few days")
            if draft.choice == .everyDays {
                NumberStepper(title: "Every", value: $draft.daysInterval, range: 2...365) { _ in "days" }
                    .inChoice()
                    .accessibilityIdentifier("often-every-count")
            }
            choiceRow(.everyWeeks, draft.choice == .everyWeeks ? HabitCopy.capitalized(words(often)) : "Every few weeks")
            if draft.choice == .everyWeeks {
                NumberStepper(title: "Every", value: $draft.weeksInterval, range: 1...52) { $0 == 1 ? "week" : "weeks" }
                    .inChoice()
                    .accessibilityIdentifier("often-weeks-count")
                // Days are an add-on: off, it's every few weeks from the start date.
                Toggle("On set days", isOn: Binding(get: { !draft.weeksDays.isEmpty }, set: { on in
                    withAnimation { draft.weeksDays = on ? [Calendar.current.component(.weekday, from: start)] : [] }
                }))
                .tint(.green)
                .inChoice()
                .accessibilityIdentifier("often-weeks-days")
                if !draft.weeksDays.isEmpty {
                    WeekdayPicker(selection: $draft.weeksDays, firstWeekday: weekStart)
                        .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 16, trailing: 16))
                        // The line under it starts at the row's edge, not at the first letter inside a circle.
                        .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                        .inChoice()
                }
            }
            choiceRow(.everyMonths, draft.choice == .everyMonths ? HabitCopy.capitalized(HabitCopy.everyN(draft.monthsInterval, "month")) : "Every few months")
            if draft.choice == .everyMonths {
                NumberStepper(title: "Every", value: $draft.monthsInterval, range: 1...24) { $0 == 1 ? "month" : "months" }
                    .inChoice()
                    .accessibilityIdentifier("often-months-count")
            }
        }
    }

    /// On a date each month (dates, the last day, or a weekday like the first Saturday) or each year.
    @ViewBuilder private var dateChoices: some View {
        Section {
            choiceRow(.date, draft.choice == .date ? words(.calendar(draft.dateRule)) : "On a date each month or year")
            if draft.choice == .date { dateControls }
        } footer: {
            if let note = setDaysNote { Text(note).formNote() }
        }
    }

    /// Tasks: again a while after it's done, counted from the day it's ticked. People ask for this in
    /// to-do reviews ("repeat from completion date": about 59 reviews across the corpora, many from Reminders).
    @ViewBuilder private var afterDoneChoices: some View {
        Section {
            choiceRow(.afterDone, draft.choice == .afterDone ? HabitCopy.capitalized(words(often)) : "A while after it’s done")
            if draft.choice == .afterDone {
                Picker("Unit", selection: $draft.afterUnit) {
                    // Figma: Days | Weeks | Months. Years only for a task saved with it, so its choice still shows.
                    ForEach([ScheduleUnit.day, .week, .month] + (draft.afterUnit == .year ? [.year] : [])) {
                        Text($0.plural.capitalized).tag($0)
                    }
                }
                .pickerStyle(.segmented)
                .segmentRow()
                .inChoice()
                .accessibilityIdentifier("often-after-unit")
                NumberStepper(title: "Again after", value: $draft.afterCount, range: 1...365)
                    .inChoice()
                    .accessibilityIdentifier("often-after-count")
            }
        }
    }

    private var countChoice: HowOften {
        hasAmount ? .days(draft.countPeriod, draft.count) : .times(draft.countPeriod, draft.count)
    }

    /// Week | Month | Year, then how many.
    @ViewBuilder private func countControls(days: Bool) -> some View {
        Picker("Each", selection: Binding(get: { draft.countPeriod }, set: { period in
            draft.countPeriod = period
            draft.count = min(draft.count, draft.countMaximum(days: days))
        })) {
            ForEach([GoalPeriod.week, .month, .year]) { Text($0.rawValue.capitalized).tag($0) }
        }
        .pickerStyle(.segmented)
        .segmentRow()
        .inChoice()
        .accessibilityIdentifier("often-count-period")
        NumberStepper(title: days ? "Days" : "Times", value: $draft.count, range: 1...draft.countMaximum(days: days))
            .inChoice()
            .accessibilityIdentifier("often-count")
    }

    /// Month | Year; a month's Repeat on (Dates, The last day, A weekday) and its dates grid or weekday wheel; a year's
    /// month and date wheel. Two values that belong together are one Wheel picker (the Rulebook, 6 Nov 2026).
    @ViewBuilder private var dateControls: some View {
        Picker("Each", selection: Binding(get: { draft.dateRule.unit }, set: { draft.dateRule.unit = $0 })) {
            Text("Month").tag(ScheduleUnit.month)
            Text("Year").tag(ScheduleUnit.year)
        }
        .pickerStyle(.segmented)
        .segmentRow()
        .listRowSeparator(.hidden, edges: .top)
        .modifier(FullWidthLine(on: draft.dateRule.unit == .year))
        .accessibilityIdentifier("often-date-unit")
        if draft.dateRule.unit == .month {
            Picker("Repeat on", selection: $draft.dateRule.pattern) {
                Text("Dates").tag(CalendarSchedule.MonthPattern.dates)
                Text("The last day").tag(CalendarSchedule.MonthPattern.last)
                Text("A weekday").tag(CalendarSchedule.MonthPattern.weekday)
            }
            .pickerStyle(.menu)
            .tint(Color.ink)
            .modifier(FullWidthLine(on: draft.dateRule.pattern != .last))
            .accessibilityIdentifier("often-date-pattern")
            switch draft.dateRule.pattern {
            case .dates:
                MonthDatePicker(selection: $draft.dateRule.dates)
                    .listRowInsets(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8))
                if draft.dateRule.dates.contains(where: { $0 > 28 }) {
                    Picker("Shorter months", selection: $draft.dateRule.useLastDay) {
                        Text("Use the last day").tag(true)
                        Text("Skip that month").tag(false)
                    }
                    .pickerStyle(.menu)
                    .tint(Color.ink)
                }
            case .last:
                EmptyView()
            case .weekday:
                WheelPicker(first: [1, 2, 3, 4, 5, -1].map { ($0, HabitCopy.ordinalWord($0)) },
                            second: (1...7).map { ($0, HabitCopy.fullDays[$0 - 1]) },
                            firstSelection: $draft.dateRule.ordinal, secondSelection: $draft.dateRule.weekday,
                            labels: ("Which one", "Weekday"))
                    .frame(maxWidth: .infinity, minHeight: 216, maxHeight: 216)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                    .accessibilityIdentifier("often-weekday-wheel")
            }
        } else {
            WheelPicker(first: (1...12).map { ($0, HabitCopy.monthNames[$0 - 1]) },
                        second: (1...daysIn(month: draft.dateRule.month)).map { ($0, "\($0)") },
                        firstSelection: Binding(get: { draft.dateRule.month }, set: { month in
                            draft.dateRule.month = month
                            draft.dateRule.day = min(draft.dateRule.day, daysIn(month: month))
                        }),
                        secondSelection: $draft.dateRule.day,
                        labels: ("Month", "Date"))
                .frame(maxWidth: .infinity, minHeight: 216, maxHeight: 216)
                .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                .accessibilityIdentifier("often-year-wheel")
            if draft.dateRule.month == 2 && draft.dateRule.day == 29 {
                Picker("Years without 29 February", selection: $draft.dateRule.useLastDay) {
                    Text("Use 28 February").tag(true)
                    Text("Skip that year").tag(false)
                }
                .pickerStyle(.menu)
                .tint(Color.ink)
            }
        }
    }

    // MARK: Rows and notes

    /// A choice with a checkmark; tapping it picks it and runs `extra` (e.g. which period). Chosen, the line under it
    /// goes when settings open under it, so they read as part of it.
    private func choiceRow(_ choice: OftenDraft.Choice, _ title: String, selected: Bool? = nil, id: String? = nil,
                           extra: (() -> Void)? = nil) -> some View {
        let chosen = selected ?? (draft.choice == choice)
        return CheckRow(title: title, selected: chosen) {
            withAnimation {
                draft.choice = choice
                extra?()
            }
        }
        .listRowSeparator(chosen && choice != .everyDay && choice != .total ? .hidden : .automatic, edges: .bottom)
        .accessibilityIdentifier("often-" + (id ?? "\(choice)"))
    }

    private var setDaysNote: String? {
        guard case .calendar(let rule) = often else { return nil }
        if rule.unit == .month && rule.pattern == .dates && rule.dates.contains(where: { $0 > 28 }) {
            return rule.useLastDay ? "Months without that date use their last day." : "Months without that date are skipped."
        }
        if rule.unit == .month && rule.pattern == .weekday && rule.ordinal == 5 {
            return "Months without a fifth \(HabitCopy.fullDays[(rule.weekday - 1 + 7) % 7]) are skipped."
        }
        if rule.unit == .year && rule.month == 2 && rule.day == 29 {
            return rule.useLastDay ? "Years without 29 February use 28 February." : "Years without 29 February are skipped."
        }
        return nil
    }

    private func daysIn(month: Int) -> Int {
        let cal = Calendar.current
        let date = cal.date(from: DateComponents(year: 2024, month: month, day: 1))!
        return cal.range(of: .day, in: .month, for: date)!.count
    }
}

private extension View {
    /// A chosen option's own setting: no line above it, so it reads as part of the choice (Figma draws none inside an
    /// option). The line under the last one stays, before the next choice in the card.
    func inChoice() -> some View {
        listRowSeparator(.hidden, edges: .top)
    }

    /// A segmented control in a choice: Figma's 12 above and 16 below, full width inside the card's 16.
    func segmentRow() -> some View {
        listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 12, trailing: 16))
    }
}

/// Figma's full-width line, above a wheel or the dates grid: the list's line moved out to the card's edges.
private struct FullWidthLine: ViewModifier {
    let on: Bool
    func body(content: Content) -> some View {
        if on {
            content
                .alignmentGuide(.listRowSeparatorLeading) { _ in -16 }
                .alignmentGuide(.listRowSeparatorTrailing) { d in d.width + 16 }
        } else {
            content
        }
    }
}

/// "How much" (an amount with an optional unit), "How long" (hours and minutes, for Time it) or "Limit"
/// (Cut down). The type chosen before the form decides which.
///
/// How much is Figma's How much page (1102:2782): one card with the amount as the biggest thing on the screen (the
/// Amount field, 56 Bold, centred, the keypad up from the start) and the Unit row under it, then "When you log it",
/// which says what + does on Today. In Figma the page is one component with Typing and Keyboard down variants; here
/// they're the one screen with its keyboard up or down, never two views. The Unit row pushes the Unit page, so it
/// keeps the push chevron instead of Figma's pop-up chevron: a pop-up opens a menu where it is, and the unit list has
/// search and a field of its own, which a menu can't hold.
struct HowMuchEditor: View {
    enum Mode { case amount, time, limit }
    enum Field: Hashable { case amount, step }

    let mode: Mode
    @Binding var amount: String
    @Binding var unit: String
    @Binding var hours: String
    @Binding var minutes: String
    let usedUnits: [String]
    /// The period the amount is for, so a time can't be longer than it.
    let period: GoalPeriod
    /// The whole habit as one sentence, the same one the New Habit form shows.
    var sentence: String? = nil
    /// What the name suggests, as the field's hint ("e.g. 10000 steps"); never a value.
    var hint: String? = nil
    /// A limit being edited: true if it's in minutes, false if it counts something; nil when it's new. Its unit stays on
    /// that side, so past minutes never turn into counts or back (Rulebook D6; report "Time Limits", 4 Oct 2026).
    var limitInMinutes: Bool? = nil
    /// How much only: what + does on Today. Off adds the step; on asks how much each time (29 Sep).
    var asksEachTime: Binding<Bool>? = nil
    /// How much only: what each tap adds; nil keeps the suggested step.
    var step: Binding<Double?>? = nil
    /// The suggested step, shown in the step box until one is typed.
    var stepPlaceholder = "1"
    @FocusState private var focus: Field?

    private var limit: Bool { mode == .limit }

    /// The amount said back as it's typed: "2,500 ml", "1 h 30 min", "At most 3 coffees".
    private var readBack: String? {
        let text: String
        if mode == .time {
            guard let value = GoalDraft(hours: hours, minutes: minutes).duration(max: period.maxMinutes) else { return nil }
            text = HabitCopy.minutes(value)
        } else {
            guard let value = GoalNumber.parse(amount), value > 0 else { return nil }
            text = HabitCopy.amount(value, TextLimit.clean(unit, TextLimit.unit))
        }
        return limit ? "At most \(text)" : text
    }

    var body: some View {
        Group {
            if mode == .amount {
                amountForm
            } else {
                otherForm
            }
        }
        .navigationTitle(limit ? "Limit" : mode == .time ? "How Long" : "How Much")
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
        .selectsNumbersOnFocus()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                if focus != nil { Spacer(); Button("Done") { focus = nil }.fontWeight(.semibold) }
            }
        }
        // The amount starts filled with a suggestion, so the keyboard comes up with it selected.
        .task { if mode != .time { focus = .amount } }
    }

    // MARK: How much (Figma 1102:2782)

    private var amountForm: some View {
        Form {
            Section {
                AmountTypingField(text: $amount, placeholder: "0", label: "Amount", focus: $focus)
                    .listRowInsets(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                    .listRowSeparator(.hidden)
                unitLink
            } footer: {
                Text(entryError ?? "Up to 2 decimal places. The unit is optional.")
            }
            if let asksEachTime {
                Section {
                    CheckRow(title: "One tap adds a set amount", selected: !asksEachTime.wrappedValue) {
                        withAnimation { asksEachTime.wrappedValue = false }
                    }
                    // The step belongs to the choice above it, so no line between them (Figma's option block).
                    .listRowSeparator(asksEachTime.wrappedValue ? .automatic : .hidden, edges: .bottom)
                    .accessibilityIdentifier("tap-adds-step")
                    if !asksEachTime.wrappedValue, let step {
                        StepBoxRow(value: step, placeholder: stepPlaceholder, focus: $focus)
                    }
                    CheckRow(title: "Type the amount each time", selected: asksEachTime.wrappedValue) {
                        if focus == .step { focus = nil }
                        withAnimation { asksEachTime.wrappedValue = true }
                    }
                    .accessibilityIdentifier("tap-asks")
                } header: {
                    Text("When you log it")
                }
            }
        }
        .listSectionSpacing(24)
        .contentMargins(.top, 16, for: .scrollContent)
    }

    // MARK: How long and Limit (their own screens come next in the Create New pass)

    private var otherForm: some View {
        Form {
            // From the New Habit form the sentence is pinned at the top instead (`stickySentence` below).
            if sentence == nil {
                Section {
                    VStack(spacing: 4) {
                        Text(readBack ?? "—")
                            .font(.system(.largeTitle, design: .rounded).weight(.bold).monospacedDigit())
                            .foregroundStyle(readBack == nil ? .tertiary : .primary)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                        if readBack == nil {
                            Text(mode == .time ? "Set the time below." : "Type the amount below.").font(.title3).foregroundStyle(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .accessibilityElement(children: .combine)
                    .accessibilityIdentifier("much-summary")
                }
                .listRowBackground(Color.clear)
            }
            if mode == .time {
                DurationInput(hours: $hours, minutes: $minutes, period: period, header: "Time",
                              note: "Time it with ▶ on Today, or type the time.")
            } else {
                Section {
                    LabeledContent("No more than") {
                        TextField(hint ?? "e.g. 2", text: $amount)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .font(.body.monospacedDigit().weight(.semibold))
                            .focused($focus, equals: .amount)
                            .frame(minWidth: 44, maxWidth: 160)
                            .accessibilityLabel("Limit")
                            .accessibilityIdentifier("much-number")
                    }
                    unitLink
                } header: {
                    Text("Limit")
                } footer: {
                    Text(entryError ?? (unit == HabitPlan.timeUnit
                        ? "In minutes: 90 is 1 h 30 min. Time it with ▶ on Today, or type the minutes." + (limitInMinutes == true ? " A limit in minutes stays in minutes, so its past days keep their meaning." : "")
                        : "The unit is optional. Up to 2 decimal places.")).formNote()
                }
            }
        }
        .listSectionSpacing(.compact)
        .contentMargins(.top, 4, for: .scrollContent)
        .stickySentence(sentence, id: "much-summary")
    }

    @ViewBuilder private var unitLink: some View {
        if limit && limitInMinutes == true {
            LabeledContent("Unit", value: HabitPlan.timeUnit)
                .accessibilityIdentifier("much-unit")
        } else {
            NavigationLink {
                UnitPicker(unit: $unit, used: usedUnits, mode: limit ? .limit : .amount, allowsNone: true,
                           allowsTime: limit && limitInMinutes == nil)
            } label: {
                LabeledContent("Unit") {
                    Text(unit.isEmpty ? "No unit" : unit)
                }
            }
            .accessibilityIdentifier("much-unit")
        }
    }

    private var entryError: String? {
        let text = amount.trimmingCharacters(in: .whitespaces)
        guard !text.isEmpty else { return nil }
        guard let n = GoalNumber.parse(text), n > 0 else { return "Enter a number above 0, with up to 2 decimal places." }
        return nil
    }
}

/// Figma's Amount field (4292:2568) on a page that sets a number: 56 Bold, centred, the field as wide as what's typed so
/// the number and its cursor stay centred, and a tap anywhere on its row gives it the keyboard. The Log screen's
/// `AmountNumberField` is the same face on a record draft; this one types into a plain string binding.
struct AmountTypingField: View {
    @Binding var text: String
    let placeholder: String
    let label: String
    var focus: FocusState<HowMuchEditor.Field?>.Binding

    var body: some View {
        ZStack {
            Text(text.isEmpty ? placeholder : text).hidden().padding(.horizontal, 4)
            TextField(placeholder, text: $text)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.center)
                .focused(focus, equals: .amount)
                .accessibilityLabel(label)
                .accessibilityIdentifier("much-number")
        }
        .font(CustomText.amount(56))
        .lineLimit(1)
        .minimumScaleFactor(0.5)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture { focus.wrappedValue = .amount }
    }
}

/// "Each Tap Adds" with its number in a small grey box (Figma's Step, 72 × 40, Tertiary System Fill, the number at its
/// trailing edge), as Calendar and Clock box a value that's typed in place. The value follows the text key by key.
private struct StepBoxRow: View {
    @Binding var value: Double?
    let placeholder: String
    var focus: FocusState<HowMuchEditor.Field?>.Binding
    @State private var text = ""

    var body: some View {
        HStack(spacing: 16) {
            Text("Each Tap Adds")
            Spacer(minLength: 0)
            // The suggested step is the value each tap adds until another is typed, so it reads as a value (Label),
            // not as a hint.
            TextField("", text: $text, prompt: Text(placeholder).foregroundStyle(Color.primary))
                .onAppear { text = value.map(GoalNumber.text) ?? "" }
                .onChange(of: text) { value = GoalNumber.parse(text).flatMap { $0 > 0 ? $0 : nil } }
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .focused(focus, equals: .step)
                .padding(.trailing, 12)
                .frame(width: 72, height: 40)
                .background(Color(.tertiarySystemFill), in: .rect(cornerRadius: 8))
                .accessibilityLabel("Each Tap Adds")
                .accessibilityIdentifier("tap-step")
        }
        .contentShape(Rectangle())
        .onTapGesture { focus.wrappedValue = .step }
    }
}

/// A number on the How often screen: − / + for small nudges, and the number itself can be typed, so "100 times
/// a year" or "every 30 days" isn't 97 or 28 taps (found by counting taps, 29 Sep). Out-of-range typing is held
/// to the range as it's typed.
struct NumberStepper: View {
    let title: String
    @Binding var value: Int
    let range: ClosedRange<Int>
    var unit: (Int) -> String = { _ in "" }
    @FocusState private var typing: Bool

    var body: some View {
        Stepper(value: $value, in: range) {
            HStack(spacing: 6) {
                Text(title)
                Spacer(minLength: 8)
                // Not fixedSize: a field sized to its placeholder clips what's typed (Design Rules).
                TextField("", text: Binding(get: { "\(value)" }, set: { text in
                    if let n = Int(text.filter(\.isNumber)) { value = min(max(range.lowerBound, n), range.upperBound) }
                }))
                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
                .font(.body.monospacedDigit().weight(.semibold))
                .frame(minWidth: 28, maxWidth: 64)
                .focused($typing)
                .accessibilityLabel(title)
                let words = unit(value)
                if !words.isEmpty { Text(words).foregroundStyle(.secondary) }
            }
        }
        .toolbar {
            // The number pad has no return key.
            ToolbarItemGroup(placement: .keyboard) {
                if typing { Spacer(); Button("Done") { typing = false }.fontWeight(.semibold) }
            }
        }
    }
}
