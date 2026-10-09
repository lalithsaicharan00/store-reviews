import SwiftUI
import UIKit

/// Backup & Export → Move to a New iPhone → Show a Transfer Code (Current Work 73.1): the old iPhone's half of Move from
/// another device. It makes a fresh backup of everything, shows a code, and sends the backup to the new iPhone that
/// types it (`TransferSender`). The screen stays awake while it waits; leaving it ends the code. This iPhone keeps
/// everything: it's a copy, not a move.
struct TransferSendView: View {
    @Environment(BackupCenter.self) private var backup
    @State private var sender = TransferSender()

    var body: some View {
        Form {
            Section {
                VStack(spacing: 14) {
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
                Text("On your new iPhone, open \(Onboarding.appName), choose I've used it before, then Move from another device, and type this code. Keep this screen open and both iPhones close.")
            }
            if case .failed = sender.state {
                Section { Button("Try Again") { restart() }.accessibilityIdentifier("transfer-try-again") }
            } else if sender.state == .needsPermission {
                Section {
                    Button("Open Settings") {
                        if let url = URL(string: UIApplication.openSettingsURLString) { UIApplication.shared.open(url) }
                    }
                    Button("Try Again") { restart() }
                }
            }
        }
        .navigationTitle("Transfer Code")
        .navigationBarTitleDisplayMode(.inline)
        .task(id: ObjectIdentifier(sender)) { await prepare() }
        .onAppear { UIApplication.shared.isIdleTimerDisabled = true }
        .onDisappear {
            sender.stop()
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }

    @ViewBuilder private var status: some View {
        switch sender.state {
        case .preparing:
            Label("Getting your data ready…", systemImage: "hourglass").foregroundStyle(.secondary)
        case .waiting:
            HStack(spacing: 8) {
                ProgressView()
                Text("Waiting for your new iPhone…")
            }
            .foregroundStyle(.secondary)
        case .sending(let done):
            VStack(spacing: 8) {
                ProgressView(value: done)
                Text("Sending… \(Int((done * 100).rounded()))%").monospacedDigit()
            }
        case .sent:
            Label("Sent. Your habits are on your new iPhone.", systemImage: "checkmark.circle.fill")
                .accessibilityIdentifier("transfer-sent")
        case .needsPermission:
            Text("\(Onboarding.appName) needs Local Network to reach your new iPhone. Turn it on in Settings, then try again.")
                .multilineTextAlignment(.center)
        case .failed(let text):
            Text(text).multilineTextAlignment(.center)
        }
    }

    private func prepare() async {
        do {
            let file = try await backup.transferFile()
            guard !Task.isCancelled else { return }
            await sender.start(file: file)
        } catch {
            sender.fail("Couldn't get your data ready. Your habits are safe on this iPhone. Please try again.")
        }
    }

    /// A new code each time: a code is used once.
    private func restart() {
        sender.stop()
        sender = TransferSender()
    }
}
