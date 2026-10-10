import Foundation
import Observation
import StoreKit
import UIKit

// Plus from the App Store, with StoreKit 2 (Current Work 80; the Plus screens, 10 Oct 2026). Plus is the account's
// `HabitStore.isPlus` (Debug's default, the account path) OR an App Store entitlement for any of the three products,
// not revoked. Prices are always the App Store's own `displayPrice`, never typed here. No server sees a purchase: the
// App Store keeps it with the person's Apple Account, so every device signed in to it has Plus (Rulebook D16).

/// The two plans. Plus Family is shared through Apple's Family Sharing: nothing to set up in the app.
enum PlusPlan: String, CaseIterable, Identifiable {
    case plus, family
    var id: Self { self }

    var productID: String { self == .plus ? PlusProduct.plus : PlusProduct.family }
    var name: String { self == .plus ? "Plus" : "Plus Family" }
    /// Who it's for, in the 6th-habit sheet's cards.
    var who: String { self == .plus ? "Just you" : "You + 5 people" }
    /// The Plus page's row title.
    var title: String { self == .plus ? "Plus · just you" : "Plus Family · you + 5" }
    var detail: String {
        self == .plus ? "Unlimited habits, your iPad and Apple Watch, sync through your own iCloud"
            : "Everything in Plus for you and up to 5 people in your Apple family, each with their own habits"
    }
}

/// Who has Plus on this Apple Account, as the App Store says.
enum PlusOwnership: Equatable {
    case none
    /// Bought with this Apple Account: Plus, or Plus Family (bought outright or as the upgrade).
    case owner(PlusPlan, since: Date)
    /// Shared by someone in the person's Apple family (`ownershipType == .familyShared`).
    case familyMember(since: Date)
}

/// One App Store entitlement, as much of it as the screens need.
struct PlusEntitlement: Equatable {
    let productID: String
    let familyShared: Bool
    let purchased: Date
}

/// Something that went wrong, in plain words: an alert's title and message, never an error code.
struct PlusProblem: Identifiable, Equatable {
    let title: String
    let message: String
    /// The alert offers Try Again.
    var canRetry = true
    var id: String { title + message }

    static var noAnswer: PlusProblem {
        PlusProblem(title: "The App Store didn't respond", message: "Nothing was charged. Try again in a minute.")
    }
    static var notAllowed: PlusProblem {
        PlusProblem(title: "Purchases are turned off", message: PlusStore.purchasesOffLine, canRetry: false)
    }
    static var unavailable: PlusProblem {
        PlusProblem(title: "Plus isn't available right now",
                    message: "The App Store couldn't offer it. Nothing was charged. Please try again later.", canRetry: false)
    }
    static var unconfirmed: PlusProblem {
        PlusProblem(title: "The purchase wasn't confirmed",
                    message: "The App Store didn't confirm it, so Plus isn't on yet. Try Restore Purchases in a minute, or contact us and we'll help.",
                    canRetry: false)
    }
}

enum PlusPurchase: Equatable { case bought(PlusPlan), pending, cancelled, failed(PlusProblem) }
enum PlusRestore: Equatable { case found(PlusOwnership), nothing, cancelled, failed }
/// Why Plus ended: shown once, the next time the app opens ("Plus has ended", screens 23 and 24).
enum PlusEnded: String, Identifiable { case refund, family; var id: Self { self } }
enum PlusPrices: Equatable { case loading, loaded, failed }

/// What the App Store answered a purchase with, before the screens see it.
enum PlusBackendPurchase { case success(PlusEntitlement), pending, cancelled, failed(PlusProblem) }
enum PlusSync { case done, cancelled, failed }

/// The App Store, or a test launch's stand-in for it (`PlusTestBackend`).
protocol PlusBackend: AnyObject {
    var canMakePayments: Bool { get }
    /// Product ID → the App Store's display price. Throws when the App Store can't be reached.
    func prices() async throws -> [String: String]
    func purchase(_ productID: String) async -> PlusBackendPurchase
    /// This Apple Account's current entitlements to the three products, revoked ones left out.
    func entitlements() async -> [PlusEntitlement]
    /// Whether one of the products was refunded (a revoked transaction).
    func refunded() async -> Bool
    func sync() async -> PlusSync
    /// Calls `changed` whenever the App Store says something changed (`Transaction.updates`), from launch.
    func listen(_ changed: @escaping @MainActor () async -> Void)
}

