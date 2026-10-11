import Core
import Foundation
import Observation
import WatchKit

/// The Watch app's one store, link to the iPhone and Plus state (Architecture 12). Shared, because a notification's
/// button, a complication's tap or a batch from the iPhone can wake the app without a screen.
///
/// The Watch keeps its own full copy of the data (WA1): it opens from its own database at once and never waits for the
/// iPhone to show anything. Its changes are saved here first (S7), then go to the iPhone in `peer_out` batches.
@Observable
final class WatchModel {
    static let shared = WatchModel()

    let store: HabitStore
    @ObservationIgnored let link: WatchLink
    @ObservationIgnored let widgets = WidgetPublisher()
    let plus: PlusState
    /// Where the iPhone's first fill stands (WA2): Today says "Getting your habits…" until it has heard back.
    private(set) var filled = true
    /// The database couldn't be opened: say so, never show an empty Today as if there were nothing.
    private(set) var openFailed = false
    @ObservationIgnored private var loading: Task<Void, Never>?
    @ObservationIgnored private let repository: HabitRepository?

    /// A test launch (`-uitest`) never touches the person's data (D8): an in-memory database, its own App Group folder
    /// (`WidgetDisk.directory` under `uitest/`), and no link to an iPhone.
    static let testLaunch = ProcessInfo.processInfo.arguments.contains("-uitest")
    /// The paired-simulator check (`-uitest -pair-test`, `Tools/ci/watch_pair.sh`): a test launch that still links to
    /// its iPhone, itself a test launch with its own in-memory database. Simulator Debug builds only, so a test launch
    /// on a real Watch can never reach the person's iPhone (D8).
    static let pairTest: Bool = {
        #if DEBUG && targetEnvironment(simulator)
        return ProcessInfo.processInfo.arguments.contains("-pair-test")
        #else
        return false
        #endif
    }()

    private init() {
        var repository: HabitRepository?
        var failed = false
        if Self.testLaunch {
            repository = Persistence.inMemory().repository
            // A test launch's own switches (D8: never the person's): names hidden for E5 and D4.
            UserDefaults.standard.set(ProcessInfo.processInfo.arguments.contains("-hide-names"), forKey: HideNames.key)
        } else {
            do { repository = try Persistence.onDisk().repository } catch { failed = true }
        }
        self.repository = repository
        openFailed = failed
        let opened = repository ?? Persistence.inMemory().repository
        store = HabitStore(repository: opened, databaseOpened: repository != nil)
        // The last 400 days in memory (a year goal's whole year, with room), quit habits and tasks whole; the database
        // keeps everything (Architecture 12 §2). An extreme 15-year account read whole took 27 s (run 38109083512).
        store.historyWindowDays = 400
        link = WatchLink(repository: repository, testLaunch: Self.testLaunch && !Self.pairTest)
        plus = PlusState(testLaunch: Self.testLaunch)
        store.isPlus = true // the Watch app is Plus; `PlusState` decides whether it opens at all (G1)
        store.onChange = { [weak self] in self?.changed() }
        // A tap gives the system's click; a goal met gives success, the completion sound's place (Design Notes, feel).
        store.onLog = { completed in WKInterfaceDevice.current().play(completed ? .success : .click) }
        link.model = self
    }

    /// Loads once; every caller (the first screen, a notification action, a batch from the iPhone) waits for the same load.
    func ensureLoaded() async {
        if let loading { return await loading.value }
        let task = Task { @MainActor in
            await store.load()
            if Self.testLaunch && !Self.pairTest {
                await WatchFixtures.installIfAsked(self)
            } else {
                try? await repository?.peerStart()
                await refreshPeerStatus()
                link.activate()
            }
            await saveWidgetTaps()
            widgets.schedule(store)
            scheduleRefresh()
        }
        loading = task
        await task.value
    }

    func refreshPeerStatus() async {
        guard let repository, !Self.testLaunch || Self.pairTest else { return }
        if let status = try? await repository.peerStatus() { filled = status.filled }
    }

