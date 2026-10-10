import SwiftUI

/// What the speed runs' driver asks a screen to do (30 Sep 2026). Screens handle the ones that are theirs with
/// `.onPerfCommand`; in release builds that modifier does nothing.
enum PerfAction: Equatable {
    case previousDay, nextDay
    case openAllHabits, openWidgets, openHabit(String), openCalendar, openNewHabit, openHabitForm, startRoutine(String), close
    case previousMonth, nextMonth
    case previousHabit, nextHabit
    case openDay(LocalDay), closeDay, openLog, closeLog, openEntry, saveEntry, logAgain, hideLogKeyboard
    /// Day details' All logs page, the Log view's Edit, and the day's note (the 7 Oct 2026 redesign).
    case openAllLogs, editEntry, openNote
    /// A page from the ≡ menu; the menu itself; Today's group filter; Progress's range; the habit page's Edit.
    case openPlace(MenuPlace), toggleMenu, nextGroup, nextRange, openEdit
    /// Progress's "What the squares mean": fold or open it (`HeatKeySection`, 3 Oct 2026).
    case toggleHeatKey
    /// A page with nothing on it, pushed like a menu page (`PerfBlankPage`); one with only a number field.
    case openBlank, openTypingControl
    /// The habit page's History · Notes · Progress, by position (3 Oct 2026).
    case habitTab(Int)
    /// The habit page's All milestones page (spec "Habit Progress" §3.2, 11 Oct 2026).
    case openMilestones, showMilestones
    /// Today's Edit: Arrange Your Day (3 Oct 2026).
    case openArrange
    /// The lock's keypad (Current Work 58): a digit, or Delete.
    case codeKey(Int), codeDelete
    /// The welcome (Current Work 73.1): shown over Today, a page pushed by name (`OnboardingRoute.perf`), and Back.
    case openOnboarding, onboardingPage(String), onboardingBack
    /// Privacy & Security's App Lock page, and its setup sheet (Current Work 58.13).
    case openAppLock, openLockSetup
    /// Backup & Export's Account and Restore pages (Current Work 76).
    case openAccount, openRestore
}

/// Speed runs only: switches a scenario flips to take one part out of a screen and see what it cost (the bisect
/// method, PERFORMANCE-LESSONS.md). Outside the speed runs they never change.
enum PerfSwitches {
    /// False opens the habit form without putting the cursor in its name field, to tell the form's own opening from
    /// the keyboard's (2 Oct 2026).
    static var focusFormName = true
    /// True (scenario `habit-milestones-blank`) pushes an empty page where All milestones goes, the same way: the
    /// control for its first opening (22.6 s and 50 s in two speed runs, 167 ms and 2 s with the profiler, 10 Oct 2026).
    static var blankMilestonesPage = false
    /// False (`-perf-no-widget-publish`, a launch argument) leaves out the widgets' publication after each change, to
    /// measure what it costs the screen the person is using (8 Oct 2026, Current Work 49). Always true outside speed runs.
    static let widgetPublication: Bool = {
        #if DEBUG
        return !ProcessInfo.processInfo.arguments.contains("-perf-no-widget-publish")
        #else
        return true
        #endif
    }()
}

/// The control for "opening a screen" (2 Oct 2026): a page with nothing on it, pushed on Today's stack exactly like a
/// menu page. If it stalls as long as the real pages, the cost is the push itself, not what the pages draw.
struct PerfBlankPage: Hashable {}

/// The control for typing (2 Oct 2026): a bare number field, typed into exactly like the entry editor. On the iPhone
/// the editor cost ~6 ms a keystroke with nothing of the app's running per letter; this shows what iOS's own text
/// input costs.
struct PerfTypingPage: Hashable {}

extension View {
    func perfBlankDestination() -> some View {
        #if DEBUG
        navigationDestination(for: PerfBlankPage.self) { _ in
            Color(.systemGroupedBackground).ignoresSafeArea()
                .navigationTitle("Blank")
                .navigationBarTitleDisplayMode(.inline)
        }
        .navigationDestination(for: PerfTypingPage.self) { _ in PerfTypingView() }
        #else
        self
        #endif
    }
}

extension View {
    func onPerfCommand(_ handle: @escaping (PerfAction) -> Void) -> some View {
        #if DEBUG
        modifier(PerfCommandReceiver(handle: handle))
        #else
        self
        #endif
    }
}

#if DEBUG
import UIKit

/// Debug-only delivery has no publisher or observable command state in SwiftUI's view graph.
/// Covered presenters still receive Close; weak subscriptions release dismissed screens naturally.
final class PerfRemote {
    static let shared = PerfRemote()
    private var receivers: [UUID: WeakPerfSubscription] = [:]

    func connect(_ subscription: PerfSubscription, handle: @escaping (PerfAction) -> Void) {
        subscription.handle = handle
        receivers[subscription.id] = WeakPerfSubscription(subscription)
    }

