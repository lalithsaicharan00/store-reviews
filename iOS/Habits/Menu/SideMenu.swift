import SwiftUI

/// Today with the ≡ menu over it (the user's decision, 30 Sep 2026; `Docs/Checklists/Sidebar Menu.md`).
///
/// iOS has no side menu on iPhone, so this one is put together from system parts: an inset-grouped `List`, the
/// system's snappy spring, the dimming a sheet uses, VoiceOver's modal and escape. It slides over Today from the
/// left and never moves or redraws Today: only this layer reads the menu's state.
struct MenuShell<Content: View>: View {
    let menu: MenuModel
    @ViewBuilder let content: Content

    var body: some View {
        ZStack(alignment: .topLeading) {
            content
            EdgeSwipe(menu: menu)
            MenuLayer(menu: menu)
        }
    }
}

/// How far the finger moved, and how fast, decide whether a drag opens or closes the menu.
private enum Swipe {
    static func settles(open: Bool, translation: CGFloat, predicted: CGFloat, width: CGFloat) -> Bool {
        open ? translation > width * 0.35 || predicted > width * 0.6
             : !(translation < -width * 0.35 || predicted < -width * 0.6)
    }
    static func width(_ size: CGSize) -> CGFloat { min(size.width * 0.84, 360) }
}

/// A swipe from Today's left edge opens the menu, following the finger. Only on Today itself: on a pushed page the
/// same swipe is the system's Back.
private struct EdgeSwipe: View {
    let menu: MenuModel
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        if !menu.isOpen && menu.path.isEmpty {
            GeometryReader { proxy in
                let width = Swipe.width(proxy.size)
                Color.clear
                    .frame(width: 16)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 10, coordinateSpace: .global)
                            .onChanged { value in
                                guard !reduceMotion else { return }
                                if !menu.mounted { menu.mounted = true }
                                menu.drag = min(width, max(0, value.translation.width))
                            }
                            .onEnded { value in
                                let open = Swipe.settles(open: true, translation: value.translation.width,
                                                         predicted: value.predictedEndTranslation.width, width: width)
                                menu.setOpen(open, reduceMotion: reduceMotion)
                            }
                    )
                    .accessibilityHidden(true)
            }
            .ignoresSafeArea()
        }
    }
}

/// The dimmed Today and the menu panel.
private struct MenuLayer: View {
    let menu: MenuModel
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        GeometryReader { proxy in
            let width = Swipe.width(proxy.size)
            // Reduce Motion: the panel fades in place instead of sliding.
            let closedAt: CGFloat = menu.isOpen ? 0 : -width
            let x: CGFloat = reduceMotion ? (menu.isOpen ? min(0, menu.drag) : 0)
                : min(0, max(-width, closedAt + menu.drag))
            let shown: CGFloat = reduceMotion ? (menu.isOpen ? 1 : 0) : (width + x) / width
            let active = menu.isOpen || menu.drag != 0
            ZStack(alignment: .topLeading) {
                Color.black.opacity(0.28 * shown)
                    .ignoresSafeArea()
                    .contentShape(Rectangle())
                    .allowsHitTesting(menu.isOpen)
                    .onTapGesture { menu.setOpen(false, reduceMotion: reduceMotion) }
                    .gesture(closeDrag(width: width))
                    .accessibilityHidden(true)
                // The panel always slides; its rows exist only while it's open or moving (`MenuModel.mounted`).
                ZStack {
                    if menu.mounted { SideMenu(menu: menu).transition(.identity) }
                }
                .frame(width: width)
                .frame(maxHeight: .infinity)
                .background(Color(.systemGroupedBackground).ignoresSafeArea())
                .compositingGroup()
                .shadow(color: .black.opacity(active ? 0.18 : 0), radius: 12, x: 2)
                .offset(x: x)
                .opacity(reduceMotion ? shown : 1)
                .simultaneousGesture(closeDrag(width: width))
                .allowsHitTesting(menu.isOpen)
                .accessibilityHidden(!menu.isOpen)
                // Modal only while open: closed, the panel still sat off screen as an "alert" XCUITest found
                // (BackupUITests, run 38037588319).
                .accessibilityAddTraits(menu.isOpen ? .isModal : [])
                .accessibilityAction(.escape) { menu.setOpen(false, reduceMotion: reduceMotion) }
            }
        }
    }

    /// Dragging the menu (or the dimmed Today) to the left closes it, following the finger.
    private func closeDrag(width: CGFloat) -> some Gesture {
        DragGesture(minimumDistance: 20, coordinateSpace: .global)
            .onChanged { value in
                // Only a mostly sideways drag, so scrolling the menu never moves it.
                guard menu.isOpen, abs(value.translation.width) > abs(value.translation.height) else { return }
                menu.drag = max(-width, min(0, value.translation.width))
            }
            .onEnded { value in
                guard menu.isOpen, menu.drag != 0 else { return }
                let open = Swipe.settles(open: false, translation: value.translation.width,
                                         predicted: value.predictedEndTranslation.width, width: width)
                menu.setOpen(open, reduceMotion: reduceMotion)
            }
    }
}

