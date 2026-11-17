import SwiftUI
import UIKit

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
        Group {
            if habit.kind == .duration {
                // Keep the same host when a running timer stops, and on every day: replacing TimelineView with a plain
                // row could dismiss a sheet opened from that row, and switching the day rebuilt every duration row twice
                // (rule 4). A stopped, covered or other day's clock simply has no ticks.
                RowClock(start: clockStart) { now in row(now: now) }
            } else {
                row(now: .now)
            }
        }
        // The list's own modifiers go outside the clock: a TimelineView doesn't pass them to the List, so a timer row
        // lost its edges and its fill (17 Nov 2026, the Simulator against Figma's Read row).
        .listRowInsets(EdgeInsets())
        .alignmentGuide(.listRowSeparatorTrailing) { $0[.trailing] - RowSpace.edge }
        .listRowBackground(rowBackground)
        // Logged from the sheet: the row stays where it is until the person pauses, as after a tap (#58). The day's own
        // rule, so a past day is logged against the goal it had then.
        .sheet(item: $sheet, onDismiss: {
            if logged { logged = false; layout?.hold(reduceMotion: reduceMotion) }
        }) { shown in
            switch shown {
            case .log: AddLogView(habit: habit, day: day, source: .manual).onAppear { logged = true }
            case .edit: EditHabitSheet(habit: habit)
            case .notes: HabitNotesView(habit: habit)
            case .pause: PauseSheet(habit: habit)
            }
        }
        // Figma's Habit row · Swipe (17 Nov 2026): one action a side, as Mail and Reminders do. Swipe left: Skip, or
        // Undo Skip on a skipped day. Swipe right: Note. The row slides whole, a grey capsule shows, and a full swipe
        // acts (the Rulebook, 5 Nov 2026). Undo isn't a swipe: it's named under the row after a log, and in the menu.
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            if day <= store.today() && lineOverride == nil && habit.kind != .task {
                RowSkipButton(habit: habit, day: day)
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            if day <= store.today() && lineOverride == nil {
                RowNoteButton(habit: habit, day: day)
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
                    // The same Add screen as everywhere, named for what it adds (U21, U22): "Add log…", "Add a check…".
                    Button(RecordKind(habit, on: day, store: store).addTitle + "…", systemImage: "plus") { sheet = .log }
                        .disabled(day > store.today())
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

    /// A running timer's clock start, nil when the row's clock shouldn't tick.
    private var clockStart: Date? {
        isToday && sheet == nil && store.dayTarget?.habitID != habit.id ? store.timers[habit.id] : nil
    }

    /// The progress fill behind the row, ticking with a running timer.
    @ViewBuilder private var rowBackground: some View {
        if habit.kind == .duration {
            RowClock(start: clockStart) { now in fill(now: now) }
        } else {
            fill(now: .now)
        }
    }

    private func fill(now: Date) -> some View {
        let progress = store.progress(of: habit, on: day, now: now)
        let goal = store.goal(of: store.rule(habit, on: day))
        return ProgressFill(progress: habit.atMost ? 0 : progress / max(goal, 1), color: habit.color)
            .overlay(NoteTargetFlash(habit: habit, day: day, highlighted: highlighted))
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
        // A cut-down habit at or past its most: a neutral band says so (Figma's Limit band), and past it the streak
        // steps aside. Worked out from the two numbers the row already has, nothing more is read.
        let limit = habit.atMost && goal > 0 && progress >= goal ? (progress > goal ? LimitBand.over : .reached) : nil
        let streak = showStreaks && limit != .over ? store.streak(of: habit, asOf: day) : 0
        // One shape for every row (report "Today's Rows — The Line Under the Name", 3 Oct 2026): the icon, the name with
        // its one line, the streak and the button centred on one 44-pt band; after a log, one line of small buttons
        // under the text. Nothing else stacks up, so no row runs past three lines and icons line up down the list.
        VStack(alignment: .leading, spacing: 0) {
          HStack(alignment: .center, spacing: RowSpace.iconToText) {
            HStack(alignment: .center, spacing: RowSpace.iconToText) {
              HabitIcon(symbol: habit.symbol, color: habit.color)
              VStack(alignment: .leading, spacing: RowSpace.nameToLine) {
                  // One line: the name uses the row's width and ends in "…" only when it runs out (U6 allows 24).
                  // Label whether done or not (Figma, 17 Nov 2026): the fill and the button say it's done.
                  Text(habit.name).font(.body).foregroundStyle(.primary).lineLimit(1)
                      .alignmentGuide(.listRowSeparatorLeading) { $0[.leading] }
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
                // A milestone this tap reached bursts round the button (its own small view reads the store's
                // milestone, so the row doesn't: S6).
                .overlay { MilestoneBurst(habit: habit, day: day) }
          }
          .frame(minHeight: RowBand.height)
          // Undo and Add Note after a log, in their own small view so a tap redraws that line, not every row (L16).
          if lineOverride == nil { RowAfterLog(habit: habit, day: day) }
        }
        .padding(.leading, RowSpace.edge)
        .padding(.trailing, RowSpace.buttonEdge)
        .padding(.vertical, RowSpace.bodyVertical)
        // Under the body, across the card's whole width: a milestone this habit just reached, or its limit.
        .rowFoot(habit: habit, day: day, limit: lineOverride == nil ? limit : nil)
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

    /// Every log from the row's button: hold Today's order, then change the data inside the tick animation so the
    /// button fills and the row's colour sweeps across (research §1). The store answers a log with its tap or the
    /// completion sound (`HabitStore+Feedback`); an undo answers here.
    private func log(undo: Bool = false, _ change: () -> Void) {
        layout?.hold(reduceMotion: reduceMotion)
        if undo { TickFeedback.undone() }
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

    /// The line under the name: `HabitStore.rowLine`, the same words on the Apple Watch.
    private func rowLine(progress: Double, goal: Double) -> String {
        store.rowLine(habit, on: day, slot: slot, time: time, progress: progress, goal: goal, running: isRunning)
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
                // Ticked several times a day, or N times a week, month or year: still a ✓, because the person chose a
                // habit they check off, never a +1 counter like an amount (the user, 7 Oct 2026, Current Work 64). Each
                // tap adds one check and never takes one back; the named Undo and History do that. It fills, and the
                // completion sound plays, only when the goal is met: today's for several a day, the period's for a week
                // or month goal, which has no daily goal (Current Work 54).
                RoundActionButton(symbol: "checkmark", done: done, color: habit.color,
                                  label: "Add 1 to \(habit.name)", keepSymbolWhenDone: true) {
                    offerNote()
                    log { store.addProgress(habit, value: 1, on: day) }
                }
            case .check, .task:
                // A once-a-day tick toggles that day's tick ("N days a week" too: a day counts once).
                let ticked = slot.map { store.isSlotDone(habit, slot: $0, on: day) }
                    ?? (habit.kind == .task ? done : store.isTicked(habit, on: day))
                RoundActionButton(symbol: "checkmark", done: ticked, color: habit.color,
                                  label: ticked ? "Undo \(habit.name)" : "Mark \(habit.name) done") {
                    if !ticked { offerNote() }
                    log(undo: ticked) {
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
                        log { store.increment(habit, on: day) }
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
                        log { store.toggleTimer(habit, slot: slot) }
                    }
                }
                .disabled(!isToday)
            case .quit, .checklist:
                EmptyView()
            }
        }
    }
}

/// One step of a checklist, under its habit on Today: Figma's Step row (17 Nov 2026), as a reminder in Reminders. A tick
/// circle leads (an empty Tertiary Label ring, or the habit's colour with a white ✓), then the step in Body; a done step
/// reads in Secondary Label. 44 tall; the line under it starts at the step's words.
struct StepRow: View {
    let step: Step
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store
    @Environment(TodayLayout.self) private var layout: TodayLayout?
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    /// Figma: the circle sits in a 24-wide column 16 from the card's edge, and the words 16 after it. The tap target
    /// reaches 10 past the column each side, so it's Apple's 44 without moving anything.
    private static let reach: CGFloat = 10

    var body: some View {
        let done = store.isStepDone(step, of: habit, on: day)
        HStack(spacing: 16 - Self.reach) {
            Button(action: { toggle(done: done) }) {
                StepTick(done: done, color: habit.color)
                    .frame(width: 24, height: 22)
                    .padding(.horizontal, Self.reach)
                    .frame(minHeight: 44)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel(done ? "Undo \(step.name)" : "Mark \(step.name) done")
            Text(step.name).font(.body).foregroundStyle(done ? .secondary : .primary).lineLimit(1)
                .alignmentGuide(.listRowSeparatorLeading) { $0[.leading] }
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .disabled(day > store.today())
        .padding(.leading, RowSpace.edge - Self.reach)
        .padding(.trailing, RowSpace.edge)
        .listRowInsets(EdgeInsets())
        .alignmentGuide(.listRowSeparatorTrailing) { $0[.trailing] - RowSpace.edge }
    }

    private func toggle(done: Bool) {
        if !done { store.noteOffer = .init(habit: habit.id, day: day) }
        layout?.hold(reduceMotion: reduceMotion)
        // A tick's tap, or the completion on the last step, comes from the store (`HabitStore+Feedback`).
        if done { TickFeedback.undone() }
        withAnimation(Motion.tick(reduceMotion)) { store.toggleStep(step, of: habit, on: day) }
    }
}

/// A step's tick: a 22-pt ring in Tertiary Label (1.5 pt), or a circle in the habit's colour with a white ✓ (Semibold 12).
private struct StepTick: View {
    let done: Bool
    let color: HabitColor

    var body: some View {
        ZStack {
            if done {
                Circle().fill(color.color)
                Image(systemName: "checkmark").font(.system(size: 12, weight: .semibold)).foregroundStyle(.white)
            } else {
                Circle().strokeBorder(Color(.tertiaryLabel), lineWidth: 1.5)
            }
        }
        .frame(width: 22, height: 22)
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
    @Environment(\.dynamicTypeSize) private var typeSize
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
                        .alignmentGuide(.listRowSeparatorLeading) { $0[.leading] }
                    // At the accessibility sizes the count goes under the name, so the name isn't cut to "Smo…" (the
                    // Rulebook, 31 Oct 2026: what sits beside a label gives way first).
                    if typeSize.isAccessibilitySize {
                        RowClock(start: tick) { now in elapsed(current(now)) }
                    }
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
                if !typeSize.isAccessibilitySize {
                    RowClock(start: tick) { now in elapsed(current(now)) }
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
        // The same edges as every habit row; its count on the right is words, not a button, so 16 from the edge.
        .padding(.horizontal, RowSpace.edge)
        .padding(.vertical, RowSpace.bodyVertical)
        .listRowInsets(EdgeInsets())
        .alignmentGuide(.listRowSeparatorTrailing) { $0[.trailing] - RowSpace.edge }
        .listRowBackground(Color(.secondarySystemGroupedBackground).overlay(HighlightFlash(on: highlighted, color: habit.color)))
        // Figma's Habit row · Swipe: swipe left is Log a Slip (where the "Slipped" button was: U5), swipe right is Note;
        // a full swipe acts. While paused there's no slip to log, so nothing is offered (a full swipe can't reach a
        // switched-off button). Pause is in the long-press menu.
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            if !store.isPaused(habit, on: today) {
                Button { sheet = .slip } label: { Label("Log a Slip", systemImage: "arrow.uturn.backward") }
                    .tint(Color(.systemGray))
                    .accessibilityIdentifier("row-swipe-slip")
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            RowNoteButton(habit: habit, day: today)
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
            case .slip: AddLogView(habit: habit, day: today, source: .manual) { id in withAnimation { lastSlip = id } }
            }
        }
    }

    private func elapsed(_ seconds: TimeInterval) -> some View {
        Text(Format.elapsed(seconds))
            .font(.body.monospacedDigit().weight(.semibold))
            .foregroundStyle(.primary)
            .lineLimit(1)
            .fixedSize()
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
    /// Habits still to do; nil for the Quit or Cut Down card, which has no status.
    let left: Int?
    let isNow: Bool
    let isOpen: Bool
    let onStart: (() -> Void)?
    let onToggle: () -> Void
    /// "Starts 6 AM" under a timed section's name, folded or open; nil for Anytime, Quit or Cut Down and Paused. On its own
    /// line, so it never takes room from the folded icons or "N left" (the user, 3 Oct 2026).
    var subtitle: String? = nil
    /// Folded, the name is cut to 8 letters so the icons get the room. Off for "Quit or Cut Down", whose meaning
    /// would go with its last words.
    var foldsTitle = true
    /// The iPad's Columns view: a column never folds (it has its own room), so no chevron (Design Notes §6).
    var folds = true
    /// A day ahead: nothing can be logged yet, so the count says what's planned ("3 planned"), not what's left.
    var planned = false

    /// The width for the name, Now and the icons, and the width of the name block (the name with Now, or its "Starts
    /// 6 AM" line, whichever is wider).
    @State private var room: CGFloat = 0
    @State private var labelWidth: CGFloat = 0
    /// Between the name block and the folded icons: clear room that grows with the text size (the user, 4 Oct 2026:
    /// "a good amount of spacing… a relative unit", around 12 to 16 points).
    @ScaledMetric(relativeTo: .headline) private var iconGap = 14.0
    private var shownIconGap: CGFloat { min(iconGap, 24) }

    /// At least this much space between the icons and "2 left" / ✓.
    static let statusGap: CGFloat = 12

    /// The caller provides Start for unfinished habits today; Figma's Section header shows it only open (folded, the
    /// icons, "N left" and › say what's inside).
    private var showsStart: Bool { onStart != nil && isOpen }

    private var iconCount: Int? {
        guard !isOpen, room > 0 else { return nil }
        return FoldedIcons.fitting(habits.count, in: room - labelWidth - shownIconGap)
    }

    /// Folded, the name shows at most 8 letters and "…", so the icons get the room.
    /// (A 9-letter name, like Afternoon, is shown whole: "Afternoo…" would be no shorter.)
    private var shownTitle: String {
        guard !isOpen, foldsTitle, title.count > 9 else { return title }
        return title.prefix(8).trimmingCharacters(in: .whitespaces) + "…"
    }

    private var status: String? {
        guard let left else { return nil }
        return left == 0 ? "All done" : planned ? "\(left) planned" : "\(left) left"
    }

    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        Group {
            // Figma's Today, Large text: at the accessibility sizes the header stacks (name and chevron, then the time
            // with the count or the folded icons, then Start on a line of its own), so no word is cut (S10: chosen
            // from the text size, never `ViewThatFits`).
            if typeSize.isAccessibilitySize {
                stacked
            } else {
                HStack(spacing: Self.statusGap) {
                    titleArea
                    controls
                }
            }
        }
        .frame(minHeight: 44)
        // Figma's Section header: 16 at the sides on every phone (the system's own inset is 20 on the larger ones),
        // and 10 + 44 + 10 is its 64. The same edges as the rows under it.
        .padding(.vertical, 10)
        .padding(.horizontal, RowSpace.edge)
        .listRowInsets(EdgeInsets())
        .alignmentGuide(.listRowSeparatorTrailing) { $0[.trailing] - RowSpace.edge }
    }

    private var stacked: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title).font(.headline).fixedSize(horizontal: false, vertical: true)
                    HStack(spacing: 10) {
                        if let subtitle { Text(subtitle).font(.footnote).foregroundStyle(.secondary) }
                        if !isOpen, !habits.isEmpty {
                            FoldedIcons(habits: habits, max: 3).fixedSize()
                                .transition(.opacity.combined(with: .scale(scale: 0.9, anchor: .leading)))
                        } else {
                            statusView
                        }
                    }
                    if !isOpen && !habits.isEmpty { statusView }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .modifier(HeaderTap(label: accessibilityText, isOpen: isOpen, onToggle: onToggle))
                if folds { chevron }
            }
            if showsStart, let onStart {
                StartButton(compact: false, primary: isNow, title: title, action: onStart)
            }
        }
    }

    @ViewBuilder private var statusView: some View {
        if left == 0 {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 18))
                .foregroundStyle(.secondary)
                .accessibilityHidden(true)
                .transition(.scale(scale: 0.4).combined(with: .opacity))
        } else if let status {
            Text(status).font(.subheadline).monospacedDigit().foregroundStyle(.secondary).accessibilityHidden(true)
        }
    }

    private var chevron: some View {
        Button(action: onToggle) {
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.secondary)
                .rotationEffect(.degrees(isOpen ? 90 : 0))
                .frame(width: 34, height: 44)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(isOpen ? "Fold" : "Open") \(title)")
    }

    private var accessibilityText: String {
        [title, subtitle, isNow ? "Now" : nil, status ?? "\(habits.count) habits"].compactMap { $0 }.joined(separator: ", ")
    }

    private var titleArea: some View {
        // Folded, the icons sit beside the whole name block, centred on the header, not on the name's line, with clear
        // room between (the user, 4 Oct 2026: "they should be centre aligned vertically in the card, not to the title").
        HStack(alignment: .center, spacing: shownIconGap) {
            VStack(alignment: .leading, spacing: 1) {
                // Figma's Section header has no Now chip: the routine it is now is the one whose Start is filled.
                Text(shownTitle).font(.headline).lineLimit(1)
                if let subtitle {
                    Text(subtitle).font(.footnote).foregroundStyle(.secondary).lineLimit(1)
                }
            }
            // Folded, the block keeps its own width (the name is already short) so the icons know their room; open, the
            // name takes what's left and ends in "…". A whole folded name goes first, and ends in "…" only when even the
            // header can't hold it (the largest text sizes); the icons get what's left.
            .fixedSize(horizontal: !isOpen && foldsTitle, vertical: false)
            .layoutPriority(foldsTitle ? 0 : 1)
            .onGeometryChange(for: CGFloat.self) { $0.size.width } action: { labelWidth = $0 }
            if let count = iconCount {
                // Folding: the icons fade in from the name's side as the rows go back under the header (#59).
                FoldedIcons(habits: habits, max: count).fixedSize()
                    .transition(.opacity.combined(with: .scale(scale: 0.9, anchor: .leading)))
            }
        }
            .frame(maxWidth: .infinity, alignment: .leading)
            .onGeometryChange(for: CGFloat.self) { $0.size.width } action: { room = $0 }
            .modifier(HeaderTap(label: accessibilityText, isOpen: isOpen, onToggle: onToggle))

    }

    private var controls: some View {
            HStack(spacing: 8) {
                // Done: a ✓ in about 20 pt, where "✓ All done" took about 78; VoiceOver says "All done". It grows in with
                // the row's own tick (#58).
                statusView
                if showsStart, let onStart {
                    StartButton(compact: !isOpen, primary: isNow, title: title, action: onStart)
                }
                if folds { chevron }
            }
            .lineLimit(1)
            // Never squeezed: the name gives way instead.
            .fixedSize()
    }

}

