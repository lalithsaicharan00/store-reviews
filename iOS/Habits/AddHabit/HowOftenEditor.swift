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
    @Environment(\.dynamicTypeSize) private var dynamicType

    private var hasAmount: Bool { amountText != nil }
    private var often: HowOften { draft.often(hasAmount: hasAmount) }

    /// A choice's words: with an amount, "2 chapters a week"; without, "3 times a week".
    private func words(_ choice: HowOften) -> String {
        let phrase = choice.phrase(hasAmount: hasAmount, checklist: checklist, weekStart: weekStart)
        guard let amountText else { return HabitCopy.capitalized(phrase) }
        if limit { return "At most \(amountText) " + (choice == .everyDay ? "a day" : phrase) }
        switch choice {
        case .everyDay: return "\(amountText) a day"
        case .days(_, 1): return "\(amountText), \(phrase)"
        default: return "\(amountText) \(phrase)"
        }
    }

    var body: some View {
        Form {
            Section {
                VStack(spacing: 6) {
                    Text(words(often))
                        .font(.system(.title, design: .rounded).weight(.bold))
                        .fixedSize(horizontal: false, vertical: true)
                    Text(explanation).font(.callout).foregroundStyle(.secondary)
                    if let next { Text("Coming up: \(next)").font(.callout.weight(.medium)) }
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 6)
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier("often-summary")
            }
            .listRowBackground(Color.clear)
            if limit {
                Section {
                    choiceRow(.everyDay, words(.everyDay))
                    choiceRow(.total, words(.total(.week)), selected: draft.choice == .total && draft.totalPeriod == .week, id: "total-week") { draft.totalPeriod = .week }
                    choiceRow(.total, words(.total(.month)), selected: draft.choice == .total && draft.totalPeriod == .month, id: "total-month") { draft.totalPeriod = .month }
                } footer: { Text("Log each one as it happens. It counts while you stay at or under the limit.").formNote() }
            } else if hasAmount {
                amountChoices
            } else {
                countChoices
            }
            setDayChoices
        }
        .onAppear { draft.seed(start: start, weekStart: weekStart) }
        .navigationTitle("How Often")
        .navigationBarTitleDisplayMode(.inline)
        .listSectionSpacing(.compact)
    }

    // MARK: Choices

    /// Just do it: every day, several times a day, or a number of times (or days) in a week, month or year.
    @ViewBuilder private var countChoices: some View {
        Section {
            choiceRow(.everyDay, "Every day")
            choiceRow(.timesADay, words(.timesADay(max(2, draft.perDay))))
            if draft.choice == .timesADay {
                Stepper(value: $draft.perDay, in: 2...99) {
                    LabeledContent("Times a day", value: "\(draft.perDay)")
                }
                .accessibilityIdentifier("often-per-day")
            }
            choiceRow(.times, words(countChoice))
            if draft.choice == .times { countControls(days: draft.countsDays) }
        } header: {
            Text("How many times")
        } footer: {
            if draft.choice == .times {
                Text(draft.countsDays ? "Counts different days: two on one day count once." : "Every ✓ counts, even two on one day. Do it on any days.").formNote()
            } else if draft.choice == .timesADay {
                Text("Each ✓ counts one, so Today shows 1/\(draft.perDay).").formNote()
            }
        }
    }

    /// An amount: that much a day, in total over a week, month or year, or on some days.
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
        } footer: {
            if draft.choice == .total { Text(totalNote).formNote() }
        }
        Section {
            choiceRow(.times, words(countChoice))
            if draft.choice == .times { countControls(days: true) }
        } header: {
            Text("On some days")
        } footer: {
            if draft.choice == .times, let amountText {
                Text("Counts the days you reach \(amountText). + adds all of it in one tap.").formNote()
            }
        }
    }

    /// The same for everything: certain days of the week, every few days or weeks, or on a date.
    @ViewBuilder private var setDayChoices: some View {
        Section {
            choiceRow(.weekdays, words(.weekdays(draft.weekdays)))
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
            choiceRow(.every, words(.calendar(draft.everyRule)))
            if draft.choice == .every { everyControls }
            choiceRow(.date, words(.calendar(draft.dateRule)))
            if draft.choice == .date { dateControls }
        } header: {
            Text("On set days")
        } footer: {
            if let note = setDaysNote { Text(note).formNote() }
        }
    }

    private var countChoice: HowOften {
        hasAmount || draft.countsDays ? .days(draft.countPeriod, draft.count) : .times(draft.countPeriod, draft.count)
    }

    @ViewBuilder private func countControls(days: Bool) -> some View {
        Picker("Each", selection: Binding(get: { draft.countPeriod }, set: { period in
            draft.countPeriod = period
            draft.count = min(draft.count, draft.countMaximum(days: days))
        })) {
            ForEach([GoalPeriod.week, .month, .year]) { Text($0.label).tag($0) }
        }
        .accessibilityIdentifier("often-count-period")
        Stepper(value: $draft.count, in: 1...draft.countMaximum(days: days)) {
            LabeledContent(days ? "Days" : "Times", value: "\(draft.count)")
        }
        .accessibilityIdentifier("often-count")
        if !hasAmount && !checklist {
            Picker("Count", selection: Binding(get: { draft.countsDays }, set: { counts in
                draft.countsDays = counts
                draft.count = min(draft.count, draft.countMaximum(days: counts))
            })) {
                Text("Every time").tag(false)
                Text("Different days").tag(true)
            }
            .pickerStyle(.segmented)
            .accessibilityIdentifier("often-counts-days")
        }
    }

    @ViewBuilder private var everyControls: some View {
        Picker("Repeat every", selection: Binding(get: { draft.everyRule.unit }, set: { unit in
            draft.everyRule.unit = unit
            draft.everyRule.interval = unit == .day ? max(2, draft.everyRule.interval) : draft.everyRule.interval
        })) {
            Text("Few days").tag(ScheduleUnit.day)
            Text("Few weeks").tag(ScheduleUnit.week)
        }
        .pickerStyle(.segmented)
        .accessibilityIdentifier("often-every-unit")
        Stepper(value: $draft.everyRule.interval, in: draft.everyRule.unit == .day ? 2...365 : 1...52) {
            LabeledContent("Every", value: "\(draft.everyRule.interval) \(draft.everyRule.interval == 1 ? draft.everyRule.unit.rawValue : draft.everyRule.unit.plural)")
        }
        .accessibilityIdentifier("often-every-count")
        if draft.everyRule.unit == .week {
            WeekdayPicker(selection: $draft.everyRule.weekdays, firstWeekday: weekStart)
        }
        LabeledContent("Counted from", value: start.formatted(date: .abbreviated, time: .omitted))
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
                Picker("Which", selection: $draft.dateRule.ordinal) {
                    ForEach([1, 2, 3, 4, 5, -1], id: \.self) { Text(HabitCopy.capitalized(HabitCopy.ordinalWord($0))).tag($0) }
                }
                Picker("Day", selection: $draft.dateRule.weekday) {
                    ForEach(1...7, id: \.self) { Text(HabitCopy.fullDays[$0 - 1]).tag($0) }
                }
            }
            Stepper(value: $draft.dateRule.interval, in: 1...12) {
                LabeledContent("Every", value: draft.dateRule.interval == 1 ? "month" : "\(draft.dateRule.interval) months")
            }
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

    private var weekStartName: String { HabitCopy.fullDays[(weekStart - 1 + 7) % 7] }

    private var totalNote: String {
        switch draft.totalPeriod {
        case .week: "Everything you log this week adds up. It starts fresh each \(weekStartName)."
        case .month: "Everything you log this month adds up. It starts fresh on the 1st."
        default: "Everything you log this year adds up. It starts fresh on January 1."
        }
    }

    /// What the chosen rhythm means in practice, in one line.
    private var explanation: String {
        switch often {
        case .everyDay: return limit ? "A new limit each day." : hasAmount ? "Starts fresh every day." : "Tick ✓ each day it's done."
        case .timesADay(let n): return "Each ✓ counts one; \(n) makes the day."
        case .times(let period, _): return "On any days. Everything you tick this \(period.noun) counts."
        case .days(let period, _): return hasAmount ? "On any days this \(period.noun)." : "On any different days this \(period.noun)."
        case .total(let period): return "On any days. It all adds up over the \(period.noun)."
        case .weekdays: return "Only on these days. Other days don't count against it."
        case .calendar: return "Only on these days. Other days don't count against it."
        }
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
        guard case .calendar(let rule) = often else { return nil }
        return rule.next(from: LocalDay(.now), start: LocalDay(start), calendar: .current)?
            .date().formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated))
    }

    private func daysIn(month: Int) -> Int {
        let cal = Calendar.current
        let date = cal.date(from: DateComponents(year: 2024, month: month, day: 1))!
        return cal.range(of: .day, in: .month, for: date)!.count
    }
}

