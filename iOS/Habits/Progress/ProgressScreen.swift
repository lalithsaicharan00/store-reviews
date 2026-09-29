import Charts
import SwiftUI

/// Progress (Build Plan #60; report "Progress and Statistics — What People Want", 29 Sep). Behind the chart button
/// on Today's top bar, one tap from home (users show statistics tucked in a profile or a menu go unfound).
///
/// Top to bottom, in the order the reviews ask for it: the overall share of what was planned that got done, with raw
/// numbers and the period before (the most-requested statistic: "the overall percentage of all habits"); a bar for
/// each day (or month) with its exact numbers on touch; in Year, a grid of every day; then every habit side by side,
/// each on its own rhythm, with totals for amounts and time; then quit habits. Week, Month or Year, stepped back with
/// ‹ ›. Tapping a habit opens its page. Numbers are explained under them (C217) and never reward or punish.
struct ProgressScreen: View {
    @Environment(HabitStore.self) private var store
    @State private var period: StatsPeriod = .week
    @State private var offset = 0
    @State private var snapshot: ProgressSnapshot?
    @State private var selected: Date?

    private struct Key: Hashable { let period: StatsPeriod; let offset: Int; let revision: Int }

    var body: some View {
        List {
            Section {
                Picker("Period", selection: $period) {
                    ForEach(StatsPeriod.allCases) { Text($0.title).tag($0) }
                }
                .pickerStyle(.segmented)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
                .accessibilityIdentifier("progress-period")
            }
            if let snapshot {
                if snapshot.isEmpty {
                    ContentUnavailableView("No Progress Yet", systemImage: "chart.bar.xaxis",
                                           description: Text("Add a habit on Today, and how it goes shows here."))
                        .listRowBackground(Color.clear)
                } else {
                    summary(snapshot)
                    if period == .year { yearSection(snapshot) }
                    habitsSection(snapshot)
                    quitSection(snapshot)
                }
            }
        }
        .listSectionSpacing(14)
        .navigationTitle("Progress")
        .navigationDestination(for: UUID.self) { HabitPageView(id: $0) }
        .onChange(of: period) { offset = 0; selected = nil }
        .onChange(of: offset) { selected = nil }
        // Worked out when the data or the period changes, never on a redraw (a touch on the chart only redraws).
        .task(id: Key(period: period, offset: offset, revision: store.revision)) {
            snapshot = ProgressSnapshot(stats: HabitStats(store: store), period: period, offset: offset)
        }
    }

    // MARK: Summary and the bars

    @ViewBuilder private func summary(_ s: ProgressSnapshot) -> some View {
        Section {
            HStack {
                Button("Previous \(period.rawValue)", systemImage: "chevron.left") { offset -= 1 }
                    .labelStyle(.iconOnly)
                    .disabled(s.range.lowerBound <= s.earliest)
                Spacer()
                Text(s.label).font(.headline).accessibilityAddTraits(.isHeader)
                Spacer()
                Button("Next \(period.rawValue)", systemImage: "chevron.right") { offset += 1 }
                    .labelStyle(.iconOnly)
                    .disabled(offset >= 0)
            }
            .buttonStyle(.borderless)
            VStack(alignment: .leading, spacing: 4) {
                if let rate = s.total.rate {
                    HStack(alignment: .firstTextBaseline, spacing: 6) {
                        Text(Self.percent(rate)).font(.system(.largeTitle, design: .rounded).weight(.bold)).monospacedDigit()
                        Text("done").font(.title3).foregroundStyle(.secondary)
                    }
                    Text(s.totalLine).font(.subheadline).foregroundStyle(.secondary)
                } else {
                    Text(offset == 0 ? "Nothing to count yet" : "Nothing was planned")
                        .font(.title3.weight(.semibold))
                    Text(offset == 0 ? "Days count once they're done or over." : "No habit had a day here.")
                        .font(.subheadline).foregroundStyle(.secondary)
                }
            }
            .accessibilityElement(children: .combine)
            .accessibilityIdentifier("progress-summary")
            if !s.points.isEmpty { chart(s) }
        } footer: {
            Text("Each day a habit was planned counts once, and a weekly or monthly goal once for its week or month. Skipped and paused days don't count, and today counts once it's done.")
        }
    }

