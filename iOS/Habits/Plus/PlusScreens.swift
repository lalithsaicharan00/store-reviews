import SwiftUI

// The Plus screens (Current Work 80; the user's flows of 10 Oct 2026, built from their mockups and kept calm and
// native): the 6th-habit sheet and Make Room, ≡ › Plus (buying, or Plus once it's yours), the upgrade to Plus Family,
// "Plus is yours", and "Plus has ended". One filled button per screen, monochrome chrome (U2), no badges, countdowns
// or pressure. Prices are always the App Store's own (`PlusStore.prices`).

// MARK: - ≡ › Plus

/// ≡ › Plus: the plans and their prices without Plus (screens 10–15); "Plus is yours" once it's yours (18, 22, 25),
/// never "Get Plus" again. Restore Purchases is always on the page (App Review 3.1.1).
struct PlusPage: View {
    @Environment(PlusStore.self) private var plus
    @Environment(HabitStore.self) private var store
    @Environment(\.openURL) private var openURL
    @State private var restoreResult: PlusRestore?
    @State private var bought: PlusPlan?
    /// The upgrade page, held here rather than by its row, which goes away once Plus Family is bought (U27).
    @State private var upgrading = false
    @State private var analyticsFlow = Analytics.shared.ticket

    var body: some View {
        Group {
            if store.isPlus {
                YourPlusView(restore: restore, upgrade: { upgrading = true })
            } else {
                PlusBuyView(onBought: { bought = $0 }, restore: restore)
            }
        }
        .navigationTitle("Plus")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $upgrading) {
            PlusUpgradeView {
                upgrading = false
                // Once the upgrade page has gone back: a sheet asked for mid-slide can be dropped.
                Task {
                    try? await Task.sleep(for: .milliseconds(500))
                    bought = .family
                }
            }
        }
        .sheet(item: $bought) { plan in
            PlusIsYoursView(plan: plan) { bought = nil }
        }
        // Ask to Buy, approved while the page is open: Plus unlocked on its own.
        .onChange(of: plus.approved) {
            guard let plan = plus.approved else { return }
            plus.approved = nil
            bought = plan
        }
        .alert(Self.title(restoreResult), isPresented: Binding(get: { restoreResult != nil }, set: { if !$0 { restoreResult = nil } }),
               presenting: restoreResult) { result in
            if result == .nothing {
                Button("Contact Us") { if let url = Support.mailURL() { openURL(url) } }
            }
            Button("OK", role: .cancel) {}
        } message: { result in
            Text(Self.message(result))
        }
        .analyticsScreen(.plus)
        .onAppear {
            if !store.isPlus { Analytics.shared.event(.paywall, ["entry_point": .text("menu")], ticket: analyticsFlow) }
        }
    }

    private func restore() {
        Task {
            let result = await plus.restore()
            if result != .cancelled { restoreResult = result }
        }
    }

    /// Restore's result names what was found (screen 19), or says plainly that nothing was (20).
    static func title(_ result: PlusRestore?) -> String {
        switch result {
        case .found(.owner(.family, _)): "Plus Family found"
        case .found: "Plus found"
        case .nothing: "No Plus on this Apple Account"
        case .failed: "The App Store didn't respond"
        case .cancelled, nil: ""
        }
    }

    static func message(_ result: PlusRestore) -> String {
        let device = UIDevice.current.model
        switch result {
        case .found(.owner(_, let since)):
            return "Bought \(PlusDates.day(since)) on the App Store with this Apple Account. It's on this \(device)."
        case .found:
            return "Shared by your Apple family. It's on this \(device)."
        case .nothing:
            return "Bought it with another Apple Account? Sign in with that Apple Account in the App Store, then tap Restore Purchases again. Or contact us and we'll help."
        case .failed, .cancelled:
            return "Nothing has changed. Check your connection, then try again in a minute."
        }
    }
}

