import Core
import SwiftUI
import UniformTypeIdentifiers
import UIKit

// "I've used it before" (Current Work 73.1; Figma rows 5–9, 9 Oct 2026): every way back on one page, then one loading
// page whose words say what's happening ("Getting your data" from an account or the other device, "Restoring your
// backup" from iCloud or a file, "Setting things up" with what's already here). Signing in never deletes and never
// quietly makes an account (D3); a restore keeps an undo file (D5); nothing is backed up over the data on its way back.

/// A checked backup on its way back, and where it came from.
struct ReturningBackup {
    let pending: BackupCenter.Pending
    let source: ReturnSource
    /// From another device: whether it was signed in, so this one can ask to sign in too (Current Work 76).
    var senderAccount: TransferCode.Account = .none
}

enum ReturnSource: Hashable {
    case account, iCloud, file, otherDevice

    /// The line under the loading page's title.
    var from: String {
        switch self {
        case .account: "From your account."
        case .iCloud: "From iCloud."
        case .file: "From your backup file."
        case .otherDevice: "From your other device."
        }
    }
}

/// What a loading page does.
enum OnboardingWork: Hashable {
    /// Signed in (just now, or still from before a reinstall): the account's data comes back.
    case account
    /// Move from another device, with the code the other device shows.
    case transfer(String)
    /// Continue with the data already on this iPhone.
    case thisDevice
    /// A backup file: checked, then shown for review.
    case file(URL)
    /// The reviewed backup (`OnboardingFlow.review`), replacing or merging.
    case restore(ReturnMode)
}

enum ReturnMode: Hashable { case replace, merge }

// MARK: - R01 · Welcome back

/// Every way back, most common first, and Start without restoring. When this iPhone already has something (habits
/// that came with an iPhone backup or a sync, or the account still signed in after a reinstall), that comes first,
/// with its own Continue (R01B).
struct WelcomeBackPage: View {
    @Environment(HabitStore.self) private var store
    @Environment(BackupCenter.self) private var backup: BackupCenter?
    @Environment(OnboardingFlow.self) private var flow

    fileprivate enum Found { case data(String), account }

    /// What's already here: habits or tasks, else an account still signed in (its Keychain session outlives a reinstall).
    private var found: Found? {
        let items = store.habits.filter { !$0.archived }
        if !items.isEmpty {
            let habits = items.filter { $0.kind != .task }.count
            let tasks = items.count - habits
            var parts: [String] = []
            if habits > 0 { parts.append("\(habits) \(habits == 1 ? "habit" : "habits")") }
            if tasks > 0 { parts.append("\(tasks) \(tasks == 1 ? "task" : "tasks")") }
            return .data(parts.joined(separator: " and "))
        }
        if backup?.isSignedIn == true { return .account }
        return nil
    }

    var body: some View {
        let found = found
        OnboardingList(title: "Welcome back.", lead: "Get your habits, tasks and history back.", id: "onboarding-page-returning") {
            if let found {
                Section {
                    foundCard(found)
                }
                Section {
                    ways
                } header: {
                    Text("Other ways to get your data").font(.subheadline.weight(.semibold)).foregroundStyle(Color.primary).textCase(nil)
                }
            } else {
                Section { ways }
            }
            Section {
                OnboardingButton(title: "Start without restoring", id: "onboarding-start-fresh", prominent: false) {
                    flow.finish(.startedFresh)
                }
                .listRowBackground(Color.clear)
            }
        } bottom: {
            EmptyView()
        }
        .onAppear { flow.reached("returning") }
    }

    @ViewBuilder private func foundCard(_ found: Found) -> some View {
        let (title, line, work): (String, String, OnboardingWork) = switch found {
        case .data(let what): ("We found data on this device.", "\(what). Continue with this data?", .thisDevice)
        case .account: ("You're still signed in.", "Your account is on this iPhone. Get your habits back from it?", .account)
        }
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 14) {
                OnboardingTile(symbol: found.isAccount ? "person.crop.circle" : "tray.full")
                VStack(alignment: .leading, spacing: 3) {
                    Text(title).font(.body.weight(.semibold))
                    Text(line).font(.subheadline).foregroundStyle(.secondary)
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .accessibilityElement(children: .combine)
            .accessibilityIdentifier("onboarding-found")
            OnboardingButton(title: "Continue", id: "onboarding-found-continue") { flow.go(.working(work)) }
        }
        .padding(.vertical, 6)
    }

