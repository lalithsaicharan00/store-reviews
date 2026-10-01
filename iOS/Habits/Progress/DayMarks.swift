import SwiftUI

/// A day's ring: what's done of what was planned, in ink, with the date inside (report §7.2, §17.7). One drawing for
/// Today's calendar sheet and Progress's overview. Part credit fills it part of the way; a day with nothing planned has
/// no ring; later days show a faint track.
struct DayRing: View {
    let fraction: Double
    let planned: Bool
    let isFuture: Bool
    let label: String
    var bold = false
    var selected = false
    /// Everything planned was done: a small check at the top right.
    var full = false

    var body: some View {
        ZStack {
            // A circle, like the rings: every shape in a calendar is round (Design Rules).
            Circle().fill(selected ? Color(.secondarySystemFill) : .clear)
            if planned {
                Circle().stroke(Color.ink.opacity(isFuture ? 0.07 : 0.12), lineWidth: 3)
                if !isFuture && fraction > 0 {
                    Circle().trim(from: 0, to: min(1, fraction))
                        .stroke(Color.ink, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                }
            }
            Text(label).font(.callout.weight(bold ? .bold : .medium))
                .foregroundStyle(isFuture ? Color.secondary : Color.ink)
        }
        .frame(width: 38, height: 38)
        .overlay(alignment: .topTrailing) {
            if full && !isFuture {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 11, weight: .bold)).foregroundStyle(Color.ink)
                    .background(Circle().fill(Color(.systemBackground)))
                    .offset(x: 2, y: -2)
            }
        }
    }
}

/// One day's mark in a habit's strip or a list (report §13.1). Every state differs by shape, not only colour: filled,
/// part-filled ring, empty ring, dashed ring, a sign, or nothing. Never red.
struct DayMarkView: View {
    let mark: HabitStore.DayMark
    var fraction: Double = 0
    /// A limit's day that went over: an empty ring with a small ▲.
    var over = false
    let color: Color
    var size: CGFloat = 14

    var body: some View {
        ZStack {
            switch mark {
            case .done:
                Circle().fill(color)
            case .some:
                Circle().stroke(color.opacity(0.3), lineWidth: 1.5)
                Circle().trim(from: 0, to: max(0.08, min(1, fraction)))
                    .stroke(color, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    .rotationEffect(.degrees(-90))
            case .missed:
                Circle().strokeBorder(Color.secondary, lineWidth: 1)
                if over {
                    Image(systemName: "arrowtriangle.up.fill").font(.system(size: size * 0.4)).foregroundStyle(.secondary)
                }
            case .open:
                Circle().strokeBorder(Color.secondary, style: StrokeStyle(lineWidth: 1, dash: [2, 2]))
            case .skipped:
                Image(systemName: "forward.fill").font(.system(size: size * 0.45)).foregroundStyle(.secondary)
            case .paused:
                Image(systemName: "pause.fill").font(.system(size: size * 0.45)).foregroundStyle(.secondary)
            case .upcoming:
                Circle().fill(color.opacity(0.35)).frame(width: size * 0.3, height: size * 0.3)
            case .notItsDay, .before:
                Color.clear
            }
        }
        .frame(width: size, height: size)
        .accessibilityHidden(true)
    }
}

/// A week of marks in fixed 18-point columns, trailing in a Progress row (report §7.3).
struct WeekStrip: View {
    let marks: [ProgressMark]
    let color: Color

    var body: some View {
        HStack(spacing: 0) {
            ForEach(marks) { mark in
                DayMarkView(mark: mark.mark, fraction: mark.fraction, over: mark.over, color: color)
                    .frame(width: WeekStrip.column)
            }
        }
        .accessibilityHidden(true)
    }

    static let column: CGFloat = 18
}

/// The weekday initials over the week strips, in the person's week order.
struct WeekStripHeader: View {
    let days: [LocalDay]
    let calendar: Calendar

    var body: some View {
        let names = calendar.veryShortStandaloneWeekdaySymbols
        HStack(spacing: 0) {
            Spacer(minLength: 0)
            ForEach(days, id: \.self) { day in
                Text(names[day.weekday(calendar: calendar) - 1])
                    .font(.caption2.weight(.semibold)).foregroundStyle(.secondary)
                    .frame(width: WeekStrip.column)
            }
        }
        .accessibilityHidden(true)
    }
}

/// A month of dots on one line (report §7.3, §13.3). Done is filled; part done is lighter by share; not done is an
/// empty ring; today not done yet is dashed; other days are blank, so the strip shows the person's real plan.
///
/// Plain shapes flattened into one layer (`drawingGroup`), not a `Canvas`: with a `Canvas` here the app was lost as
/// soon as the Month range opened (CI, 30 Sep 2026; a `Canvas` renderer closure is main-actor code under Swift 6's
/// default isolation). Rows are in a lazy list, so only the strips on screen exist.
struct MonthStrip: View {
    let marks: [ProgressMark]
    let color: Color

    var body: some View {
        // Fixed sizes, so the row's height never depends on its width (a list re-measures rows that do): 31 dots of
        // 5.5 points with 2.5-point gaps fit the narrowest iPhone.
        HStack(spacing: 2.5) {
            ForEach(marks) { mark in
                dot(mark).frame(width: 5.5, height: 5.5)
            }
            Spacer(minLength: 0)
        }
        .frame(height: 8)
        .drawingGroup()
        .accessibilityHidden(true)
    }

