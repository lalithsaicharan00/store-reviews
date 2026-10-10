import AuthenticationServices
import SwiftUI
import UIKit

/// Sign In and Create Account (Account and Backup Redesign, screens 2b and 2c; Current Work 76): a bottom sheet that
/// fits its content, ✕ to close, one line, Apple's own button and Google's, and a footer. Both do the same thing
/// underneath with Apple and Google; the two titles exist because people come with two intentions and look for their
/// own word ("there is no login option", report §4a). A sheet, not an alert: the person chose to start this.
///
/// - **Sign In** never makes an account by itself: an unknown sign-in asks first (Rulebook D3).
/// - **Create Account** with a sign-in that already has an account signs into it (the server's `create: true` does).
/// - **A free account signed in on another device** (Current Work 78): the sheet becomes "Use on This iPad?" (screen 7);
///   Continue signs in with `replace`, Cancel leaves everything as it was.
struct SignInSheet: View {
    enum Purpose { case signIn, create }

    @Environment(BackupCenter.self) private var backup
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @State private var working = false
    @State private var unknown: ProviderToken?
    /// Signed in on another device: the token and whether it was Create Account, until Continue or Cancel.
    @State private var other: (token: ProviderToken, create: Bool, device: String)?
    @State private var failure: String?
    @State private var google = GoogleSignIn()
    @State private var apple = AppleSignIn()
    var onSignedIn: () -> Void = {}
    /// "Sign In" or "Create Account".
    var title = "Create Account"

    private var purpose: Purpose { title == "Sign In" ? .signIn : .create }

    var body: some View {
        if let other {
            UseHereQuestion(otherDevice: other.device, working: working) {
                finish(other.token, create: other.create, replace: true)
            } onCancel: {
                self.other = nil
                dismiss()
            }
            .presentationDetents([.height(300)])
            .presentationDragIndicator(.visible)
        } else {
            providers
        }
    }

    private var providers: some View {
        NavigationStack {
            VStack(spacing: 14) {
                Text(purpose == .signIn ? "Use the same way you signed in before."
                                        : "A free account syncs your habits on one device and brings them back when you sign in on a new device.")
                    .font(.subheadline).foregroundStyle(.secondary).multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                if BackupFeatures.appleSignIn {
                    // Apple's own button and title (Sign in with Apple HIG), never a drawn copy.
                    SignInWithAppleButton(.continue) { request in
                        apple.prepare(request)
                    } onCompletion: { result in
                        start { try apple.finish(result) }
                    }
                    .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                    .frame(height: 50)
                    .clipShape(Capsule())
                    .accessibilityIdentifier("sign-in-apple")
                }
                if BackupFeatures.googleSignIn {
                    GoogleButton { start { try await google.signIn() } }
                        .frame(height: 50)
                        .accessibilityIdentifier("sign-in-google")
                }
                Text(purpose == .signIn ? "No account found? You'll be asked before a new one is made."
                                        : "Already have an account? You'll be signed in to it. Never sold, never for ads.")
                    .font(.footnote).foregroundStyle(.secondary).multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                if let failure {
                    Text(failure).font(.footnote).foregroundStyle(.red).multilineTextAlignment(.center)
                        .accessibilityIdentifier("sign-in-failure")
                }
            }
            .disabled(working)
            .padding(.horizontal, 16)
            .padding(.top, 4)
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button { dismiss() } label: { Image(systemName: "xmark") }
                        .accessibilityLabel("Cancel")
                        .accessibilityIdentifier("sign-in-cancel")
                }
                if working { ToolbarItem(placement: .topBarTrailing) { ProgressView() } }
            }
            .confirmationDialog("No account found", isPresented: Binding(get: { unknown != nil }, set: { if !$0 { unknown = nil } }), titleVisibility: .visible) {
                Button("Create an Account") {
                    guard let token = unknown else { return }
                    unknown = nil
                    finish(token, create: true)
                }
                Button("Cancel", role: .cancel) { unknown = nil }
            } message: {
                Text("There's no account for this sign-in yet. If you've used the app before with a different sign-in, use that one instead.")
            }
        }
        .presentationDetents([.height(330), .large])
        .presentationDragIndicator(.visible)
    }

    private func start(_ provider: @escaping @MainActor () async throws -> ProviderToken) {
        working = true
        failure = nil
        Task {
            do {
                let token = try await provider()
                finish(token, create: purpose == .create)
            } catch is CancellationError {
                working = false
            } catch {
                working = false
                failure = "Couldn't sign in. Check your connection and try again."
            }
        }
    }

    private func finish(_ token: ProviderToken, create: Bool, replace: Bool = false) {
        working = true
        Task {
            defer { working = false }
            do {
                try await backup.signIn(with: token, create: create, replace: replace)
                onSignedIn()
                dismiss()
            } catch let error as ServerError where error.code == "unknown_key" {
                unknown = token
            } catch let error as ServerError where error.code == "other_device_signed_in" {
                other = (token, create, error.deviceName ?? "")
            } catch {
                other = nil
                failure = "Couldn't sign in. Check your connection and try again."
            }
        }
    }
}

