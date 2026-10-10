import AuthenticationServices
import CryptoKit
import Foundation
import Security
import SwiftUI
import UIKit

/// Google Drive as the backup place without an account (Account and Backup Redesign §7 item 2; Current Work 76): the
/// person's own Drive, in the app's hidden folder (`appDataFolder`, scope `drive.appdata`: the app sees only its own
/// files, never the person's), the same 7 weekday copies per device as iCloud (`BackupFolder`'s names), read back and
/// checked by SHA-256 before they count (D4).
///
/// **Switched off** (`BackupFeatures.googleDrive`) until it truly works: it needs the Drive API enabled in the Google
/// Cloud project and `drive.appdata` added to the OAuth consent screen, which only the account owner can do in Google's
/// console (asked for 10 Oct 2026). Until then no Google Drive row shows anywhere (Backup & Export research §6: never a
/// row that does nothing).
@MainActor
final class GoogleDrive: NSObject {
    static let shared = GoogleDrive()
    static let scope = "https://www.googleapis.com/auth/drive.appdata"
    private static let api = URL(string: "https://www.googleapis.com/drive/v3")!
    private static let upload = URL(string: "https://www.googleapis.com/upload/drive/v3")!

    /// Drive's times ("2026-10-10T09:14:00.000Z"), made once (Rulebook S8).
    private static let dates: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

    private var session: ASWebAuthenticationSession?
    private var accessToken: (token: String, expires: Date)?

    /// Whether this iPhone has Google's permission for Drive (a refresh token in the Keychain).
    var isConnected: Bool { GoogleDriveKeychain.refreshToken != nil }

