import SwiftUI
import UIKit

/// The device the app is running on, for the few things that differ on the iPad (Current Work 86, `iOS/Docs/iPad/`).
/// The layout follows the window's size class, never this (Apple: "Determine layout based on size classes, not device
/// type"); this only decides what the iPad has that the iPhone doesn't (the sidebar, popovers, the menu bar's commands)
/// and the words that name the device. On the iPhone every value here is the iPhone's, so nothing there changes.
enum Device {
    static let isPad = UIDevice.current.userInterfaceIdiom == .pad
    /// "iPad" or "iPhone": the words that name this device come from the device, never typed twice (README, "Words
    /// that change on the iPad").
    static let name = isPad ? "iPad" : "iPhone"
    /// What Plus adds on this device: the *other* devices ("Your iPhone and Apple Watch" when read on an iPad).
    static let otherDevices = isPad ? "Your iPhone and Apple Watch" : "Your iPad and Apple Watch"

    /// The iPhone's words, said for this device: on the iPhone exactly as written; on the iPad "this iPhone" reads "this
    /// iPad", "iPhone Settings" "iPad Settings", "≡ › Day and Week" "the sidebar › Day and Week" (the iPad has no ≡).
    /// Only phrases that name *this* device change: "iPhone, iPad, Apple Watch" in a list of devices stays as it is.
    static func words(_ text: String) -> String {
        guard isPad else { return text }
        var out = text
        for (iPhone, iPad) in phrases where out.contains(iPhone) {
            out = out.replacingOccurrences(of: iPhone, with: iPad)
        }
        return out
    }

    private static let phrases: [(String, String)] = [
        ("this iPhone", "this iPad"), ("This iPhone", "This iPad"), ("your iPhone", "your iPad"), ("Your iPhone", "Your iPad"),
        ("iPhone Settings", "iPad Settings"), ("iPhone Passcode", "iPad Passcode"), ("iPhone passcode", "iPad passcode"),
        ("which iPhone", "which iPad"), ("a new iPhone", "a new iPad"), ("the iPhone they were", "the iPad they were"),
        ("iPhone limits", "iPadOS limits"), ("iPhone couldn’t", "iPadOS couldn’t"), ("iPhone decides", "iPadOS decides"),
        ("the iPhone asked", "the iPad asked"), ("On This iPhone", "On This iPad"), ("On this iPhone", "On this iPad"),
        ("iPhone’s", "iPad’s"), ("iPhone's", "iPad's"),
        ("in ≡ › Day and Week.", "in Day and Week, in the sidebar."), ("in ≡ › iCloud & Backup.", "in iCloud & Backup, in the sidebar."),
        ("≡ › ", "the sidebar › "), ("≡ → ", "the sidebar → "),
    ]
}

// MARK: - Environment

private nonisolated struct PadPopoverKey: EnvironmentKey {
    static let defaultValue = false
}

private nonisolated struct PadSidebarKey: EnvironmentKey {
    static var defaultValue: PadSidebarControl? { nil }
}

private nonisolated struct PadOpenHabitKey: EnvironmentKey {
    static var defaultValue: PadOpenHabit? { nil }
}

private nonisolated struct PopoverFitKey: EnvironmentKey {
    static var defaultValue: PopoverFit? { nil }
}

extension EnvironmentValues {
    /// True inside an iPad popover on a regular-width window (Day details at its row, the calendar, Filter). Such a
    /// screen has no ✕ or Done: a tap outside closes it, as Calendar's event popover (Design Notes §3). Set by the
    /// presenter, which knows its window's width; inside a popover the system reports a compact width.
    nonisolated var inPadPopover: Bool {
        get { self[PadPopoverKey.self] }
        set { self[PadPopoverKey.self] = newValue }
    }

    /// The iPad's sidebar, for the button that shows it. Nil on the iPhone.
    nonisolated var padSidebar: PadSidebarControl? {
        get { self[PadSidebarKey.self] }
        set { self[PadSidebarKey.self] = newValue }
    }

