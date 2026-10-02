import SwiftUI

// The Week view's pieces (report "Weekly Habit Cards — What Each Card Shows"; the user, 2 Oct 2026). Every number
// comes from the snapshot; nothing here walks history or builds a formatter (PERFORMANCE.md rules 5 and 8).
//
// Spacing, on an 8-point grid, with space inside a group always smaller than the space around it (proximity):
//   2   name ↔ goal (one label)              4   headline ↔ detail, mark ↔ its value
//   8   tabs ↔ dates, weekday ↔ mark          16  card padding, gap between cards, header ↔ numbers, numbers ↔ strip
//   24  the controls above ↔ the first card
enum WeekSpacing {
    static let label: CGFloat = 2
    static let pair: CGFloat = 4
    static let tight: CGFloat = 8
    static let card: CGFloat = 16
    static let section: CGFloat = 24
    /// A day's square on Week's strip: large enough for the day's number.
    static let mark: CGFloat = 40
}

/// The dates of the week (or the month), with ‹ and ›. The one part of the page that stays at the top while the cards scroll: the
/// dates say which week every card shows, and ‹ › are how weeks are compared (report §3). Week, Month, Year and the
/// group chips scroll away, so the bar is one 44-point row (NN/g: keep a sticky header small).
struct WeekPeriodBar: View {
    let title: String
    let caption: String?
    var noun = "week"
    let canGoBack: Bool
    let canGoForward: Bool
    let move: (Int) -> Void

    var body: some View {
        HStack(spacing: 0) {
            Button("Previous \(noun)", systemImage: "chevron.left") { move(-1) }
                .labelStyle(.iconOnly)
                .frame(width: 44, height: 44)
                .disabled(!canGoBack)
                .accessibilityIdentifier("progress-previous")
            Spacer(minLength: WeekSpacing.tight)
            VStack(spacing: 0) {
                Text(title).font(.headline).monospacedDigit().lineLimit(1).minimumScaleFactor(0.8)
                    .accessibilityIdentifier("progress-period")
                if let caption {
                    Text(caption).font(.caption).foregroundStyle(.secondary)
                        .accessibilityIdentifier("progress-period-caption")
                }
            }
            Spacer(minLength: WeekSpacing.tight)
            Button("Next \(noun)", systemImage: "chevron.right") { move(1) }
                .labelStyle(.iconOnly)
                .frame(width: 44, height: 44)
                .disabled(!canGoForward)
                .accessibilityIdentifier("progress-next")
        }
        .buttonStyle(.borderless)
        .font(.body.weight(.semibold))
        .padding(.horizontal, WeekSpacing.tight)
        .padding(.vertical, WeekSpacing.pair)
        .frame(maxWidth: .infinity)
        // Opaque, the page's own colour: cards slide under it cleanly.
        .background(Color(.systemGroupedBackground))
    }
}

/// One habit's card: icon, name on one line, the goal; the headline and at most one more fact; the week's strip.
struct WeekCardView: View {
    let card: ProgressWeekCard
    let columns: [WeekColumn]
    /// Month: the grid's layout; nil on Week.
    var month: MonthLayout? = nil
    /// Year: the heat map's layout; nil on Week and Month.
    var year: YearLayout? = nil
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 12) {
                HabitIcon(symbol: card.habit.symbol, color: card.habit.color, size: 40)
                VStack(alignment: .leading, spacing: WeekSpacing.label) {
                    // One line: a long name ends in "…" (the user, 2 Oct 2026).
                    Text(card.habit.name).font(.headline).foregroundStyle(.primary)
                        .lineLimit(1).truncationMode(.tail)
                    Text(card.goal).font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
                }
                Spacer(minLength: WeekSpacing.tight)
                Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
                    .accessibilityHidden(true)
            }
            VStack(alignment: .leading, spacing: WeekSpacing.pair) {
                if let start = card.runStart {
                    QuitRunClock(start: start)
                } else {
                    Text(card.headline).font(.title3.weight(.semibold)).monospacedDigit()
                        .fixedSize(horizontal: false, vertical: true)
                }
                if let detail = card.detail {
                    Text(detail).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.top, WeekSpacing.card)
            // From the accessibility sizes up, the strip gives way to the words, which carry the meaning (report §9).
            if let year, !typeSize.isAccessibilitySize, card.days.count >= year.shown {
                HeatYearGrid(layout: year, cells: card.days.prefix(year.shown).map(\.heat), color: card.habit.color)
                    .padding(.top, WeekSpacing.card)
            } else if !typeSize.isAccessibilitySize && columns.count == card.days.count {
                if let month {
                    MonthCardGrid(layout: month, columns: columns, days: card.days, color: card.habit.color)
                        .padding(.top, WeekSpacing.card)
                } else {
                    WeekCardStrip(columns: columns, days: card.days, color: card.habit.color)
                        .padding(.top, WeekSpacing.card)
                }
            }
        }
        .padding(WeekSpacing.card)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.card, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(card.accessibility)
        .accessibilityHint("Opens the habit")
        .accessibilityAddTraits(.isButton)
    }
}

