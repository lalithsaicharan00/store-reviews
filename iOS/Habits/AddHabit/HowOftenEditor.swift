import SwiftUI

/// "How often": one list of sentence endings, each with the person's own amount in it ("2 chapters a week",
/// "5 km on 3 days a week", "every Monday and Wednesday"), so what each choice means is read, not looked up
/// (Round 3 design §2.5). Choosing never changes another row and never asks to confirm.
struct HowOftenEditor: View {
    @Binding var draft: OftenDraft
    /// The amount as written ("2 chapters"), or nil for Just do it.
    let amountText: String?
    let checklist: Bool
    /// Cut down: only a day, a week or a month.
    let limit: Bool
    let start: Date
    let weekStart: Int
    /// The whole habit as one sentence ("Read twice a day, morning and afternoon"), the same one the New Habit
    /// form shows, so the result of each choice is read here (the user's request, 29 Sep).
    var sentence: String? = nil
    /// An amount or time habit whose amount isn't typed yet: it still gets the amount choices.
    var amountExpected = false
    /// A repeating task: the same screen without counts (a task is ticked once each time it's due), plus
    /// "After it's done" (29 Sep).
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
                Section { choiceRow(.everyDay, "Every day") } header: { Text("Daily") }
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
        // Only the sentence, pinned while the choices scroll under it (the user, 29 Sep: no notes here).
        .stickySentence(sentence ?? words(often), id: "often-summary")
        .onAppear { draft.seed(start: start, weekStart: weekStart) }
        // Tapping a number selects it, so typing replaces it.
        .selectsNumbersOnFocus()
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle("How Often")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: Choices
    //
    // Each section is one kind of rhythm. A choice's own settings sit indented right under it and show only
    // while it's chosen, so they read as part of it (the user, 29 Sep). A choice that isn't chosen says what
    // kind it is ("Several times a day"); once chosen it says exactly what it is ("Twice a day").

    /// Just do it: every day, or several times a day.
    @ViewBuilder private var countChoices: some View {
        Section {
            choiceRow(.everyDay, "Every day")
            choiceRow(.timesADay, draft.choice == .timesADay ? words(.timesADay(max(2, draft.perDay))) : "Several times a day")
            if draft.choice == .timesADay {
                NumberStepper(title: "Times a day", value: $draft.perDay, range: 2...99)
                .nested()
                .accessibilityIdentifier("often-per-day")
            }
        } header: {
            Text("Daily")
        }
        Section {
            choiceRow(.times, draft.choice == .times ? words(countChoice) : "Times a week, month or year")
            if draft.choice == .times { countControls(days: false) }
        } header: {
            Text("A number of times")
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
        } header: {
            Text("In total")
        }
        Section {
            choiceRow(.times, draft.choice == .times ? words(countChoice) : "Days a week, month or year")
            if draft.choice == .times { countControls(days: true) }
        } header: {
            Text("A number of days")
        }
    }

    /// Certain days of the week.
    @ViewBuilder private var weekdayChoices: some View {
        Section {
            choiceRow(.weekdays, draft.choice == .weekdays ? words(.weekdays(draft.weekdays)) : "On certain days of the week")
            if draft.choice == .weekdays {
                let quick = dynamicType.isAccessibilitySize
                    ? AnyLayout(VStackLayout(alignment: .leading, spacing: 12))
                    : AnyLayout(HStackLayout(spacing: 20))
                quick {
                    Button("Weekdays") { draft.weekdays = [2, 3, 4, 5, 6] }
                    Button("Weekends") { draft.weekdays = [1, 7] }
                }
                .buttonStyle(.borderless)
                WeekdayPicker(selection: Binding(get: { draft.weekdays }, set: { days in
                    if days.count == 7 {
                        draft.choice = .everyDay
                        UIAccessibility.post(notification: .announcement, argument: "Every day selected")
                    } else { draft.weekdays = days }
                }), firstWeekday: weekStart)
            }
        } header: {
            Text("Days of the week")
        }
    }

