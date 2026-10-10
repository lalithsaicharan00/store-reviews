#if DEBUG
import Core
import Foundation
import os

/// iCloud sync, checked against `FakeCloud` (Architecture 11 §19–20; `-cloudcheck`, `CloudSyncUITests`): simulated
/// devices, each with its own database and engine, sharing one fake iCloud. Every guard in §3 and every row of §7's error
/// table has a check here that fails without it, and the property test converges in every run with nothing lost.
/// `-cloudcheck-extreme` runs the extreme account (§14) on its own.
@MainActor
enum CloudSyncCheck {
    /// One simulated device: its database, its engine and its `CloudSync`; relaunched as the app would be.
    final class Device {
        let name: String
        let cloud: FakeCloud
        let repository: HabitRepository
        let identity: DeviceIdentity
        var transport: FakeCloudTransport
        var sync: CloudSync
        var plus: Bool
        var allowed = true
        var vendor: String

        init(_ name: String, cloud: FakeCloud, plus: Bool = true, repository: HabitRepository? = nil, vendor: String? = nil) {
            self.name = name
            self.cloud = cloud
            self.plus = plus
            self.repository = repository ?? Persistence.inMemory().repository
            identity = DeviceIdentity(fixedID: "device-" + name)
            self.vendor = vendor ?? "vendor-" + name
            transport = FakeCloudTransport(cloud: cloud)
            sync = CloudSync(repository: self.repository, transport: transport, identity: identity)
            wire()
        }

        private func wire() {
            sync.isPlus = { [unowned self] in plus }
            sync.sendingAllowed = { [unowned self] in allowed }
            sync.vendorID = { [unowned self] in vendor }
            sync.habitCount = { 0 }
        }

        /// The app quits and opens again: a new engine and `CloudSync` over the same database (its saved state).
        func relaunch() {
            transport.stop()
            transport = FakeCloudTransport(cloud: cloud)
            sync = CloudSync(repository: repository, transport: transport, identity: identity)
            wire()
        }

        func start() async {
            await sync.start()
            await sync.idle()
        }

        func syncNow() async {
            await sync.syncNow()
            await sync.idle()
        }

        func counts() async -> CloudCounts? { try? await repository.cloud.counts() }
        func waiting() async -> Int { Int(await counts()?.waitingRows ?? -1) }

        // Changes, as the app makes them (through the repository, in one transaction each).

        func addHabit(_ id: String, name: String = "Water") async {
            var habit = Habit(name: name, symbol: "drop", color: .blue, kind: .amount(unit: "glasses", increment: 1), goal: 8)
            habit.id = UUID(uuidString: id) ?? UUID()
            try? await repository.saveHabit(habit: habit.record(position: 0), steps: [], reminders: [], at: Date.now.millis)
        }

        func rename(_ id: String, to name: String) async {
            guard let record = try? await repository.load().habits.first(where: { $0.id == id }) else { return }
            try? await repository.saveHabit(habit: Self.copy(record, name: name), steps: [], reminders: [], at: Date.now.millis)
        }

        func deleteHabit(_ id: String) async {
            guard let record = try? await repository.load().habits.first(where: { $0.id == id }) else { return }
            try? await repository.saveHabit(habit: Self.copy(record, deletedAt: Date.now.millis), steps: [], reminders: [], at: Date.now.millis)
        }

        func log(_ id: String, habit: String, value: Double = 1) async {
            let entry = EntryRecord(id: id, habitId: habit, stepId: nil, day: "2026-10-01", value: value, createdAt: Date.now.millis,
                                    timeZone: "Europe/London", deletedAt: nil, slot: nil, source: "today")
            try? await repository.addEntry(entry: entry)
        }

        func undo(_ id: String) async { try? await repository.removeEntry(id: id, at: Date.now.millis) }

        /// Everything on the device, tombstones included, in a comparable form.
        func state() async -> [String] {
            guard let all = try? await repository.loadForRestore() else { return ["unreadable"] }
            var lines = all.habits.map { "h \($0.id) \($0.name) \($0.goal) \($0.deletedAt == nil ? "live" : "deleted")" }
            lines += all.entries.map { "e \($0.id) \($0.value) \($0.deletedAt == nil ? "live" : "deleted")" }
            lines += all.settings.map { "s \($0.key)=\($0.value)" }
            return lines.sorted()
        }

