import SwiftUI

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
    @State private var showLog = false
    @State private var showEdit = false
    @State private var showNotes = false
    @State private var showPause = false
    @Binding var stepsOpen: Bool
    @Environment(HabitStore.self) private var store
    @Environment(\.openHabitPage) private var openHabitPage

    var body: some View {
        if habit.kind == .duration, isToday, let start = store.timers[habit.id] {
            // A running timer redraws its row every second: the clock ticks and the fill grows, so it's
            // plain that time is being counted. Anchor it at the timer's own start: `.now` changes the
            // schedule on every redraw, and `.distantPast` replays every missed tick; both redraw
            // nonstop and freeze the app (28 Sep).
            TimelineView(.periodic(from: start, by: 1)) { context in
                row(now: context.date)
            }
        } else {
            row(now: .now)
        }
    }

    private var isRunning: Bool { isToday && store.timers[habit.id] != nil }

    @ViewBuilder
    private func row(now: Date) -> some View {
        let progress = store.progress(of: habit, on: day, now: now)
        // Past days show the goal they had (goal history, spec §8.2).
        let goal = store.goal(of: store.rule(habit, on: day))
        // A cut-back habit is "met" while under its maximum, but never shown as finished.
        let done = slot.map { store.isSlotDone(habit, slot: $0, on: day) } ?? (store.isDone(habit, on: day) && !habit.atMost)
        let streak = store.streak(of: habit, asOf: day)
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
                if lineOverride == nil { noteLine }
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
          .onTapGesture { if logsNumbers && day <= store.today() { showLog = true } }
          .accessibilityAction(named: habit.kind == .duration ? "Log time manually" : "Log amount manually") { if logsNumbers && day <= store.today() { showLog = true } }
            actionButton(done: done)
                .frame(height: RowBand.height)
                .disabled(habit.kind != .checklist && day > store.today())
        }
        // The same spacing as the Quitting rows.
        .padding(.vertical, 2)
        .listRowBackground(ProgressFill(progress: habit.atMost ? 0 : progress / max(goal, 1), color: habit.color)
            .overlay(HighlightFlash(on: highlighted || store.noteTarget == .init(habit: habit.id, day: day), color: habit.color)))
        .sheet(isPresented: $showLog) { LogProgressView(habit: habit, day: day) }
        .sheet(isPresented: $showEdit) { EditHabitSheet(habit: habit) }
        .sheet(isPresented: $showNotes) { HabitNotesView(habit: habit) }
        .sheet(isPresented: $showPause) { PauseSheet(habit: habit) }
        // Swipe left for a note, on any day and whether or not it's done: the standard iOS row gesture (Mail,
        // Reminders), for people who don't long-press. Opens the same field in the row.
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            if day <= store.today() {
                Button { startWriting() } label: { Label(store.note(of: habit, on: day) == nil ? "Note" : "Edit Note", systemImage: "note.text") }
                    .tint(.indigo)
            }
        }
        .contextMenu {
            // Edit sits with the item's other actions, as in Reminders; a tap on the row logs (spec §8).
            Button(habit.kind == .task ? "Edit Task" : "Edit Habit", systemImage: "pencil") { showEdit = true }
            // Its own page: history calendar, streak and best, notes (habit page report). Never on a tap: a tap logs.
            if let openHabitPage {
                Button(habit.kind == .task ? "View Task" : "View Habit", systemImage: "info.circle") { openHabitPage(habit.id) }
            }
            // A stretch of days off: travel, illness (pause report, 29 Sep). Skip today stays for one day.
            PauseMenuItems(habit: habit, showPause: $showPause)
            // Any day, done or not, past or today; a note never changes progress (notes report, 29 Sep).
            Button(store.note(of: habit, on: day) == nil ? "Add Note" : "Edit Note", systemImage: "note.text") { startWriting() }
                .disabled(day > store.today())
            if !store.notes(of: habit).isEmpty {
                Button("All Notes", systemImage: "list.bullet.rectangle") { showNotes = true }
            }
            if case .amount = habit.kind {
                Button("Log amount manually", systemImage: "square.and.pencil") { showLog = true }.disabled(day > store.today())
                Button("Undo Last Entry") { store.undoProgress(habit, on: day) }
                    .disabled(progress <= 0 || day > store.today())
            }
            if habit.kind == .duration {
                Button("Log time manually", systemImage: "square.and.pencil") { showLog = true }.disabled(day > store.today())
                Button("Undo Last Entry") { store.undoProgress(habit, on: day) }
                    .disabled(progress <= 0 || day > store.today())
            }
        }
    }

    // MARK: The note, in place

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
    private func actionButton(done: Bool) -> some View {
        if habit.kind == .checklist {
            // The button opens and closes the items; the checklist is done when every item is.
            RoundActionButton(symbol: stepsOpen ? "chevron.up" : "chevron.down", done: done, color: habit.color,
                              label: stepsOpen ? "Hide \(habit.name) steps" : "Show \(habit.name) steps") {
                withAnimation { stepsOpen.toggle() }
            }
        } else {
            switch habit.kind {
            case .check, .task:
                RoundActionButton(symbol: "checkmark", done: done, color: habit.color,
                                  label: done ? "Undo \(habit.name)" : "Mark \(habit.name) done") {
                    if !done { offerNote() }
                    withAnimation {
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
                        withAnimation { store.increment(habit, on: day) }
                    }
                } else {
                    RoundActionButton(symbol: "plus", done: done, color: habit.color,
                                      label: "Add an amount to \(habit.name)",
                                      keepSymbolWhenDone: true) {
                        showLog = true
                    }
                }
            case .duration:
                let running = store.timers[habit.id] != nil
                RoundActionButton(symbol: running ? "pause.fill" : "play.fill", done: done && !running, color: habit.color,
                                  label: running ? "Stop \(habit.name) timer" : "Start \(habit.name) timer") {
                    if store.timers[habit.id] == nil { TimerPresence.askOnNextSync = true } else { offerNote() }
                    withAnimation { store.toggleTimer(habit, slot: slot) }
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

    var body: some View {
        let done = store.isStepDone(step, of: habit, on: day)
        HStack(spacing: 12) {
            Text(step.name.capped(HabitRow.nameShown)).font(.subheadline).foregroundStyle(done ? .secondary : .primary).lineLimit(1)
                .accessibilityLabel(step.name)
            Spacer(minLength: 8)
            RoundActionButton(symbol: "checkmark", done: done, color: habit.color,
                              label: done ? "Undo \(step.name)" : "Mark \(step.name) done") {
                if !done { store.noteOffer = .init(habit: habit.id, day: day) }
                withAnimation { store.toggleStep(step, of: habit, on: day) }
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
    @Environment(\.openHabitPage) private var openHabitPage
    @State private var showEdit = false
    @State private var showPause = false
    private var today: LocalDay { store.today() }
    /// Set once, on a whole second, so every quit clock ticks together.
    private static let anchor = Date(timeIntervalSinceReferenceDate: Date.now.timeIntervalSinceReferenceDate.rounded(.down))

    var body: some View {
        // A fixed anchor: `.now` gave a new schedule on every redraw, restarting the clock each time (see HabitRow).
        TimelineView(.periodic(from: Self.anchor, by: 1)) { context in
            let runs = store.quitRuns(of: habit, now: context.date)
            HStack(alignment: .top, spacing: 12) {
                HabitIcon(symbol: habit.symbol, color: habit.color)
                    .frame(height: RowBand.height)
                VStack(alignment: .leading, spacing: 1) {
                    Text(habit.name.capped(HabitRow.nameShown)).font(.body).lineLimit(1).accessibilityLabel(habit.name)
                    Text("Best \(Format.days(runs.best))").font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
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
                Text(Format.elapsed(runs.current))
                    .font(.body.monospacedDigit().weight(.semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .fixedSize()
                    .frame(height: RowBand.height)
            }
            .padding(.vertical, 2)
            .accessibilityElement(children: .combine)
        }
        .listRowBackground(Color(.secondarySystemGroupedBackground).overlay(HighlightFlash(on: highlighted, color: habit.color)))
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button { store.noteTarget = .init(habit: habit.id, day: today) } label: {
                Label(store.note(of: habit, on: today) == nil ? "Note" : "Edit Note", systemImage: "note.text")
            }
            .tint(.indigo)
        }
        .contextMenu {
            Button("Edit Habit", systemImage: "pencil") { showEdit = true }
            if let openHabitPage { Button("View Habit", systemImage: "info.circle") { openHabitPage(habit.id) } }
            // Pausing ends this run (kept as a run, not a slip); a new one starts when it's back (the user, 29 Sep).
            PauseMenuItems(habit: habit, showPause: $showPause)
            Button(store.note(of: habit, on: today) == nil ? "Add Note" : "Edit Note", systemImage: "note.text") {
                store.noteTarget = .init(habit: habit.id, day: today)
            }
        }
        .sheet(isPresented: $showEdit) { EditHabitSheet(habit: habit) }
        .sheet(isPresented: $showPause) { PauseSheet(habit: habit) }
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
            HStack(spacing: 8) {
                Text(shownTitle).font(.headline).lineLimit(1)
                    .background {
                        Text(shownTitle).font(.headline).lineLimit(1).fixedSize().hidden()
                            .onGeometryChange(for: CGFloat.self) { $0.size.width } action: { titleWidth = $0 }
                    }
                if isNow { NowChip().fixedSize() }
                if let count = iconCount { FoldedIcons(habits: habits, max: count).fixedSize().padding(.leading, 2) }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .onGeometryChange(for: CGFloat.self) { $0.size.width } action: { room = $0 }
            // VoiceOver reads the header as one button; Start stays its own button.
            .accessibilityElement(children: .ignore)
            .accessibilityLabel([title, isNow ? "Now" : nil, status ?? "\(habits.count) habits"].compactMap { $0 }.joined(separator: ", "))
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
                      description: store.description(of: habit) ?? "") { _ in onSaved() }
        }
    }
}

/// The note line's small icon, tight to the text.
private struct NoteLineLabel: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 4) { configuration.icon.imageScale(.small); configuration.title }
    }
}

extension EnvironmentValues {
    /// Opens a habit's own page from a row's long-press menu. Set by Today; nil elsewhere (the New Habit preview,
    /// the page itself), where the menu leaves the item out.
    @Entry var openHabitPage: ((UUID) -> Void)? = nil
}

/// The band at the top of every row that the icon, streak and button sit in (the row's minimum height).
enum RowBand { static let height: CGFloat = 44 }
