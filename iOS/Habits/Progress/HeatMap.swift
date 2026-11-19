import SwiftUI

// The day cells (Figma's Day cell, section 11, 17 Nov 2026): one cell per day, the same in Week, Month, Year, Year in
// Pixels and on the habit's page; only the size changes. No dates or numbers inside: the fill says how much, the sign
// what happened (`HeatCell`, worked out in the store; `HeatDraw` lists the looks). Every cell is drawn by `HeatDraw`
// from the store's numbers only, batched into one fill or stroke per look (S5, S8, S12). Research behind the cells:
// report "Day Marks — Heat Map, Rule and Palette" (2 Oct 2026).

/// Figma's cell sizes: Week 36 (Week and Month), Small 28, Year 24, with 6 between Week's and Month's and 4 between
/// Year's. The year scrolls sideways rather than shrink its cells (the user, 3 Oct 2026: "always legible clearly").
enum HeatSize {
    static let week: CGFloat = 36
    static let month: CGFloat = 36
    static let small: CGFloat = 28
    static let year: CGFloat = 24
    static let gap: CGFloat = 6
    static let yearGap: CGFloat = 4
    /// No cell is ever drawn smaller: below it the signs stop being easy to read.
    static let smallest: CGFloat = 24
}

/// The widgets' day squares only (U28, locked): five steps per habit colour, light and dark, which the widgets draw
/// themselves from the snapshot (`widgetSteps`). The app's own cells are Figma's Day cell (`HeatInk`, `HeatDraw`).
/// Each step sits at one OKLCH lightness for every hue (light 0.855, 0.78, 0.71, 0.64, 0.52; dark 0.415, 0.49, 0.565,
/// 0.64, 0.76), and dark mode's ✓ is a deep shade of the habit's colour (2–3 Oct 2026).
enum HeatPalette {
    /// Dark mode's ✓ per colour, with its contrast on the goal step / the "more" step.
    private static let darkChecks: [HabitColor: Int] = [
        .red: 0x331511,     // 4.47 / 7.37
        .orange: 0x301903,  // 4.76 / 7.53
        .yellow: 0x281E00,  // 4.89 / 7.63
        .green: 0x0C2611,   // 5.20 / 8.00
        .mint: 0x002523,    // 5.10 / 7.88
        .teal: 0x00242B,    // 5.04 / 7.84
        .cyan: 0x002333,    // 4.97 / 7.77
        .blue: 0x0F1F37,    // 4.84 / 7.69
        .indigo: 0x1A1C36,  // 4.68 / 7.54
        .purple: 0x271830,  // 4.47 / 7.27
        .pink: 0x331416,    // 4.41 / 7.37
        .brown: 0x2D1B01,   // 4.85 / 7.65
        .gray: 0x131E37,    // 4.90 / 7.73
    ]