    /// One card per way back, each opening its page.
    @ViewBuilder private var ways: some View {
        NavigationLink(value: OnboardingRoute.signIn) {
            WayLabel(symbol: "person.crop.circle", title: "Sign in to your account", detail: "Continue with Apple or Google.")
        }
        .accessibilityIdentifier("onboarding-way-sign-in")
        NavigationLink(value: OnboardingRoute.restore) {
            WayLabel(symbol: "icloud.and.arrow.down", title: "Restore a backup",
                     detail: BackupFeatures.iCloudBackup ? "From iCloud or a backup file." : "From a backup file.")
        }
        .accessibilityIdentifier("onboarding-way-restore")
        NavigationLink(value: OnboardingRoute.transferCode) {
            WayLabel(symbol: "iphone", title: "Move from another device", detail: "Enter the code shown on the other device.")
        }
        .accessibilityIdentifier("onboarding-way-transfer")
    }
}

private extension WelcomeBackPage.Found {
    var isAccount: Bool { if case .account = self { true } else { false } }
}

/// A way back: an icon tile, a title and one line. The row's own chevron comes from the list.
struct WayLabel: View {
    let symbol: String
    let title: String
    let detail: String
    var checked = false

    var body: some View {
        HStack(spacing: 14) {
            OnboardingTile(symbol: symbol)
            VStack(alignment: .leading, spacing: 3) {
                Text(title).font(.body.weight(.semibold)).foregroundStyle(Color.primary)
                Text(detail).font(.subheadline).foregroundStyle(.secondary)
            }
            .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
            if checked {
                Image(systemName: "checkmark").font(.body.weight(.semibold)).foregroundStyle(Color.ink).accessibilityHidden(true)
            }
        }
        .padding(.vertical, 6)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(checked ? .isSelected : [])
    }
}

// MARK: - R02 · Sign back in

/// Apple and Google, the same size (HIG), then the account's data comes back on the loading page. An unknown sign-in
/// never quietly becomes a new, empty account (D3): it says so and offers the other ways.
struct SignBackInPage: View {
    @Environment(BackupCenter.self) private var backup: BackupCenter?
    @Environment(OnboardingFlow.self) private var flow
    @State private var working: String?
    @State private var unknown: ProviderToken?
    /// A free account signed in on another device: "Use on This iPhone?" (screen 7, Current Work 78).
    @State private var other: OtherDevice?
    @State private var failure: String?
    @State private var google = GoogleSignIn()
    @State private var apple = AppleSignIn()