    private func chart(_ s: ProgressSnapshot) -> some View {
        let unit: Calendar.Component = period == .year ? .month : .day
        // Week: a letter per day; Month: every 7th date; Year: a letter per month.
        let axis: (component: Calendar.Component, count: Int, format: Date.FormatStyle, centered: Bool) = switch period {
        case .week: (.day, 1, .dateTime.weekday(.narrow), true)
        case .month: (.day, 7, .dateTime.day(), false)
        case .year: (.month, 1, .dateTime.month(.narrow), true)
        }
        let point = selected.flatMap { date in s.points.first { store.calendar.isDate($0.date, equalTo: date, toGranularity: unit) } }
        return VStack(alignment: .leading, spacing: 8) {
            // The exact numbers for the bar under the finger (users show bars without numbers are guesswork).
            Text(point.map { "\($0.name): \($0.tally.done) of \($0.tally.planned) · \(Self.percent($0.tally.rate ?? 0))" }
                 ?? (period == .year ? "Each month's share done. Touch a bar for its numbers." : "Each day's share done. Touch a bar for its numbers."))
                .font(.caption).foregroundStyle(.secondary).monospacedDigit()
                .accessibilityHidden(true)
            Chart(s.points) { p in
                BarMark(x: .value("Date", p.date, unit: unit),
                        y: .value("Done", (p.tally.rate ?? 0) * 100))
                    .foregroundStyle(point == nil || point?.id == p.id ? Color.ink : Color.ink.opacity(0.35))
                    .cornerRadius(3)
                    .accessibilityLabel(p.name)
                    .accessibilityValue("\(p.tally.done) of \(p.tally.planned) done")
            }
            .chartYScale(domain: 0...100)
            .chartXScale(domain: s.chartDomain)
            .chartYAxis {
                AxisMarks(position: .leading, values: [0.0, 50.0, 100.0]) { value in
                    AxisGridLine()
                    AxisValueLabel { Text("\(Int(value.as(Double.self) ?? 0))%") }
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: axis.component, count: axis.count)) { _ in
                    AxisValueLabel(format: axis.format, centered: axis.centered)
                }
            }
            .chartXSelection(value: $selected)
            .frame(height: 150)
            .accessibilityIdentifier("progress-chart")
        }
        .padding(.vertical, 4)
    }

    // MARK: Year grid

    private func yearSection(_ s: ProgressSnapshot) -> some View {
        Section {
            YearGrid(first: s.range.lowerBound, last: min(s.range.upperBound, s.today), color: .ink,
                     calendar: store.calendar, value: { s.dayShares[$0] })
                .frame(height: 70)
                .padding(.vertical, 4)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Every day of \(s.label.lowercased()): \(s.fullDays) days with everything done")
        } header: {
            Text("Every day")
        } footer: {
            Text("Darker means more of the day's habits were done. Grey days had none done, or nothing planned.")
        }
    }

    // MARK: Habits

    @ViewBuilder private func habitsSection(_ s: ProgressSnapshot) -> some View {
        if !s.rows.isEmpty {
            Section("Habits") {
                ForEach(s.rows) { row in
                    NavigationLink(value: row.habit.id) {
                        HStack(spacing: 12) {
                            HabitIcon(symbol: row.habit.symbol, color: row.habit.color)
                            VStack(alignment: .leading, spacing: 4) {
                                HStack(alignment: .firstTextBaseline) {
                                    Text(row.habit.name).lineLimit(1)
                                    Spacer(minLength: 8)
                                    if let rate = row.tally.rate {
                                        Text(Self.percent(rate)).font(.subheadline.weight(.semibold)).monospacedDigit()
                                    }
                                }
                                ProgressView(value: row.tally.rate ?? 0)
                                    .tint(row.habit.color.color)
                                    .accessibilityHidden(true)
                                Text(row.detail).font(.caption).foregroundStyle(.secondary).lineLimit(2)
                            }
                        }
                        .padding(.vertical, 2)
                    }
                    .accessibilityElement(children: .combine)
                }
            }
        }
    }

    @ViewBuilder private func quitSection(_ s: ProgressSnapshot) -> some View {
        if !s.quitRows.isEmpty {
            Section("Quitting") {
                ForEach(s.quitRows) { row in
                    NavigationLink(value: row.habit.id) {
                        HStack(spacing: 12) {
                            HabitIcon(symbol: row.habit.symbol, color: row.habit.color)
                            VStack(alignment: .leading, spacing: 1) {
                                Text(row.habit.name).lineLimit(1)
                                Text(row.detail).font(.caption).foregroundStyle(.secondary)
                            }
                        }
                    }
                    .accessibilityElement(children: .combine)
                }
            }
        }
    }

    static func percent(_ rate: Double) -> String { rate.formatted(.percent.precision(.fractionLength(0))) }
}