    func send(_ action: PerfAction) {
        for (id, receiver) in Array(receivers) {
            if let subscription = receiver.value { subscription.handle(action) }
            else { receivers.removeValue(forKey: id) }
        }
    }
}

final class PerfSubscription {
    let id = UUID()
    var handle: (PerfAction) -> Void = { _ in }
}

private final class WeakPerfSubscription {
    weak var value: PerfSubscription?
    init(_ value: PerfSubscription) { self.value = value }
}

private struct PerfCommandReceiver: ViewModifier {
    let handle: (PerfAction) -> Void
    @State private var subscription = PerfSubscription()
    func body(content: Content) -> some View {
        content.onAppear { PerfRemote.shared.connect(subscription, handle: handle) }
    }
}

/// Speed runs (launched with `-perf-meter -perf-drive <scenario>` by `Tools/perf/measure_perf.sh`, 30 Sep 2026): the
/// app uses itself (scrolls, taps, switches days and months, types, moves through a routine) while `MainThreadMeter`
/// records its stalls. No UI test is attached: XCTest's own screen reading runs on the app's main thread and made up
/// to 79 % of it in the first run, which buried the app's own work. The driver writes each measured window
/// ("# WINDOW name start end") and each screen opening ("# OPEN name start end") into the stall record, and
/// "# DONE" at the end.
enum PerfDriver {
    private static var started = false
    static func startIfAsked(store: HabitStore) {
        let arguments = ProcessInfo.processInfo.arguments
        guard !started, let flag = arguments.firstIndex(of: "-perf-drive"), flag + 1 < arguments.count else { return }
        started = true
        let scenario = arguments[flag + 1]
        Task { @MainActor in
            await pause(8) // launch settles, and the script's sampler finishes attaching (it pauses the app)
            MainThreadMeter.mark("# MEASURING") // the script samples from here, so first opens are covered too
            await run(scenario, store: store)
            MainThreadMeter.mark("# DONE")
        }
    }

    /// How long each scroll or tap window lasts.
    private static let window: Double = 15

