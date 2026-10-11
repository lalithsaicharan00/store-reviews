import CryptoKit
import Foundation
import Security

/// What's switched on. The iCloud copy needs entitlements only the Apple Developer account can sign: on since 2 Oct
/// 2026, with the paid team `MHTC4C9P8F` (Habits.entitlements). Sign-in and accounts went with the server
/// (Architecture 11 §17); iCloud sync needs neither.
nonisolated enum BackupFeatures {
    static let iCloudBackup = true
    /// Google Drive as the backup place for someone who keeps iCloud off (`GoogleDrive`): off until the Drive API is
    /// enabled and `drive.appdata` is on the OAuth consent screen in Google's console (Current Work 76, asked 10 Oct
    /// 2026). No Google Drive row shows while it's off. Kept exactly as it was (the user, 10 Oct 2026).
    static let googleDrive = false
}

/// Google's iOS OAuth client, for Google Drive backups (`GoogleDrive`). The iOS client needs no secret.
nonisolated enum GoogleSignIn {
    static let clientID = "367584981284-c8q0v1eqmtbng2nu75k3abjuih4s5b8k.apps.googleusercontent.com"
    /// The client ID reversed: Google sends the person back to the app on this scheme (also in Info.plist).
    static let scheme = "com.googleusercontent.apps.367584981284-c8q0v1eqmtbng2nu75k3abjuih4s5b8k"
}

/// Random values for OAuth (PKCE verifier, state).
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

/// SHA-256 as hex, the form the core uses for backup checksums.
nonisolated enum SHA256Hex {
    static func of(_ data: Data) -> String {
        SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
    }
}