/// Everything Progress shows for one period, worked out once.
struct ProgressSnapshot {
    struct Point: Identifiable {
        let id: LocalDay
        let date: Date
        let name: String
        let tally: HabitStats.Tally
    }
    struct Row: Identifiable {
        var id: UUID { habit.id }
        let habit: Habit
        let tally: HabitStats.Tally
        let detail: String
    }

    let range: ClosedRange<LocalDay>
    let label: String
    let today: LocalDay
    /// The first day anything was tracked; ‹ stops there.
    let earliest: LocalDay
    let total: HabitStats.Tally
    let totalLine: String
    let points: [Point]
    let chartDomain: ClosedRange<Date>
    let dayShares: [LocalDay: Double]
    let fullDays: Int
    let rows: [Row]
    let quitRows: [Row]
    var isEmpty: Bool { rows.isEmpty && quitRows.isEmpty }

    init(stats: HabitStats, period: StatsPeriod, offset: Int) {
        let store = stats.store
        let calendar = store.calendar
        today = stats.today
        range = period.range(offset: offset, today: today, store: store)
        label = period.label(range, offset: offset, today: today, calendar: calendar)
        let tracked = stats.tracked
        earliest = (tracked + stats.quitting).map { store.startDay(of: $0) }.min() ?? today

        // The overall share, and the same for the period before.
        let tallies = tracked.map { stats.tally($0, in: range) }
        total = tallies.reduce(HabitStats.Tally(), +)
        let previousRange = period.range(offset: offset - 1, today: today, store: store)
        let previous = tracked.map { stats.tally($0, in: previousRange) }.reduce(HabitStats.Tally(), +)
        var line = "\(total.done) of \(total.planned) planned"
        if let rate = previous.rate { line += " · \(period.previousName) \(ProgressScreen.percent(rate))" }
        totalLine = line

        // Bars: a day each (a month each in Year), up to today.
        let days = HabitStats.days(in: range, calendar: calendar).filter { $0 <= today }
        var shares: [LocalDay: Double] = [:]
        var dayTallies: [LocalDay: HabitStats.Tally] = [:]
        for day in days {
            let tally = stats.dayTally(on: day)
            dayTallies[day] = tally
            if let rate = tally.rate { shares[day] = rate }
        }
        dayShares = shares
        fullDays = shares.values.filter { $0 >= 1 }.count
        if period == .year {
            var months: [Point] = []
            for month in 1...12 {
                let first = LocalDay(year: range.lowerBound.year, month: month, day: 1)
                guard first <= today else { break }
                let tally = days.filter { $0.month == month }.compactMap { dayTallies[$0] }.reduce(HabitStats.Tally(), +)
                guard tally.planned > 0 else { continue }
                months.append(Point(id: first, date: first.date(calendar: calendar),
                                    name: first.date(calendar: calendar).formatted(.dateTime.month(.wide)), tally: tally))
            }
            points = months
        } else {
            points = days.compactMap { day in
                guard let tally = dayTallies[day], tally.planned > 0 else { return nil }
                return Point(id: day, date: day.date(calendar: calendar),
                             name: day.date(calendar: calendar).formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)),
                             tally: tally)
            }
        }
        // The whole period on the axis, so a week always shows seven places.
        let start = calendar.startOfDay(for: range.lowerBound.date(calendar: calendar))
        let end = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: range.upperBound.date(calendar: calendar)))!
        chartDomain = start...end

        rows = zip(tracked, tallies).map { habit, tally in
            Row(habit: habit, tally: tally, detail: Self.detail(habit, tally, stats: stats, range: range, offset: offset))
        }
        quitRows = stats.quitting.map { habit in
            let slips = stats.slips(habit, in: range)
            let best = Format.days(store.quitRuns(of: habit).best)
            let slipText = slips == 0 ? "No slips" : slips == 1 ? "1 slip" : "\(slips) slips"
            return Row(habit: habit, tally: .init(), detail: "\(slipText) · best run \(best)")
        }
    }

    /// "6 of 7 days · 42 km", "2 of 4 weeks", "So far: 2/3 this week", "Paused the whole time".
    private static func detail(_ habit: Habit, _ tally: HabitStats.Tally, stats: HabitStats,
                               range: ClosedRange<LocalDay>, offset: Int) -> String {
        let store = stats.store
        let rule = store.rule(habit, on: min(range.upperBound, stats.today))
        var parts: [String] = []
        if tally.planned > 0 {
            parts.append("\(tally.done) of \(tally.planned) \(StatsPeriod.noun(rule, tally.planned))")
        } else if offset == 0, !rule.frequency.isDayBased || rule.frequency.isFlexible {
            parts.append("So far: " + goalLine(rule, progress: store.progress(of: habit, on: stats.today), goal: store.goal(of: rule)))
        } else {
            parts.append("Nothing planned")
        }
        let total = stats.total(habit, in: range)
        switch habit.kind {
        case .amount(let unit, _) where total > 0: parts.append(HabitCopy.amount(total, unit))
        case .duration where total > 0: parts.append(Format.minutes(total))
        case .check where total > 0 && (habit.goal > 1 || habit.checkUnit != nil || !rule.frequency.isDayBased):
            parts.append(HabitCopy.amount(total, habit.checkUnit ?? (total == 1 ? "time" : "times")))
        default: break
        }
        return parts.joined(separator: " · ")
    }
}

