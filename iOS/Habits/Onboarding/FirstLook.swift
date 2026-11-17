import Network
import SwiftUI

// The first launch (Figma's onboarding flows 1, 2, 4 and 5): the launch screen, then a moment while iCloud is looked
// in, then Today. There's no welcome to read and nothing to choose: habits in iCloud come back by themselves (D14),
// and a backup file is Restore from a Backup on the empty Today.
//
// While iCloud is looked in, Today's background covers Today, and only if it takes more than a second does it show
// iOS's spinner with Looking in iCloud…; a fresh install that can't reach iCloud gets No Internet Connection instead,
// which goes on by itself once the phone is online. What shows comes from CloudSync's own state
// (`FirstLook.state`), never from a page the person steps through.

enum FirstLook {
    enum State: Equatable {
        /// iCloud is being looked in, or habits are coming in from it.
        case looking
        /// A fresh install that can't reach iCloud.
        case offline
        /// Nothing to wait for: Today.
        case done
    }

    /// What the first launch shows now. `fresh` is a first launch whose welcome isn't finished; only it shows No
    /// internet, because everything else in the app works offline. Pure, so the checks can test it.
    static func state(phase: CloudSync.Phase?, firstLookDone: Bool, bringingIn: Int?, online: Bool, fresh: Bool) -> State {
        guard let phase else { return .done }
        let waiting: Bool
        switch phase {
        case .starting: waiting = true
        case .on: waiting = !firstLookDone || bringingIn != nil
        // Signed in but iCloud can't be reached: offline, or (online) a problem the iCloud page explains.
        case .off(.unavailable): waiting = !online
        // Signed out, iCloud off for the app, turned off here, another device syncing, or a question to answer.
        default: waiting = false
        }
        guard waiting else { return .done }
        if !online { return fresh ? .offline : .done }
        return .looking
    }
}

/// Whether the phone can reach the internet (`NWPathMonitor`), watched only while the first launch needs to know.
@Observable
final class Connection {
    private(set) var online = true
    @ObservationIgnored private var monitor: NWPathMonitor?
    #if DEBUG
    @ObservationIgnored private var testing = false
    #endif

    func start() {
        guard monitor == nil else { return }
        #if DEBUG
        // A test launch's phone offline for a while (`-test-cloud offline-then-online`): the Simulator's own network
        // can't be switched off from the app.
        if CloudTestStates.state == "offline-then-online" {
            guard !testing else { return }
            testing = true
            online = false
            Task {
                try? await Task.sleep(for: .seconds(CloudTestStates.offlineSeconds))
                online = true
            }
            return
        }
        #endif
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            let online = path.status == .satisfied
            Task { @MainActor in self?.online = online }
        }
        monitor.start(queue: DispatchQueue(label: "com.oftenenough.app.connection", qos: .utility))
        self.monitor = monitor
    }

    func stop() {
        monitor?.cancel()
        monitor = nil
    }
}

/// The cover over Today while iCloud is first looked in. Only this modifier reads the cloud's state, so Today never
/// redraws for it (S6).
struct FirstLookCover: ViewModifier {
    let cloud: CloudSync?
    let store: HabitStore
    @State private var connection = Connection()
    /// Not Now on No internet: Today for the rest of this launch, and habits come back by themselves later.
    @State private var notNow = false

    private var fresh: Bool { !UserDefaults.standard.bool(forKey: Onboarding.doneKey) }

    private var state: FirstLook.State {
        guard Onboarding.waitsForICloud(store), !notNow else { return .done }
        return FirstLook.state(phase: cloud?.phase, firstLookDone: cloud?.firstLookDone ?? true,
                               bringingIn: cloud?.bringingIn, online: connection.online, fresh: fresh)
    }

    func body(content: Content) -> some View {
        let state = state
        content
            // An overlay, not a full-screen cover: a cover slides up, and on a fresh install this must be there from
            // the first frame, the launch screen's own colour, with nothing moving.
            .overlay {
                switch state {
                case .done: EmptyView()
                case .offline:
                    NoInternetView(onTryAgain: { cloud?.appBecameActive() }, onNotNow: finish)
                        .transition(.opacity)
                case .looking:
                    LookingInICloud(coversAtOnce: fresh).transition(.opacity)
                }
            }
            .animation(.default, value: state)
            .onChange(of: state, initial: true) { _, new in
                if new == .done {
                    if store.isLoaded { Onboarding.markDone() }
                    connection.stop()
                } else {
                    connection.start()
                }
            }
            // Back online: ask iCloud at once, and Looking in iCloud… takes over (flow 4).
            .onChange(of: connection.online) { _, online in
                if online { cloud?.appBecameActive() }
            }
    }

    private func finish() {
        notNow = true
        Onboarding.markDone()
    }
}

/// Figma's Restoring with Looking in iCloud… (582:7893): iOS's spinner and its words, only once a second has passed;
/// Apple keeps a spinner for waits longer than a moment, and most first looks are quicker. On a fresh install Today's
/// background covers Today from the first frame (the launch screen's colour), so the empty Today never flashes before
/// habits arrive; on a later launch nothing covers Today until that second has passed.
private struct LookingInICloud: View {
    let coversAtOnce: Bool
    @State private var shown = false

    var body: some View {
        ZStack {
            if coversAtOnce || shown { Color(.systemGroupedBackground).ignoresSafeArea() }
            if shown { RestoringView(label: "Looking in iCloud…").transition(.opacity) }
        }
        .allowsHitTesting(coversAtOnce || shown)
        .accessibilityElement(children: .contain)
        .accessibilityAddTraits(coversAtOnce || shown ? .isModal : [])
        .task {
            try? await Task.sleep(for: .seconds(1))
            withAnimation { shown = true }
        }
    }
}

/// Figma's No internet (582:8426): `ContentUnavailableView` with Apple's own title. Try Again asks at once; it also goes
/// on by itself once the phone is online. Not Now opens Today.
private struct NoInternetView: View {
    var onTryAgain: () -> Void
    var onNotNow: () -> Void

    var body: some View {
        ContentUnavailableView {
            Label("No Internet Connection", systemImage: "wifi.slash")
        } description: {
            Text("If you have habits in iCloud, they’ll come back once you’re online.")
        } actions: {
            Button(action: onTryAgain) {
                Text("Try Again").foregroundStyle(Color.onInk)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .accessibilityIdentifier("no-internet-try-again")
            Button("Not Now", action: onNotNow)
                .accessibilityIdentifier("no-internet-not-now")
        }
        .tint(.ink)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .accessibilityAddTraits(.isModal)
    }
}
