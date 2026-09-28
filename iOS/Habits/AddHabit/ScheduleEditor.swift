import SwiftUI

struct ScheduleEditor: View {
    @Binding var schedule: ScheduleDraft
    @Binding var goalPeriod: GoalPeriod
    let start: Date
    let end: Date?
    let weekStart: Int
    var hasGoal = true
    var checklist = false
    var task = false
    @State private var changeGoal = false
    @Environment(\.dynamicTypeSize) private var dynamicType

    private var aggregate: Bool { hasGoal && goalPeriod != .day }
    private var summary: String { aggregate ? "Any day this \(goalPeriod.noun)" : schedule.summary }

    var body: some View {
        Form {
            Section {
                VStack(spacing: 10) {
                    Text(summary).font(.system(.largeTitle, design: .rounded).weight(.bold))
                        .fixedSize(horizontal: false, vertical: true)
                    Text(aggregate ? "Your goal adds up across the \(goalPeriod.noun), so you can work on it on any day."
                         : schedule.explanation(start: start, checklist: checklist))
                        .font(.callout).foregroundStyle(.secondary)
                    if !aggregate, schedule.mode == .interval, let next {
                        Text("Next: \(next)").font(.callout.weight(.medium))
                    }
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity).padding(.vertical, 8)
                .accessibilityElement(children: .combine)
                .accessibilityIdentifier("schedule-summary")
            }.listRowBackground(Color.clear)
            if aggregate {
                Section {
                    CheckRow(title: summary, selected: true) {}
                    Button("Use set days instead…") { changeGoal = true }
                }
            } else {
                Section("Set days") {
                    option(.daily)
                    option(.specific)
                    if schedule.mode == .specific {
                        let quickLayout = dynamicType.isAccessibilitySize
                            ? AnyLayout(VStackLayout(alignment: .leading, spacing: 12))
                            : AnyLayout(HStackLayout(spacing: 20))
                        quickLayout {
                            Button("Weekdays") { schedule.weekdays = [2, 3, 4, 5, 6] }
                            Button("Weekends") { schedule.weekdays = [1, 7] }
                        }.buttonStyle(.borderless)
                        WeekdayPicker(selection: Binding(get: { schedule.weekdays }, set: {
                            if $0.count == 7 {
                                schedule.mode = .daily
                                UIAccessibility.post(notification: .announcement, argument: "Every day selected")
                            } else { schedule.weekdays = $0 }
                        }), firstWeekday: weekStart)
                    }
                    option(.interval)
                    if schedule.mode == .interval { intervalControls }
                }
                if !task {
                    Section {
                        option(.flexible)
                        if schedule.mode == .flexible {
                            Picker("Count days over", selection: $schedule.flexiblePeriod) {
                                ForEach([GoalPeriod.week, .month, .year]) { Text($0.label).tag($0) }
                            }
                            Stepper(value: $schedule.count, in: 1...flexibleMaximum) {
                                LabeledContent("Different days", value: "\(schedule.count)")
                            }.accessibilityIdentifier("flexible-count")
                        }
                    } header: { Text("Flexible days") } footer: {
                        Text("Choose how many different days in a week, month or year.")
                    }
                } else {
                    Section {
                        option(.after)
                        if schedule.mode == .after {
                            Picker("After", selection: $schedule.afterUnit) {
                                ForEach([ScheduleUnit.day, .week, .month]) { Text($0.plural.capitalized).tag($0) }
                            }
                            Stepper(value: $schedule.afterCount, in: 1...365) {
                                Text("\(schedule.afterCount) \(schedule.afterCount == 1 ? schedule.afterUnit.rawValue : schedule.afterUnit.plural) after completion")
                            }
                        }
                    }
                }
            }
        }
        .onAppear { schedule.seed(start: start, weekStart: weekStart) }
        .navigationTitle("Schedule")
        .navigationBarTitleDisplayMode(.inline)
        .listSectionSpacing(.compact)
        .alert("Use a goal for each scheduled day?", isPresented: $changeGoal) {
            Button("Change Goal to A day") { goalPeriod = .day }
            Button("Cancel", role: .cancel) {}
        } message: { Text("This schedule works with a goal that starts again each scheduled day. Your previous schedule will be restored.") }
    }