    private static func run(_ scenario: String, store: HabitStore) async {
        switch scenario {
        case "scroll-today":
            await measure("Today: scrolling") { await scroll() }
        case "tap-today":
            guard let water = store.habits.first(where: { $0.name == "Water" }) else { return MainThreadMeter.mark("# NOTE no Water") }
            await measure("Today: +1 and day ‹ ›") {
                await repeatFor(window) {
                    withAnimation { store.increment(water, on: store.today()) }
                    await pause(0.35)
                    send(.previousDay)
                    await pause(0.35)
                    send(.nextDay)
                    await pause(0.35)
                }
            }
            // The same two actions apart (2 Oct 2026), to tell which one costs what.
            await measure("Today: +1 alone") {
                await repeatFor(window) {
                    withAnimation { store.increment(water, on: store.today()) }
                    await pause(0.35)
                }
            }
            await measure("Today: day ‹ › alone") {
                await repeatFor(window) {
                    send(.previousDay)
                    await pause(0.35)
                    send(.nextDay)
                    await pause(0.35)
                }
            }
            // A tap on a row opens its Day sheet (3 Oct 2026, report "Today's Rows"): its first and second opening, and
            // scrolling inside it (Rulebook T4).
            await open("Today: a row's Day sheet (first)") { store.dayTarget = .init(habitID: water.id, day: store.today()) }
            send(.closeDay)
            await pause(1.2)
            await open("Today: a row's Day sheet (again)") { store.dayTarget = .init(habitID: water.id, day: store.today()) }
            await measure("Today: Day sheet scrolling") { await scroll() }
            send(.closeDay)
            await pause(1.0)
            // A task's row opens its Day sheet too, and Add Note opens the note sheet (3 Oct 2026, report "Today's Rows —
            // The Line Under the Name"; Rulebook T4).
            if let task = store.habits.first(where: { $0.kind == .task && !$0.archived }) {
                await open("Today: a task's Day sheet") { store.dayTarget = .init(habitID: task.id, day: store.today()) }
                send(.closeDay)
                await pause(1.0)
            }
            await open("Today: the note sheet") { store.noteTarget = .init(habit: water.id, day: store.today()) }
            store.noteTarget = nil
            await pause(1.0)
            // ▶ opens the timer full screen (4 Oct 2026, report "Timers — What People Expect When They Tap ▶"; T4): its
            // opening, and its clock ticking with Today underneath.
            if let timed = store.habits.first(where: { $0.kind == .duration && !$0.atMost && !$0.archived }) {
                if store.timers[timed.id] == nil { store.toggleTimer(timed) }
                await open("Today: the timer screen") { store.timerScreen = timed.id }
                await measure("Timer screen: a running clock") { await pause(window) }
                store.timerScreen = nil
                await pause(1.0)
                if store.timers[timed.id] != nil { store.toggleTimer(timed) }
            }
        case "typing-control":
            await open("Typing control") { send(.openTypingControl) }
            await pause(1)
            await measure("Control: typing in a bare number field") {
                await repeatFor(window) {
                    for text in ["1", "12", "123", "12", "1"] { type(text); await pause(0.1) }
                }
            }
            send(.close)
        case "widget-guide":
            // The Widgets guide is Help → Widgets now (Current Work 58), opened as a widget's Choose a habit opens it.
            await openTwice("Widgets guide") { send(.openWidgets) }
            await measure("Widgets guide: scrolling") { await scroll() }
        case "privacy":
            // Privacy & Security (Current Work 58, T4): opening it, scrolling it, and hiding names outside the app, which
            // publishes the widgets at once and re-plans reminders (spec §2.3).
            await openTwice("Privacy & Security") { send(.openPlace(.privacy)) }
            await measure("Privacy & Security: scrolling") { await scroll() }
            await measure("Hide names: widgets published and reminders re-planned") {
                await repeatFor(window) {
                    HideNames.setChosen(!HideNames.chosen)
                    await AppModel.shared.privacyChanged()
                    await pause(0.5)
                }
            }
            HideNames.setChosen(false)
            await AppModel.shared.privacyChanged()
            send(.close)
        case "app-lock":
            // App Lock's page and its setup sheet (Current Work 58.13, T4): the page from Privacy & Security, and the sheet
            // the switch opens (screens 2 and 3). A test launch's own lock, which stays off (D8).
            send(.openPlace(.privacy))
            await pause(1.5)
            await open("App Lock page (first)") { send(.openAppLock) }
            await open("App Lock: setup sheet (first)") { send(.openLockSetup) }
            send(.close)
            await pause(1.2)
            send(.openPlace(.privacy))
            await pause(1.5)
            await open("App Lock page (again)") { send(.openAppLock) }
            await open("App Lock: setup sheet (again)") { send(.openLockSetup) }
            await measure("App Lock: setup sheet scrolling") { await scroll() }
            send(.close)
        case "account":
            // ≡ → Account (Current Work 76, T4): signed out, as a test launch is (D8); and its Sign In sheet.
            await openTwice("Account") { send(.openPlace(.account)) }
            await measure("Account: scrolling") { await scroll() }
            send(.close)
            await pause(1.2)
            send(.openPlace(.backup))
            await pause(1.5)
            await open("Backup & Export → Your Account") { send(.openAccount) }
            send(.close)
        case "backup-page":
            // ≡ → Backup & Export (Current Work 76, T4): opening it, scrolling it, and Restore From a Backup from it.
            await openTwice("Backup & Export") { send(.openPlace(.backup)) }
            await measure("Backup & Export: scrolling") { await scroll() }
            await open("Backup & Export → Restore From a Backup") { send(.openRestore) }
            send(.close)
        case "backup-states":
            // Backup & Export and Account in each state (Current Work 78, T4): no account, a free account (syncs this
            // iPhone), Plus; shown as they would be, without signing in (D8).
            for (name, plus) in [("no account", nil), ("free", false), ("Plus", true)] as [(String, Bool?)] {
                AppModel.shared.backup?.perfSignedIn = plus
                await pause(0.5)
                await open("Backup & Export (\(name))") { send(.openPlace(.backup)) }
                await measure("Backup & Export (\(name)): scrolling") { await scroll() }
                send(.close)
                await pause(1.2)
                await open("Account (\(name))") { send(.openPlace(.account)) }
                send(.close)
                await pause(1.2)
            }
            AppModel.shared.backup?.perfSignedIn = nil
        case "lock-keypad":
            // The lock's cover with its keypad (Current Work 58, T4): showing it, typing on it (never six digits, so it
            // stays), then the right code, which opens the app. A test launch's own lock (D8).
            let lock = AppModel.shared.lock
            await open("Lock cover with keypad") { Task { await lock.perfLock() } }
            await measure("Lock keypad: typing") {
                await repeatFor(window) {
                    for digit in [1, 2, 3, 4, 5] { send(.codeKey(digit)); await pause(0.12) }
                    for _ in 0..<5 { send(.codeDelete); await pause(0.12) }
                }
            }
            await measure("Lock: the right code opens") {
                for digit in [1, 2, 3, 4, 5, 6] { send(.codeKey(digit)); await pause(0.12) }
                await pause(1.5)
            }
            lock.turnOff()
        case "widget-log":
            guard let water = store.habits.first(where: { $0.name == "Water" }) else { return MainThreadMeter.mark("# ERROR no Water") }
            let day = store.today()
            for entry in store.entries(of: water.id, on: day) { store.undoEntry(entry.id) }
            await store.flush()
            await measure("Widget: durable amount log and publication") {
                await repeatFor(window) {
                    let event = UUID()
                    do {
                        try await AppModel.shared.logFromWidget(item: water.id.uuidString, day: day.key,
                                                               event: event.uuidString, signature: HabitStore.widgetSignature(water))
                        guard store.entries(of: water.id).contains(where: { $0.id == event }) else {
                            MainThreadMeter.mark("# ERROR widget log did not persist"); return
                        }
                    } catch { MainThreadMeter.mark("# ERROR widget log: \(error)"); return }
                    store.undoEntry(event); await store.flush()
                    await pause(0.35)
                }
            }
        case "widget-publish":
            // Every habit's seven days worked out again, as after a new day or a setting every widget shows (week start,
            // streaks), then published: the widgets' heaviest moment (Implementation Spec §11, S16).
            await measure("Widget: full publication, every habit's week") {
                await repeatFor(window) {
                    store.widgetProjectionCache = [:]
                    await AppModel.shared.widgets.publish(store)
                    await pause(0.35)
                }
            }
        case "progress":
            await openTwice("Progress") { send(.openPlace(.progress)) }
            await measure("Progress: scrolling") { await scroll() }
            await measure("Progress: period ‹ › and range") {
                await repeatFor(window) {
                    send(.previousMonth); await pause(0.4)
                    send(.nextMonth); await pause(0.4)
                    send(.nextRange); await pause(0.4)
                }
            }
            // The key folds and opens (3 Oct 2026); left open for the runs after.
            await measure("Progress: key fold and open") {
                await repeatFor(window) { send(.toggleHeatKey); await pause(0.6) }
            }
            // Folding is remembered app-wide now (Current Work 57): the runs after start from a key never folded.
            HeatKeyVisit.forgetAll()
        case "progress-year":
            // Year (2 Oct 2026): a heat map per habit, a year of squares each. Opened on Year (set before opening, so
            // the scenario never depends on the range a run before left), then its cards scrolled; Week afterwards.
            UserDefaults.standard.set(ProgressRange.year.rawValue, forKey: ProgressOptions.range)
            await openTwice("Progress Year") { send(.openPlace(.progress)) }
            // A year scrolls sideways inside its card (3 Oct 2026): the first year on screen, back and forth.
            await measure("Progress Year: sideways") { await scrollSideways() }
            await measure("Progress Year: scrolling") { await scroll() }
            send(.close)
            UserDefaults.standard.set(ProgressRange.week.rawValue, forKey: ProgressOptions.range)
        case "arrange":
            // Today's Edit (3 Oct 2026): opening Arrange Your Day, scrolling every habit in it, moving Anytime, sorting a
            // card, and hiding completed habits back on Today.
            await openTwice("Arrange Your Day") { send(.openArrange) }
            await measure("Arrange Your Day: scrolling") { await scroll() }
            await measure("Arrange Your Day: move Anytime and sort") {
                await repeatFor(window) {
                    store.moveCard(.anytime, .bottom); await pause(0.4)
                    store.moveCard(.anytime, .top); await pause(0.4)
                    store.sortCard(.morning, by: .name); await pause(0.4)
                }
            }
            send(.close)
            await pause(1)
            await measure("Today: hide completed on and off") {
                await repeatFor(window) {
                    UserDefaults.standard.set(true, forKey: Preferences.hideDoneHabits); await pause(0.5)
                    UserDefaults.standard.set(false, forKey: Preferences.hideDoneHabits); await pause(0.5)
                }
            }
        case "menu":
            await measure("Menu: open and close") {
                await repeatFor(window) { send(.toggleMenu); await pause(0.6) }
            }
        case "groups":
            await measure("Today: group filter") {
                await repeatFor(window) { send(.nextGroup); await pause(0.4) }
            }
            send(.close)
        case "menu-pages":
            // Every other page in the ≡ menu: how long each takes to open, between two blank pages pushed the same
            // way (the control: what a push alone costs).
            await open("Blank page (control, first)") { send(.openBlank) }
            send(.close)
            await pause(1)
            for place in [MenuPlace.tasks, .timesOfDay, .dayAndWeek, .reminders, .appearance, .account, .backup, .privacy, .plus, .help, .about] {
                // Twice: the first pays one-time costs (a launch's first form, picker, search bar); the second is
                // what every later opening costs.
                await openTwice(place.title) { send(.openPlace(place)) }
                send(.close)
                await pause(1)
            }
            await open("Blank page (control, again)") { send(.openBlank) }
            send(.close)
            await pause(1)
        case "habit-edit":
            await open("All Habits") { send(.openAllHabits) }
            await open("Habit page") { send(.openHabit("Water")) }
            await open("Edit habit (first)") { send(.openEdit) }
            send(.closeDay) // the habit page closes its sheets
            await pause(1.2)
            await open("Edit habit (again)") { send(.openEdit) }
        case "all-habits":
            await openTwice("All Habits") { send(.openAllHabits) }
            await measure("All Habits: scrolling") { await scroll() }
        case "habit-page":
            // The habit page (3 Oct 2026): History opens first, then Notes and Progress, each switched to and scrolled.
            await open("All Habits") { send(.openAllHabits) }
            await open("Habit page") { send(.openHabit("Brush teeth")) }
            await measure("Habit page: History scrolling") { await scroll() }
            await open("Habit page: Notes") { send(.habitTab(1)) }
            await open("Habit page: Progress") { send(.habitTab(2)) }
            await measure("Habit page: Progress scrolling") { await scroll() }
            await measure("Habit page: switching tabs") {
                await repeatFor(window) {
                    send(.habitTab(0)); await pause(0.5)
                    send(.habitTab(2)); await pause(0.5)
                }
            }
        case "habit-milestones", "habit-milestones-blank":
            PerfSwitches.blankMilestonesPage = scenario == "habit-milestones-blank"
            // Milestones (spec "Habit Progress", 11 Oct 2026): the Progress tab with a year of medals, its Earlier shelf
            // scrolled sideways, then the All milestones page opened and scrolled.
            await open("All Habits") { send(.openAllHabits) }
            await open("Habit page") { send(.openHabit("Brush teeth")) }
            await open("Habit page: Progress (milestones)") { send(.habitTab(2)) }
            await measure("Habit page: Progress scrolling (milestones)") { await scroll() }
            send(.showMilestones)
            await pause(1)
            await measure("Habit page: Milestones shelf scrolling") { await scrollSideways() }
            // Opened three times: the first run's first opening read 50 s in one launch and 2 s in another, with the
            // main thread asleep in the profile (10 Oct 2026); the later openings say what it costs every other time.
            for round in ["first", "second", "third"] {
                await open("All milestones (\(round))") { send(.openMilestones) }
                if round == "first" { await measure("All milestones: scrolling") { await scroll() } }
                send(.closeDay)
                await pause(1.2)
            }
        case "habit-page-total":
            // A weekly total (15 km a week): its Progress has the week's total against its goal.
            await open("All Habits") { send(.openAllHabits) }
            await open("Habit page (weekly total)") { send(.openHabit("Run")) }
            await measure("Habit page (weekly total): History scrolling") { await scroll() }
            await open("Habit page (weekly total): Progress") { send(.habitTab(2)) }
            await measure("Habit page (weekly total): Progress scrolling") { await scroll() }
        case "habit-page-quit":
            // A quit habit: its Progress has the live clock and the time since the last slip.
            await open("All Habits") { send(.openAllHabits) }
            await open("Habit page (quit)") { send(.openHabit("Smoking")) }
            await measure("Habit page (quit): History scrolling") { await scroll() }
            await open("Habit page (quit): Progress") { send(.habitTab(2)) }
            await measure("Habit page (quit): Progress scrolling") { await scroll() }
        case "calendar":
            await openTwice("Calendar") { send(.openCalendar) }
            await measure("Calendar: month ‹ ›") {
                await repeatFor(window) {
                    for _ in 0..<3 { send(.previousMonth); await pause(0.3) }
                    for _ in 0..<3 { send(.nextMonth); await pause(0.3) }
                }
            }
        case "day-sheet", "log-sheet":
            // Day details, the Log view and Edit log, All logs (7 Oct 2026 redesign; Rulebook T4).
            guard let water = store.habits.first(where: { $0.name == "Water" }) else { return MainThreadMeter.mark("# NOTE no Water") }
            let today = store.today()
            // Four logs or more: the two newest and "All N logs" (U17).
            while store.dayLogs(of: water, on: today).count < 4 { store.addProgress(water, value: 1, on: today, source: .manual) }
            await store.flush()
            await open("All Habits") { send(.openAllHabits) }
            await open("Habit page") { send(.openHabit("Water")) }
            await open("Day sheet (first)") { send(.openDay(today)) }
            send(.closeDay)
            await pause(1.2)
            await open("Day sheet (again)") { send(.openDay(today)) }
            if scenario == "log-sheet" {
                // Log manually: the one Add screen, the number pad up as it opens.
                await open("Log sheet") { send(.openLog) }
                await measure("Log sheet: typing") {
                    await repeatFor(window) {
                        for text in ["1", "12", "123", "12", "1"] { type(text); await pause(0.1) }
                    }
                }
                await open("Log keyboard dismissal") { send(.hideLogKeyboard) }
                send(.closeLog)
                await pause(1.0)
            } else {
                await measure("Day sheet: entry list scrolling") { await scroll() }
            }
            await open("All logs") { send(.openAllLogs) }
            await measure("All logs: scrolling") { await scroll() }
            send(.closeDay)
            await pause(1.2)
            await open("Day sheet (for a log)") { send(.openDay(today)) }
            await open("Entry editor") { send(.openEntry) }
            await open("Edit log (keyboard)") { send(.editEntry) }
            await measure("Entry editor: typing") {
                await repeatFor(window) {
                    for text in ["1", "12", "123", "12", "1"] { type(text); await pause(0.1) }
                }
            }
            await open("Save entry") { send(.saveEntry) }
            await pause(0.5)
            await measure("Day sheet: add, edit and exact undo") {
                await repeatFor(window) {
                    store.addProgress(water, value: 1, on: today, source: .daySheet)
                    if let entry = store.entries(of: water.id, on: today).last {
                        store.editEntry(entry.id, value: 2, at: entry.createdAt.addingTimeInterval(-60))
                        store.undoEntry(entry.id)
                    }
                    await pause(0.3)
                }
            }
        case "add-screens":
            // The one Add screen for every kind (7 Oct 2026; T4): Add log (an amount, a time) with typing, Add a check,
            // Mark a day done, Tick steps and Add slip, each opened from its Day details.
            let today = store.today()
            for (name, typing) in [("Water", true), ("Read", true), ("Call family", false), ("Meds", false),
                                   ("Skincare", false), ("Smoking", false)] {
                guard store.habits.contains(where: { $0.name == name }) else { MainThreadMeter.mark("# NOTE no \(name)"); continue }
                await open("All Habits") { send(.openAllHabits) }
                await open("Habit page (\(name))") { send(.openHabit(name)) }
                await open("Day sheet (\(name))") { send(.openDay(today)) }
                await open("Add screen (\(name))") { send(.openLog) }
                if typing {
                    await measure("Add screen (\(name)): typing") {
                        await repeatFor(window) {
                            for text in ["1", "12", "123", "12", "1"] { type(text); await pause(0.1) }
                        }
                    }
                }
                send(.closeLog)
                await pause(1.0)
                send(.closeDay)
                await pause(1.0)
                send(.close)
                await pause(1.2)
            }
        case "notes":
            // Add note and Edit note, typing (7 Oct 2026; T4): from Water's Day details, the note box and Save above
            // the keyboard.
            guard let water = store.habits.first(where: { $0.name == "Water" }) else { return MainThreadMeter.mark("# NOTE no Water") }
            let today = store.today()
            store.setNote("", of: water, on: today)
            await open("All Habits") { send(.openAllHabits) }
            await open("Habit page") { send(.openHabit("Water")) }
            await open("Day sheet") { send(.openDay(today)) }
            await open("Add note") { send(.openNote) }
            let sentence = "Big glass after the run"
            await measure("Add note: typing") {
                await repeatFor(window) {
                    for n in 1...sentence.count { type(String(sentence.prefix(n))); await pause(0.08) }
                    for n in stride(from: sentence.count - 1, through: 0, by: -1) { type(String(sentence.prefix(n))); await pause(0.05) }
                }
            }
            send(.closeLog)
            await pause(1.0)
            store.setNote("A note to change.", of: water, on: today)
            await pause(0.5)
            await open("Note view") { send(.openNote) }
            await open("Edit note (keyboard)") { send(.editEntry) }
            await measure("Edit note: typing") {
                await repeatFor(window) {
                    for n in 1...sentence.count { type(String(sentence.prefix(n))); await pause(0.08) }
                    for n in stride(from: sentence.count - 1, through: 0, by: -1) { type(String(sentence.prefix(n))); await pause(0.05) }
                }
            }
            send(.closeDay)
            await pause(1.0)
            store.setNote("", of: water, on: today)
        case "new-habit":
            await openTwice("New Habit") { send(.openNewHabit) }
            send(.close)
            await pause(1)
            await openTwice("Habit form") { send(.openHabitForm) }
            let name = "Drink a glass of water"
            await measure("Habit form: typing") {
                await repeatFor(window) {
                    for n in 1...name.count { type(String(name.prefix(n))); await pause(0.08) }
                    for n in stride(from: name.count - 1, through: 0, by: -1) { type(String(name.prefix(n))); await pause(0.05) }
                }
            }
        case "form-parts":
            // The habit form's opening split in two (2 Oct 2026): the form alone, then the launch's first keyboard,
            // then a later keyboard. The first opening without the keyboard still pays the form's one-time costs.
            PerfSwitches.focusFormName = false
            await openTwice("Habit form, no keyboard") { send(.openHabitForm) }
            send(.close)
            await pause(1.2)
            PerfSwitches.focusFormName = true
            await open("Habit form, the launch's first keyboard") { send(.openHabitForm) }
            send(.close)
            await pause(1.2)
            await open("Habit form, keyboard again") { send(.openHabitForm) }
            send(.close)
            await pause(1)
        case "player":
            await openTwice("Routine player") { send(.startRoutine(.anytime)) }
            await measure("Routine player: ‹ ›") {
                await repeatFor(window) {
                    send(.nextHabit); await pause(0.4)
                    send(.previousHabit); await pause(0.4)
                }
            }
            // The player's Day details (U23, 7 Oct 2026): the same sheet a row opens, over the player.
            await open("Routine player: Day details") { send(.openDay(store.today())) }
            send(.closeDay)
            await pause(1.2)
            // A quick thumb (Current Work 50, 5 Oct 2026): › to the end and ‹ back, a tap every 0.1 s.
            await measure("Routine player: fast ‹ ›") {
                await repeatFor(window) {
                    for _ in 0..<12 { send(.nextHabit); await pause(0.1) }
                    for _ in 0..<12 { send(.previousHabit); await pause(0.1) }
                }
            }
        case "onboarding":
            // The welcome (Current Work 73.1, T4): shown over Today, each page's opening, Back and forward, the ideas
            // scrolled, every way back, and typing a transfer code. It runs on the speed runs' own data, so Welcome back
            // shows "We found data on this device".
            await open("Welcome") { send(.openOnboarding) }
            for page in ["included", "build", "quit", "tasks", "days", "firstHabit"] {
                await open("Welcome: \(page)") { send(.onboardingPage(page)) }
            }
            await measure("Welcome: ideas scrolling") { await scroll() }
            await measure("Welcome: Back and forward") {
                await repeatFor(window) {
                    send(.onboardingBack); await pause(0.5)
                    send(.onboardingPage("firstHabit")); await pause(0.5)
                }
            }
            await open("Welcome: New (Create my own habit)") { send(.onboardingPage("createOwn")) }
            for _ in 0..<7 { send(.onboardingBack) }
            await pause(1.2)
            for page in ["welcomeBack", "signIn", "restore", "transferCode"] {
                await open("Welcome: \(page)") { send(.onboardingPage(page)) }
            }
            let code = "K7PQ49XM"
            await measure("Transfer code: typing") {
                await repeatFor(window) {
                    for n in 1...code.count { type(String(code.prefix(n))); await pause(0.12) }
                    for n in stride(from: code.count - 1, through: 0, by: -1) { type(String(code.prefix(n))); await pause(0.08) }
                }
            }
            send(.close)
        default:
            MainThreadMeter.mark("# NOTE unknown scenario \(scenario)")
        }
    }