/// The Plus page without Plus: where the person stands, the two plans (Plus chosen), and one button that names what it
/// buys and its price. Prices that can't load show no price at all, only Try Again; purchases turned off (Screen
/// Time) turn the button off and say who can change it; Ask to Buy says it's waiting.
private struct PlusBuyView: View {
    let onBought: (PlusPlan) -> Void
    let restore: () -> Void
    @Environment(PlusStore.self) private var plus
    @State private var plan: PlusPlan = .plus
    @State private var problem: PlusProblem?

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                PlusHeading(symbol: "plus.circle", title: "Plus", line: "One payment, yours forever.")
                    .padding(.bottom, 10)
                FreeHabitCount()
                if plus.pricesState == .failed {
                    PlusNote(title: "Prices didn't load", line: "Check your connection, then try again. Nothing was charged.",
                             id: "plus-prices-failed")
                } else if let waiting = plus.waiting {
                    PlusNote(title: "Waiting for approval", line: "Plus unlocks as soon as it's approved. You can close this.",
                             id: "plus-waiting")
                    let waitingPlan: PlusPlan = waiting == PlusProduct.plus ? .plus : .family
                    PlanRow(plan: waitingPlan, price: plus.prices[waiting], chosen: true, choosable: false) {}
                } else {
                    ForEach(PlusPlan.allCases) { option in
                        PlanRow(plan: option, price: plus.prices[option.productID], chosen: plan == option) { plan = option }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 20)
        }
        .background(Color(.systemGroupedBackground))
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 10) {
                mainButton
                if !plus.canMakePayments {
                    Text(PlusStore.purchasesOffLine)
                        .font(.footnote).foregroundStyle(.secondary).multilineTextAlignment(.center)
                        .accessibilityIdentifier("plus-payments-off")
                }
                PlusFooter(restore: restore)
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .padding(.bottom, 6)
            .background(Color(.systemGroupedBackground))
        }
        .plusProblemAlert($problem) { buy() }
        .onPerfCommand { action in if action == .nextPlan { plan = plan == .plus ? .family : .plus } }
    }

    @ViewBuilder private var mainButton: some View {
        if plus.pricesState == .failed {
            PlusMainButton(title: "Try Again", id: "plus-try-again") { Task { await plus.loadPrices() } }
        } else if plus.waiting != nil {
            PlusMainButton(title: "Waiting for Approval", enabled: false, id: "plus-buy") {}
        } else {
            PlusMainButton(title: plus.buyTitle(plan), working: plus.buying || plus.pricesState == .loading,
                           enabled: plus.canMakePayments, id: "plus-buy") { buy() }
        }
    }

    private func buy() {
        Task {
            switch await plus.buy(plan.productID) {
            case .bought(let bought): onBought(bought)
            case .failed(let failure): problem = failure
            case .pending, .cancelled: break // Apple's sheet said it all; waiting shows on the page
            }
        }
    }
}

/// "Plus is yours" (screens 18, 22 and 25): how it came, what's included, and for a Plus owner the upgrade to Plus
/// Family. A family member sees no purchase buttons; leaving the family is done in Settings. On a new device with the
/// same Apple Account it's already here, with nothing to press or sign in to.
private struct YourPlusView: View {
    let restore: () -> Void
    let upgrade: () -> Void
    @Environment(PlusStore.self) private var plus
    @Environment(\.openURL) private var openURL

    var body: some View {
        List {
            Section {
                PlusHeading(symbol: "checkmark.circle", title: "Plus is yours", line: line)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
            }
            Section {
                Label("Unlimited habits", systemImage: "infinity")
                Label("Your iPad and Apple Watch", systemImage: "ipad.and.iphone")
                Label("Sync through your own iCloud", systemImage: "icloud")
                if plus.ownedPlan == .family {
                    Label("Up to 5 people in your Apple family", systemImage: "person.2")
                }
            } header: {
                Text("Included")
            } footer: {
                if plus.isFamilyMember {
                    Text("Your habits are your own: nobody in the family sees them. To leave the family, go to Settings › your name › Family Sharing. Your habits all stay; only Plus stops.")
                } else if plus.ownedPlan != nil {
                    Text("Nothing to sign in to: Plus comes with your Apple Account, on every device signed in to it.")
                }
            }
            if plus.ownedPlan == .plus {
                Section {
                    Button(action: upgrade) {
                        HStack {
                            Text("Upgrade to Plus Family").foregroundStyle(Color.primary)
                            Spacer(minLength: 8)
                            if let price = plus.prices[PlusProduct.upgrade] { Text(price).foregroundStyle(.secondary) }
                            Image(systemName: "chevron.right")
                                .font(.footnote.weight(.semibold))
                                .foregroundStyle(.tertiary)
                                .accessibilityHidden(true)
                        }
                        .contentShape(Rectangle())
                    }
                    .accessibilityIdentifier("plus-upgrade")
                } footer: {
                    Text("Add up to 5 people for the difference.")
                }
            }
            Section {
                if !plus.isFamilyMember {
                    Button("Restore Purchases", action: restore).accessibilityIdentifier("plus-restore")
                }
                Button("Contact Us") { if let url = Support.mailURL() { openURL(url) } }
            }
            .foregroundStyle(Color.primary)
        }
        .listStyle(.insetGrouped)
    }

