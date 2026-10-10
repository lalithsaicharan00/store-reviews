import Core
import SwiftUI
import UIKit

/// The questions iCloud sync asks the person, once each, over whatever is on screen (Architecture 11 §10–12). Only
/// this modifier reads them, so Today never redraws for sync. Each asks first and changes nothing until answered:
/// - **Your habits were removed from iCloud** (the person deleted the app's iCloud data, or another device did): Back
///   Up Again · Not Now (§11).
/// - **A different Apple Account** on this iPhone: Add to This Account's iCloud · Keep on This iPhone Only (§10).
/// - **Free plan, another device syncs:** the second-device sheet (§12; the Plus screens' image 16).
/// - **Free plan, the old device:** "Your habits now sync on your iPad", once, after it sent what it had (§12).
struct CloudQuestions: ViewModifier {
    @Bindable var cloud: CloudSync
    let backup: BackupCenter
    /// Asked this launch already (an alert answered with the app still on the question keeps it on the iCloud page).
    @State private var removedSeen = false
    @State private var accountSeen = false

    func body(content: Content) -> some View {
        content
            .alert("Your habits were removed from iCloud", isPresented: Binding(
                get: { cloud.phase == .asking(.removed) && !removedSeen && !cloud.working },
                set: { if !$0 { removedSeen = true } })) {
                Button("Back Up Again") { Task { await cloud.backUpAgain() } }
                Button("Not Now", role: .cancel) { Task { await cloud.notNowAfterRemoval() } }
            } message: {
                Text("This iPhone still has all of them. Back them up to iCloud again?")
            }
            .alert("This iPhone uses a different Apple Account", isPresented: Binding(
                get: { if case .asking(.differentAccount) = cloud.phase { !accountSeen && !cloud.working } else { false } },
                set: { if !$0 { accountSeen = true } })) {
                Button("Add to This Account's iCloud") { Task { await cloud.addToThisAccount() } }
                Button("Keep on This iPhone Only", role: .cancel) { Task { await cloud.keepOnThisIPhoneOnly() } }
            } message: {
                Text(CloudWords.differentAccount(cloud.phase, here: cloud.habitCount()))
            }
            .alert("Your habits now sync on \(BackupCenter.yourDevice(cloud.handedOverTo ?? ""))", isPresented: Binding(
                get: { cloud.handedOverTo != nil }, set: { if !$0 { cloud.handedOverTo = nil } })) {
                Button("OK") { cloud.handedOverTo = nil }
            } message: {
                Text("This \(DeviceIdentity.name) keeps everything it has.")
            }
            .sheet(item: $cloud.secondDevice) { ask in
                SecondDeviceSheet(otherDevice: ask.otherDevice, working: cloud.working) {
                    Task { if await cloud.moveHere() { cloud.secondDevice = nil } }
                } onClose: {
                    cloud.secondDevice = nil
                }
            }
    }
}

/// "Use your habits on this iPad?" (Plus screens, image 16; Architecture 11 §12): the free plan syncs one device at a
/// time through iCloud. Plus first, as a calm card with an outlined See Plus; the free move last, with the only filled
/// button (the user's decision: order matters). ✕ changes nothing on either device.
struct SecondDeviceSheet: View {
    let otherDevice: String
    var working = false
    let onMove: () -> Void
    let onClose: () -> Void
    @State private var showPlus = false

