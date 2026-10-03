import SwiftUI

// Progress's heat map (the user, 2–3 Oct 2026): one square per day, the same in Week, Month, Year and on the habit's
// page; only the size changes, and never below `HeatSize.smallest`. No dates or numbers inside: the colour says how
// much, the sign says what happened (`HeatCell`, worked out in the store):
//   grey with ✕         asked and not done, once the day is over
//   three lighter steps up to 33 %, up to 66 %, up to 99 % of the day's goal: no sign (✓ means done; a part day isn't)
//   colour with ✓       the goal met (the habit's own colour)
//   darkest with a bold ✓  more than the goal
//   plain grey          asked, not over yet: today before anything is logged, a due day still to come
//   dashed outline      nothing asked: not scheduled; with ⏩ skipped, with ⏸ paused
//   thin grey outline   today (square, like every cell; light, so it never outweighs the day itself)
//   nothing             before the habit began
// Research behind it (report "Day Marks — Heat Map, Rule and Palette", 2 Oct 2026): heat maps are the most praised way
// to show days across 1.2 million reviews in every language. Every square is drawn by `HeatDraw` from the store's
// numbers only, batched into one fill or stroke per look (PERFORMANCE.md rules 5, 8 and 12).

/// Square sizes (the user, 3 Oct 2026: "the cells shouldn't be smaller … always legible clearly, easy to read … even
/// in the yearly"). The year scrolls sideways rather than shrink its squares.
enum HeatSize {
    static let week: CGFloat = 40
    static let month: CGFloat = 32
    static let year: CGFloat = 24
    static let yearGap: CGFloat = 4
    /// No square is ever drawn smaller: below it the signs stop being easy to read.
    static let smallest: CGFloat = 24
}

/// Grey, the five steps of every habit colour (light and dark), and the signs' colours. Each step sits at one OKLCH
/// lightness for every hue (light: 0.855, 0.78, 0.71, 0.64 = the habit's own colour, 0.52; dark: 0.415, 0.49, 0.565,
/// 0.64, 0.76), so no colour's steps look stronger than another's. Measured (the report's
/// `Day Marks Evidence/scripts/make.py`): neighbouring steps differ by at least 0.07 in OKLab, about 3.5 times the
/// smallest visible difference, and by at least 0.043 under every colour-vision deficiency. "Gray" habits get a cool
/// slate tint so their steps never read as the not-done grey.
/// Signs, measured on every colour (3 Oct 2026; WCAG 1.4.11 asks 3:1): ✓ is white on the goal step (≥ 3.11:1) and on
/// light mode's darkest step (≥ 5.14:1); dark mode's "more" step is its brightest, where white is 2:1, so its ✓ is
/// near-black (≥ 7.4:1). ✕, ⏩ and ⏸ are a grey at ≥ 4.4:1 on the grey square and the card; the dashed outline
/// ≥ 3.2:1 on the card.
enum HeatPalette {
    static func color(_ level: Int, _ habit: HabitColor, dark: Bool) -> Color {
        guard level > 0 else { return grey(dark) }
        let steps = table[habit] ?? table[.green]!
        return hex((dark ? steps.dark : steps.light)[min(5, level) - 1])
    }

    static func grey(_ dark: Bool) -> Color { dark ? greyDark : greyLight }
    /// ✕, ⏩, ⏸.
    static func sign(_ dark: Bool) -> Color { dark ? signDark : signLight }
    static func dash(_ dark: Bool) -> Color { dark ? dashDark : dashLight }
    static func today(_ dark: Bool) -> Color { dark ? todayDark : todayLight }
    /// The ✓ on the goal step and the "more" step.
    static func check(_ level: Int, dark: Bool) -> Color { dark && level >= 5 ? Color(white: 0.11) : .white }

    private static let greyLight = hex(0xEBEBF0), greyDark = hex(0x2C2C2E)
    private static let signLight = hex(0x6C6C70), signDark = hex(0x98989F)
    private static let dashLight = hex(0x8E8E93), dashDark = hex(0x7C7C80)
    private static let todayLight = hex(0x8E8E93), todayDark = hex(0x8E8E93)

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


/// Draws heat squares into a `Canvas`: every look batched into one fill or stroke (one fill per step, one stroke for
/// the dashes, one per kind of sign), never one call per day. Every heat view draws through it, so a square looks the
/// same at every size. One size per drawing: line widths follow it.
struct HeatDraw {
    let size: CGFloat
    private var fills: [Int: Path] = [:]
    private var dashes = Path()
    private var crosses = Path()
    private var signs = Path()
    private var checks = Path()
    private var boldChecks = Path()
    private var today = Path()

    init(size: CGFloat) { self.size = size }

    /// Room a square's today outline needs around it.
    static let outline: CGFloat = 3
    var radius: CGFloat { size * 0.22 }