    private var line: String {
        switch plus.ownership {
        case .owner(_, let since): "Yours forever · bought \(PlusDates.day(since)) with your Apple Account"
        case .familyMember: "Shared by your Apple family"
        case .none: "Yours forever"
        }
    }
}

/// Plus → Plus Family (screen 21): only the difference, then Apple's sheet, then "Plus Family is yours".
struct PlusUpgradeView: View {
    let onBought: () -> Void
    @Environment(PlusStore.self) private var plus
    @State private var problem: PlusProblem?

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                PlusHeading(symbol: "plus.circle", title: "Plus Family", line: "Add up to 5 people. You pay only the difference.")
                    .padding(.bottom, 10)
                if plus.pricesState == .failed {
                    PlusNote(title: "Prices didn't load", line: "Check your connection, then try again. Nothing was charged.",
                             id: "plus-prices-failed")
                } else {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Plus Family").font(.headline)
                        Text("You + 5 people in your Apple family, each with their own habits")
                            .font(.subheadline).foregroundStyle(.secondary)
                        HStack(alignment: .firstTextBaseline, spacing: 6) {
                            PriceText(price: plus.prices[PlusProduct.upgrade]).font(.title2.bold())
                            Text("the difference · one-time").font(.caption).foregroundStyle(.secondary)
                        }
                        .padding(.top, 6)
                    }
                    .plusCard(chosen: true)
                    VStack(spacing: 12) {
                        LabeledContent("You already have Plus") {
                            if let since = plus.since { Text("Since \(PlusDates.day(since))") }
                        }
                        Divider()
                        LabeledContent("Plus Family") { PriceText(price: plus.prices[PlusProduct.family]) }
                    }
                    .plusCard()
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 20)
        }
        .background(Color(.systemGroupedBackground))
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 10) {
                if plus.pricesState == .failed {
                    PlusMainButton(title: "Try Again", id: "plus-try-again") { Task { await plus.loadPrices() } }
                } else {
                    PlusMainButton(title: plus.prices[PlusProduct.upgrade].map { "Upgrade · \($0)" } ?? "Upgrade",
                                   working: plus.buying || plus.pricesState == .loading || plus.waiting != nil,
                                   enabled: plus.canMakePayments, id: "plus-upgrade-buy") { buy() }
                }
                Text(plus.canMakePayments ? "Shared through Apple's Family Sharing." : PlusStore.purchasesOffLine)
                    .font(.footnote).foregroundStyle(.secondary).multilineTextAlignment(.center)
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .padding(.bottom, 6)
            .background(Color(.systemGroupedBackground))
        }
        .navigationTitle("Upgrade")
        .navigationBarTitleDisplayMode(.inline)
        .plusProblemAlert($problem) { buy() }
    }

    private func buy() {
        Task {
            switch await plus.buy(PlusProduct.upgrade) {
            case .bought: onBought()
            case .failed(let failure): problem = failure
            case .pending, .cancelled: break
            }
        }
    }
}

