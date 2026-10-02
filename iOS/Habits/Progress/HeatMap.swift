import SwiftUI

// Progress's heat map (the user, 2 Oct 2026): one square per day, the same in Week, Month and Year; only the size
// changes. Colour strength is how much of what the day asked for was done (`HeatCell`, worked out in the store):
//   grey            asked and not done (today stays grey, ringed, until something is logged)
//   five steps      up to a third, up to two thirds, more, the goal met (the habit's own colour), more than the goal
//   dashed outline  nothing asked that day: not scheduled, skipped or paused (Week and Month show the sign)
//   nothing         before the habit began, or a day still to come
// Research behind it (report "Day Marks — Heat Map, Rule and Palette", 2 Oct 2026): heat maps are the most praised way to show days across 1.2 million
// reviews in every language; people want the whole year at once, dates, skips that aren't failures, and shades by
// amount. Squares and the grid are drawn from the store's numbers only (PERFORMANCE.md rules 5, 8 and 12).

/// Grey and the five steps of every habit colour, light and dark. Each step sits at one OKLCH lightness for every hue
/// (light: 0.855, 0.78, 0.71, 0.64 = the habit's own colour, 0.52; dark: 0.415, 0.49, 0.565, 0.64, 0.76), so no colour's
/// steps look stronger than another's. Measured (the report's `Day Marks Evidence/scripts/make.py`): neighbouring steps differ by at least
/// 0.07 in OKLab, about 3.5 times the smallest visible difference, and by at least 0.043 under every colour-vision
/// deficiency; numbers on a square reach 4.3:1. "Gray" habits get a cool slate tint so their steps never read as the
/// not-done grey.
enum HeatPalette {
    static func color(_ level: Int, _ habit: HabitColor, dark: Bool) -> Color {
        guard level > 0 else { return hex(dark ? 0x2C2C2E : 0xEBEBF0) }
        let steps = table[habit] ?? table[.green]!
        return hex((dark ? steps.dark : steps.light)[min(5, level) - 1])
    }

    /// The number on a square: black or white, whichever reads better on that step.
    static func ink(_ level: Int, dark: Bool) -> Color {
        if level == 0 { return dark ? Color(white: 0.6) : Color(white: 0.45) }
        if dark { return level >= 5 ? Color(white: 0.11) : .white }
        return level >= 4 ? .white : Color(white: 0.11)
    }

    static let notDone = (light: 0xEBEBF0, dark: 0x2C2C2E)
    static let dash = (light: 0xB8B8BE, dark: 0x5A5A5E)

    static func hex(_ v: Int) -> Color {
        Color(.sRGB, red: Double(v >> 16 & 0xFF) / 255, green: Double(v >> 8 & 0xFF) / 255, blue: Double(v & 0xFF) / 255)
    }

    private static let table: [HabitColor: (light: [Int], dark: [Int])] = [
        .red: ([0xFFBDB2, 0xFE9688, 0xFE6D5D, 0xFA352B, 0xC50A0B],
                 [0x83271F, 0xAB2A21, 0xD32C23, 0xFA352B, 0xFE8C7C]),
        .orange: ([0xF2C69F, 0xE6A971, 0xD98E44, 0xC97504, 0x975703],
                 [0x6A4116, 0x895111, 0xAA6204, 0xC97504, 0xE89F58]),
        .yellow: ([0xDFCE9F, 0xCDB573, 0xBC9E45, 0xAA8808, 0x806501],
                 [0x5A4A17, 0x745E12, 0x8F7207, 0xAA8808, 0xCBAE5A]),
        .green: ([0xA6E1AD, 0x7ACE86, 0x4CBC62, 0x06A941, 0x057F2F],
                 [0x1B5A28, 0x15742F, 0x068E36, 0x06A941, 0x62CC74]),
        .mint: ([0xA7DBD7, 0x7BC8C2, 0x4DB5AE, 0x09A19A, 0x067974],
                 [0x1B5653, 0x166F6A, 0x088882, 0x09A19A, 0x62C4BD]),
        .teal: ([0xA6DAE5, 0x7AC5D5, 0x4CB1C6, 0x079DB4, 0x057688],
                 [0x1A545F, 0x156C7B, 0x078498, 0x079DB4, 0x61C1D5]),
        .cyan: ([0xA5D7F5, 0x79C2EA, 0x4AADDF, 0x0598D0, 0x04729D],
                 [0x1A526D, 0x14688E, 0x0580B0, 0x0598D0, 0x60BDEE]),
        .blue: ([0xB2D2FF, 0x8AB9FE, 0x61A2FE, 0x3289FF, 0x1465CA],
                 [0x224B84, 0x255FAE, 0x2973D8, 0x3289FF, 0x7EB3FF]),
        .indigo: ([0xC4CBFE, 0xA7B0FF, 0x8D95FF, 0x7679FC, 0x5757C8],
                 [0x404383, 0x5154AC, 0x6366D5, 0x7679FC, 0xA0A8FE]),
        .purple: ([0xE6BDFF, 0xD89AFC, 0xC979F4, 0xB75AE7, 0x8D3BB6],
                 [0x613579, 0x7D409E, 0x9B4BC3, 0xB75AE7, 0xD68EFE]),
        .pink: ([0xFEBBBC, 0xFF9498, 0xFF6975, 0xFB2852, 0xC40138],
                 [0x842330, 0xAC233A, 0xD52144, 0xFB2852, 0xFF898F]),
        .brown: ([0xDDCDB9, 0xC9B398, 0xB89C7B, 0xA48660, 0x7E6443],
                 [0x584936, 0x715D43, 0x8B7151, 0xA48660, 0xC7AC8B]),
        .gray: ([0xC7D0E0, 0xACB8CF, 0x93A2BE, 0x7D8CAB, 0x5C6983],
                 [0x444C5B, 0x566175, 0x697690, 0x7D8CAB, 0xA3B2CD]),
    ]
}

