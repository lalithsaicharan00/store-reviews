import SwiftUI
import UIKit

/// The app on the iPad (Current Work 86; `iOS/Docs/iPad/`): the iPhone's Today in Apple's iPad frame.
///
/// - **Regular width, landscape:** the sidebar (the ≡ menu's rows, in its order, with "N left" beside Today) beside the
///   content; its own `sidebar.left` button, at its top right, puts it away (Design Notes §1).
/// - **Regular width, portrait:** the sidebar is put away; its button at the content's top left slides it over the
///   content, which doesn't move (§2).
/// - **Compact width (a narrow window):** the iPhone app (I2): the sidebar slides over, as in portrait; Today has the
///   iPhone's top bar, bottom day bar and sheets (§4).
///
/// Built from system parts rather than `NavigationSplitView`, for the iPad's first priority after the iPhone itself: a
/// split view collapses into one navigation stack in a narrow window, with the sidebar's list as its first page (not the
/// iPhone's menu over Today), and moving Today from one container to another as the window changes size rebuilds it,
/// which closed an open Day details and lost a typed amount. Here Today is one view in one place at every size, so
/// rotating, resizing or splitting the window never loses anything (Build Prompt §1, priority 2).
///
/// Today stays alive under the other places, as it does under the iPhone's pushed pages, with its clocks paused
/// (`ClocksPausedUnderMenu`). A place's page has its own navigation stack (a `MenuModel` of its own, so Progress's pushes
/// stay inside Progress).
struct PadRoot: View {
    let menu: MenuModel
    @Environment(\.horizontalSizeClass) private var sizeClass
    @Environment(HabitStore.self) private var store
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    /// Per window, never in the store: the place shown and whether the sidebar was put away (Build Prompt §4.2).
    @SceneStorage("pad.place") private var savedPlace = ""
    @SceneStorage("pad.sidebar-hidden") private var sidebarHidden = false
    /// The sidebar slid over the content (portrait, a narrow window).
    @State private var overlayOpen = false
    @State private var size = CGSize.zero
    /// The navigation stack of the page beside the sidebar.
    @State private var pageMenu = MenuModel()
    @AppStorage(Preferences.padLayout) private var layout = PadLayout.list.rawValue
    private let commands = PadCommands.shared

    /// The sidebar sits beside the content in a regular-width window wider than it is tall (landscape), as iPadOS's own
    /// split views do; in portrait and in a narrow window it slides over.
    private var docks: Bool { sizeClass == .regular && size.width > size.height }
    private var docked: Bool { docks && !sidebarHidden }

    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack(spacing: 0) {
                if docked {
                    PadSidebarPanel(menu: menu, showsToggle: true, toggle: toggle, pick: pick)
                        .frame(width: PadMetrics.sidebar)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                }
                ZStack {
                    TodayView()
                        .opacity(menu.padPlace == nil ? 1 : 0)
                        .allowsHitTesting(menu.padPlace == nil)
                        .accessibilityHidden(menu.padPlace != nil)
                    if let place = menu.padPlace {
                        // Modal to VoiceOver: hidden Today's list and bars are hosted by UIKit, which the hidden flag
                        // above didn't reach (run 38141959437 found Today's rows under Times of Day; U1).
                        PadPage(place: place, pageMenu: pageMenu, root: menu)
                            .accessibilityAddTraits(.isModal)
                            .id(place)
                    }
                }
                .accessibilityElement(children: .contain)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            if !docked {
                PadSidebarOverlay(open: overlayOpen, close: { setOverlay(false) }) {
                    PadSidebarPanel(menu: menu, showsToggle: true, toggle: toggle, pick: pick)
                }
            }
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .onGeometryChange(for: CGSize.self) { $0.size } action: { size = $0 }
        .environment(\.padSidebar, PadSidebarControl(docked: docked, toggle: toggle, regular: sizeClass == .regular,
                                                     columns: layout == PadLayout.columns.rawValue,
                                                     covered: menu.padPlace != nil, openHabit: { openHabit($0) }))
        .environment(\.padOpenHabit, PadOpenHabit { habit in openHabit(habit) })
        .onAppear {
            // A test starts on Today with the sidebar out, whatever the last test left (Rulebook T8).
            if TestLaunchIsolation.isTestLaunch { savedPlace = ""; sidebarHidden = false }
            // The place this window showed last (SceneStorage: per window).
            if menu.padPlace == nil, let place = MenuPlace(rawValue: savedPlace) { menu.padPlace = place }
        }
        #if DEBUG
        .task { await PadSizeScript.run() }
        #endif
        .onChange(of: menu.padPlace) {
            savedPlace = menu.padPlace?.rawValue ?? ""
            pageMenu.path = NavigationPath()
        }
        // The menu bar's Hide Sidebar (⌃⌘S).
        .onChange(of: commands.sidebarRequests) { toggle() }
        .onChange(of: docks) { overlayOpen = false }
        .onChange(of: docked || overlayOpen, initial: true) { commands.sidebarShown = docked || overlayOpen }
        .onChange(of: commands.placeRequest) {
            guard let request = commands.placeRequest else { return }
            commands.placeRequest = nil
            pick(request.place)
        }
    }