/// The menu (Figma's Side menu, 17 Nov 2026): the app's mark and name, then where you are and Habits & Tasks, then Plus,
/// Settings and two ways to write to us. Rows are 50 tall, Body, the page you're on in Semibold.
private struct SideMenu: View {
    let menu: MenuModel
    @Environment(HabitStore.self) private var store
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.openURL) private var openURL
    @State private var showAddress = false

    var body: some View {
        List {
            Section {
                row("Today", symbol: "sun.max", detail: nil, id: "menu-today", current: true) {
                    menu.setOpen(false, reduceMotion: reduceMotion)
                }
                place(.habitsAndTasks)
            }
            Section {
                place(.plus)
                place(.settings)
                row("Contact Us", symbol: "envelope", detail: nil, id: "menu-contact", current: false) {
                    write(Support.mailURL())
                }
                row("Send Feedback", symbol: "bubble.left", detail: nil, id: "menu-feedback", current: false) {
                    write(Support.feedbackURL())
                }
            }
        }
        .listStyle(.insetGrouped)
        .listSectionSpacing(12)
        .environment(\.defaultMinListRowHeight, 50)
        .scrollContentBackground(.hidden)
        .scrollBounceBehavior(.basedOnSize)
        .contentMargins(.top, 4, for: .scrollContent)
        .safeAreaInset(edge: .top, spacing: 0) { header }
        .alert("Write to Us", isPresented: $showAddress) {
            Button("Copy Address") { UIPasteboard.general.string = Support.email }
            Button("OK", role: .cancel) {}
        } message: {
            Text("Email \(Support.email). Say what happened and when, and which iPhone you use.")
        }
    }

    /// The app's mark (the approved tonal stack, tilted 12°; its dark set in dark mode, Logo Guide) and its name.
    private var header: some View {
        HStack(spacing: 12) {
            Image("BrandMark")
                .resizable()
                .frame(width: 31.2, height: 31.2)
                .rotationEffect(.degrees(12))
                .frame(width: 36, height: 36)
                .accessibilityHidden(true)
            Text(Onboarding.appName).font(.headline)
            Spacer(minLength: 0)
        }
        .padding(16)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isHeader)
    }

    private func place(_ place: MenuPlace) -> some View {
        row(place.title, symbol: place.symbol, detail: detail(place), id: "menu-" + place.rawValue, current: false) {
            menu.go(to: place, reduceMotion: reduceMotion)
        }
    }

    /// Habits & Tasks says how many there are; nothing else needs a number to choose it.
    private func detail(_ place: MenuPlace) -> String? {
        place == .habitsAndTasks ? String(store.habits.filter { !$0.archived }.count) : nil
    }

    /// The phone's mail app; with none, the address to copy. The menu stays open behind it.
    private func write(_ url: URL?) {
        Analytics.shared.count(.contactSupport, ticket: Analytics.shared.ticket)
        guard let url else { showAddress = true; return }
        openURL(url) { opened in
            if !opened { showAddress = true }
        }
    }

    private func row(_ title: String, symbol: String, detail: String?, id: String, current: Bool,
                     action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: symbol)
                    .font(.body)
                    .foregroundStyle(Color.primary)
                    .frame(width: 26)
                Text(title)
                    .fontWeight(current ? .semibold : .regular)
                    .foregroundStyle(Color.primary)
                    .lineLimit(1)
                Spacer(minLength: 8)
                if let detail {
                    Text(detail).foregroundStyle(.secondary).monospacedDigit().lineLimit(1)
                }
            }
            .contentShape(Rectangle())
        }
        .accessibilityIdentifier(id)
        .accessibilityAddTraits(current ? .isSelected : [])
    }
}

