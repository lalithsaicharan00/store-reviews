import Charts
import SwiftUI

/// The habit page's Over Time (report §8.3): Week · Month · Year · All, the numbers for the habit's type, the count
/// bar and a chart. Worked out once per change of data, range or period (report §20), never while drawing.
struct OverTimeSection: View {
    let habit: Habit
    let start: OverTimeStart?
    @Environment(HabitStore.self) private var store
    @AppStorage(ProgressOptions.showPercentages) private var showPercentages = true
    @State private var range: OverTimeRange = .month
    @State private var anchor: LocalDay?
    @State private var snapshot: OverTimeSnapshot?
    @State private var key: Key?
    /// The tapped bar in the chart, by its place.
    @State private var selected: Int?

    private struct Key: Hashable {
        let range: OverTimeRange
        let anchor: LocalDay?
        let version: Int
        let habit: Habit
    }

    var body: some View {
        let current = Key(range: range, anchor: anchor, version: store.dataVersion, habit: habit)
        Section {
            VStack(alignment: .leading, spacing: 14) {
                Picker("Range", selection: $range) {
                    ForEach(OverTimeRange.allCases) { Text($0.title).tag($0) }
                }
                .pickerStyle(.segmented)
                .accessibilityIdentifier("over-time-range")
                if let snapshot {
                    periodControl(snapshot)
                    tiles(snapshot)
                    if let pace = snapshot.pace { Text(pace).font(.subheadline).foregroundStyle(.secondary).accessibilityIdentifier("over-time-pace") }
                    if let change = snapshot.change { Text(change).font(.subheadline).foregroundStyle(.secondary) }
                    if let counts = snapshot.counts { CountBar(counts: counts, color: habit.color.color) }
                    if !snapshot.bars.isEmpty { chart(snapshot) }
                    if !snapshot.running.isEmpty { runningChart(snapshot) }
                    if !snapshot.steps.isEmpty { bySteps(snapshot.steps) }
                    // Both are percentages for check-offs: hidden with Show Percentages off (report §7.6).
                    if !snapshot.weekdays.isEmpty && (showPercentages || snapshot.weekdayAverages) { byWeekday(snapshot) }
                    if !snapshot.rate.isEmpty && showPercentages { rateChart(snapshot.rate) }
                    ForEach(snapshot.footnotes, id: \.self) {
                        Text($0).font(.footnote).foregroundStyle(.secondary)
                    }
                }
            }
            .padding(.vertical, 6)
            // On the one row, never on the Section: a Section repeats its modifiers once per row (Design Rules).
            .id("over-time")
            .onAppear {
                // Opened from Progress: start on its range and period, once.
                let first = key == nil ? start : nil
                if let first {
                    range = first.range
                    anchor = first.anchor
                }
                load(Key(range: first?.range ?? range, anchor: first?.anchor ?? anchor, version: store.dataVersion, habit: habit))
            }
            .onChange(of: current) { load(current) }
        } header: {
            Text("Over Time")
        }
    }

    private func load(_ key: Key) {
        guard key != self.key else { return }
        self.key = key
        selected = nil
        snapshot = store.overTime(habit, range: key.range, anchor: key.anchor ?? store.today())
    }

