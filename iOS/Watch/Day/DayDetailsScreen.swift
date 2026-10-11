import SwiftUI
import WatchKit

/// Day details on the Watch (B), today only: the habit's progress as a dial, its one main action in the middle of the
/// bottom bar (white, the iPhone player's ink; glass for a limit or a slip, U16), Log manually (pencil) and ⋯ in the
/// corners. Below, reached with the Crown: today's logs, the streak, and Skip today, last and plain (U17).
struct DayDetailsScreen: View {
    let habitID: UUID
    @Environment(HabitStore.self) private var store
    @Environment(WatchNavigation.self) private var navigation
    @Environment(\.isLuminanceReduced) private var wristDown
    @State private var more = false
    @State private var askSlip = false
    @AppStorage(ProgressOptions.showStreaks) private var showStreaks = true

    var body: some View {
        if let habit = store.habits.first(where: { $0.id == habitID }) {
            page(habit)
        } else {
            ContentUnavailableView("This habit isn't here any more", systemImage: "questionmark.circle")
        }
    }

    private var day: LocalDay { store.today() }

    /// The height between the inline title and the bottom bar: about 150 pt on the 46 mm Watch, 125 on the 42 mm.
    private var firstScreen: CGFloat { max(110, WKInterfaceDevice.current().screenBounds.height - 96) }

    /// After a log here, its named Undo, one tap away (WA7, U14); a check's Undo is the main action itself (B5).
    @ViewBuilder
    private func undo(_ habit: Habit, ruled: Habit) -> some View {
        if let offer = store.undoOffer, offer.habitID == habit.id, offer.day == day, ruled.kind != .check || store.countsUp(habit, on: day) {
            Button(offer.undoLabel(for: ruled)) { store.undoEntry(offer.id) }
                .font(.footnote.weight(.semibold))
                .buttonStyle(.bordered)
                .controlSize(.small)
                .lineLimit(1)
                .accessibilityIdentifier("undo")
        }
    }