    /// Every few days, weeks or months, counted from the start date. Weeks can add set days.
    @ViewBuilder private var intervalChoices: some View {
        Section {
            choiceRow(.everyDays, draft.choice == .everyDays ? HabitCopy.capitalized(HabitCopy.everyN(draft.daysInterval, "day")) : "Every few days")
            if draft.choice == .everyDays {
                NumberStepper(title: "Every", value: $draft.daysInterval, range: 2...365) { _ in "days" }
                .nested()
                .accessibilityIdentifier("often-every-count")
                nextRow
            }
            choiceRow(.everyWeeks, draft.choice == .everyWeeks ? HabitCopy.capitalized(words(often)) : "Every few weeks")
            if draft.choice == .everyWeeks {
                NumberStepper(title: "Every", value: $draft.weeksInterval, range: 1...52) { $0 == 1 ? "week" : "weeks" }
                .nested()
                .accessibilityIdentifier("often-weeks-count")
                // Days are an add-on: off, it's every few weeks from the start date.
                Toggle("On set days", isOn: Binding(get: { !draft.weeksDays.isEmpty }, set: { on in
                    withAnimation { draft.weeksDays = on ? [Calendar.current.component(.weekday, from: start)] : [] }
                }))
                .tint(.green)
                .nested()
                .accessibilityIdentifier("often-weeks-days")
                if !draft.weeksDays.isEmpty {
                    WeekdayPicker(selection: $draft.weeksDays, firstWeekday: weekStart).nested()
                }
                nextRow
            }
            choiceRow(.everyMonths, draft.choice == .everyMonths ? HabitCopy.capitalized(HabitCopy.everyN(draft.monthsInterval, "month")) : "Every few months")
            if draft.choice == .everyMonths {
                NumberStepper(title: "Every", value: $draft.monthsInterval, range: 1...24) { $0 == 1 ? "month" : "months" }
                .nested()
                .accessibilityIdentifier("often-months-count")
                nextRow
            }
        } header: {
            Text("Every few days, weeks or months")
        }
    }

    /// On a date each month (dates, the last day, or a weekday like the first Saturday) or each year.
    @ViewBuilder private var dateChoices: some View {
        Section {
            choiceRow(.date, draft.choice == .date ? words(.calendar(draft.dateRule)) : "On a date each month or year")
            if draft.choice == .date {
                dateControls
                nextRowFlat
            }
        } header: {
            Text("On a date")
        } footer: {
            if let note = setDaysNote { Text(note).formNote() }
        }
    }

    /// Tasks: again a while after it's done, counted from the day it's ticked. People ask for this in
    /// to-do reviews ("repeat from completion date": about 59 reviews across the corpora, many from Reminders).
    @ViewBuilder private var afterDoneChoices: some View {
        Section {
            choiceRow(.afterDone, draft.choice == .afterDone ? HabitCopy.capitalized(words(often)) : "A while after it's done")
            if draft.choice == .afterDone {
                Picker("Unit", selection: $draft.afterUnit) {
                    ForEach(ScheduleUnit.allCases) { Text($0.plural.capitalized).tag($0) }
                }
                .pickerStyle(.segmented)
                .accessibilityIdentifier("often-after-unit")
                NumberStepper(title: "Again after", value: $draft.afterCount, range: 1...365) { $0 == 1 ? draft.afterUnit.rawValue : draft.afterUnit.plural }
                .accessibilityIdentifier("often-after-count")
            }
        } header: {
            Text("After it's done")
        } footer: {
            if draft.choice == .afterDone { Text("Counted from the day you tick it.").formNote() }
        }
    }

    /// The next day it's on, from the start date, for the set-day rhythms.
    @ViewBuilder private var nextRow: some View {
        if let next {
            LabeledContent("Next", value: next).nested()
        }
    }

    @ViewBuilder private var nextRowFlat: some View {
        if let next { LabeledContent("Next", value: next) }
    }

    private var countChoice: HowOften {
        hasAmount ? .days(draft.countPeriod, draft.count) : .times(draft.countPeriod, draft.count)
    }