    /// For test launches: shows the first-launch state until the fixture says the fill has arrived.
    func setFilledForTest(_ value: Bool) { filled = value }

    /// After every saved change: the iPhone hears of it 0.5 s after the last one (S16), and the face is redrawn.
    private func changed() {
        link.scheduleSend()
        scheduleFace()
        guard !Self.testLaunch else { return }
        let store = store
        HabitShortcuts.habitsChanged(store)
        Task {
            await WatchNotifications.syncTimerAlerts(store)
            WatchNotifications.registerCategories(habits: store.habits)
        }
    }

    /// The face is redrawn 3 s after the last change while the app is open, and at once when it leaves the screen
    /// (WatchApp): working out the snapshot takes up to 58 ms on the main thread (run 38111296058), too much to repeat
    /// after every run of taps while the face isn't even showing. The iPhone's own publisher (locked, U28) is unchanged.
    @ObservationIgnored private var faceTask: Task<Void, Never>?
    private func scheduleFace() {
        faceTask?.cancel()
        faceTask = Task { @MainActor [weak self] in
            try? await Task.sleep(for: .seconds(3))
            guard !Task.isCancelled, let self else { return }
            await self.widgets.publish(self.store)
        }
    }

    /// The iPhone sent changes, or a fill part: show them, keeping any tap still being saved (S7).
    func receivedFromPhone() {
        store.reloadAfterSync()
        Task {
            await store.flush()
            await refreshPeerStatus()
            await widgets.publish(store)
        }
    }

    // MARK: Complication taps

    /// Saves the complications' waiting taps (`WatchTapIntent`), in the order they were made, each once: a + by its own
    /// ID, a ✓ as the state it set (`HabitStore.logFromWidget`, the iPhone's own rule). A tap the store refuses (another
    /// day, a changed habit) is dropped; a storage failure keeps them all for the next try.
    func saveWidgetTaps() async {
        guard store.isLoaded, store.isStorageReady, store.problem == nil else { return }
        let taps = WidgetTaps.read()
        guard !taps.isEmpty else { return }
        for tap in taps {
            guard let id = UUID(uuidString: tap.item), let day = LocalDay(key: tap.day), let event = UUID(uuidString: tap.event) else { continue }
            store.logFromWidget(id: id, day: day, event: event, signature: tap.signature, mode: tap.mode, now: tap.at)
        }
        await store.flush()
        if store.problem != nil, !store.isStorageReady { return }
        store.problem = nil
        WidgetTaps.remove(Set(taps.map(\.event)))
        await widgets.publish(store, hold: true)
        link.sendNow()
    }

    /// Asks watchOS to wake the app about every 15 minutes (with a complication on the face it allows about four an hour):
    /// complication taps are saved and the face is kept fresh even when the app isn't opened.
    func scheduleRefresh() {
        guard !Self.testLaunch else { return }
        WKApplication.shared().scheduleBackgroundRefresh(withPreferredDate: .now.addingTimeInterval(15 * 60), userInfo: nil) { _ in }
    }

    /// Plus decides what the face shows without it (G7): the snapshot says so, and the face shows no names or counts.
    func plusChanged() {
        let plus = self.plus.access != .none
        if store.isPlus != plus { store.isPlus = plus }
    }

    #if DEBUG
    /// Test launches: history added in one transaction, then read back (a year of logs for the speed runs).
    func importForTest(_ entries: [Entry]) async {
        guard let repository else { return }
        _ = try? await repository.importAll(snapshot: Snapshot(habits: [], steps: [], reminders: [], entries: entries.map(\.record), settings: []))
        await store.load()
    }

    /// Speed runs: a batch as if from the iPhone, merged and shown the way `WatchLink` does.
    func applyPeerBatchForTest(_ batch: String) async throws {
        guard let repository else { return }
        let started = CFAbsoluteTimeGetCurrent()
        _ = try await repository.acceptPeerBatch(batch: batch)
        perfNote("Batch: merged into the database", since: started)
        receivedFromPhone()
    }
    #endif

    /// Today as the person's day counts it (D7, WA5).
    var today: LocalDay { store.today() }
}