    @ViewBuilder
    private func page(_ habit: Habit) -> some View {
        let ruled = store.rule(habit, on: day)
        let running = store.timers[habit.id] != nil
        let skipped = store.isSkipped(habit, on: day)
        let paused = store.isPaused(habit, on: day)
        ScrollView {
            VStack(spacing: 14) {
                if ruled.kind == .checklist {
                    ChecklistSteps(habit: habit, ruled: ruled, day: day, locked: skipped || paused)
                } else {
                    // The first screen is the dial and nothing else but its named Undo, centred between the title and
                    // the bottom bar; today's logs, the streak and Skip today are below, reached with the Crown (B1, B2).
                    // Rows that started right under the dial showed through the bottom buttons (run 38097123253).
                    VStack(spacing: 6) {
                        DayDial(habit: habit, ruled: ruled, day: day, skipped: skipped, paused: paused, dimmed: wristDown)
                        if !wristDown { undo(habit, ruled: ruled) }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: firstScreen)
                }
                if !wristDown {
                    lower(habit, ruled: ruled)
                }
            }
            .padding(.bottom, 8)
        }
        .navigationTitle(habit.name)
        .navigationBarTitleDisplayMode(.inline)
        .background {
            if running && !wristDown {
                // A running timer tints the page in its habit's colour (Design Notes: colour can show state).
                LinearGradient(colors: [habit.color.watchColor.opacity(0.85), habit.color.watchColor.opacity(0.25), .black],
                               startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            }
        }
        .toolbar {
            if !wristDown { bar(habit, ruled: ruled, skipped: skipped, paused: paused, running: running) }
        }
        .sheet(isPresented: $more) { MoreSheet(habit: habit, day: day) }
        .confirmationDialog("Record a slip?", isPresented: $askSlip, titleVisibility: .visible) {
            Button("Record a slip") { store.slip(habit, on: day, at: store.clock(), source: .watch) }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("\(habit.name) · now, \(DayWords.clock(store.clock(), calendar: store.calendar))")
        }
        .accessibilityIdentifier("day-details")
    }

    // MARK: The bottom bar

    @ToolbarContentBuilder
    private func bar(_ habit: Habit, ruled: Habit, skipped: Bool, paused: Bool, running: Bool) -> some ToolbarContent {
        let main = mainAction(habit, ruled: ruled, running: running)
        ToolbarItemGroup(placement: .bottomBar) {
            if showsPencil(ruled) && !paused {
                Button { navigation.path.append(.logManually(habit.id)) } label: { Image(systemName: "pencil") }
                    .accessibilityLabel("Log manually")
                    .accessibilityIdentifier("log-manually")
                    .disabled(skipped)
            } else {
                Spacer()
            }
            if let main, !paused {
                Button(action: main.run) {
                    Group {
                        if let symbol = main.symbol { Label(main.title, systemImage: symbol) } else { Text(main.title) }
                    }
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .foregroundStyle(main.prominent ? Color.black : Color.white)
                }
                .buttonStyle(.borderedProminent)
                .tint(main.prominent ? Color.white : Color.white.opacity(0.2))
                .controlSize(.large)
                .disabled(skipped)
                .handGestureShortcut(.primaryAction)
                .accessibilityLabel(main.spoken ?? main.title)
                .accessibilityIdentifier("main-action")
            }
            Button { more = true } label: { Image(systemName: "ellipsis") }
                .accessibilityLabel("More")
                .accessibilityIdentifier("more")
        }
    }

    private struct MainAction {
        let title: String
        var symbol: String? = nil
        var prominent = true
        var spoken: String? = nil
        let run: () -> Void
    }

    /// The habit's one main action, in the iPhone's words (`DayActivity`), never one that completes a whole day's amount
    /// (WA8).
    private func mainAction(_ habit: Habit, ruled: Habit, running: Bool) -> MainAction? {
        let source = EntrySource.watch
        switch ruled.kind {
        case .task:
            let done = store.isDone(habit, on: day)
            return MainAction(title: done ? "Undo done" : "Mark done", prominent: !done) { log { store.toggleCheck(habit, on: day, source: source) } }
        case .check:
            if store.countsUp(habit, on: day) {
                return MainAction(title: "Add a check", prominent: !ruled.atMost) { log { store.addProgress(habit, value: 1, on: day, source: source) } }
            }
            let done = store.isDayMet(ruled, on: day)
            return MainAction(title: done ? "Undo done" : "Mark done", prominent: !done) {
                log { store.setDayDone(!done, of: habit, on: day, source: source) }
            }
        case .checklist:
            return nil
        case .amount(let unit, _):
            guard let step = ruled.quickIncrement else {
                return MainAction(title: "Log amount", prominent: !ruled.atMost) { navigation.path.append(.logManually(habit.id)) }
            }
            return MainAction(title: "+" + HabitCopy.amount(step, unit), prominent: !ruled.atMost,
                              spoken: "Add " + HabitCopy.amount(step, unit)) { log { store.increment(habit, on: day, source: source) } }
        case .duration:
            if running {
                return MainAction(title: "Pause", symbol: "pause.fill", prominent: !ruled.atMost, spoken: "Pause timer") {
                    log { store.stopTimer(habit, on: day, source: source) }
                }
            }
            return MainAction(title: "Start", symbol: "play.fill", prominent: !ruled.atMost, spoken: "Start timer") {
                log { store.startTimerOnWatch(habit) }
            }
        case .quit:
            // Available, never invited: glass, not white (U16); asks first (H7).
            return MainAction(title: "Record a slip", prominent: false) { askSlip = true }
        }
    }

    private func showsPencil(_ ruled: Habit) -> Bool {
        switch ruled.kind {
        case .amount: ruled.quickIncrement != nil
        case .duration: true
        default: false
        }
    }

    private func log(_ change: () -> Void) {
        withAnimation(.snappy(duration: 0.25)) { change() }
    }

    // MARK: Below the dial

    @ViewBuilder
    private func lower(_ habit: Habit, ruled: Habit) -> some View {
        let logs = store.dayLogs(of: habit, on: day)
        VStack(alignment: .leading, spacing: 8) {
            if ruled.kind == .checklist {
                // A checklist has no dial: its "Undo Last Step" follows the steps.
                undo(habit, ruled: ruled)
            }
            if showStreaks, habit.kind != .task, habit.kind != .quit {
                StreakCard(habit: habit, day: day)
            }
            if !logs.isEmpty && ruled.kind != .checklist {
                Text("Today's logs").font(.footnote).foregroundStyle(.secondary).padding(.leading, 4).padding(.top, 4)
                let shown = logs.count <= 3 ? logs : Array(logs.prefix(2))
                ForEach(shown) { entry in
                    Button { navigation.path.append(.log(entry.id)) } label: {
                        LogLine(entry: entry, habit: ruled)
                    }
                    .accessibilityIdentifier("log-row")
                }
                if logs.count > 3 {
                    Button { navigation.path.append(.allLogs(habit.id)) } label: {
                        HStack { Text("All \(logs.count) logs"); Spacer(); Image(systemName: "chevron.right").foregroundStyle(.secondary) }
                    }
                    .accessibilityIdentifier("all-logs")
                }
            }
            if store.canSkip(ruled) && !store.isPaused(habit, on: day) && !store.isSkipped(habit, on: day) {
                Button("Skip today") { withAnimation { store.setSkipped(habit, on: day, true) } }
                    .padding(.top, 6)
                    .accessibilityIdentifier("skip-today")
            }
        }
    }
}

/// The dial (B1, B4–B8, B10, B14, H2–H4): a ring to the goal in the habit's colour (neutral grey for a limit, U25), the
/// habit's icon, the number that matters and what it's out of.
struct DayDial: View {
    let habit: Habit
    let ruled: Habit
    let day: LocalDay
    let skipped: Bool
    let paused: Bool
    let dimmed: Bool
    @Environment(HabitStore.self) private var store

