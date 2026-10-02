import SwiftUI

// Progress ▸ Year (the user, 2 Oct 2026): each habit's year as GitHub's contribution grid, in the app's style. Weeks run
// left to right, weekdays top to bottom; the last column holds today and nothing after it is drawn. Rounded squares,
// large enough to carry the app's signs (▲, skip, pause, ×). Every day is a grey square until something fills it:
//   done        the habit's colour                    partial   one of three lighter steps (less → more)
//   more        the colour with a white ▲             over      a limit's day above it: the colour with a white ▲
//   not done    grey (today stays grey until logged)  not scheduled  a dashed outline, keeping the grid's shape
//   skipped     grey with ⏩                          paused    grey with ⏸            slip   grey with ×
//   before it started, days to come: nothing
// The weekday letters stay put while the year scrolls sideways, and it opens on the latest weeks. One `Canvas` per
// card (PERFORMANCE.md rule 12); every colour is worked out in advance (`HabitColor.yearShade`), none while drawing.

/// What one square shows.
enum YearCellStyle: Hashable {
    case full, shade(Int), more, empty, skipped, paused, notScheduled, slip, blank

    init(_ day: WeekCardDay) {
        if day.slip { self = .slip; return }
        switch day.mark {
        case .done: self = day.more ? .more : .full
        case .some: self = .shade(day.fraction <= 1.0 / 3 ? 0 : day.fraction <= 2.0 / 3 ? 1 : 2)
        // A limit's day over it: the habit's colour stays, with ▲ (the user, 2 Oct 2026).
        case .missed: self = day.over ? .more : .empty
        case .open, .upcoming: self = .empty
        case .skipped: self = .skipped
        case .paused: self = .paused
        case .notItsDay: self = .notScheduled
        case .before: self = .blank
        }
    }
}

/// The grid's measures and its drawing, shared by the cards and the key.
enum YearGrid {
    static let cell: CGFloat = 18
    static let gap: CGFloat = 4
    static var pitch: CGFloat { cell + gap }
    static let corner: CGFloat = 4
    /// Room above the squares for the month names.
    static let labels: CGFloat = 18

    /// The neutral greys, fixed per appearance so a `Canvas` never resolves a dynamic colour per square.
    struct Ink {
        let empty: Color
        let dash: Color
        let sign: Color
        let label: Color
        init(dark: Bool) {
            empty = dark ? hex(0x2C2C2E) : hex(0xE5E5EA)  // systemGray5
            dash = dark ? hex(0x5A5A5E) : hex(0xB8B8BE)
            sign = dark ? hex(0x98989F) : hex(0x8A8A8E)   // systemGray
            label = dark ? hex(0x98989F) : hex(0x6C6C70)
        }
    }

    /// Draws one square. `signs` are resolved once per drawing pass.
    static func draw(_ style: YearCellStyle, in rect: CGRect, context: GraphicsContext, color: HabitColor, dark: Bool,
                     ink: Ink, signs: Signs) {
        let shape = Path(roundedRect: rect, cornerRadius: corner, style: .continuous)
        let center = CGPoint(x: rect.midX, y: rect.midY)
        switch style {
        case .blank: return
        case .full: context.fill(shape, with: .color(color.mark))
        case .more:
            context.fill(shape, with: .color(color.mark))
            context.draw(signs.more, at: center)
        case .shade(let level): context.fill(shape, with: .color(color.yearShade(level, dark: dark)))
        case .empty: context.fill(shape, with: .color(ink.empty))
        case .skipped:
            context.fill(shape, with: .color(ink.empty))
            context.draw(signs.skip, at: center)
        case .paused:
            context.fill(shape, with: .color(ink.empty))
            context.draw(signs.pause, at: center)
        case .slip:
            context.fill(shape, with: .color(ink.empty))
            context.draw(signs.slip, at: center)
        case .notScheduled:
            let inset = Path(roundedRect: rect.insetBy(dx: 0.75, dy: 0.75), cornerRadius: corner - 0.5, style: .continuous)
            context.stroke(inset, with: .color(ink.dash), style: StrokeStyle(lineWidth: 1.5, dash: [3, 2.5]))
        }
    }

    struct Signs {
        let more: GraphicsContext.ResolvedText
        let skip: GraphicsContext.ResolvedText
        let pause: GraphicsContext.ResolvedText
        let slip: GraphicsContext.ResolvedText
        init(_ context: GraphicsContext, ink: Ink) {
            func sign(_ name: String, _ color: Color, size: CGFloat = 8) -> GraphicsContext.ResolvedText {
                context.resolve(Text(Image(systemName: name)).font(.system(size: size, weight: .bold)).foregroundColor(color))
            }
            more = sign("arrowtriangle.up.fill", .white)
            skip = sign("forward.fill", ink.sign)
            pause = sign("pause.fill", ink.sign)
            slip = sign("xmark", ink.sign, size: 9)
        }
    }

