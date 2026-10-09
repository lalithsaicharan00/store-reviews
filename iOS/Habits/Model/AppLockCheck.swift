#if DEBUG
import Core
import Foundation
import UserNotifications

/// App Lock and Hide Names Outside the App, checked in the app (`-applockcheck`, `AppLockUITests`; Current Work 58).
/// Runs on a test launch's own Keychain item and settings (D8). What it proves:
/// - the code: kept as a hash that checks the right code and refuses others; wrong codes wait 1, 5, 15 minutes, then
///   an hour; the right code clears the wait; nothing is ever erased;
/// - the 24-hour reset: waiting, ready, cancelled by the code; a clock set back (a restart) never shortens it;
/// - Face ID changed is noticed, and only the person's answer trusts the new set;
/// - names hidden outside the app: widgets (`WidgetCheck.discreetFailures`), reminders and alarms (own words,
///   "Reminder · 8:00", "3 reminders · 8:00", "Still open · 8:00", "+1", "Reminder" with previews off), Siri (no names,
///   no suggestions) and the timer's Live Activity (no name drawn); App Lock holds it on and turning the lock off gives
///   back the person's own choice.
@MainActor
enum AppLockCheck {
    static func run() async -> [String] {
        var failures: [String] = []
        func expect(_ value: Bool, _ name: String) { if !value { failures.append(name) } }
        let lock = AppModel.shared.lock

        // MARK: The code

        lock.turnOff()
        HideNames.setChosen(false)
        expect(lock.mode == .passcode && !AppLock.isEnabled, "Starts off, in iPhone-passcode mode")
        await lock.saveCode("246810")
        expect(lock.mode == .code && AppLock.isEnabled, "A saved code turns on code mode")
        expect(LockKeychain.vault.codeHash?.count == 32 && LockKeychain.vault.salt?.count == 16 && LockKeychain.vault.iterations >= 100_000,
               "The code is kept as a salted slow hash")
        expect(!String(decoding: (try? JSONEncoder().encode(LockKeychain.vault)) ?? Data(), as: UTF8.self).contains("246810"),
               "The code itself is never stored")
        expect(await LockKeychain.check("246810"), "The right code checks")
        expect(!(await LockKeychain.check("246811")), "A wrong code doesn't")

        // MARK: Wrong codes and their waits

        for _ in 0..<4 { await lock.enter("000000") }
        expect(lock.message == "That's not the code." && lock.waitText == nil, "Four wrong codes: no wait yet")
        await lock.enter("000000")
        expect(lock.waitText == "Try again in 1 minute.", "Five wrong codes in a row: 1 minute (\(lock.waitText ?? "none"))")
        await lock.enter("246810")
        expect(LockKeychain.vault.failures == 5, "While waiting, even the right code isn't taken")
        for (failures, expected) in [(5, "Try again in 5 minutes."), (6, "Try again in 15 minutes."), (7, "Try again in 1 hour."), (9, "Try again in 1 hour.")] {
            LockKeychain.update { $0.failures = failures; $0.waitEnds = nil }
            lock.bump()
            await lock.enter("000000")
            expect(lock.waitText == expected, "Wrong code \(failures + 1): \(expected) (\(lock.waitText ?? "none"))")
        }
        LockKeychain.update { $0.waitEnds = LockClock.now - 1 }
        lock.bump()
        await lock.enter("246810")
        expect(LockKeychain.vault.failures == 0 && lock.waitText == nil && !lock.isLocked, "The right code after the wait opens and clears the count")
        expect(LockKeychain.vault.codeHash != nil, "Nothing is erased by wrong codes")

        // MARK: The 24-hour reset

        LockKeychain.update { $0.askReset(at: Date.now) }
        lock.bump()
        expect(lock.resetWaiting && !lock.resetReady, "A reset asked for is waiting")
        LockKeychain.update { $0.resetCredited = LockVault.resetWait - 60 }
        expect(lock.resetWaiting, "23 h 59 min: still waiting")
        // The clock set back (the iPhone restarted, or a changed time can't reach this clock): never less time passed.
        let credited = LockKeychain.vault.resetCredited
        LockKeychain.update { $0.resetMark = LockClock.now + 10_000 }
        expect(LockKeychain.vault.resetElapsed >= credited, "A clock that went back never shortens the wait")
        LockKeychain.update { $0.resetCredited = LockVault.resetWait; $0.resetMark = LockClock.now }
        lock.bump()
        expect(lock.resetReady && lock.step == .resetReady, "After 24 hours the cover offers Choose a New Code")
        LockKeychain.update { $0.askReset(at: Date.now) }
        lock.bump()
        await lock.enter("246810")
        expect(LockKeychain.vault.resetAskedAt == nil && lock.message == "The code reset was cancelled.",
               "Typing the right code cancels a waiting reset, and says so")

        // MARK: Face ID changed

        LockKeychain.update { $0.trustedDomainState = Data("A".utf8); $0.faceIDOff = false }
        lock.bump()
        expect(!lock.faceIDChanged && lock.faceIDUsable, "The same set: Face ID opens it")
        LockKeychain.update { $0.trustedDomainState = Data("B".utf8) }
        lock.bump()
        expect(lock.faceIDChanged && !lock.faceIDUsable, "A changed set: Face ID stops until the code")
        await lock.enter("246810")
        expect(lock.askTrustFaceID, "After the code: Use Face ID again?")
        lock.askTrustFaceID = false
        expect(LockKeychain.vault.trustedDomainState == Data("B".utf8), "The new set isn't trusted until the person says so")
        lock.trustFaceID(false)
        expect(lock.faceIDOff && !lock.faceIDUsable && !lock.faceIDChanged, "Keep Face ID Off: only the code opens it")
        lock.trustFaceID(true)
        expect(!lock.faceIDOff && lock.faceIDUsable, "Use Face ID Again trusts the set as it is now")

        // MARK: Hide names, held on by the lock

        HideNames.setChosen(false)
        expect(HideNames.isOn, "App Lock holds names hidden")
        lock.removeCode()
        AppLock.setEnabled(true)
        expect(lock.mode == .passcode && AppLock.isEnabled && HideNames.isOn, "Back to the iPhone passcode: still locked, names still hidden")
        lock.turnOff()
        expect(!HideNames.isOn, "Turning the lock off gives back the person's choice (off)")
        HideNames.setChosen(true)
        AppLock.setEnabled(true)
        lock.turnOff()
        expect(HideNames.isOn, "Turning the lock off gives back the person's choice (on)")

        // MARK: Everything outside the app, with names hidden

        var utc = Calendar(identifier: .gregorian); utc.timeZone = TimeZone(secondsFromGMT: 0)!
        let store = HabitStore(repository: Persistence.inMemory().repository, calendar: utc)
        await store.load()
        await WidgetFixture.install(in: store)
        let day = store.today()
        let start = day.adding(days: -5, calendar: utc)
        let meds = Habit(name: "Secret meds", symbol: "pills", color: .red, kind: .check,
                         reminders: [ReminderTime(hour: 8, minute: 0)], remind: true, followUpMinutes: 15, startsOn: start,
                         reminderText: "The usual")
        let water = Habit(name: "Private water", symbol: "drop", color: .blue, kind: .amount(unit: "glasses", increment: 1), goal: 8,
                          reminders: [ReminderTime(hour: 9, minute: 0)], remind: true, startsOn: start)
        let walk = Habit(name: "Hidden walk", symbol: "figure.walk", color: .green, kind: .check,
                         reminders: [ReminderTime(hour: 9, minute: 0)], remind: true, startsOn: start)
        let read = Habit(name: "Quiet reading", symbol: "book", color: .orange, kind: .check,
                         reminders: [ReminderTime(hour: 9, minute: 0)], remind: true, startsOn: start)
        for habit in [meds, water, walk, read] { store.add(habit) }
        await store.flush()
        let names = store.habits.map(\.name) + store.sections.map(\.name)
        func leaks(_ text: String) -> [String] { names.filter { !$0.isEmpty && text.contains($0) } }

        HideNames.setChosen(true)
        failures += WidgetCheck.discreetFailures(store, now: Date.now)

        let now = ReminderClock.date(on: day, hour: 0, minute: 0, calendar: utc)!
        let scheduler = ReminderScheduler(notifications: FakeReminderNotifications(), alarms: FakeReminderAlarms())
        let plan = scheduler.plan(store, now: now).filter { $0.day == day }
        let requests = scheduler.requests(for: plan, store: store)
        let words = requests.map { "\($0.content.title) | \($0.content.body) | \($0.content.subtitle)" }
        expect(requests.count >= 3 && words.allSatisfy { leaks($0).isEmpty },
               "No reminder names a habit or section (\(words.flatMap(leaks).prefix(3).joined(separator: ", ")))")
        let eight = DaySection.clock(8 * 60), nine = DaySection.clock(9 * 60)
        expect(requests.contains { $0.content.title == "The usual" }, "Reminder says… is the title (\(words.prefix(4).joined(separator: " / ")))")
        expect(requests.contains { $0.content.title == "Still open · \(eight)" && $0.content.body == "The usual" }, "A repeat: Still open · 8:00")
        expect(requests.contains { $0.content.title == "3 reminders · \(nine)" }, "A group: 3 reminders · 9:00")
        let alone = scheduler.requests(for: plan.filter { $0.habit.id == water.id }, store: store)
        expect(alone.first?.content.title == "Reminder · \(nine)", "No words: Reminder · 9:00 (\(alone.first?.content.title ?? "none"))")
        let categories = ReminderScheduler.categories(for: store.habits, hidden: true)
        let plus = categories.first { $0.identifier.hasSuffix(water.id.uuidString) }?.actions.first?.title
        expect(plus == "+1", "+ without a unit (\(plus ?? "none"))")
        expect(categories.allSatisfy { $0.hiddenPreviewsBodyPlaceholder == ReminderScheduler.previewPlaceholder }, "Previews off: Reminder, on every category")
        let named = ReminderScheduler.categories(for: store.habits, hidden: false)
        expect(named.first { $0.identifier.hasSuffix(water.id.uuidString) }?.actions.first?.title == "+1 glass", "Names shown: the unit stays")
        let alarmTitles = plan.map(AlarmReminderRecord.title)
        expect(alarmTitles.contains("The usual") && alarmTitles.allSatisfy { leaks($0).isEmpty }, "Alarms say the same words")

        // Siri and Shortcuts.
        let answer = WhatsLeftIntent.answer(store)
        expect(leaks(answer).isEmpty && answer.contains("Open Often Enough to see which"), "What's left names nothing (\(answer))")
        let status = store.shortcutStatus(water, on: day, named: false)
        expect(leaks(status).isEmpty, "How's it going names nothing (\(status))")
        expect(((try? await HabitQuery().suggestedEntities()) ?? [HabitEntity(id: UUID(), name: "x", symbol: "x")]).isEmpty,
               "No habit suggested to Spotlight or Siri")

        // The timer's Live Activity.
        if let timer = store.habits.first(where: { $0.name == "Widget timer" }) {
            store.toggleTimer(timer)
            let running = AppModel.shared.timerPresence.runningTimers(store, now: Date.now)
            expect(running.first?.state.hidesName == true, "The Live Activity draws no name")
            store.toggleTimer(timer)
            await store.flush()
        }

        // Names shown again: everything as before.
        HideNames.setChosen(false)
        let shown = scheduler.requests(for: plan.filter { $0.habit.id == meds.id && $0.followUp == 0 }, store: store)
        expect(shown.first?.content.title == "Secret meds" && shown.first?.content.body == "The usual",
               "Names shown: the name, and Reminder says… as the body")
        expect(WhatsLeftIntent.answer(store).contains("Still to do"), "Names shown: Siri lists what's left")
        lock.turnOff()
        return failures
    }
}
#endif