    mutating func add(_ cell: HeatCell, in rect: CGRect, isToday: Bool = false) {
        let corner = CGSize(width: radius, height: radius)
        switch cell {
        case .blank:
            return
        case .upcoming:
            fills[0, default: Path()].addRoundedRect(in: rect, cornerSize: corner, style: .continuous)
        case .level(let n):
            let step = max(0, min(5, n))
            fills[step, default: Path()].addRoundedRect(in: rect, cornerSize: corner, style: .continuous)
            if step == 0 { cross(rect) }
            if step == 4 { Self.check(rect, into: &checks) }
            if step == 5 { Self.check(rect, into: &boldChecks) }
        case .off(let why):
            let inset = dashWidth / 2
            dashes.addRoundedRect(in: rect.insetBy(dx: inset, dy: inset),
                                  cornerSize: CGSize(width: radius - inset, height: radius - inset), style: .continuous)
            if why == .skipped { skip(rect) }
            if why == .paused { pause(rect) }
        }
        if isToday {
            let ring = rect.insetBy(dx: -2.5, dy: -2.5)
            today.addRoundedRect(in: ring, cornerSize: CGSize(width: radius + 2.5, height: radius + 2.5), style: .continuous)
        }
    }

    func draw(in context: GraphicsContext, color: HabitColor, dark: Bool) {
        for (n, path) in fills { context.fill(path, with: .color(HeatPalette.color(n, color, dark: dark))) }
        context.stroke(dashes, with: .color(HeatPalette.dash(dark)),
                       style: StrokeStyle(lineWidth: dashWidth, dash: [size * 0.12, size * 0.09]))
        let rounded = { (width: CGFloat) in StrokeStyle(lineWidth: width, lineCap: .round, lineJoin: .round) }
        context.stroke(crosses, with: .color(HeatPalette.sign(dark)), style: rounded(size * 0.085))
        context.fill(signs, with: .color(HeatPalette.sign(dark)))
        context.stroke(checks, with: .color(HeatPalette.check(4, dark: dark)), style: rounded(size * 0.1))
        context.stroke(boldChecks, with: .color(HeatPalette.check(5, dark: dark)), style: rounded(size * 0.14))
        context.stroke(today, with: .color(HeatPalette.today(dark)), lineWidth: 1.5)
    }

    private var dashWidth: CGFloat { max(1.2, size * 0.045) }

    private static func point(_ rect: CGRect, _ x: CGFloat, _ y: CGFloat) -> CGPoint {
        CGPoint(x: rect.minX + x * rect.width, y: rect.minY + y * rect.height)
    }

    private static func check(_ rect: CGRect, into path: inout Path) {
        path.move(to: Self.point(rect, 0.28, 0.52))
        path.addLine(to: Self.point(rect, 0.43, 0.67))
        path.addLine(to: Self.point(rect, 0.73, 0.35))
    }

    private mutating func cross(_ rect: CGRect) {
        crosses.move(to: Self.point(rect, 0.35, 0.35)); crosses.addLine(to: Self.point(rect, 0.65, 0.65))
        crosses.move(to: Self.point(rect, 0.65, 0.35)); crosses.addLine(to: Self.point(rect, 0.35, 0.65))
    }

    private mutating func skip(_ rect: CGRect) {
        for x in [0.26, 0.5] as [CGFloat] {
            signs.move(to: Self.point(rect, x, 0.33))
            signs.addLine(to: Self.point(rect, x + 0.24, 0.5))
            signs.addLine(to: Self.point(rect, x, 0.67))
            signs.closeSubpath()
        }
    }

    private mutating func pause(_ rect: CGRect) {
        for x in [0.35, 0.55] as [CGFloat] {
            let bar = CGRect(origin: Self.point(rect, x, 0.32), size: CGSize(width: rect.width * 0.1, height: rect.height * 0.36))
            signs.addRoundedRect(in: bar, cornerSize: CGSize(width: rect.width * 0.03, height: rect.width * 0.03))
        }
    }
}

/// One square on its own: the key, and the habit page's month (where each day is its own button).
struct HeatSquare: View, Equatable {
    let cell: HeatCell
    let color: HabitColor
    var size: CGFloat = HeatSize.month
    var isToday = false
    @Environment(\.colorScheme) private var scheme

    static func == (a: Self, b: Self) -> Bool {
        a.cell == b.cell && a.color == b.color && a.size == b.size && a.isToday == b.isToday
    }