    /// A one-choice section: its settings sit flush under it, not indented (the user, 29 Sep).
    @ViewBuilder private func countControls(days: Bool) -> some View {
        Picker("Each", selection: Binding(get: { draft.countPeriod }, set: { period in
            draft.countPeriod = period
            draft.count = min(draft.count, draft.countMaximum(days: days))
        })) {
            ForEach([GoalPeriod.week, .month, .year]) { Text($0.rawValue.capitalized).tag($0) }
        }
        .pickerStyle(.segmented)
        .accessibilityIdentifier("often-count-period")
        NumberStepper(title: days ? "Days" : "Times", value: $draft.count, range: 1...draft.countMaximum(days: days))
        .accessibilityIdentifier("often-count")
    }

    /// "The [first ▾] [Saturday ▾]"; the row adds "of the month" after it, or under it on a narrow phone.
    @ViewBuilder private var weekdayOfMonthPhrase: some View {
        Text("The")
        Picker("Which one", selection: $draft.dateRule.ordinal) {
            ForEach([1, 2, 3, 4, 5, -1], id: \.self) { Text(HabitCopy.ordinalWord($0)).tag($0) }
        }
        .pickerStyle(.menu)
        .labelsHidden()
        .fixedSize()
        .accessibilityIdentifier("often-weekday-ordinal")
        Picker("Weekday", selection: $draft.dateRule.weekday) {
            ForEach(1...7, id: \.self) { Text(HabitCopy.fullDays[$0 - 1]).tag($0) }
        }
        .pickerStyle(.menu)
        .labelsHidden()
        .fixedSize()
        .accessibilityIdentifier("often-weekday-day")
    }

    @ViewBuilder private var dateControls: some View {
        Picker("Each", selection: Binding(get: { draft.dateRule.unit }, set: { draft.dateRule.unit = $0 })) {
            Text("Month").tag(ScheduleUnit.month)
            Text("Year").tag(ScheduleUnit.year)
        }
        .pickerStyle(.segmented)
        .accessibilityIdentifier("often-date-unit")
        if draft.dateRule.unit == .month {
            Picker("On", selection: $draft.dateRule.pattern) {
                Text("Dates").tag(CalendarSchedule.MonthPattern.dates)
                Text("The last day").tag(CalendarSchedule.MonthPattern.last)
                Text("A weekday").tag(CalendarSchedule.MonthPattern.weekday)
            }
            switch draft.dateRule.pattern {
            case .dates:
                MonthDatePicker(selection: $draft.dateRule.dates)
                if draft.dateRule.dates.contains(where: { $0 > 28 }) {
                    Picker("Shorter months", selection: $draft.dateRule.useLastDay) {
                        Text("Use the last day").tag(true)
                        Text("Skip that month").tag(false)
                    }
                }
            case .last:
                EmptyView()
            case .weekday:
                // One row that reads as the phrase: "The [first] [Saturday] of the month". The first menu is which
                // one of that weekday in the month (a weekday comes 4 or 5 times, so first to fifth, or the last);
                // the second is the weekday itself, all seven. Two rows, "Which" and "Day", read as a mistake (29 Sep).
                // Even gaps between every part; on a narrow phone only "of the month" moves to the next line.
                ViewThatFits(in: .horizontal) {
                    HStack(spacing: 8) {
                        weekdayOfMonthPhrase
                        Text("of the month")
                    }
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 8) { weekdayOfMonthPhrase }
                        Text("of the month")
                    }
                }
                .accessibilityElement(children: .contain)
            }
            NumberStepper(title: "Every", value: $draft.dateRule.interval, range: 1...12) { $0 == 1 ? "month" : "months" }
            .accessibilityIdentifier("often-month-interval")
        } else {
            Picker("Month", selection: Binding(get: { draft.dateRule.month }, set: { month in
                draft.dateRule.month = month
                draft.dateRule.day = min(draft.dateRule.day, daysIn(month: month))
            })) {
                ForEach(1...12, id: \.self) { Text(HabitCopy.monthNames[$0 - 1]).tag($0) }
            }
            Picker("Date", selection: $draft.dateRule.day) {
                ForEach(1...daysIn(month: draft.dateRule.month), id: \.self) { Text(HabitCopy.ordinal($0)).tag($0) }
            }
            if draft.dateRule.month == 2 && draft.dateRule.day == 29 {
                Picker("Years without 29 February", selection: $draft.dateRule.useLastDay) {
                    Text("Use 28 February").tag(true)
                    Text("Skip that year").tag(false)
                }
            }
        }
    }

    // MARK: Rows and notes

    /// A choice with a checkmark; tapping it picks it and runs `extra` (e.g. which period).
    private func choiceRow(_ choice: OftenDraft.Choice, _ title: String, selected: Bool? = nil, id: String? = nil,
                           extra: (() -> Void)? = nil) -> some View {
        CheckRow(title: title, selected: selected ?? (draft.choice == choice)) {
            withAnimation {
                draft.choice = choice
                extra?()
            }
        }
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

    private var next: String? {
        let format = Date.FormatStyle.dateTime.weekday(.abbreviated).day().month(.abbreviated)
        switch often {
        case .calendar(let rule):
            return rule.next(from: LocalDay(.now), start: LocalDay(start), calendar: .current)?.date().formatted(format)
        case .everyWeeks(let n):
            // Every few weeks from the start date: the start itself, or the next one after today.
            let cal = Calendar.current
            var day = cal.startOfDay(for: start)
            let today = cal.startOfDay(for: .now)
            while day < today { day = cal.date(byAdding: .day, value: 7 * max(n, 1), to: day)! }
            return day.formatted(format)
        default:
            return nil
        }
    }

    private func daysIn(month: Int) -> Int {
        let cal = Calendar.current
        let date = cal.date(from: DateComponents(year: 2024, month: month, day: 1))!
        return cal.range(of: .day, in: .month, for: date)!.count
    }
}

