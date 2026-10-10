import SwiftUI

// Shared by the Watch app and its complications. Colour belongs to the habits; the chrome is monochrome (U2). The
// Watch is always dark, so each habit's system colour reads on it as is (the iPhone's `HabitColor.color`). Colours are
// named as the snapshot names them (`WidgetItem.color`), so the complications need no app model.

enum WatchPalette {
    static func color(_ name: String) -> Color {
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

    /// Platters (rows, glass buttons): the system's own dark fill.
    static let platter = Color.white.opacity(0.14)
    /// A habit's progress fill over a platter: its colour, dimmed so white text stays readable.
    static func fill(_ name: String) -> Color { color(name).opacity(0.42) }
    /// A limit fills neutral grey, never the habit's colour and never red (H1, U25).
    static let limitFill = Color.white.opacity(0.26)
}
