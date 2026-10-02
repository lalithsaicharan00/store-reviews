import SwiftUI

/// One habit's own page, opened from All Habits (Build Plan #56b; report "The Habit Page — What People Expect").
/// What it is first, then its numbers and a calendar of its days, its notes, and Edit, Pause, Archive and Delete.
/// It's never the way to check off: a tap on Today's row keeps logging.
struct HabitPageView: View {
    let id: UUID
    /// Opened from Progress: scroll to Over Time, on Progress's range and period (report §7.3).
    var overTime: OverTimeStart? = nil
    @Environment(HabitStore.self) private var store
    @AppStorage(ProgressOptions.showStreaks) private var showStreaks = true
    @Environment(\.dismiss) private var dismiss
    @State private var showEdit = false
    @State private var showPause = false
    @State private var showNotes = false
    @State private var showPlus = false
    @State private var confirmingDelete = false
    @State private var month: LocalDay?
    @State private var noteDay: LocalDay?
    @State private var progressDay: LocalDay?

    var body: some View {
        if let habit = store.habits.first(where: { $0.id == id }) {
            page(habit)
        } else {
            ContentUnavailableView("Habit Deleted", systemImage: "trash")
        }
    }

    private func page(_ habit: Habit) -> some View {
        let today = store.today()
        let pause = store.pause(of: habit, on: today)
        return ScrollViewReader { proxy in List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 12) {
                        HabitIcon(symbol: habit.symbol, color: habit.color, size: 44)
                        Text(habit.name).font(.title2.weight(.bold)).lineLimit(2)
                    }
                    Text(Self.sentence(habit, store: store)).font(.callout).foregroundStyle(.secondary)
                    if let description = store.description(of: habit) {
                        Text(description).font(.callout)
                    }
                }
                .padding(.vertical, 4)
            }
            if let pause, pause.contains(today) {
                Section {
                    HStack {
                        Label(Self.pausedText(pause, store: store), systemImage: "pause.circle")
                        Spacer(minLength: 8)
                        Button("Resume") { store.resume(habit) }
                            .buttonStyle(.bordered)
                            .tint(habit.color.color)
                    }
                }
            }
            if habit.kind != .task {
                Section { numbers(habit) }
            }
            Section {
                Button { progressDay = today } label: {
                    HStack {
                        Text("Today").foregroundStyle(.primary)
                        Spacer()
                        Text(store.dayResult(habit, on: today)).foregroundStyle(.secondary)
                        Image(systemName: "chevron.right").font(.caption.weight(.semibold)).foregroundStyle(.tertiary)
                    }
                }
                .accessibilityIdentifier("habit-today-progress")
            }
            if habit.kind != .quit && habit.kind != .task {
                Section {
                    HabitMonthView(habit: habit, month: Binding(get: { month ?? Self.firstOfMonth(today, store.calendar) },
                                                                set: { month = $0 }), onSelect: { progressDay = $0 })
                        .id("month-calendar")
                        .onAppear { store.analytics.count(.habitCalendar, ticket: store.analytics.ticket) }
                }
                OverTimeSection(habit: habit, start: overTime)
                HabitYearSection(habit: habit) { first in
                    month = first
                    withAnimation { proxy.scrollTo("month-calendar", anchor: .top) }
                }
                // Runs are streaks: Show Streaks off hides them too (report §7.6).
                if showStreaks {
                    HabitRunsSection(habit: habit)
                    // Every streak milestone reached, kept for good, and the next (report "Milestones", 30 Sep).
                    Section("Milestones") { milestones(habit, today: today) }
                }
            }
            if habit.kind == .quit {
                QuitOverTimeSection(habit: habit)
                HabitYearSection(habit: habit) { _ in }
            }
            notesSection(habit, today: today)
            Section {
                if store.canPause(habit) || pause != nil {
                    if let pause {
                        if pause.contains(today) {
                            Button("Resume", systemImage: "play.circle") { store.resume(habit) }
                        } else {
                            Button("Cancel Pause from \(PauseSheet.short(pause.from, calendar: store.calendar))", systemImage: "xmark.circle") {
                                store.resume(habit)
                            }
                        }
                    } else {
                        Button("Pause…", systemImage: "pause.circle") { showPause = true }
                    }
                }
                if habit.archived {
                    Button("Restore", systemImage: "arrow.uturn.backward") { if !store.restore(habit) { showPlus = true } }
                } else {
                    Button("Archive", systemImage: "archivebox") { store.archive([habit]) }
                }
                Button("Delete", systemImage: "trash", role: .destructive) { confirmingDelete = true }
            } footer: {
                Text("Archive stops it and keeps its history. Delete removes it and its history for good.")
            }
        }
        .task {
            // From Progress: straight to Over Time, once the list has laid out.
            guard overTime != nil, habit.kind != .task else { return }
            try? await Task.sleep(for: .milliseconds(150))
            withAnimation { proxy.scrollTo("over-time", anchor: .top) }
        }
        }
        .analyticsScreen(.habitDetail)
        .navigationTitle(habit.name.capped(HabitRow.nameShown))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) { Button("Edit") { showEdit = true } }
        }
        .sheet(item: $progressDay) { DaySheet(habit: habit, day: $0) }
        .onPerfCommand { action in
            switch action {
            case .openDay(let day): progressDay = day
            case .openEdit: showEdit = true
            case .closeDay: progressDay = nil; showEdit = false
            default: break
            }
        }
        .sheet(isPresented: $showEdit) { EditHabitSheet(habit: habit) }
        .sheet(isPresented: $showPause) { PauseSheet(habit: habit) }
        .sheet(isPresented: $showNotes) { HabitNotesView(habit: habit) }
        .sheet(isPresented: $showPlus) { PlusView() }
        .confirmationDialog("Delete \(habit.name)?", isPresented: $confirmingDelete, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                dismiss()
                store.delete([habit])
            }
            if !habit.archived { Button("Archive Instead") { store.archive([habit]) } }
        } message: {
            Text("Its history and notes are deleted too, and this can't be undone. Archiving stops it and keeps its history.")
        }
        .safeAreaInset(edge: .bottom) {
            if let day = noteDay {
                NoteBar(title: habit.name + " · " + NoteSheet.dayText(day, today: today, calendar: store.calendar),
                        initial: store.note(of: habit, on: day) ?? "",
                        onSave: { store.setNote($0, of: habit, on: day) },
                        onClose: { withAnimation(.snappy) { noteDay = nil } })
                    .id(day.key)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }

    // MARK: Numbers

    @ViewBuilder private func numbers(_ habit: Habit) -> some View {
        if habit.kind == .quit {
            // The live clock, best run, clean days, next milestone and Log a Slip (report §10.3; Build Plan #60d).
            QuitNumbers(habit: habit)
        } else {
            let unit = habit.frequency.streakUnit
            let today = store.today()
            let done = store.doneThisMonth(habit, through: today)
            VStack(spacing: 10) {
                HStack(spacing: 0) {
                    // "Show Streaks" off (Progress's view options) hides streaks and bests here too (report §7.6).
                    if showStreaks {
                        stat(unit.short(store.streak(of: habit, asOf: today)), "Streak")
                        stat(unit.short(store.bestStreak(of: habit)), "Best")
                    }
                    stat(done == 1 ? "1 day" : "\(done) days", "Done this month")
                }
                // A total a break can't take away (report §8.1).
                if let line = store.totalLine(of: habit, today: today) {
                    Text(line).font(.footnote).foregroundStyle(.secondary).monospacedDigit()
                        .frame(maxWidth: .infinity)
                        .accessibilityIdentifier("habit-total-line")
                }
            }
        }
    }

    private func stat(_ value: String, _ label: String) -> some View {
        VStack(spacing: 2) {
            Text(value).font(.title3.weight(.semibold).monospacedDigit()).lineLimit(1).minimumScaleFactor(0.7)
            Text(label).font(.caption).foregroundStyle(.secondary).lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
    }

    // MARK: Notes

    /// "Reached: 7 and 30 days", "Next: 100 days in a row, 64 to go". From the streak and the best, never stored.
    @ViewBuilder private func milestones(_ habit: Habit, today: LocalDay) -> some View {
        let unit = store.rule(habit, on: today).frequency.streakUnit
        let current = store.streak(of: habit, asOf: today)
        let reached = unit.milestones(upTo: max(store.bestStreak(of: habit), current))
        let next = unit.nextMilestone(after: current)
        // Identifiers on the rows: a Section repeats its modifiers on every row (Design Rules).
        LabeledContent("Reached", value: reached.isEmpty ? "None yet" : unit.list(reached))
            .accessibilityIdentifier("habit-milestones-reached")
            .onAppear { store.analytics.count(.milestones, ticket: store.analytics.ticket) }
        LabeledContent("Next", value: "\(unit.inARow(next)), \(next - current) to go")
            .accessibilityIdentifier("habit-milestones-next")
    }

    @ViewBuilder private func notesSection(_ habit: Habit, today: LocalDay) -> some View {
        let notes = store.notes(of: habit)
        Section("Notes") {
            ForEach(notes.prefix(3), id: \.day) { note in
                Button { withAnimation(.snappy) { noteDay = note.day } } label: {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(NoteSheet.dayText(note.day, today: today, calendar: store.calendar))
                            .font(.subheadline.weight(.semibold)).foregroundStyle(.secondary)
                        Text(note.text).foregroundStyle(.primary).lineLimit(3).multilineTextAlignment(.leading)
                    }
                }
            }
            if notes.count > 3 {
                Button("All Notes (\(notes.count))") { showNotes = true }
            }
            if store.note(of: habit, on: today) == nil {
                Button("Add Note for Today", systemImage: "square.and.pencil") { withAnimation(.snappy) { noteDay = today } }
            }
        }
    }

    // MARK: Words shared with All Habits

    /// The habit in one sentence, with its parts of the day: "Water 8 glasses a day, morning".
    static func sentence(_ habit: Habit, store: HabitStore) -> String {
        if habit.kind == .quit {
            let since = (habit.quitSince ?? habit.createdAt).formatted(.dateTime.day().month(.abbreviated).year())
            return "Quitting since \(since)"
        }
        if habit.kind == .task, let due = habit.dueDay {
            return "\(habit.name) on \(PauseSheet.short(due, calendar: store.calendar))"
        }
        let parts = habit.parts == [.anytime] ? "anytime" : HabitCopy.partsPhrase(habit.parts.map { store.section($0).name })
        return HabitCopy.sentence(habit, weekStart: store.settings.weekStart) + ", " + parts
    }

    /// The short line under a name in All Habits.
    static func summary(_ habit: Habit, store: HabitStore) -> String {
        if habit.archived { return "Archived" }
        let today = store.today()
        if let pause = store.pause(of: habit, on: today), pause.contains(today) { return pausedText(pause, store: store) }
        if habit.kind == .quit { return "Best run \(Format.days(store.quitRuns(of: habit).best))" }
        if habit.kind == .task, store.isDone(habit, on: today) { return habit.dueDay == nil ? "Done today" : "Completed" }
        if habit.kind == .task, let due = habit.dueDay { return "Planned for \(PauseSheet.short(due, calendar: store.calendar))" }
        return HabitCopy.capitalized(HabitCopy.plan(habit, weekStart: store.settings.weekStart, short: true))
    }

    static func pausedText(_ pause: HabitPause, store: HabitStore) -> String {
        guard let last = pause.through else { return "Paused until you turn it back on" }
        return "Paused · back " + PauseSheet.short(last.adding(days: 1, calendar: store.calendar), calendar: store.calendar)
    }

    static func firstOfMonth(_ day: LocalDay, _ calendar: Calendar) -> LocalDay {
        LocalDay(year: day.year, month: day.month, day: 1)
    }
}