    var body: some View {
        let status = DayStatus.make(habit, on: day, store: store)
        let fraction = ringFraction()
        ZStack {
            Circle().stroke(Color.white.opacity(dimmed ? 0.1 : 0.18), lineWidth: 9)
            Circle()
                .trim(from: 0, to: fraction)
                .stroke(ringColor.opacity(dimmed ? 0.6 : 1), style: StrokeStyle(lineWidth: 9, lineCap: .round))
                .rotationEffect(.degrees(-90))
            VStack(spacing: 2) {
                Image(systemName: habit.symbol)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(skipped ? Color.secondary : habit.color.watchColor)
                centre
                if skipped {
                    Button("Undo skip") { withAnimation { store.setSkipped(habit, on: day, false) } }
                        .font(.footnote)
                        .buttonStyle(.bordered)
                        .controlSize(.mini)
                        .fixedSize()
                        .accessibilityIdentifier("undo-skip")
                }
            }
            .padding(10)
        }
        // Up to 132 pt, smaller when the first screen also holds an Undo or the Watch is the 42 mm.
        .frame(maxWidth: 132, maxHeight: 132)
        .aspectRatio(1, contentMode: .fit)
        .frame(maxWidth: .infinity)
        .padding(.top, 2)
        .accessibilityElement(children: skipped ? .contain : .ignore)
        .accessibilityLabel(status.title + (status.detail.map { ", " + $0 } ?? ""))
        .accessibilityIdentifier("dial")
    }

    private var ringColor: Color {
        if ruled.atMost { return Color(white: 0.82) }
        return store.isDone(habit, on: day) || store.timers[habit.id] != nil ? habit.color.watchColor : habit.color.watchColor
    }

    private func ringFraction() -> Double {
        if skipped || paused || habit.kind == .quit { return 0 }
        if ruled.kind == .task { return store.isDone(habit, on: day) ? 1 : 0 }
        if !ruled.frequency.isDayBased {
            let goal = store.goal(of: habit)
            return goal > 0 ? min(1, store.progress(of: habit, on: day) / goal) : 0
        }
        let goal = store.dayGoal(of: ruled)
        return goal > 0 ? min(1, store.dayProgress(of: ruled, on: day) / goal) : 0
    }