/// A section header's name block: VoiceOver reads it as one button that folds or opens the part; Start stays its own.
private struct HeaderTap: ViewModifier {
    let label: String
    let isOpen: Bool
    let onToggle: () -> Void

    func body(content: Content) -> some View {
        content
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(label)
            .accessibilityValue(isOpen ? "Open" : "Folded")
            .accessibilityAddTraits(.isButton)
            .accessibilityHint(isOpen ? "Folds this part" : "Opens this part")
            .contentShape(Rectangle())
            .onTapGesture(perform: onToggle)
            .accessibilityAction { onToggle() }
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

    /// Figma's folded header: 28-pt circles, each overlapping the one before by 6, ringed in the card's colour (2 pt).
    private static let size: CGFloat = 28
    private static let overlap: CGFloat = 6
    /// What each circle after the first adds to the width.
    private static let step: CGFloat = size - overlap

    /// How many icons fit in `width`, leaving room for a "+N" circle for the rest; nil when not even that fits.
    static func fitting(_ count: Int, in width: CGFloat, limit: Int = 6) -> Int? {
        for n in stride(from: min(limit, count), through: 0, by: -1) {
            let circles = CGFloat(n + (count > n ? 1 : 0))
            if circles * step + overlap <= width + 1 { return n } // 1 pt for rounding
        }
        return nil
    }

    var body: some View {
        HStack(spacing: -Self.overlap) {
            ForEach(habits.prefix(max)) { HabitIcon(symbol: $0.symbol, color: $0.color, size: Self.size, ring: 2) }
            if habits.count > max {
                // The rest, as a circle the same size as the icons: Caption 1 Semibold in Label on Tertiary System Fill.
                Text("+\(habits.count - max)")
                    .font(.caption.weight(.semibold).monospacedDigit())
                    .foregroundStyle(.primary)
                    .lineLimit(1).fixedSize()
                    .padding(.horizontal, 4)
                    .frame(minWidth: Self.size, minHeight: Self.size)
                    .background {
                        Capsule().fill(Color.card)
                        Capsule().fill(Color(.tertiarySystemFill))
                        Capsule().strokeBorder(Color.card, lineWidth: 2)
                    }
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
                      description: store.description(of: habit) ?? "") { _ in onSaved() }
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
    /// Between the after-log buttons: wide enough that Undo and Add Note aren't tapped by mistake (the user, 6 Oct
    /// 2026: "very close… there is a chance of misclick"; Current Work 55).
    static let betweenButtons: CGFloat = 16
    /// Above and below a row that keeps the list's own insets (onboarding's habit rows).
    static let rowPadding: CGFloat = 2
    /// From the card's edge to the row's icon or words (Figma's Habit row and Step row: 16).
    static let edge: CGFloat = 16
    /// From the card's edge to the round button's 44-pt frame, so its 34-pt circle sits 16 from the edge as in Figma.
    static let buttonEdge: CGFloat = edge - (44 - 34) / 2
    /// Above and below the 44-pt band: 13 + 44 + 13 is Figma's 70; with the after-log line, + 6 + 30 is its 106.
    static let bodyVertical: CGFloat = 13
    /// Where text starts: the icon's width plus its gap, so the after-log buttons and step rows line up with names.
    static let textLeading: CGFloat = 32 + iconToText
    /// The milestone or limit band under a row, across the card (Figma: 32 tall, its words where the name starts).
    static let footBand: CGFloat = 32
}

/// After a log on this row: Undo and Note, Figma's after-log capsules on one line under the name (the words the user
/// approved, 5 Nov 2026: never the habit's or a step's name, which once pushed Note off the screen; VoiceOver still hears
/// what Undo takes back and whether the note is new). A milestone the tap reached is the band under the row
/// (`RowFoot`). Only while the offer lasts. Only this reads the store's offers, so a log redraws this line, not each
/// row's whole body (lesson L16, 2 Oct 2026).
struct RowAfterLog: View {
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let undo = store.undoOffer.flatMap { $0.habitID == habit.id && $0.day == day ? $0 : nil }
        let offered = undo != nil || store.noteOffer == .init(habit: habit.id, day: day)
        if offered {
            let note = store.note(of: habit, on: day) != nil
            // One layout, never measured twice: at the accessibility text sizes the buttons show their icons (their
            // words stay for VoiceOver). `ViewThatFits` measured three layouts each time the line appeared and doubled
            // the cost of changing days (speed bisect, 4 Oct 2026).
            buttons(undo: undo, note: note, icons: typeSize.isAccessibilitySize)
                .padding(.leading, RowSpace.textLeading)
                .padding(.top, RowSpace.afterBand)
        }
    }

    private func buttons(undo: Entry?, note: Bool, icons: Bool) -> some View {
        HStack(spacing: RowSpace.betweenButtons) {
            if let undo {
                // Figma's words, short so the line always fits; VoiceOver hears what it takes back ("Undo +1 glass").
                Button { store.undoEntry(undo.id) } label: { Label("Undo", systemImage: "arrow.uturn.backward") }
                    .accessibilityLabel(undo.undoLabel(for: habit))
                    .accessibilityIdentifier("habit-inline-undo")
            }
            if day <= store.today() {
                Button { writeNote() } label: { Label("Note", systemImage: "plus") }
                    .accessibilityLabel(note ? "Edit Note" : "Add Note")
                    .accessibilityIdentifier(note ? "habit-edit-note" : "habit-add-note")
            }
        }
        .labelStyle(AfterLogLabel(iconOnly: icons))
        .buttonStyle(AfterLogButtonStyle())
        .lineLimit(1)
        .truncationMode(.tail)
        // Offered the row's width, not its own: the line fits it instead of running off the screen.
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    /// Opens the note sheet for this habit and day (as the row's swipe and menu do).
    private func writeNote() {
        store.noteTarget = .init(habit: habit.id, day: day)
    }
}

/// After a slip on a quit row: Undo and Note, the same capsules as every row; gone after 8 seconds.
struct QuitAfterSlip: View {
    let habit: Habit
    let day: LocalDay
    let slip: UUID
    let onDone: () -> Void
    @Environment(HabitStore.self) private var store
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        let note = store.note(of: habit, on: day) != nil
        HStack(spacing: RowSpace.betweenButtons) {
            Button { store.undoEntry(slip); onDone() } label: { Label("Undo", systemImage: "arrow.uturn.backward") }
                .accessibilityLabel("Undo Slip")
                .accessibilityIdentifier("habit-inline-undo")
            Button { store.noteTarget = .init(habit: habit.id, day: day) } label: { Label("Note", systemImage: "plus") }
                .accessibilityLabel(note ? "Edit Note" : "Add Note")
                .accessibilityIdentifier(note ? "habit-edit-note" : "habit-add-note")
        }
        // As every row's after-log line: icons at the accessibility sizes (the words stay for VoiceOver), and never
        // wider than the row.
        .labelStyle(AfterLogLabel(iconOnly: typeSize.isAccessibilitySize))
        .buttonStyle(AfterLogButtonStyle())
        .lineLimit(1)
        .frame(maxWidth: .infinity, alignment: .leading)
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
            HStack(spacing: 4) { configuration.icon; configuration.title }
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
struct HabitPageRoute: Hashable {
    let id: UUID
    /// Opens straight on to its All Milestones (the milestone pop-up's button).
    var milestones = false
}

/// The milestone bar on Today (Figma's Milestone bar): a streak milestone a tap just reached, rising over the bottom of
/// the list for 5 seconds, and its pop-up behind See. Only this reads the store's milestone, so reaching one redraws
/// this and the row's band, never the list (S6). The row's band stays after the bar has gone.
struct TodayMilestoneBar: View {
    @Environment(HabitStore.self) private var store
    @Environment(MenuModel.self) private var menu
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var shown: MilestoneMoment?
    @State private var popup: MilestoneMoment?
    /// The last tap's milestone already shown, so a redraw never brings the bar back.
    @State private var seen: UUID?
    /// Figma's Milestone · Motion: the bar rises 0.3 s after the taps stop, so a run of taps never moves it in and
    /// out; a newer tap starts the wait again.
    @State private var waiting: Task<Void, Never>?

    var body: some View {
        ZStack {
            if let shown {
                MilestoneBar(moment: shown, onSee: { popup = shown; hide() }, onGone: hide)
                    .id(shown.id)
                    .transition(reduceMotion ? .opacity : .asymmetric(
                        insertion: .opacity.combined(with: .offset(y: 24)),
                        removal: .opacity.combined(with: .offset(y: -16))))
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
        .onChange(of: store.milestoneOffer) { show(store.milestoneOffer) }
        .sheet(item: $popup) { moment in
            MilestonePopup(moment: moment) {
                menu.path.append(HabitPageRoute(id: moment.habitID, milestones: true))
            }
        }
    }

    private func show(_ offer: HabitStore.MilestoneOffer?) {
        guard let offer else { hide(); return }
        guard offer.entry != seen, let value = offer.value, let unit = offer.unit,
              let habit = store.habits.first(where: { $0.id == offer.habit }) else { return }
        seen = offer.entry
        let moment = MilestoneMoment(entry: offer.entry, habit: habit, value: value, unit: unit, again: offer.again)
        waiting?.cancel()
        waiting = Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(300))
            guard !Task.isCancelled else { return }
            // 0.3–0.55 s, rising 24 and fading in, emphasized decelerate (Figma 853:45906).
            withAnimation(.timingCurve(0.05, 0.7, 0.1, 1, duration: 0.25)) { shown = moment }
        }
    }

    private func hide() {
        waiting?.cancel()
        guard shown != nil else { return }
        withAnimation(.snappy(duration: 0.25)) { shown = nil }
    }
}

/// Swipe left → Skip or Undo Skip, for the day the row shows (Figma's Habit row · Swipe: forward.fill and
/// arrow.uturn.backward, grey). Reads only that habit's day, so other rows don't redraw.
struct RowSkipButton: View {
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store

    var body: some View {
        if store.isSkipped(habit, on: day) {
            Button { store.setSkipped(habit, on: day, false) } label: { Label("Undo Skip", systemImage: "arrow.uturn.backward") }
                .tint(Color(.systemGray))
        } else if store.canSkip(store.rule(habit, on: day)) && !store.isPaused(habit, on: day) {
            Button { store.setSkipped(habit, on: day, true) } label: { Label("Skip", systemImage: "forward.fill") }
                .tint(Color(.systemGray))
                .accessibilityIdentifier("row-swipe-skip")
        }
    }
}

/// Swipe right → Note (Edit Note once the day has one), grey, opening the note sheet. Reads only this habit's note,
/// so the row's own body never does.
struct RowNoteButton: View {
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store

    var body: some View {
        Button { store.noteTarget = .init(habit: habit.id, day: day) } label: {
            Label(store.note(of: habit, on: day) == nil ? "Note" : "Edit Note", systemImage: "square.and.pencil")
        }
        .tint(Color(.systemGray))
        .accessibilityIdentifier("row-swipe-note")
    }
}

/// Figma's after-log capsule: 30 tall, a solid card-coloured capsule with a 1-pt Separator outline (anything
/// see-through splits in two where a progress fill ends, the Rulebook, 5 Nov 2026), the symbol and the words in
/// Subheadline, Label. Plain shapes, no shadow and no material (S10).
struct AfterLogButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .foregroundStyle(.primary)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .frame(minHeight: 30)
            .background {
                Capsule().fill(Color.card)
                Capsule().strokeBorder(Color(.separator), lineWidth: 1)
            }
            .contentShape(Capsule())
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

/// A cut-down habit at its most, or past it: Figma's Limit band. Neutral, never red (U3).
enum LimitBand {
    case reached, over
    var words: String { self == .reached ? "Limit reached" : "Over the limit" }
}

extension View {
    /// The band under a habit row (`RowFoot`).
    func rowFoot(habit: Habit, day: LocalDay, limit: LimitBand?) -> some View {
        VStack(spacing: 0) {
            self
            RowFoot(habit: habit, day: day, limit: limit)
        }
    }
}

/// The band under a row, across the card's whole width, 32 tall, its words where the name starts (Figma, 17 Nov
/// 2026): a milestone this habit's log just reached (its Milestone Band, the Medal and the words in Deep), or else a
/// cut-down habit's limit (Tertiary System Fill, hourglass, Label). Only this reads the store's milestone, so reaching
/// one redraws this band, not the row (L16). It stays while the store offers it: until the next log anywhere, or until
/// its own log is undone or deleted.
struct RowFoot: View {
    let habit: Habit
    let day: LocalDay
    let limit: LimitBand?
    @Environment(HabitStore.self) private var store

    var body: some View {
        if let mark = store.milestoneOffer, mark.habit == habit.id, mark.day == day {
            Playback(duration: MilestoneBandMotion.duration, atRest: MilestoneBandMotion.played(mark.entry, "band")) { ms in
                MilestoneBandMotion(text: mark.text, color: habit.color, ms: ms)
            }
            .accessibilityIdentifier("today-milestone")
        } else if let limit {
            band(fill: Color(.tertiarySystemFill)) {
                Image(systemName: "hourglass").font(.footnote.weight(.semibold))
                Text(limit.words)
            }
            .foregroundStyle(.primary)
            .accessibilityIdentifier("today-limit")
        }
    }

    private func band<Content: View>(fill: Color, @ViewBuilder _ content: () -> Content) -> some View {
        HStack(spacing: 6) { content() }
            .font(.subheadline.weight(.semibold))
            .lineLimit(1)
            .padding(.leading, RowSpace.edge + RowSpace.textLeading)
            .padding(.trailing, RowSpace.edge)
            .frame(maxWidth: .infinity, minHeight: RowSpace.footBand, alignment: .leading)
            .background(fill)
            .accessibilityElement(children: .combine)
    }
}

// MARK: - A milestone reached on a row (Figma's Milestone · Motion, Row band, 853:45982)
//
// Figma's timeline is 2 s from the finger coming down; the log lands as the press bottoms out (180 ms), so here 0 is
// the tap. The band itself grows in with the row's own tick animation (its height is the List's to animate); what's
// inside it plays once (`Playback`), and never again for the same log (a row scrolled away and back shows it at rest).

/// The burst round the round button when a tap reaches a milestone: a ring in the habit's colour, 56 across and 2 thick,
/// growing 0.7 → 1.45 as it fades from 55 %, and eight dots in its Gradient Top (6 and 4 across in turn, every 45° from
/// 22.5°) flying out from 20 to 34, each 12 ms after the one before. 120–890 ms after the tap. Only this reads the
/// store's milestone, so the row doesn't redraw for it (S6).
struct MilestoneBurst: View {
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store

    var body: some View {
        if let mark = store.milestoneOffer, mark.habit == habit.id, mark.day == day {
            // At rest (a row scrolled away and back), the burst has gone: nothing is drawn.
            Playback(duration: 900, atRest: MilestoneBandMotion.played(mark.entry, "burst")) { ms in
                Burst(color: habit.color, ms: ms)
            }
                .frame(width: 88, height: 88)
                .allowsHitTesting(false)
                .accessibilityHidden(true)
                .id(mark.entry)
        }
    }

    private struct Burst: View {
        let color: HabitColor
        let ms: Double

        var body: some View {
            Canvas { context, size in
                let c = CGPoint(x: size.width / 2, y: size.height / 2)
                let ring = track(ms, Key(120, 0, Ease.out), Key(160, 0.55, Ease.out), Key(570, 0))
                if ring > 0 {
                    let k = track(ms, Key(120, 0.7, Ease.out), Key(570, 1.45))
                    let r = 27 * k
                    context.stroke(Circle().path(in: CGRect(x: c.x - r, y: c.y - r, width: 2 * r, height: 2 * r)),
                                   with: .color(color.color.opacity(ring)), lineWidth: 2 * k)
                }
                for i in 0..<8 {
                    let start = 120 + 12 * Double(i)
                    let a = track(ms, Key(start, 0, Ease.out), Key(start + 80, 1, Ease.in), Key(start + 500, 0))
                    guard a > 0 else { continue }
                    let s = track(ms, Key(start, 0.6, Ease.out), Key(start + 150, 1, Ease.in), Key(start + 500, 0.3))
                    let out = track(ms, Key(start, 20, Ease.out), Key(start + 320, 34))
                    let angle = (22.5 + 45 * Double(i)) * .pi / 180
                    let r = (i.isMultiple(of: 2) ? 3 : 2) * s
                    let p = CGPoint(x: c.x + cos(angle) * out, y: c.y + sin(angle) * out)
                    context.fill(Circle().path(in: CGRect(x: p.x - r, y: p.y - r, width: 2 * r, height: 2 * r)),
                                 with: .color(color.gradientTop.opacity(a)))
                }
            }
        }
    }
}

/// The milestone band's inside, at `ms` after the tap: it fades in (280–440 ms), the medal spins in from 35° and pops
/// (0.01 → 1.3 → 1, 400–720 ms), the words slide 8 in from the left (460–680 ms), a sheen passes once (700–1300 ms,
/// 48 × 80, tilted 20°, white at 50 %), and two sparkles over the medal twinkle out (640–1220 ms).
struct MilestoneBandMotion: View {
    let text: String
    let color: HabitColor
    let ms: Double

    static let duration = 1300.0

    /// The motions that have played, by log and part, so each plays once per log. Main actor only.
    private static var seen: Set<String> = []

    /// Whether `part` of `entry`'s milestone has played; asking marks it played. Read once, when its view is made
    /// (`Playback` keeps its first answer), so a later redraw of the same view never stops it mid-way.
    static func played(_ entry: UUID, _ part: String) -> Bool {
        !seen.insert(entry.uuidString + part).inserted
    }

    /// Figma's two sparkles in the band (from its leading edge, at the name's start): x, y of the top left, size, start.
    private static let sparkles: [(CGFloat, CGFloat, CGFloat, Double)] = [(28.5, 2.5, 7, 640), (9.5, 17.5, 5, 720)]

    var body: some View {
        HStack(spacing: 6) {
            Medal(size: 16, color: color)
                .rotationEffect(.degrees(track(ms, Key(400, 35, Ease.out), Key(720, 0))))
                .scaleEffect(track(ms, Key(400, 0.01, Ease.out), Key(580, 1.3, Ease.inOut), Key(720, 1)))
            Text(text)
                .foregroundStyle(color.deep)
                .offset(x: track(ms, Key(460, -8, Ease.arrive), Key(680, 0)))
                .opacity(track(ms, Key(460, 0, Ease.arrive), Key(680, 1)))
        }
        .font(.subheadline.weight(.semibold))
        .lineLimit(1)
        .overlay(alignment: .topLeading) {
            Canvas { context, _ in
                for (x, y, d, start) in Self.sparkles {
                    let a = track(ms, Key(start, 0, Ease.out), Key(start + 120, 1, Ease.in), Key(start + 500, 0))
                    guard a > 0 else { continue }
                    let k = track(ms, Key(start, 0.01, Ease.pop), Key(start + 180, 1.1, Ease.in), Key(start + 500, 0.5))
                    let turn = track(ms, Key(start, 0, Ease.out), Key(start + 500, 45)) * .pi / 180
                    let star = sparkle(at: .zero, size: d * k)
                        .applying(CGAffineTransform(rotationAngle: turn))
                        .applying(CGAffineTransform(translationX: x + d / 2, y: y + d / 2))
                    context.fill(star, with: .color(color.color.opacity(a)))
                }
            }
            .frame(width: 44, height: 32)
            .offset(y: -6)
            .allowsHitTesting(false)
        }
        .padding(.leading, RowSpace.edge + RowSpace.textLeading)
        .padding(.trailing, RowSpace.edge)
        .frame(maxWidth: .infinity, minHeight: RowSpace.footBand, alignment: .leading)
        .opacity(track(ms, Key(280, 0, Ease.out), Key(440, 1)))
        .background(color.milestoneBand.opacity(track(ms, Key(280, 0, Ease.out), Key(440, 1))))
        .overlay(alignment: .leading) {
            if ms > 700 && ms < 1300 {
                Rectangle()
                    .fill(sheen(peak: 0.5))
                    .frame(width: 48, height: 80)
                    .rotationEffect(.degrees(20))
                    .offset(x: -147 + track(ms, Key(700, 0, Ease.inOut), Key(1300, 520)))
                    .allowsHitTesting(false)
            }
        }
        .clipped()
        .accessibilityElement(children: .combine)
    }
}
