import Accessibility
import SwiftUI

/// A bar chart drawn in one `Canvas` pass: bars, goal lines, the ▲ over a limit, grid lines and axis labels.
///
/// Swift Charts' first layout of the habit page's Over Time chart was most of a 1-second freeze the first time the
/// page scrolled to it, and no single option was to blame (bisect runs, 1 Oct 2026: selection, either axis and the
/// date bins each took off part of it). The same picture drawn here is one view with no layout of its own
/// (PERFORMANCE.md rule 12). VoiceOver reads each bar, and Audio Graphs and the data table come from the chart
/// descriptor, as with Swift Charts.
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

    private static let top: CGFloat = 8
    private static let labelRow: CGFloat = 18

    var body: some View {
        let axis = Self.axis(max(bars.map(\.value).max() ?? 0, goals.map(\.value).max() ?? 0))
        let ticks = stride(from: 0, through: axis.top, by: axis.step).map { $0 }
        let gutter = Self.gutter(ticks.map(yLabel))
        let picked = chosen?.wrappedValue.flatMap { id in bars.first { $0.id == id } }
        Canvas { context, size in
            draw(in: &context, size: size, axis: axis, ticks: ticks, gutter: gutter, picked: picked)
        }
        .onGeometryChange(for: CGFloat.self) { $0.size.width } action: { width = $0 }
        .contentShape(Rectangle())
        .onTapGesture(coordinateSpace: .local) { location in
            guard let chosen else { return }
            let plot = max(width - gutter, 1)
            let at = Double(location.x / plot)
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
        .accessibilityChartDescriptor(ChartDescriptor(title: title, bars: bars))
    }

    // MARK: Drawing

    private func draw(in context: inout GraphicsContext, size: CGSize, axis: (top: Double, step: Double),
                      ticks: [Double], gutter: CGFloat, picked: Bar?) {
        let bottom = xLabels.isEmpty ? 0 : Self.labelRow
        let plot = CGRect(x: 0, y: Self.top, width: max(size.width - gutter, 1),
                          height: max(size.height - Self.top - bottom, 1))
        func x(_ at: Double) -> CGFloat { plot.minX + CGFloat(at) * plot.width }
        func y(_ value: Double) -> CGFloat { plot.maxY - CGFloat(value / axis.top) * plot.height }

        // Grid lines, with their values on the right, as Swift Charts draws them.
        for tick in ticks {
            var line = Path()
            line.move(to: CGPoint(x: plot.minX, y: y(tick)))
            line.addLine(to: CGPoint(x: plot.maxX, y: y(tick)))
            context.stroke(line, with: .color(.secondary.opacity(0.25)), lineWidth: 0.5)
            let label = context.resolve(Text(yLabel(tick)).font(.caption2).foregroundStyle(.secondary))
            context.draw(label, at: CGPoint(x: size.width, y: y(tick)), anchor: .trailing)
        }

        // Bars: one path per shade, so a month of bars is a few fills.
        var shades: [Double: Path] = [:]
        var marks = Path()
        for bar in bars {
            let left = x(bar.from), right = x(bar.to)
            let gap = min(2, (right - left) * 0.2)
            let topY = y(bar.value)
            shades[bar.opacity, default: Path()].addRect(CGRect(x: left + gap / 2, y: topY,
                                                                width: max(right - left - gap, 1), height: plot.maxY - topY))
            if bar.over {
                let mid = (left + right) / 2
                marks.move(to: CGPoint(x: mid - 3, y: topY - 1))
                marks.addLine(to: CGPoint(x: mid + 3, y: topY - 1))
                marks.addLine(to: CGPoint(x: mid, y: topY - 6))
                marks.closeSubpath()
            }
        }
        for (opacity, path) in shades { context.fill(path, with: .color(color.opacity(opacity))) }
        context.fill(marks, with: .color(.secondary))

        // The goal or limit, dashed for a limit.
        var goalPath = Path()
        for goal in goals {
            goalPath.move(to: CGPoint(x: x(goal.from), y: y(goal.value)))
            goalPath.addLine(to: CGPoint(x: x(goal.to), y: y(goal.value)))
        }
        context.stroke(goalPath, with: .color(.secondary), style: StrokeStyle(lineWidth: 1, dash: dashedGoals ? [4, 3] : []))

        // Labels under the chart.
        for label in xLabels {
            let text = context.resolve(Text(label.text).font(.caption2).foregroundStyle(.secondary))
            context.draw(text, at: CGPoint(x: x(label.at), y: plot.maxY + 3), anchor: .top)
        }

        // The tapped bar: a faint line through it and its label at the top, kept inside the chart.
        if let picked {
            let mid = (x(picked.from) + x(picked.to)) / 2
            var line = Path()
            line.move(to: CGPoint(x: mid, y: plot.minY))
            line.addLine(to: CGPoint(x: mid, y: plot.maxY))
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

    // MARK: Scale

    /// A round top and step, three to five grid lines: 0, 2, 4, 6, 8 for a goal of 8.
    static func axis(_ highest: Double) -> (top: Double, step: Double) {
        guard highest > 0 else { return (1, 1) }
        let rough = highest / 4
        let magnitude = pow(10, (log10(rough)).rounded(.down))
        let step = [1, 2, 2.5, 5, 10].map { $0 * magnitude }.first { $0 >= rough } ?? 10 * magnitude
        return ((highest / step).rounded(.up) * step, step)
    }

    /// Room for the widest value label, worked out from its length (the caption digits are about 6.5 points wide).
    private static func gutter(_ labels: [String]) -> CGFloat {
        CGFloat(labels.map(\.count).max() ?? 1) * 6.5 + 8
    }
}

/// Audio Graphs and the data table for VoiceOver, as Swift Charts gave them.
private nonisolated struct ChartDescriptor: AXChartDescriptorRepresentable {
    let title: String
    let bars: [LightBarChart.Bar]

    func makeChartDescriptor() -> AXChartDescriptor {
        let x = AXCategoricalDataAxisDescriptor(title: "Period", categoryOrder: bars.map(\.label))
        let highest = max(bars.map(\.value).max() ?? 0, 1)
        let y = AXNumericDataAxisDescriptor(title: "Value", range: 0...highest, gridlinePositions: []) { "\($0)" }
        let series = AXDataSeriesDescriptor(name: title, isContinuous: false,
                                            dataPoints: bars.map { AXDataPoint(x: $0.label, y: $0.value) })
        return AXChartDescriptor(title: title, summary: nil, xAxis: x, yAxis: y, additionalAxes: [], series: [series])
    }
}
