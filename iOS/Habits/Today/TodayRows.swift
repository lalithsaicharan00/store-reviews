import SwiftUI
import UIKit

/// "3/8 glasses", "12/20 min", "2/3 this week", "1/4 items", "0/2 cups max": one format for every habit.
/// While a timer runs, time is a live clock instead: "7:42/20 min" ("Timing a Habit", 28 Sep).
func goalLine(_ habit: Habit, progress: Double, goal: Double, running: Bool = false) -> String {
    let period = switch habit.frequency {
    case .perWeek: " this week"
    case .perMonth: " this month"
    case .perYear: " this year"
    default: ""
    }
    if habit.atMost {
        let unit: String
        if case .amount(let text, _) = habit.kind { unit = text.isEmpty ? "" : " " + text } else { unit = "" }
        return "\(Format.amount(progress))\(unit) logged\(period.isEmpty ? " today" : period) · limit \(Format.amount(goal))"
    }
    let max = ""
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
    case .check, .quit, .task:
        return "\(Format.amount(progress))/\(Format.amount(goal))\(max)\(period)"
    }
}

/// One-time tasks: the time if set, and where it came from if it moved forward.
func taskLine(_ habit: Habit, shownOn day: LocalDay, calendar: Calendar) -> String {
    var parts: [String] = []
    if let due = habit.dueDay, due < day {
        parts.append("From " + due.date(calendar: calendar).formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)))
    }
    if let minute = habit.dueMinute {
        let time = calendar.date(bySettingHour: minute / 60, minute: minute % 60, second: 0, of: .now)!
        parts.append(time.formatted(date: .omitted, time: .shortened))
    }
    return parts.isEmpty ? "Task" : parts.joined(separator: " · ")
}

