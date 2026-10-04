import SwiftUI
import UIKit

/// "3/8 glasses", "12/20 min", "2/3 this week", "1/4 steps", "1/3 times", "0/2 cups max": one format for every habit.
/// While a timer runs, time is a live clock instead: "7:42/20 min" ("Timing a Habit", 28 Sep).
func goalLine(_ habit: Habit, progress: Double, goal: Double, running: Bool = false) -> String {
    let period = switch habit.frequency {
    case .perWeek: " this week"
    case .perMonth: " this month"
    case .perYear: " this year"
    default: ""
    }
    // A limit reads like any count, with "max" after it (as the player says it): "1/2 cups max" (3 Oct 2026).
    let max = habit.atMost ? " max" : ""
    switch habit.kind {
    case .duration:
        // Time is always hours and minutes: "12 min/1 h 30 min".
        let done = running ? Format.clock(progress) : Format.minutes(progress.rounded(.down))
        return "\(done)/\(Format.minutes(goal))\(max)\(period)"
    case .amount(let unit, _):
        // No unit: just the numbers ("3/8").
        return "\(Format.amount(progress))/\(Format.amount(goal))\(unit.isEmpty ? "" : " " + unit)\(max)\(period)"
    case .checklist:
        return "\(Format.amount(progress))/\(Format.amount(goal)) steps\(period)"
    case .check where habit.checkUnit != nil:
        return "\(Format.amount(progress))/\(Format.amount(goal)) \(habit.checkUnit!)\(period)"
    case .check:
        // Counted with no unit of its own: "1/3 times", so the number never stands alone.
        return "\(Format.amount(progress))/\(Format.amount(goal))\(habit.frequency.isDayBased ? " times" : "")\(max)\(period)"
    case .quit, .task:
        return "\(Format.amount(progress))/\(Format.amount(goal))\(max)\(period)"
    }
}

/// A task's line always says it's a task (report "Today's Rows — The Line Under the Name": people want tasks and habits
/// told apart), then its time if set, or where it came from if it moved forward: "Task", "Task · 5:00 PM".
func taskLine(_ habit: Habit, shownOn day: LocalDay, calendar: Calendar) -> String {
    var parts = ["Task"]
    if let due = habit.dueDay, due < day {
        parts.append("From " + due.date(calendar: calendar).formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)))
    }
    if let minute = habit.dueMinute {
        let time = calendar.date(bySettingHour: minute / 60, minute: minute % 60, second: 0, of: .now)!
        parts.append(time.formatted(date: .omitted, time: .shortened))
    }
    return parts.joined(separator: " · ")
}

struct HabitRow: View {
    /// Names in tight places (the timer bar, a sheet's title) show this many characters, then "…". Rows use their
    /// width instead, ending in "…" only when they run out (report "Today's Rows — The Line Under the Name").
    static let nameShown = 15
    let habit: Habit
    let day: LocalDay
    let isToday: Bool
    /// For a habit in several day sections: the section this row ticks.
    var slot: String? = nil
    /// The row's earliest time, shown after the goal ("0/1 · 7:00 AM") so Today says why it's here.
    var time: ReminderTime? = nil
    /// Flashes briefly after the habit is added.
    var highlighted = false
    /// The New Habit preview: replaces the progress line ("—" before an amount is set).
    var lineOverride: String? = nil
    /// The one sheet a row can show: one `.sheet(item:)`, never one modifier per sheet (PERFORMANCE.md rule 10).
    @State private var sheet: RowSheet?
    /// The log sheet was the one shown: when it closes, the row holds its place as after a tap (#58).
    @State private var logged = false
    /// A checklist's steps shown under it on Today (`TodayLayout`); nil elsewhere (the New Habit preview).
    var steps: FoldBox? = nil
    @Environment(HabitStore.self) private var store
    /// Today's layout: a log holds the rows in place until the person pauses (#58). Nil in the New Habit preview.
    @Environment(TodayLayout.self) private var layout: TodayLayout?
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    /// Today's navigation stack, for Open Habit Page from the touch-and-hold menu. Nil in the New Habit preview.
    @Environment(MenuModel.self) private var menu: MenuModel?
    /// Progress's view option "Show Streaks" (report §7.6): off hides streaks here too.
    @AppStorage(ProgressOptions.showStreaks) private var showStreaks = true

    var body: some View {
        let _ = perfTimed("Count: a Today row drawn") { () }
        if habit.kind == .duration {
            // Keep the same host when a running timer stops, and on every day: replacing TimelineView with a plain row
            // could dismiss a sheet opened from that row, and switching the day rebuilt every duration row twice
            // (rule 4). A stopped, covered or other day's clock simply has no ticks.
            RowClock(start: isToday && sheet == nil && store.dayTarget?.habitID != habit.id ? store.timers[habit.id] : nil) { now in
                row(now: now)
            }
        } else {
            row(now: .now)
        }
    }

    private func showing(_ kind: RowSheet) -> Binding<Bool> {
        Binding(get: { sheet == kind }, set: { if $0 { sheet = kind } else if sheet == kind { sheet = nil } })
    }

    private var isRunning: Bool { isToday && store.timers[habit.id] != nil }