        func liveEntries() async -> Int { (try? await repository.load().entries.count) ?? -1 }

        static func copy(_ r: HabitRecord, name: String? = nil, deletedAt: Int64? = nil) -> HabitRecord {
            HabitRecord(id: r.id, name: name ?? r.name, symbol: r.symbol, color: r.color, kind: r.kind, unit: r.unit, increment: r.increment,
                        part: r.part, goal: r.goal, period: r.period, scheduleDays: r.scheduleDays, frequency: r.frequency, dueDay: r.dueDay,
                        dueMinute: r.dueMinute, atMost: r.atMost, quitSince: r.quitSince, position: r.position, createdAt: r.createdAt,
                        updatedAt: Date.now.millis, archivedAt: r.archivedAt, deletedAt: deletedAt.map { KotlinLong(value: $0) } ?? r.deletedAt,
                        remind: r.remind, alert: r.alert, followUpMinutes: r.followUpMinutes, startsOn: r.startsOn, endsOn: r.endsOn,
                        reminderText: r.reminderText)
        }
    }

    private static func id(_ n: Int) -> String { String(format: "00000000-0000-4000-8000-%012d", n) }

    static func run() async -> [String] {
        var failures: [String] = []
        for (name, check) in checks {
            let found = await check()
            failures += found.map { "\(name): \($0)" }
        }
        return failures
    }

    static let checks: [(String, @MainActor () async -> [String])] = [
        ("two devices", twoDevices),
        ("outbox", outboxShrinksOnlyOnConfirmedSaves),
        ("limits and errors", limitsAndErrors),
        ("zones", zonesRemovedNeverDeleteHere),
        ("accounts", accountsNeverDeleteHere),
        ("brake", brakeBothWays),
        ("free plan", freePlanHandover),
        ("fresh install", freshInstallWaits),
        ("delete from iCloud", deleteFromICloud),
        ("clone", cloneGetsItsOwnNode),
        ("restarts", crashesAndLostState),
        ("property", randomInterleavingsConverge),
    ]

    // MARK: The checks

    static func twoDevices() async -> [String] {
        var failures: [String] = []
        let cloud = FakeCloud()
        let phone = Device("phone", cloud: cloud), iPad = Device("ipad", cloud: cloud)
        await phone.start(); await iPad.start()
        await phone.addHabit(id(1))
        await phone.log(id(101), habit: id(1))
        await phone.syncNow()
        await iPad.syncNow()
        if await phone.state() != iPad.state() { failures.append("the iPad has what the phone made") }
        // Both offline, the same habit changed on each: both changes merge.
        await iPad.rename(id(1), to: "Tea")
        await phone.log(id(102), habit: id(1))
        await phone.syncNow(); await iPad.syncNow(); await phone.syncNow()
        let a = await phone.state(), b = await iPad.state()
        if a != b { failures.append("converged (\(a.count) vs \(b.count) lines)") }
        if !a.contains(where: { $0.contains("Tea") }) || !a.contains(where: { $0.contains(id(102)) }) { failures.append("both changes kept") }
        let phoneWaiting = await phone.waiting(), iPadWaiting = await iPad.waiting()
        if phoneWaiting != 0 || iPadWaiting != 0 { failures.append("nothing left waiting") }
        if phone.sync.phase != .on { failures.append("phase on (\(phone.sync.phase))") }
        return failures
    }

    /// §7: a change leaves the outbox only when CloudKit confirms a record that holds it.
    static func outboxShrinksOnlyOnConfirmedSaves() async -> [String] {
        var failures: [String] = []
        let cloud = FakeCloud()
        let phone = Device("phone", cloud: cloud)
        await phone.start()
        await phone.addHabit(id(1))
        for n in 0..<3 { await phone.log(id(200 + n), habit: id(1)) }
        let before = await phone.waiting()
        cloud.loseNetworkAfter = 2 // two saved in iCloud, the answer never arrives
        await phone.syncNow()
        let v1 = await phone.waiting()
        if v1 != before { failures.append("nothing leaves without an answer (\(before) → \(v1))") }
        if cloud.rows().count != 2 { failures.append("the two saves did reach iCloud (\(cloud.rows().count))") }
        await phone.syncNow()
        await phone.syncNow()
        let v2 = await phone.waiting()
        if v2 != 0 { failures.append("all confirmed in the end (\(v2))") }
        if cloud.rows().count != 4 { failures.append("iCloud has all four (\(cloud.rows().count))") }
        if phone.sync.debugInflight != 0 { failures.append("no record left in flight (\(phone.sync.debugInflight))") }
        return failures
    }

