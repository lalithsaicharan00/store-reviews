import SwiftUI
import UIKit

/// Backup & Export → Move to Another Device (Account and Backup Redesign, screen 5; Current Work 73.1 and 76): the old
/// device's half of Move from another device, opened straight from the row, like a messaging app's transfer (the user,
/// 10 Oct 2026: no options screen first). Three steps, the code, and that it's waiting. It makes a fresh backup of
/// everything, seals it with the code and hands it to our server for the device that types the code (`TransferSender`;
/// through the server since 10 Oct 2026, so the devices can be anywhere), with whether this device is signed in so the
/// other one can ask to sign in too. The screen stays awake while it waits; leaving it ends the code and deletes the
/// file from the server. This device keeps everything: it's a copy, not a move.
struct TransferSendView: View {
    @Environment(BackupCenter.self) private var backup
    @State private var sender = TransferSender()

    var body: some View {
        Form {
            Section {
                step(1, "Install \(Onboarding.appName) on the other device")
                step(2, "Choose I've used it before, then Move from another device")
                step(3, "Enter this code")
            }
            Section {
                VStack(spacing: 12) {
                    Text(TransferCode.display(sender.code))
                        .font(.system(size: 40, weight: .bold, design: .monospaced))
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                        .textSelection(.enabled)
                        .accessibilityLabel("Transfer code: " + sender.code.map(String.init).joined(separator: " "))
                        .accessibilityIdentifier("transfer-code")
                    status
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
            } footer: {
                Text("Keep this screen open until your habits arrive on the other device. They stay on this device too.")
            }
            if case .failed = sender.state {
                Section { Button("Try Again") { restart() }.accessibilityIdentifier("transfer-try-again") }
            } else if sender.state == .expired {
                Section { Button("Show a New Code") { restart() }.accessibilityIdentifier("transfer-try-again") }
            }
        }
        .navigationTitle("Move to Another Device")
        .navigationBarTitleDisplayMode(.inline)
        .task(id: ObjectIdentifier(sender)) { await prepare() }
        .onAppear { UIApplication.shared.isIdleTimerDisabled = true }
        .onDisappear {
            sender.stop()
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }

    private func step(_ number: Int, _ text: String) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            Text("\(number)").font(.subheadline.weight(.semibold)).monospacedDigit()
                .frame(width: 26, height: 26)
                .background(Circle().fill(Color(.tertiarySystemFill)))
                .alignmentGuide(.firstTextBaseline) { $0[.firstTextBaseline] }
            Text(text).fixedSize(horizontal: false, vertical: true)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("transfer-step-\(number)")
    }

    @ViewBuilder private var status: some View {
        switch sender.state {
        case .preparing:
            Label("Getting your data ready…", systemImage: "hourglass").foregroundStyle(.secondary)
        case .waiting:
            HStack(spacing: 8) {
                ProgressView()
                Text("Waiting for the other device…")
            }
            .foregroundStyle(.secondary)
        case .sent:
            Label("Done. Your habits are on the other device.", systemImage: "checkmark.circle.fill")
                .accessibilityIdentifier("transfer-sent")
        case .expired:
            Text("This code has expired. Show a new code to try again.")
                .multilineTextAlignment(.center)
                .accessibilityIdentifier("transfer-expired")
        case .failed(let text):
            Text(text).multilineTextAlignment(.center)
        }
    }

    private func prepare() async {
        do {
            let file = try await backup.transferFile()
            guard !Task.isCancelled else { return }
            await sender.start(file: file, account: backup.isSignedIn ? (backup.isPlus ? .plus : .free) : .none, api: backup.api)
        } catch {
            sender.fail("Couldn't get your data ready. Your habits are safe on this device. Please try again.")
        }
    }

    /// A new code each time: a code is used once.
    private func restart() {
        sender.stop()
        sender = TransferSender()
    }
}