    private func toggle() {
        if docks {
            withAnimation(MenuModel.motion(reduceMotion)) { sidebarHidden.toggle() }
        } else {
            setOverlay(!overlayOpen)
        }
    }

    private func setOverlay(_ open: Bool) {
        withAnimation(MenuModel.motion(reduceMotion)) { overlayOpen = open }
    }

    /// A sidebar row: its page beside the sidebar (nil is Today). Slid over, the sidebar goes once a row is chosen.
    private func pick(_ place: MenuPlace?) {
        var instant = Transaction()
        instant.disablesAnimations = true
        withTransaction(instant) { menu.padPlace = place }
        if !docked { setOverlay(false) }
    }

    /// Habits (or Tasks) with this habit's page beside the list.
    private func openHabit(_ habit: Habit) {
        store.dayTarget = nil
        let place: MenuPlace = habit.kind == .task ? .tasks : .habits
        menu.padHabit[place] = habit.id
        pick(place)
    }
}

enum PadMetrics {
    static let sidebar: CGFloat = 320
    /// Today's column and the settings pages (Design Notes §1, §5): the iPhone's cards at a readable width, centred.
    static let column: CGFloat = 700
    /// Plus: one decision read top to bottom (Design Notes §5).
    static let plus: CGFloat = 540
    /// The list beside a habit's page (Habits and Tasks).
    static let list: CGFloat = 320
}

// MARK: - Sidebar

/// The sidebar slid over the content: frosted, with a shadow; the content doesn't move or shrink. A tap outside it, or
/// its button, puts it away (Design Notes §2).
private struct PadSidebarOverlay<Panel: View>: View {
    let open: Bool
    let close: () -> Void
    @ViewBuilder let panel: Panel

    var body: some View {
        ZStack(alignment: .topLeading) {
            if open {
                Color.black.opacity(0.12)
                    .ignoresSafeArea()
                    .contentShape(Rectangle())
                    .onTapGesture(perform: close)
                    .accessibilityHidden(true)
                    .transition(.opacity)
                panel
                    .frame(width: PadMetrics.sidebar)
                    .shadow(color: .black.opacity(0.18), radius: 18, x: 4)
                    .transition(.move(edge: .leading))
                    .accessibilityAddTraits(.isModal)
                    .accessibilityAction(.escape, close)
            }
        }
    }
}

/// The ≡ menu's rows as the iPad's sidebar (I3): Today · Progress · Habits · Tasks, then Times of Day · Day and Week ·
/// Reminders · Appearance, then iCloud & Backup · Privacy & Security, then Plus, then Help & Feedback · About. Counts as
/// on the iPhone's menu, and "N left" beside Today (I4), each in its own small view (S6).
struct PadSidebarPanel: View {
    let menu: MenuModel
    let showsToggle: Bool
    let toggle: () -> Void
    let pick: (MenuPlace?) -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                if showsToggle {
                    Button("Hide Sidebar", systemImage: "sidebar.left", action: toggle)
                        .labelStyle(.iconOnly)
                        .font(.title3)
                        .frame(width: 44, height: 44)
                        .accessibilityIdentifier("sidebar-hide")
                }
            }
            .padding(.horizontal, 8)
            .padding(.top, 6)
            List {
                Section {
                    PadSidebarRow(title: "Today", symbol: "sun.max", id: "menu-today",
                                  selected: menu.padPlace == nil) { pick(nil) } detail: { TodayLeftCount() }
                    ForEach(MenuPlace.groups[0]) { place in row(place) }
                }
                ForEach(MenuPlace.groups.dropFirst(), id: \.self) { group in
                    Section { ForEach(group) { row($0) } }
                }
            }
            .listStyle(.sidebar)
            .scrollContentBackground(.hidden)
            .environment(\.defaultMinListRowHeight, 40)
        }
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .padding(8)
        // A container's id needs `.contain`, or every row inside takes it (Rulebook T9).
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("pad-sidebar")
    }

    private func row(_ place: MenuPlace) -> some View {
        PadSidebarRow(title: place.title, symbol: place.symbol, id: "menu-" + place.rawValue,
                      selected: menu.padPlace == place) { pick(place) } detail: { PlaceCount(place: place) }
    }
}