    var body: some View {
        let dark = scheme == .dark
        let pad = HeatDraw.outline
        Canvas { context, _ in
            var draw = HeatDraw(size: size)
            draw.add(cell, in: CGRect(x: pad, y: pad, width: size, height: size), isToday: isToday)
            draw.draw(in: context, color: color, dark: dark)
        }
        .frame(width: size + 2 * pad, height: size + 2 * pad)
        .padding(-pad)
        .accessibilityHidden(true)
    }
}

/// A row of squares, each centred in its column (Week's strip). One `Canvas`.
struct HeatRow: View, Equatable {
    let cells: [HeatCell]
    let todayIndex: Int?
    let color: HabitColor
    var size: CGFloat = HeatSize.week
    @Environment(\.colorScheme) private var scheme

    static func == (a: Self, b: Self) -> Bool {
        a.cells == b.cells && a.todayIndex == b.todayIndex && a.color == b.color && a.size == b.size
    }

    var body: some View {
        let dark = scheme == .dark
        let pad = HeatDraw.outline
        Canvas { context, canvas in
            let column = canvas.width / CGFloat(max(cells.count, 1))
            var draw = HeatDraw(size: size)
            for (i, cell) in cells.enumerated() {
                let x = column * (CGFloat(i) + 0.5) - size / 2
                draw.add(cell, in: CGRect(x: x, y: pad, width: size, height: size), isToday: i == todayIndex)
            }
            draw.draw(in: context, color: color, dark: dark)
        }
        .frame(height: size + 2 * pad)
        .accessibilityHidden(true)
    }
}

/// A month of squares in rows of seven, each centred in its weekday's column (Month's card). One `Canvas`.
struct HeatMonth: View, Equatable {
    /// Empty places before the 1st.
    let lead: Int
    let cells: [HeatCell]
    let todayIndex: Int?
    let color: HabitColor
    var size: CGFloat = HeatSize.month
    var rowGap: CGFloat = 8
    @Environment(\.colorScheme) private var scheme

    static func == (a: Self, b: Self) -> Bool {
        a.lead == b.lead && a.cells == b.cells && a.todayIndex == b.todayIndex && a.color == b.color
            && a.size == b.size && a.rowGap == b.rowGap
    }

    var rows: Int { (lead + cells.count + 6) / 7 }

    var body: some View {
        let dark = scheme == .dark
        let pad = HeatDraw.outline
        Canvas { context, canvas in
            let column = canvas.width / 7
            var draw = HeatDraw(size: size)
            for (i, cell) in cells.enumerated() {
                let place = lead + i
                let x = column * (CGFloat(place % 7) + 0.5) - size / 2
                let y = pad + CGFloat(place / 7) * (size + rowGap)
                draw.add(cell, in: CGRect(x: x, y: y, width: size, height: size), isToday: i == todayIndex)
            }
            draw.draw(in: context, color: color, dark: dark)
        }
        .frame(height: CGFloat(rows) * size + CGFloat(max(rows - 1, 0)) * rowGap + 2 * pad)
        .accessibilityHidden(true)
    }
}

/// What the squares mean, always at the top of the page, so no square needs explaining (the user, 2–3 Oct 2026):
/// the scale with each step named in per cent, then the other looks in words. The squares are the real ones.
struct HeatKey: View {
    /// On its own card (Progress); false inside a list row (the habit's page, under its month).
    var boxed = true