    @ViewBuilder
    private func row(now: Date) -> some View {
        let progress = store.progress(of: habit, on: day, now: now)
        // Past days show the goal they had (goal history, spec §8.2).
        let goal = store.goal(of: store.rule(habit, on: day))
        // A cut-back habit is "met" while under its maximum, but never shown as finished.
        let done = slot.map { store.isSlotDone(habit, slot: $0, on: day) } ?? (store.isDone(habit, on: day) && !habit.atMost)
        let streak = showStreaks ? store.streak(of: habit, asOf: day) : 0
        // One shape for every row (report "Today's Rows — The Line Under the Name", 3 Oct 2026): the icon, the name with
        // its one line, the streak and the button centred on one 44-pt band; after a log, one line of small buttons
        // under the text. Nothing else stacks up, so no row runs past three lines and icons line up down the list.
        VStack(alignment: .leading, spacing: 0) {
          HStack(alignment: .center, spacing: RowSpace.iconToText) {
            HStack(alignment: .center, spacing: RowSpace.iconToText) {
              HabitIcon(symbol: habit.symbol, color: habit.color)
              VStack(alignment: .leading, spacing: RowSpace.nameToLine) {
                  // One line: the name uses the row's width and ends in "…" only when it runs out (U6 allows 24).
                  Text(habit.name).font(.body).foregroundStyle(done ? .secondary : .primary).lineLimit(1)
                  // What today asks of it, the same kind of fact on every row: how much and how far along, or how
                  // often; then its time. Exactly one line.
                  Text(lineOverride ?? rowLine(progress: progress, goal: goal))
                      .font(.subheadline).foregroundStyle(isRunning ? .primary : .secondary)
                      .monospacedDigit()
                      .lineLimit(1)
                      .accessibilityIdentifier("habit-line")
              }
              Spacer(minLength: RowSpace.textToTrailing)
              if streak > 0 {
                  StreakLabel(count: streak, unit: habit.frequency.streakUnit, onFill: progress / max(goal, 1) >= 0.7)
              }
            }
            .contentShape(Rectangle())
            // The row opens its Day sheet for the day Today shows; the round button logs (the user, 3 Oct 2026; report
            // "Today's Rows": Reminders, Mail and Health open the item from its row and act from its control). A named
            // action only: a button trait, a default action or a hint on this container merges its texts into one
            // element, so names stop reading as text (CI, 3 Oct 2026; Rulebook T9).
            .onTapGesture { openDay() }
            .accessibilityAction(named: "Show Day") { openDay() }
            .accessibilityAction(named: "Undo last log") {
                if let entry = store.undoOffer, entry.habitID == habit.id, entry.day == day { store.undoEntry(entry.id) }
            }
            actionButton(done: done, progress: progress, goal: goal)
                .disabled(habit.kind != .checklist && day > store.today())
          }
          .frame(minHeight: RowBand.height)
          // Undo and Add Note after a log, in their own small view so a tap redraws that line, not every row (L16).
          if lineOverride == nil { RowAfterLog(habit: habit, day: day) }
        }
        .padding(.vertical, RowSpace.rowPadding)
        .listRowBackground(ProgressFill(progress: habit.atMost ? 0 : progress / max(goal, 1), color: habit.color)
            .overlay(NoteTargetFlash(habit: habit, day: day, highlighted: highlighted)))
        // Logged from the sheet: the row stays where it is until the person pauses, as after a tap (#58). The day's own
        // rule, so a past day is logged against the goal it had then.
        .sheet(item: $sheet, onDismiss: {
            if logged { logged = false; layout?.hold(reduceMotion: reduceMotion) }
        }) { shown in
            switch shown {
            case .log: AddEntryView(habit: habit, day: day).onAppear { logged = true }
            case .edit: EditHabitSheet(habit: habit)
            case .notes: HabitNotesView(habit: habit)
            case .pause: PauseSheet(habit: habit)
            }
        }
        // Swipe left: a note (the full swipe, harmless), Skip and Pause, each a labelled button the swipe reveals; never an
        // action performed unseen (report "Today's Rows": accidental skips and "which way is which" came from swipes
        // that act on their own).
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            if day <= store.today() && lineOverride == nil {
                Button { startWriting() } label: { Label(store.note(of: habit, on: day) == nil ? "Note" : "Edit Note", systemImage: "note.text") }
                    .tint(.indigo)
                if habit.kind != .task { RowSkipButton(habit: habit, day: day) }
                if habit.kind != .task { RowPauseButton(habit: habit, showPause: showing(.pause)) }
            }
        }
        // Swipe right: Undo, saying what it takes back ("Undo +1 glass"), when this day has an entry. No full swipe.
        .swipeActions(edge: .leading, allowsFullSwipe: false) {
            if lineOverride == nil, day <= store.today(), let entry = store.entries(of: habit.id, on: day).last {
                Button { undo(entry) } label: { Label(entry.undoLabel(for: store.rule(habit, on: day)), systemImage: "arrow.uturn.backward") }
                    .tint(.gray)
                    .accessibilityIdentifier("row-swipe-undo")
            }
        }
        .contextMenu {
            if lineOverride == nil {
                // The same actions as the Day sheet, for people who touch and hold (report "Today's Rows"). No Delete:
                // it lives in the sheet's ⋯ menu, asking first.
                if habit.kind != .task, let menu {
                    Button("Open Habit Page", systemImage: "chart.bar.doc.horizontal") { menu.path.append(HabitPageRoute(id: habit.id)) }
                }
                Button(habit.kind == .task ? "Edit Task" : "Edit Habit", systemImage: "pencil") { sheet = .edit }
                if habit.kind != .task && habit.kind != .checklist {
                    Button("Add Entry…", systemImage: "plus") { sheet = .log }.disabled(day > store.today())
                }
                // Any day, done or not, past or today; a note never changes progress (notes report, 29 Sep).
                Button(store.note(of: habit, on: day) == nil ? "Add Note" : "Edit Note", systemImage: "note.text") { startWriting() }
                    .disabled(day > store.today())
                if habit.kind != .task {
                    if store.isSkipped(habit, on: day) {
                        Button("Undo Skip", systemImage: "arrow.uturn.backward") { store.setSkipped(habit, on: day, false) }
                    } else if store.canSkip(store.rule(habit, on: day)) && !store.isPaused(habit, on: day) && day <= store.today() {
                        Button(day == store.today() ? "Skip Today" : "Skip This Day", systemImage: "forward") { store.setSkipped(habit, on: day, true) }
                    }
                    // A stretch of days off: travel, illness (pause report, 29 Sep).
                    PauseMenuItems(habit: habit, showPause: showing(.pause))
                }
                if day <= store.today(), let entry = store.entries(of: habit.id, on: day).last {
                    Button(entry.undoLabel(for: store.rule(habit, on: day)), systemImage: "arrow.uturn.backward") { undo(entry) }
                }
                if store.hasNotes(habit) {
                    Button("All Notes", systemImage: "list.bullet.rectangle") { sheet = .notes }
                }
            }
        }
    }

    /// The Day sheet for this habit or task on the day Today shows (one sheet for every row; a task's is shaped for a
    /// task: the user, 3 Oct 2026).
    private func openDay() {
        guard lineOverride == nil else { return }
        store.dayTarget = .init(habitID: habit.id, day: day)
    }

    /// Takes back exactly this entry, holding Today's order as any log does.
    private func undo(_ entry: Entry) {
        layout?.hold(reduceMotion: reduceMotion)
        TickFeedback.undone()
        withAnimation(Motion.tick(reduceMotion)) { store.undoEntry(entry.id) }
    }

    /// Every log from the row's button: hold Today's order, answer the tap (haptic, chime), then change the data inside
    /// the tick animation so the button fills and the row's colour sweeps across (research §1).
    private func log(finished: Bool, undo: Bool = false, _ change: () -> Void) {
        layout?.hold(reduceMotion: reduceMotion)
        if undo { TickFeedback.undone() } else { TickFeedback.logged(finished: finished) }
        withAnimation(Motion.tick(reduceMotion)) { change() }
    }

    // MARK: The note

    /// After a check, an amount or a stopped timer: this row offers "Add note" (and no other row does).
    private func offerNote() {
        guard day <= store.today() else { return }
        withAnimation(.easeOut(duration: 0.2)) { store.noteOffer = .init(habit: habit.id, day: day) }
    }

    /// Opens the note sheet for this habit and day (never typed in the row: the user, 3 Oct 2026). The row is marked
    /// while the sheet is up.
    private func startWriting() {
        store.noteTarget = .init(habit: habit.id, day: day)
    }

    /// The line under the name (report "Today's Rows — The Line Under the Name", 3 Oct 2026): what today asks of this
    /// habit, the same kind of fact on every row. Counted: how much and how far along ("3/8 glasses", "2/3 this week",
    /// "1/4 steps", "1/2 cups max"). A single tick: how often ("Every day", "Every Mon, Wed and Fri"), since the ✓ is
    /// its done-or-not and "0/1" says nothing. Then its time. A task says it's a task; a skipped day says so.
    private func rowLine(progress: Double, goal: Double) -> String {
        if habit.kind == .task { return taskLine(habit, shownOn: day, calendar: store.calendar) }
        let time = self.time.map { " · " + DaySection.clock($0.minuteOfDay) } ?? ""
        if store.isSkipped(habit, on: day) { return (day == store.today() ? "Skipped today" : "Skipped") + time }
        if case .flexible(let period, let needed) = habit.frequency, let count = store.flexibleProgress(habit, on: day) {
            let days = "\(count)/\(needed) \(needed == 1 ? "day" : "days") this \(period.noun)"
            // A tick on some days a week: the days are the progress. An amount or a time: today's, then the days.
            return (habit.kind == .check ? days : goalLine(habit, progress: progress, goal: goal, running: isRunning) + " · " + days) + time
        }
        if habit.kind == .check && habit.frequency.isDayBased && (slot != nil || goal <= 1) {
            return HabitCopy.capitalized(HabitCopy.rhythm(habit.frequency, weekStart: store.settings.weekStart, short: true)) + time
        }
        return goalLine(habit, progress: progress, goal: goal, running: isRunning) + time
    }

    @ViewBuilder
    private func actionButton(done: Bool, progress: Double, goal: Double) -> some View {
        if habit.kind == .checklist {
            // The button opens and closes the items; the checklist is done when every item is.
            let open = steps?.open == true
            RoundActionButton(symbol: open ? "chevron.up" : "chevron.down", done: done, color: habit.color,
                              label: open ? "Hide \(habit.name) steps" : "Show \(habit.name) steps", popsOnTap: false) {
                withAnimation(Motion.fold(reduceMotion)) { steps?.open = !open }
            }
        } else {
            switch habit.kind {
            case .check where slot == nil && store.countsUp(habit, on: day):
                // Ticked several times a day: + adds one each tap, like an amount, and never takes one back; the named
                // Undo does that (the user, 3 Oct 2026: one mental model, "✓ toggles, + adds"; report "Today's Rows").
                RoundActionButton(symbol: "plus", done: done, color: habit.color,
                                  label: "Add 1 to \(habit.name)", keepSymbolWhenDone: true, text: "+1") {
                    offerNote()
                    log(finished: progress < goal && progress + 1 >= goal) { store.addProgress(habit, value: 1, on: day) }
                }
            case .check, .task:
                // A once-a-day tick toggles that day's tick; a weekly count's day too, judged on this day only.
                let ticked = slot.map { store.isSlotDone(habit, slot: $0, on: day) }
                    ?? (habit.kind == .task ? done : store.isTicked(habit, on: day))
                RoundActionButton(symbol: "checkmark", done: ticked, color: habit.color,
                                  label: ticked ? "Undo \(habit.name)" : "Mark \(habit.name) done") {
                    if !ticked { offerNote() }
                    log(finished: !ticked && (slot != nil || progress + 1 >= goal), undo: ticked) {
                        if let slot { store.toggleSlot(habit, slot: slot, on: day) } else { store.toggleCheck(habit, on: day) }
                    }
                }
            case .amount(let unit, _):
                // The person chose on the form what + does, and the button shows it: "+1", "+250", "+1k" adds that
                // step; a plain "+" asks how much, with the number pad (29 Sep). Tapping the row always types.
                if let step = habit.quickIncrement {
                    RoundActionButton(symbol: "plus", done: done, color: habit.color,
                                      label: "Add \(HabitCopy.amount(step, unit)) to \(habit.name)",
                                      keepSymbolWhenDone: true,
                                      text: "+" + Format.amount(step)) {
                        offerNote()
                        log(finished: !habit.atMost && progress < goal && progress + step >= goal) { store.increment(habit, on: day) }
                    }
                } else {
                    RoundActionButton(symbol: "plus", done: done, color: habit.color,
                                      label: "Add an amount to \(habit.name)",
                                      keepSymbolWhenDone: true) {
                        sheet = .log
                    }
                }
            case .duration:
                let running = store.timers[habit.id] != nil
                RoundActionButton(symbol: running ? "pause.fill" : "play.fill", done: done && !running, color: habit.color,
                                  label: running ? "Stop \(habit.name) timer" : "Start \(habit.name) timer") {
                    if store.timers[habit.id] == nil {
                        TimerPresence.askOnNextSync = true
                        TickFeedback.started()
                        withAnimation(Motion.tick(reduceMotion)) { store.toggleTimer(habit, slot: slot) }
                        // And its timer opens full screen, which a swipe puts away while it keeps running (4 Oct 2026).
                        if UserDefaults.standard.bool(forKey: Preferences.timerScreen) { store.timerScreen = habit.id }
                    } else {
                        // Stopping saves the time: a log like any other.
                        offerNote()
                        log(finished: !done && progress >= goal) { store.toggleTimer(habit, slot: slot) }
                    }
                }
                .disabled(!isToday)
            case .quit, .checklist:
                EmptyView()
            }
        }
    }
}