struct HabitRow: View {
    /// Names on Today show this many characters, then "…", so every row stays on one line.
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
        // Top-aligned (the user, 29 Sep): icon, streak and button sit in a 44-pt band at the top of the row. Rows
        // of one or two lines look centred; with three or more lines the text runs on below instead of the icon
        // and button drifting to the middle.
        HStack(alignment: .top, spacing: 12) {
          // The row itself opens Add Amount / Add Time for any count or timed habit: one place to type a
          // number, for every habit (research: "Logging a Count — One Tap or Type", 28 Sep).
          HStack(alignment: .top, spacing: 12) {
            HabitIcon(symbol: habit.symbol, color: habit.color)
                .frame(height: RowBand.height)
            VStack(alignment: .leading, spacing: 1) {
                // One line always: names show 15 characters, then "…".
                Text(habit.name.capped(HabitRow.nameShown)).font(.body).foregroundStyle(done ? .secondary : .primary).lineLimit(1)
                    .accessibilityLabel(habit.name) // VoiceOver reads it in full
                let line = lineOverride ?? subtitle(progress: progress, goal: goal)
                if !line.isEmpty { Text(line)
                    .font(.subheadline).foregroundStyle(isRunning ? .primary : .secondary)
                    .monospacedDigit()
                    .lineLimit(habit.atMost ? 2 : 1) }
                // How often, in words, for rules that name days: "Every Mon and Wed", "On the 1st of every month".
                let rhythm = HabitCopy.todayCaption(habit, weekStart: store.settings.weekStart)
                if !rhythm.isEmpty {
                    Text(rhythm)
                        .font(.caption).foregroundStyle(.secondary)
                        .lineLimit(1)
                        .accessibilityIdentifier("habit-rhythm")
                }
                // The note, "Add note", a milestone and Undo: in their own small view, so a tap that offers them redraws
                // that line, not every row on Today (lesson L16, 2 Oct).
                if lineOverride == nil { RowOfferLine(habit: habit, day: day) }
                if case .flexible(let period, let needed) = habit.frequency,
                   let count = store.flexibleProgress(habit, on: day) {
                    Text(count > needed ? "\(count) days this \(period.noun) · goal reached"
                         : "\(count) of \(needed) \(needed == 1 ? "day" : "days") this \(period.noun)\(count == needed ? " ✓" : "")")
                        .font(.caption).foregroundStyle(.secondary)
                        .accessibilityIdentifier("flexible-progress")
                }
            }
            .frame(minHeight: RowBand.height)
            Spacer(minLength: 8)
            if streak > 0 {
                StreakLabel(count: streak, unit: habit.frequency.streakUnit, onFill: progress / max(goal, 1) >= 0.7)
                    .frame(height: RowBand.height)
            }
          }
          .contentShape(Rectangle())
          .onTapGesture { if logsNumbers && day <= store.today() { sheet = .log } }
          .accessibilityAction(named: "Undo last log") {
              if let entry = store.undoOffer, entry.habitID == habit.id, entry.day == day { store.undoEntry(entry.id) }
          }
          .accessibilityAction(named: habit.kind == .duration ? "Log time manually" : "Log amount manually") { if logsNumbers && day <= store.today() { sheet = .log } }
            actionButton(done: done, progress: progress, goal: goal)
                .frame(height: RowBand.height)
                .disabled(habit.kind != .checklist && day > store.today())
        }
        // The same spacing as the Quitting rows.
        .padding(.vertical, 2)
        .listRowBackground(ProgressFill(progress: habit.atMost ? 0 : progress / max(goal, 1), color: habit.color)
            .overlay(NoteTargetFlash(habit: habit, day: day, highlighted: highlighted)))
        // Logged from the sheet: the row stays where it is until the person pauses, as after a tap (#58). The day's own
        // rule, so a past day is logged against the goal it had then.
        .sheet(item: $sheet, onDismiss: {
            if logged { logged = false; layout?.hold(reduceMotion: reduceMotion) }
        }) { shown in
            switch shown {
            case .log: LogProgressView(habit: store.rule(habit, on: day), day: day).onAppear { logged = true }
            case .edit: EditHabitSheet(habit: habit)
            case .notes: HabitNotesView(habit: habit)
            case .pause: PauseSheet(habit: habit)
            }
        }
        // Swipe left for a note, on any day and whether or not it's done: the standard iOS row gesture (Mail,
        // Reminders), for people who don't long-press. Opens the same field in the row.
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            if day <= store.today() {
                Button { startWriting() } label: { Label(store.note(of: habit, on: day) == nil ? "Note" : "Edit Note", systemImage: "note.text") }
                    .tint(.indigo)
            }
        }
        .contextMenu {
            Button(day == store.today() ? "Edit Today's Progress…" : "Edit Progress…", systemImage: "calendar") { store.dayTarget = .init(habitID: habit.id, day: day) }
                .disabled(day > store.today())
            // Edit sits with the item's other actions, as in Reminders; a tap on the row logs (spec §8).
            Button(habit.kind == .task ? "Edit Task" : "Edit Habit", systemImage: "pencil") { sheet = .edit }
            // A stretch of days off: travel, illness (pause report, 29 Sep). Skip today stays for one day.
            PauseMenuItems(habit: habit, showPause: showing(.pause))
            // Any day, done or not, past or today; a note never changes progress (notes report, 29 Sep).
            Button(store.note(of: habit, on: day) == nil ? "Add Note" : "Edit Note", systemImage: "note.text") { startWriting() }
                .disabled(day > store.today())
            if store.hasNotes(habit) {
                Button("All Notes", systemImage: "list.bullet.rectangle") { sheet = .notes }
            }
            if case .amount = habit.kind {
                Button("Log amount manually", systemImage: "square.and.pencil") { sheet = .log }.disabled(day > store.today())
                Button("Undo Last Entry") { undoLast() }
                    .disabled(progress <= 0 || day > store.today())
            }
            if habit.kind == .duration {
                Button("Log time manually", systemImage: "square.and.pencil") { sheet = .log }.disabled(day > store.today())
                Button("Undo Last Entry") { undoLast() }
                    .disabled(progress <= 0 || day > store.today())
            }
        }
    }

    private func undoLast() {
        layout?.hold(reduceMotion: reduceMotion)
        TickFeedback.undone()
        withAnimation(Motion.tick(reduceMotion)) { store.undoProgress(habit, on: day) }
    }

    /// Every log from the row's button: hold Today's order, answer the tap (haptic, chime), then change the data inside
    /// the tick animation so the button fills and the row's colour sweeps across (research §1).
    private func log(finished: Bool, undo: Bool = false, _ change: () -> Void) {
        layout?.hold(reduceMotion: reduceMotion)
        if undo { TickFeedback.undone() } else { TickFeedback.logged(finished: finished) }
        withAnimation(Motion.tick(reduceMotion)) { change() }
    }

    // MARK: The note, in place

    /// After a check, an amount or a stopped timer: this row offers "Add note" (and no other row does).
    private func offerNote() {
        guard day <= store.today() else { return }
        withAnimation(.easeOut(duration: 0.2)) { store.noteOffer = .init(habit: habit.id, day: day) }
    }

    /// Opens the note bar for this habit and day. The row is held in place (and marked) while the note is written.
    private func startWriting() {
        store.noteOffer = .init(habit: habit.id, day: day)
        withAnimation(.snappy) { store.noteTarget = .init(habit: habit.id, day: day) }
    }

    /// Counts and timed habits take a typed number from the row (Add Amount / Add Time).
    private var logsNumbers: Bool {
        switch habit.kind {
        case .amount, .duration: true
        default: false
        }
    }

    /// "3/8 glasses", "1/3", "12 min/20 min"; a once-a-day tick shows no "0/1", only its time if it has one.
    private func subtitle(progress: Double, goal: Double) -> String {
        let time = self.time.map { DaySection.clock($0.minuteOfDay) }
        if habit.kind == .task { return taskLine(habit, shownOn: day, calendar: store.calendar) }
        // A once-a-day tick, or one part's tick of a habit done in several times of day, is a single
        // tick: no "0/1" or "0/2", just its time if it has one.
        if habit.kind == .check && habit.frequency.isDayBased && (slot != nil || goal <= 1) {
            return time ?? ""
        }
        return goalLine(habit, progress: progress, goal: goal, running: isRunning) + (time.map { " · " + $0 } ?? "")
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
            case .check, .task:
                RoundActionButton(symbol: "checkmark", done: done, color: habit.color,
                                  label: done ? "Undo \(habit.name)" : "Mark \(habit.name) done") {
                    if !done { offerNote() }
                    // A habit ticked several times a day is done on its last tick; a per-section tick on its own.
                    log(finished: !done && (slot != nil || progress + 1 >= goal), undo: done) {
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
            Text(step.name.capped(HabitRow.nameShown)).font(.subheadline).foregroundStyle(done ? .secondary : .primary).lineLimit(1)
                .accessibilityLabel(step.name)
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
        .padding(.leading, 44)
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
    /// One `.sheet(item:)` for the row's three sheets (PERFORMANCE.md rule 10).
    @State private var sheet: QuitSheet?
    /// The slip just logged, offered for Undo for a few seconds.
    @State private var lastSlip: UUID?
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
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .top, spacing: 12) {
                HabitIcon(symbol: habit.symbol, color: habit.color)
                    .frame(height: RowBand.height)
                VStack(alignment: .leading, spacing: 1) {
                    Text(habit.name.capped(HabitRow.nameShown)).font(.body).lineLimit(1).accessibilityLabel(habit.name)
                    RowClock(start: tick) { now in
                        Text("Best \(Format.days(max(pastBest, current(now))))").font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
                    }
                    if let id = lastSlip { SlipUndoLine(id: id) { withAnimation { lastSlip = nil } } }
                    // A craving or a slip, noted for today (quit rows take notes too, 29 Sep).
                    if let note = store.note(of: habit, on: today) {
                        Button { store.noteTarget = .init(habit: habit.id, day: today) } label: {
                            Label(note, systemImage: "note.text")
                                .font(.caption).foregroundStyle(.secondary)
                                .lineLimit(2).multilineTextAlignment(.leading)
                                .labelStyle(NoteLineLabel())
                        }
                        .buttonStyle(.borderless)
                    }
                }
                .frame(minHeight: RowBand.height)
                Spacer(minLength: 8)
                RowClock(start: tick) { now in
                    Text(Format.elapsed(current(now)))
                        .font(.body.monospacedDigit().weight(.semibold))
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                        .fixedSize()
                }
                .frame(height: RowBand.height)
            }
            .padding(.vertical, 2)
            .accessibilityElement(children: .combine)
        HStack {
            Button("Slipped") { sheet = .slip }
                .disabled(store.isPaused(habit, on: today))
            if let entry = store.undoOffer, entry.habitID == habit.id, entry.day == today {
                Button { store.undoEntry(entry.id) } label: {
                    Text("Undo").frame(minWidth: 44, minHeight: 44)
                }
                    .accessibilityIdentifier("habit-inline-undo")
            }
        }.buttonStyle(.borderless).font(.caption)
        }
        .listRowBackground(Color(.secondarySystemGroupedBackground).overlay(HighlightFlash(on: highlighted, color: habit.color)))
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button { store.noteTarget = .init(habit: habit.id, day: today) } label: {
                Label(store.note(of: habit, on: today) == nil ? "Note" : "Edit Note", systemImage: "note.text")
            }
            .tint(.indigo)
        }
        .contextMenu {
            Button("Edit Habit", systemImage: "pencil") { sheet = .edit }
            // A slip is an event with its own time (Build Plan #60d); editing "Started" is only for fixing a wrong start.
            Button("Log a Slip…", systemImage: "arrow.uturn.backward.circle") { sheet = .slip }
            Button("Edit Today's Progress…", systemImage: "calendar") { store.dayTarget = .init(habitID: habit.id, day: today) }
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

/// The note line's small icon, tight to the text.
private struct NoteLineLabel: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 4) { configuration.icon.imageScale(.small); configuration.title }
    }
}