    var body: some View {
        OnboardingList(title: "Sign back in.", lead: "Use the same sign-in you used before.", id: "onboarding-page-sign-in") {
            Section {
                if BackupFeatures.appleSignIn {
                    SignInButton(symbol: "apple.logo", title: "Continue with Apple", working: working == "apple", id: "onboarding-apple") {
                        start("apple") { try await apple.signIn() }
                    }
                }
                if BackupFeatures.googleSignIn {
                    SignInButton(symbol: "g.circle", title: "Continue with Google", working: working == "google", id: "onboarding-google") {
                        start("google") { try await google.signIn() }
                    }
                }
            } footer: {
                if let failure {
                    Text(failure).font(.callout).foregroundStyle(.red).accessibilityIdentifier("onboarding-sign-in-failure")
                }
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
            .disabled(working != nil)
            Section {
                OnboardingButton(title: "Restore a backup instead", id: "onboarding-restore-instead", prominent: false) {
                    flow.go(.restore)
                }
                .listRowBackground(Color.clear)
            }
        } bottom: {
            EmptyView()
        }
        .onAppear { flow.reached("sign_in") }
        .sheet(item: $other) { ask in
            UseHereQuestion(otherDevice: ask.device, working: working != nil) {
                working = "replace"
                finish(ask.token, create: false, replace: true)
            } onCancel: {
                other = nil
            }
            .presentationDetents([.height(300)])
            .presentationDragIndicator(.visible)
        }
        .alert("No account for this sign-in", isPresented: Binding(get: { unknown != nil }, set: { if !$0 { unknown = nil } })) {
            Button("Try Another Sign-In", role: .cancel) { unknown = nil }
            Button("Restore a Backup Instead") { unknown = nil; flow.go(.restore) }
            Button("Create a New Account") {
                guard let token = unknown else { return }
                unknown = nil
                finish(token, create: true)
            }
        } message: {
            Text("There's no \(Onboarding.appName) account for this sign-in. If you used a different one before, try that instead.")
        }
    }

    private func start(_ provider: String, _ signIn: @escaping @MainActor () async throws -> ProviderToken) {
        working = provider
        failure = nil
        Task {
            do {
                finish(try await signIn(), create: false)
            } catch is CancellationError {
                working = nil
            } catch {
                working = nil
                failure = "Couldn't sign in. Check your connection and try again."
            }
        }
    }

    /// Signs in without backing this iPhone up first: the account's data comes back on the next page, then it backs up.
    private func finish(_ token: ProviderToken, create: Bool, replace: Bool = false) {
        guard let backup else { failure = "Couldn't sign in on this iPhone."; working = nil; return }
        Task {
            defer { working = nil }
            do {
                try await backup.signIn(with: token, create: create, backUp: false, replace: replace)
                other = nil
                flow.go(.working(.account))
            } catch let error as ServerError where error.code == "unknown_key" {
                unknown = token
            } catch let error as ServerError where error.code == "other_device_signed_in" {
                other = OtherDevice(token: token, device: error.deviceName ?? "")
            } catch {
                other = nil
                failure = "Couldn't sign in. Check your connection and try again."
            }
        }
    }

    private struct OtherDevice: Identifiable {
        let id = UUID()
        let token: ProviderToken
        let device: String
    }
}

/// "Continue with Apple" / "Continue with Google": full width, the same size, on the card colour.
private struct SignInButton: View {
    let symbol: String
    let title: String
    let working: Bool
    let id: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                if working { ProgressView() } else { Image(systemName: symbol).font(.title3).accessibilityHidden(true) }
                Text(title).font(.headline)
            }
            .foregroundStyle(Color.primary)
            .frame(maxWidth: .infinity, minHeight: 52)
            .contentShape(Capsule())
        }
        .buttonStyle(SignInButtonStyle())
        .accessibilityIdentifier(id)
    }
}

private struct SignInButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.background(configuration.isPressed ? Color(.systemGray4) : Color.card, in: Capsule())
    }
}

// MARK: - R04 / R05 · Restore a backup

/// Where the backup is. iCloud is looked in as the page opens: a backup found there comes first, ready to review
/// (R05), with the other places under "Other backups"; otherwise the places to look (R04). Google Drive is in the
/// wireframes but has no backups to find yet (nothing backs up there), so it isn't offered until it does.
struct RestoreSourcePage: View {
    @Environment(BackupCenter.self) private var backup: BackupCenter?
    @Environment(OnboardingFlow.self) private var flow
    @State private var copies: [BackupCenter.ICloudCopy] = []
    @State private var chosen: BackupCenter.ICloudCopy?
    @State private var searching = false
    @State private var searched = false
    @State private var importing = false
    @State private var opening = false
    @State private var failure: String?

