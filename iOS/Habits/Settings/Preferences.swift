import AudioToolbox
import SwiftUI
import UIKit

/// This phone's own choices (≡ → Appearance; Build Plan #61). They're about how the app looks and feels on this phone,
/// not the person's data, so they live in UserDefaults, not the database. Defaults from the research
/// "Ticking Off, Folding and Small Settings — What People Need" (1 Oct 2026).
enum Preferences {
    /// Automatic, Light or Dark (`Theme`).
    static let theme = "appearance.theme"
    /// A light tap for each log and a "success" when a habit is done. On: it's private, and people praise it.
    static let haptics = "feedback.haptics"
    /// A short chime when a habit is done. Off: sound is public, and some find app sounds intrusive.
    static let sound = "feedback.sound"
    /// Where done habits go on Today (`DoneOrder`).
    static let doneOrder = "today.doneOrder"
    /// Today's Filter: leave done habits, or done tasks, off Today (the user, 3 Oct 2026). Off by default.
    static let hideDoneHabits = "today.hideDoneHabits"
    static let hideDoneTasks = "today.hideDoneTasks"

    static func register() {
        UserDefaults.standard.register(defaults: [theme: Theme.automatic.rawValue, haptics: true, sound: false,
                                                  doneOrder: DoneOrder.inPlace.rawValue])
    }
}

enum Theme: String, CaseIterable, Identifiable {
    case automatic, light, dark
    var id: String { rawValue }

    var title: String {
        switch self {
        case .automatic: "Automatic"
        case .light: "Light"
        case .dark: "Dark"
        }
    }

    var style: UIUserInterfaceStyle {
        switch self {
        case .automatic: .unspecified
        case .light: .light
        case .dark: .dark
        }
    }

    /// Applied to every window, so sheets, alerts and menus are never left in the other mode (a `preferredColorScheme`
    /// on the root view reaches a sheet only when it's next shown).
    @MainActor static func apply(_ raw: String) {
        let style = (Theme(rawValue: raw) ?? .automatic).style
        for case let scene as UIWindowScene in UIApplication.shared.connectedScenes {
            for window in scene.windows where window.overrideUserInterfaceStyle != style {
                window.overrideUserInterfaceStyle = style
            }
        }
    }
}

/// Where a habit goes on Today once it's done. It stays where the person put it by default (the user, 3 Oct 2026:
/// order is the person's own, Rulebook U13); Move to Bottom is one tap away in Appearance for the many who want it
/// (research "Ticking Off, Folding and Small Settings" §2: 90 of 243 reviews want done ones below, 7 kept in place).
enum DoneOrder: String, CaseIterable, Identifiable {
    case inPlace, bottom
    var id: String { rawValue }

    var title: String {
        switch self {
        case .bottom: "Move to Bottom"
        case .inPlace: "Stay in Place"
        }
    }
}

/// What a person feels and hears when they log on Today (research §1). Fired by the tap itself, never by a redraw:
/// going to another day where a habit is done must not buzz.
@MainActor enum TickFeedback {
    private static let light = UIImpactFeedbackGenerator(style: .light)
    private static let success = UINotificationFeedbackGenerator()
    /// The chime, made once. A system sound follows the silent switch and mixes with music instead of stopping it.
    private static let chime: SystemSoundID? = {
        guard let url = Bundle.main.url(forResource: "Tick", withExtension: "wav") else { return nil }
        var id: SystemSoundID = 0
        return AudioServicesCreateSystemSoundID(url as CFURL, &id) == kAudioServicesNoError ? id : nil
    }()

    static var hapticsOn: Bool { UserDefaults.standard.bool(forKey: Preferences.haptics) }
    static var soundOn: Bool { UserDefaults.standard.bool(forKey: Preferences.sound) }

    /// One log: a light tap on the way to the goal; a success tap (and the chime, if on) when it makes the habit done.
    static func logged(finished: Bool) {
        if hapticsOn {
            if finished { success.notificationOccurred(.success) } else { light.impactOccurred() }
        }
        if finished && soundOn { playChime() }
    }

    /// A timer started: a light tap, nothing logged yet.
    static func started() {
        if hapticsOn { light.impactOccurred() }
    }

    /// An undo or an un-tick: a light tap, no sound.
    static func undone() {
        if hapticsOn { light.impactOccurred(intensity: 0.6) }
    }

    /// Plays the chime regardless of the switch (the Sound row plays it once when turned on).
    static func playChime() {
        if let chime { AudioServicesPlaySystemSound(chime) }
    }
}

/// The app's one motion for a tick and for folding (research §1, §3): short springs with no bounce, never holding up
/// the next tap. With Reduce Motion on, nothing slides or bounces.
enum Motion {
    /// A log on Today: the button fills, the row's colour sweeps across.
    static func tick(_ reduceMotion: Bool) -> Animation? { reduceMotion ? nil : .snappy(duration: 0.3) }
    /// Opening and closing a time of day: the header stays still and the rows come out from under it.
    static func fold(_ reduceMotion: Bool) -> Animation { reduceMotion ? .easeInOut(duration: 0.2) : .snappy(duration: 0.32) }
    /// Done rows settling below the rest, and finished parts folding, once the person pauses.
    static func settle(_ reduceMotion: Bool) -> Animation { reduceMotion ? .easeInOut(duration: 0.2) : .smooth(duration: 0.45) }
}