/// After paying (screens 7 and 17): Plus is on the person's Apple Account; Plus Family reaches their Apple family
/// through Family Sharing, with nothing to set up, invite or sign in to. Done goes back to what they were doing.
struct PlusIsYoursView: View {
    let plan: PlusPlan
    let done: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                PlusHeading(symbol: "checkmark.circle", title: plan == .plus ? "Plus is yours" : "Plus Family is yours",
                            line: plan == .plus
                                ? "Thank you. It's on your Apple Account, so every iPhone, iPad and Mac signed in to it has Plus."
                                : "Everyone in your Apple family gets Plus on their own devices, with nothing to set up here. Their habits stay their own; nobody sees anyone else's.")
                if plan == .plus {
                    Text("Your habits stay on your devices and in your own iCloud. We never see them.")
                        .font(.footnote).foregroundStyle(.secondary).multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 56)
        }
        .scrollBounceBehavior(.basedOnSize)
        .background(Color(.systemGroupedBackground))
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 10) {
                PlusMainButton(title: "Done", id: "plus-done", action: done)
                if plan == .family {
                    Text("Up to 5 people in your Apple family. They need Share Purchases on: Settings › your name › Family Sharing.")
                        .font(.footnote).foregroundStyle(.secondary).multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 6)
        }
        .toolbar(.hidden, for: .navigationBar)
        .presentationDragIndicator(.visible)
    }
}

// MARK: - The 6th habit

/// Starting a 6th habit on the free plan (screens 2–4): straight away, the person's own 5 habits and an empty 6th,
/// Plus and Plus Family side by side, and "Make room instead". ✕ is the only way out: there is no "Not now" (the user,
/// 10 Oct 2026). Whatever they were doing is kept: `onUnlocked` runs once they have Plus or have made room, and the
/// caller saves its habit (or brings it back) once the sheet has closed.
struct SixthHabitSheet: View {
    enum Reason {
        /// New → Build or maintain / Quit or cut down.
        case sixth
        /// A filled-in form (an idea, "Add Drink water"), kept as it is.
        case adding(String)
        /// Bringing back an archived habit ("Bring back Read"); its history is never touched.
        case restoring(String)
    }

    let reason: Reason
    let onUnlocked: () -> Void
    @Environment(PlusStore.self) private var plus
    @Environment(\.dismiss) private var dismiss
    @Environment(\.dynamicTypeSize) private var typeSize
    @State private var plan: PlusPlan = .plus
    @State private var problem: PlusProblem?
    @State private var bought: PlusPlan?
    @State private var analyticsFlow = Analytics.shared.ticket

    var body: some View {
        NavigationStack {
            if let bought {
                PlusIsYoursView(plan: bought) {
                    onUnlocked()
                    dismiss()
                }
            } else {
                choice
            }
        }
        .presentationDragIndicator(.visible)
        .onChange(of: plus.approved) {
            guard let approved = plus.approved, bought == nil else { return }
            plus.approved = nil
            bought = approved
        }
        .analyticsScreen(.plus)
        .onAppear { Analytics.shared.event(.paywall, ["entry_point": .text("habit_limit")], ticket: analyticsFlow) }
    }

    private var title: String {
        switch reason {
        case .sixth: "Add a \(HabitStore.freeHabitLimit + 1)th habit"
        case .adding(let name): "Add \(name)"
        case .restoring(let name): "Bring back \(name)"
        }
    }

    private var line: String {
        switch reason {
        case .sixth: "You're using all \(HabitStore.freeHabitLimit) free habits."
        case .adding: "It would be your \(HabitStore.freeHabitLimit + 1)th habit."
        case .restoring(let name): "\(name) would be your \(HabitStore.freeHabitLimit + 1)th habit."
        }
    }