/// "How much" (an amount with an optional unit), "How long" (hours and minutes, for Time it) or "Limit"
/// (Cut down). The type chosen before the form decides which.
struct HowMuchEditor: View {
    enum Mode { case amount, time, limit }

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
    @FocusState private var typing: Bool

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
                    LabeledContent(limit ? "No more than" : "Amount") {
                        TextField(hint ?? (limit ? "e.g. 2" : "e.g. 8"), text: $amount)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .font(.body.monospacedDigit().weight(.semibold))
                            .focused($typing)
                            .frame(minWidth: 44, maxWidth: 160)
                            .accessibilityLabel(limit ? "Limit" : "Amount")
                            .accessibilityIdentifier("much-number")
                    }
                    unitLink
                } header: {
                    Text(limit ? "Limit" : "Amount")
                } footer: {
                    Text(entryError ?? (limit && unit == HabitPlan.timeUnit
                        ? "In minutes: 90 is 1 h 30 min. Time it with ▶ on Today, or type the minutes." + (limitInMinutes == true ? " A limit in minutes stays in minutes, so its past days keep their meaning." : "")
                        : "The unit is optional. Up to 2 decimal places.")).formNote()
                }
            }
        }
        .listSectionSpacing(.compact)
        .contentMargins(.top, 4, for: .scrollContent)
        .stickySentence(sentence, id: "much-summary")
        .navigationTitle(limit ? "Limit" : mode == .time ? "How Long" : "How Much")
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
        .selectsNumbersOnFocus()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                if typing { Spacer(); Button("Done") { typing = false }.fontWeight(.semibold) }
            }
        }
        // The amount starts filled with a suggestion, so the keyboard comes up with it selected.
        .task { if mode != .time { typing = true } }
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
                    Text(unit.isEmpty ? "Optional" : unit)
                        .foregroundStyle(unit.isEmpty ? .tertiary : .secondary)
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

private extension View {
    /// A choice's own setting, indented under it so it reads as part of that choice.
    func nested() -> some View {
        padding(.leading, 22)
            .font(.subheadline)
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