    private static func hex(_ v: Int) -> Color {
        Color(.sRGB, red: Double(v >> 16 & 0xFF) / 255, green: Double(v >> 8 & 0xFF) / 255, blue: Double(v & 0xFF) / 255)
    }
}

/// A habit's year on its card: the weekday letters, fixed, beside the year's squares, which scroll sideways and open on
/// the latest weeks.
struct YearHeatMap: View {
    let layout: YearLayout
    let days: [WeekCardDay]
    let color: HabitColor

    var body: some View {
        HStack(alignment: .top, spacing: 6) {
            VStack(spacing: YearGrid.gap) {
                ForEach(0..<7, id: \.self) { row in
                    let isToday = row == layout.todayRow
                    Text(row < layout.letters.count ? layout.letters[row] : "")
                        .font(.caption2.weight(isToday ? .bold : .medium))
                        .foregroundStyle(isToday ? Color.primary : Color.secondary)
                        .underline(isToday)
                        .frame(width: 14, height: YearGrid.cell)
                }
            }
            .padding(.top, YearGrid.labels)
            ScrollView(.horizontal) {
                YearSquares(layout: layout, styles: days.prefix(layout.shown).map { YearCellStyle($0) }, color: color)
            }
            .scrollIndicators(.hidden)
            .defaultScrollAnchor(.trailing)
        }
        .accessibilityHidden(true)
    }
}

/// The squares and the month names, drawn in one pass.
private struct YearSquares: View, Equatable {
    let layout: YearLayout
    let styles: [YearCellStyle]
    let color: HabitColor
    @Environment(\.colorScheme) private var scheme

    static func == (a: Self, b: Self) -> Bool { a.layout == b.layout && a.styles == b.styles && a.color == b.color }

    var body: some View {
        let columns = layout.columns
        // Room after the last column for a month name that starts there.
        let tail: CGFloat = layout.months.last?.column == columns - 1 ? 12 : 0
        let dark = scheme == .dark
        Canvas { context, _ in
            let ink = YearGrid.Ink(dark: dark)
            let signs = YearGrid.Signs(context, ink: ink)
            for month in layout.months {
                context.draw(Text(month.name).font(.caption2.weight(.medium)).foregroundColor(ink.label),
                             at: CGPoint(x: CGFloat(month.column) * YearGrid.pitch, y: 0), anchor: .topLeading)
            }
            for (i, style) in styles.enumerated() where style != .blank {
                let place = layout.lead + i
                let rect = CGRect(x: CGFloat(place / 7) * YearGrid.pitch,
                                  y: YearGrid.labels + CGFloat(place % 7) * YearGrid.pitch,
                                  width: YearGrid.cell, height: YearGrid.cell)
                YearGrid.draw(style, in: rect, context: context, color: color, dark: dark, ink: ink, signs: signs)
            }
        }
        .frame(width: max(YearGrid.cell, CGFloat(columns) * YearGrid.pitch - YearGrid.gap + tail),
               height: YearGrid.labels + 7 * YearGrid.pitch - YearGrid.gap)
    }
}

/// One square as the cards draw it, for the key.
struct YearKeyCell: View {
    let style: YearCellStyle
    var color: HabitColor = .green
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        let dark = scheme == .dark
        Canvas { context, size in
            let ink = YearGrid.Ink(dark: dark)
            YearGrid.draw(style, in: CGRect(origin: .zero, size: size), context: context, color: color, dark: dark,
                          ink: ink, signs: YearGrid.Signs(context, ink: ink))
        }
        .frame(width: YearGrid.cell, height: YearGrid.cell)
        .accessibilityHidden(true)
    }
}

/// The Year key's entries (the user, 2 Oct 2026): every square the cards can show, in plain words. Partial shows its
/// three steps side by side, so "lighter means less" is seen, not only read.
struct YearKeyEntry: Identifiable {
    let name: String
    let meaning: String
    let styles: [YearCellStyle]
    var id: String { name }