@Observable
final class PlusStore {
    private(set) var ownership: PlusOwnership = .none
    /// Product ID → display price, once the App Store has answered.
    private(set) var prices: [String: String] = [:]
    private(set) var pricesState: PlusPrices = .loading
    /// Screen Time can turn purchases off: known before tapping, so the button is off and says why.
    private(set) var canMakePayments = true
    /// A purchase waiting for a parent's approval (Ask to Buy): its product, until the App Store says yes.
    private(set) var waiting: String?
    /// A waiting purchase the App Store has now approved: the screen that's open says "Plus is yours", once.
    var approved: PlusPlan?
    /// Plus came off this Apple Account since the app last saw it: "Plus has ended", once.
    var ended: PlusEnded?
    private(set) var buying = false

    var hasPlus: Bool { ownership != .none }
    var ownedPlan: PlusPlan? { if case .owner(let plan, _) = ownership { plan } else { nil } }
    var isFamilyMember: Bool { if case .familyMember = ownership { true } else { false } }
    var since: Date? {
        switch ownership {
        case .none: nil
        case .owner(_, let date), .familyMember(let date): date
        }
    }

    @ObservationIgnored private let backend: PlusBackend
    /// Test launches never read or write the person's own Plus notes (Rulebook D8).
    @ObservationIgnored private let remembers: Bool
    @ObservationIgnored private var started = false
    /// Tells `HabitStore` whether the App Store says Plus.
    @ObservationIgnored var onChange: (Bool) -> Void = { _ in }

    init(backend: PlusBackend, remembers: Bool) {
        self.backend = backend
        self.remembers = remembers
    }

    /// From launch: the App Store's changes (an approved Ask to Buy, a refund, a family that stopped sharing), what this
    /// Apple Account owns, and the prices.
    func start() {
        guard !started else { return }
        started = true
        canMakePayments = backend.canMakePayments
        #if DEBUG
        let arguments = ProcessInfo.processInfo.arguments
        if let i = arguments.firstIndex(of: "-plus-ended"), i + 1 < arguments.count { ended = PlusEnded(rawValue: arguments[i + 1]) }
        #endif
        backend.listen { [weak self] in await self?.refresh() }
        Task {
            await refresh()
            await loadPrices()
        }
    }

    func loadPrices() async {
        if pricesState == .failed { pricesState = .loading }
        canMakePayments = backend.canMakePayments
        do {
            let found = try await backend.prices()
            prices = found
            // Both plans or nothing: one price and a blank beside it would look like a made-up choice.
            pricesState = found[PlusProduct.plus] != nil && found[PlusProduct.family] != nil ? .loaded : .failed
        } catch {
            pricesState = .failed
        }
    }

    func refresh() async {
        let now = Self.ownership(from: await backend.entitlements())
        let before = ownership
        if now != before { ownership = now }
        if now != .none, let product = waiting {
            waiting = nil
            approved = product == PlusProduct.plus ? .plus : .family
        }
        onChange(now != .none)
        await noteEnded(now: now)
    }

    static func ownership(from list: [PlusEntitlement]) -> PlusOwnership {
        let own = list.filter { !$0.familyShared }
        if let first = own.map(\.purchased).min() {
            return .owner(own.contains { $0.productID != PlusProduct.plus } ? .family : .plus, since: first)
        }
        if let shared = list.filter(\.familyShared).map(\.purchased).min() { return .familyMember(since: shared) }
        return .none
    }

    /// Buys a product. Apple's own sheet asks first; cancelling there shows nothing here.
    func buy(_ productID: String) async -> PlusPurchase {
        guard !buying else { return .cancelled }
        buying = true
        defer { buying = false }
        // Usage sharing (optional): captured when the purchase starts, sent with its verified end only.
        let ticket = Analytics.shared.ticket
        let outcome: PlusPurchase
        switch await backend.purchase(productID) {
        case .success(let entitlement):
            await refresh()
            // The entitlement list can lag the purchase by a moment: what was just bought counts at once.
            if ownership == .none {
                ownership = Self.ownership(from: [entitlement])
                onChange(true)
            }
            outcome = .bought(productID == PlusProduct.plus ? .plus : .family)
        case .pending:
            waiting = productID
            outcome = .pending
        case .cancelled:
            outcome = .cancelled
        case .failed(let problem):
            outcome = .failed(problem)
        }
        let tier = productID == PlusProduct.plus ? "plus" : productID == PlusProduct.family ? "family" : "family_upgrade"
        let result = switch outcome {
        case .bought: "verified"
        case .pending: "pending"
        case .cancelled: "cancelled"
        case .failed: "failed"
        }
        var failure = "none"
        if case .failed(let problem) = outcome { failure = problem == .unconfirmed ? "verification" : "unavailable" }
        Analytics.shared.event(.purchase, ["product_tier": .text(tier), "result": .text(result), "verification": .text("store"),
                                           "failure_code": .text(failure)], ticket: ticket)
        return outcome
    }