    private static func send(_ action: PerfAction) { PerfRemote.shared.send(action) }

    private static func pause(_ seconds: Double) async { try? await Task.sleep(for: .seconds(seconds)) }

    private static var now: String { String(format: "%.3f", Date.now.timeIntervalSince1970) }

    /// A screen opening: its stalls in the 1.5 s after the command are how long it froze the app.
    private static func open(_ name: String, _ action: () -> Void) async {
        let start = now
        action()
        await pause(1.5)
        MainThreadMeter.mark("# OPEN \(name)|\(start)|\(now)")
    }

    /// The first opening pays one-time costs (the keyboard, a screen's first build); the second is what people
    /// feel every other time. Both are reported.
    private static func openTwice(_ name: String, _ action: () -> Void) async {
        await open(name + " (first)", action)
        send(.close)
        await pause(1.2)
        await open(name + " (again)", action)
    }

    private static func measure(_ name: String, _ work: () async -> Void) async {
        let start = now
        await work()
        MainThreadMeter.mark("# WINDOW \(name)|\(start)|\(now)")
        // End this run-loop turn before the next action. Otherwise Save's keyboard/navigation
        // work can share the last typing turn and be counted as a typing stall.
        await pause(0.15)
    }

    private static func repeatFor(_ seconds: Double, _ step: () async -> Void) async {
        let end = Date.now.addingTimeInterval(seconds)
        while Date.now < end { await step() }
    }