    /// Asks Google for Drive access only (`drive.appdata`): it never makes an app account. Throws `CancellationError`
    /// if the person closes the sheet.
    func connect() async throws {
        let verifier = SignInNonce.make() + SignInNonce.make()
        let challenge = Data(SHA256.hash(data: Data(verifier.utf8))).base64URL
        let state = SignInNonce.make()
        let redirect = GoogleSignIn.scheme + ":/oauth2redirect"
        var components = URLComponents(string: "https://accounts.google.com/o/oauth2/v2/auth")!
        components.queryItems = [
            URLQueryItem(name: "client_id", value: GoogleSignIn.clientID),
            URLQueryItem(name: "redirect_uri", value: redirect),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: Self.scope),
            URLQueryItem(name: "code_challenge", value: challenge),
            URLQueryItem(name: "code_challenge_method", value: "S256"),
            URLQueryItem(name: "state", value: state),
            URLQueryItem(name: "access_type", value: "offline"),
            URLQueryItem(name: "prompt", value: "consent"),
        ]
        let callback: URL = try await withCheckedThrowingContinuation { continuation in
            let session = ASWebAuthenticationSession(url: components.url!, callbackURLScheme: GoogleSignIn.scheme) { @Sendable url, error in
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
        guard items.first(where: { $0.name == "state" })?.value == state, let code = items.first(where: { $0.name == "code" })?.value else {
            throw CancellationError()
        }
        let json = try await token(["code": code, "client_id": GoogleSignIn.clientID, "redirect_uri": redirect,
                                    "grant_type": "authorization_code", "code_verifier": verifier])
        guard let refresh = json["refresh_token"] as? String else { throw URLError(.userAuthenticationRequired) }
        GoogleDriveKeychain.refreshToken = refresh
        remember(json)
    }

    /// Forgets Drive on this iPhone (the copies there stay the person's).
    func disconnect() {
        GoogleDriveKeychain.refreshToken = nil
        accessToken = nil
    }

    private func token(_ form: [String: String]) async throws -> [String: Any] {
        var request = URLRequest(url: URL(string: "https://oauth2.googleapis.com/token")!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        request.httpBody = Data(form.map { "\($0.key)=\($0.value.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? "")" }.joined(separator: "&").utf8)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200, let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] else {
            throw URLError(.userAuthenticationRequired)
        }
        return json
    }

    private func remember(_ json: [String: Any]) {
        guard let access = json["access_token"] as? String else { return }
        accessToken = (access, Date.now.addingTimeInterval((json["expires_in"] as? Double ?? 3600) - 60))
    }

    private func bearer() async throws -> String {
        if let accessToken, accessToken.expires > .now { return accessToken.token }
        guard let refresh = GoogleDriveKeychain.refreshToken else { throw URLError(.userAuthenticationRequired) }
        remember(try await token(["refresh_token": refresh, "client_id": GoogleSignIn.clientID, "grant_type": "refresh_token"]))
        guard let accessToken else { throw URLError(.userAuthenticationRequired) }
        return accessToken.token
    }

    private func send(_ request: URLRequest) async throws -> Data {
        var request = request
        request.setValue("Bearer \(try await bearer())", forHTTPHeaderField: "authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        let status = (response as? HTTPURLResponse)?.statusCode ?? 0
        guard (200..<300).contains(status) else { throw GoogleDriveError(status: status) }
        return data
    }

    /// A file in the app's Drive folder.
    struct File: Identifiable, Hashable, Sendable {
        let id: String
        let name: String
        let modified: Date
        let sha256: String
        let properties: [String: String]
    }

    /// Every file in the app's Drive folder.
    func list() async throws -> [File] {
        var components = URLComponents(url: Self.api.appending(path: "files"), resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "spaces", value: "appDataFolder"),
                                 URLQueryItem(name: "fields", value: "files(id,name,modifiedTime,sha256Checksum,appProperties)"),
                                 URLQueryItem(name: "pageSize", value: "200")]
        let data = try await send(URLRequest(url: components.url!))
        let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
        let formatter = Self.dates
        return ((json?["files"] as? [[String: Any]]) ?? []).compactMap { f in
            guard let id = f["id"] as? String, let name = f["name"] as? String else { return nil }
            return File(id: id, name: name, modified: (f["modifiedTime"] as? String).flatMap(formatter.date(from:)) ?? .distantPast,
                        sha256: f["sha256Checksum"] as? String ?? "", properties: f["appProperties"] as? [String: String] ?? [:])
        }
    }

    /// Writes `data` as `name` (replacing the file of that name), with `properties` beside it; true once Drive's own
    /// SHA-256 of what it stored matches (read back and checked, D4).
    func put(_ data: Data, name: String, sha256: String, properties: [String: String]) async throws -> Bool {
        let existing = try await list().first { $0.name == name }
        let boundary = "oftenenough-\(UUID().uuidString)"
        var metadata: [String: Any] = ["name": name, "appProperties": properties]
        if existing == nil { metadata["parents"] = ["appDataFolder"] }
        var body = Data("--\(boundary)\r\ncontent-type: application/json; charset=UTF-8\r\n\r\n".utf8)
        body += try JSONSerialization.data(withJSONObject: metadata)
        body += Data("\r\n--\(boundary)\r\ncontent-type: application/zip\r\n\r\n".utf8) + data + Data("\r\n--\(boundary)--\r\n".utf8)
        let path = existing.map { "files/\($0.id)" } ?? "files"
        var components = URLComponents(url: Self.upload.appending(path: path), resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "uploadType", value: "multipart"), URLQueryItem(name: "fields", value: "id,sha256Checksum")]
        var request = URLRequest(url: components.url!, timeoutInterval: 60)
        request.httpMethod = existing == nil ? "POST" : "PATCH"
        request.setValue("multipart/related; boundary=\(boundary)", forHTTPHeaderField: "content-type")
        request.httpBody = body
        let reply = (try? JSONSerialization.jsonObject(with: try await send(request))) as? [String: Any]
        return (reply?["sha256Checksum"] as? String)?.lowercased() == sha256.lowercased()
    }

    func download(_ file: File) async throws -> Data {
        var components = URLComponents(url: Self.api.appending(path: "files/\(file.id)"), resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "alt", value: "media")]
        return try await send(URLRequest(url: components.url!, timeoutInterval: 60))
    }
}

struct GoogleDriveError: Error { let status: Int }