    /// Restore Purchases (`AppStore.sync()`): a real result naming what was found, never a "restored" that found nothing.
    func restore() async -> PlusRestore {
        guard !buying else { return .cancelled }
        buying = true
        defer { buying = false }
        let ticket = Analytics.shared.ticket
        let outcome: PlusRestore
        switch await backend.sync() {
        case .cancelled: outcome = .cancelled
        case .failed: outcome = .failed
        case .done:
            await refresh()
            outcome = ownership == .none ? .nothing : .found(ownership)
        }
        let result = switch outcome {
        case .found: "restored"
        case .nothing: "no_entitlement"
        case .cancelled: "cancelled"
        case .failed: "failed"
        }
        Analytics.shared.event(.purchaseRestore, ["result": .text(result), "verification": .text("store"),
                                                  "failure_code": .text(outcome == .failed ? "network" : "none")], ticket: ticket)
        return outcome
    }

    func acknowledgeEnded() {
        ended = nil
        if remembers { UserDefaults.standard.removeObject(forKey: Keys.ended) }
    }

    /// Remembers what the App Store last said (written only when it changes, S15), so Plus that's gone since is told
    /// once: a refund (a revoked purchase), or a family that stopped sharing. An owner's Plus that's simply not listed
    /// (signed out of the App Store) says nothing: nothing is hidden or locked either way.
    private func noteEnded(now: PlusOwnership) async {
        guard remembers else { return }
        let defaults = UserDefaults.standard
        let seen = defaults.string(forKey: Keys.seen)
        let current: String? = switch now {
        case .none: nil
        case .owner: "owner"
        case .familyMember: "member"
        }
        if seen != current {
            if current == nil, let seen {
                // Asked on its own line: an `await` inside `?:` doesn't build (Rulebook T17).
                var refunded = false
                if seen == "owner" { refunded = await backend.refunded() }
                let reason: PlusEnded? = seen == "member" ? .family : refunded ? .refund : nil
                if let reason { defaults.set(reason.rawValue, forKey: Keys.ended) }
            }
            defaults.set(current, forKey: Keys.seen)
        }
        if current != nil, defaults.string(forKey: Keys.ended) != nil { defaults.removeObject(forKey: Keys.ended) }
        if ended == nil, current == nil, let raw = defaults.string(forKey: Keys.ended) { ended = PlusEnded(rawValue: raw) }
    }

    private enum Keys {
        static let seen = "plus.storeSeen"
        static let ended = "plus.endedNotice"
    }

    /// "Purchases are turned off on this iPhone (Screen Time). …"
    static var purchasesOffLine: String {
        "Purchases are turned off on this \(UIDevice.current.model) (Screen Time). Whoever manages Screen Time can allow them."
    }
}

/// The App Store itself (StoreKit 2).
final class AppStoreBackend: PlusBackend {
    private var products: [String: Product] = [:]
    private var listener: Task<Void, Never>?

    var canMakePayments: Bool { AppStore.canMakePayments }

    func prices() async throws -> [String: String] {
        let list = try await Product.products(for: PlusProduct.all)
        for product in list { products[product.id] = product }
        return Dictionary(list.map { ($0.id, $0.displayPrice) }, uniquingKeysWith: { first, _ in first })
    }