/// "Use on This iPad?" (Account and Backup Redesign, screen 7; Current Work 78): signing in to a free account that's
/// signed in on another device. Continue moves the account here and signs the other device out (it keeps its habits);
/// Cancel changes nothing on either. Never words like "active device" or "session" (Free Sync §5).
struct UseHereQuestion: View {
    let otherDevice: String
    var working = false
    let onContinue: () -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("Use on This \(UIDevice.current.model)?")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
                .accessibilityIdentifier("use-here-title")
            Text("Free syncs one device, so \(BackupCenter.yourDevice(otherDevice)) will be signed out. It keeps its habits.")
                .font(.subheadline).foregroundStyle(.secondary).multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .accessibilityIdentifier("use-here-text")
            VStack(spacing: 10) {
                Button(action: onContinue) {
                    Group {
                        if working { ProgressView().tint(Color.onInk) } else { Text("Continue").font(.headline) }
                    }
                    .foregroundStyle(Color.onInk)
                    .frame(maxWidth: .infinity, minHeight: 32)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .tint(.ink)
                .accessibilityIdentifier("use-here-continue")
                Button(action: onCancel) {
                    Text("Cancel").font(.headline).foregroundStyle(Color.primary).frame(maxWidth: .infinity, minHeight: 32)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .tint(.secondary)
                .accessibilityIdentifier("use-here-cancel")
            }
            .disabled(working)
        }
        .padding(.horizontal, 16)
        .padding(.top, 28)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

/// "Continue with Google", as Google's branding guidelines draw it (light theme, standard): a white button with a grey
/// outline, Google's four-colour "G" at its left, the words in the system's medium weight, as tall and as prominent as
/// Apple's. The app signs in with Google through the system's web sheet (`GoogleSignIn`), without Google's SDK, so its
/// button view isn't available; this follows the same rules.
struct GoogleButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                GoogleMark().frame(width: 18, height: 18)
                Text("Continue with Google").font(.system(size: 19, weight: .medium)).foregroundStyle(Color(red: 0.12, green: 0.12, blue: 0.12))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Capsule().fill(Color.white))
            .overlay(Capsule().strokeBorder(Color(red: 0.45, green: 0.47, blue: 0.46), lineWidth: 1))
            .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Continue with Google")
    }
}

/// Google's "G" (the sign-in button's mark, 48 × 48 units), in its four colours.
struct GoogleMark: View {
    private static let parts: [(String, Color)] = [
        ("M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z",
         Color(red: 0xEA / 255, green: 0x43 / 255, blue: 0x35 / 255)),
        ("M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z",
         Color(red: 0x42 / 255, green: 0x85 / 255, blue: 0xF4 / 255)),
        ("M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z",
         Color(red: 0xFB / 255, green: 0xBC / 255, blue: 0x05 / 255)),
        ("M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z",
         Color(red: 0x34 / 255, green: 0xA8 / 255, blue: 0x53 / 255)),
    ]

    var body: some View {
        Canvas { context, size in
            let scale = min(size.width, size.height) / 48
            for (path, color) in Self.parts {
                context.fill(SVGPath.parse(path).applying(CGAffineTransform(scaleX: scale, y: scale)), with: .color(color))
            }
        }
        .accessibilityHidden(true)
    }
}

/// Just enough of SVG's path syntax for `GoogleMark`: M, L, H, V, C, S and Z, absolute and relative.
nonisolated enum SVGPath {
    static func parse(_ text: String) -> Path {
        var path = Path()
        var tokens: [String] = []
        var number = ""
        func flush() { if !number.isEmpty { tokens.append(number); number = "" } }
        for ch in text {
            if ch.isLetter {
                flush(); tokens.append(String(ch))
            } else if ch == "-" {
                if !number.isEmpty && !number.hasSuffix("e") { flush() }
                number.append(ch)
            } else if ch == "." {
                if number.contains(".") { flush() }
                number.append(ch)
            } else if ch.isNumber {
                number.append(ch)
            } else {
                flush()
            }
        }
        flush()
        var i = 0
        var command: Character = "M"
        var current = CGPoint.zero
        var start = CGPoint.zero
        var lastControl: CGPoint?
        func next() -> CGFloat { defer { i += 1 }; return CGFloat(Double(tokens[i]) ?? 0) }
        while i < tokens.count {
            if let c = tokens[i].first, c.isLetter { command = c; i += 1; if c == "z" || c == "Z" { path.closeSubpath(); current = start; lastControl = nil; continue } }
            guard i < tokens.count else { break }
            let relative = command.isLowercase
            func point(_ x: CGFloat, _ y: CGFloat) -> CGPoint { relative ? CGPoint(x: current.x + x, y: current.y + y) : CGPoint(x: x, y: y) }
            switch command.uppercased() {
            case "M":
                current = point(next(), next()); start = current; path.move(to: current)
                command = relative ? "l" : "L"; lastControl = nil
            case "L":
                current = point(next(), next()); path.addLine(to: current); lastControl = nil
            case "H":
                let x = next(); current = CGPoint(x: relative ? current.x + x : x, y: current.y); path.addLine(to: current); lastControl = nil
            case "V":
                let y = next(); current = CGPoint(x: current.x, y: relative ? current.y + y : y); path.addLine(to: current); lastControl = nil
            case "C":
                let c1 = point(next(), next()), c2 = point(next(), next()), end = point(next(), next())
                path.addCurve(to: end, control1: c1, control2: c2); current = end; lastControl = c2
            case "S":
                let c1 = lastControl.map { CGPoint(x: 2 * current.x - $0.x, y: 2 * current.y - $0.y) } ?? current
                let c2 = point(next(), next()), end = point(next(), next())
                path.addCurve(to: end, control1: c1, control2: c2); current = end; lastControl = c2
            default:
                i += 1
            }
        }
        return path
    }
}