    /// §4 and §7's table: 250 a request, conflicts, a full iCloud, throttling, zoneNotFound, unknownItem, invalid
    /// records, records too large.
    static func limitsAndErrors() async -> [String] {
        var failures: [String] = []
        let cloud = FakeCloud()
        let phone = Device("phone", cloud: cloud), iPad = Device("ipad", cloud: cloud)
        await phone.start(); await iPad.start()
        await phone.addHabit(id(1))
        for n in 0..<599 { await phone.log(id(1_000 + n), habit: id(1)) }
        let requests = cloud.requests
        await phone.syncNow()
        if cloud.requests - requests != 3 { failures.append("600 records go in 3 requests of at most 250 (\(cloud.requests - requests))") }
        if cloud.rows().count != 600 { failures.append("all 600 in iCloud (\(cloud.rows().count))") }

        // A conflict: iCloud has a newer copy; it's merged and sent again.
        await iPad.syncNow()
        cloud.conflictOnce = ["habit:" + id(1)]
        await iPad.rename(id(1), to: "Conflicted")
        await iPad.syncNow()
        if await iPad.waiting() != 0 { failures.append("a conflict is merged and sent again") }
        await phone.syncNow()
        if !(await phone.state()).contains(where: { $0.contains("Conflicted") }) { failures.append("the merged change reaches the phone") }

        // iCloud full: nothing is lost, nothing is retried until asked, then it all goes.
        cloud.full = true
        await phone.log(id(2_000), habit: id(1))
        await phone.syncNow()
        if !phone.sync.isFull { failures.append("iCloud full is said") }
        if await phone.waiting() != 1 { failures.append("the change waits in the outbox while iCloud is full") }
        if !CloudStatus.of(phone.sync, isPlus: true).title.contains("full") { failures.append("the page says iCloud is full") }
        cloud.full = false
        await phone.syncNow()
        let afterRoom = await phone.waiting()
        if phone.sync.isFull || afterRoom != 0 { failures.append("once there's room, it goes") }

        // Throttled: nothing is lost; the next send goes.
        cloud.throttleSends = 1
        await phone.log(id(2_001), habit: id(1))
        await phone.syncNow()
        if await phone.waiting() != 1 { failures.append("throttled: still waiting") }
        await phone.syncNow()
        if await phone.waiting() != 0 { failures.append("after the wait, sent") }

        // The zone is missing with no deletion said (never made, or lost): made again, everything sent again.
        cloud.space?.habitsZone = false
        cloud.space?.rows = [:]
        cloud.space?.feed = [:]
        await phone.log(id(2_002), habit: id(1))
        await phone.syncNow()
        await phone.syncNow()
        let live = (try? await phone.repository.loadForRestore()).map { $0.habits.count + $0.entries.count } ?? -1
        if cloud.rows().count != live { failures.append("a missing zone: everything here goes up again (\(cloud.rows().count) of \(live))") }

        // unknownItem: a record gone from iCloud while this device kept its system fields: saved again as new.
        cloud.space?.rows["entry:" + id(1_000)] = nil
        await phone.undo(id(1_000))
        await phone.syncNow()
        let afterUnknown = await phone.waiting()
        if cloud.rows()["entry:" + id(1_000)] == nil || afterUnknown != 0 { failures.append("unknownItem: saved again as a new record") }

        // A record iCloud refuses: kept aside, said, never retried forever, never dropped.
        cloud.invalid = ["entry:" + id(2_003)]
        await phone.log(id(2_003), habit: id(1))
        await phone.syncNow()
        await phone.syncNow()
        if phone.sync.keptAside != 1 { failures.append("a refused record is kept aside (\(phone.sync.keptAside))") }
        if !(await phone.state()).contains(where: { $0.contains(id(2_003)) }) { failures.append("and stays on the phone") }

        // A record over 256 KB: refused before sending, kept aside.
        try? await phone.repository.saveSetting(key: "daynote.2026-10-01", value: String(repeating: "a", count: 300 * 1024))
        await phone.syncNow()
        if phone.sync.keptAside != 2 { failures.append("a record too large is kept aside (\(phone.sync.keptAside))") }
        return failures
    }

