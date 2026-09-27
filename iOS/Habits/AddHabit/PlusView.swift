import SwiftUI

/// The one calm Plus screen, shown when a free user reaches their 6th habit (decided 29 Sep 2026).
/// Purchase is wired up with billing later.
struct PlusView: View {
    var body: some View {
        VStack(spacing: 20) {
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 56)).foregroundStyle(Color.ink)
                Text("You're using all 5 free habits")
                    .font(.title2.weight(.bold)).multilineTextAlignment(.center)
                Text("Plus is a one-time purchase: unlimited habits, iPad and Apple Watch, sync between devices and automatic backup. Your 5 habits stay free forever.")
                    .font(.body).foregroundStyle(.secondary).multilineTextAlignment(.center)
                Spacer()
                Button {} label: {
                    Text("Get Plus").font(.headline).frame(maxWidth: .infinity, minHeight: 50)
                }
                .buttonStyle(.borderedProminent).tint(.ink)
                .disabled(true)
                Text("Purchases arrive in a later build.").font(.footnote).foregroundStyle(.secondary)
            }
        .padding(24)
        .navigationTitle("Plus")
        .navigationBarTitleDisplayMode(.inline)
    }
}