/// One day's square for Week and Month: the step's colour, a dashed outline when nothing was asked (with the skip or
/// pause sign), the day's number or date inside, and a ring for today.
struct HeatSquare: View {
    let cell: HeatCell
    let color: HabitColor
    var size: CGFloat = 40
    var text: String = ""
    var isToday = false
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        let dark = scheme == .dark
        let shape = RoundedRectangle(cornerRadius: size * 0.22, style: .continuous)
        ZStack {
            switch cell {
            case .blank:
                Color.clear
            case .off(let why):
                shape.strokeBorder(HeatPalette.hex(dark ? HeatPalette.dash.dark : HeatPalette.dash.light),
                                   style: StrokeStyle(lineWidth: 1.5, dash: [3, 2.5]))
                if why == .notScheduled {
                    label(Color.secondary)
                } else {
                    Image(systemName: why == .skipped ? "forward.fill" : "pause.fill")
                        .font(.system(size: size * 0.26, weight: .semibold)).foregroundStyle(.secondary)
                }
            case .level(let n):
                shape.fill(HeatPalette.color(n, color, dark: dark))
                label(HeatPalette.ink(n, dark: dark))
            }
        }
        .frame(width: size, height: size)
        .overlay {
            if isToday {
                RoundedRectangle(cornerRadius: size * 0.22 + 3, style: .continuous)
                    .strokeBorder(Color.primary, lineWidth: 2).padding(-3.5)
            }
        }
        .accessibilityHidden(true)
    }

    @ViewBuilder private func label(_ ink: Color) -> some View {
        if !text.isEmpty {
            Text(text).font(.system(size: size * 0.32, weight: .semibold)).monospacedDigit()
                .lineLimit(1).minimumScaleFactor(0.6).foregroundStyle(ink).padding(.horizontal, 2)
        }
    }
}