    /// The habit's five steps (light, then dark) and dark mode's ✓, as 0xRRGGBB: the widgets draw the same squares as
    /// Progress (Implementation Spec §2, "Day squares") without the app's colour tables.
    static func widgetSteps(_ habit: HabitColor) -> [Int] {
        let steps = table[habit] ?? table[.green]!
        return steps.light + steps.dark + [darkChecks[habit] ?? darkChecks[.green]!]
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


/// The colours of a habit's day cells (Figma's Day cell, 17 Nov 2026): Done is the habit's own colour, More than the
/// goal its Increased Contrast shade, Part the colour at 50 %. Everything else is Apple's: Tertiary System Fill for a day
/// that was asked, Secondary Label for its sign, Separator for the dashed outline, Label for today's ring. Made on the
/// main actor once per drawing, never per cell.
struct HeatInk {
    let done: Color
    let more: Color
    let part: Color

    init(_ habit: HabitColor) {
        done = habit.color
        more = habit.increasedContrast
        part = habit.color.opacity(0.5)
    }
}

/// Draws day cells into a `Canvas`, as Figma's Day cell (977:635): every look batched into one fill or stroke, and each
/// sign resolved once and stamped where it goes, never one view per day. Every heat view draws through it, so a cell
/// looks the same everywhere. One size per drawing: its corner and its signs follow Figma's three sizes (Week 36,
/// Small 28, Year 24; a Year in Pixels square keeps Year's look at whatever size fills the card).
///   Done                the habit's colour, white ✓
///   More than the goal  Increased Contrast, white ✓
///   Part                the colour at 50 %, no sign (✓ means done; a part day isn't)
///   Not done            Tertiary System Fill, ✕ in Secondary Label
///   Skipped · Paused    Tertiary System Fill, forward.fill · pause.fill in Secondary Label
///   To come             Tertiary System Fill, nothing
///   No goal             a dashed Separator outline, 1.5 inside, dashes of 3 (2.33 on Small)
///   Empty               nothing (before the habit began, days outside the month)
///   Today               a 2-pt Label ring 3 outside the cell, on any state
struct HeatDraw {
    let size: CGFloat
    private var grey = Path()
    private var part = Path()
    private var done = Path()
    private var more = Path()
    private var dashes = Path()
    private var today = Path()
    private var checks: [CGPoint] = []
    private var crosses: [CGPoint] = []
    private var skips: [CGPoint] = []
    private var pauses: [CGPoint] = []

    init(size: CGFloat) { self.size = size }

    /// Room a cell's today ring needs around it.
    static let outline: CGFloat = 3
    var radius: CGFloat { Self.radius(size) }

    /// Figma's corners: 8 on Week, 7 on Small, 6 on Year.
    static func radius(_ size: CGFloat) -> CGFloat { size >= 34 ? 8 : size >= 27 ? 7 : 6 }

    /// Figma's signs, in points of SF Pro Regular: ✓, ✕, then ⏩ and ⏸.
    private var signs: (check: CGFloat, cross: CGFloat, mark: CGFloat) {
        size >= 34 ? (18, 15, 13) : size >= 27 ? (14, 12, 10) : (13, 10, 10)
    }

    mutating func add(_ cell: HeatCell, in rect: CGRect, isToday: Bool = false) {
        let corner = CGSize(width: radius, height: radius)
        let centre = CGPoint(x: rect.midX, y: rect.midY)
        switch cell {
        case .blank:
            break
        case .upcoming:
            grey.addRoundedRect(in: rect, cornerSize: corner, style: .continuous)
        case .level(let n):
            switch n {
            case ...0:
                grey.addRoundedRect(in: rect, cornerSize: corner, style: .continuous)
                crosses.append(centre)
            case 1...3:
                part.addRoundedRect(in: rect, cornerSize: corner, style: .continuous)
            case 4:
                done.addRoundedRect(in: rect, cornerSize: corner, style: .continuous)
                checks.append(centre)
            default:
                more.addRoundedRect(in: rect, cornerSize: corner, style: .continuous)
                checks.append(centre)
            }
        case .off(.notScheduled):
            let inset = Self.dashWidth / 2
            dashes.addRoundedRect(in: rect.insetBy(dx: inset, dy: inset),
                                  cornerSize: CGSize(width: radius - inset, height: radius - inset), style: .continuous)
        case .off(let why):
            // Skipped and paused days were asked of: grey, like not done, with their own sign.
            grey.addRoundedRect(in: rect, cornerSize: corner, style: .continuous)
            if why == .skipped { skips.append(centre) } else { pauses.append(centre) }
        }
        if isToday {
            // The ring's 2-pt line runs from 1 to 3 outside the cell, as Figma's 3-outside rectangle with an inside stroke.
            today.addRoundedRect(in: rect.insetBy(dx: -2, dy: -2), cornerSize: CGSize(width: radius + 2, height: radius + 2),
                                 style: .continuous)
        }
    }

    func draw(in context: GraphicsContext, ink: HeatInk) {
        context.fill(grey, with: .color(Color(.tertiarySystemFill)))
        context.fill(part, with: .color(ink.part))
        context.fill(done, with: .color(ink.done))
        context.fill(more, with: .color(ink.more))
        let dash: CGFloat = size >= 34 || size < 27 ? 3 : 7.0 / 3
        context.stroke(dashes, with: .color(Color(.separator)), style: StrokeStyle(lineWidth: Self.dashWidth, dash: [dash, dash]))
        let signs = signs
        stamp(checks, "checkmark", signs.check, .white, in: context)
        stamp(crosses, "xmark", signs.cross, Color(.secondaryLabel), in: context)
        stamp(skips, "forward.fill", signs.mark, Color(.secondaryLabel), in: context)
        stamp(pauses, "pause.fill", signs.mark, Color(.secondaryLabel), in: context)
        context.stroke(today, with: .color(Color(.label)), lineWidth: 2)
    }

    private static let dashWidth: CGFloat = 1.5

    /// One SF Symbol, resolved once, drawn centred on every point.
    private func stamp(_ points: [CGPoint], _ symbol: String, _ size: CGFloat, _ color: Color,
                       in context: GraphicsContext) {
        guard !points.isEmpty else { return }
        let sign = context.resolve(Text(Image(systemName: symbol)).font(.system(size: size)).foregroundColor(color))
        for point in points { context.draw(sign, at: point, anchor: .center) }
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
        // Read so a change of appearance redraws: the cells' colours are Apple's, resolved by the canvas.
        let _ = scheme
        let ink = HeatInk(color)
        let pad = HeatDraw.outline
        Canvas { context, _ in
            var draw = HeatDraw(size: size)
            draw.add(cell, in: CGRect(x: pad, y: pad, width: size, height: size), isToday: isToday)
            draw.draw(in: context, ink: ink)
        }
        .frame(width: size + 2 * pad, height: size + 2 * pad)
        .padding(-pad)
        .accessibilityHidden(true)
    }
}

/// A row of cells spread edge to edge, the first at the leading edge and the last at the trailing one (Figma's Week:
/// seven 36s, space between). One `Canvas`; the today ring may reach past the edges, so the canvas does too.
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
        // Read so a change of appearance redraws: the cells' colours are Apple's, resolved by the canvas.
        let _ = scheme
        let ink = HeatInk(color)
        let pad = HeatDraw.outline
        Canvas { context, canvas in
            let pitch = (canvas.width - 2 * pad - size) / CGFloat(max(cells.count - 1, 1))
            var draw = HeatDraw(size: size)
            for (i, cell) in cells.enumerated() {
                draw.add(cell, in: CGRect(x: pad + pitch * CGFloat(i), y: pad, width: size, height: size), isToday: i == todayIndex)
            }
            draw.draw(in: context, ink: ink)
        }
        .frame(height: size + 2 * pad)
        .padding(-pad)
        .accessibilityHidden(true)
    }
}

