import SwiftUI
import UIKit

// MARK: - The app's colour system
//
// One place for every colour the iPhone app, its widgets and its Live Activity draw (17 Nov 2026). The source is the
// "IOS app" Figma file, design system › 02 · Colour, and its 131 colour styles; the table of every style, with its
// light and dark values, is in iOS/Docs/Colours — iOS Native.md.
//
// 1. Apple's colours are called by Apple's names, never by a value. iOS has them all, with their own dark mode,
//    Increase Contrast and future changes (iOS 26's Red is #FF383C, not the older #FF3B30), so nothing here copies
//    one. Figma's `iOS/<Group>/<Name>` styles exist only because Figma has no iOS colours of its own:
//
//      Figma style                              Swift
//      Label / Label                            .primary as a foreground, Color(.label) as a fill
//      Label / Secondary, Tertiary, Quaternary  .secondary, .tertiary, .quaternary; Color(.secondaryLabel) …
//      Label / Placeholder Text                 Color(.placeholderText) (a TextField draws its own)
//      Separator / Separator, Opaque Separator  Color(.separator), Color(.opaqueSeparator)
//      Fill / System … Quaternary System Fill   Color(.systemFill) … Color(.quaternarySystemFill), by shape size
//      Background / …                           Color(.systemBackground) and its Secondary and Tertiary
//      Grouped Background / …                   Color(.systemGroupedBackground) and its Secondary and Tertiary
//      Standard / System Red … System Brown     .red … .brown (a habit's base: HabitColor.color below)
//      Standard / System Gray … Gray 6          .gray, Color(.systemGray2) … Color(.systemGray6)
//      Standard / White, Black                  .white, .black
//      Custom / Dimming                         nothing: iOS draws it behind a sheet or an alert itself
//
//    Left out on purpose: `.accentColor`, `.link` and iOS's blue tint. The chrome stays neutral; colour belongs to
//    the habits (the user, 5 Nov 2026).
//
// 2. Ours, because iOS has no such colour: Ink and On Ink (below), and a habit's shades (HabitColor).
//
// Light mode is Figma's. Figma has no dark mode, so the dark values are derived from the light ones by the same
// rules and are written next to each; check them on the iPhone before calling dark mode done.

nonisolated enum Palette {
    /// `iOS/Custom/Ink`: the neutral main colour, where iOS would use its blue. Filled buttons, the cursor, selected
    /// controls, the progress bar. Charcoal #303030 in light mode, near-white #F2F2F5 in dark (the user, 5 Nov 2026).
    static let ink = dynamic(light: 0x303030, dark: 0xF2F2F5)
    /// `iOS/Custom/On Ink`: words and icons on Ink. White in light mode, #1C1C1E in dark.
    static let onInk = dynamic(light: 0xFFFFFF, dark: 0x1C1C1E)

    /// A colour from 0xRRGGBB, in sRGB.
    static func srgb(_ value: UInt32) -> UIColor {
        UIColor(red: CGFloat(value >> 16 & 0xFF) / 255, green: CGFloat(value >> 8 & 0xFF) / 255,
                blue: CGFloat(value & 0xFF) / 255, alpha: 1)
    }

    /// One colour in light mode and another in dark, chosen by iOS as the appearance changes.
    static func dynamic(light: UInt32, dark: UInt32) -> Color {
        Color(uiColor: UIColor { $0.userInterfaceStyle == .dark ? srgb(dark) : srgb(light) })
    }

    /// Light mode with Increase Contrast on, whatever the phone is set to: the darker value Apple gives each standard
    /// colour, on which white is 4.5:1 or more. UIKit builds trait collections on the main actor.
    @MainActor fileprivate static var increasedContrastTraits: UITraitCollection {
        UITraitCollection { traits in
            traits.userInterfaceStyle = .light
            traits.accessibilityContrast = .high
        }
    }
}

extension Color {
    /// `iOS/Custom/Ink` (`Palette.ink`).
    static let ink = Palette.ink
    /// `iOS/Custom/On Ink` (`Palette.onInk`).
    static let onInk = Palette.onInk
}

// MARK: - Habit colours