    var body: some View {
        OnboardingList(title: "Restore a backup.", lead: copies.isEmpty ? "Where is your backup stored?" : "We found a backup in iCloud.",
                       id: "onboarding-page-restore") {
            if copies.isEmpty {
                Section {
                    if BackupFeatures.iCloudBackup { iCloudRow }
                    fileRow
                } footer: {
                    if let failure { Text(failure).font(.callout).foregroundStyle(.red) }
                }
            } else {
                Section {
                    ForEach(copies) { copy in
                        Button { chosen = copy } label: {
                            WayLabel(symbol: "icloud.and.arrow.down", title: copy.deviceName.isEmpty ? (copy.isThisDevice ? "This iPhone's backup" : "iCloud backup") : copy.deviceName,
                                     detail: copy.detail, checked: copies.count > 1 && chosen == copy)
                        }
                        .accessibilityIdentifier("onboarding-icloud-copy")
                    }
                } footer: {
                    if let failure { Text(failure).font(.callout).foregroundStyle(.red) }
                }
                Section {
                    fileRow
                } header: {
                    Text("Other backups").font(.subheadline.weight(.semibold)).foregroundStyle(Color.primary).textCase(nil)
                }
            }
        } bottom: {
            if !copies.isEmpty {
                OnboardingButton(title: opening ? "Opening…" : "Review backup", id: "onboarding-review") { Task { await review() } }
                    .disabled(opening || chosen == nil)
            }
        }
        .task { await search() }
        .onAppear { flow.reached("restore_source") }
        .fileImporter(isPresented: $importing, allowedContentTypes: [.zip, .data], allowsMultipleSelection: false) { result in
            guard case .success(let urls) = result, let url = urls.first else { return }
            flow.go(.working(.file(url)))
        }
    }

    private var iCloudRow: some View {
        Button { Task { await search() } } label: {
            HStack {
                WayLabel(symbol: "icloud.and.arrow.down", title: "iCloud", detail: iCloudLine)
                if searching { ProgressView() }
            }
        }
        .disabled(searching)
        .accessibilityIdentifier("onboarding-restore-icloud")
    }

    private var iCloudLine: String {
        if searching { return "Looking for a backup in iCloud…" }
        if FileManager.default.ubiquityIdentityToken == nil { return "This iPhone isn't signed in to iCloud." }
        return searched ? "No backup found in this iPhone's iCloud." : "Find a backup saved in iCloud."
    }

    private var fileRow: some View {
        Button { importing = true } label: {
            HStack {
                WayLabel(symbol: "doc.zipper", title: "Backup file", detail: "Open a backup file you've saved.")
                Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary).accessibilityHidden(true)
            }
        }
        .accessibilityIdentifier("onboarding-restore-file")
    }

    /// iCloud brings copies that aren't on this iPhone yet; look again until they're here (at most a minute), and keep
    /// looking a little while nothing has been found (`BackupCenter.keepLooking`).
    private func search() async {
        guard BackupFeatures.iCloudBackup, let backup, !searching else { return }
        searching = true
        defer { searching = false; searched = true }
        let started = Date.now
        for _ in 0..<20 {
            // Each device's newest copy with habits, this iPhone's own first (a reinstall picks its own, Current Work 75).
            let (all, downloading) = await backup.iCloudCopies()
            let found = BackupCenter.newestPerDevice(all)
            if !found.isEmpty {
                copies = found
                if chosen == nil || !found.contains(where: { $0 == chosen }) { chosen = found.first }
            }
            let more = backup.canLookInICloud && BackupCenter.keepLooking(found: !copies.isEmpty, downloading: downloading, elapsed: Date.now.timeIntervalSince(started))
            if !more || Task.isCancelled { return }
            try? await Task.sleep(for: .seconds(3))
        }
    }

    private func review() async {
        guard let backup, let chosen else { return }
        failure = nil
        opening = true
        defer { opening = false }
        guard let pending = await backup.open(chosen) else {
            failure = "Couldn't read this backup from iCloud. Please try again."
            return
        }
        flow.review = ReturningBackup(pending: pending, source: .iCloud)
        flow.go(.review)
    }
}

// MARK: - R07 · Enter transfer code

/// The code the other iPhone shows (≡ → Backup & Export → Move to a New iPhone → Show a Transfer Code).
struct TransferCodePage: View {
    @Environment(OnboardingFlow.self) private var flow
    @State private var draft = TransferDraft()

    var body: some View {
        OnboardingList(title: "Enter transfer code.", lead: "Use the code shown on your other device.", id: "onboarding-page-transfer") {
            Section {
                TransferCodeField(draft: draft, onSubmit: start)
            } header: {
                Text("Transfer code").font(.subheadline.weight(.semibold)).foregroundStyle(Color.primary).textCase(nil)
            } footer: {
                Text("On your other iPhone, open \(Onboarding.appName) and go to ≡ › Backup & Export › Move to a New iPhone › Show a Transfer Code. Keep both iPhones close.")
                    .formNote()
            }
        } bottom: {
            TransferGetButton(draft: draft, action: start)
        }
        .onAppear { flow.reached("transfer_code") }
    }