/// Labels over a row of cells, each centred over its cell (`HeatRow`'s spacing): the weekday names and letters.
struct HeatColumns<Label: View>: View {
    let count: Int
    var size: CGFloat = HeatSize.week
    @ViewBuilder let label: (Int) -> Label

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<count, id: \.self) { i in
                if i > 0 { Spacer(minLength: 0) }
                label(i).frame(width: size)
            }
        }
    }
}

/// A month in rows of seven, spread edge to edge as Week's row (Figma's Month: 36s, 6 between rows). One `Canvas`.
struct HeatMonth: View, Equatable {
    /// Empty places before the 1st.
    let lead: Int
    let cells: [HeatCell]
    let todayIndex: Int?
    let color: HabitColor
    var size: CGFloat = HeatSize.month
    var rowGap: CGFloat = HeatSize.gap
    @Environment(\.colorScheme) private var scheme

    static func == (a: Self, b: Self) -> Bool {
        a.lead == b.lead && a.cells == b.cells && a.todayIndex == b.todayIndex && a.color == b.color
            && a.size == b.size && a.rowGap == b.rowGap
    }

    var rows: Int { (lead + cells.count + 6) / 7 }

    var body: some View {
        // Read so a change of appearance redraws: the cells' colours are Apple's, resolved by the canvas.
        let _ = scheme
        let ink = HeatInk(color)
        let pad = HeatDraw.outline
        Canvas { context, canvas in
            let pitch = (canvas.width - 2 * pad - size) / 6
            var draw = HeatDraw(size: size)
            for (i, cell) in cells.enumerated() {
                let place = lead + i
                let x = pad + CGFloat(place % 7) * pitch
                let y = pad + CGFloat(place / 7) * (size + rowGap)
                draw.add(cell, in: CGRect(x: x, y: y, width: size, height: size), isToday: i == todayIndex)
            }
            draw.draw(in: context, ink: ink)
        }
        .frame(height: CGFloat(rows) * size + CGFloat(max(rows - 1, 0)) * rowGap + 2 * pad)
        .padding(-pad)
        .accessibilityHidden(true)
    }
}