    private var choice: some View {
        ScrollView {
            VStack(spacing: 18) {
                HabitIconsRow()
                VStack(spacing: 6) {
                    Text(title)
                        .font(.title2.bold())
                        .multilineTextAlignment(.center)
                        .accessibilityAddTraits(.isHeader)
                        .accessibilityIdentifier("sixth-title")
                    Text(line).font(.subheadline).foregroundStyle(.secondary).multilineTextAlignment(.center)
                }
                if plus.pricesState == .failed {
                    PlusNote(title: "Prices didn't load", line: "Check your connection, then try again. Nothing was charged.",
                             id: "plus-prices-failed")
                } else if plus.waiting != nil {
                    PlusNote(title: "Waiting for approval", line: "Plus unlocks as soon as it's approved. You can close this.",
                             id: "plus-waiting")
                } else {
                    let layout = typeSize.isAccessibilitySize ? AnyLayout(VStackLayout(spacing: 12)) : AnyLayout(HStackLayout(spacing: 12))
                    layout {
                        ForEach(PlusPlan.allCases) { option in
                            PlanCard(plan: option, price: plus.prices[option.productID], chosen: plan == option) { plan = option }
                        }
                    }
                    .fixedSize(horizontal: false, vertical: true)
                }
                PlusIncluded()
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .background(Color(.systemGroupedBackground))
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 4) {
                mainButton
                if !plus.canMakePayments {
                    Text(PlusStore.purchasesOffLine)
                        .font(.footnote).foregroundStyle(.secondary).multilineTextAlignment(.center)
                        .accessibilityIdentifier("plus-payments-off")
                }
                NavigationLink {
                    MakeRoomView {
                        onUnlocked()
                        dismiss()
                    }
                } label: {
                    Text("Make room instead")
                        .font(.body.weight(.medium))
                        .foregroundStyle(Color.primary)
                        .frame(maxWidth: .infinity, minHeight: 36)
                        .contentShape(Rectangle())
                }
                .accessibilityIdentifier("plus-make-room")
                Text("Archive a habit (it keeps its progress) or delete one")
                    .font(.footnote).foregroundStyle(.secondary).multilineTextAlignment(.center)
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .padding(.bottom, 6)
            .background(Color(.systemGroupedBackground))
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button { dismiss() } label: { Image(systemName: "xmark") }
                    .accessibilityLabel("Close")
                    .accessibilityIdentifier("plus-close")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .plusProblemAlert($problem) { buy() }
        .onPerfCommand { action in if action == .nextPlan { plan = plan == .plus ? .family : .plus } }
    }

    @ViewBuilder private var mainButton: some View {
        if plus.pricesState == .failed {
            PlusMainButton(title: "Try Again", id: "plus-try-again") { Task { await plus.loadPrices() } }
        } else if plus.waiting != nil {
            PlusMainButton(title: "Waiting for Approval", enabled: false, id: "plus-buy") {}
        } else {
            PlusMainButton(title: plus.buyTitle(plan), working: plus.buying || plus.pricesState == .loading,
                           enabled: plus.canMakePayments, id: "plus-buy") { buy() }
        }
    }

    private func buy() {
        Task {
            switch await plus.buy(plan.productID) {
            case .bought(let plan): bought = plan
            case .failed(let failure): problem = failure
            case .pending, .cancelled: break
            }
        }
    }
}

/// The person's own habits (up to 5) and an empty 6th, at the top of the 6th-habit sheet ("that looks cool", the user).
private struct HabitIconsRow: View {
    @Environment(HabitStore.self) private var store

    var body: some View {
        let habits = store.habits.filter { !$0.archived && $0.kind != .task }.prefix(HabitStore.freeHabitLimit)
        HStack(spacing: 10) {
            ForEach(Array(habits)) { habit in
                HabitIcon(symbol: habit.symbol, color: habit.color, size: 44)
            }
            Image(systemName: "plus")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.secondary)
                .frame(width: 44, height: 44)
                .overlay(RoundedRectangle(cornerRadius: 44 * 0.28, style: .continuous)
                    .strokeBorder(Color.secondary, style: StrokeStyle(lineWidth: 1.5, dash: [4, 3])))
        }
        .padding(.top, 8)
        .accessibilityHidden(true)
    }
}

/// "Make room instead" (screens 5 and 6): Archive is the plain, safe action on each habit; Delete only in •••, asking
/// first and offering Archive Instead. Once one is gone, what the person was adding goes ahead: nothing bought, nothing
/// lost.
struct MakeRoomView: View {
    let onRoomMade: () -> Void
    @Environment(HabitStore.self) private var store
    @State private var deleting: Habit?
    @State private var working = false