struct StepRow: View {
    let step: Step
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store
    @Environment(TodayLayout.self) private var layout: TodayLayout?
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        let done = store.isStepDone(step, of: habit, on: day)
        HStack(spacing: 12) {
            Text(step.name).font(.subheadline).foregroundStyle(done ? .secondary : .primary).lineLimit(1)
            Spacer(minLength: 8)
            RoundActionButton(symbol: "checkmark", done: done, color: habit.color,
                              label: done ? "Undo \(step.name)" : "Mark \(step.name) done") {
                if !done { store.noteOffer = .init(habit: habit.id, day: day) }
                layout?.hold(reduceMotion: reduceMotion)
                if done { TickFeedback.undone() } else {
                    // The last step makes the checklist done.
                    TickFeedback.logged(finished: habit.steps.allSatisfy { $0.id == step.id || store.isStepDone($0, of: habit, on: day) })
                }
                withAnimation(Motion.tick(reduceMotion)) { store.toggleStep(step, of: habit, on: day) }
            }
        }
        .disabled(day > store.today())
        // Step names start where row names do; a step has no line of its own (it's part of the row above).
        .padding(.leading, RowSpace.textLeading)
        .padding(.vertical, -6)
    }
}

/// A row's brief flash after it's added: a tint over the row, faded in and out by the caller.
struct HighlightFlash: View {
    let on: Bool
    let color: HabitColor
    var body: some View { color.color.opacity(on ? 0.3 : 0).allowsHitTesting(false) }
}

