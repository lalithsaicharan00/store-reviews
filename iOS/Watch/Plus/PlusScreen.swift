import SwiftUI

/// The Watch without Plus (G1–G6): state first, then the offer (W6). Reminders still reach the wrist for free (watchOS
/// mirrors the iPhone's notifications without this app).
struct PlusScreen: View {
    @Environment(PlusState.self) private var plus
    @State private var handingOff = false

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                switch plus.moment {
                case .offer, .purchasing: offer
                case .bought: bought
                case .waiting: waiting
                case .unreachable: unreachable
                case .ended: ended
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 2)
        }
        .userActivity(WatchHandoff.openPlus) { $0.isEligibleForHandoff = true }
        .accessibilityIdentifier("plus-screen")
    }

    private var mark: some View {
        Image(systemName: "checkmark")
            .font(.system(size: 20, weight: .bold))
            .foregroundStyle(.black)
            .frame(width: 40, height: 40)
            .background(Circle().fill(.white))
            .accessibilityHidden(true)
    }

    private func heading(_ text: String) -> some View {
        Text(text).font(.title3.weight(.bold)).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
    }

    private func detail(_ text: String) -> some View {
        Text(text).font(.footnote).foregroundStyle(.secondary).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
    }

    private var getPlus: some View {
        Button {
            Task { await plus.buy() }
        } label: {
            Text(plus.price.map { "Get Plus · \($0)" } ?? "Get Plus").foregroundStyle(.black).lineLimit(1).minimumScaleFactor(0.7)
        }
        .buttonStyle(.borderedProminent).tint(.white)
        .disabled(plus.moment == .purchasing)
        .accessibilityIdentifier("get-plus")
    }

    /// Opens Plus on the iPhone by Handoff: this page is offered to the iPhone all the time it's open (the app's icon in
    /// the iPhone's app switcher opens ≡ › Plus there). watchOS can't push an app to the iPhone's screen, so the button
    /// says where to look.
    @ViewBuilder private var continueOnIPhone: some View {
        Button("Continue on iPhone") { withAnimation { handingOff = true } }
            .accessibilityIdentifier("continue-on-iphone")
        if handingOff {
            detail("On your iPhone, open the app switcher and tap Often Enough at the bottom.")
                .accessibilityIdentifier("handoff-hint")
        }
    }

    // G1
    @ViewBuilder private var offer: some View {
        mark
        heading("Apple Watch is part of Plus")
        detail("Log from your wrist, run routines and see today on your watch face.")
        getPlus.padding(.top, 4)
        continueOnIPhone
        detail("One-time, no subscription. Plus Family is on your iPhone.").padding(.top, 6)
        Button("Restore Purchases") { Task { await plus.restore() } }
            .buttonStyle(.plain)
            .font(.footnote.weight(.semibold))
            .padding(.top, 4)
            .accessibilityIdentifier("restore")
    }

    // G3
    @ViewBuilder private var bought: some View {
        mark
        heading("Plus is yours")
        detail("Thank you. On your iPhone and iPad too.")
        Button("Continue") { plus.continueAfterPurchase() }
            .buttonStyle(.borderedProminent).tint(.white).foregroundStyle(.black)
            .padding(.top, 4)
            .accessibilityIdentifier("plus-continue")
    }

    // G4
    @ViewBuilder private var waiting: some View {
        ProgressView().frame(height: 36)
        heading("Waiting for approval")
        detail("Someone in your Apple family needs to approve Plus. It opens here by itself.")
        Button("OK") { plus.moment = .offer }.padding(.top, 4)
    }

    // G5
    @ViewBuilder private var unreachable: some View {
        heading("Couldn't reach the App Store")
        detail("Nothing was charged. Try again, or buy on your iPhone.")
        Button("Try Again") { Task { await plus.buy() } }
            .buttonStyle(.borderedProminent).tint(.white).foregroundStyle(.black)
            .padding(.top, 4)
            .accessibilityIdentifier("try-again")
        continueOnIPhone
    }

    // G6
    @ViewBuilder private var ended: some View {
        mark
        heading("Plus has ended on this Apple Account")
        detail("Nothing was deleted: everything you logged here is on your iPhone.")
        getPlus.padding(.top, 4)
        continueOnIPhone
    }
}