/// "How much": Just do it, or an amount with a unit (minutes and hours make it timed). The amount is
/// typed; time uses the hours and minutes wheels, with Type for exact times.
struct HowMuchEditor: View {
    @Binding var usesAmount: Bool
    @Binding var amount: String
    @Binding var unit: String
    @Binding var hours: String
    @Binding var minutes: String
    /// Cut down: always an amount, read as a limit.
    let limit: Bool
    let usedUnits: [String]
    /// The period the amount is for, so a time can't be longer than it.
    let period: GoalPeriod
    @FocusState private var typing: Bool

    private var timed: Bool { unit == HabitPlan.timeUnit }

    /// The amount said back as it's typed: "Just do it", "2,500 ml", "1 h 30 min", "At most 3 coffees".
    private var readBack: String? {
        if !usesAmount && !limit { return "Just do it" }
        let text: String
        if timed {
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
            Section {
                VStack(spacing: 2) {
                    Text(readBack ?? "—")
                        .font(.system(.largeTitle, design: .rounded).weight(.bold).monospacedDigit())
                        .foregroundStyle(readBack == nil ? .tertiary : .primary)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    if readBack == nil {
                        Text("Type the amount below.").font(.title3).foregroundStyle(.secondary)
                    }
                }
                .frame(maxWidth: .infinity)
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier("much-summary")
            }
            .listRowBackground(Color.clear)
            if !limit {
                Section {
                    CheckRow(title: "Just do it", detail: "Tick ✓ when it's done", selected: !usesAmount) {
                        typing = false
                        withAnimation { usesAmount = false }
                    }
                    .accessibilityIdentifier("much-just-do-it")
                    CheckRow(title: "An amount", detail: "How many, how much or how long: 8 glasses, 5 km, 30 min", selected: usesAmount) {
                        withAnimation { usesAmount = true }
                        if !timed { typing = true }
                    }
                    .accessibilityIdentifier("much-amount")
                }
            }
            if usesAmount || limit {
                if timed {
                    DurationInput(hours: $hours, minutes: $minutes, period: period, header: "Time")
                    unitSection(footer: "Time it with ▶ on Today, or type the time.")
                } else {
                    Section {
                        LabeledContent(limit ? "No more than" : "Amount") {
                            TextField(limit ? "e.g. 2" : "e.g. 8", text: $amount)
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
                        Text(entryError ?? "The unit is optional. Up to 2 decimal places.").formNote()
                    }
                }
            }
        }
        .listSectionSpacing(.compact)
        .contentMargins(.top, 4, for: .scrollContent)
        .navigationTitle(limit ? "Limit" : "How Much")
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
        .selectsNumbersOnFocus()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                if typing { Spacer(); Button("Done") { typing = false }.fontWeight(.semibold) }
            }
        }
        .task { if (usesAmount || limit) && !timed && amount.isEmpty { typing = true } }
    }

    private var unitLink: some View {
        NavigationLink {
            UnitPicker(unit: $unit, used: usedUnits, mode: limit ? .limit : .amount, allowsNone: true)
        } label: {
            LabeledContent("Unit") {
                Text(unit.isEmpty ? "Optional" : timed ? "Time" : unit)
                    .foregroundStyle(unit.isEmpty ? .tertiary : .secondary)
            }
        }
        .accessibilityIdentifier("much-unit")
    }

    private func unitSection(footer: String) -> some View {
        Section { unitLink } footer: { Text(footer).formNote() }
    }

    private var entryError: String? {
        let text = amount.trimmingCharacters(in: .whitespaces)
        guard !text.isEmpty else { return nil }
        guard let n = GoalNumber.parse(text), n > 0 else { return "Enter a number above 0, with up to 2 decimal places." }
        return nil
    }
}
