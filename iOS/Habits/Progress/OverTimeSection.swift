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
    @State private var selected: Date?

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
                    ForEach(snapshot.footnotes, id: \.self) {
                        Text($0).font(.footnote).foregroundStyle(.secondary)
                    }
                }
            }
            .padding(.vertical, 6)
            // On the one row, never on the Section: a Section repeats its modifiers once per row (Design Rules).
            .id("over-time")
            .onAppear {
                if key == nil, let start {
                    range = start.range
                    anchor = start.anchor
                }
                load(Key(range: range, anchor: anchor, version: store.dataVersion, habit: habit))
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
        let color = habit.color.color
        let chosen = selected.flatMap { date in snapshot.bars.first { $0.start <= date && date < $0.end } }
        return Chart {
            ForEach(snapshot.bars) { bar in
                BarMark(x: .value("Date", bar.start, unit: snapshot.bucket), y: .value("Value", bar.value))
                    // Lower is better for a limit: a neutral colour, never a celebration (report §11.2). Part done is lighter.
                    .foregroundStyle(color.opacity(snapshot.isLimit ? 0.6 : bar.light ? 0.45 : 1))
                    .annotation(position: .top, spacing: 1) {
                        if bar.over {
                            Image(systemName: "arrowtriangle.up.fill").font(.system(size: 6)).foregroundStyle(.secondary)
                        }
                    }
                if let goal = bar.goal {
                    RuleMark(xStart: .value("From", bar.start), xEnd: .value("To", bar.end), y: .value("Goal", goal))
                        .foregroundStyle(Color.secondary)
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: snapshot.isLimit ? [4, 3] : []))
                }
            }
            if let chosen {
                RuleMark(x: .value("Chosen", chosen.start, unit: snapshot.bucket))
                    .foregroundStyle(Color.secondary.opacity(0.3))
                    .annotation(position: .top, overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
                        Text(chosen.label).font(.caption.weight(.semibold))
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(RoundedRectangle(cornerRadius: 6).fill(Color(.secondarySystemGroupedBackground)))
                    }
            }
        }
        .chartXScale(domain: lower...upper)
        .chartXSelection(value: $selected)
        .chartYAxis {
            AxisMarks { value in
                AxisGridLine()
                AxisValueLabel {
                    if let v = value.as(Double.self) { Text(axisLabel(v, snapshot.scale)) }
                }
            }
        }
        .chartYScale(domain: .automatic(includesZero: true))
        .frame(height: 180)
        .accessibilityIdentifier("over-time-chart")
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