    /// §11: the person deleted the app's iCloud data, or keys were reset: nothing here is deleted.
    static func zonesRemovedNeverDeleteHere() async -> [String] {
        var failures: [String] = []
        let cloud = FakeCloud()
        let phone = Device("phone", cloud: cloud)
        await phone.start()
        await phone.addHabit(id(1))
        for n in 0..<10 { await phone.log(id(300 + n), habit: id(1)) }
        await phone.syncNow()
        let before = await phone.state()

        cloud.deleteZones(.purged)
        await phone.syncNow()
        if phone.sync.phase != .asking(.removed) { failures.append("purged: asks first (\(phone.sync.phase))") }
        if await phone.state() != before { failures.append("purged: nothing here is deleted") }
        if !cloud.rows().isEmpty { failures.append("purged: nothing is uploaded before the answer") }
        phone.relaunch()
        await phone.start()
        if phone.sync.phase != .asking(.removed) { failures.append("the question survives a relaunch") }
        await phone.sync.backUpAgain()
        await phone.sync.idle()
        await phone.syncNow()
        if cloud.rows().count != 11 { failures.append("Back Up Again: everything goes up again (\(cloud.rows().count))") }

        cloud.deleteZones(.encryptedDataReset)
        await phone.syncNow()
        await phone.syncNow()
        if phone.sync.phase != .on || cloud.rows().count != 11 { failures.append("keys reset: the zone is made again and everything uploaded (\(cloud.rows().count))") }
        if await phone.state() != before { failures.append("keys reset: nothing here changes") }
        return failures
    }

    /// §10: signing out, back in, another Apple Account: nothing deleted; another account asks first.
    static func accountsNeverDeleteHere() async -> [String] {
        var failures: [String] = []
        let cloud = FakeCloud(user: "alice")
        let phone = Device("phone", cloud: cloud)
        await phone.start()
        await phone.addHabit(id(1))
        await phone.log(id(400), habit: id(1))
        await phone.syncNow()
        let before = await phone.state()

        await cloud.signOut()
        await phone.sync.idle()
        if phone.sync.phase != .off(.noAccount) { failures.append("signed out: iCloud is off (\(phone.sync.phase))") }
        if await phone.state() != before { failures.append("signed out: nothing deleted") }
        await phone.log(id(401), habit: id(1))
        if await phone.waiting() != 1 { failures.append("signed out: changes keep waiting") }

        await cloud.signIn("alice")
        phone.sync.appBecameActive()
        await phone.sync.idle()
        await phone.syncNow()
        let backIn = await phone.waiting()
        if backIn != 0 || cloud.rows()["entry:" + id(401)] == nil { failures.append("back in: what waited goes") }

        await cloud.signOut()
        await phone.sync.idle()
        await cloud.signIn("bob")
        phone.sync.appBecameActive()
        await phone.sync.idle()
        if case .asking(.differentAccount) = phone.sync.phase {} else { failures.append("another Apple Account: asks first (\(phone.sync.phase))") }
        if !cloud.rows().isEmpty { failures.append("another Apple Account: nothing uploaded before the answer") }
        if (await phone.state()).count != before.count + 1 { failures.append("another Apple Account: nothing deleted") }
        await phone.sync.keepOnThisIPhoneOnly()
        if phone.sync.phase != .off(.turnedOff) || !cloud.rows().isEmpty { failures.append("Keep on This iPhone Only: nothing goes") }
        await phone.sync.turnOn()
        await phone.sync.idle()
        if case .asking(.differentAccount) = phone.sync.phase {} else { failures.append("turned on again: asks again") }
        await phone.sync.addToThisAccount()
        await phone.sync.idle()
        await phone.syncNow()
        if cloud.rows().count != 3 { failures.append("Add to This Account's iCloud: everything here goes (\(cloud.rows().count))") }
        return failures
    }