/// How a month sits in its grid: the empty places before the 1st, and the weekday letters in the person's order.
struct MonthLayout: Hashable {
    let lead: Int
    let letters: [String]
}

/// A month on a card (the user, 2 Oct 2026: for seeing patterns): a calendar of squares with the date in each, the
/// weekday letters once at the top (today's underlined). Plain stacks of fixed-size cells, never a lazy grid (Design
/// Rules).
struct MonthCardGrid: View {
    let layout: MonthLayout
    let columns: [WeekColumn]
    let days: [WeekCardDay]
    let color: HabitColor

    var body: some View {
        let rows = (layout.lead + days.count + 6) / 7
        let todayColumn = columns.firstIndex { $0.isToday }.map { (layout.lead + $0) % 7 }
        VStack(spacing: MonthCardGrid.rowGap) {
            HStack(spacing: 0) {
                ForEach(0..<7, id: \.self) { i in
                    let isToday = i == todayColumn
                    Text(i < layout.letters.count ? layout.letters[i] : "")
                        .font(.caption.weight(isToday ? .semibold : .medium))
                        .foregroundStyle(isToday ? Color.primary : Color.secondary)
                        .underline(isToday)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, WeekSpacing.pair)
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<7, id: \.self) { column in
                        cell(row * 7 + column - layout.lead)
                    }
                }
            }
        }
        .accessibilityHidden(true)
    }

    @ViewBuilder private func cell(_ index: Int) -> some View {
        if index >= 0 && index < days.count {
            let day = days[index]
            ZStack {
                if case .blank = day.heat {
                    // A day still to come: its date only, so the month still reads as a calendar.
                    Text("\(day.day.day)").font(.system(size: 11, weight: .medium)).foregroundStyle(.tertiary)
                } else {
                    HeatSquare(cell: day.heat, color: color, size: MonthCardGrid.square, text: "\(day.day.day)",
                               isToday: index < columns.count && columns[index].isToday)
                }
            }
            .frame(maxWidth: .infinity).frame(height: MonthCardGrid.square)
        } else {
            Color.clear.frame(maxWidth: .infinity).frame(height: MonthCardGrid.square)
        }
    }

    static let square: CGFloat = 32
    static let rowGap: CGFloat = 7
}

/// Sun–Sat (in the person's order): the weekday, then the day's square with its own number inside ("8", "25m", "3/4").
struct WeekCardStrip: View {
    let columns: [WeekColumn]
    let days: [WeekCardDay]
    let color: HabitColor

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            ForEach(Array(days.enumerated()), id: \.element.id) { index, day in
                let column = columns[index]
                VStack(spacing: WeekSpacing.tight) {
                    Text(column.short)
                        .font(.caption.weight(column.isToday ? .semibold : .regular))
                        .foregroundStyle(column.isToday ? Color.primary : Color.secondary)
                        .underline(column.isToday)
                        .lineLimit(1).minimumScaleFactor(0.8)
                    HeatSquare(cell: day.heat, color: color, size: WeekSpacing.mark, text: day.value, isToday: column.isToday)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .accessibilityHidden(true)
    }
}

extension HabitColor {
    /// The habit's colour for marks and icons, all at one lightness (the user, 2 Oct 2026: every colour should feel
    /// equally strong; orange and green looked darker than purple). Each system colour is moved to OKLCH lightness 0.64,
    /// keeping its hue and as much of its saturation as fits the screen, so none turns muddy (mixing in black did).
    /// 0.64 is the lightest level at which a white check still reaches 3:1 (WCAG 1.4.11) on every colour; light and
    /// dark mode land on nearly the same values, so one table serves both. Worked out once (Research/Temp, 2 Oct 2026),
    /// never while drawing. Yellow at this lightness is a mustard: that's yellow at the same strength as the rest.
    var mark: Color { Self.marks[self] ?? color }

    private static let marks: [HabitColor: Color] = [
        .red: hex(0xFA352B), .orange: hex(0xC97505), .yellow: hex(0xAA8809), .green: hex(0x07A941),
        .mint: hex(0x09A19A), .teal: hex(0x079DB4), .cyan: hex(0x0698D0), .blue: hex(0x3289FF),
        .indigo: hex(0x7679FC), .purple: hex(0xB75AE7), .pink: hex(0xFB2852), .brown: hex(0xA48660),
        .gray: hex(0x8B8B90),
    ]

    private static func hex(_ v: Int) -> Color {
        Color(.sRGB, red: Double(v >> 16 & 0xFF) / 255, green: Double(v >> 8 & 0xFF) / 255, blue: Double(v & 0xFF) / 255)
    }
}