    private func start() {
        guard draft.isComplete else { return }
        flow.go(.working(.transfer(draft.code)))
    }
}

/// The typed code. Only the field reads `text`; the page reads `isComplete`, which changes once, at the eighth
/// character (S11).
@Observable final class TransferDraft {
    var text = "" {
        didSet {
            guard text != oldValue else { return }
            let complete = TransferCode.normalize(text).count == TransferCode.length
            if complete != isComplete { isComplete = complete }
        }
    }
    private(set) var isComplete = false
    var code: String { TransferCode.normalize(text) }
}

private struct TransferCodeField: View {
    let draft: TransferDraft
    let onSubmit: () -> Void
    @FocusState private var focused: Bool

    var body: some View {
        @Bindable var draft = draft
        TextField("Enter code", text: $draft.text)
            .font(.title2.monospaced().weight(.semibold))
            .textInputAutocapitalization(.characters)
            .autocorrectionDisabled()
            .keyboardType(.asciiCapable)
            .textContentType(.oneTimeCode)
            .submitLabel(.go)
            .focused($focused)
            .onSubmit(onSubmit)
            .frame(minHeight: 44)
            .accessibilityLabel("Transfer code")
            .accessibilityIdentifier("onboarding-transfer-code")
            .onChange(of: draft.text) { _, new in
                // Capitals, the dash and spaces dropped, eight at most: put back on the next turn, or the field keeps
                // showing what wasn't kept (U6).
                let clean = TransferCode.normalize(new)
                if clean != new { Task { @MainActor in if draft.text == new { draft.text = clean } } }
            }
            .task { focused = true }
    }
}

private struct TransferGetButton: View {
    let draft: TransferDraft
    let action: () -> Void

    var body: some View {
        OnboardingButton(title: "Get my data", id: "onboarding-get-data", action: action)
            .disabled(!draft.isComplete)
    }
}

// MARK: - Review

/// What a backup holds before anything changes: how much, from which iPhone and when. On an empty iPhone, one button;
/// with something here already, Replace or Merge, each saying what it would do (03 §3.6).
struct ReviewBackupPage: View {
    @Environment(OnboardingFlow.self) private var flow

    var body: some View {
        if let review = flow.review {
            content(review)
        } else {
            Color(.systemGroupedBackground)
        }
    }

    @ViewBuilder private func content(_ review: ReturningBackup) -> some View {
        let check = review.pending.check
        let preview = check.preview
        let empty = preview.map { $0.phoneHabits == 0 && $0.phoneEntries == 0 } ?? true
        let nothing = preview.map { $0.replace.changesNothing && $0.merge.changesNothing } ?? false
        OnboardingList(title: review.source == .otherDevice ? "Your data." : "Your backup.", lead: lead(review), id: "onboarding-page-review") {
            if let problem = check.problem {
                Section { Text(BackupCenter.words(for: problem)) }
            } else if let preview {
                Section {
                    LabeledContent("In the backup", value: RestoreStartView.counts(habits: Int(preview.fileHabits), entries: Int(preview.fileEntries)))
                        .accessibilityIdentifier("onboarding-review-counts")
                    LabeledContent("Made on", value: preview.deviceName)
                    if !empty {
                        LabeledContent("On this iPhone now", value: RestoreStartView.counts(habits: Int(preview.phoneHabits), entries: Int(preview.phoneEntries)))
                    }
                }
                if nothing {
                    Section { Text("Everything in this backup is already here. Nothing needs to change.") }
                } else if !empty {
                    Section {
                        Button("Replace What's on This iPhone") { flow.go(.working(.restore(.replace))) }
                            .accessibilityIdentifier("onboarding-review-replace")
                    } footer: {
                        Text("This iPhone becomes exactly the backup. " + RestorePreviewView.describe(preview.replace)).formNote()
                    }
                    Section {
                        Button("Merge") { flow.go(.working(.restore(.merge))) }
                            .disabled(preview.merge.changesNothing)
                            .accessibilityIdentifier("onboarding-review-merge")
                    } footer: {
                        Text(preview.merge.changesNothing ? "Merging adds nothing: everything in the backup is already here."
                             : "Adds what's missing and keeps everything here. " + RestorePreviewView.describe(preview.merge)).formNote()
                    }
                }
                Section {
                } footer: {
                    Text("You can undo a restore for 30 days in ≡ › Backup & Export.").formNote()
                }
            }
        } bottom: {
            if check.problem != nil || preview == nil {
                OnboardingButton(title: "Choose another backup", id: "onboarding-review-back") { flow.path.removeLast() }
            } else if nothing {
                OnboardingButton(title: "Continue", id: "onboarding-review-continue") { flow.finish(.restored) }
            } else if empty {
                OnboardingButton(title: "Restore", id: "onboarding-review-restore") { flow.go(.working(.restore(.replace))) }
            }
        }
    }