    var body: some View {
        VStack(alignment: .leading, spacing: WeekSpacing.card) {
            HStack(alignment: .top, spacing: 4) {
                ForEach(0..<6, id: \.self) { n in
                    VStack(spacing: WeekSpacing.pair) {
                        HeatSquare(cell: .level(n), color: .green, size: HeatSize.smallest)
                        Text(Self.steps[n]).font(.caption2).foregroundStyle(.secondary)
                            .multilineTextAlignment(.center).lineLimit(2).fixedSize()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            VStack(alignment: .leading, spacing: WeekSpacing.tight) {
                HStack(spacing: WeekSpacing.card) {
                    entry(.upcoming, "Still to come")
                    entry(.upcoming, "Today", isToday: true)
                }
                // One line when it fits; at large text sizes, one entry per line.
                ViewThatFits(in: .horizontal) {
                    HStack(spacing: WeekSpacing.card) { dashedEntries }
                    VStack(alignment: .leading, spacing: WeekSpacing.tight) { dashedEntries }
                }
            }
            .font(.caption).foregroundStyle(.secondary)
        }
        .padding(boxed ? WeekSpacing.card : 0)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(boxed ? Color.card : .clear, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .accessibilityElement(children: .ignore)
        // "%", not the word: the key names the steps; it isn't a progress percentage, which Show Percentages hides.
        .accessibilityLabel("Key. Grey with a cross: not done. Lighter to darker: up to 33%, 66% and 99% of the goal. A check: goal met. Darkest with a bold check: more than the goal. Plain grey: still to come. An outline: today. Dashed: not scheduled; with a skip or pause sign: skipped or paused.")
        .accessibilityIdentifier("progress-key")
    }

    @ViewBuilder private var dashedEntries: some View {
        entry(.off(.notScheduled), "Not scheduled")
        entry(.off(.skipped), "Skipped")
        entry(.off(.paused), "Paused")
    }

    private func entry(_ cell: HeatCell, _ title: String, isToday: Bool = false) -> some View {
        HStack(spacing: 6) {
            HeatSquare(cell: cell, color: .green, size: HeatSize.smallest, isToday: isToday)
                // Today's outline sits outside the square: room for it before the words.
                .padding(.horizontal, isToday ? HeatDraw.outline : 0)
            Text(title).lineLimit(1).fixedSize()
        }
    }

    static let steps = ["Not\ndone", "Up to\n33%", "Up to\n66%", "Up to\n99%", "Goal\n100%", "More\n100%+"]
}

/// A habit's year as GitHub's grid (the user, 2–3 Oct 2026): weeks left to right, weekdays top to bottom, months on
/// top. Squares stay `HeatSize.year`, large enough to read every sign; the year scrolls sideways instead of shrinking
/// ("even if it shows two or three months, that is fine; clarity is more important"). The weekday letters stay put;
/// it opens on the latest weeks. `onDay`, where given, receives the first day (its index) of the tapped column.
struct HeatYear: View {
    let layout: YearLayout
    let cells: [HeatCell]
    let color: HabitColor
    var onDay: ((Int) -> Void)? = nil

    static let labels: CGFloat = 18

    var body: some View {
        HStack(alignment: .top, spacing: 4) {
            VStack(spacing: HeatSize.yearGap) {
                ForEach(0..<7, id: \.self) { row in
                    let isToday = row == layout.todayRow
                    Text(row < layout.letters.count ? layout.letters[row] : "")
                        .font(.caption2.weight(isToday ? .bold : .medium))
                        .foregroundStyle(isToday ? Color.primary : Color.secondary)
                        .frame(width: 14, height: HeatSize.year)
                }
            }
            .padding(.top, Self.labels + HeatDraw.outline)
            ScrollView(.horizontal) {
                let squares = HeatYearSquares(layout: layout, cells: cells, color: color).equatable()
                if let onDay {
                    squares.contentShape(Rectangle()).onTapGesture { location in
                        let column = max(0, Int((location.x - HeatDraw.outline) / (HeatSize.year + HeatSize.yearGap)))
                        onDay(min(max(0, column * 7 - layout.lead), max(layout.shown - 1, 0)))
                    }
                } else {
                    // On a Progress card the whole card is the button that opens the habit.
                    squares
                }
            }
            .scrollIndicators(.hidden)
            .defaultScrollAnchor(.trailing)
            // Another year starts again at its latest weeks: the card keeps its identity (the habit's), and without
            // this its squares stayed where the last year was left (2 Oct 2026).
            .id(layout)
        }
    }
}

/// The year's squares and month names, drawn in one pass. Rendered off the main thread: a year is about 1,300 points
/// wide, and drawing it is the one cost of a card that grows with the screen's width rather than the data.
private struct HeatYearSquares: View, Equatable {
    let layout: YearLayout
    let cells: [HeatCell]
    let color: HabitColor
    @Environment(\.colorScheme) private var scheme

    static func == (a: Self, b: Self) -> Bool { a.layout == b.layout && a.cells == b.cells && a.color == b.color }

    var body: some View {
        let dark = scheme == .dark
        let pad = HeatDraw.outline
        let pitch = HeatSize.year + HeatSize.yearGap
        let columns = max(layout.columns, 1)
        // Room after the last column for a month name that starts there.
        let width = 2 * pad + CGFloat(columns) * pitch - HeatSize.yearGap + 24
        let height = HeatYear.labels + 2 * pad + 7 * pitch - HeatSize.yearGap
        Canvas(rendersAsynchronously: true) { context, _ in
            let label = dark ? Color(white: 0.62) : Color(white: 0.4)
            for month in layout.months {
                context.draw(Text(month.name).font(.caption.weight(.medium)).foregroundColor(label),
                             at: CGPoint(x: pad + CGFloat(month.column) * pitch, y: 0), anchor: .topLeading)
            }
            var draw = HeatDraw(size: HeatSize.year)
            let top = HeatYear.labels + pad
            let todayPlace = layout.todayRow == nil ? -1 : layout.lead + layout.shown - 1
            for (i, cell) in cells.prefix(layout.shown).enumerated() {
                let place = layout.lead + i
                let rect = CGRect(x: pad + CGFloat(place / 7) * pitch, y: top + CGFloat(place % 7) * pitch,
                                  width: HeatSize.year, height: HeatSize.year)
                draw.add(cell, in: rect, isToday: place == todayPlace)
            }
            draw.draw(in: context, color: color, dark: dark)
        }
        .frame(width: width, height: height)
    }
}
