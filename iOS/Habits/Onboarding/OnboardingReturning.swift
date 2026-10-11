import Core
import SwiftUI
import UniformTypeIdentifiers
import UIKit

// "I've used it before" (Current Work 73.1; Figma rows 5–9, 9 Oct 2026; Architecture 11 §13.1): habits come back by
// themselves from iCloud, so the page first says what iCloud is bringing, and "Start without restoring" waits until iCloud
// has been looked in; then the other ways back (a backup in iCloud, a file), and one loading page whose words say what's
// happening ("Restoring your backup", "Setting things up"). A restore keeps an undo file (D5); nothing is sent to
// iCloud or backed up over the data on its way back until the welcome is finished.

/// A checked backup on its way back, and where it came from.
struct ReturningBackup {
    let pending: BackupCenter.Pending
    let source: ReturnSource
}

enum ReturnSource: Hashable {
    case iCloud, file

    /// The line under the loading page's title.
    var from: String {
        switch self {
        case .iCloud: "From iCloud."
        case .file: "From your backup file."
        }
    }
}

/// What a loading page does.
enum OnboardingWork: Hashable {
    /// Continue with the data already on this iPhone (that came with an iPhone backup, or from iCloud).
    case thisDevice
    /// A backup file: checked, then shown for review.
    case file(URL)
    /// The reviewed backup (`OnboardingFlow.review`), replacing or merging.
    case restore(ReturnMode)
}

enum ReturnMode: Hashable { case replace, merge }

// MARK: - R01 · Welcome back

/// Every way back, most common first, and Start without restoring. iCloud comes first: on a phone signed in to iCloud
/// the habits come back by themselves, so the page says what iCloud is doing, and what's here once they've come (R01B).
/// "Start without restoring" waits until iCloud has been looked in, so an empty phone is never taken for "nothing to
/// bring back" (Architecture 11 §13.1).
struct WelcomeBackPage: View {
    @Environment(HabitStore.self) private var store
    @Environment(CloudSync.self) private var cloud: CloudSync?
    @Environment(OnboardingFlow.self) private var flow

    /// What's already here: habits or tasks (from iCloud, or with an iPhone backup).
    private var found: String? {
        let items = store.habits.filter { !$0.archived }
        guard !items.isEmpty else { return nil }
        let habits = items.filter { $0.kind != .task }.count
        let tasks = items.count - habits
        var parts: [String] = []
        if habits > 0 { parts.append("\(habits) \(habits == 1 ? "habit" : "habits")") }
        if tasks > 0 { parts.append("\(tasks) \(tasks == 1 ? "task" : "tasks")") }
        return parts.joined(separator: " and ")
    }

    /// iCloud is still being looked in for the first time, or a big fetch is still coming.
    private var lookingInICloud: Bool {
        guard let cloud else { return false }
        switch cloud.phase {
        case .starting: return true
        case .on: return !cloud.firstLookDone || cloud.bringingIn != nil
        default: return false
        }
    }

    var body: some View {
        let found = found
        OnboardingList(title: "Welcome back.", lead: "Get your habits, tasks and history back.", id: "onboarding-page-returning") {
            if let found {
                Section { foundCard(found) }
                Section {
                    ways
                } header: {
                    Text("Other ways to get your data").font(.subheadline.weight(.semibold)).foregroundStyle(Color.primary).textCase(nil)
                }
            } else {
                Section {
                    iCloudCard
                    ways
                }
            }
            Section {
                OnboardingButton(title: "Start without restoring", id: "onboarding-start-fresh", prominent: false) {
                    flow.finish(.startedFresh)
                }
                .disabled(lookingInICloud && found == nil)
                .listRowBackground(Color.clear)
            }
        } bottom: {
            EmptyView()
        }
        .onAppear { flow.reached("returning") }
    }