    /// "From iCloud · 8 Oct 2026, 10:30 PM": where, and when it was made.
    private func lead(_ review: ReturningBackup) -> String {
        let from = String(review.source.from.dropLast())
        guard let preview = review.pending.check.preview else { return from + "." }
        let made = Date(timeIntervalSince1970: Double(preview.createdAt) / 1000)
        return from + " · " + made.formatted(date: .abbreviated, time: .shortened)
    }
}

// MARK: - R03 / R08 / R09 · The loading page

/// One page for every wait, its words fitted to what's happening (the user, 9 Oct 2026): a title and where from at the
/// top, a turning symbol and what it's doing now in the middle, Cancel at the bottom while stopping is safe. A
/// problem is said in place, with what to do next. Back cancels too; once a restore is writing, neither is offered.
struct WorkingPage: View {
    let work: OnboardingWork
    @Environment(HabitStore.self) private var store
    @Environment(BackupCenter.self) private var backup: BackupCenter?
    @Environment(OnboardingFlow.self) private var flow
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var status = ""
    @State private var failure: Failure?
    @State private var writing = false
    @State private var attempt = 0
    @State private var receiver = TransferReceiver()

    /// A problem and the two ways on from it.
    private struct Failure: Equatable {
        enum Next: Equatable { case tryAgain, back, openSettings, restoreInstead, startFresh }
        let text: String
        let main: Next
        let other: Next
    }

    private var title: String {
        switch work {
        case .account, .transfer: "Getting your data."
        case .thisDevice: "Setting things up."
        case .file: "Processing your data."
        case .restore: flow.review?.source == .otherDevice ? "Restoring your data." : "Restoring your backup."
        }
    }