struct QuitRow: View {
    let habit: Habit
    var highlighted = false
    @Environment(HabitStore.self) private var store
    @Environment(MenuModel.self) private var menu: MenuModel?
    /// One `.sheet(item:)` for the row's three sheets (PERFORMANCE.md rule 10).
    @State private var sheet: QuitSheet?
    /// The slip just logged, offered for Undo for a few seconds.
    @State private var lastSlip: UUID?
    /// Progress's "Show Streaks": off hides the best run too (report "Today's Rows — The Line Under the Name").
    @AppStorage(ProgressOptions.showStreaks) private var showStreaks = true
    private var today: LocalDay { store.today() }
    /// Set once, on a whole second, so every quit clock ticks together.
    private static let anchor = Date(timeIntervalSinceReferenceDate: Date.now.timeIntervalSinceReferenceDate.rounded(.down))

    var body: some View {
        // The history is walked when the row's data changes, never per second: only the two times below tick
        // (PERFORMANCE.md rule 3). The whole row used to sit in the clock, rebuilt and re-walked every second (1 Oct).
        let history = store.quitHistory(of: habit)
        let ongoing = history.last.flatMap { $0.endedBy == .ongoing ? $0.start : nil }
        let pastBest = history.dropLast(ongoing == nil ? 0 : 1).map { $0.length(now: .now) }.max() ?? 0
        let current = { (now: Date) in ongoing.map { max(0, now.timeIntervalSince($0)) } ?? 0 }
        // A fixed anchor: `.now` gave a new schedule on every redraw, restarting the clock each time (see HabitRow).
        // No ongoing run (paused): nothing ticks.
        let tick = ongoing == nil ? nil : Self.anchor
        // The same shape as every habit row (report "Today's Rows — The Line Under the Name", 3 Oct 2026): icon, name,
        // one line (the best run, the one other fact people value), and the live count where other rows have their
        // button. No "Slipped" line under everything: a slip is logged from the row's sheet, a swipe or the menu.
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: RowSpace.iconToText) {
                HabitIcon(symbol: habit.symbol, color: habit.color)
                VStack(alignment: .leading, spacing: RowSpace.nameToLine) {
                    Text(habit.name).font(.body).lineLimit(1)
                    if showStreaks {
                        RowClock(start: tick) { now in
                            Text("Best \(Format.days(max(pastBest, current(now))))")
                                .font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
                                .accessibilityIdentifier("habit-line")
                        }
                    } else {
                        // Streaks hidden (Progress → Show Streaks): no record to compare with, just when this run began.
                        Text(ongoing.map { "Since " + $0.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)) } ?? "Paused")
                            .font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
                            .accessibilityIdentifier("habit-line")
                    }
                }
                Spacer(minLength: RowSpace.textToTrailing)
                RowClock(start: tick) { now in
                    Text(Format.elapsed(current(now)))
                        .font(.body.monospacedDigit().weight(.semibold))
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                        .fixedSize()
                }
            }
            .frame(minHeight: RowBand.height)
            .contentShape(Rectangle())
            // The row opens its Day sheet, as every habit row does (report "Today's Rows").
            .onTapGesture { store.dayTarget = .init(habitID: habit.id, day: today) }
            // A named action only, never a trait, default action or hint here (they merge the texts: Rulebook T9).
            .accessibilityAction(named: "Show Day") { store.dayTarget = .init(habitID: habit.id, day: today) }
            // After a slip: the same small buttons as every row, Undo Slip and the note.
            if let id = lastSlip {
                QuitAfterSlip(habit: habit, day: today, slip: id) { withAnimation { lastSlip = nil } }
            }
        }
        .padding(.vertical, RowSpace.rowPadding)
        .listRowBackground(Color(.secondarySystemGroupedBackground).overlay(HighlightFlash(on: highlighted, color: habit.color)))
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button { store.noteTarget = .init(habit: habit.id, day: today) } label: {
                Label(store.note(of: habit, on: today) == nil ? "Note" : "Edit Note", systemImage: "note.text")
            }
            .tint(.indigo)
            // Where the "Slipped" button was (U5): one swipe away, opening Log a Slip, never logging unseen.
            Button { sheet = .slip } label: { Label("Log Slip", systemImage: "arrow.uturn.backward.circle") }
                .tint(.gray)
                .disabled(store.isPaused(habit, on: today))
                .accessibilityIdentifier("row-swipe-slip")
            RowPauseButton(habit: habit, showPause: Binding(get: { sheet == .pause }, set: { sheet = $0 ? .pause : (sheet == .pause ? nil : sheet) }))
        }
        .contextMenu {
            if let menu {
                Button("Open Habit Page", systemImage: "chart.bar.doc.horizontal") { menu.path.append(HabitPageRoute(id: habit.id)) }
            }
            Button("Edit Habit", systemImage: "pencil") { sheet = .edit }
            // A slip is an event with its own time (Build Plan #60d); editing "Started" is only for fixing a wrong start.
            Button("Log a Slip…", systemImage: "arrow.uturn.backward.circle") { sheet = .slip }
            // Pausing ends this run (kept as a run, not a slip); a new one starts when it's back (the user, 29 Sep).
            PauseMenuItems(habit: habit, showPause: Binding(get: { sheet == .pause }, set: { sheet = $0 ? .pause : (sheet == .pause ? nil : sheet) }))
            Button(store.note(of: habit, on: today) == nil ? "Add Note" : "Edit Note", systemImage: "note.text") {
                store.noteTarget = .init(habit: habit.id, day: today)
            }
        }
        .sheet(item: $sheet) { shown in
            switch shown {
            case .edit: EditHabitSheet(habit: habit)
            case .pause: PauseSheet(habit: habit)
            case .slip: LogSlipSheet(habit: habit) { id in withAnimation { lastSlip = id } }
            }
        }
    }
}

