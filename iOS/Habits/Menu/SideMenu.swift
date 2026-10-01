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
                .accessibilityAddTraits(.isModal)
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

/// The menu's rows: where you are, then the places people visit most, then settings, Plus and help.
private struct SideMenu: View {
    let menu: MenuModel
    @Environment(HabitStore.self) private var store
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        List {
            Section {
                row("Today", symbol: "sun.max", detail: nil, id: "menu-today", current: true) {
                    menu.setOpen(false, reduceMotion: reduceMotion)
                }
                ForEach(MenuPlace.groups[0]) { place($0) }
            }
            ForEach(MenuPlace.groups.dropFirst(), id: \.self) { group in
                Section { ForEach(group) { place($0) } }
            }
        }
        .listStyle(.insetGrouped)
        .listSectionSpacing(.compact)
        .environment(\.defaultMinListRowHeight, 46)
        .scrollContentBackground(.hidden)
        .scrollBounceBehavior(.basedOnSize)
        .contentMargins(.top, 12, for: .scrollContent)
    }

    private func place(_ place: MenuPlace) -> some View {
        row(place.title, symbol: place.symbol, detail: detail(place), id: "menu-" + place.rawValue, current: false) {
            menu.go(to: place, reduceMotion: reduceMotion)
        }
    }

    /// A count where it helps choose: how many habits and tasks, and how much of the free plan is used.
    private func detail(_ place: MenuPlace) -> String? {
        switch place {
        case .habits: String(store.habits.filter { !$0.archived && $0.kind != .task }.count)
        case .tasks: String(store.habits.filter { !$0.archived && $0.kind == .task }.count)
        case .plus: store.isPlus ? nil : "\(store.activeHabitCount) of \(HabitStore.freeHabitLimit)"
        default: nil
        }
    }

    private func row(_ title: String, symbol: String, detail: String?, id: String, current: Bool,
                     action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: current ? symbol + ".fill" : symbol)
                    .font(.body)
                    .foregroundStyle(Color.ink)
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

/// What a menu row opens, pushed onto Today's stack.
struct MenuPage: View {
    let place: MenuPlace

    var body: some View {
        switch place {
        case .progress: ProgressScreen()
        case .habits: AllHabitsView(kind: .habits)
        case .tasks: AllHabitsView(kind: .tasks)
        case .timesOfDay: TimesOfDayList()
        case .dayAndWeek: DayAndWeekView()
        case .appearance: AppearanceView()
        case .plus: PlusView(fromMenu: true)
        case .backup: BackupExportView()
        case .reminders: RemindersView()
        case .help, .about: BlankMenuPage(title: place.title)
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