    var body: some View {
        let habits = store.habits.filter { !$0.archived && $0.kind != .task }
        List {
            Section {
                ForEach(habits) { habit in
                    HStack(spacing: 12) {
                        HabitIcon(symbol: habit.symbol, color: habit.color, size: 30)
                        Text(habit.name).lineLimit(1)
                        Spacer(minLength: 8)
                        Button("Archive") { archive(habit) }
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.capsule)
                            .controlSize(.small)
                            .foregroundStyle(Color.primary)
                            .tint(.secondary)
                            .accessibilityLabel("Archive \(habit.name)")
                            .accessibilityIdentifier("make-room-archive-\(habit.name)")
                        Menu {
                            Button("Delete…", systemImage: "trash", role: .destructive) { deleting = habit }
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.secondary)
                                .frame(width: 32, height: 32)
                                .contentShape(Rectangle())
                        }
                        .accessibilityLabel("More for \(habit.name)")
                        .accessibilityIdentifier("make-room-more-\(habit.name)")
                    }
                }
            } header: {
                Text(header(habits.count))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .textCase(nil)
            } footer: {
                Text("Archived habits keep all their progress, and you can bring them back any time.")
            }
        }
        .listStyle(.insetGrouped)
        .disabled(working)
        .navigationTitle("Make Room")
        .navigationBarTitleDisplayMode(.inline)
        .alert(deleting.map { "Delete \($0.name)?" } ?? "", isPresented: Binding(get: { deleting != nil }, set: { if !$0 { deleting = nil } }),
               presenting: deleting) { habit in
            Button("Archive Instead") { archive(habit) }
            Button("Delete", role: .destructive) { delete(habit) }
            Button("Cancel", role: .cancel) {}
        } message: { _ in
            Text("Its history and notes are deleted too. Archiving keeps them and makes room just the same.")
        }
    }

    /// "Archive or delete one of your 5 habits…"; over the limit (after Plus ended) it says how many more.
    private func header(_ count: Int) -> String {
        let over = count - HabitStore.freeHabitLimit + 1
        return over <= 1 ? "Archive or delete one of your \(count) habits to add a new one."
            : "Archive or delete \(over) of your \(count) habits to add a new one."
    }

    private func archive(_ habit: Habit) {
        working = true
        store.archive([habit])
        goOn()
    }

    private func delete(_ habit: Habit) {
        working = true
        store.delete([habit])
        goOn()
    }

    /// Saved before going on, so the free slot is really there (`HabitStore.restore` checks). Over the limit, one isn't
    /// enough: the page stays until there's room.
    private func goOn() {
        Task {
            await store.flush()
            working = false
            if store.canAddHabit { onRoomMade() }
        }
    }
}

extension View {
    /// Bringing back an archived habit past the free plan's 5 (screen 4): the 6th-habit sheet, then, once there's Plus or
    /// room, the habit comes back with its history.
    func restoringPastTheLimit(_ habit: Binding<Habit?>) -> some View {
        modifier(RestorePastTheLimit(habit: habit))
    }
}

private struct RestorePastTheLimit: ViewModifier {
    @Binding var habit: Habit?
    @Environment(HabitStore.self) private var store
    @State private var unlocked: Habit?

    func body(content: Content) -> some View {
        content.sheet(item: $habit, onDismiss: {
            guard let unlocked else { return }
            self.unlocked = nil
            store.restore(unlocked)
        }) { habit in
            SixthHabitSheet(reason: .restoring(habit.name)) { unlocked = habit }
        }
    }
}

// MARK: - When Plus ends