/// What the cells mean, always at the top of Progress and under the habit page's month (the user, 2–3 Oct 2026), in
/// three rows: how much was done (the habit's colour), days that were asked of with nothing done (grey), and the other
/// days. The cells are the real ones (Figma's Day cell), in green as the example; each habit uses its own colour.
struct HeatKey: View {
    /// On its own card (Progress); false inside a list row (the habit's page, under its month).
    var boxed = true
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        VStack(alignment: .leading, spacing: WeekSpacing.card) {
            VStack(alignment: .leading, spacing: WeekSpacing.tight) {
                heading("Progress", note: "Shown in green; each habit uses its own colour")
                row {
                    entry(.level(2), "Part done")
                    entry(.level(4), "Goal met")
                    entry(.level(5), "More than the goal")
                }
            }
            VStack(alignment: .leading, spacing: WeekSpacing.tight) {
                heading("Planned that day")
                row {
                    entry(.level(0), "Not done")
                    entry(.off(.skipped), "Skipped")
                    entry(.off(.paused), "Paused")
                }
            }
            VStack(alignment: .leading, spacing: WeekSpacing.tight) {
                heading("Other days")
                row {
                    entry(.upcoming, "Still to come")
                    entry(.off(.notScheduled), "Not scheduled")
                    entry(.upcoming, "Today", isToday: true)
                }
            }
        }
        .padding(boxed ? WeekSpacing.card : 0)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(boxed ? Color.card : .clear, in: RoundedRectangle(cornerRadius: CardShape.radius, style: .continuous))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Key. Progress, in the habit's colour: part done lighter, goal met with a check, more than the goal deeper with a check. Planned that day, grey: not done with a cross, skipped, paused. Other days: plain grey still to come, dashed not scheduled, a ring for today.")
        .accessibilityIdentifier("progress-key")
    }

    private func heading(_ title: String, note: String? = nil) -> some View {
        VStack(alignment: .leading, spacing: WeekSpacing.label) {
            Text(title).font(.footnote.weight(.semibold)).foregroundStyle(.primary)
            if let note { Text(note).font(.caption2).foregroundStyle(.secondary) }
        }
    }

    /// One line, wrapping where a word needs it; from the accessibility text sizes up, one entry per line. Chosen by the
    /// text size, not by measuring both layouts (`ViewThatFits` laid the row out twice each time the key came back).
    @ViewBuilder private func row(@ViewBuilder _ entries: () -> some View) -> some View {
        if typeSize.isAccessibilitySize {
            VStack(alignment: .leading, spacing: WeekSpacing.tight) { entries() }
                .font(.caption).foregroundStyle(.secondary)
        } else {
            HStack(alignment: .center, spacing: WeekSpacing.card) { entries() }
                .font(.caption).foregroundStyle(.secondary)
        }
    }

    private func entry(_ cell: HeatCell, _ title: String, isToday: Bool = false) -> some View {
        HStack(spacing: 6) {
            HeatSquare(cell: cell, color: .green, size: HeatSize.smallest, isToday: isToday)
                // Today's ring sits outside the cell: room for it before the words.
                .padding(.horizontal, isToday ? HeatDraw.outline : 0)
            Text(title).fixedSize(horizontal: false, vertical: true)
        }
    }
}