/// The band at the top of every row that the icon, streak and button sit in (the row's minimum height).
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

/// A row's note line, "Add note", the milestone a tap reached and its Undo. Only this reads the store's offers, so a
/// log (which sets them on every tap) redraws this line, not each row's whole body (lesson L16, 2 Oct 2026).
struct RowOfferLine: View {
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            noteLine
            // A milestone this tap reached, beside its Undo and only while that lasts: words, never a
            // pop-up (report "Milestones — Marking Progress Without Noise").
            if let entry = store.undoOffer, entry.habitID == habit.id, entry.day == day,
               let mark = store.milestoneOffer, mark.entry == entry.id {
                Label(mark.text, systemImage: "checkmark.seal.fill")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(habit.color.color)
                    .lineLimit(1)
                    .accessibilityIdentifier("today-milestone")
            }
            if let entry = store.undoOffer, entry.habitID == habit.id, entry.day == day {
                Button { store.undoEntry(entry.id) } label: {
                    Text(entry.undoLabel(for: habit)).frame(minWidth: 44, minHeight: 44, alignment: .leading)
                }
                    .buttonStyle(.borderless).font(.caption)
                    .accessibilityIdentifier("habit-inline-undo")
            }
        }
    }

    /// The note line: the note (tap to change it); or, right after logging, a small "Add note". Nothing when
    /// there's no note and nothing was just logged. Writing happens in the note bar above the keyboard, never in
    /// the row (research: typing in the card was hidden by the keyboard and too cramped, 29 Sep).
    @ViewBuilder private var noteLine: some View {
        if let note = store.note(of: habit, on: day) {
            Button { startWriting() } label: {
                Label(note, systemImage: "note.text")
                    .font(.caption).foregroundStyle(.secondary)
                    .lineLimit(2).multilineTextAlignment(.leading)
                    .labelStyle(NoteLineLabel())
            }
            .buttonStyle(.borderless)
            .accessibilityLabel("Note: \(note)")
            .accessibilityHint("Edit the note")
            .accessibilityIdentifier("habit-note-line")
        } else if store.noteOffer == .init(habit: habit.id, day: day) && store.note(of: habit, on: day) == nil {
            Button { startWriting() } label: {
                Label("Add note", systemImage: "square.and.pencil")
                    .font(.caption.weight(.medium))
                    .labelStyle(NoteLineLabel())
            }
            .buttonStyle(.borderless)
            .tint(.secondary)
            .transition(.opacity)
            .accessibilityIdentifier("habit-add-note")
        }
    }

    /// Opens the note bar for this habit and day (as the row's own swipe and menu do).
    private func startWriting() {
        store.noteOffer = .init(habit: habit.id, day: day)
        withAnimation(.snappy) { store.noteTarget = .init(habit: habit.id, day: day) }
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
