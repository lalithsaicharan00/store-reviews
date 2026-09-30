import SwiftUI

/// What the speed runs' driver asks a screen to do (30 Sep 2026). Screens handle the ones that are theirs with
/// `.onPerfCommand`; in release builds that modifier does nothing.
enum PerfAction: Equatable {
    case previousDay, nextDay
    case openAllHabits, openHabit(String), openCalendar, openNewHabit, openHabitForm, startRoutine(String), close
    case previousMonth, nextMonth
    case previousHabit, nextHabit
    case typeName(String)
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

/// The latest command. Each is new (its own ID), so the same action twice in a row still arrives.
@Observable final class PerfRemote {
    static let shared = PerfRemote()
    struct Command: Equatable {
        let id = UUID()
        let action: PerfAction
    }
    var command: Command?
}

private struct PerfCommandReceiver: ViewModifier {
    let handle: (PerfAction) -> Void
    func body(content: Content) -> some View {
        content.onChange(of: PerfRemote.shared.command) { _, command in
            if let command { handle(command.action) }
        }
    }
}

/// Speed runs (launched with `-perf-meter -perf-drive <scenario>` by `Tools/perf/measure_perf.sh`, 30 Sep 2026): the
/// app uses itself (scrolls, taps, switches days and months, types, moves through a routine) while `MainThreadMeter`
/// records its stalls. No UI test is attached: XCTest's own screen reading runs on the app's main thread and made up
/// to 79 % of it in the first run, which buried the app's own work. The driver writes each measured window
/// ("# WINDOW name start end") and each screen opening ("# OPEN name start end") into the stall record, and
/// "# DONE" at the end.
enum PerfDriver {
    static func startIfAsked(store: HabitStore) {
        let arguments = ProcessInfo.processInfo.arguments
        guard let flag = arguments.firstIndex(of: "-perf-drive"), flag + 1 < arguments.count else { return }
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
        case "all-habits":
            await openTwice("All Habits") { send(.openAllHabits) }
            await measure("All Habits: scrolling") { await scroll() }
        case "habit-page":
            await open("All Habits") { send(.openAllHabits) }
            await open("Habit page") { send(.openHabit("Brush teeth")) }
            await measure("Habit page: scrolling") { await scroll() }
        case "calendar":
            await openTwice("Calendar") { send(.openCalendar) }
            await measure("Calendar: month ‹ ›") {
                await repeatFor(window) {
                    for _ in 0..<3 { send(.previousMonth); await pause(0.3) }
                    for _ in 0..<3 { send(.nextMonth); await pause(0.3) }
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
                    for n in 1...name.count { send(.typeName(String(name.prefix(n)))); await pause(0.08) }
                    for n in stride(from: name.count - 1, through: 0, by: -1) { send(.typeName(String(name.prefix(n)))); await pause(0.05) }
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

    private static func send(_ action: PerfAction) { PerfRemote.shared.command = .init(action: action) }

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

    /// The biggest scrollable view on the frontmost screen (a presented sheet's, if one is up).
    private static func frontScrollView() -> UIScrollView? {
        let windows = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.flatMap(\.windows)
        guard var top = (windows.first(where: \.isKeyWindow) ?? windows.first)?.rootViewController else { return nil }
        while let presented = top.presentedViewController { top = presented }
        var best: UIScrollView?
        func visit(_ view: UIView) {
            if let scroll = view as? UIScrollView, scroll.window != nil, !scroll.isHidden, scroll.alpha > 0.01,
               scroll.bounds.width > 200, scroll.contentSize.height > scroll.bounds.height + 40,
               scroll.bounds.width * scroll.bounds.height > (best.map { $0.bounds.width * $0.bounds.height } ?? 0) {
                best = scroll
            }
            view.subviews.forEach(visit)
        }
        visit(top.view)
        return best
    }
}
#endif