extension GoogleDrive: @preconcurrency ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.first ?? ASPresentationAnchor()
    }
}

/// Google's refresh token for Drive, in this iPhone's Keychain only (never synced or backed up).
nonisolated enum GoogleDriveKeychain {
    private static var query: [String: Any] {
        [kSecClass as String: kSecClassGenericPassword, kSecAttrService as String: "com.oftenenough.app.google-drive",
         kSecAttrAccount as String: "refresh-token"]
    }

    static var refreshToken: String? {
        get {
            var q = query
            q[kSecReturnData as String] = true
            q[kSecMatchLimit as String] = kSecMatchLimitOne
            var result: CFTypeRef?
            guard SecItemCopyMatching(q as CFDictionary, &result) == errSecSuccess, let data = result as? Data else { return nil }
            return String(data: data, encoding: .utf8)
        }
        set {
            SecItemDelete(query as CFDictionary)
            guard let newValue else { return }
            var add = query
            add[kSecValueData as String] = Data(newValue.utf8)
            add[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
            SecItemAdd(add as CFDictionary, nil)
        }
    }
}

/// Backup & Export → Google Drive: choosing Drive as the backup place asks Google's permission (Drive only).
struct GoogleDriveChoiceView: View {
    @Environment(BackupCenter.self) private var backup
    @State private var working = false
    @State private var failure: String?

    var body: some View {
        Form {
            Section {
                Text("Your habits are backed up to a hidden folder in your Google Drive that only this app can see. Google asks for your permission first.")
            }
            Section {
                Button(backup.usesGoogleDrive ? "Back Up to iCloud Instead" : "Back Up to Google Drive") {
                    Task { await toggle() }
                }
                .disabled(working)
                .accessibilityIdentifier("google-drive-choose")
            }
            if let failure { Section { Text(failure).foregroundStyle(.red) } }
        }
        .navigationTitle("Google Drive")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func toggle() async {
        working = true
        failure = nil
        defer { working = false }
        if backup.usesGoogleDrive { backup.chooseGoogleDrive(false); return }
        do {
            if !GoogleDrive.shared.isConnected { try await GoogleDrive.shared.connect() }
            backup.chooseGoogleDrive(true)
        } catch is CancellationError {
        } catch {
            failure = "Couldn't connect to Google Drive. Check your connection and try again."
        }
    }
}

/// Restore From a Backup → Google Drive: the copies in the app's Drive folder, by device and day.
struct GoogleDriveCopiesView: View {
    @Environment(BackupCenter.self) private var backup
    @State private var files: [GoogleDrive.File] = []
    @State private var loading = true
    @State private var pending: BackupCenter.Pending?
    @State private var failure: String?

    var body: some View {
        Form {
            if loading {
                Section { ProgressView() }
            } else if files.isEmpty {
                Section { Text(GoogleDrive.shared.isConnected ? "No backup found in your Google Drive." : "Not connected to Google Drive.").foregroundStyle(.secondary) }
            }
            ForEach(files) { file in
                Button {
                    Task { await open(file) }
                } label: {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(file.properties["deviceName"] ?? "A backup").foregroundStyle(Color.primary)
                        Text(HabitCopy.capitalized(ICloudPage.when(file.modified))).font(.footnote).foregroundStyle(.secondary)
                    }
                }
            }
            if let failure { Section { Text(failure).foregroundStyle(.red) } }
        }
        .navigationTitle("Google Drive")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            defer { loading = false }
            files = ((try? await GoogleDrive.shared.list()) ?? []).filter { $0.name.hasSuffix(".zip") }.sorted { $0.modified > $1.modified }
        }
        .sheet(item: $pending) { pending in NavigationStack { RestorePreviewView(pending: pending) } }
    }

    private func open(_ file: GoogleDrive.File) async {
        failure = nil
        guard let data = try? await GoogleDrive.shared.download(file), file.sha256.isEmpty || SHA256Hex.of(data) == file.sha256.lowercased() else {
            failure = "Couldn't download this backup. Check your connection and try again."
            return
        }
        pending = await backup.check(data)
    }
}