    /// §13.2: too many deletes at once, either way, wait for the person.
    static func brakeBothWays() async -> [String] {
        var failures: [String] = []
        let cloud = FakeCloud()
        let phone = Device("phone", cloud: cloud), iPad = Device("ipad", cloud: cloud)
        await phone.start(); await iPad.start()
        await phone.addHabit(id(1))
        for n in 0..<100 { await phone.log(id(500 + n), habit: id(1)) }
        await phone.syncNow(); await iPad.syncNow()
        // A bug takes back 60 logs on the phone.
        for n in 0..<60 { await phone.undo(id(500 + n)) }
        await phone.syncNow()
        if phone.sync.outgoingDeletes != 60 { failures.append("outgoing: 60 deletes wait (\(phone.sync.outgoingDeletes))") }
        let liveInICloud = cloud.rows().values.filter { $0.table == "entry" && $0.fields.contains("\"deleted_at\":null") }.count
        if liveInICloud != 100 { failures.append("outgoing: iCloud still has all 100 (\(liveInICloud))") }
        await phone.sync.sendWaitingDeletes()
        await phone.sync.idle()
        if await phone.waiting() != 0 { failures.append("outgoing: sent once the person says") }
        await iPad.syncNow()
        if iPad.sync.heldDeletes == 0 { failures.append("incoming: held") }
        let kept = await iPad.liveEntries()
        if kept < 80 { failures.append("incoming: at most 20% went before the hold (\(kept) left)") }
        if !CloudStatus.of(iPad.sync, isPlus: true).needsYou { failures.append("incoming: the page asks") }
        await iPad.sync.applyHeldChanges()
        await iPad.sync.idle()
        let v3 = await iPad.liveEntries()
        if v3 != 40 { failures.append("incoming: applied when the person says (\(v3))") }
        if await phone.state() != iPad.state() { failures.append("the two devices agree afterwards") }
        return failures
    }

    /// §12: free, one syncing device; Move Here; the old device sends what it has first.
    static func freePlanHandover() async -> [String] {
        var failures: [String] = []
        let cloud = FakeCloud()
        let phone = Device("phone", cloud: cloud, plus: false), iPad = Device("ipad", cloud: cloud, plus: false)
        await phone.start()
        await phone.addHabit(id(1))
        await phone.log(id(600), habit: id(1))
        await phone.syncNow()
        if cloud.space?.active?.deviceID != phone.identity.deviceID { failures.append("the first device is the one syncing") }
        // The phone goes offline and logs; the iPad opens.
        phone.transport.offline = true
        await phone.log(id(601), habit: id(1))
        await phone.syncNow()
        await iPad.start()
        if case .otherDevice = iPad.sync.phase {} else { failures.append("the iPad doesn't sync while the phone is the one (\(iPad.sync.phase))") }
        if iPad.sync.secondDevice == nil { failures.append("the iPad asks (the second-device sheet)") }
        if await iPad.liveEntries() != 0 { failures.append("nothing comes down before Move Here") }
        if !(await iPad.sync.moveHere()) { failures.append("Move Here") }
        await iPad.sync.idle()
        let v4 = await iPad.liveEntries()
        if v4 != 1 { failures.append("after Move Here, what's in iCloud comes (\(v4))") }
        // The phone comes back: it sends its earlier change first, then stops.
        phone.transport.offline = false
        await phone.syncNow()
        if case .otherDevice = phone.sync.phase {} else { failures.append("the phone stops syncing (\(phone.sync.phase))") }
        if cloud.rows()["entry:" + id(601)] == nil { failures.append("the phone's unsent change reached iCloud before it stopped") }
        if phone.sync.handedOverTo == nil { failures.append("the phone says where its habits sync now") }
        await phone.log(id(602), habit: id(1))
        await phone.syncNow()
        if cloud.rows()["entry:" + id(602)] != nil { failures.append("a later change on the old device stays on it") }
        if await phone.waiting() != 1 { failures.append("and waits there, never lost") }
        await iPad.syncNow()
        let v5 = await iPad.liveEntries()
        if v5 != 2 { failures.append("the iPad has the phone's earlier change (\(v5))") }
        // Two free devices both thinking they're the one: the first to reach iCloud keeps it.
        let stale = CloudActive(deviceID: "nobody", name: "iPhone", at: .distantPast, system: Data("old".utf8))
        do { _ = try await phone.transport.claimActive(phone.sync.active ?? stale, expected: stale); failures.append("a stale claim loses") } catch {}
        return failures
    }