/// "Plus has ended" (screens 23 and 24), once, the next time the app opens after the App Store took Plus away (a
/// refund, or a family that stopped sharing). Nothing is hidden or locked: every habit stays, even over 5; adding
/// another needs room or Plus again.
struct PlusEndedView: View {
    let reason: PlusEnded
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var showPlus = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    PlusHeading(symbol: "plus.circle", title: "Plus has ended",
                                line: reason == .refund ? "It was refunded through the App Store."
                                    : "You left the Apple family, or its purchase sharing was turned off.")
                    PlusNote(title: "Your habits are all here", line: habitsLine, id: "plus-ended-habits")
                }
                .padding(.horizontal, 16)
                .padding(.top, 40)
            }
            .scrollBounceBehavior(.basedOnSize)
            .background(Color(.systemGroupedBackground))
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 10) {
                    PlusMainButton(title: "OK", id: "plus-ended-ok") { dismiss() }
                    PlusSecondButton(title: reason == .refund ? "Get Plus Again" : "Get Plus", id: "plus-ended-get") { showPlus = true }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 6)
            }
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(isPresented: $showPlus) { PlusPage() }
        }
        .presentationDragIndicator(.visible)
    }

    private var habitsLine: String {
        let count = store.activeHabitCount
        let limit = HabitStore.freeHabitLimit
        let again = reason == .refund ? "get Plus again" : "get Plus of your own"
        if count > limit {
            return "All \(count) keep working, with their history. To add another habit, make room under \(limit), or \(again)."
        }
        return "They all keep working, with their history. The free plan holds \(limit) habits; you can \(again) any time."
    }
}

// MARK: - Pieces

/// A Plus screen's heading: a plain symbol, the title, and one line under it.
struct PlusHeading: View {
    let symbol: String
    let title: String
    var line: String? = nil
    @ScaledMetric(relativeTo: .largeTitle) private var size: CGFloat = 44

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: symbol)
                .font(.system(size: size, weight: .light))
                .foregroundStyle(Color.ink)
                .accessibilityHidden(true)
            Text(title)
                .font(.title.bold())
                .multilineTextAlignment(.center)
                .accessibilityAddTraits(.isHeader)
            if let line {
                Text(line)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

/// The one filled button on a Plus screen: ink, full width, at the bottom (U2, U18).
struct PlusMainButton: View {
    let title: String
    var working = false
    var enabled = true
    let id: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Text(title).font(.headline).opacity(working ? 0 : 1)
                if working { ProgressView().tint(Color.onInk) }
            }
            .foregroundStyle(enabled ? Color.onInk : Color.secondary)
            .frame(maxWidth: .infinity, minHeight: 34)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .tint(.ink)
        .disabled(!enabled)
        .allowsHitTesting(!working)
        .accessibilityIdentifier(id)
    }
}

/// A second, plain choice beside the filled button.
struct PlusSecondButton: View {
    let title: String
    let id: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title).font(.headline).foregroundStyle(Color.primary).frame(maxWidth: .infinity, minHeight: 34)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .tint(.secondary)
        .accessibilityIdentifier(id)
    }
}

/// A plan on the Plus page: chosen with a tap; a check and an ink outline show which.
private struct PlanRow: View {
    let plan: PlusPlan
    let price: String?
    let chosen: Bool
    var choosable = true
    let choose: () -> Void

    var body: some View {
        Button(action: choose) {
            HStack(spacing: 12) {
                if choosable {
                    Image(systemName: chosen ? "checkmark.circle.fill" : "circle")
                        .font(.title2)
                        .foregroundStyle(chosen ? Color.ink : Color(.tertiaryLabel))
                        .accessibilityHidden(true)
                }
                VStack(alignment: .leading, spacing: 3) {
                    Text(plan.title).font(.headline)
                    Text(plan.detail).font(.subheadline).foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                PriceText(price: price).font(.headline)
            }
            .foregroundStyle(Color.primary)
            .plusCard(chosen: chosen)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(!choosable)
        .accessibilityAddTraits(chosen ? .isSelected : [])
        .accessibilityIdentifier("plan-" + plan.rawValue)
    }
}

/// A plan in the 6th-habit sheet: the two side by side.
private struct PlanCard: View {
    let plan: PlusPlan
    let price: String?
    let chosen: Bool
    let choose: () -> Void

    var body: some View {
        Button(action: choose) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .firstTextBaseline) {
                    Text(plan.name).font(.headline)
                    Spacer(minLength: 4)
                    Image(systemName: chosen ? "checkmark.circle.fill" : "circle")
                        .font(.title3)
                        .foregroundStyle(chosen ? Color.ink : Color(.tertiaryLabel))
                        .accessibilityHidden(true)
                }
                Text(plan.who).font(.subheadline).foregroundStyle(.secondary)
                Spacer(minLength: 12)
                PriceText(price: price).font(.title2.bold())
                Text("one-time").font(.caption).foregroundStyle(.secondary)
            }
            .foregroundStyle(Color.primary)
            .plusCard(chosen: chosen)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(chosen ? .isSelected : [])
        .accessibilityIdentifier("plan-" + plan.rawValue)
    }
}

