#if DEBUG
import Core
import Foundation

/// Test launches' iCloud (Rulebook D8: never the person's). Every test launch (`-uitest`, `-dbname`) gets `FakeCloud`,
/// signed out, so iCloud is off and nothing about sync shows; `-test-cloud <state>` puts it in a state for the iCloud
/// page's UI tests (Architecture 11 §19), through the real code wherever it can:
///
/// - `synced`, `waiting` (offline), `full`, `off`, `restricted`, `removed` (the habits were removed from iCloud),
///   `other-account` (this database synced with another Apple Account), `free-this` / `free-other` (with `-free`: this
///   device, or an iPad, is the one syncing), `plus` (an iPad syncs too);
/// - `has-habits`: another device's habits already in iCloud (a fresh install's welcome brings them back);
/// - `bringing`, `held`, `brake`: shown as they'd be (the logic behind them is `CloudSyncCheck`'s).
@MainActor
enum CloudTestStates {
    private(set) static var fake: FakeCloud?

    private static func value(after flag: String, in arguments: [String]) -> String? {
        arguments.firstIndex(of: flag).flatMap { $0 + 1 < arguments.count ? arguments[$0 + 1] : nil }
    }

    static var state: String? { value(after: "-test-cloud", in: ProcessInfo.processInfo.arguments) }

    static func transport(_ arguments: [String]) -> CloudTransport {
        let state = value(after: "-test-cloud", in: arguments)
        let signedIn = state.map { !["off", "restricted"].contains($0) } ?? false
        let cloud = FakeCloud(user: signedIn ? "test-user" : nil)
        if state == "restricted" { cloud.statusWhenSignedOut = .restricted }
        fake = cloud
        return FakeCloudTransport(cloud: cloud)
    }

    /// Before iCloud starts at launch: what the state needs to be true.
    static func prepareIfAsked(cloud: CloudSync?, repository: HabitRepository?) async {
        guard let state, let fake, let cloud, let repository else { return }
        switch state {
        case "waiting":
            fake.offline = true
        case "full":
            fake.full = true
        case "free-other":
            _ = try? fake.claim(CloudActive(deviceID: "other-ipad", name: "iPad", at: .now, system: nil), expected: nil)
            try? fake.saveDevice(CloudDevice(id: "other-ipad", name: "iPad", platform: "ipados", lastSync: .now, habits: 12))
        case "plus":
            try? fake.saveDevice(CloudDevice(id: "other-ipad", name: "iPad", platform: "ipados", lastSync: .now.addingTimeInterval(-3600), habits: 12))
        case "other-account":
            try? await repository.cloud.bind(account: "icloud:someone-before")
            try? fake.saveDevice(CloudDevice(id: "other-ipad", name: "iPad", platform: "ipados", lastSync: .now, habits: 14))
        case "removed":
            try? await repository.cloud.setState(key: "question", value: "removed")
        case "has-habits":
            // Another device's habits already in this Apple Account's iCloud (a reinstall, a new iPhone, §13.1).
            fake.seed(habitRows(["Read from iCloud", "Walk from iCloud"]))
        case "bringing", "held", "brake":
            fake.offline = true
            Task {
                await cloud.start()
                await cloud.idle()
                show(state)
            }
        default:
            break
        }
    }

    /// The iCloud page's states, for the speed runs (`icloud-states`).
    static let pageStates = ["synced", "waiting", "full", "off", "bringing", "free-other", "plus", "removed", "other-account", "held"]