private struct PadSidebarRow<Detail: View>: View {
    let title: String
    let symbol: String
    let id: String
    let selected: Bool
    let action: () -> Void
    @ViewBuilder let detail: Detail

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: symbol)
                    .font(.body)
                    .foregroundStyle(Color.ink)
                    .frame(width: 26)
                Text(title)
                    .fontWeight(selected ? .semibold : .regular)
                    .foregroundStyle(Color.primary)
                    .lineLimit(1)
                Spacer(minLength: 8)
                detail
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .listRowBackground(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(selected ? Color(.systemFill) : .clear)
                .padding(.horizontal, 8)
        )
        .hoverEffect(.highlight)
        .accessibilityIdentifier(id)
        .accessibilityAddTraits(selected ? .isSelected : [])
    }
}

/// "9 left" beside Today: what's left today, the scan from anywhere in the app (I4). Its own view, so a tap on Today
/// redraws this count, not the sidebar.
private struct TodayLeftCount: View {
    @Environment(HabitStore.self) private var store

    var body: some View {
        if store.isLoaded {
            let summary = store.daySummary(on: store.today())
            let left = summary.total - summary.done
            if left > 0 {
                Text("\(left) left").foregroundStyle(.secondary).monospacedDigit().lineLimit(1)
                    .accessibilityIdentifier("sidebar-today-left")
            }
        }
    }
}

/// The counts the iPhone's menu shows: how many habits and tasks, and how much of the free plan is used.
private struct PlaceCount: View {
    let place: MenuPlace
    @Environment(HabitStore.self) private var store

    var body: some View {
        if let text {
            Text(text).foregroundStyle(.secondary).monospacedDigit().lineLimit(1)
        }
    }

    private var text: String? {
        switch place {
        case .habits: String(store.habits.filter { !$0.archived && $0.kind != .task }.count)
        case .tasks: String(store.habits.filter { !$0.archived && $0.kind == .task }.count)
        case .plus: store.isPlus ? nil : "\(store.activeHabitCount) of \(HabitStore.freeHabitLimit)"
        default: nil
        }
    }
}

// MARK: - Pages

/// A place's page beside the sidebar, on its own navigation stack: the pages it opens are pushed in the same place,
/// with a back button (Design Notes §5). Settings at Today's 700 pt, centred; Plus at 540; Progress across the room, its
/// cards two across; Habits and Tasks as a list and the selected habit's page side by side, each on its own stack.
struct PadPage: View {
    let place: MenuPlace
    let pageMenu: MenuModel
    let root: MenuModel

    var body: some View {
        Group {
            switch place {
            case .habits: PadListDetail(kind: .habits, root: root, pageMenu: pageMenu)
            case .tasks: PadListDetail(kind: .tasks, root: root, pageMenu: pageMenu)
            default:
                PadStack(pageMenu: pageMenu) {
                    switch place {
                    case .progress: ProgressScreen()
                    case .plus: MenuPage(place: place).padColumn(PadMetrics.plus, bars: true)
                    default: MenuPage(place: place).padColumn(PadMetrics.column)
                    }
                }
            }
        }
        .environment(pageMenu)
    }
}

/// A navigation stack beside the sidebar: the sidebar's button at its top left while the sidebar is put away, and the
/// pages a place can push.
private struct PadStack<Content: View>: View {
    let pageMenu: MenuModel
    var showsSidebarButton = true
    @ViewBuilder let content: Content
    @Environment(\.padSidebar) private var sidebar

    var body: some View {
        NavigationStack(path: Bindable(pageMenu).path) {
            content
                .toolbar {
                    if showsSidebarButton, let sidebar, !sidebar.docked {
                        ToolbarItem(placement: .topBarLeading) { PadSidebarButton(control: sidebar) }
                    }
                }
                .navigationDestination(for: MenuPlace.self) { MenuPage(place: $0) }
                .navigationDestination(for: HelpLink.self) { HelpView(open: $0.topic).analyticsScreen(.help) }
                .navigationDestination(for: HabitPageRoute.self) { HabitPageView(id: $0.id) }
        }
    }
}