    @ViewBuilder private func foundCard(_ what: String) -> some View {
        let fromICloud = cloud?.phase == .on
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 14) {
                OnboardingTile(symbol: fromICloud ? "icloud" : "tray.full")
                VStack(alignment: .leading, spacing: 3) {
                    Text(fromICloud ? "Your habits are here from iCloud." : "We found data on this device.").font(.body.weight(.semibold))
                    Text(lookingInICloud ? "\(what) so far. More are coming from iCloud." : "\(what). Continue with this data?")
                        .font(.subheadline).foregroundStyle(.secondary)
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .accessibilityElement(children: .combine)
            .accessibilityIdentifier("onboarding-found")
            OnboardingButton(title: "Continue", id: "onboarding-found-continue") { flow.go(.working(.thisDevice)) }
        }
        .padding(.vertical, 6)
    }

    /// iCloud: looking, nothing there, or off (Settings turns it on).
    @ViewBuilder private var iCloudCard: some View {
        if lookingInICloud {
            HStack(spacing: 14) {
                OnboardingTile(symbol: "icloud.and.arrow.down")
                VStack(alignment: .leading, spacing: 3) {
                    Text("Looking in iCloud…").font(.body.weight(.semibold))
                    Text("Your habits come back by themselves if they're there.").font(.subheadline).foregroundStyle(.secondary)
                }
                .fixedSize(horizontal: false, vertical: true)
                Spacer(minLength: 0)
                ProgressView()
            }
            .padding(.vertical, 6)
            .accessibilityElement(children: .combine)
            .accessibilityIdentifier("onboarding-icloud-looking")
        } else if let cloud, case .off(.noAccount) = cloud.phase {
            Button {
                if let url = URL(string: UIApplication.openSettingsURLString) { UIApplication.shared.open(url) }
            } label: {
                WayLabel(symbol: "icloud.slash", title: "Sign in to iCloud", detail: "In Settings. Your habits come back by themselves if they're there.")
            }
            .accessibilityIdentifier("onboarding-icloud-settings")
        } else if cloud?.phase == .on {
            WayLabel(symbol: "icloud", title: "No habits in iCloud", detail: "None came back from this Apple Account's iCloud.")
                .accessibilityIdentifier("onboarding-icloud-empty")
        }
    }

    /// The other ways back, each opening its page.
    @ViewBuilder private var ways: some View {
        NavigationLink(value: OnboardingRoute.restore) {
            WayLabel(symbol: "clock.arrow.circlepath", title: "Restore a backup",
                     detail: BackupFeatures.iCloudBackup ? "A day's copy from iCloud, or a backup file." : "From a backup file.")
        }
        .accessibilityIdentifier("onboarding-way-restore")
    }
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
        OnboardingList(title: "Your backup.", lead: lead(review), id: "onboarding-page-review") {
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
                    Text("You can undo a restore for 30 days in ≡ › iCloud & Backup.").formNote()
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

    /// A problem and the two ways on from it.
    private struct Failure: Equatable {
        enum Next: Equatable { case tryAgain, back, openSettings, restoreInstead, startFresh }
        let text: String
        let main: Next
        let other: Next
    }

    private var title: String {
        switch work {
        case .thisDevice: "Setting things up."
        case .file: "Processing your data."
        case .restore: "Restoring your backup."
        }
    }

    private var from: String {
        switch work {
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
        case .back: "Back"
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
        case .thisDevice:
            status = "Getting everything ready…"
            await store.flush()
            await settle(since: started)
            end(.keptOnDevice)
        case .file(let url): await process(url, backup, started: started)
        case .restore(let mode): await restore(mode, backup, started: started)
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

    private func restore(_ mode: ReturnMode, _ backup: BackupCenter, started: Date) async {
        guard let review = flow.review, !Task.isCancelled else { return }
        writing = true
        status = "Bringing back your habits…"
        do {
            _ = try await backup.restore(review.pending, mode: mode == .replace ? .replace : .merge)
            await settle(since: started)
            end(.restored)
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