/// A year of days as small squares, a column per week (GitHub's contribution grid, the most-requested long view: users
/// show a year that fills in is what keeps them going). `value` is 0...1, or nil for a day with nothing planned.
struct YearGrid: View {
    let first: LocalDay
    let last: LocalDay
    let color: Color
    let calendar: Calendar
    let value: (LocalDay) -> Double?

    var body: some View {
        Canvas { context, size in
            guard first <= last else { return }
            let lead = (calendar.component(.weekday, from: first.date(calendar: calendar)) - calendar.firstWeekday + 7) % 7
            let days = HabitStats.days(in: first...last, calendar: calendar)
            let columns = max(1, (lead + days.count + 6) / 7)
            let gap: CGFloat = 2
            let side = max(2, min((size.width - gap * CGFloat(columns - 1)) / CGFloat(columns), (size.height - gap * 6) / 7))
            for (i, day) in days.enumerated() {
                let slot = i + lead
                let rect = CGRect(x: CGFloat(slot / 7) * (side + gap), y: CGFloat(slot % 7) * (side + gap), width: side, height: side)
                let path = Path(roundedRect: rect, cornerRadius: side * 0.25)
                if let share = value(day), share > 0 {
                    context.fill(path, with: .color(color.opacity(0.25 + 0.75 * share)))
                } else {
                    context.fill(path, with: .color(Color(.tertiarySystemFill)))
                }
            }
        }
    }
}
