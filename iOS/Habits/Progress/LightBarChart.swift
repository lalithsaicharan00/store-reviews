import Accessibility
import SwiftUI

// Charts drawn in one `Canvas` pass: bars or a line, goal lines, grid lines and axis labels.
//
// Swift Charts' first layout of the habit page's Over Time chart was most of a 1-second freeze the first time the page
// scrolled to it, and no single option was to blame (bisect runs, 1 Oct 2026: selection, either axis and the date bins
// each took off part of it). The same pictures drawn here are one view each with no layout of their own
// (PERFORMANCE.md rule 12). VoiceOver reads each bar or point, and Audio Graphs and the data table come from the chart
// descriptor, as with Swift Charts.

/// A bar chart: Over Time's bars, By Weekday, a quit habit's runs.
struct LightBarChart: View {
    nonisolated struct Bar: Identifiable, Sendable {
        let id: Int
        /// Where the bar starts and ends across the chart, 0 to 1.
        let from: Double
        let to: Double
        let value: Double
        let opacity: Double
        /// A limit went over: a small ▲ above the bar.
        let over: Bool
        /// What VoiceOver says, and the callout when the bar is tapped.
        let label: String
        /// A word above the bar ("Now" on a quit habit's current run).
        var note: String? = nil
    }

    /// A goal or limit line from `from` to `to` (0 to 1), so it steps where the goal changed.
    struct GoalLine {
        let from: Double
        let to: Double
        let value: Double
    }

    /// A label under the chart, centred at `at` (0 to 1).
    struct XLabel {
        let at: Double
        let text: String
    }

    let title: String
    let bars: [Bar]
    var goals: [GoalLine] = []
    var dashedGoals = false
    var xLabels: [XLabel] = []
    let color: Color
    let yLabel: (Double) -> String
    /// The tapped bar, whose label shows above the chart; nil where bars can't be tapped.
    var chosen: Binding<Int?>? = nil

    @State private var width: CGFloat = 0

    var body: some View {
        let axis = ChartGrid.axis(max(bars.map(\.value).max() ?? 0, goals.map(\.value).max() ?? 0))
        let grid = ChartGrid(top: axis.top, ticks: stride(from: 0, through: axis.top, by: axis.step).map { $0 }, yLabel: yLabel,
                             hasXLabels: !xLabels.isEmpty, roomAbove: bars.contains { $0.note != nil } ? 14 : 8)
        let picked = chosen?.wrappedValue.flatMap { id in bars.first { $0.id == id } }
        Canvas { context, size in
            draw(in: &context, size: size, grid: grid, picked: picked)
        }
        .onGeometryChange(for: CGFloat.self) { $0.size.width } action: { width = $0 }
        .contentShape(Rectangle())
        .onTapGesture(coordinateSpace: .local) { location in
            guard let chosen else { return }
            let at = Double(location.x / max(width - grid.gutter, 1))
            let hit = bars.first { $0.from <= at && at < $0.to }?.id
            chosen.wrappedValue = hit == chosen.wrappedValue ? nil : hit
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(title)
        .accessibilityChildren {
            ForEach(bars) { bar in
                Rectangle().accessibilityLabel(bar.label)
            }
        }
        .accessibilityChartDescriptor(ChartDescriptor(title: title, labels: bars.map(\.label), values: bars.map(\.value)))
    }

    private func draw(in context: inout GraphicsContext, size: CGSize, grid: ChartGrid, picked: Bar?) {
        let plot = grid.plot(in: size)
        grid.drawLines(in: &context, size: size, plot: plot)
        grid.drawXLabels(xLabels, in: &context, plot: plot)

        // Bars: one path per shade, so a month of bars is a few fills.
        var shades: [Double: Path] = [:]
        var marks = Path()
        for bar in bars {
            let left = plot.x(bar.from), right = plot.x(bar.to)
            let gap = max(1, (right - left) * 0.2) // bars fill four fifths of their slot
            let top = plot.y(bar.value)
            shades[bar.opacity, default: Path()].addRect(CGRect(x: left + gap / 2, y: top,
                                                                width: max(right - left - gap, 1), height: plot.rect.maxY - top))
            let mid = (left + right) / 2
            if bar.over {
                marks.move(to: CGPoint(x: mid - 3, y: top - 1))
                marks.addLine(to: CGPoint(x: mid + 3, y: top - 1))
                marks.addLine(to: CGPoint(x: mid, y: top - 6))
                marks.closeSubpath()
            }
            if let note = bar.note {
                let text = context.resolve(Text(note).font(.caption2).foregroundStyle(.secondary))
                context.draw(text, at: CGPoint(x: mid, y: top - 2), anchor: .bottom)
            }
        }
        for (opacity, path) in shades { context.fill(path, with: .color(color.opacity(opacity))) }
        context.fill(marks, with: .color(.secondary))

        // The goal or limit (or an average), dashed for a limit.
        var goalPath = Path()
        for goal in goals {
            goalPath.move(to: CGPoint(x: plot.x(goal.from), y: plot.y(goal.value)))
            goalPath.addLine(to: CGPoint(x: plot.x(goal.to), y: plot.y(goal.value)))
        }
        context.stroke(goalPath, with: .color(.secondary), style: StrokeStyle(lineWidth: 1, dash: dashedGoals ? [4, 3] : []))

        // The tapped bar: a faint line through it and its label at the top, kept inside the chart.
        if let picked {
            let mid = (plot.x(picked.from) + plot.x(picked.to)) / 2
            var line = Path()
            line.move(to: CGPoint(x: mid, y: plot.rect.minY))
            line.addLine(to: CGPoint(x: mid, y: plot.rect.maxY))
            context.stroke(line, with: .color(.secondary.opacity(0.3)), lineWidth: 1)
            let text = context.resolve(Text(picked.label).font(.caption.weight(.semibold)))
            let measured = text.measure(in: size)
            let box = CGSize(width: measured.width + 16, height: measured.height + 8)
            let left = min(max(0, mid - box.width / 2), max(0, size.width - box.width))
            let frame = CGRect(origin: CGPoint(x: left, y: 0), size: box)
            context.fill(RoundedRectangle(cornerRadius: 6).path(in: frame), with: .color(Color(.secondarySystemGroupedBackground)))
            context.draw(text, at: CGPoint(x: frame.midX, y: frame.midY), anchor: .center)
        }
    }
}

/// A line chart: a week's or month's running total (stepped, with the area under it and a dashed pace line), and the
/// 30-day rate.
struct LightLineChart: View {
    nonisolated struct Point: Identifiable, Sendable {
        let id: Int
        /// Across the chart, 0 to 1.
        let at: Double
        let value: Double
        /// What VoiceOver says for this point.
        let label: String
    }

