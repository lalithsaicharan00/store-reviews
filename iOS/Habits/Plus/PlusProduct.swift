import Foundation

/// The App Store's product IDs (`iOS/OftenEnough.storekit`; created in App Store Connect before a real purchase).
/// Its own file so the Apple Watch app compiles the same list (Rulebook U31): one purchase, read the same on both.
nonisolated enum PlusProduct {
    static let plus = "com.oftenenough.app.plus"
    static let family = "com.oftenenough.app.plusfamily"
    /// Plus → Plus Family, the difference; offered only to Plus owners.
    static let upgrade = "com.oftenenough.app.plusfamily.upgrade"
    static let all = [plus, family, upgrade]
}