    /// Opens a habit's page in the iPad's Habits list–detail (Day details' habit row). Nil on the iPhone.
    nonisolated var padOpenHabit: PadOpenHabit? {
        get { self[PadOpenHabitKey.self] }
        set { self[PadOpenHabitKey.self] = newValue }
    }

    /// The size an iPad popover's screens ask for (`fitsPadPopover`). Nil outside a popover.
    nonisolated var popoverFit: PopoverFit? {
        get { self[PopoverFitKey.self] }
        set { self[PopoverFitKey.self] = newValue }
    }
}

/// The sidebar's state as the screens beside it see it: whether it's shown beside them (then its own button, at its
/// top right, puts it away), and how to show or hide it.
struct PadSidebarControl {
    /// The sidebar is in the window beside the content (landscape, regular width, not put away).
    let docked: Bool
    let toggle: () -> Void
    /// The window is regular width (a narrow window is the iPhone's Today), and Today shows Columns. One value for
    /// Today to read, nil on the iPhone, so the iPhone's Today does no more work per redraw than before.
    var regular = false
    var columns = false
}

struct PadOpenHabit {
    let open: (Habit) -> Void
}

// MARK: - Day details at its row

/// Which row Day details points at on the iPad (Design Notes §3): the row that was tapped; for a habit opened another
/// way (a widget, Siri), its first row on screen; with no row on screen (a folded card, another group), a form sheet
/// in the middle instead (`fallback`), latched so it never jumps to a row that scrolls in behind it.
///
/// The popover itself hangs on Today's whole content, never on the row: a List recycles a row that leaves the screen
/// (rotating to landscape can push it below the fold), and a popover on that row would close with it, losing a typed
/// amount. The row only reports where it is (`rect`); if it goes, the popover stays where it pointed.
@Observable final class PadAnchor {
    static let shared = PadAnchor()
    /// Today's coordinate space, where the row's frame is read and the popover is attached.
    static let space = "pad-today"
    /// The section of the row last tapped, per habit (a habit ticked in several sections has a row in each).
    @ObservationIgnored private var tappedSection: [UUID: String] = [:]
    /// The Day details shown as a sheet because its habit had no row on screen.
    var fallback: HabitStore.DayTarget?
    /// The row Day details points at, once chosen, and where it was last seen.
    var key: String?
    var rect: CGRect?

    func tapped(_ habit: UUID, section: String?) {
        if let section { tappedSection[habit] = section } else { tappedSection[habit] = nil }
    }

    /// The row (`TodayView.rowKey`) Day details for `target` points at, among the rows on screen; nil when none is.
    func key(for target: HabitStore.DayTarget, visible: Set<String>) -> String? {
        let suffix = target.habitID.uuidString
        if let section = tappedSection[target.habitID] {
            let key = TodayView.rowKey(section, target.habitID)
            if visible.contains(key) { return key }
        }
        return visible.filter { $0.hasSuffix(suffix) }.min()
    }

    /// Day details closed: nothing to point at.
    func clear() {
        if fallback != nil { fallback = nil }
        if key != nil { key = nil }
        if rect != nil { rect = nil }
    }
}

/// A Today row on the iPad that reports where it is while Day details points at it (`PadAnchor`). The row itself on the
/// iPhone (and on the iPad while it isn't the one).
struct PadDayAnchorRow: ViewModifier {
    let key: String

    func body(content: Content) -> some View {
        content.background {
            if PadAnchor.shared.key == key {
                Color.clear
                    .onGeometryChange(for: CGRect.self) { $0.frame(in: .named(PadAnchor.space)) } action: { rect in
                        if PadAnchor.shared.key == key { PadAnchor.shared.rect = rect }
                    }
            }
        }
    }
}

/// Day details as a popover pointing at its row, on the iPad (Design Notes §3; Rulebook I9): in both orientations on a
/// regular width, and the iPhone's sheet in a narrow window (`presentationCompactAdaptation(.sheet)`), from the same
/// presentation, so a typed amount inside it survives rotating and the window changing size. On Today's content, in the
/// coordinate space its rows report in. Nothing on the iPhone (Today's `.sheet` shows Day details there).
struct PadDayPresenter: ViewModifier {
    @Environment(HabitStore.self) private var store
    @Environment(\.horizontalSizeClass) private var sizeClass

