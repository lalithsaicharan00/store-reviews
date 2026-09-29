import Charts
import SwiftUI

/// An amount or timed habit's last 30 days on its page: a bar per day, the goal as a line that steps where an edit
/// changed it (spec §9: the chart stays continuous for the same unit; days in an older unit are left out), and the
/// average and best above it (users ask for totals and averages in their own units, not only percentages: C047).
struct HabitAmountChart: View {
    let habit: Habit
    let stats: HabitStats
    @State private var selected: Date?

    private struct Day: Identifiable {
        let id: LocalDay
        let date: Date
        let value: Double
        let goal: Double?
    }

    private var timed: Bool { habit.kind == .duration }
    private var unit: String { HabitCopy.unit(of: habit) }

    private func text(_ value: Double) -> String { timed ? Format.minutes(value) : HabitCopy.amount(value, unit) }

    private var series: [Day] {
        let store = stats.store
        let calendar = store.calendar
        let first = max(store.startDay(of: habit), stats.today.adding(days: -29, calendar: calendar), stats.unitSince(habit) ?? .init(year: 1, month: 1, day: 1))
        guard first <= stats.today else { return [] }
        return HabitStats.days(in: first...stats.today, calendar: calendar).map { day in
            let rule = store.rule(habit, on: day)
            return Day(id: day, date: day.date(calendar: calendar), value: stats.logged(habit, on: day),
                       goal: rule.frequency.isDayBased ? rule.goal : nil)
        }
    }

    var body: some View {
        let days = series
        let logged = days.filter { $0.value > 0 }
        let point = selected.flatMap { date in days.first { stats.store.calendar.isDate($0.date, inSameDayAs: date) } }
        VStack(alignment: .leading, spacing: 8) {
            if let point {
                Text("\(point.date.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated))): \(text(point.value))")
                    .font(.caption).foregroundStyle(.secondary).monospacedDigit()
            } else if !logged.isEmpty {
                let average = logged.reduce(0) { $0 + $1.value } / Double(logged.count)
                Text("Average \(text(average)) on the days you logged it · best \(text(logged.map(\.value).max() ?? 0))")
                    .font(.caption).foregroundStyle(.secondary).monospacedDigit()
            } else {
                Text("Nothing logged in the last 30 days.").font(.caption).foregroundStyle(.secondary)
            }
            Chart {
                ForEach(days) { day in
                    BarMark(x: .value("Date", day.date, unit: .day), y: .value("Logged", day.value))
                        .foregroundStyle(habit.color.color.opacity(point == nil || point?.id == day.id ? 1 : 0.35))
                        .cornerRadius(2)
                        .accessibilityLabel(day.date.formatted(.dateTime.weekday(.wide).day().month(.wide)))
                        .accessibilityValue(text(day.value))
                }
                ForEach(days.filter { $0.goal != nil }) { day in
                    LineMark(x: .value("Date", day.date, unit: .day), y: .value("Goal", day.goal ?? 0))
                        .interpolationMethod(.stepCenter)
                        .foregroundStyle(Color.secondary)
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [3, 3]))
                        .accessibilityHidden(true)
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .day, count: 7)) { _ in AxisValueLabel(format: .dateTime.day().month(.abbreviated)) }
            }
            .chartXSelection(value: $selected)
            .frame(height: 140)
        }
        .padding(.vertical, 4)
    }
}
