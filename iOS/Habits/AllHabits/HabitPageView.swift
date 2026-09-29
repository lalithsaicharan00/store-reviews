import SwiftUI

/// One habit's own page, opened from All Habits (Build Plan #56b; report "The Habit Page — What People Expect").
/// What it is first, then its numbers and a calendar of its days, its notes, and Edit, Pause, Archive and Delete.
/// It's never the way to check off: a tap on Today's row keeps logging.
struct HabitPageView: View {
    let id: UUID
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var showEdit = false
    @State private var showPause = false
    @State private var showNotes = false
    @State private var showPlus = false
    @State private var confirmingDelete = false
    @State private var month: LocalDay?
    @State private var noteDay: LocalDay?
    /// The day opened from the calendar, to fill in or change (report "Filling In a Past Day From the Habit Page").
    @State private var openDay: LocalDay?

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
        return List {
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
            if habit.kind != .quit && habit.kind != .task {
                Section {
                    HabitMonthView(habit: habit, month: Binding(get: { month ?? Self.firstOfMonth(today, store.calendar) },
                                                                set: { month = $0 }),
                                   onSelect: { openDay = $0 })
                } footer: {
                    if !habit.archived { Text("Tap a day to fill it in or change it.") }
                }
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
        .navigationTitle(habit.name.capped(HabitRow.nameShown))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) { Button("Edit") { showEdit = true } }
        }
        .sheet(isPresented: $showEdit) { EditHabitSheet(habit: habit) }
        .sheet(isPresented: $showPause) { PauseSheet(habit: habit) }
        .sheet(isPresented: $showNotes) { HabitNotesView(habit: habit) }
        .sheet(isPresented: $showPlus) { PlusView() }
        .sheet(item: $openDay) { day in
            HabitDaySheet(habit: habit, day: day) { withAnimation(.snappy) { noteDay = day } }
        }
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
            let runs = store.quitRuns(of: habit)
            HStack(spacing: 0) {
                stat(store.isPaused(habit, on: store.today()) ? "Paused" : Format.days(runs.current), "This run")
                stat(Format.days(runs.best), "Best run")
            }
        } else {
            let unit = habit.frequency.streakUnit
            let today = store.today()
            let first = Self.firstOfMonth(today, store.calendar)
            let done = stride(from: 0, to: today.day, by: 1)
                .map { first.adding(days: $0, calendar: store.calendar) }
                .filter { store.dayMark(habit, on: $0) == .done }.count
            HStack(spacing: 0) {
                stat(unit.short(store.streak(of: habit, asOf: today)), "Streak")
                stat(unit.short(store.bestStreak(of: habit)), "Best")
                stat(done == 1 ? "1 day" : "\(done) days", "Done this month")
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
    /// A tap on a day that can be filled in or changed (nil: the calendar only shows).
    var onSelect: ((LocalDay) -> Void)? = nil
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
                ForEach(Array(ordered.enumerated()), id: \.offset) { Text($0.element).font(.caption2.weight(.semibold)).foregroundStyle(.secondary) }
                ForEach(0..<lead, id: \.self) { _ in Color.clear.frame(height: 36) }
                ForEach(1...count, id: \.self) { d in
                    cell(LocalDay(year: month.year, month: month.month, day: d), isToday: LocalDay(year: month.year, month: month.month, day: d) == today)
                }
            }
            HStack(spacing: 14) {
                legend(Circle().fill(habit.color.color), "Done")
                legend(Circle().strokeBorder(habit.color.color, lineWidth: 2), "Some")
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

    @ViewBuilder private func cell(_ day: LocalDay, isToday: Bool) -> some View {
        if let onSelect, store.canChange(habit, on: day) {
            Button { onSelect(day) } label: { dayCell(day, isToday: isToday) }
                .buttonStyle(.plain)
                .accessibilityHint("Fill in or change this day")
        } else {
            dayCell(day, isToday: isToday)
        }
    }

    private func dayCell(_ day: LocalDay, isToday: Bool) -> some View {
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
        .contentShape(Rectangle())
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(day.date(calendar: store.calendar).formatted(.dateTime.weekday(.wide).day().month(.wide))), \(words(mark))")
    }

    private func words(_ mark: HabitStore.DayMark) -> String {
        switch mark {
        case .done: "done"
        case .some: "some done"
        case .missed: "not done"
        case .open: "not done yet"
        case .skipped: "skipped"
        case .paused: "paused"
        case .notItsDay: "not one of its days"
        case .upcoming: "coming up"
        case .before: "before it started"
        }
    }

    private func legend(_ mark: some View, _ label: String) -> some View {
        HStack(spacing: 4) {
            mark.frame(width: 9, height: 9)
            Text(label)
        }
    }
}
