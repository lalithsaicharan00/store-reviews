import SwiftUI
import UIKit

/// The widgets' colours (Implementation Spec §2). A habit's colour is the app's own (`HabitColor`, Shared/Palette.swift),
/// so a widget's icon is exactly the app's.
nonisolated enum WidgetPalette {
    static func hex(_ v: Int) -> Color {
        Color(.sRGB, red: Double(v >> 16 & 0xFF) / 255, green: Double(v >> 8 & 0xFF) / 255, blue: Double(v & 0xFF) / 255)
    }

    /// The habit's colour, for its icon and its done button: the iOS system colour (`HabitColor.color`), as in Figma.
    /// The icons' own darker set (OKLCH 0.64, 2 Oct 2026) was retired on 17 Nov 2026 for Figma's colours.
    static func main(_ name: String) -> Color { (HabitColor(rawValue: name) ?? .blue).color }

    /// The app's ink (`Palette.ink`, Shared/Palette.swift).
    static let ink = Palette.ink
    /// A limit's fill: neutral grey, never the habit's colour and never red (the user, 6 Oct 2026).
    static let limitFill = Color(UIColor { $0.userInterfaceStyle == .dark
        ? UIColor(red: 0x63 / 255, green: 0x63 / 255, blue: 0x66 / 255, alpha: 1)
        : UIColor(red: 0x86 / 255, green: 0x86 / 255, blue: 0x8B / 255, alpha: 1) })
    /// The weekly widget's cards (`weekly-widget/container`) and an empty day's square (`weekly-widget/empty-day`).
    /// In dark mode grey squares sit on #1C1C1E, never #2C2C2E (found 6 Oct 2026).
    static let container = Color(UIColor { $0.userInterfaceStyle == .dark
        ? UIColor(red: 0x1C / 255, green: 0x1C / 255, blue: 0x1E / 255, alpha: 1)
        : UIColor(red: 0xF2 / 255, green: 0xF2 / 255, blue: 0xF7 / 255, alpha: 1) })
    /// A list's count pill (Figma's Count, 21 Nov 2026): Tertiary System Fill as it shows over the widget's white
    /// (#EFEFF0), painted solid so a row's tap can draw the new count on an identical pill over it (W12). Dark: #3A3A3C.
    static let countPill = Color(UIColor { $0.userInterfaceStyle == .dark
        ? UIColor(red: 0x3A / 255, green: 0x3A / 255, blue: 0x3C / 255, alpha: 1)
        : UIColor(red: 0xEF / 255, green: 0xEF / 255, blue: 0xF0 / 255, alpha: 1) })
    static let emptyDayLight = 0xDEDEE3, emptyDayDark = 0x2C2C2E
    /// ✕, ⏩ and ⏸ on a grey square; the dashed and today outlines (#86868B: 3.25:1 on the week card).
    static let signLight = 0x6C6C70, signDark = 0x98989F
    static let outlineLight = 0x86868B, outlineDark = 0x7C7C80
}