    /// Scrolls the frontmost list down and up at a reading speed, a frame at a time, as a finger would.
    private static func scroll() async {
        guard let list = frontScrollView() else { return MainThreadMeter.mark("# NOTE no scroll view") }
        let speed: CGFloat = 1200 // points per second
        var down = true
        var last = CACurrentMediaTime()
        let end = Date.now.addingTimeInterval(window)
        while Date.now < end {
            try? await Task.sleep(for: .milliseconds(16))
            let time = CACurrentMediaTime()
            let top = -list.adjustedContentInset.top
            let bottom = max(top, list.contentSize.height + list.adjustedContentInset.bottom - list.bounds.height)
            var y = list.contentOffset.y + (down ? speed : -speed) * CGFloat(time - last)
            last = time
            if y >= bottom { y = bottom; down = false } else if y <= top { y = top; down = true }
            list.contentOffset.y = y
        }
    }

    /// Insert/delete through UIKit's text-input path, as a keyboard does. Replacing a Binding's
    /// string instead makes SwiftUI write text back into UIKit and measures a different path.
    private static func type(_ text: String) {
        // Nothing focused yet (the form's own focus didn't land in one launch, 1 Oct 2026): focus the screen's first
        // text field, as a tap on it would, so the typing is still measured.
        guard let view = frontView(), let field = focusedInput(in: view) ?? focusFirstInput(in: view) else {
            MainThreadMeter.mark("# ERROR no focused native text input")
            return
        }
        let old = contents(of: field)
        if old == text { return }
        if let selection = field.selectedTextRange, !selection.isEmpty {
            field.insertText(text)
        } else {
            let prefix = zip(old, text).prefix { $0.0 == $0.1 }.count
            if prefix == old.count { field.insertText(String(text.dropFirst(prefix))) }
            else if prefix == text.count {
                for _ in prefix..<old.count { field.deleteBackward() }
            } else {
                field.selectedTextRange = field.textRange(from: field.beginningOfDocument, to: field.endOfDocument)
                field.insertText(text)
            }
        }
        if contents(of: field) != text { MainThreadMeter.mark("# ERROR native typing did not produce expected text") }
    }