    /// A straight dashed line, as the pace from 0 to the goal across the period.
    struct Guide {
        let from: (at: Double, value: Double)
        let to: (at: Double, value: Double)
    }

    let title: String
    let points: [Point]
    /// The value holds until the next point, then steps (a running total).
    var stepped = false
    var area = false
    var guide: Guide? = nil
    /// A fixed scale and grid lines (the rate: 0, 50, 100), instead of rounding up from the highest value.
    var fixed: (top: Double, ticks: [Double])? = nil
    var xLabels: [LightBarChart.XLabel] = []
    let color: Color
    var lineOpacity = 1.0
    let yLabel: (Double) -> String

    var body: some View {
        let highest = max(points.map(\.value).max() ?? 0, guide.map { max($0.from.value, $0.to.value) } ?? 0)
        let axis = ChartGrid.axis(highest)
        let grid = fixed.map { ChartGrid(top: $0.top, ticks: $0.ticks, yLabel: yLabel, hasXLabels: !xLabels.isEmpty) }
            ?? ChartGrid(top: axis.top, ticks: stride(from: 0, through: axis.top, by: axis.step).map { $0 }, yLabel: yLabel,
                         hasXLabels: !xLabels.isEmpty)
        Canvas { context, size in
            draw(in: &context, size: size, grid: grid)
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(title)
        .accessibilityChildren {
            ForEach(points) { point in
                Rectangle().accessibilityLabel(point.label)
            }
        }
        .accessibilityChartDescriptor(ChartDescriptor(title: title, labels: points.map(\.label), values: points.map(\.value)))
    }

    private func draw(in context: inout GraphicsContext, size: CGSize, grid: ChartGrid) {
        let plot = grid.plot(in: size)
        grid.drawLines(in: &context, size: size, plot: plot)
        grid.drawXLabels(xLabels, in: &context, plot: plot)

        var line = Path()
        for (i, point) in points.enumerated() {
            let spot = CGPoint(x: plot.x(point.at), y: plot.y(point.value))
            if i == 0 {
                line.move(to: spot)
            } else {
                if stepped { line.addLine(to: CGPoint(x: spot.x, y: line.currentPoint?.y ?? spot.y)) }
                line.addLine(to: spot)
            }
        }
        if area, let first = points.first, let last = points.last {
            var fill = line
            fill.addLine(to: CGPoint(x: plot.x(last.at), y: plot.rect.maxY))
            fill.addLine(to: CGPoint(x: plot.x(first.at), y: plot.rect.maxY))
            fill.closeSubpath()
            context.fill(fill, with: .color(color.opacity(0.12)))
        }
        context.stroke(line, with: .color(color.opacity(lineOpacity)), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))

        if let guide {
            var dashed = Path()
            dashed.move(to: CGPoint(x: plot.x(guide.from.at), y: plot.y(guide.from.value)))
            dashed.addLine(to: CGPoint(x: plot.x(guide.to.at), y: plot.y(guide.to.value)))
            context.stroke(dashed, with: .color(.secondary), style: StrokeStyle(lineWidth: 1, dash: [4, 3]))
        }
    }
}

// MARK: - Shared

/// The plot area inside the chart, and where a value or a place across it lands.
private struct ChartPlot {
    let rect: CGRect
    let top: Double
    func x(_ at: Double) -> CGFloat { rect.minX + CGFloat(at) * rect.width }
    func y(_ value: Double) -> CGFloat { rect.maxY - CGFloat(min(max(value, 0), top) / top) * rect.height }
}

/// The value scale, grid lines and their labels on the right, and the labels underneath, as Swift Charts draws them.
private struct ChartGrid {
    let top: Double
    let ticks: [Double]
    let yLabel: (Double) -> String
    let hasXLabels: Bool
    var roomAbove: CGFloat = 8

