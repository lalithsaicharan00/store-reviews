import SwiftUI

/// What the speed runs' driver asks a screen to do (30 Sep 2026). Screens handle the ones that are theirs with
/// `.onPerfCommand`; in release builds that modifier does nothing.
enum PerfAction: Equatable {
    case previousDay, nextDay
    case openAllHabits, openWidgets, openHabit(String), openCalendar, openNewHabit, openHabitForm, startRoutine(String), close
    case previousMonth, nextMonth
    case previousHabit, nextHabit
    case openDay(LocalDay), closeDay, openLog, closeLog, openEntry, saveEntry, logAgain, hideLogKeyboard
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
        case "widget-guide":
            await openTwice("Widgets guide") { send(.openWidgets) }
            await measure("Widgets guide: scrolling") { await scroll() }
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
        case "all-habits":
            await openTwice("All Habits") { send(.openAllHabits) }
            await measure("All Habits: scrolling") { await scroll() }
        case "habit-page":
            await open("All Habits") { send(.openAllHabits) }
            await open("Habit page") { send(.openHabit("Brush teeth")) }
            await measure("Habit page: scrolling") { await scroll() }
        case "habit-page-total":
            // A weekly total (15 km a week): its page has the running-total chart.
            await open("All Habits") { send(.openAllHabits) }
            await open("Habit page (weekly total)") { send(.openHabit("Run")) }
            await measure("Habit page (weekly total): scrolling") { await scroll() }
        case "habit-page-quit":
            // A quit habit: its page has the live clock, the slips and the runs chart.
            await open("All Habits") { send(.openAllHabits) }
            await open("Habit page (quit)") { send(.openHabit("Smoking")) }
            await measure("Habit page (quit): scrolling") { await scroll() }
        case "calendar":
            await openTwice("Calendar") { send(.openCalendar) }
            await measure("Calendar: month ‹ ›") {
                await repeatFor(window) {
                    for _ in 0..<3 { send(.previousMonth); await pause(0.3) }
                    for _ in 0..<3 { send(.nextMonth); await pause(0.3) }
                }
            }
        case "day-sheet", "log-sheet":
            await open("All Habits") { send(.openAllHabits) }
            await open("Habit page") { send(.openHabit("Water")) }
            let today = store.today()
            await open("Day sheet (first)") { send(.openDay(today)) }
            send(.closeDay)
            await pause(1.2)
            await open("Day sheet (again)") { send(.openDay(today)) }
            if scenario == "log-sheet" {
                await open("Log sheet") { send(.openLog) }
                await measure("Log sheet: typing") {
                    await repeatFor(window) {
                        for text in ["1", "12", "123", "12", "1"] { type(text); await pause(0.1) }
                    }
                }
                await open("Log keyboard dismissal") { send(.hideLogKeyboard) }
                await measure("Log sheet: entry list scrolling") { await scroll() }
            } else {
                await measure("Day sheet: entry list scrolling") { await scroll() }
            }
            await open("Entry editor") { send(.openEntry) }
            await measure("Entry editor: typing") {
                await repeatFor(window) {
                    for text in ["1", "12", "123", "12", "1"] { type(text); await pause(0.1) }
                }
            }
            await open("Save entry") { send(.saveEntry) }
            await pause(0.5)
            if scenario == "log-sheet" { send(.closeLog); await pause(0.5) }
            await measure("Day sheet: add, edit and exact undo") {
                guard let water = store.habits.first(where: { $0.name == "Water" }) else { return }
                await repeatFor(window) {
                    store.addProgress(water, value: 1, on: today, source: .daySheet)
                    if let entry = store.entries(of: water.id, on: today).last {
                        store.editEntry(entry.id, value: 2)
                        store.undoEntry(entry.id)
                    }
                    await pause(0.3)
                }
            }
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
        case "player":
            await openTwice("Routine player") { send(.startRoutine(.anytime)) }
            await measure("Routine player: ‹ ›") {
                await repeatFor(window) {
                    send(.nextHabit); await pause(0.4)
                    send(.previousHabit); await pause(0.4)
                }
            }
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
#endif
