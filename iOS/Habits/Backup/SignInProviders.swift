import AuthenticationServices
import CryptoKit
import Foundation
import Security
import UIKit

/// What's switched on. Apple sign-in and the iCloud copy need entitlements only the Apple Developer account can sign:
/// on since 2 Oct 2026, with the paid team `MHTC4C9P8F` (Habits.entitlements).
nonisolated enum BackupFeatures {
    static let googleSignIn = true
    static let appleSignIn = true
    static let iCloudBackup = true
}

/// A provider's proof of who someone is, for `POST /v1/auth/apple|google`. The server gets `nonce` raw; the provider
/// was given its SHA-256, so a token can't be replayed by someone else (server/README.md).
struct ProviderToken {
    let path: String
    let idToken: String
    let nonce: String
    /// Apple only: the credential's one-time code. The server swaps it for a token it revokes at Apple when the
    /// account is deleted (App Review 5.1.1(v); server/src/appleTokens.ts).
    var authorizationCode: String? = nil
}

nonisolated enum SignInNonce {
    static func make() -> String {
        var bytes = [UInt8](repeating: 0, count: 32)
        _ = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
        return Data(bytes).base64URL
    }

    static func sha256Hex(_ text: String) -> String {
        SHA256.hash(data: Data(text.utf8)).map { String(format: "%02x", $0) }.joined()
    }
}

extension Data {
    nonisolated var base64URL: String {
        base64EncodedString().replacingOccurrences(of: "+", with: "-").replacingOccurrences(of: "/", with: "_").replacingOccurrences(of: "=", with: "")
    }
}

/// Google sign-in through the system's web sign-in sheet (`ASWebAuthenticationSession`), with PKCE, as Google's own
/// iOS library does it, without adding the library. The iOS OAuth client needs no secret. The ID token's audience
/// is the iOS client ID, which the server accepts (`GOOGLE_AUDIENCES`).
final class GoogleSignIn: NSObject {
    static let clientID = "367584981284-c8q0v1eqmtbng2nu75k3abjuih4s5b8k.apps.googleusercontent.com"
    /// The client ID reversed: Google sends the person back to the app on this scheme (also in Info.plist).
    static let scheme = "com.googleusercontent.apps.367584981284-c8q0v1eqmtbng2nu75k3abjuih4s5b8k"
    private static var redirect: String { scheme + ":/oauth2redirect" }

    private var session: ASWebAuthenticationSession?

    /// Asks Google who this is. Throws `CancellationError` if the person closes the sheet.
    func signIn() async throws -> ProviderToken {
        let verifier = SignInNonce.make() + SignInNonce.make()
        let challenge = Data(SHA256.hash(data: Data(verifier.utf8))).base64URL
        let nonce = SignInNonce.make()
        let state = SignInNonce.make()
        var components = URLComponents(string: "https://accounts.google.com/o/oauth2/v2/auth")!
        components.queryItems = [
            URLQueryItem(name: "client_id", value: Self.clientID),
            URLQueryItem(name: "redirect_uri", value: Self.redirect),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: "openid email profile"),
            URLQueryItem(name: "code_challenge", value: challenge),
            URLQueryItem(name: "code_challenge_method", value: "S256"),
            URLQueryItem(name: "state", value: state),
            URLQueryItem(name: "nonce", value: SignInNonce.sha256Hex(nonce)),
            URLQueryItem(name: "prompt", value: "select_account"),
        ]
        let callback: URL = try await withCheckedThrowingContinuation { continuation in
            let session = ASWebAuthenticationSession(url: components.url!, callbackURLScheme: Self.scheme) { @Sendable url, error in
                if let url {
                    continuation.resume(returning: url)
                } else if let error = error as? ASWebAuthenticationSessionError, error.code == .canceledLogin {
                    continuation.resume(throwing: CancellationError())
                } else {
                    continuation.resume(throwing: error ?? URLError(.badServerResponse))
                }
            }
            session.presentationContextProvider = self
            self.session = session
            if !session.start() { continuation.resume(throwing: URLError(.cannotLoadFromNetwork)) }
        }
        session = nil
        let items = URLComponents(url: callback, resolvingAgainstBaseURL: false)?.queryItems ?? []
        guard items.first(where: { $0.name == "state" })?.value == state,
              let code = items.first(where: { $0.name == "code" })?.value else {
            throw CancellationError() // Google said no (access denied), or a stray callback
        }

        var request = URLRequest(url: URL(string: "https://oauth2.googleapis.com/token")!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        let form = ["code": code, "client_id": Self.clientID, "redirect_uri": Self.redirect, "grant_type": "authorization_code", "code_verifier": verifier]
        request.httpBody = Data(form.map { "\($0.key)=\($0.value.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? "")" }.joined(separator: "&").utf8)
        let (data, _) = try await URLSession.shared.data(for: request)
        guard let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any], let idToken = json["id_token"] as? String else {
            throw URLError(.badServerResponse)
        }
        return ProviderToken(path: "/v1/auth/google", idToken: idToken, nonce: nonce)
    }
}

extension GoogleSignIn: @preconcurrency ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.first ?? ASPresentationAnchor()
    }
}

/// Sign in with Apple. Written now, switched on (`BackupFeatures.appleSignIn`) when the Apple Developer account can
/// sign the "Sign in with Apple" entitlement.
final class AppleSignIn: NSObject {
    private var continuation: CheckedContinuation<ProviderToken, Error>?
    private var nonce = ""

    func signIn() async throws -> ProviderToken {
        nonce = SignInNonce.make()
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email]
        request.nonce = SignInNonce.sha256Hex(nonce)
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            controller.performRequests()
        }
    }
}

extension AppleSignIn: @preconcurrency ASAuthorizationControllerDelegate, @preconcurrency ASAuthorizationControllerPresentationContextProviding {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let data = credential.identityToken, let token = String(data: data, encoding: .utf8) else {
            continuation?.resume(throwing: URLError(.badServerResponse))
            continuation = nil
            return
        }
        let code = credential.authorizationCode.flatMap { String(data: $0, encoding: .utf8) }
        continuation?.resume(returning: ProviderToken(path: "/v1/auth/apple", idToken: token, nonce: nonce, authorizationCode: code))
        continuation = nil
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let canceled = (error as? ASAuthorizationError)?.code == .canceled
        continuation?.resume(throwing: canceled ? CancellationError() : error)
        continuation = nil
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.first ?? ASPresentationAnchor()
    }
}

/// SHA-256 as hex, the form the core and the server use for backup checksums.
nonisolated enum SHA256Hex {
    static func of(_ data: Data) -> String {
        SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
    }
}