    @ViewBuilder
    private var centre: some View {
        if paused {
            big("Paused")
            small(store.pause(of: habit, on: day).map { DayWords.paused($0, calendar: store.calendar) } ?? "")
        } else if skipped {
            big("Skipped")
        } else {
            switch ruled.kind {
            case .quit: quit
            case .task, .check where !store.countsUp(habit, on: day) && ruled.frequency.isDayBased:
                let done = store.isDone(habit, on: day)
                big(done ? "Done" : "Not yet")
                small(doneWhen(done))
            case .check:
                let periodic = !ruled.frequency.isDayBased
                let value = periodic ? store.progress(of: habit, on: day) : store.dayProgress(of: ruled, on: day)
                let goal = periodic ? store.goal(of: habit) : store.dayGoal(of: ruled)
                big("\(HabitCopy.number(value))/\(HabitCopy.number(goal))")
                small(periodic ? DayStatus.periodWord(ruled.frequency).trimmingCharacters(in: .whitespaces)
                      : (ruled.checkUnit ?? "times") + " today")
            case .duration:
                duration
            case .amount(let unit, _):
                let periodic = !ruled.frequency.isDayBased
                let value = periodic ? store.progress(of: habit, on: day) : store.dayProgress(of: ruled, on: day)
                let goal = periodic ? store.goal(of: habit) : store.dayGoal(of: ruled)
                big(Format.amount(value))
                small("of " + HabitCopy.amount(goal, unit) + (ruled.atMost ? " max" : "") + DayStatus.periodWord(ruled.frequency))
                if ruled.atMost { limitWord(value: value, goal: goal) }
            case .checklist:
                EmptyView()
            }
        }
    }

    @ViewBuilder
    private var duration: some View {
        let goal = store.dayGoal(of: ruled)
        let saved = store.entries(of: habit.id, on: day).filter { $0.stepID == nil }.reduce(0) { $0 + $1.value }
        if let start = store.timers[habit.id] {
            if dimmed {
                // Wrist down (B8): minutes, not seconds, dimmed.
                big(Format.minutes((saved + Date.now.timeIntervalSince(start) / 60).rounded(.down)))
                    .foregroundStyle(.secondary)
            } else {
                // The clock is drawn from the start time (WA10, S3): the total today, live.
                Text(timerInterval: start.addingTimeInterval(-saved * 60)...Date.distantFuture, countsDown: false)
                    .font(.system(size: 30, weight: .bold, design: .rounded).monospacedDigit())
                    .minimumScaleFactor(0.6).lineLimit(1)
            }
        } else {
            big(Format.minutes(saved.rounded(.down)))
        }
        small("of " + Format.minutes(goal) + (ruled.atMost ? " max" : ""))
        if ruled.atMost { limitWord(value: saved, goal: goal) }
    }

    @ViewBuilder
    private var quit: some View {
        QuitRunText(habit: habit)
            .font(.system(size: 26, weight: .bold, design: .rounded))
            .minimumScaleFactor(0.6).lineLimit(1)
        let runs = store.quitRuns(of: habit, now: store.clock())
        if let since = store.slips(of: habit).last ?? habit.quitSince {
            small("since " + DayWords.short(LocalDay(since, calendar: store.calendar), calendar: store.calendar)
                  + ", " + DayWords.clock(since, calendar: store.calendar))
        }
        if runs.best > runs.current {
            Text("Best " + RunWords.short(runs.best)).font(.footnote.weight(.semibold))
        }
    }

    /// "Daily limit", then "Limit reached" or "Over the limit", plainly (H2, H3, U3).
    private func limitWord(value: Double, goal: Double) -> some View {
        Text(value > goal ? "Over the limit" : value == goal ? "Limit reached" : "Daily limit")
            .font(.footnote.weight(.semibold))
    }

    private func doneWhen(_ done: Bool) -> String {
        guard done, let last = store.entries(of: habit.id, on: day).last else { return "Today" }
        return "Today, " + store.clockText(of: last)
    }

    private func big(_ text: String) -> some View {
        Text(text).font(.system(size: 30, weight: .bold, design: .rounded)).minimumScaleFactor(0.5).lineLimit(1)
    }