    /// §13.1: a fresh install looks in iCloud first and sends nothing until its welcome is finished.
    static func freshInstallWaits() async -> [String] {
        var failures: [String] = []
        let cloud = FakeCloud()
        let old = Device("old", cloud: cloud)
        await old.start()
        await old.addHabit(id(1))
        for n in 0..<5 { await old.log(id(700 + n), habit: id(1)) }
        await old.syncNow()
        let fresh = Device("fresh", cloud: cloud)
        fresh.allowed = false
        await fresh.start()
        if !fresh.sync.firstLookDone { failures.append("a fresh install looks in iCloud") }
        let v6 = await fresh.liveEntries()
        if v6 != 5 { failures.append("and brings the habits (\(v6))") }
        await fresh.addHabit(id(2), name: "Started fresh")
        await fresh.syncNow()
        if cloud.rows()["habit:" + id(2)] != nil { failures.append("nothing is sent before the welcome is finished") }
        fresh.allowed = true
        await fresh.syncNow()
        if cloud.rows()["habit:" + id(2)] == nil { failures.append("afterwards it goes") }
        return failures
    }

    /// §17: Delete My Data From iCloud removes the zones; this device keeps everything; the others ask.
    static func deleteFromICloud() async -> [String] {
        var failures: [String] = []
        let cloud = FakeCloud()
        let phone = Device("phone", cloud: cloud), iPad = Device("ipad", cloud: cloud)
        await phone.start(); await iPad.start()
        await phone.addHabit(id(1))
        await phone.log(id(800), habit: id(1))
        await phone.syncNow(); await iPad.syncNow()
        let before = await phone.state()
        do { try await phone.sync.deleteEverythingFromICloud() } catch { failures.append("deleted (\(error))") }
        if !cloud.rows().isEmpty { failures.append("iCloud's copy is gone") }
        if await phone.state() != before { failures.append("this device keeps everything") }
        if phone.sync.phase != .off(.deleted) { failures.append("and stops syncing") }
        await phone.log(id(801), habit: id(1))
        await phone.syncNow()
        if !cloud.rows().isEmpty { failures.append("nothing goes up again until turned on") }
        await iPad.syncNow()
        if iPad.sync.phase != .asking(.removed) { failures.append("another device asks before backing up again (\(iPad.sync.phase))") }
        if await iPad.state() != before { failures.append("another device keeps everything") }
        await phone.sync.turnOn()
        await phone.sync.idle()
        await phone.syncNow()
        if cloud.rows().count != 3 { failures.append("turned on again: everything goes up (\(cloud.rows().count))") }
        return failures
    }