    static let habits: [YearKeyEntry] = [
        YearKeyEntry(name: "Done", meaning: "The day's goal was reached.", styles: [.full]),
        YearKeyEntry(name: "Partial", meaning: "Some of the day's goal was done. The lighter the square, the less: up to a third, up to two thirds, or more.",
                     styles: [.shade(0), .shade(1), .shade(2)]),
        YearKeyEntry(name: "More than the goal", meaning: "Done, and more than the day's goal. On a “no more than” habit, ▲ means over the limit.",
                     styles: [.more]),
        YearKeyEntry(name: "Not done", meaning: "A day it was due ended with nothing logged. Today stays grey until you log it; its weekday letter is underlined.",
                     styles: [.empty]),
        YearKeyEntry(name: "Not scheduled", meaning: "Not one of its days, or nothing logged that day toward a weekly or monthly goal. Never counts against it.",
                     styles: [.notScheduled]),
        YearKeyEntry(name: "Skipped", meaning: "You skipped it that day. Doesn't count either way.", styles: [.skipped]),
        YearKeyEntry(name: "Paused", meaning: "The habit was paused. Doesn't count either way.", styles: [.paused]),
        YearKeyEntry(name: "No square", meaning: "Days before the habit started. Days still to come aren't drawn: the last column ends today.",
                     styles: []),
    ]
    static let quit: [YearKeyEntry] = [
        YearKeyEntry(name: "Clean day", meaning: "No slip was logged that day.", styles: [.full]),
        YearKeyEntry(name: "Slip", meaning: "A slip was logged that day.", styles: [.slip]),
    ]
}

struct YearKeyRow: View {
    let entry: YearKeyEntry

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            HStack(spacing: 3) {
                ForEach(Array(entry.styles.enumerated()), id: \.offset) { YearKeyCell(style: $0.element) }
            }
            .frame(width: 3 * YearGrid.cell + 6, alignment: .leading)
            VStack(alignment: .leading, spacing: WeekSpacing.label) {
                Text(entry.name).font(.subheadline.weight(.semibold))
                Text(entry.meaning).font(.footnote).foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .accessibilityElement(children: .combine)
    }
}

extension HabitColor {
    /// The three part-done steps of the habit's colour, least to most (the user, 2 Oct 2026: "use OKLCH"). Each step
    /// sits at one OKLCH lightness for every hue, so no colour's steps look stronger than another's, and keeps its hue
    /// with as much of its saturation as fits the screen. Light mode: 0.865, 0.785, 0.71, lighter than the done colour
    /// (0.64) and darker than the empty grey (0.92). Dark mode: 0.40, 0.48, 0.56, deeper than the done colour and
    /// brighter than the grey (0.29), as GitHub's dark grid. Made by `Research/Temp/year_palette.py`, never while drawing.
    func yearShade(_ level: Int, dark: Bool) -> Color {
        guard let steps = Self.yearShades[self] else { return mark.opacity(0.3 + 0.2 * Double(level)) }
        let list = dark ? steps.dark : steps.light
        return Self.shadeHex(list[max(0, min(2, level))])
    }

    private static let yearShades: [HabitColor: (light: [Int], dark: [Int])] = [
        .red: ([0xFFC1B8, 0xFE998B, 0xFD6E5E], [0x782A22, 0xA42C23, 0xD02D24]),
        .orange: ([0xF0CBAA, 0xE4AC7A, 0xD78F4A], [0x623F1C, 0x844F16, 0xA7610A]),
        .yellow: ([0xE0D2AB, 0xCDB77B, 0xBB9F4B], [0x54461D, 0x705B17, 0x8D710C]),
        .green: ([0xB1E1B6, 0x82CE8C, 0x52BB65], [0x20542A, 0x1A702F, 0x0D8C36]),
        .mint: ([0xB1DDD9, 0x83C8C2, 0x53B4AD], [0x20514E, 0x1B6B66, 0x0F8680]),
        .teal: ([0xB0DBE5, 0x82C5D4, 0x52B1C4], [0x204F59, 0x1A6877, 0x0E8396]),
        .cyan: ([0xAFDAF2, 0x81C3E7, 0x50ADDC], [0x1F4D65, 0x196589, 0x0C7EAD]),
        .blue: ([0xB8D5FE, 0x8CBBFF, 0x63A2FD], [0x254879, 0x275CA6, 0x2A72D4]),
        .indigo: ([0xC8CFFF, 0xA9B2FE, 0x8E95FD], [0x3D4178, 0x4F52A5, 0x6265D2]),
        .purple: ([0xE7C2FE, 0xD79EF8, 0xC77CF1], [0x5A356F, 0x794097, 0x984BC0]),
        .pink: ([0xFEC0C1, 0xFE979B, 0xFE6976], [0x792730, 0xA52639, 0xD12444]),
        .brown: ([0xDED0C0, 0xCAB59D, 0xB79D7D], [0x524535, 0x6D5A42, 0x897050]),
        .gray: ([0xD2D2D4, 0xB8B8BC, 0xA1A1A5], [0x474749, 0x5D5D60, 0x747478]),
    ]

    private static func shadeHex(_ v: Int) -> Color {
        Color(.sRGB, red: Double(v >> 16 & 0xFF) / 255, green: Double(v >> 8 & 0xFF) / 255, blue: Double(v & 0xFF) / 255)
    }
}