    private func small(_ text: String) -> some View {
        Text(text).font(.footnote).foregroundStyle(.secondary).multilineTextAlignment(.center).lineLimit(2).minimumScaleFactor(0.8)
    }
}

/// A checklist is a list (B9): tap a step to tick it; done when all are.
struct ChecklistSteps: View {
    let habit: Habit
    let ruled: Habit
    let day: LocalDay
    let locked: Bool
    @Environment(HabitStore.self) private var store

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            let done = Int(store.dayProgress(of: ruled, on: day))
            Text("\(done) of \(ruled.steps.count) steps").font(.footnote).foregroundStyle(.secondary).padding(.leading, 4)
            ForEach(ruled.steps) { step in
                let ticked = store.isStepDone(step, of: ruled, on: day)
                Button {
                    withAnimation(.snappy(duration: 0.25)) { store.toggleStep(step, of: ruled, on: day, source: .watch) }
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: ticked ? "checkmark.circle.fill" : "circle")
                            .font(.title3)
                            .foregroundStyle(ticked ? habit.color.watchColor : Color.secondary)
                        Text(step.name).lineLimit(2).foregroundStyle(ticked ? Color.secondary : Color.primary)
                        Spacer(minLength: 0)
                    }
                }
                .disabled(locked)
                .accessibilityValue(ticked ? "Done" : "Not done")
                .accessibilityIdentifier("step-\(step.name)")
            }
        }
    }
}

/// "🔥 30 days in a row · Best 42" (H10). Show Streaks off hides it, as on the iPhone.
struct StreakCard: View {
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store

    var body: some View {
        let current = store.streak(of: habit, asOf: day)
        let unit = store.rule(habit, on: day).frequency.streakUnit
        if current > 0 {
            HStack(spacing: 8) {
                Text("🔥").font(.title3)
                Text("\(current)").font(.title3.weight(.bold).monospacedDigit())
                VStack(alignment: .leading, spacing: 0) {
                    Text(unit.inARow(current).replacingOccurrences(of: "\(current) ", with: "")).font(.footnote)
                    Text("Best \(store.bestStreak(of: habit))").font(.footnote).foregroundStyle(.secondary)
                }
                Spacer(minLength: 0)
            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 18, style: .continuous).fill(WatchPalette.platter))
            .accessibilityElement(children: .combine)
            .accessibilityIdentifier("streak")
        }
    }
}

/// One log's line: what and when (B2).
struct LogLine: View {
    let entry: Entry
    let habit: Habit
    @Environment(HabitStore.self) private var store

    var body: some View {
        HStack {
            Text(LogWords.what(entry, habit: habit)).lineLimit(1)
            Spacer(minLength: 4)
            Text(store.clockText(of: entry)).foregroundStyle(.secondary).monospacedDigit()
        }
    }
}

enum LogWords {
    /// "+1 glass", "20 min", "Done", "Slip": a log as Today's Undo names it, without the "Undo".
    static func what(_ entry: Entry, habit: Habit) -> String {
        let undo = entry.undoLabel(for: habit)
        if undo.hasPrefix("Undo +") { return String(undo.dropFirst(5)) }
        if entry.stepID != nil { return entry.description(for: habit) }
        return entry.description(for: habit)
    }
}

/// ⋯ More (B13): only what this habit can do here, plus Open on iPhone.
struct MoreSheet: View {
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store
    @Environment(WatchNavigation.self) private var navigation
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        let ruled = store.rule(habit, on: day)
        List {
            if case .amount = ruled.kind {
                Button("Log manually") { dismiss(); navigation.path.append(.logManually(habit.id)) }
            } else if ruled.kind == .duration {
                Button("Log manually") { dismiss(); navigation.path.append(.logManually(habit.id)) }
            }
            if store.isSkipped(habit, on: day) {
                Button("Undo skip") { store.setSkipped(habit, on: day, false); dismiss() }
            } else if store.canSkip(ruled) && !store.isPaused(habit, on: day) {
                Button("Skip today") { store.setSkipped(habit, on: day, true); dismiss() }
                    .accessibilityIdentifier("more-skip")
            }
            Button("Open on iPhone") { dismiss() }
                .accessibilityIdentifier("open-on-iphone")
        }
        .navigationTitle(habit.name)
        .userActivity(WatchHandoff.openHabit) { activity in
            activity.userInfo = ["habit": habit.id.uuidString]
            activity.isEligibleForHandoff = true
        }
    }
}

/// Handoff to the iPhone: "Open on iPhone" and "Continue on iPhone" (G1) leave the app's icon in the iPhone's app
/// switcher, opening at the same place.
enum WatchHandoff {
    static let openHabit = "com.oftenenough.app.open-habit"
    static let openPlus = "com.oftenenough.app.open-plus"
}