/// The system's sidebar button, at the top left of whatever is beside the sidebar while it's put away (I7; the user,
/// 11 Oct 2026: one menu icon, the same at every width).
struct PadSidebarButton: View {
    let control: PadSidebarControl

    var body: some View {
        Button("Show Sidebar", systemImage: "sidebar.left", action: control.toggle)
            .accessibilityIdentifier("sidebar-button")
    }
}

extension View {
    /// A page at a readable width, centred in the room it has (Today's column, the settings pages, Plus): the scroll
    /// view still spans the room, so it scrolls from anywhere. Only on a regular width: a narrow window is the iPhone's.
    /// `bars`: a page whose main button rides at the bottom outside its scroll view (Plus): the column insets the safe
    /// area, so the button keeps to the column too (run 38131431056: Buy spanned 828 pt beside the sidebar).
    @ViewBuilder func padColumn(_ width: CGFloat, bars: Bool = false) -> some View {
        if Device.isPad { modifier(PadColumn(width: width, bars: bars)) } else { self }
    }
}

private struct PadColumn: ViewModifier {
    let width: CGFloat
    let bars: Bool
    @Environment(\.horizontalSizeClass) private var sizeClass
    @State private var room: CGFloat = 0

    func body(content: Content) -> some View {
        // A grouped list keeps 20 pt of its own on each side of its cards.
        let margin = sizeClass == .regular ? max(0, (room - width) / 2 - 20) : 0
        content
            .contentMargins(.horizontal, bars ? 0 : margin, for: .scrollContent)
            .safeAreaPadding(.horizontal, bars ? margin : 0)
            .onGeometryChange(for: CGFloat.self) { $0.size.width.rounded() } action: { room = $0 }
    }
}

// MARK: - Habits and Tasks: list and page side by side

/// Habits (or Tasks) on a regular width: the list and the selected habit's page side by side, each with its own bar
/// ("Habits" and Select over the list, the habit's page and its ⋯ beside it), as Notes, Mail and Reminders do (Design
/// Notes §5); a tap moves from habit to habit with no Back. In a narrow window, the iPhone's list that pushes the page.
struct PadListDetail: View {
    let kind: AllHabitsView.Kind
    let root: MenuModel
    let pageMenu: MenuModel
    @Environment(\.horizontalSizeClass) private var sizeClass
    @Environment(HabitStore.self) private var store
    @State private var listMenu = MenuModel()

