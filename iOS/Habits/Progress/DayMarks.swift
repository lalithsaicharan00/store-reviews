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
        HStack(spacing: 0) {
            Spacer(minLength: 0)
            ForEach(days, id: \.self) { day in
                Text(calendar.veryShortStandaloneWeekdaySymbols[calendar.component(.weekday, from: day.date(calendar: calendar)) - 1])
                    .font(.caption2.weight(.semibold)).foregroundStyle(.secondary)
                    .frame(width: WeekStrip.column)
            }
        }
        .accessibilityHidden(true)
    }
}

/// A month of dots on one line, drawn in one `Canvas` (hundreds of small views would slow the list; report §20).
/// Done is filled; part done is lighter by share; not done is an empty ring; today not done yet is dashed; other days
/// are blank, so the strip shows the person's real plan (§13.3).
struct MonthStrip: View {
    let marks: [ProgressMark]
    let color: Color

    var body: some View {
        Canvas { context, size in
            let count = CGFloat(max(marks.count, 1))
            let gap: CGFloat = 2.5
            let dot = max(3, min(7, (size.width - gap * (count - 1)) / count))
            let y = (size.height - dot) / 2
            for (i, mark) in marks.enumerated() {
                let rect = CGRect(x: CGFloat(i) * (dot + gap), y: y, width: dot, height: dot)
                let circle = Path(ellipseIn: rect)
                switch mark.mark {
                case .done:
                    context.fill(circle, with: .color(color))
                case .some:
                    context.fill(circle, with: .color(color.opacity(mark.fraction >= 0.5 ? 0.7 : 0.45)))
                case .missed:
                    context.stroke(Path(ellipseIn: rect.insetBy(dx: 0.5, dy: 0.5)), with: .style(HierarchicalShapeStyle.secondary), lineWidth: 1)
                case .open:
                    context.stroke(Path(ellipseIn: rect.insetBy(dx: 0.5, dy: 0.5)), with: .style(HierarchicalShapeStyle.secondary),
                                   style: StrokeStyle(lineWidth: 1, dash: [1.5, 1.5]))
                default:
                    break
                }
            }
        }
        .frame(height: 8)
        .accessibilityHidden(true)
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