/// The first row of every card: name, Now, folded icons, then "N left" (or ✓), Start and the fold chevron.
///
/// "N left" always shows, open or folded: it's what people open the app to see. Start: "▶ Start" when
/// open, ▶ alone when folded, primary in the Now section; a folded section that isn't Now has no ▶, so
/// its icons get the room (research: "Section Header — Start Button, Left Count and Icons").
/// Space goes, in order of importance: the status and Start never shrink. Folded, the name shows at
/// most 8 letters and the icons take the rest; open, the name gets whatever is left and ends in "…".
struct PartHeader: View {
    let title: String
    let habits: [Habit]
    /// Habits still to do; nil for the Quitting card, which has no status.
    let left: Int?
    let isNow: Bool
    let isOpen: Bool
    let onStart: (() -> Void)?
    let onToggle: () -> Void
    /// "Starts 6 AM" under a timed section's name, folded or open; nil for Anytime, Quitting and Paused. On its own
    /// line, so it never takes room from the folded icons or "N left" (the user, 3 Oct 2026).
    var subtitle: String? = nil

    /// The width for the name, Now and the icons, and the name's full one-line width.
    @State private var room: CGFloat = 0
    @State private var titleWidth: CGFloat = 0

    /// At least this much space between the icons and "2 left" / ✓.
    static let statusGap: CGFloat = 12