    func purchase(_ productID: String) async -> PlusBackendPurchase {
        do {
            if products[productID] == nil { _ = try await prices() }
            guard let product = products[productID] else { return .failed(.unavailable) }
            let result: Product.PurchaseResult
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                result = try await product.purchase(confirmIn: scene)
            } else {
                result = try await product.purchase()
            }
            switch result {
            case .success(let verification):
                guard case .verified(let transaction) = verification else { return .failed(.unconfirmed) }
                await transaction.finish()
                return .success(Self.entitlement(transaction))
            case .pending: return .pending
            case .userCancelled: return .cancelled
            @unknown default: return .cancelled
            }
        } catch StoreKitError.userCancelled {
            return .cancelled
        } catch Product.PurchaseError.purchaseNotAllowed {
            return .failed(.notAllowed)
        } catch Product.PurchaseError.productUnavailable {
            return .failed(.unavailable)
        } catch StoreKitError.notAvailableInStorefront {
            return .failed(.unavailable)
        } catch {
            return .failed(.noAnswer)
        }
    }

    func entitlements() async -> [PlusEntitlement] {
        var list: [PlusEntitlement] = []
        for await result in StoreKit.Transaction.currentEntitlements {
            guard case .verified(let transaction) = result, PlusProduct.all.contains(transaction.productID),
                  transaction.revocationDate == nil else { continue }
            list.append(Self.entitlement(transaction))
        }
        return list
    }

    func refunded() async -> Bool {
        for await result in StoreKit.Transaction.all {
            if case .verified(let transaction) = result, PlusProduct.all.contains(transaction.productID),
               transaction.revocationDate != nil { return true }
        }
        return false
    }

    func sync() async -> PlusSync {
        do {
            try await AppStore.sync()
            return .done
        } catch StoreKitError.userCancelled {
            return .cancelled
        } catch {
            return .failed
        }
    }

    func listen(_ changed: @escaping @MainActor () async -> Void) {
        listener?.cancel()
        // Also delivers, at launch, any purchase that wasn't finished (an app closed mid-purchase, an approved Ask to Buy).
        listener = Task {
            for await result in StoreKit.Transaction.updates {
                if case .verified(let transaction) = result, PlusProduct.all.contains(transaction.productID) {
                    await transaction.finish()
                }
                await changed()
            }
        }
    }

    private static func entitlement(_ transaction: StoreKit.Transaction) -> PlusEntitlement {
        PlusEntitlement(productID: transaction.productID, familyShared: transaction.ownershipType == .familyShared,
                        purchased: transaction.purchaseDate)
    }
}

#if DEBUG
/// A test launch's App Store (Rulebook D8: a test never touches the person's own purchases), scripted by launch
/// arguments so every state of the screens can be reached: `-plus-prices-fail` (the first load fails, Try Again
/// works), `-plus-ask-to-buy` (waits for approval), `-plus-purchase-fails`, `-plus-payments-off` (Screen Time),
/// `-plus-owned`, `-plus-owned-family`, `-plus-family-member`, and `-plus-ended refund|family` (PlusStore.start).
/// `-real-storekit` uses the App Store instead (the scheme's StoreKit configuration file, `OftenEnough.storekit`).
final class PlusTestBackend: PlusBackend {
    private let arguments = ProcessInfo.processInfo.arguments
    private var owned: [PlusEntitlement] = []
    private var failures: Int

    init() {
        failures = arguments.contains("-plus-prices-fail") ? 1 : 0
        let bought = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2026, month: 3, day: 12, hour: 12)) ?? .now
        if arguments.contains("-plus-owned") { owned = [PlusEntitlement(productID: PlusProduct.plus, familyShared: false, purchased: bought)] }
        if arguments.contains("-plus-owned-family") { owned = [PlusEntitlement(productID: PlusProduct.family, familyShared: false, purchased: bought)] }
        if arguments.contains("-plus-family-member") { owned = [PlusEntitlement(productID: PlusProduct.family, familyShared: true, purchased: bought)] }
    }

    var canMakePayments: Bool { !arguments.contains("-plus-payments-off") }

    func prices() async throws -> [String: String] {
        try? await Task.sleep(for: .milliseconds(150))
        if failures > 0 {
            failures -= 1
            throw URLError(.notConnectedToInternet)
        }
        // The StoreKit configuration file's prices (iOS/OftenEnough.storekit).
        return [PlusProduct.plus: "$24.99", PlusProduct.family: "$59.99", PlusProduct.upgrade: "$35.00"]
    }

    func purchase(_ productID: String) async -> PlusBackendPurchase {
        try? await Task.sleep(for: .milliseconds(300))
        if arguments.contains("-plus-ask-to-buy") { return .pending }
        if arguments.contains("-plus-purchase-fails") { return .failed(.noAnswer) }
        let entitlement = PlusEntitlement(productID: productID, familyShared: false, purchased: .now)
        owned.append(entitlement)
        return .success(entitlement)
    }

    func entitlements() async -> [PlusEntitlement] { owned }
    func refunded() async -> Bool { false }
    func sync() async -> PlusSync {
        try? await Task.sleep(for: .milliseconds(300))
        return .done
    }
    func listen(_ changed: @escaping @MainActor () async -> Void) {}
}
#endif