    private func option(_ mode: ScheduleDraft.Mode) -> some View {
        CheckRow(title: mode.rawValue, selected: schedule.mode == mode) { withAnimation { schedule.mode = mode } }
    }
    private var flexibleMaximum: Int {
        switch schedule.flexiblePeriod { case .week: 7; case .month: 28; case .year: 365; case .day: 1 }
    }
    private var intervalRange: ClosedRange<Int> {
        switch schedule.rule.unit { case .day: 2...365; case .week: 2...52; case .month: 1...120; case .year: 1...20 }
    }
    private var unitBinding: Binding<ScheduleUnit> {
        Binding(get: { schedule.rule.unit }, set: { unit in
            schedule.intervalCounts[schedule.rule.unit] = schedule.rule.interval
            schedule.rule.unit = unit
            schedule.rule.interval = schedule.intervalCounts[unit] ?? 1
        })
    }
    @ViewBuilder private var intervalControls: some View {
        Picker("Repeat interval", selection: unitBinding) {
            ForEach(ScheduleUnit.allCases) { Text($0.plural.capitalized).tag($0) }
        }.accessibilityIdentifier("schedule-interval-unit")
        Stepper(value: $schedule.rule.interval, in: intervalRange) {
            LabeledContent("Every", value: "\(schedule.rule.interval) \(schedule.rule.interval == 1 ? schedule.rule.unit.rawValue : schedule.rule.unit.plural)")
        }.accessibilityIdentifier("schedule-interval-count")
        switch schedule.rule.unit {
        case .day: EmptyView()
        case .week:
            WeekdayPicker(selection: $schedule.rule.weekdays, firstWeekday: weekStart)
        case .month:
            Picker("Pattern", selection: $schedule.rule.pattern) {
                ForEach(CalendarSchedule.MonthPattern.allCases) { Text($0.rawValue).tag($0) }
            }
            switch schedule.rule.pattern {
            case .dates:
                if schedule.rule.dates.contains(where: { $0 > 28 }) { shortMonths }
                MonthDatePicker(selection: $schedule.rule.dates)
            case .last: EmptyView()
            case .weekday:
                Picker("On the", selection: $schedule.rule.ordinal) {
                    ForEach([1, 2, 3, 4, 5, -1], id: \.self) { Text(ScheduleDraft.ordinalName($0)).tag($0) }
                }
                Picker("Weekday", selection: $schedule.rule.weekday) {
                    ForEach(1...7, id: \.self) { Text(Calendar.current.standaloneWeekdaySymbols[$0 - 1]).tag($0) }
                }
            }
        case .year:
            Picker("Month", selection: Binding(get: { schedule.rule.month }, set: {
                schedule.rule.month = $0
                schedule.rule.day = min(schedule.rule.day, daysInYearMonth)
            })) {
                ForEach(1...12, id: \.self) { Text(Calendar.current.monthSymbols[$0 - 1]).tag($0) }
            }
            Picker("Date", selection: $schedule.rule.day) {
                ForEach(1...daysInYearMonth, id: \.self) { Text(ScheduleDraft.ordinal($0)).tag($0) }
            }
            if schedule.rule.month == 2 && schedule.rule.day == 29 {
                Picker("Years without 29 Feb", selection: $schedule.rule.useLastDay) {
                    Text("Use 28 Feb").tag(true)
                    Text("Skip that year").tag(false)
                }
            }
        }
        LabeledContent("Starts", value: start.formatted(date: .abbreviated, time: .omitted))
    }
    private var shortMonths: some View {
        Picker("Shorter months", selection: $schedule.rule.useLastDay) {
            Text("Use the last day").tag(true)
            Text("Skip that month").tag(false)
        }
    }
    private var daysInYearMonth: Int {
        let cal = Calendar.current
        let date = cal.date(from: DateComponents(year: 2024, month: schedule.rule.month, day: 1))!
        return cal.range(of: .day, in: .month, for: date)!.count
    }
    private var next: String? {
        schedule.rule.next(from: LocalDay(.now), start: LocalDay(start), end: end.map { LocalDay($0) }, calendar: .current)?
            .date().formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated).year())
    }
}