    /// By Weekday (report §8.6): seven bars in the person's week order, and one neutral caption. Never a worst day.
    private func byWeekday(_ snapshot: OverTimeSnapshot) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("By Weekday").font(.subheadline.weight(.semibold))
            let count = Double(max(snapshot.weekdays.count, 1))
            LightBarChart(title: "By Weekday",
                          bars: snapshot.weekdays.enumerated().map { i, day in
                              LightBarChart.Bar(id: i, from: Double(i) / count + 0.1 / count, to: Double(i + 1) / count - 0.1 / count,
                                                value: day.value, opacity: day.days == 0 ? 0.2 : 0.8, over: false,
                                                label: "\(day.name), \(snapshot.weekdayAverages ? axisLabel(day.value, snapshot.scale) : "\(Int(day.value))%")")
                          },
                          xLabels: snapshot.weekdays.enumerated().map { i, day in
                              LightBarChart.XLabel(at: (Double(i) + 0.5) / count, text: day.name)
                          },
                          color: habit.color.color,
                          yLabel: { snapshot.weekdayAverages ? axisLabel($0, snapshot.scale) : "\(Int($0))%" })
            .frame(height: 120)
            if let caption = snapshot.weekdayCaption {
                Text(caption).font(.footnote).foregroundStyle(.secondary)
            }
        }
        .accessibilityIdentifier("over-time-weekdays")
    }

    /// The 30-day rate (report §16.6): a forgiving measure anyone can check on the calendar.
    private func rateChart(_ points: [RatePoint]) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("30-day rate").font(.subheadline.weight(.semibold))
            Chart(points) { point in
                LineMark(x: .value("Date", point.date), y: .value("Rate", point.percent))
                    .foregroundStyle(habit.color.color)
            }
            .chartYScale(domain: 0...100)
            .chartYAxis {
                AxisMarks(values: [0, 50, 100]) { value in
                    AxisGridLine()
                    AxisValueLabel { if let v = value.as(Double.self) { Text("\(Int(v))%") } }
                }
            }
            .frame(height: 120)
            Text("Of the planned days in the last 30 days, how many were done.").font(.footnote).foregroundStyle(.secondary)
        }
        .accessibilityIdentifier("over-time-rate")
    }

    /// "Floss · 60%", or "12 of 20 days" while percentages are hidden (report §9.2, E).
    private func bySteps(_ steps: [OverTimeStep]) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("By Step").font(.subheadline.weight(.semibold))
            ForEach(steps) { step in
                HStack {
                    Text(step.name).lineLimit(1)
                    Spacer(minLength: 8)
                    Text(showPercentages ? step.percent.map { "\($0)%" } ?? "No days yet" : "\(step.ticked) of \(step.days) days")
                        .foregroundStyle(.secondary).monospacedDigit()
                }
                .font(.subheadline)
                .accessibilityElement(children: .combine)
            }
        }
        .accessibilityIdentifier("over-time-steps")
    }

    private func periodControl(_ snapshot: OverTimeSnapshot) -> some View {
        HStack {
            if snapshot.range != .all {
                Button("Previous", systemImage: "chevron.left") { move(snapshot, by: -1) }
                    .labelStyle(.iconOnly)
                    .frame(width: 44, height: 36)
                    .disabled(!snapshot.canGoBack)
            }
            Spacer()
            Text(snapshot.title).font(.headline).accessibilityIdentifier("over-time-period")
            Spacer()
            if snapshot.range != .all {
                Button("Next", systemImage: "chevron.right") { move(snapshot, by: 1) }
                    .labelStyle(.iconOnly)
                    .frame(width: 44, height: 36)
                    .disabled(!snapshot.canGoForward)
            }
        }
        .buttonStyle(.borderless)
    }

    private func move(_ snapshot: OverTimeSnapshot, by step: Int) {
        guard let kind = snapshot.range.kind else { return }
        let calendar = store.calendar
        let day = step < 0 ? snapshot.span.lowerBound.adding(days: -1, calendar: calendar)
            : snapshot.span.upperBound.adding(days: 1, calendar: calendar)
        anchor = store.period(kind, containing: day).contains(store.today()) ? nil : day
    }

    private func tiles(_ snapshot: OverTimeSnapshot) -> some View {
        LazyVGrid(columns: [GridItem(.flexible(), alignment: .top), GridItem(.flexible(), alignment: .top)], spacing: 12) {
            ForEach(snapshot.tiles) { tile in
                let percent = showPercentages ? tile.percent : nil
                VStack(alignment: .leading, spacing: 2) {
                    Text(tile.value + (percent.map { " · \($0)%" } ?? ""))
                        .font(.headline.monospacedDigit()).lineLimit(2).minimumScaleFactor(0.8)
                    Text(tile.caption).font(.caption).foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("\(tile.caption), \(tile.value)" + (percent.map { ", \($0) percent" } ?? ""))
            }
        }
    }

    // MARK: Chart

    private func chart(_ snapshot: OverTimeSnapshot) -> some View {
        let calendar = store.calendar
        let lower = calendar.startOfDay(for: snapshot.span.lowerBound.date(calendar: calendar))
        let upper = calendar.startOfDay(for: snapshot.span.upperBound.adding(days: 1, calendar: calendar).date(calendar: calendar))
        let length = max(upper.timeIntervalSince(lower), 1)
        let at = { (date: Date) in min(1, max(0, date.timeIntervalSince(lower) / length)) }
        // Lower is better for a limit: a neutral colour, never a celebration (report §11.2). Part done is lighter.
        let bars = snapshot.bars.enumerated().map { i, bar in
            LightBarChart.Bar(id: i, from: at(bar.start), to: at(bar.end), value: bar.value,
                              opacity: snapshot.isLimit ? 0.6 : bar.light ? 0.45 : 1, over: bar.over, label: bar.label)
        }
        // The goal or limit: one line for each run of bars with the same goal; it steps where the goal changed.
        let goals = Self.goalSegments(snapshot.bars).map { LightBarChart.GoalLine(from: at($0.start), to: at($0.end), value: $0.goal) }
        return LightBarChart(title: "Over Time, \(snapshot.title)", bars: bars, goals: goals, dashedGoals: snapshot.isLimit,
                             xLabels: xLabels(snapshot, at: at), color: habit.color.color,
                             yLabel: { axisLabel($0, snapshot.scale) }, chosen: $selected)
            .frame(height: 180)
            .accessibilityIdentifier("over-time-chart")
    }

    /// Dates under the chart, as Swift Charts chose them: each week's first day for a month of days, months for a year,
    /// at most six, so they never crowd.
    private func xLabels(_ snapshot: OverTimeSnapshot, at: (Date) -> Double) -> [LightBarChart.XLabel] {
        let calendar = store.calendar
        var marks: [(day: LocalDay, text: String)] = []
        let unit: Calendar.Component
        switch snapshot.bucket {
        case .day:
            unit = .day
            var day = snapshot.span.lowerBound
            while day <= snapshot.span.upperBound {
                if snapshot.range == .week || day.weekday(calendar: calendar) == calendar.firstWeekday {
                    let date = day.date(calendar: calendar)
                    marks.append((day, snapshot.range == .week ? date.formatted(.dateTime.weekday(.narrow))
                                  : date.formatted(.dateTime.month(.abbreviated).day())))
                }
                day = day.adding(days: 1, calendar: calendar)
            }
        case .year:
            unit = .year
            for year in snapshot.span.lowerBound.year...snapshot.span.upperBound.year {
                marks.append((LocalDay(year: year, month: 1, day: 1), String(year)))
            }
        default:
            unit = .month
            var month = LocalDay(year: snapshot.span.lowerBound.year, month: snapshot.span.lowerBound.month, day: 1)
            let multiYear = snapshot.span.lowerBound.year != snapshot.span.upperBound.year
            while month <= snapshot.span.upperBound {
                let date = month.date(calendar: calendar)
                if month >= snapshot.span.lowerBound {
                    marks.append((month, multiYear && month.month == 1 ? String(month.year) : date.formatted(.dateTime.month(.abbreviated))))
                }
                month = LocalDay(year: month.month == 12 ? month.year + 1 : month.year, month: month.month % 12 + 1, day: 1)
            }
        }
        let every = max(1, Int((Double(marks.count) / 6).rounded(.up)))
        return marks.enumerated().compactMap { i, mark in
            guard i % every == 0 else { return nil }
            let start = mark.day.date(calendar: calendar)
            let end = calendar.date(byAdding: unit, value: 1, to: start) ?? start
            return LightBarChart.XLabel(at: (at(start) + at(end)) / 2, text: mark.text)
        }
    }

    private struct GoalSegment: Identifiable {
        let start: Date
        let end: Date
        let goal: Double
        var id: Date { start }
    }

    /// Bars side by side with the same goal share one line; a gap (a day that isn't its day) or a new goal starts
    /// another, so the line looks as it did with one per bar.
    private static func goalSegments(_ bars: [OverTimeBar]) -> [GoalSegment] {
        var segments: [GoalSegment] = []
        for bar in bars {
            guard let goal = bar.goal else { continue }
            if let last = segments.last, last.goal == goal, last.end == bar.start {
                segments[segments.count - 1] = GoalSegment(start: last.start, end: bar.end, goal: goal)
            } else {
                segments.append(GoalSegment(start: bar.start, end: bar.end, goal: goal))
            }
        }
        return segments
    }

    /// A week or month total: the running total, and a straight dashed line from 0 to the goal or limit. Above the
    /// line is ahead of pace; for a limit, below it is (report §9.3). Neutral colours either way.
    private func runningChart(_ snapshot: OverTimeSnapshot) -> some View {
        let calendar = store.calendar
        let lower = calendar.startOfDay(for: snapshot.span.lowerBound.date(calendar: calendar))
        let upper = calendar.startOfDay(for: snapshot.span.upperBound.date(calendar: calendar))
        let color = habit.color.color
        return Chart {
            ForEach(snapshot.running) { point in
                LineMark(x: .value("Date", point.date), y: .value("Total", point.total), series: .value("Line", "Total"))
                    .foregroundStyle(color.opacity(snapshot.isLimit ? 0.6 : 1))
                    .interpolationMethod(.stepEnd)
                AreaMark(x: .value("Date", point.date), y: .value("Total", point.total))
                    .foregroundStyle(color.opacity(0.12))
                    .interpolationMethod(.stepEnd)
            }
            if let pace = snapshot.paceLine {
                LineMark(x: .value("Date", pace.start), y: .value("Total", 0.0), series: .value("Line", "Pace"))
                    .foregroundStyle(Color.secondary)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [4, 3]))
                LineMark(x: .value("Date", pace.end), y: .value("Total", pace.goal), series: .value("Line", "Pace"))
                    .foregroundStyle(Color.secondary)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [4, 3]))
            }
        }
        .chartXScale(domain: lower...max(upper, lower.addingTimeInterval(1)))
        .chartYAxis {
            AxisMarks { value in
                AxisGridLine()
                AxisValueLabel {
                    if let v = value.as(Double.self) { Text(axisLabel(v, snapshot.scale)) }
                }
            }
        }
        .chartLegend(.hidden)
        .frame(height: 180)
        .accessibilityIdentifier("over-time-running")
    }

    /// The unit's own labels, time always as hours and minutes (report §9.3).
    private func axisLabel(_ v: Double, _ scale: OverTimeScale) -> String {
        switch scale {
        case .percent: return "\(Int(v))%"
        case .minutes: return v >= 60 && v.truncatingRemainder(dividingBy: 60) == 0 ? "\(Int(v / 60)) h" : HabitCopy.minutes(v)
        case .amount: return HabitCopy.number(v)
        }
    }
}