/// Settings, until it's built from its own Figma page: every page the menu used to list, so none is out of reach.
struct SettingsPage: View {
    var body: some View {
        List {
            ForEach(MenuPlace.settingsGroups, id: \.self) { group in
                Section {
                    ForEach(group) { place in
                        NavigationLink(value: place) {
                            Label(place.title, systemImage: place.symbol)
                        }
                        .accessibilityIdentifier("menu-" + place.rawValue)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// Habits & Tasks, until it's built from its own Figma page: Habits | Tasks on top, then that list.
struct HabitsAndTasksPage: View {
    @State private var kind: AllHabitsView.Kind = .habits

    var body: some View {
        AllHabitsView(kind: kind)
            .id(kind)
            .safeAreaInset(edge: .top, spacing: 0) {
                Picker("Show", selection: $kind) {
                    Text("Habits").tag(AllHabitsView.Kind.habits)
                    Text("Tasks").tag(AllHabitsView.Kind.tasks)
                }
                .pickerStyle(.segmented)
                .controlSize(.large)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .accessibilityIdentifier("habits-tasks-picker")
            }
    }
}

/// Help & Feedback opened on one topic (a widget's Choose a habit: Help → Widgets → "Choose a habit for a widget").
struct HelpLink: Hashable {
    let topic: String
}

/// What a menu row opens, pushed onto Today's stack.
struct MenuPage: View {
    let place: MenuPlace

    var body: some View {
        switch place {
        case .habitsAndTasks: HabitsAndTasksPage()
        case .settings: SettingsPage()
        case .progress: ProgressScreen()
        case .habits: AllHabitsView(kind: .habits)
        case .tasks: AllHabitsView(kind: .tasks)
        case .timesOfDay: TimesOfDayList()
        case .dayAndWeek: DayAndWeekView()
        case .appearance: AppearanceView()
        case .plus: PlusPage()
        case .backup:
            // Without a database (it couldn't be opened) there's no backup centre; the older page says what's wrong.
            if let backup = AppModel.shared.backup, let cloud = AppModel.shared.cloud {
                ICloudPage().environment(backup).environment(cloud)
            } else {
                BackupExportView()
            }
        case .reminders: RemindersView()
        case .privacy: PrivacyView()
        case .help: HelpView().analyticsScreen(.help)
        case .about: AboutView().analyticsScreen(.about)
        default: ComingSoonView(place: place)
        }
    }
}

/// A page that isn't built yet: what it will hold, so the menu's structure can be tried now.
private struct ComingSoonView: View {
    let place: MenuPlace

    var body: some View {
        ContentUnavailableView {
            Label(place.title, systemImage: place.symbol)
        } description: {
            if place == .about, let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                Text("Version \(version)\n\n" + (place.plan ?? ""))
            } else {
                Text(place.plan ?? "")
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(place.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
