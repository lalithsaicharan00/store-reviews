import Foundation
import Observation
import StoreKit

/// Plus on the Watch (G): read from the same App Store purchase as the iPhone, nothing to restore or sign in to (WA12).
/// The Watch can sell Plus itself (StoreKit on watchOS); Plus Family stays on the iPhone.
@Observable
final class PlusState {
    enum Access { case checking, plus, none }
    /// What G1–G6 shows while not Plus.
    enum Moment: Equatable { case offer, purchasing, bought, waiting, unreachable, ended }

    /// The iPhone's own list (`PlusProduct`): Plus, Plus Family, or the upgrade, bought on any device of the Apple Account.
    static let products = PlusProduct.all
    /// The Watch had Plus before: if it ends, say so (G6) instead of the first offer.
    private static let hadPlusKey = "plus.hadPlus"

    private(set) var access: Access = .checking
    var moment: Moment = .offer
    /// The App Store's own price ("$24.99", `displayPrice`); nil until it has loaded.
    private(set) var price: String?
    @ObservationIgnored private var product: Product?
    @ObservationIgnored private var updates: Task<Void, Never>?
    @ObservationIgnored private let override: Access?

    init(testLaunch: Bool) {
        let arguments = ProcessInfo.processInfo.arguments
        #if DEBUG
        // As on the iPhone: Debug builds behave like Plus (AppModel's "everyone is Plus" switch). `-free` tests without it;
        // `-plus-moment <name>` shows one of the Plus screens for the screenshot review.
        override = arguments.contains("-free") ? Access.none : .plus
        if let i = arguments.firstIndex(of: "-plus-moment"), i + 1 < arguments.count {
            moment = Moment(name: arguments[i + 1]) ?? .offer
            price = "$24.99"
        }
        #else
        override = nil
        #endif
        if let override { access = override }
        guard !testLaunch else { return }
        updates = Task { [weak self] in
            for await update in Transaction.updates {
                if case .verified(let transaction) = update { await transaction.finish() }
                await self?.refresh()
            }
        }
        Task { await refresh() }
    }

    /// Reads the purchase again: at launch, after a purchase, and whenever StoreKit says something changed (a refund, a
    /// family member's purchase, an approved Ask to Buy, G4).
    func refresh() async {
        var entitled = false
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result, Self.products.contains(transaction.productID), transaction.revocationDate == nil {
                entitled = true
            }
        }
        if product == nil, let found = try? await Product.products(for: [PlusProduct.plus]).first {
            product = found
            price = found.displayPrice
        }
        if override != nil { return }
        let had = UserDefaults.standard.bool(forKey: Self.hadPlusKey)
        if entitled {
            UserDefaults.standard.set(true, forKey: Self.hadPlusKey)
            if access == .none && moment != .bought { moment = .bought }
            access = .plus
        } else {
            if had && access != .none { moment = .ended } // G6: send what's waiting first (WatchLink does), delete nothing
            access = .none
        }
    }

    /// "Get Plus · $24.99" (G1, G2): Apple's own purchase sheet; the person confirms with the side button.
    func buy() async {
        moment = .purchasing
        do {
            if product == nil { product = try await Product.products(for: [PlusProduct.plus]).first; price = product?.displayPrice }
            guard let product else { moment = .unreachable; return }
            switch try await product.purchase() {
            case .success(let verification):
                if case .verified(let transaction) = verification { await transaction.finish() }
                moment = .bought
                await refresh()
            case .pending: moment = .waiting // Ask to Buy: it opens by itself once approved
            case .userCancelled: moment = .offer
            @unknown default: moment = .offer
            }
        } catch {
            moment = .unreachable // nothing was charged (G5)
        }
    }

    /// Restore Purchases, always on the page (App Review 3.1.1).
    func restore() async {
        try? await AppStore.sync()
        await refresh()
    }

    /// G3's Continue.
    func continueAfterPurchase() {
        moment = .offer
        access = .plus
    }
}

extension PlusState.Moment {
    init?(name: String) {
        switch name {
        case "offer": self = .offer
        case "bought": self = .bought
        case "waiting": self = .waiting
        case "unreachable": self = .unreachable
        case "ended": self = .ended
        default: return nil
        }
    }
}