    /// §13.4: a device restored from another's backup gets its own clock node.
    static func cloneGetsItsOwnNode() async -> [String] {
        var failures: [String] = []
        let folder = FileManager.default.temporaryDirectory.appending(path: "clone-\(UUID().uuidString)", directoryHint: .isDirectory)
        try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: folder) }
        let cloud = FakeCloud()
        guard let original = try? HabitRepository.companion.open(path: folder.appending(path: "a.db").path) else { return ["open"] }
        let phone = Device("phone", cloud: cloud, repository: original, vendor: "vendor-A")
        await phone.start()
        await phone.addHabit(id(1))
        await phone.syncNow()
        try? await original.snapshot(path: folder.appending(path: "b.db").path)
        guard let copy = try? HabitRepository.companion.open(path: folder.appending(path: "b.db").path) else { return ["copy"] }
        let a = try? await original.cloud.node(), copied = try? await copy.cloud.node()
        if a == nil || a != copied { failures.append("the copy carries the same node, as a restored iPhone would") }
        let clone = Device("clone", cloud: cloud, repository: copy, vendor: "vendor-B")
        await clone.start()
        let b = try? await copy.cloud.node()
        if b == nil || b == a { failures.append("a different device: a new node") }
        let again = try? await original.cloud.node()
        let same = Device("phone2", cloud: cloud, repository: original, vendor: "vendor-A")
        await same.start()
        if (try? await original.cloud.node()) != again { failures.append("the same device keeps its node") }
        try? original.close()
        try? copy.close()
        return failures
    }

    /// §8–9: the app dying between applying a page and saving the engine's state; a lost state; pages twice and out of order.
    static func crashesAndLostState() async -> [String] {
        var failures: [String] = []
        let cloud = FakeCloud()
        cloud.pageSize = 7
        let phone = Device("phone", cloud: cloud), iPad = Device("ipad", cloud: cloud)
        await phone.start()
        await phone.addHabit(id(1))
        for n in 0..<40 { await phone.log(id(900 + n), habit: id(1)) }
        await phone.syncNow()
        cloud.dieAfterApplying = true
        await iPad.start()
        iPad.relaunch()
        await iPad.start()
        await iPad.syncNow()
        if await phone.state() != iPad.state() { failures.append("after dying between apply and save: the same, nothing doubled") }
        try? await iPad.repository.cloud.setState(key: "engine", value: nil)
        iPad.relaunch()
        await iPad.start()
        await iPad.syncNow()
        let lostA = await phone.state(), lostB = await iPad.state(), lostWaiting = await iPad.waiting()
        if lostA != lostB || lostWaiting != 0 { failures.append("a lost engine state: everything again, nothing sent back") }
        cloud.deliverTwice = true
        cloud.outOfOrder = true
        for n in 0..<10 { await phone.undo(id(900 + n)) }
        await phone.sync.sendWaitingDeletes()
        await phone.syncNow()
        await iPad.syncNow()
        if iPad.sync.heldDeletes > 0 { await iPad.sync.applyHeldChanges(); await iPad.sync.idle() }
        if await phone.state() != iPad.state() { failures.append("pages twice and out of order: the same") }
        return failures
    }

    /// §19's property test: three devices, random changes, random faults, many runs; every run converges and nothing
    /// made anywhere is lost.
    static func randomInterleavingsConverge() async -> [String] {
        var failures: [String] = []
        for seed in 0..<12 {
            var random = SeededRandom(seed: UInt64(seed + 1))
            let cloud = FakeCloud()
            cloud.pageSize = 5
            let devices = ["p", "i", "w"].map { Device("\($0)\(seed)", cloud: cloud) }
            for device in devices { await device.start() }
            var made: Set<String> = []
            var counter = 0
            for _ in 0..<8 {
                for device in devices {
                    for _ in 0..<Int.random(in: 0...3, using: &random) {
                        counter += 1
                        let habit = id(Int.random(in: 1...3, using: &random))
                        switch Int.random(in: 0..<6, using: &random) {
                        case 0: await device.addHabit(habit, name: "\(device.name)-\(counter)")
                        case 1: await device.rename(habit, to: "\(device.name)-\(counter)")
                        case 2, 3:
                            let entry = id(10_000 + seed * 1_000 + counter)
                            await device.log(entry, habit: habit)
                            made.insert(entry)
                        case 4:
                            if let entry = made.randomElement(using: &random) { await device.undo(entry) }
                        default:
                            if Int.random(in: 0..<4, using: &random) == 0 { await device.deleteHabit(habit) }
                        }
                    }
                    switch Int.random(in: 0..<7, using: &random) {
                    case 0: cloud.loseNetworkAfter = Int.random(in: 0...2, using: &random)
                    case 1: cloud.conflictOnce = Set(cloud.rows().keys.shuffled(using: &random).prefix(2))
                    case 2: cloud.dieAfterApplying = true
                    case 3: cloud.throttleSends = 1
                    case 4: cloud.deliverTwice = Bool.random(using: &random); cloud.outOfOrder = Bool.random(using: &random)
                    default: break
                    }
                    if Int.random(in: 0..<3, using: &random) > 0 { await device.syncNow() }
                    if device.transport.died { device.relaunch(); await device.start() }
                    if Int.random(in: 0..<10, using: &random) == 0 {
                        try? await device.repository.cloud.setState(key: "engine", value: nil)
                        device.relaunch()
                        await device.start()
                    }
                }
            }
            cloud.loseNetworkAfter = nil
            cloud.conflictOnce = []
            cloud.dieAfterApplying = false
            cloud.throttleSends = 0
            for _ in 0..<3 {
                for device in devices {
                    if device.transport.died { device.relaunch(); await device.start() }
                    if device.sync.outgoingDeletes > 0 { await device.sync.sendWaitingDeletes() }
                    if device.sync.heldDeletes > 0 { await device.sync.applyHeldChanges() }
                    await device.syncNow()
                }
            }
            let expected = await devices[0].state()
            for device in devices.dropFirst() {
                let state = await device.state()
                if state != expected { failures.append("seed \(seed): \(device.name) differs") }
            }
            for device in devices {
                let left = await device.waiting()
                if left != 0 { failures.append("seed \(seed): \(device.name) still has \(left) waiting") }
            }
            let everywhere = Set(expected.filter { $0.hasPrefix("e ") }.map { String($0.split(separator: " ")[1]) })
            if !made.isSubset(of: everywhere) { failures.append("seed \(seed): lost \(made.subtracting(everywhere).count) logs") }
        }
        return failures
    }

    // MARK: The extreme account (§14), on its own: `-cloudcheck-extreme`

    /// 25,000 logs a year for 15 years and 60 habits: up in requests of 250 across a relaunch, down on a new device.
    static func extremeAccount() async -> (failures: [String], summary: String) {
        var failures: [String] = []
        let cloud = FakeCloud()
        cloud.pageSize = 400
        let phone = Device("phone", cloud: cloud), iPad = Device("ipad", cloud: cloud)
        await phone.start()
        let count = 375_000
        var habits: [HabitRecord] = []
        for n in 0..<60 {
            var habit = Habit(name: "Habit \(n)", symbol: "drop", color: .blue, kind: .check, goal: 1)
            habit.id = UUID(uuidString: id(n)) ?? UUID()
            habits.append(habit.record(position: n))
        }
        var entries: [EntryRecord] = []
        entries.reserveCapacity(count)
        let start = Int64(1_317_427_200_000)
        for n in 0..<count {
            entries.append(EntryRecord(id: String(format: "e-%07d", n), habitId: id(n % 60), stepId: nil, day: "2026-10-01", value: 1,
                                       createdAt: start + Int64(n) * 1_260_000, timeZone: "Europe/London", deletedAt: nil, slot: nil, source: "today"))
        }
        let clock = ContinuousClock()
        let began = clock.now
        try? await phone.repository.importAll(snapshot: Snapshot(habits: habits, steps: [], reminders: [], entries: entries, settings: []))
        entries = []
        let imported = clock.now
        let requests = cloud.requests
        await phone.syncNow()
        // The app quits half-way through a first upload and carries on (§14).
        phone.relaunch()
        await phone.start()
        for _ in 0..<20 where await phone.waiting() > 0 { await phone.syncNow() }
        let uploaded = clock.now
        if cloud.rows().count != count + 60 { failures.append("all up (\(cloud.rows().count))") }
        let used = cloud.requests - requests
        if used > (count + 60) / 250 + 20 { failures.append("in requests of 250 (\(used))") }
        await iPad.start()
        await iPad.syncNow()
        let fetched = clock.now
        let v7 = await iPad.liveEntries()
        if v7 != count { failures.append("all down (\(v7))") }
        // Room to spare before iOS would stop the app for its memory.
        let headroom = os_proc_available_memory() / 1_048_576
        if headroom > 0 && headroom < 200 { failures.append("memory headroom \(headroom) MB") }
        let summary = "import \(imported - began), upload \(uploaded - imported) in \(used) requests, fetch \(fetched - uploaded), \(headroom) MB headroom"
        if uploaded - imported > .seconds(25 * 60) || fetched - uploaded > .seconds(25 * 60) { failures.append("time: \(summary)") }
        return (failures, summary)
    }
}

/// A seeded generator, so a failing run can be repeated exactly.
nonisolated struct SeededRandom: RandomNumberGenerator {
    private var state: UInt64
    init(seed: UInt64) { state = seed &* 0x9E37_79B9_7F4A_7C15 }
    mutating func next() -> UInt64 {
        state &+= 0x9E37_79B9_7F4A_7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58_476D_1CE4_E5B9
        z = (z ^ (z >> 27)) &* 0x94D0_49BB_1331_11EB
        return z ^ (z >> 31)
    }
}
#endif