    /// The caller provides Start for unfinished habits or limit check-ins today; folded only in Now.
    private var showsStart: Bool { onStart != nil && (isOpen || isNow) }

    private var iconCount: Int? {
        guard !isOpen, room > 0 else { return nil }
        let now: CGFloat = isNow ? 52 : 0
        return FoldedIcons.fitting(habits.count, in: room - now - titleWidth - 10)
    }

    /// Folded, the name shows at most 8 letters and "…", so the icons get the room.
    /// (A 9-letter name, like Afternoon, is shown whole: "Afternoo…" would be no shorter.)
    private var shownTitle: String {
        guard !isOpen, title.count > 9 else { return title }
        return title.prefix(8).trimmingCharacters(in: .whitespaces) + "…"
    }

    private var status: String? {
        guard let left else { return nil }
        return left == 0 ? "All done" : "\(left) left"
    }

    var body: some View {
        HStack(spacing: Self.statusGap) {
            titleArea
            controls
        }
        .frame(minHeight: 44)
    }

    private var titleArea: some View {
        VStack(alignment: .leading, spacing: 1) {
            HStack(spacing: 8) {
                Text(shownTitle).font(.headline).lineLimit(1)
                    .background {
                        Text(shownTitle).font(.headline).lineLimit(1).fixedSize().hidden()
                            .onGeometryChange(for: CGFloat.self) { $0.size.width } action: { titleWidth = $0 }
                    }
                if isNow { NowChip().fixedSize() }
                if let count = iconCount {
                    // Folding: the icons fade in from the name's side as the rows go back under the header (#59).
                    FoldedIcons(habits: habits, max: count).fixedSize().padding(.leading, 2)
                        .transition(.opacity.combined(with: .scale(scale: 0.9, anchor: .leading)))
                }
            }
            if let subtitle {
                Text(subtitle).font(.footnote).foregroundStyle(.secondary).lineLimit(1)
            }
        }
            .frame(maxWidth: .infinity, alignment: .leading)
            .onGeometryChange(for: CGFloat.self) { $0.size.width } action: { room = $0 }
            // VoiceOver reads the header as one button; Start stays its own button.
            .accessibilityElement(children: .ignore)
            .accessibilityLabel([title, subtitle, isNow ? "Now" : nil, status ?? "\(habits.count) habits"].compactMap { $0 }.joined(separator: ", "))
            .accessibilityValue(isOpen ? "Open" : "Folded")
            .accessibilityAddTraits(.isButton)
            .accessibilityHint(isOpen ? "Folds this part" : "Opens this part")
            .contentShape(Rectangle())
            .onTapGesture(perform: onToggle)
            .accessibilityAction { onToggle() }

    }

    private var controls: some View {
            HStack(spacing: 8) {
                if left == 0 {
                    // Done: a ✓ in about 20 pt, where "✓ All done" took about 78. VoiceOver says "All done".
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(.secondary)
                        .accessibilityHidden(true)
                        // The last habit of the part: the ✓ grows in with the row's own tick (#58).
                        .transition(.scale(scale: 0.4).combined(with: .opacity))
                } else if let status {
                    Text(status).font(.subheadline).monospacedDigit().foregroundStyle(.secondary).accessibilityHidden(true)
                }
                if showsStart, let onStart {
                    StartButton(compact: !isOpen, primary: isNow, title: title, action: onStart)
                }
                Button(action: onToggle) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .rotationEffect(.degrees(isOpen ? 90 : 0))
                        .frame(width: 36, height: 44)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .padding(.trailing, -8)
                .accessibilityLabel("\(isOpen ? "Fold" : "Open") \(title)")
            }
            .lineLimit(1)
            // Never squeezed: the name gives way instead.
            .fixedSize()
    }

}

/// Starts a section's routine. Open: "▶ Start"; folded: ▶ alone. Primary (filled ink) in the Now section,
/// grey elsewhere. Always a 44 pt tall target.
struct StartButton: View {
    let compact: Bool
    let primary: Bool
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: "play.fill").font(.system(size: 12, weight: .bold))
                if !compact { Text("Start").font(.subheadline.weight(.semibold)) }
            }
            .foregroundStyle(primary ? Color.onInk : Color.ink)
            .frame(width: compact ? 34 : nil, height: 34)
            .padding(.horizontal, compact ? 0 : 14)
            .background(Capsule().fill(primary ? Color.ink : Color(.tertiarySystemFill)))
            .frame(minWidth: 44, minHeight: 44)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Start \(title) routine")
        .accessibilityHint("Opens unfinished habits, one at a time")
        .accessibilityIdentifier("start-\(title)")
    }
}

struct FoldedIcons: View {
    let habits: [Habit]
    var max = 4

    /// Each icon, and the "+N" square, is 22 pt plus 4 pt spacing.
    private static let step: CGFloat = 26