    /// Shows the iCloud page as it is in `state`, without iCloud.
    static func show(_ state: String) {
        guard let cloud = AppModel.shared.cloud else { return }
        let now = Date.now
        let phone = CloudDevice(id: cloud.deviceID, name: DeviceIdentity.name, platform: DeviceIdentity.platform, lastSync: now, habits: 9)
        let iPad = CloudDevice(id: "other-ipad", name: "iPad", platform: "ipados", lastSync: now.addingTimeInterval(-3600), habits: 9)
        switch state {
        case "synced": cloud.setForTest(phase: .on, devices: [phone], lastSynced: now.addingTimeInterval(-30))
        case "waiting": cloud.setForTest(phase: .on, waiting: 3, devices: [phone])
        case "full": cloud.setForTest(phase: .on, waiting: 214, full: true, devices: [phone])
        case "off": cloud.setForTest(phase: .off(.noAccount))
        case "bringing": cloud.setForTest(phase: .on, bringingIn: 12_000, devices: [phone])
        case "free-other": cloud.setForTest(phase: .otherDevice(name: "iPad"))
        case "plus": cloud.setForTest(phase: .on, devices: [phone, iPad], lastSynced: now.addingTimeInterval(-30))
        case "removed": cloud.setForTest(phase: .asking(.removed))
        case "other-account": cloud.setForTest(phase: .asking(.differentAccount(iCloudHabits: 14)))
        case "held": cloud.setForTest(phase: .on, held: 120, devices: [phone])
        case "brake": cloud.setForTest(phase: .on, outgoing: 60, devices: [phone])
        default: break
        }
    }

    /// `Row` records for habits saved by another device: the fields a habit needs, each with one stamp.
    static func habitRows(_ names: [String]) -> [CloudRowRecord] {
        let clock = "000001790000000000-00000-otherdevice"
        return names.enumerated().map { i, name in
            let id = String(format: "00000000-0000-4000-9000-%012d", i + 1)
            let fields: [String: Any] = ["name": name, "symbol": "book.fill", "color": "orange", "kind": "check", "increment": 1.0,
                                         "part": "anytime", "goal": 1.0, "period": "day", "frequency": "daily", "at_most": false,
                                         "position": i, "created_at": 1_790_000_000_000 as Int64, "updated_at": 1_790_000_000_000 as Int64,
                                         "remind": true, "alert": "notification"]
            let json = (try? JSONSerialization.data(withJSONObject: fields, options: [.sortedKeys])).flatMap { String(data: $0, encoding: .utf8) } ?? "{}"
            let clocks = "{" + fields.keys.sorted().map { "\"\($0)\":\"\(clock)\"" }.joined(separator: ",") + "}"
            return CloudRowRecord(name: "habit:" + id, table: "habit", row: id, fields: json, clocks: clocks, schema: 9, format: 1, system: nil)
        }
    }

    // MARK: A big fetch, for the speed runs (`today-big-fetch`)

    /// Signs the test launch's iCloud in with `records` logs already there, and starts bringing them in (not waited for).
    static func startBigFetch(records: Int) async {
        guard let fake, let cloud = AppModel.shared.cloud else { return }
        await fake.signIn("perf-user")
        let habits = AppModel.shared.store.habits.filter { $0.kind != .task }.map { $0.id.uuidString }
        guard !habits.isEmpty else { return }
        let clock = "000001790000000000-00000-perfnode"
        var rows: [CloudRowRecord] = []
        rows.reserveCapacity(records)
        for i in 0..<records {
            let day = Date.now.addingTimeInterval(-Double(i % 365) * 86_400)
            let key = day.formatted(.iso8601.year().month().day())
            let fields = #"{"habit_id":"\#(habits[i % habits.count])","step_id":null,"day":"\#(key)","value":1.0,"created_at":\#(Int64(day.timeIntervalSince1970 * 1000)),"time_zone":"Europe/London","deleted_at":null,"slot":null,"source":"perf"}"#
            let names = ["habit_id", "step_id", "day", "value", "created_at", "time_zone", "deleted_at", "slot", "source"]
            let clocks = "{" + names.map { "\"\($0)\":\"\(clock)\"" }.joined(separator: ",") + "}"
            let id = String(format: "perf-%08d", i)
            rows.append(CloudRowRecord(name: "entry:" + id, table: "entry", row: id, fields: fields, clocks: clocks,
                                       schema: 9, format: 1, system: nil))
        }
        fake.seed(rows)
        cloud.appBecameActive()
    }

    static func finishBigFetch() async {
        await AppModel.shared.cloud?.idle()
    }
}
#endif