    /// Room for the widest value label, from its length (caption digits are about 6.5 points wide).
    var gutter: CGFloat { CGFloat(ticks.map { yLabel($0).count }.max() ?? 1) * 6.5 + 8 }

    func plot(in size: CGSize) -> ChartPlot {
        let bottom: CGFloat = hasXLabels ? 18 : 0
        return ChartPlot(rect: CGRect(x: 0, y: roomAbove, width: max(size.width - gutter, 1),
                                      height: max(size.height - roomAbove - bottom, 1)),
                         top: max(top, .leastNonzeroMagnitude))
    }

    func drawLines(in context: inout GraphicsContext, size: CGSize, plot: ChartPlot) {
        for tick in ticks {
            var line = Path()
            line.move(to: CGPoint(x: plot.rect.minX, y: plot.y(tick)))
            line.addLine(to: CGPoint(x: plot.rect.maxX, y: plot.y(tick)))
            context.stroke(line, with: .color(.secondary.opacity(0.25)), lineWidth: 0.5)
            let label = context.resolve(Text(yLabel(tick)).font(.caption2).foregroundStyle(.secondary))
            context.draw(label, at: CGPoint(x: size.width, y: plot.y(tick)), anchor: .trailing)
        }
    }

    func drawXLabels(_ labels: [LightBarChart.XLabel], in context: inout GraphicsContext, plot: ChartPlot) {
        for label in labels {
            let text = context.resolve(Text(label.text).font(.caption2).foregroundStyle(.secondary))
            context.draw(text, at: CGPoint(x: plot.x(label.at), y: plot.rect.maxY + 3), anchor: .top)
        }
    }

    /// A round top and step, three to five grid lines: 0, 2, 4, 6, 8 for a goal of 8.
    static func axis(_ highest: Double) -> (top: Double, step: Double) {
        guard highest > 0 else { return (1, 1) }
        let rough = highest / 4
        let magnitude = pow(10, log10(rough).rounded(.down))
        let step = [1, 2, 2.5, 5, 10].map { $0 * magnitude }.first { $0 >= rough } ?? 10 * magnitude
        return ((highest / step).rounded(.up) * step, step)
    }
}

/// Audio Graphs and the data table for VoiceOver, as Swift Charts gave them.
private nonisolated struct ChartDescriptor: AXChartDescriptorRepresentable {
    let title: String
    let labels: [String]
    let values: [Double]

    func makeChartDescriptor() -> AXChartDescriptor {
        let x = AXCategoricalDataAxisDescriptor(title: "Period", categoryOrder: labels)
        let highest = max(values.max() ?? 0, 1)
        let y = AXNumericDataAxisDescriptor(title: "Value", range: 0...highest, gridlinePositions: []) { "\($0)" }
        let series = AXDataSeriesDescriptor(name: title, isContinuous: false,
                                            dataPoints: zip(labels, values).map { AXDataPoint(x: $0, y: $1) })
        return AXChartDescriptor(title: title, summary: nil, xAxis: x, yAxis: y, additionalAxes: [], series: [series])
    }
}