/// One page's "What the squares mean": closed whenever a page opens, everywhere in the app, and open only while the
/// person stays on the page where they opened it (the user, 19 Nov 2026: "When I open it and leave that page, it should
/// be closed … just because I opened it here, it doesn't mean everywhere else … it should stay closed"). Nothing is
/// remembered: switching tabs, ranges or dates on the same page keeps it as it is; leaving the page forgets it. This
/// replaces 6 Oct's app-wide memory (Current Work 57).
@Observable final class HeatKeyVisit {
    private(set) var isOpen = false

    func toggle() { isOpen.toggle() }
}

/// The key, folded or open (the user, 3 Oct 2026: a separate, collapsible section), closed whenever its page opens
/// (`HeatKeyVisit`). `boxed` gives it its own card (Progress); inside a list section (the
/// habit's page) it draws plainly.
struct HeatKeySection: View {
    var boxed = true
    /// The page's visit; a key shown outside one keeps its own.
    @Environment(HeatKeyVisit.self) private var pageVisit: HeatKeyVisit?
    @State private var ownVisit = HeatKeyVisit()

    var body: some View {
        let visit = pageVisit ?? ownVisit
        let open = visit.isOpen
        VStack(alignment: .leading, spacing: WeekSpacing.card) {
            Button {
                withAnimation(.snappy(duration: 0.25)) { visit.toggle() }
            } label: {
                HStack {
                    Text("What the squares mean").font(.subheadline.weight(.semibold)).foregroundStyle(.primary)
                    Spacer(minLength: WeekSpacing.tight)
                    Image(systemName: "chevron.down").font(.footnote.weight(.semibold)).foregroundStyle(.secondary)
                        // An accordion's chevron (the user, 3 Oct 2026): down while folded, up while open. Never pointing
                        // right: next to the dates' ‹ › that would read as a page to go to.
                        .rotationEffect(.degrees(open ? 180 : 0))
                }
                .frame(minHeight: 28)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("What the squares mean")
            .accessibilityValue(open ? "Shown" : "Hidden")
            .accessibilityHint(open ? "Hides the key" : "Shows the key")
            .accessibilityIdentifier("heat-key-toggle")
            if open {
                HeatKey(boxed: false)
                    .transition(.opacity)
            }
        }
        .padding(boxed ? WeekSpacing.card : 0)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(boxed ? Color.card : .clear, in: RoundedRectangle(cornerRadius: CardShape.radius, style: .continuous))
        .onPerfCommand { action in
            if action == .toggleHeatKey { withAnimation(.snappy(duration: 0.25)) { visit.toggle() } }
        }
    }
}

/// A habit's year as GitHub's grid (the user, 2–3 Oct 2026; Figma's history card, Year): weeks left to right, weekdays
/// top to bottom, months on top. Cells stay `HeatSize.year`, large enough to read every sign; the year scrolls sideways
/// instead of shrinking, opening on the latest weeks and going back to January. The weekday letters stay put (12 wide,
/// Footnote; today's Caption 1 Semibold in Label). `onDay`, where given, receives the first day (its index) of the
/// tapped column.
struct HeatYear: View {
    let layout: YearLayout
    let cells: [HeatCell]
    let color: HabitColor
    var onDay: ((Int) -> Void)? = nil

    /// The month names' row, and the gap under it.
    static let labels: CGFloat = 16 + HeatSize.yearGap