    /// How many icons fit in `width`, leaving room for a "+N" square for the rest; nil when not even that fits.
    static func fitting(_ count: Int, in width: CGFloat, limit: Int = 6) -> Int? {
        for n in stride(from: min(limit, count), through: 0, by: -1) {
            let squares = CGFloat(n + (count > n ? 1 : 0))
            if squares * step - 4 <= width + 1 { return n } // 1 pt for rounding
        }
        return nil
    }

    var body: some View {
        HStack(spacing: 4) {
            ForEach(habits.prefix(max)) { HabitIcon(symbol: $0.symbol, color: $0.color, size: 22) }
            if habits.count > max {
                // The rest, as a square the same shape as the icons.
                Text("+\(habits.count - max)")
                    .font(.system(size: 11, weight: .bold).monospacedDigit())
                    .foregroundStyle(.secondary)
                    .lineLimit(1).fixedSize()
                    .padding(.horizontal, 2)
                    .frame(minWidth: 22, minHeight: 22)
                    .background(RoundedRectangle(cornerRadius: 22 * 0.28, style: .continuous).fill(Color(.tertiarySystemFill)))
            }
        }
    }
}

/// Edit a saved habit: the New Habit form on it, filled in (spec §8). Always the latest saved version.
struct EditHabitSheet: View {
    let habit: Habit
    var onSaved: () -> Void = {}
    @Environment(HabitStore.self) private var store

    var body: some View {
        NavigationStack {
            HabitForm(editing: store.habits.first { $0.id == habit.id } ?? habit, weekStart: store.settings.weekStart,
                      description: store.description(of: habit) ?? "", group: store.groupOf[habit.id]) { _ in onSaved() }
        }
    }
}

/// The band every row's icon, name and line, streak and button are centred on (the row's minimum height).
enum RowBand { static let height: CGFloat = 44 }

/// A fixed timer anchor while running, one initial draw while stopped or covered by its sheet.
/// Today's clocks stop while a page from the ≡ menu covers Today (PERFORMANCE.md rule 6): the quit clocks and a
/// running row's clock otherwise redrew every second under All Habits, a habit page or Progress (profile, 1 Oct
/// 2026). They pick up the right time as soon as Today shows again.
private nonisolated struct ClocksPausedKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    nonisolated var clocksPaused: Bool {
        get { self[ClocksPausedKey.self] }
        set { self[ClocksPausedKey.self] = newValue }
    }
}

/// A running row's clock: the only part of a Today row that reads `clocksPaused`. When the row read it, every row on
/// Today redrew each time a menu page opened or closed, not only the rows with a clock (1 Oct 2026).
private struct RowClock<Content: View>: View {
    let start: Date?
    @ViewBuilder let content: (Date) -> Content
    @Environment(\.clocksPaused) private var clocksPaused

    var body: some View {
        TimelineView(HabitRowClockSchedule(start: clocksPaused ? nil : start)) { context in
            content(context.date)
        }
    }
}

private struct HabitRowClockSchedule: TimelineSchedule {
    let start: Date?
    func entries(from date: Date, mode: TimelineScheduleMode) -> AnySequence<Date> {
        guard let start else { return AnySequence([date]) }
        return AnySequence(PeriodicTimelineSchedule(from: start, by: 1).entries(from: date, mode: mode))
    }
}

/// The sheets a Today row can open, one at a time.
enum RowSheet: String, Identifiable {
    case log, edit, notes, pause
    var id: String { rawValue }
}

/// The sheets a quit row can open, one at a time.
enum QuitSheet: String, Identifiable {
    case edit, pause, slip
    var id: String { rawValue }
}

/// Today's row spacing, one set of numbers for every row (report "Today's Rows — The Line Under the Name", 3 Oct
/// 2026): space inside a group smaller than around it, and no number used for two jobs.
enum RowSpace {
    /// Between a name and its line.
    static let nameToLine: CGFloat = 2
    /// Between the icon and the text, and between the text block and the round button.
    static let iconToText: CGFloat = 12
    /// At least this between the text and the streak or count on the right.
    static let textToTrailing: CGFloat = 8
    /// From the 44-pt band to the after-log buttons.
    static let afterBand: CGFloat = 6
    /// Between the after-log buttons.
    static let betweenButtons: CGFloat = 8
    /// Above and below each row, inside the list's own row spacing.
    static let rowPadding: CGFloat = 2
    /// Where text starts: the icon's width plus its gap, so the after-log buttons and step rows line up with names.
    static let textLeading: CGFloat = 32 + iconToText
}