    func body(content: Content) -> some View {
        let anchor = PadAnchor.shared
        content
                .coordinateSpace(.named(PadAnchor.space))
                .popover(isPresented: Binding(get: { shown }, set: { if !$0 && shown { store.dayTarget = nil } }),
                         attachmentAnchor: .rect(.rect(anchor.rect ?? .zero))) {
                    if let target = store.dayTarget, let habit = store.habits.first(where: { $0.id == target.habitID }) {
                        PadDayDetails(habit: habit, day: target.day, regular: sizeClass == .regular)
                    }
                }
    }

    private var shown: Bool {
        store.dayTarget != nil && PadAnchor.shared.fallback == nil && PadAnchor.shared.rect != nil
    }
}

/// Day details inside the popover: the iPhone's own screen at the iPhone's width (375 pt), sized to what it shows.
struct PadDayDetails: View {
    let habit: Habit
    let day: LocalDay
    let regular: Bool
    @State private var fit = PopoverFit(width: 375)

    var body: some View {
        DaySheet(habit: habit, day: day, pageLink: true)
            .environment(\.inPadPopover, regular)
            .padPopoverFrame(fit, active: regular)
            .presentationCompactAdaptation(.sheet)
    }
}

// MARK: - Popover size

/// How big an iPad popover is: as wide as its design, as tall as the screen on top needs (each screen inside reports
/// its scroll content's height with `fitsPadPopover`), so it never shows empty space or cuts anything off, and it grows
/// or shrinks as All logs or Add log is pushed inside it (Design Notes §3: "The popover changes height smoothly").
@Observable final class PopoverFit {
    let width: CGFloat
    /// The screen on top (the last to appear), and each screen's needed height.
    var top = ""
    var heights: [String: CGFloat] = [:]

    init(width: CGFloat) { self.width = width }

    var height: CGFloat { heights[top] ?? 420 }

    func report(_ screen: String, _ height: CGFloat) {
        let rounded = height.rounded(.up)
        if abs((heights[screen] ?? 0) - rounded) >= 1 { heights[screen] = rounded }
    }
}

extension View {
    /// Sizes a popover's content to `fit` (on a regular width only: in a narrow window it's a sheet of its own size).
    /// The same modifiers either way, with values that do nothing in a narrow window: a branch here would give Day
    /// details a new identity when the window changes width, and lose Add log and its typed amount (run 38131431056).
    func padPopoverFrame(_ fit: PopoverFit, active: Bool) -> some View {
        environment(\.popoverFit, active ? fit : nil)
            .frame(width: active ? fit.width : nil, height: active ? min(max(fit.height, 160), 900) : nil)
            .animation(.snappy(duration: 0.25), value: fit.height)
    }

    /// Tells an iPad popover how tall this screen's content is, while it's the screen on top. Nothing outside a popover.
    /// Nothing at all on the iPhone: not even an environment read on its Day details screens (U30).
    @ViewBuilder func fitsPadPopover(_ screen: String) -> some View {
        if Device.isPad { modifier(FitsPadPopover(screen: screen)) } else { self }
    }

    /// A form sheet on the iPad (Design Notes §5: New (+), the habit form, Set Up App Lock, restore, Plus's sheets).
    /// The iPhone's sheet as it is.
    @ViewBuilder func padFormSheet() -> some View {
        if Device.isPad { presentationSizing(.form) } else { self }
    }
}

private struct FitsPadPopover: ViewModifier {
    let screen: String
    @Environment(\.popoverFit) private var fit

    // One shape whether or not a popover is measuring: the window changing width keeps the screen's state.
    func body(content: Content) -> some View {
        content
            .onScrollGeometryChange(for: CGFloat.self) { geometry in
                geometry.contentSize.height + geometry.contentInsets.top + geometry.contentInsets.bottom
            } action: { _, height in
                fit?.report(screen, height)
            }
            .onAppear { fit?.top = screen }
    }
}