    private var here: String { DeviceIdentity.name }
    private var other: String { BackupCenter.yourDevice(otherDevice) }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    DevicePair(other: otherDevice, here: here)
                    VStack(spacing: 6) {
                        Text("Use your habits on this \(here)?")
                            .font(.title2.bold())
                            .multilineTextAlignment(.center)
                            .accessibilityAddTraits(.isHeader)
                            .accessibilityIdentifier("second-device-title")
                        Text("The free plan syncs one device at a time through iCloud.")
                            .font(.subheadline).foregroundStyle(.secondary).multilineTextAlignment(.center)
                    }
                    .padding(.bottom, 4)
                    card {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 6) {
                                Text("Keep both in sync").font(.headline)
                                Text("Plus").font(.caption.weight(.semibold)).padding(.horizontal, 6).padding(.vertical, 2)
                                    .background(Color(.tertiarySystemFill), in: Capsule())
                            }
                            Text("With Plus, \(other), this \(here) and any other device stay in sync. A one-time purchase.")
                                .font(.subheadline).foregroundStyle(.secondary)
                        }
                        Button { showPlus = true } label: {
                            Text("See Plus").font(.headline).frame(maxWidth: .infinity, minHeight: 34)
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                        .controlSize(.large)
                        .tint(.primary)
                        .accessibilityIdentifier("second-device-see-plus")
                    }
                    card {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Move to this \(here)").font(.headline)
                            Text("Your habits come here from iCloud. \(HabitCopy.capitalized(other)) stops syncing and keeps everything it has.")
                                .font(.subheadline).foregroundStyle(.secondary)
                                .accessibilityIdentifier("second-device-text")
                        }
                        Button(action: onMove) {
                            Group {
                                if working { ProgressView().tint(Color.onInk) } else { Text("Use on This \(here)").font(.headline) }
                            }
                            .foregroundStyle(Color.onInk)
                            .frame(maxWidth: .infinity, minHeight: 34)
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        .controlSize(.large)
                        .tint(.ink)
                        .disabled(working)
                        .accessibilityIdentifier("second-device-move")
                    }
                    Text("✕ keeps this \(here) on its own. Nothing changes on \(other).")
                        .font(.footnote).foregroundStyle(.secondary).multilineTextAlignment(.center)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .background(Color(.systemGroupedBackground))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: onClose) { Image(systemName: "xmark") }
                        .accessibilityLabel("Close")
                        .accessibilityIdentifier("second-device-close")
                        .disabled(working)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showPlus) { MenuPage(place: .plus) }
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
        .interactiveDismissDisabled(working)
    }

    private func card(@ViewBuilder _ content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 12) { content() }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

/// The other device and this one, drawn plainly: the other's outline, an arrow, this one's outline (image 16).
private struct DevicePair: View {
    let other: String
    let here: String

    var body: some View {
        HStack(alignment: .bottom, spacing: 14) {
            device(symbol(for: other), name: other.isEmpty ? "Other device" : other, current: false)
            Image(systemName: "arrow.right").font(.title3).foregroundStyle(.secondary).padding(.bottom, 30)
            device(symbol(for: here), name: "This \(here)", current: true)
        }
        .padding(.top, 8)
        .accessibilityHidden(true)
    }

    private func device(_ symbol: String, name: String, current: Bool) -> some View {
        VStack(spacing: 6) {
            Image(systemName: symbol)
                .font(.system(size: current ? 56 : 40, weight: .ultraLight))
                .foregroundStyle(current ? Color.ink : Color.secondary)
                .frame(height: 64, alignment: .bottom)
            Text(name)
                .font(.caption.weight(current ? .semibold : .regular))
                .foregroundStyle(current ? Color.primary : Color.secondary)
                .lineLimit(1)
        }
    }

    private func symbol(for name: String) -> String {
        name.localizedCaseInsensitiveContains("iPad") ? "ipad" : name.localizedCaseInsensitiveContains("Mac") ? "macbook" : "iphone"
    }
}

/// What iCloud sync says, in people's words (§17; U3, U11): status first, never blame, the habits' safety always said.
enum CloudWords {
    /// "This iPhone now uses a different Apple Account. Its iCloud has 14 habits. This iPhone has 9." (§10)
    static func differentAccount(_ phase: CloudSync.Phase, here: Int) -> String {
        let there: String
        if case .asking(.differentAccount(let count?)) = phase {
            there = count == 0 ? "Its iCloud has no habits yet." : "Its iCloud has \(count) \(count == 1 ? "habit" : "habits")."
        } else {
            there = "Its iCloud may already have habits."
        }
        let mine = "This \(DeviceIdentity.name) has \(here) \(here == 1 ? "habit" : "habits")"
        return "\(there) \(mine). Adding them merges both; nothing is replaced."
    }
}