    private var from: String {
        switch work {
        case .account: ReturnSource.account.from
        case .transfer: ReturnSource.otherDevice.from
        case .thisDevice: "With the data already on this iPhone."
        case .file: ReturnSource.file.from
        case .restore: flow.review?.source.from ?? ""
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            OnboardingHeading(title: title, lead: from, id: "onboarding-page-working")
                .padding(.horizontal, 20)
                .padding(.top, 8)
            Spacer(minLength: 24)
            Group {
                if let failure {
                    VStack(spacing: 14) {
                        Image(systemName: "exclamationmark.circle").font(.system(size: 40)).foregroundStyle(.secondary)
                        Text(failure.text).font(.body).multilineTextAlignment(.center)
                            .accessibilityIdentifier("onboarding-working-failure")
                    }
                } else {
                    VStack(spacing: 14) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.system(size: 40, weight: .medium))
                            .symbolEffect(.rotate, options: .repeat(.continuous), isActive: !reduceMotion)
                            .accessibilityHidden(true)
                        WorkingStatus(status: status)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 32)
            .accessibilityElement(children: .combine)
            Spacer(minLength: 24)
            OnboardingBottomBar { actions }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(writing)
        .interactiveDismissDisabled(writing)
        .task(id: attempt) { await run() }
    }

    @ViewBuilder private var actions: some View {
        if let failure {
            OnboardingButton(title: label(failure.main), id: "onboarding-working-main") { act(failure.main) }
            OnboardingButton(title: label(failure.other), id: "onboarding-working-other", prominent: false) { act(failure.other) }
        } else if !writing {
            OnboardingButton(title: "Cancel", id: "onboarding-working-cancel", prominent: false) { flow.path.removeLast() }
        } else {
            // Nothing to tap while a restore writes; the same height keeps the symbol still.
            Color.clear.frame(height: 44)
        }
    }

    private func label(_ next: Failure.Next) -> String {
        switch next {
        case .tryAgain: "Try again"
        case .back: work.isTransfer ? "Enter the code again" : "Back"
        case .openSettings: "Open Settings"
        case .restoreInstead: "Restore a backup instead"
        case .startFresh: "Start without restoring"
        }
    }

    private func act(_ next: Failure.Next) {
        switch next {
        case .tryAgain: failure = nil; attempt += 1
        case .back: flow.path.removeLast()
        case .openSettings: if let url = URL(string: UIApplication.openSettingsURLString) { UIApplication.shared.open(url) }
        case .restoreInstead: flow.replaceTop(with: .restore)
        case .startFresh: flow.finish(.startedFresh)
        }
    }

    // MARK: The work

    /// Ends the welcome, unless the page was left (Cancel or Back) while the work was still going.
    private func end(_ outcome: OnboardingOutcome) {
        guard !Task.isCancelled else { return }
        flow.finish(outcome)
    }

    /// Moves on to the review, unless the page was left meanwhile.
    private func show(_ route: OnboardingRoute) {
        guard !Task.isCancelled else { return }
        flow.replaceTop(with: route)
    }

    private func run() async {
        guard failure == nil else { return }
        let started = Date.now
        guard let backup else {
            failure = Failure(text: "Your data can't be brought back on this iPhone right now.", main: .back, other: .startFresh)
            return
        }
        switch work {
        case .account: await bringBackAccount(backup, started: started)
        case .transfer(let code): await receive(code, backup, started: started)
        case .thisDevice:
            status = "Getting everything ready…"
            await store.flush()
            await settle(since: started)
            end(.keptOnDevice)
        case .file(let url): await process(url, backup, started: started)
        case .restore(let mode): await restore(mode, backup, started: started)
        }
    }

    private func bringBackAccount(_ backup: BackupCenter, started: Date) async {
        status = "Checking your account…"
        do {
            switch try await backup.accountReturn() {
            case .synced:
                status = "Bringing back your habits…"
                await settle(since: started)
                end(.signedIn)
            }
        } catch is CancellationError {
        } catch {
            guard !Task.isCancelled else { return }
            failure = Failure(text: "Couldn't reach your account. Check your connection and try again.", main: .tryAgain, other: .back)
        }
    }

    /// The file the code points to, through our server (`TransferReceiver`); the server deletes it once it has been
    /// checked here, and the other device says "Done".
    private func receive(_ code: String, _ backup: BackupCenter, started: Date) async {
        status = "Getting your data from your other device…"
        do {
            let data = try await receiver.receive(code: code, api: backup.api)
            status = "Checking your data…"
            guard let pending = await backup.check(data) else {
                failure = Failure(text: "Your data didn't arrive whole, so nothing was changed. Please try again.", main: .tryAgain, other: .back)
                return
            }
            if let problem = pending.check.problem {
                failure = Failure(text: BackupCenter.words(for: problem), main: .back, other: .startFresh)
                return
            }
            await receiver.confirm()
            await restoreOrReview(pending, from: .otherDevice, backup, started: started, senderAccount: receiver.senderAccount)
        } catch let problem as TransferReceiver.Failure {
            // At least a second on this page, so what happened can be read before it changes (as `settle`).
            await settle(since: started)
            guard !Task.isCancelled else { return }
            failure = switch problem {
            case .wrongCode: Failure(text: "That code doesn't match, or it has expired. Check the code on your other device.", main: .back, other: .tryAgain)
            case .unreachable: Failure(text: "Couldn't reach the server, so nothing was changed. Check your connection and try again.", main: .tryAgain, other: .back)
            case .damaged: Failure(text: "Your data didn't arrive whole, so nothing was changed. Please try again.", main: .tryAgain, other: .back)
            }
        } catch {
            // Cancelled: the page has gone.
        }
    }

    private func process(_ url: URL, _ backup: BackupCenter, started: Date) async {
        status = "Checking your backup file…"
        let scoped = url.startAccessingSecurityScopedResource()
        defer { if scoped { url.stopAccessingSecurityScopedResource() } }
        guard let data = await Task.detached(operation: { try? Data(contentsOf: url) }).value else {
            failure = Failure(text: "Couldn't open the file. Nothing was changed.", main: .back, other: .startFresh)
            return
        }
        if BackupCenter.isOlderBackupFile(data) {
            // A file saved from Backup & Export before 1 Oct 2026: it only ever adds what's missing.
            writing = true
            status = "Bringing back your habits…"
            do {
                _ = try await backup.importOlderFile(url)
                await settle(since: started)
                end(.restored)
            } catch {
                writing = false
                failure = Failure(text: "Couldn't restore this file, so nothing was changed.", main: .back, other: .startFresh)
            }
            return
        }
        guard let pending = await backup.check(data) else {
            failure = Failure(text: BackupCenter.words(for: "not_a_backup"), main: .back, other: .startFresh)
            return
        }
        await settle(since: started)
        flow.review = ReturningBackup(pending: pending, source: .file)
        show(.review)
    }

    /// An empty iPhone has nothing to lose (and an undo file is kept): restore straight away. Otherwise the person
    /// chooses Replace or Merge on the review page.
    private func restoreOrReview(_ pending: BackupCenter.Pending, from source: ReturnSource, _ backup: BackupCenter, started: Date,
                                 senderAccount: TransferCode.Account = .none) async {
        // Nothing in it: say so, rather than "restore" nothing and open an empty Today as if it had worked.
        if let preview = pending.check.preview, preview.fileHabits == 0 && preview.fileEntries == 0 {
            failure = Failure(text: source == .otherDevice ? "Your other device has no habits or tasks to send yet."
                                                           : "This backup has no habits or tasks in it.",
                              main: .back, other: .startFresh)
            return
        }
        flow.review = ReturningBackup(pending: pending, source: source, senderAccount: senderAccount)
        let empty = pending.check.preview.map { $0.phoneHabits == 0 && $0.phoneEntries == 0 } ?? false
        guard empty else {
            show(.review)
            return
        }
        await restore(.replace, backup, started: started)
    }

    private func restore(_ mode: ReturnMode, _ backup: BackupCenter, started: Date) async {
        guard let review = flow.review, !Task.isCancelled else { return }
        writing = true
        status = "Bringing back your habits…"
        do {
            _ = try await backup.restore(review.pending, mode: mode == .replace ? .replace : .merge)
            // Signed in: the account gets what came back (its backup was held back while signing in).
            if backup.isSignedIn { Task { await backup.backUpNow() } }
            // Moved from a device that was signed in: once on Today, ask to sign in with the same account (sign-ins never
            // travel between devices; Account and Backup Redesign §7 item 3).
            if review.source == .otherDevice, review.senderAccount != .none, !backup.isSignedIn { backup.suggestSignIn = review.senderAccount }
            await settle(since: started)
            end(review.source == .account ? .signedIn : review.source == .otherDevice ? .transferred : .restored)
        } catch {
            writing = false
            failure = Failure(text: "Couldn't restore, so nothing was changed. Please try again.", main: .tryAgain, other: .back)
        }
    }

    /// At least a second on screen, so a quick job reads as a step, not a flicker.
    private func settle(since started: Date) async {
        let left = 1.0 - Date.now.timeIntervalSince(started)
        if left > 0 { try? await Task.sleep(for: .seconds(left)) }
    }
}

private extension OnboardingWork {
    var isTransfer: Bool { if case .transfer = self { true } else { false } }
}

/// What the loading page is doing now.
private struct WorkingStatus: View {
    let status: String

    var body: some View {
        Text(status)
            .font(.headline)
            .multilineTextAlignment(.center)
            .monospacedDigit()
            .accessibilityIdentifier("onboarding-working-status")
    }
}