// MARK: - Popovers from buttons

extension View {
    /// A popover from this button on a regular-width iPad (Design Notes §5: the calendar from "Today ⌄", Filter from its
    /// button): small, quick, tied to what's on screen; no Done (a tap outside closes it). Nothing on the iPhone, where
    /// the same screen is a sheet.
    @ViewBuilder func padPopover<Content: View>(isPresented: Binding<Bool>, width: CGFloat,
                                                @ViewBuilder content: @escaping () -> Content) -> some View {
        if Device.isPad {
            popover(isPresented: isPresented) { PadPopoverContent(width: width, content: content) }
        } else {
            self
        }
    }

    /// Registers a Today row as on screen on the iPad, so Day details can point at it (`PadAnchor`). On the iPhone the
    /// rows that need it (timers) register themselves.
    @ViewBuilder func padVisibleRow(_ key: String, in visible: VisibleRows) -> some View {
        if Device.isPad {
            onAppear { visible.show(key) }.onDisappear { visible.hide(key) }
        } else {
            self
        }
    }
}

private struct PadPopoverContent<Content: View>: View {
    @State private var fit: PopoverFit
    let content: () -> Content

    init(width: CGFloat, content: @escaping () -> Content) {
        _fit = State(initialValue: PopoverFit(width: width))
        self.content = content
    }

    var body: some View {
        content()
            .environment(\.inPadPopover, true)
            .padPopoverFrame(fit, active: true)
    }
}

extension View {
    /// A Today row on the iPad that Day details can point at (`PadDayAnchorRow`). The row itself on the iPhone.
    @ViewBuilder func padDayAnchor(_ key: String) -> some View {
        if Device.isPad { modifier(PadDayAnchorRow(key: key)) } else { self }
    }
}

extension View {
    /// A screen in an iPad popover that doesn't scroll (Add note): the height it asks for while on top.
    @ViewBuilder func padPopoverHeight(_ screen: String, _ height: CGFloat) -> some View {
        if Device.isPad { modifier(PadPopoverHeight(screen: screen, height: height)) } else { self }
    }
}

private struct PadPopoverHeight: ViewModifier {
    let screen: String
    let height: CGFloat
    @Environment(\.popoverFit) private var fit

    func body(content: Content) -> some View {
        content.onAppear { fit?.report(screen, height); fit?.top = screen }
    }
}

extension String {
    /// "Your iPhone and Apple Watch" → "your iPhone and Apple Watch", inside a sentence.
    var lowercasedFirst: String { prefix(1).lowercased() + dropFirst() }
}

extension View {
    /// Return adds on an Add screen with the iPad's keyboard (I11): Return in the typed field, or anywhere when nothing is
    /// typed. Nothing on the iPhone, whose number pad has no Return.
    @ViewBuilder func padReturnAdds(_ add: @escaping () -> Void) -> some View {
        if Device.isPad { onSubmit(add) } else { self }
    }

    /// The main button answers Return on the iPad's keyboard (I11).
    @ViewBuilder func padDefaultAction() -> some View {
        if Device.isPad { keyboardShortcut(.defaultAction) } else { self }
    }
}

extension View {
    /// A destination only the iPad pushes (Add log and Add note inside Day details); on the iPhone nothing is registered,
    /// so its screen does no more work than before.
    @ViewBuilder func padNavigationDestination<Item: Hashable, Destination: View>(
        item: Binding<Item?>, @ViewBuilder destination: @escaping (Item) -> Destination) -> some View {
        if Device.isPad { navigationDestination(item: item, destination: destination) } else { self }
    }
}

extension View {
    /// Today's iPad presentations (`PadDayPresenter`); nothing on the iPhone.
    @ViewBuilder func padDayPresenter() -> some View {
        if Device.isPad { modifier(PadDayPresenter()) } else { self }
    }
}