/// What the squares mean, always at the top of the page, so no square needs explaining (the user, 2 Oct 2026). One
/// scale, "Less … More" with each step named, and the three other looks in words.
struct HeatKey: View {
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        let dark = scheme == .dark
        VStack(alignment: .leading, spacing: WeekSpacing.tight) {
            HStack(spacing: 6) {
                ForEach(0..<6, id: \.self) { n in
                    VStack(spacing: 3) {
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(HeatPalette.color(n, .green, dark: dark))
                            .frame(width: 18, height: 18)
                        Text(Self.steps[n]).font(.caption2).foregroundStyle(.secondary).lineLimit(1).fixedSize()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            HStack(spacing: 14) {
                HStack(spacing: 5) {
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .strokeBorder(HeatPalette.hex(dark ? HeatPalette.dash.dark : HeatPalette.dash.light),
                                      style: StrokeStyle(lineWidth: 1.3, dash: [2.5, 2]))
                        .frame(width: 16, height: 16)
                    Text("Not scheduled, skipped or paused")
                }
                HStack(spacing: 5) {
                    RoundedRectangle(cornerRadius: 5, style: .continuous).strokeBorder(Color.primary, lineWidth: 1.6)
                        .frame(width: 16, height: 16)
                    Text("Today")
                }
            }
            .font(.caption).foregroundStyle(.secondary)
        }
        .padding(WeekSpacing.card)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.card, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Key. Grey: not done. Lighter to darker: up to a third, up to two thirds, more, goal met, more than the goal. Dashed: not scheduled, skipped or paused. A ring: today.")
        .accessibilityIdentifier("progress-key")
    }

    static let steps = ["Not done", "⅓", "⅔", "Almost", "Goal met", "More"]
}

/// A habit's whole year at once, as GitHub's grid (the user, 2 Oct 2026; the most praised view: "see your entire year
/// in one view"): weeks left to right, weekdays top to bottom with their letters on the left, months on top; the last
/// column holds today and nothing after it is drawn. Sized to the card's width, never scrolled. One `Canvas`.
struct HeatYearGrid: View, Equatable {
    let layout: YearLayout
    let cells: [HeatCell]
    let color: HabitColor
    @Environment(\.colorScheme) private var scheme

    static func == (a: Self, b: Self) -> Bool { a.layout == b.layout && a.cells == b.cells && a.color == b.color }

    /// Left: the weekday letters. Top: the month names.
    static let side: CGFloat = 11
    static let top: CGFloat = 13
    /// The year's height: 7 rows at the pitch a full year (53 weeks) has on a phone card.
    static func height(columns: Int) -> CGFloat { top + 7 * min(9, 300 / CGFloat(max(columns, 30))) }

    var body: some View {
        let dark = scheme == .dark
        let columns = layout.columns
        Canvas { context, size in
            let pitch = min((size.width - Self.side) / CGFloat(max(columns, 1)), (size.height - Self.top) / 7)
            let cellSize = pitch * 0.82
            let radius = cellSize * 0.22
            let label = dark ? Color(white: 0.6) : Color(white: 0.42)
            for (row, letter) in layout.letters.enumerated() {
                let isToday = row == layout.todayRow
                context.draw(Text(letter).font(.system(size: 7.5, weight: isToday ? .bold : .medium))
                                .foregroundColor(isToday ? (dark ? .white : .black) : label),
                             at: CGPoint(x: 3, y: Self.top + CGFloat(row) * pitch + cellSize / 2), anchor: .center)
            }
            for month in layout.months {
                context.draw(Text(month.name).font(.system(size: 9, weight: .medium)).foregroundColor(label),
                             at: CGPoint(x: Self.side + CGFloat(month.column) * pitch, y: 0), anchor: .topLeading)
            }
            let notDone = HeatPalette.color(0, color, dark: dark)
            let dash = HeatPalette.hex(dark ? HeatPalette.dash.dark : HeatPalette.dash.light)
            var fills: [Int: Path] = [:]
            var off = Path()
            for (i, cell) in cells.prefix(layout.shown).enumerated() {
                let place = layout.lead + i
                let rect = CGRect(x: Self.side + CGFloat(place / 7) * pitch, y: Self.top + CGFloat(place % 7) * pitch,
                                  width: cellSize, height: cellSize)
                switch cell {
                case .blank: continue
                case .off: off.addRoundedRect(in: rect.insetBy(dx: 0.4, dy: 0.4), cornerSize: CGSize(width: radius, height: radius))
                case .level(let n): fills[n, default: Path()].addRoundedRect(in: rect, cornerSize: CGSize(width: radius, height: radius))
                }
            }
            // One fill per step (six at most), not one per day.
            for (n, path) in fills { context.fill(path, with: .color(n == 0 ? notDone : HeatPalette.color(n, color, dark: dark))) }
            context.stroke(off, with: .color(dash), style: StrokeStyle(lineWidth: 0.8, dash: [1.6, 1.2]))
            if layout.todayRow != nil, layout.shown > 0 {
                let place = layout.lead + layout.shown - 1
                let rect = CGRect(x: Self.side + CGFloat(place / 7) * pitch, y: Self.top + CGFloat(place % 7) * pitch,
                                  width: cellSize, height: cellSize).insetBy(dx: -1.4, dy: -1.4)
                context.stroke(Path(roundedRect: rect, cornerRadius: radius + 1.2), with: .color(dark ? .white : .black), lineWidth: 1.2)
            }
        }
        .frame(height: Self.height(columns: columns))
        .accessibilityHidden(true)
    }
}
