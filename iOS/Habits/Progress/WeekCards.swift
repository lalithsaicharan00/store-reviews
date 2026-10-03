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
                HeatYear(layout: year, cells: card.days.prefix(year.shown).map(\.heat), color: card.habit.color)
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

/// A month on a card (the user, 2 Oct 2026: for seeing patterns): rows of squares under the weekday letters (today's
/// underlined). No dates inside (the user, 3 Oct 2026): the sign says what happened; the habit's page has the dated
/// calendar. One `Canvas`, never a lazy grid (Design Rules).
struct MonthCardGrid: View {
    let layout: MonthLayout
    let columns: [WeekColumn]
    let days: [WeekCardDay]
    let color: HabitColor

    var body: some View {
        let todayIndex = columns.firstIndex { $0.isToday }
        let todayColumn = todayIndex.map { (layout.lead + $0) % 7 }
        VStack(spacing: WeekSpacing.tight) {
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
            HeatMonth(lead: layout.lead, cells: days.map(\.heat), todayIndex: todayIndex, color: color)
                .equatable()
        }
        .accessibilityHidden(true)
    }
}

/// Sun–Sat (in the person's order): the weekday, then the day's square. The day's own amount is in the card's words
/// and the habit's page, not on the square (the user, 3 Oct 2026).
struct WeekCardStrip: View {
    let columns: [WeekColumn]
    let days: [WeekCardDay]
    let color: HabitColor

    var body: some View {
        VStack(spacing: WeekSpacing.tight) {
            HStack(spacing: 0) {
                ForEach(columns) { column in
                    Text(column.short)
                        .font(.caption.weight(column.isToday ? .semibold : .regular))
                        .foregroundStyle(column.isToday ? Color.primary : Color.secondary)
                        .underline(column.isToday)
                        .lineLimit(1).minimumScaleFactor(0.8)
                        .frame(maxWidth: .infinity)
                }
            }
            HeatRow(cells: days.map(\.heat), todayIndex: columns.firstIndex { $0.isToday }, color: color)
                .equatable()
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
