import Foundation

/// The App Store's product IDs (`iOS/OftenEnough.storekit`; created in App Store Connect before a real purchase).
nonisolated enum PlusProduct {
    static let plus = "com.oftenenough.app.plus"
    /// Plus alone since 21 Oct 2026: no Plus Family (Rulebook D16).
    static let all = [plus]
}