    @ViewBuilder private func dot(_ mark: ProgressMark) -> some View {
        switch mark.mark {
        case .done: Circle().fill(color)
        case .some: Circle().fill(color.opacity(mark.fraction >= 0.5 ? 0.7 : 0.45))
        case .missed: Circle().strokeBorder(Color.secondary, lineWidth: 1)
        case .open: Circle().strokeBorder(Color.secondary, style: StrokeStyle(lineWidth: 1, dash: [1.5, 1.5]))
        default: Color.clear
        }
    }
}

/// One habit on one day, with its mark and value: the Day sheet's rows and the habit page's day popover (report §7.4,
/// §8.2). Read-only.
struct DayDetailRow: View {
    let row: ProgressDayRow

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            DayMarkView(mark: row.mark, fraction: row.fraction, over: row.atMost && row.mark == .missed,
                        color: row.habit.color.color, size: 16)
                .frame(width: 22, height: 22)
            VStack(alignment: .leading, spacing: 2) {
                Text(row.habit.name).lineLimit(2)
                Text(row.value).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                if let note = row.note {
                    Text(note).font(.footnote).foregroundStyle(.secondary).lineLimit(4)
                        .padding(.top, 2)
                }
            }
            Spacer(minLength: 0)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(row.habit.name), \(row.value)" + (row.note.map { ". Note: \($0)" } ?? ""))
    }
}

/// Dots at grid cells (column × 7 + row), as one path: a whole year draws as four shapes, not hundreds of views
/// (report §20). Plain values only, so the shape is safe to draw wherever SwiftUI draws it.
nonisolated struct DotCells: Shape {
    let cells: [Int]
    let dot: CGFloat
    let gap: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for cell in cells {
            let x = CGFloat(cell / 7) * (dot + gap), y = CGFloat(cell % 7) * (dot + gap)
            path.addEllipse(in: CGRect(x: x, y: y, width: dot, height: dot))
        }
        return path
    }
}

/// A year of round dots (report §7.2, §8.4, §13.3): weeks in columns, weekdays down; month letters above, and
/// optionally M, W, F on the left. Tapping a month calls `onMonth`. Days with nothing planned have no dot.
struct YearGridView: View {
    let dots: YearDots
    let color: Color
    var dot: CGFloat = 4.5
    var gap: CGFloat = 1.5
    var labels = false
    var onMonth: ((LocalDay) -> Void)? = nil
    @Environment(HabitStore.self) private var store

    private var step: CGFloat { dot + gap }

    var body: some View {
        let width = CGFloat(dots.columns) * step
        HStack(alignment: .top, spacing: 4) {
            if labels {
                // Weekday letters for rows 0, 2 and 4 (M, W, F with a Monday week start).
                VStack(alignment: .trailing, spacing: 0) {
                    Color.clear.frame(height: 12)
                    ForEach(0..<7, id: \.self) { row in
                        Text(row % 2 == 0 && row < 6 ? letter(row) : "")
                            .font(.system(size: max(7, step * 0.9))).foregroundStyle(.secondary)
                            .frame(height: step)
                    }
                }
                .accessibilityHidden(true)
            }
            VStack(alignment: .leading, spacing: 2) {
                ZStack(alignment: .topLeading) {
                    ForEach(dots.months) { month in
                        Text(month.first.date(calendar: store.calendar).formatted(.dateTime.month(.narrow)))
                            .font(.system(size: 9, weight: .semibold)).foregroundStyle(.secondary)
                            .offset(x: CGFloat(month.column) * step)
                    }
                }
                .frame(width: width, height: 10, alignment: .topLeading)
                .accessibilityHidden(true)
                ZStack(alignment: .topLeading) {
                    DotCells(cells: dots.full, dot: dot, gap: gap).fill(color)
                    DotCells(cells: dots.high, dot: dot, gap: gap).fill(color.opacity(0.7))
                    DotCells(cells: dots.low, dot: dot, gap: gap).fill(color.opacity(0.45))
                    DotCells(cells: dots.ring, dot: dot, gap: gap).stroke(Color.secondary, lineWidth: 0.8)
                    if let onMonth {
                        // A month column is the tap target: a dot is too small to tap (report §21).
                        HStack(spacing: 0) {
                            ForEach(Array(dots.months.enumerated()), id: \.element.id) { i, month in
                                let next = i + 1 < dots.months.count ? dots.months[i + 1].column : dots.columns
                                Button { onMonth(month.first) } label: { Color.clear.contentShape(Rectangle()) }
                                    .buttonStyle(.plain)
                                    .frame(width: CGFloat(max(1, next - month.column)) * step)
                                    .accessibilityLabel(month.first.date(calendar: store.calendar).formatted(.dateTime.month(.wide)))
                                    .accessibilityHint("Opens the month")
                                    .accessibilityIdentifier("year-month-\(month.month)")
                            }
                        }
                        .offset(x: CGFloat(dots.months.first?.column ?? 0) * step)
                    }
                }
                .frame(width: width, height: 7 * step, alignment: .topLeading)
            }
        }
    }

    private func letter(_ row: Int) -> String {
        let calendar = store.calendar
        let symbols = calendar.veryShortStandaloneWeekdaySymbols
        return symbols[(calendar.firstWeekday - 1 + row) % 7]
    }
}