    private static func focusedInput(in view: UIView) -> (any UITextInput)? {
        if view.isFirstResponder, let field = view as? any UITextInput { return field }
        for child in view.subviews {
            if let field = focusedInput(in: child) { return field }
        }
        return nil
    }

    private static func focusFirstInput(in view: UIView) -> (any UITextInput)? {
        if let field = view as? UIView & UITextInput, field.window != nil, !field.isHidden,
           (field as? UITextField)?.isEnabled ?? (field as? UITextView)?.isEditable ?? false {
            if field.becomeFirstResponder() {
                MainThreadMeter.mark("# FOCUSED the first text field")
                return field
            }
        }
        for child in view.subviews {
            if let field = focusFirstInput(in: child) { return field }
        }
        return nil
    }

    private static func contents(of input: any UITextInput) -> String {
        guard let range = input.textRange(from: input.beginningOfDocument, to: input.endOfDocument) else { return "" }
        return input.text(in: range) ?? ""
    }

    private static func frontView() -> UIView? {
        let windows = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.flatMap(\.windows)
        guard var top = (windows.first(where: \.isKeyWindow) ?? windows.first)?.rootViewController else { return nil }
        while let presented = top.presentedViewController { top = presented }
        return top.view
    }

    /// The first view on screen that scrolls sideways (a year in its card), moved back and forth like a finger would.
    private static func scrollSideways() async {
        guard let view = frontView() else { return }
        var found: UIScrollView?
        func visit(_ view: UIView) {
            guard found == nil else { return }
            if let scroll = view as? UIScrollView, scroll.window != nil, !scroll.isHidden,
               scroll.contentSize.width > scroll.bounds.width + 40, scroll.contentSize.height <= scroll.bounds.height + 1,
               let window = scroll.window, window.bounds.intersects(scroll.convert(scroll.bounds, to: window)) {
                found = scroll
            }
            view.subviews.forEach(visit)
        }
        visit(view)
        guard let row = found else { return MainThreadMeter.mark("# NOTE no sideways scroll view") }
        let speed: CGFloat = 900
        var back = true
        var last = CACurrentMediaTime()
        let end = Date.now.addingTimeInterval(window)
        while Date.now < end {
            try? await Task.sleep(for: .milliseconds(16))
            let time = CACurrentMediaTime()
            let left = -row.adjustedContentInset.left
            let right = max(left, row.contentSize.width + row.adjustedContentInset.right - row.bounds.width)
            var x = row.contentOffset.x + (back ? -speed : speed) * CGFloat(time - last)
            last = time
            if x <= left { x = left; back = false } else if x >= right { x = right; back = true }
            row.contentOffset.x = x
        }
    }

    /// The biggest scrollable view on the frontmost screen (a presented sheet's, if one is up).
    private static func frontScrollView() -> UIScrollView? {
        guard let view = frontView() else { return nil }
        var best: UIScrollView?
        func visit(_ view: UIView) {
            if let scroll = view as? UIScrollView, scroll.window != nil, !scroll.isHidden, scroll.alpha > 0.01,
               scroll.bounds.width > 200, scroll.contentSize.height > scroll.bounds.height + 40,
               scroll.bounds.width * scroll.bounds.height > (best.map { $0.bounds.width * $0.bounds.height } ?? 0) {
                best = scroll
            }
            view.subviews.forEach(visit)
        }
        visit(view)
        return best
    }
}

/// A bare number field for the typing control (`PerfTypingPage`), focused as it opens.
private struct PerfTypingView: View {
    @State private var text = ""
    @FocusState private var focused: Bool

    var body: some View {
        Form { TextField("0", text: $text).keyboardType(.decimalPad).focused($focused) }
            .navigationTitle("Typing control")
            .navigationBarTitleDisplayMode(.inline)
            .task { focused = true }
    }
}
#endif