/// A price as the App Store gave it; a grey placeholder while it loads, never a made-up number.
private struct PriceText: View {
    let price: String?

    var body: some View {
        Text(price ?? "$00.00")
            .monospacedDigit()
            .redacted(reason: price == nil ? .placeholder : [])
    }
}

/// "5 of 5 free habits used", with a quiet dot for each.
private struct FreeHabitCount: View {
    @Environment(HabitStore.self) private var store

    var body: some View {
        let count = store.activeHabitCount
        let limit = HabitStore.freeHabitLimit
        HStack {
            Text("\(count) of \(limit) free habits used")
            Spacer(minLength: 8)
            HStack(spacing: 5) {
                ForEach(0..<limit, id: \.self) { i in
                    Circle().fill(i < count ? Color.ink : Color(.systemFill)).frame(width: 8, height: 8)
                }
            }
            .accessibilityHidden(true)
        }
        .plusCard()
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("plus-count")
    }
}

/// A short status card: prices that didn't load, a purchase waiting for approval, habits that all stay.
private struct PlusNote: View {
    let title: String
    let line: String
    let id: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.headline)
            Text(line).font(.subheadline).foregroundStyle(.secondary)
        }
        .plusCard()
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier(id)
    }
}

/// What both plans include, in the 6th-habit sheet.
private struct PlusIncluded: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Both plans include")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
            ForEach(["Unlimited habits", "Your iPad and Apple Watch", "Sync through your own iCloud"], id: \.self) { item in
                Label {
                    Text(item)
                } icon: {
                    Image(systemName: "checkmark.circle").foregroundStyle(Color.ink)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 4)
    }
}

/// "One-time, no subscription · Restore Purchases": Restore is always on the page (App Review 3.1.1).
private struct PlusFooter: View {
    let restore: () -> Void
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let layout = typeSize.isAccessibilitySize ? AnyLayout(VStackLayout(spacing: 4)) : AnyLayout(HStackLayout(spacing: 6))
        layout {
            Text("One-time, no subscription").foregroundStyle(.secondary)
            if !typeSize.isAccessibilitySize { Text("·").foregroundStyle(.secondary).accessibilityHidden(true) }
            Button("Restore Purchases", action: restore).accessibilityIdentifier("plus-restore")
        }
        .font(.footnote)
    }
}

extension View {
    /// A card on the grouped background; a chosen one has an ink outline.
    func plusCard(chosen: Bool = false) -> some View {
        padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.card, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).strokeBorder(Color.ink, lineWidth: 2).opacity(chosen ? 1 : 0))
    }

    /// A purchase that didn't go through (screen 12): a native alert in plain words, with Try Again when trying again
    /// can help.
    func plusProblemAlert(_ problem: Binding<PlusProblem?>, retry: @escaping () -> Void) -> some View {
        alert(problem.wrappedValue?.title ?? "", isPresented: Binding(get: { problem.wrappedValue != nil },
                                                                     set: { if !$0 { problem.wrappedValue = nil } }),
              presenting: problem.wrappedValue) { shown in
            if shown.canRetry { Button("Try Again") { retry() } }
            Button("OK", role: .cancel) {}
        } message: { shown in
            Text(shown.message)
        }
    }
}

extension PlusStore {
    /// The main button names what it buys and its price: "Get Plus · $24.99".
    func buyTitle(_ plan: PlusPlan) -> String {
        guard let price = prices[plan.productID] else { return "Get \(plan.name)" }
        return "Get \(plan.name) · \(price)"
    }
}

enum PlusDates {
    /// "12 Mar 2027", in the person's own order of day, month and year.
    static func day(_ date: Date) -> String {
        date.formatted(.dateTime.day().month(.abbreviated).year())
    }
}