/// A habit's colour: one of iOS's 13 standard hues, stored by its raw value ("blue").
///
/// Each has the shades Figma names `iOS/Habit/<Hue>/<Shade>`. `color` and `increasedContrast` are Apple's, called by
/// name; the rest are ours. Every shade is worked out once and kept by the hue's place in `allCases`, so reading one in
/// a view's body is a jump and an array read: no hashing of the name, nothing to unwrap.
nonisolated enum HabitColor: String, CaseIterable, Codable, Sendable {
    case red, orange, yellow, green, mint, teal, cyan, blue, indigo, purple, pink, brown, gray

    /// `iOS/Standard/System <Hue>`: the habit's colour, as iOS draws it in light and dark.
    var color: Color {
        switch self {
        case .red: .red
        case .orange: .orange
        case .yellow: .yellow
        case .green: .green
        case .mint: .mint
        case .teal: .teal
        case .cyan: .cyan
        case .blue: .blue
        case .indigo: .indigo
        case .purple: .purple
        case .pink: .pink
        case .brown: .brown
        case .gray: .gray
        }
    }

    /// `Increased Contrast`: Apple's own darker value of this hue (the one iOS uses with Increase Contrast on). For
    /// anything that carries white. The same in dark mode, so white on it stays readable there too. Read on the main
    /// actor, as a view's body is.
    @MainActor var increasedContrast: Color { Self.increasedContrasts[place] }
    /// `Deep`: ours. Increased Contrast mixed 30 % with black. The milestone bar's dark end and words on Milestone
    /// Band. The same in dark mode.
    var deep: Color { Self.shades[place].deep }
    /// `Gradient Top`: the top of iOS's own `Color.<hue>.gradient`, read from the phone. The medal's light end.
    var gradientTop: Color { Self.shades[place].gradientTop }
    /// `Fill`: ours. Today's progress fill, everywhere a habit's progress fills a row or card. Opaque, on a card.
    var fill: Color { Self.shades[place].fill }
    /// `Milestone Band`: ours. One step stronger than Fill.
    var milestoneBand: Color { Self.shades[place].milestoneBand }
    /// `Bar`: ours. The milestone bar, Deep at the leading edge to Increased Contrast at the trailing edge.
    @MainActor var bar: LinearGradient {
        LinearGradient(colors: [deep, increasedContrast], startPoint: .leading, endPoint: .trailing)
    }
    /// `Medal`: ours. The milestone medal, Gradient Top at the top to Increased Contrast at the bottom.
    @MainActor var medal: LinearGradient {
        LinearGradient(colors: [gradientTop, increasedContrast], startPoint: .top, endPoint: .bottom)
    }

    private struct Shades: Sendable {
        let deep, gradientTop, fill, milestoneBand: Color
    }

    /// The hue's place in `allCases`, the index of every table below (kept in the order the cases are declared).
    private var place: Int {
        switch self {
        case .red: 0
        case .orange: 1
        case .yellow: 2
        case .green: 3
        case .mint: 4
        case .teal: 5
        case .cyan: 6
        case .blue: 7
        case .indigo: 8
        case .purple: 9
        case .pink: 10
        case .brown: 11
        case .gray: 12
        }
    }

    @MainActor private static let increasedContrasts: [Color] = allCases.map { hue in
        Color(uiColor: hue.systemColor.resolvedColor(with: Palette.increasedContrastTraits))
    }

    /// Our values, 0xRRGGBB. Light: Figma's styles, as measured and chosen on 5 Nov 2026. Fill and Milestone Band are
    /// the app's green at 15 % on white (#E1F7E6) and one step stronger, carried to each hue in OKLCH (Fill L 0.955
    /// C 0.032, Band L 0.924 C 0.053; Brown at 0.42× chroma, Gray none). Dark, derived 17 Nov 2026 the same way from
    /// the app's dark green fill (green at 26 % on #1C1C1E, #214B2D: Fill L 0.374 C 0.070, Band L 0.430 C 0.085),
    /// chroma lowered only where sRGB can't hold it.
    private static let values: [HabitColor: (deep: UInt32, gradientTop: UInt32,
                                            fill: UInt32, fillDark: UInt32, band: UInt32, bandDark: UInt32)] = [
        .red: (0x900818, 0xFF6367, 0xFFEBE9, 0x60312D, 0xFFDDD9, 0x783B37),
        .orange: (0x793000, 0xFFAD58, 0xFFECE0, 0x5C3618, 0xFFDFC9, 0x72421B),
        .yellow: (0x623F00, 0xFFCC00, 0xF8F0D8, 0x4C400B, 0xF3E5BF, 0x5F4F07),
        .green: (0x00531B, 0x62DD81, 0xE1F7E6, 0x254B2A, 0xCCF1D6, 0x2C5C33),
        .mint: (0x005046, 0x37DFCD, 0xDAF8F2, 0x014C43, 0xC0F2E8, 0x015D53),
        .teal: (0x004E5C, 0x37DBE6, 0xD8F7FA, 0x014A50, 0xBDF1F6, 0x015B62),
        .cyan: (0x004C6A, 0x37D8FA, 0xDAF6FF, 0x00485B, 0xC0EFFF, 0x01596F),
        .blue: (0x0E4197, 0x2FA9FF, 0xE7F1FF, 0x234264, 0xD6E8FF, 0x29527D),
        .indigo: (0x322A89, 0x887DFF, 0xEDEFFF, 0x363D65, 0xE0E4FF, 0x424B7E),
        .purple: (0x6C1977, 0xE95DFC, 0xFBEAFD, 0x523356, 0xF8DBFB, 0x663F6B),
        .pink: (0x8F072C, 0xFF5A7F, 0xFFEBEB, 0x603034, 0xFFDCDC, 0x773A40),
        .brown: (0x5A412F, 0xCBA489, 0xF8EEE8, 0x4D3D31, 0xF2E3D8, 0x5F4B3C),
        .gray: (0x404043, 0xB0B0B5, 0xF0F0F0, 0x414141, 0xE6E6E6, 0x505050),
    ]

    /// Built once, in `allCases` order, so `place` finds each hue's (a missing hue in `values` stops the app at once,
    /// at launch, rather than drawing a wrong colour).
    private static let shades: [Shades] = {
        assert(allCases.indices.allSatisfy { allCases[$0].place == $0 }, "HabitColor.place must follow the cases' order")
        return allCases.map { hue in
            let v = values[hue]!
            return Shades(
                deep: Color(uiColor: Palette.srgb(v.deep)),
                gradientTop: Color(uiColor: Palette.srgb(v.gradientTop)),
                fill: Palette.dynamic(light: v.fill, dark: v.fillDark),
                milestoneBand: Palette.dynamic(light: v.band, dark: v.bandDark))
        }
    }()

    /// The UIKit colour behind `color`, for resolving it under other traits.
    private var systemColor: UIColor {
        switch self {
        case .red: .systemRed
        case .orange: .systemOrange
        case .yellow: .systemYellow
        case .green: .systemGreen
        case .mint: .systemMint
        case .teal: .systemTeal
        case .cyan: .systemCyan
        case .blue: .systemBlue
        case .indigo: .systemIndigo
        case .purple: .systemPurple
        case .pink: .systemPink
        case .brown: .systemBrown
        case .gray: .systemGray
        }
    }
}
