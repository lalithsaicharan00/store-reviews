import SwiftUI
import UIKit

/// The widgets' colours (Implementation Spec §2), shared with the app where they are the same thing: the habit icon's
/// colour (`HabitColor.mark` reads `markHex`), so a widget's icon is exactly the app's.
nonisolated enum WidgetPalette {
    /// Each habit colour at one lightness (OKLCH 0.64): see `HabitColor.mark`.
    static let markHex: [String: Int] = [
        "red": 0xFA352B, "orange": 0xC97505, "yellow": 0xAA8809, "green": 0x07A941,
        "mint": 0x09A19A, "teal": 0x079DB4, "cyan": 0x0698D0, "blue": 0x3289FF,
        "indigo": 0x7679FC, "purple": 0xB75AE7, "pink": 0xFB2852, "brown": 0xA48660,
        "gray": 0x8B8B90,
    ]

    static func hex(_ v: Int) -> Color {
        Color(.sRGB, red: Double(v >> 16 & 0xFF) / 255, green: Double(v >> 8 & 0xFF) / 255, blue: Double(v & 0xFF) / 255)
    }

    /// The habit's icon colour.
    static func mark(_ name: String) -> Color { hex(markHex[name] ?? markHex["blue"]!) }

    /// The habit's main colour: the system colour the app uses for a done button and row fills (`HabitColor.color`).
    static func main(_ name: String) -> Color {
        switch name {
        case "red": .red
        case "orange": .orange
        case "yellow": .yellow
        case "green": .green
        case "mint": .mint
        case "teal": .teal
        case "cyan": .cyan
        case "indigo": .indigo
        case "purple": .purple
        case "pink": .pink
        case "brown": .brown
        case "gray": .gray
        default: .blue
        }
    }

    /// Charcoal in light mode, off-white in dark: the app's ink (`Color.ink`).
    static let ink = Color(UIColor { $0.userInterfaceStyle == .dark
        ? UIColor(red: 0.925, green: 0.925, blue: 0.935, alpha: 1)
        : UIColor(red: 0.153, green: 0.153, blue: 0.165, alpha: 1) })
    /// A limit's fill: neutral grey, never the habit's colour and never red (the user, 6 Oct 2026).
    static let limitFill = Color(UIColor { $0.userInterfaceStyle == .dark
        ? UIColor(red: 0x63 / 255, green: 0x63 / 255, blue: 0x66 / 255, alpha: 1)
        : UIColor(red: 0x86 / 255, green: 0x86 / 255, blue: 0x8B / 255, alpha: 1) })
    /// The weekly widget's cards (`weekly-widget/container`) and an empty day's square (`weekly-widget/empty-day`).
    /// In dark mode grey squares sit on #1C1C1E, never #2C2C2E (found 6 Oct 2026).
    static let container = Color(UIColor { $0.userInterfaceStyle == .dark
        ? UIColor(red: 0x1C / 255, green: 0x1C / 255, blue: 0x1E / 255, alpha: 1)
        : UIColor(red: 0xF2 / 255, green: 0xF2 / 255, blue: 0xF7 / 255, alpha: 1) })
    static let emptyDayLight = 0xDEDEE3, emptyDayDark = 0x2C2C2E
    /// ✕, ⏩ and ⏸ on a grey square; the dashed and today outlines (#86868B: 3.25:1 on the week card).
    static let signLight = 0x6C6C70, signDark = 0x98989F
    static let outlineLight = 0x86868B, outlineDark = 0x7C7C80
}