    var body: some View {
        HStack(alignment: .top, spacing: 6) {
            VStack(spacing: HeatSize.yearGap) {
                ForEach(0..<7, id: \.self) { row in
                    let isToday = row == layout.todayRow
                    Text(row < layout.letters.count ? layout.letters[row] : "")
                        .font(isToday ? .caption.weight(.semibold) : .footnote)
                        .foregroundStyle(isToday ? Color.primary : Color.secondary)
                        .frame(width: 12, height: HeatSize.year)
                }
            }
            .padding(.top, Self.labels)
            .dynamicTypeSize(...DynamicTypeSize.xLarge)
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

/// The year's cells and month names, drawn in one pass. Rendered off the main thread: a year is about 1,300 points
/// wide, and drawing it is the one cost of a card that grows with the screen's width rather than the data.
private struct HeatYearSquares: View, Equatable {
    let layout: YearLayout
    let cells: [HeatCell]
    let color: HabitColor
    @Environment(\.colorScheme) private var scheme

    static func == (a: Self, b: Self) -> Bool { a.layout == b.layout && a.cells == b.cells && a.color == b.color }

    var body: some View {
        // Read so a change of appearance redraws: the cells' colours are Apple's, resolved by the canvas.
        let _ = scheme
        let ink = HeatInk(color)
        let pad = HeatDraw.outline
        let pitch = HeatSize.year + HeatSize.yearGap
        let columns = max(layout.columns, 1)
        // Room after the last column for a month name that starts there.
        let width = 2 * pad + CGFloat(columns) * pitch - HeatSize.yearGap + 24
        let height = HeatYear.labels + 7 * pitch - HeatSize.yearGap + pad
        Canvas(rendersAsynchronously: true) { context, _ in
            let label = Color(.secondaryLabel)
            for month in layout.months {
                context.draw(Text(month.name).font(.footnote).foregroundColor(label),
                             at: CGPoint(x: pad + CGFloat(month.column) * pitch, y: 8), anchor: .leading)
            }
            var draw = HeatDraw(size: HeatSize.year)
            let top = HeatYear.labels
            let todayPlace = layout.todayRow == nil ? -1 : layout.lead + layout.shown - 1
            for (i, cell) in cells.prefix(layout.shown).enumerated() {
                let place = layout.lead + i
                let rect = CGRect(x: pad + CGFloat(place / 7) * pitch, y: top + CGFloat(place % 7) * pitch,
                                  width: HeatSize.year, height: HeatSize.year)
                draw.add(cell, in: rect, isToday: place == todayPlace)
            }
            draw.draw(in: context, ink: ink)
        }
        .frame(width: width, height: height)
        // The month names keep to their 16-point row at every text size; the words carry the meaning beyond it.
        .dynamicTypeSize(...DynamicTypeSize.xLarge)
    }
}

/// Year in Pixels (the user, 3 Oct 2026: "year is really important … a beautiful thing"; Figma's Year in Pixels card,
/// 17 Nov 2026): twelve month columns by 31 day rows, the whole year at once. The squares fill the card's width and it
/// never scrolls sideways: (width − 18 − 12 × 3) ÷ 12, about 20 on a 6.1-inch iPhone, drawn in Day cell's Year look.
/// The month letters on top (today's month in Label, semibold), every fifth day's number down the side (1, 6, 11 … 31).
/// Days a month doesn't have (30 February) stay empty. A tap selects a day; it never logs anything. One `Canvas`.
struct HeatYearPixels: View, Equatable {
    /// Every day of the year, from 1 January.
    let cells: [HeatCell]
    /// Each month's 1st, as an index into `cells`, and its length.
    let monthStarts: [Int]
    let monthLengths: [Int]
    /// "J", "F"…
    let monthNames: [String]
    let todayIndex: Int?
    let selected: Int?
    let color: HabitColor
    let select: (Int) -> Void
    @Environment(\.colorScheme) private var scheme
    @State private var width: CGFloat = 0

    static func == (a: Self, b: Self) -> Bool {
        a.cells == b.cells && a.monthStarts == b.monthStarts && a.todayIndex == b.todayIndex && a.selected == b.selected
            && a.color == b.color && a.monthNames == b.monthNames
    }

    /// The day numbers' column, the month letters' row, and the gap between everything (Figma: 18, 18, 3).
    static let gutter: CGFloat = 18
    static let header: CGFloat = 18
    static let gap: CGFloat = 3
    /// Days with their number beside them.
    static let labelled: Set<Int> = [1, 6, 11, 16, 21, 26, 31]

    /// A square's side for the grid's width; until the width is known, the 6.1-inch iPhone's card.
    static func square(for width: CGFloat) -> CGFloat {
        max(HeatSize.smallest * 0.6, ((width > 0 ? width : 296) - gutter - 12 * gap) / 12)
    }

    static func height(for width: CGFloat) -> CGFloat {
        let side = square(for: width)
        return header + gap + 31 * side + 30 * gap + HeatDraw.outline
    }

    var body: some View {
        // Read so a change of appearance redraws: the cells' colours are Apple's, resolved by the canvas.
        let _ = scheme
        let ink = HeatInk(color)
        let todayMonth = todayIndex.flatMap { index in monthStarts.lastIndex { $0 <= index } }
        Canvas { context, size in
            let side = Self.square(for: size.width)
            let pitch = side + Self.gap
            let left = Self.gutter + Self.gap, top = Self.header + Self.gap
            for m in 0..<min(12, monthNames.count) {
                let isNow = m == todayMonth
                let name = Text(monthNames[m]).font(isNow ? .footnote.weight(.semibold) : .footnote)
                    .foregroundColor(isNow ? Color(.label) : Color(.secondaryLabel))
                context.draw(name, at: CGPoint(x: left + CGFloat(m) * pitch + side / 2, y: Self.header / 2), anchor: .center)
            }
            for d in Self.labelled.sorted() {
                context.draw(Text("\(d)").font(.footnote.monospacedDigit()).foregroundColor(Color(.secondaryLabel)),
                             at: CGPoint(x: 0, y: top + CGFloat(d - 1) * pitch + side / 2), anchor: .leading)
            }
            var draw = HeatDraw(size: side)
            var picked: CGRect?
            for m in 0..<min(12, monthStarts.count) {
                for d in 0..<monthLengths[m] {
                    let i = monthStarts[m] + d
                    guard i < cells.count else { continue }
                    let rect = CGRect(x: left + CGFloat(m) * pitch, y: top + CGFloat(d) * pitch, width: side, height: side)
                    draw.add(cells[i], in: rect, isToday: i == todayIndex)
                    if i == selected { picked = rect }
                }
            }
            draw.draw(in: context, ink: ink)
            if let picked {
                // The tapped day: a ring in the habit's colour, so it never reads as today's Label ring.
                let ring = picked.insetBy(dx: -2, dy: -2)
                context.stroke(Path(roundedRect: ring, cornerRadius: HeatDraw.radius(side) + 2, style: .continuous),
                               with: .color(ink.done), lineWidth: 2)
            }
        }
        .frame(height: Self.height(for: width))
        // The squares follow the card's width, not the text size, so the labels stop growing where "31" still fits
        // its 18-point column and a month letter its square.
        .dynamicTypeSize(...DynamicTypeSize.large)
        .onGeometryChange(for: CGFloat.self) { $0.size.width } action: { width = $0 }
        .contentShape(Rectangle())
        .onTapGesture(coordinateSpace: .local) { location in
            // The same geometry as the drawing: which column (month) and row (day) the finger is in.
            let side = Self.square(for: width), pitch = side + Self.gap
            let column = Int(floor((location.x - Self.gutter - Self.gap / 2) / pitch))
            let row = Int(floor((location.y - Self.header - Self.gap / 2) / pitch))
            guard column >= 0, column < min(12, monthStarts.count), row >= 0, row < monthLengths[column] else { return }
            let index = monthStarts[column] + row
            if index < cells.count { select(index) }
        }
        .accessibilityHidden(true)
    }
}