/// Done · Part done · Not done · Skipped · Paused, one thin bar with the counts under it (report §8.3). Zero parts are
/// left out; never red.
struct CountBar: View {
    let counts: OverTimeCounts
    let color: Color

    var body: some View {
        let parts: [(String, Int, Color)] = [
            (counts.atMost ? "Within" : "Done", counts.done, color),
            ("Part done", counts.part, color.opacity(0.45)),
            (counts.atMost ? "Over" : "Not done", counts.notDone, Color(.systemGray3)),
            ("Skipped", counts.skipped, Color(.systemGray5)),
            ("Paused", counts.paused, Color(.systemGray6)),
        ].filter { $0.1 > 0 }
        VStack(alignment: .leading, spacing: 6) {
            GeometryReader { proxy in
                HStack(spacing: 2) {
                    ForEach(parts, id: \.0) { part in
                        Capsule().fill(part.2)
                            .frame(width: max(4, (proxy.size.width - CGFloat(parts.count - 1) * 2) * CGFloat(part.1) / CGFloat(max(counts.total, 1))))
                    }
                }
            }
            .frame(height: 8)
            Text(parts.map { "\($0.0) \($0.1)" }.joined(separator: " · "))
                .font(.caption).foregroundStyle(.secondary).monospacedDigit()
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(parts.map { "\($0.0) \($0.1)" }.joined(separator: ", "))
        .accessibilityIdentifier("over-time-counts")
    }
}