    var body: some View {
        if sizeClass == .regular {
            HStack(spacing: 0) {
                PadStack(pageMenu: listMenu) {
                    AllHabitsView(kind: kind, selected: selection)
                }
                .frame(width: PadMetrics.list)
                Divider().ignoresSafeArea()
                PadStack(pageMenu: pageMenu, showsSidebarButton: false) {
                    if let id = selection.wrappedValue, store.habits.contains(where: { $0.id == id }) {
                        HabitPageView(id: id)
                            .id(id)
                    } else {
                        ContentUnavailableView(kind == .tasks ? "No Task Selected" : "No Habit Selected",
                                               systemImage: kind == .tasks ? "list.bullet" : "checklist")
                            .background(Color(.systemGroupedBackground))
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .onAppear(perform: selectFirst)
            .onChange(of: selection.wrappedValue) { pageMenu.path = NavigationPath() }
        } else {
            PadStack(pageMenu: pageMenu) { AllHabitsView(kind: kind) }
        }
    }

    private var place: MenuPlace { kind == .tasks ? .tasks : .habits }

    private var selection: Binding<UUID?> {
        Binding(get: { root.padHabit[place] }, set: { root.padHabit[place] = $0 })
    }

    /// The first habit's page shows until another is chosen, as Notes shows its first note.
    private func selectFirst() {
        if let id = root.padHabit[place], store.habits.contains(where: { $0.id == id }) { return }
        let shown = store.habits.filter { ($0.kind == .task) == (kind == .tasks) && !$0.archived }
        root.padHabit[place] = (shown.first { $0.kind != .quit } ?? shown.first)?.id
    }
}

// MARK: - The menu bar

/// The iPad's menu bar (I11): View (as List ⌘1, as Columns ⌘2, Hide Sidebar ⌃⌘S, Go to Today ⌘T, Previous Day ⌘←,
/// Next Day ⌘→) and File's New Habit ⌘N. One window, so the commands reach it through this shared object.
@Observable final class PadCommands {
    static let shared = PadCommands()
    /// Counts each Hide Sidebar, so the same command twice is seen twice.
    var sidebarRequests = 0
    /// Whether the sidebar is out, for the command's name (Hide Sidebar or Show Sidebar).
    var sidebarShown = true
    /// A place to show (Go to Today: nil).
    var placeRequest: PlaceRequest?
    /// Today's day and New Habit, as the speed runs' commands.
    var todayRequest: TodayRequest?

    struct PlaceRequest: Equatable {
        let place: MenuPlace?
        let id = UUID()
    }

    struct TodayRequest: Equatable {
        let action: PerfAction
        let id = UUID()
    }

    func today(_ action: PerfAction) {
        placeRequest = PlaceRequest(place: nil)
        todayRequest = TodayRequest(action: action)
    }
}

struct PadMenuCommands: Commands {
    @AppStorage(Preferences.padLayout) private var layout = PadLayout.list.rawValue

    private func layoutButton(_ value: PadLayout, _ key: KeyEquivalent) -> some View {
        Button { layout = value.rawValue } label: {
            if layout == value.rawValue { Label("as \(value.title)", systemImage: "checkmark") } else { Text("as \(value.title)") }
        }
        .keyboardShortcut(key)
        .disabled(!Device.isPad)
    }

    var body: some Commands {
        CommandGroup(after: .newItem) {
            Button("New Habit") { PadCommands.shared.today(.openNewHabit) }
                .keyboardShortcut("n")
                .disabled(!Device.isPad)
        }
        // In the sidebar's own group: commands placed *before* it never reached the iPad's menu bar (runs 38141959437,
        // 38149917285: ⌘1 / ⌘2 did nothing, as Toggles and as Buttons, while this group's ⌃⌘S worked).
        CommandGroup(replacing: .sidebar) {
            layoutButton(.list, "1")
            layoutButton(.columns, "2")
            Divider()
            Button(PadCommands.shared.sidebarShown ? "Hide Sidebar" : "Show Sidebar") { PadCommands.shared.sidebarRequests += 1 }
                .keyboardShortcut("s", modifiers: [.control, .command])
                .disabled(!Device.isPad)
        }
        CommandGroup(after: .sidebar) {
            Divider()
            Button("Go to Today") { PadCommands.shared.today(.goToToday) }
                .keyboardShortcut("t")
                .disabled(!Device.isPad)
            Button("Previous Day") { PadCommands.shared.today(.previousDay) }
                .keyboardShortcut(.leftArrow)
                .disabled(!Device.isPad)
            Button("Next Day") { PadCommands.shared.today(.nextDay) }
                .keyboardShortcut(.rightArrow)
                .disabled(!Device.isPad)
        }
    }
}

/// How Today lays out its cards on a regular-width iPad (Design Notes §6): one column (the default, as every top app
/// shows a day), or each time of day its own column, as Reminders' Columns. Remembered per device.
enum PadLayout: String, CaseIterable, Identifiable {
    case list, columns
    var id: Self { self }
    var title: String { self == .list ? "List" : "Columns" }
}

#if DEBUG
/// UI tests only: a window that changes size class at set times, as a window dragged narrow beside another app and back
/// (Build Prompt §5: "the narrow-window fallback (a size-class override or a resized window)"). `-pad-compact` starts
/// narrow; `-pad-size-script "30:compact,50:regular"` changes at those seconds after Today first shows. It overrides
/// the window's own trait, so popovers adapt to sheets exactly as they do in a narrow window.
enum PadSizeScript {
    static func run() async {
        let arguments = ProcessInfo.processInfo.arguments
        if arguments.contains("-pad-compact") { set(.compact) }
        guard let flag = arguments.firstIndex(of: "-pad-size-script"), flag + 1 < arguments.count else { return }
        let start = Date.now
        for step in arguments[flag + 1].split(separator: ",") {
            let parts = step.split(separator: ":")
            guard parts.count == 2, let at = Double(parts[0]) else { continue }
            let wait = at - Date.now.timeIntervalSince(start)
            if wait > 0 { try? await Task.sleep(for: .seconds(wait)) }
            set(parts[1] == "compact" ? .compact : .regular)
        }
    }

    private static func set(_ size: UIUserInterfaceSizeClass) {
        for case let scene as UIWindowScene in UIApplication.shared.connectedScenes {
            for window in scene.windows { window.traitOverrides.horizontalSizeClass = size }
        }
    }
}
#endif