/// After a log on this row: the named Undo, the note (Add Note, or Edit Note once there is one) and a milestone the
/// tap reached, as small capsule buttons on one line under the text (the user, 3 Oct 2026: nothing wraps, even
/// spacing, never typed in the row). Only while the offer lasts. Only this reads the store's offers, so a log redraws
/// this line, not each row's whole body (lesson L16, 2 Oct 2026).
struct RowAfterLog: View {
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let undo = store.undoOffer.flatMap { $0.habitID == habit.id && $0.day == day ? $0 : nil }
        let offered = undo != nil || store.noteOffer == .init(habit: habit.id, day: day)
        if offered {
            let mark = undo.flatMap { entry in store.milestoneOffer.flatMap { $0.entry == entry.id ? $0 : nil } }
            let note = store.note(of: habit, on: day) != nil
            // One layout, never measured twice: at the accessibility text sizes the buttons show their icons (their
            // words stay for VoiceOver); a milestone shortens with "…" before anything wraps. `ViewThatFits` measured
            // three layouts each time the line appeared and doubled the cost of changing days (speed bisect, 4 Oct 2026).
            buttons(undo: undo, note: note, mark: mark?.text, icons: typeSize.isAccessibilitySize)
                .padding(.leading, RowSpace.textLeading)
                .padding(.top, RowSpace.afterBand)
        }
    }

    private func buttons(undo: Entry?, note: Bool, mark: String?, icons: Bool) -> some View {
        HStack(spacing: RowSpace.betweenButtons) {
            if let undo {
                Button { store.undoEntry(undo.id) } label: {
                    Label(undo.undoLabel(for: habit), systemImage: "arrow.uturn.backward")
                }
                .fixedSize()
                .accessibilityIdentifier("habit-inline-undo")
            }
            if day <= store.today() {
                Button { writeNote() } label: {
                    Label(note ? "Edit Note" : "Add Note", systemImage: note ? "note.text" : "square.and.pencil")
                }
                .fixedSize()
                .accessibilityIdentifier(note ? "habit-edit-note" : "habit-add-note")
            }
            if let mark {
                // A milestone this tap reached, beside its Undo and only while that lasts: words, never a pop-up
                // (report "Milestones — Marking Progress Without Noise").
                Label(mark, systemImage: "checkmark.seal.fill")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(habit.color.color)
                    .lineLimit(1)
                    .accessibilityIdentifier("today-milestone")
            }
        }
        .labelStyle(AfterLogLabel(iconOnly: icons))
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .controlSize(.small)
        .tint(.secondary)
        .font(.caption.weight(.medium))
        .lineLimit(1)
    }

    /// Opens the note sheet for this habit and day (as the row's swipe and menu do).
    private func writeNote() {
        store.noteTarget = .init(habit: habit.id, day: day)
    }
}

/// After a slip on a quit row: Undo Slip and the note, the same small buttons as every row; gone after 8 seconds.
struct QuitAfterSlip: View {
    let habit: Habit
    let day: LocalDay
    let slip: UUID
    let onDone: () -> Void
    @Environment(HabitStore.self) private var store

    var body: some View {
        let note = store.note(of: habit, on: day) != nil
        HStack(spacing: RowSpace.betweenButtons) {
            Button { store.undoEntry(slip); onDone() } label: { Label("Undo Slip", systemImage: "arrow.uturn.backward") }
                .accessibilityIdentifier("habit-inline-undo")
            Button { store.noteTarget = .init(habit: habit.id, day: day) } label: {
                Label(note ? "Edit Note" : "Add Note", systemImage: note ? "note.text" : "square.and.pencil")
            }
            .accessibilityIdentifier(note ? "habit-edit-note" : "habit-add-note")
        }
        .labelStyle(AfterLogLabel(iconOnly: false))
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .controlSize(.small)
        .tint(.secondary)
        .font(.caption.weight(.medium))
        .lineLimit(1)
        .fixedSize()
        .padding(.leading, RowSpace.textLeading)
        .padding(.top, RowSpace.afterBand)
        .task(id: slip) {
            try? await Task.sleep(for: .seconds(8))
            onDone()
        }
    }
}

/// The after-log buttons' labels: the words with a small icon, or the icon alone when the words don't fit (the
/// accessibility label keeps the words).
private struct AfterLogLabel: LabelStyle {
    let iconOnly: Bool
    @ViewBuilder func makeBody(configuration: Configuration) -> some View {
        if iconOnly {
            configuration.icon
        } else {
            HStack(spacing: 4) { configuration.icon.imageScale(.small); configuration.title }
        }
    }
}

/// The row's brief tint while its note is being written. Only this reads `noteTarget`.
struct NoteTargetFlash: View {
    let habit: Habit
    let day: LocalDay
    let highlighted: Bool
    @Environment(HabitStore.self) private var store

    var body: some View {
        HighlightFlash(on: highlighted || store.noteTarget == .init(habit: habit.id, day: day), color: habit.color)
    }
}


/// A habit's page pushed on Today's own stack (Open Habit Page in a row's touch-and-hold menu).
struct HabitPageRoute: Hashable { let id: UUID }

/// Swipe left → Skip or Undo Skip, for the day the row shows. Reads only that habit's day, so other rows don't redraw.
struct RowSkipButton: View {
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store

    var body: some View {
        if store.isSkipped(habit, on: day) {
            Button { store.setSkipped(habit, on: day, false) } label: { Label("Undo Skip", systemImage: "arrow.uturn.backward") }
                .tint(.gray)
        } else if store.canSkip(store.rule(habit, on: day)) && !store.isPaused(habit, on: day) {
            Button { store.setSkipped(habit, on: day, true) } label: { Label("Skip", systemImage: "forward") }
                .tint(.gray)
                .accessibilityIdentifier("row-swipe-skip")
        }
    }
}

/// Swipe left → Pause… or Resume.
struct RowPauseButton: View {
    let habit: Habit
    @Binding var showPause: Bool
    @Environment(HabitStore.self) private var store

    var body: some View {
        let today = store.today()
        if let pause = store.pause(of: habit, on: today), pause.contains(today) {
            Button { store.resume(habit) } label: { Label("Resume", systemImage: "play.circle") }
                .tint(.teal)
        } else if store.canPause(habit) && store.pause(of: habit, on: today) == nil {
            Button { showPause = true } label: { Label("Pause", systemImage: "pause.circle") }
                .tint(.teal)
                .accessibilityIdentifier("row-swipe-pause")
        }
    }
}
