import SwiftUI

/// The ≡ menu's state, and Today's navigation path, which the menu pushes onto (the user's decision, 30 Sep 2026:
/// everything that isn't daily lives in the menu; `Docs/Checklists/Sidebar Menu.md`).
///
/// Today never reads `isOpen`: opening, dragging and closing the menu redraw only the menu and its dimming, never
/// Today's list ("Speed: every tap answers at once" in the Design Rules).
@Observable final class MenuModel {
    var isOpen = false
    /// How far a finger has dragged the menu right (+, opening from Today's edge) or left (−, closing it).
    /// Only the menu layer reads it, so a drag frame redraws nothing else.
    var drag: CGFloat = 0
    /// Whether the menu's rows exist. They're made as it starts to open and removed once it has finished closing:
    /// a closed menu does no work, and VoiceOver can't land on rows that are off screen (`accessibilityHidden`
    /// doesn't reach inside a `List`'s cells; found by `TodayUITests.testMenu`, 30 Sep).
    var mounted = false
    /// Today's navigation stack. A menu row appends its place; the habit page appends a habit's ID.
    var path = NavigationPath()

    /// Opens or closes the menu from wherever a finger left it, and on closing can open `place` on Today's stack in
    /// the same animation.
    func setOpen(_ open: Bool, reduceMotion: Bool, then place: MenuPlace? = nil) {
        if open { mounted = true }
        withAnimation(MenuModel.motion(reduceMotion)) {
            isOpen = open
            drag = 0
            if let place { path.append(place) }
        } completion: { [self] in
            if !isOpen && drag == 0 { mounted = false }
        }
    }

    /// Closes the menu and opens `place` on Today's stack.
    func go(to place: MenuPlace, reduceMotion: Bool) {
        setOpen(false, reduceMotion: reduceMotion, then: place)
    }

    /// Back to Today itself at once (a tapped notification): the menu closes and any page it opened goes.
    func reset() {
        isOpen = false
        drag = 0
        mounted = false
        path = NavigationPath()
    }

    /// The system's own spring for a panel sliding in; a short fade with Reduce Motion on.
    static func motion(_ reduceMotion: Bool) -> Animation {
        reduceMotion ? .easeInOut(duration: 0.2) : .snappy(duration: 0.3)
    }
}

/// Every row in the ≡ menu, most used first. The names are the pages' titles, so a row and the page it opens always
/// say the same thing.
enum MenuPlace: String, Hashable, CaseIterable, Identifiable {
    case progress, habits, tasks
    case timesOfDay, dayAndWeek, reminders, appearance, widgets
    case backup, privacy
    case plus
    case help, about

    var id: String { rawValue }

    /// The menu's groups, separated by a gap like the iPhone's own Settings.
    static let groups: [[MenuPlace]] = [[.progress, .habits, .tasks], [.timesOfDay, .dayAndWeek, .reminders, .appearance, .widgets],
                                        [.backup, .privacy], [.plus], [.help, .about]]

    var title: String {
        switch self {
        case .progress: "Progress"
        case .habits: "Habits"
        case .tasks: "Tasks"
        case .timesOfDay: "Times of Day"
        case .dayAndWeek: "Day and Week"
        case .reminders: "Reminders"
        case .appearance: "Appearance"
        case .widgets: "Widgets"
        case .backup: "Backup & Export"
        case .privacy: "Privacy"
        case .plus: "Plus"
        case .help: "Help & Feedback"
        case .about: "About"
        }
    }

    /// Monochrome: colour belongs to habits only (Build Plan #11).
    var symbol: String {
        switch self {
        case .progress: "chart.bar.xaxis"
        case .habits: "checklist"
        case .tasks: "list.bullet"
        case .timesOfDay: "rectangle.split.3x1"
        case .dayAndWeek: "calendar"
        case .reminders: "bell"
        case .appearance: "circle.lefthalf.filled"
        case .widgets: "rectangle.on.rectangle"
        case .backup: "externaldrive"
        case .privacy: "hand.raised"
        case .plus: "plus.circle"
        case .help: "questionmark.circle"
        case .about: "info.circle"
        }
    }

    /// What a page that isn't built yet will hold (Build Plan #60, #61), shown on its "coming" page.
    var plan: String? {
        switch self {
        case .reminders: "Whether notifications and alarms are allowed, and what a new reminder starts as."
        case .backup: "Backups on this phone, a copy you can export or import, and moving to a new phone."
        case .privacy: "Lock the app with Face ID, and erase your data."
        case .help: "Answers to common questions, and a way to reach us."
        case .about: "The privacy policy and terms."
        case .progress, .habits, .tasks, .timesOfDay, .dayAndWeek, .appearance, .widgets, .plus: nil
        }
    }
}