/// One month of a habit's days. Every shape is round (Design Rules: calendar). Done is filled in the habit's colour,
/// some progress is a ring, a missed day is just its number (never a harsh mark, C095), and days that aren't its
/// days, paused or skipped are faint, with a small sign for paused and skipped.
struct HabitMonthView: View {
    let habit: Habit
    @Binding var month: LocalDay
    var onSelect: (LocalDay) -> Void = { _ in }
    @Environment(HabitStore.self) private var store

    var body: some View {
        let calendar = store.calendar
        let date = month.date(calendar: calendar)
        let count = calendar.range(of: .day, in: .month, for: date)?.count ?? 30
        let lead = (calendar.component(.weekday, from: date) - calendar.firstWeekday + 7) % 7
        let symbols = calendar.veryShortStandaloneWeekdaySymbols
        let ordered = Array(symbols[(calendar.firstWeekday - 1)...] + symbols[..<(calendar.firstWeekday - 1)])
        let today = store.today()
        let earliest = HabitPageView.firstOfMonth(store.startDay(of: habit), calendar)
        let latest = HabitPageView.firstOfMonth(today, calendar)
        VStack(spacing: 10) {
            HStack {
                Button("Previous month", systemImage: "chevron.left") { month = shift(-1) }
                    .labelStyle(.iconOnly)
                    .disabled(month <= earliest)
                Spacer()
                Text(date.formatted(.dateTime.month(.wide).year())).font(.headline)
                Spacer()
                Button("Next month", systemImage: "chevron.right") { month = shift(1) }
                    .labelStyle(.iconOnly)
                    .disabled(month > latest)
            }
            .buttonStyle(.borderless)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: 7), spacing: 6) {
                ForEach(MonthGridCell.month(places: lead + count), id: \.self) { item in
                    switch item {
                    case .weekday(let i): Text(ordered[i]).font(.caption2.weight(.semibold)).foregroundStyle(.secondary)
                    case .place(let place) where place < lead: Color.clear.frame(height: 36)
                    case .place(let place):
                        let day = LocalDay(year: month.year, month: month.month, day: place - lead + 1)
                        Button { onSelect(day) } label: { cell(day, isToday: day == today).frame(minHeight: 44) }
                            .buttonStyle(.borderless)
                            .disabled(day > today)
                            .accessibilityLabel(spoken(day))
                            .accessibilityIdentifier("habit-day-\(day.key)")
                    }
                }
            }
            HStack(spacing: 14) {
                legend(Circle().fill(habit.color.color), HabitStore.DayMark.done.words(atMost: habit.atMost))
                legend(Circle().strokeBorder(habit.color.color, lineWidth: 2), HabitStore.DayMark.some.words(atMost: habit.atMost))
                legend(Image(systemName: "pause.fill").font(.system(size: 8)).foregroundStyle(.secondary), "Paused")
                legend(Image(systemName: "forward.fill").font(.system(size: 8)).foregroundStyle(.secondary), "Skipped")
            }
            .font(.caption2)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }

    private func shift(_ months: Int) -> LocalDay {
        let d = store.calendar.date(byAdding: .month, value: months, to: month.date(calendar: store.calendar))!
        return HabitPageView.firstOfMonth(LocalDay(d, calendar: store.calendar), store.calendar)
    }

    private func cell(_ day: LocalDay, isToday: Bool) -> some View {
        // The day's button (in the grid) opens the day's sheet: its result, its entries, and filling in or fixing it
        // (Build Plan #57). It replaces the read-only popover (Progress report §8.2), which showed less and sat inside
        // the same button, so one of the two never received the tap (merge, 1 Oct 2026).
        mark(day, isToday: isToday)
    }

    private func mark(_ day: LocalDay, isToday: Bool) -> some View {
        let mark = store.dayMark(habit, on: day)
        let color = habit.color.color
        let faint = [.notItsDay, .before, .paused, .skipped].contains(mark)
        return ZStack {
            switch mark {
            case .done: Circle().fill(color)
            case .some: Circle().strokeBorder(color, lineWidth: 2)
            default: if isToday { Circle().strokeBorder(Color.secondary.opacity(0.5), lineWidth: 1) }
            }
            Text("\(day.day)")
                .font(.callout.monospacedDigit().weight(isToday ? .bold : .regular))
                .foregroundStyle(mark == .done ? AnyShapeStyle(.white) : faint ? AnyShapeStyle(.tertiary) : AnyShapeStyle(.primary))
        }
        .frame(width: 34, height: 34)
        .overlay(alignment: .bottom) {
            switch mark {
            case .paused: Image(systemName: "pause.fill").font(.system(size: 6)).foregroundStyle(.secondary).offset(y: 5)
            case .skipped: Image(systemName: "forward.fill").font(.system(size: 6)).foregroundStyle(.secondary).offset(y: 5)
            case .upcoming: Circle().fill(color.opacity(0.6)).frame(width: 4, height: 4).offset(y: 4)
            default: EmptyView()
            }
        }
        .frame(height: 36)
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }

    /// What VoiceOver says for a day: on the day's button, so the button stays a button (merge, 1 Oct 2026: the label on
    /// the drawing inside it made the drawing its own element, and the button vanished from VoiceOver and the tests).
    private func spoken(_ day: LocalDay) -> String {
        "\(day.date(calendar: store.calendar).formatted(.dateTime.weekday(.wide).day().month(.wide))), \(words(store.dayMark(habit, on: day)))"
    }

    private func words(_ mark: HabitStore.DayMark) -> String {
        mark.words(atMost: habit.atMost).lowercased()
    }

    private func legend(_ mark: some View, _ label: String) -> some View {
        HStack(spacing: 4) {
            mark.frame(width: 9, height: 9)
            Text(label)
        }
    }
}
