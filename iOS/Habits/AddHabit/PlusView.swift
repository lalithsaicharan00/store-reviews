import SwiftUI

/// The one calm Plus screen, shown when a free user reaches their 6th habit (decided 29 Sep 2026).
/// Purchase is wired up with billing later.
struct PlusView: View {
    /// Opened from ≡ → Plus, not at the free limit: the heading says where the person stands instead.
    var fromMenu = false
    @Environment(HabitStore.self) private var store
    @State private var analyticsFlow = Analytics.shared.ticket

    private var heading: String {
        guard fromMenu else { return "You're using all 5 free habits" }
        return store.isPlus ? "You have Plus"
            : "\(store.activeHabitCount) of \(HabitStore.freeHabitLimit) free habits used"
    }

    var body: some View {
        VStack(spacing: 20) {
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 56)).foregroundStyle(Color.ink)
                Text(heading)
                    .font(.title2.weight(.bold)).multilineTextAlignment(.center)
                Text("Plus is a one-time purchase: unlimited habits, iPad and Apple Watch, and sync between devices. Your 5 habits stay free forever.")
                    .font(.body).foregroundStyle(.secondary).multilineTextAlignment(.center)
                Spacer()
                if !(fromMenu && store.isPlus) {
                    Button {} label: {
                        Text("Get Plus").font(.headline).frame(maxWidth: .infinity, minHeight: 50)
                    }
                    .buttonStyle(.borderedProminent).tint(.ink)
                    .disabled(true)
                    Text("Purchases arrive in a later build.").font(.footnote).foregroundStyle(.secondary)
                }
            }
        .padding(24)
        .analyticsScreen(.plus)
        .onAppear {
            Analytics.shared.event(.paywall, ["entry_point": .text(fromMenu ? "menu" : "habit_limit")], ticket: analyticsFlow)
        }
        .navigationTitle("Plus")
        .navigationBarTitleDisplayMode(.inline)
    }
}
