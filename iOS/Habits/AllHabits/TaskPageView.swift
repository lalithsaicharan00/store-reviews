import SwiftUI

/// Task details (Figma 1136:9271: One-time · not done yet, One-time · done, Repeating, Menu open; Android's
/// `TaskDetailsScreen`). A task has no Progress, only its days, so no tabs: the header (icon 56, name, one line:
/// "One-time · Wed, 4 Nov · Morning", "One-time · done today", "Every 2 months · Next Wed, 9 Dec"), then
///
/// - **a one-time task not done yet:** the Planned card notice over Nothing Done Yet. A task is ticked on Today, never
///   here (U38);
/// - **done:** one card, "Done", then the day it was done ("Fri, 23 Oct", "Done at 9:12 AM", its note, ›);
/// - **repeating:** every time it was done, newest first, a card per year ("2026", "Done 4 times").
///
/// Each card folds from its first row; a day opens that day's Day details. Add Note floats at the bottom right. The ⋯
/// menu has Edit Task, Move to Another Day…, Duplicate, Archive and Delete, as the task's More button on Tasks.
struct TaskPageView: View {
    let task: Habit
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var data: TaskPageData?
    @State private var folded: Set<String> = []
    @State private var openDay: LocalDay?
    @State private var noteDay: NoteDay?
    @State private var choosingNoteDay = false
    @State private var showEdit = false
    @State private var moving = false
    @State private var confirmingDelete = false
    @State private var restoring: Habit?
    @State private var headerGone = false
    @State private var banner: String?
    @State private var bannerTask: Task<Void, Never>?

    struct NoteDay: Identifiable { let day: LocalDay; var id: String { day.key } }

    var body: some View {
        let today = store.today()
        let key = TaskPageData.Key(task: task, version: store.dataVersion, today: today)
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                header.padding(.bottom, 8)
                if let data { content(data) }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, task.archived ? 40 : 88)
            .frame(maxWidth: .infinity, minHeight: 0, alignment: .top)
        }
        .scrollBounceBehavior(.basedOnSize)
        .onScrollGeometryChange(for: Bool.self) { $0.contentOffset.y + $0.contentInsets.top > HabitPageView.headerHeight } action: { _, gone in
            withAnimation(.easeOut(duration: 0.15)) { headerGone = gone }
        }
        .background(Color(.systemGroupedBackground))
        .overlay(alignment: .bottomTrailing) {
            if !task.archived {
                Button(action: addNote) {
                    Label("Add Note", systemImage: "square.and.pencil").foregroundStyle(Color.onInk)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .tint(Color.ink)
                .fontWeight(.semibold)
                .accessibilityIdentifier("task-add-note")
                .dayCalendar(isPresented: $choosingNoteDay, habit: task) { noteDay = NoteDay(day: $0) }
                .padding(.trailing, 16)
                .padding(.bottom, 8)
            }
        }
        .overlay(alignment: .bottom) {
            if let banner {
                Banner(text: banner) { EmptyView() }
                    .padding(.bottom, 64)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .onAppear { data = TaskPageData.make(task, store: store, key: key) }
        .onChange(of: key) { data = TaskPageData.make(task, store: store, key: key) }
        .onDisappear { bannerTask?.cancel() }
        .navigationTitle(task.name.capped(HabitRow.nameShown))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(task.name.capped(HabitRow.nameShown))
                    .font(.headline)
                    .lineLimit(1)
                    .opacity(headerGone ? 1 : 0)
                    .accessibilityHidden(!headerGone)
            }
            ToolbarItem(placement: .topBarTrailing) { menu(today: today) }
        }
        .sheet(item: $openDay) { DaySheet(habit: task, day: $0) }
        .sheet(item: $noteDay) { target in noteSheet(target.day) }
        .sheet(isPresented: $showEdit) { EditHabitSheet(habit: task) }
        .sheet(isPresented: $moving) { moveSheet(today: today) }
        .restoringPastTheLimit($restoring)
        .alert("Delete \(task.name)?", isPresented: $confirmingDelete) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                // The page leaves first, then the task goes (U27).
                dismiss()
                store.delete([task])
            }
        } message: {
            // Cancel and Delete only (D9); Archive is the row above Delete in the ⋯ menu.
            Text(task.dueDay == nil
                 ? "It's a repeating task: it goes for good, with every time it was done and its notes. Archiving stops it and keeps its history."
                 : "Its notes are deleted too, and this can't be undone. Archiving keeps it.")
        }
        .analyticsScreen(.habitDetail)
    }

    // MARK: Header

    private var header: some View {
        HStack(alignment: .center, spacing: 16) {
            HabitIcon(symbol: task.symbol, color: task.color, size: 56)
            VStack(alignment: .leading, spacing: 0) {
                Text(task.name).font(.title2.weight(.bold)).lineLimit(2)
                    .accessibilityAddTraits(.isHeader)
                if let line = data?.line {
                    Text(line).font(.subheadline).foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("habit-header")
    }

    // MARK: Content

    @ViewBuilder private func content(_ data: TaskPageData) -> some View {
        if task.archived {
            let day = store.archivedOn[task.id]
            let when = day.map { $0 == store.today() ? "Archived today" : "Archived on \(DayWords.dayMonth($0, calendar: store.calendar))" }
            CardNotice(symbol: "archivebox", title: when ?? "Archived",
                       message: "It’s off Today and Tasks, and keeps its history. Restore it to plan it again.",
                       problem: false, id: "task-archived") {
                Button("Restore") { if !store.restore(task) { restoring = task } }
                    .controlSize(.small)
                    .accessibilityIdentifier("task-restore")
            }
            .padding(WeekSpacing.card)
            .background(Color.card, in: CardShape.shape)
        }
        if data.groups.isEmpty {
            if let planned = data.planned, !task.archived {
                CardNotice(symbol: "calendar", title: "Planned for " + planned, message: "It shows on Today that day; tick it there.",
                           problem: false, id: "task-planned") { EmptyView() }
                    .padding(WeekSpacing.card)
                    .background(Color.card, in: CardShape.shape)
            }
            // Right under the card, as in Figma, not centred in the room left.
            ContentUnavailableView("Nothing Done Yet", systemImage: "checkmark.circle",
                                   description: Text("When it’s done, the day shows here, with any note."))
                .accessibilityIdentifier("task-nothing-done")
        } else {
            ForEach(data.groups) { group in
                TaskDoneCard(group: group, color: task.color, isOpen: !folded.contains(group.id),
                             toggle: { withAnimation(.snappy) { folded.formSymmetricDifference([group.id]) } },
                             open: { openDay = $0 })
            }
        }
    }

    // MARK: Add Note

    /// A one-time task's note goes on its own day (the day it was done, else its planned day once it has come, else
    /// today); a repeating task asks which day, in History's calendar.
    private func addNote() {
        if task.dueDay == nil { choosingNoteDay = true; return }
        let today = store.today()
        let day = data?.groups.first?.days.first?.day ?? task.dueDay.flatMap { $0 <= today ? $0 : nil } ?? today
        noteDay = NoteDay(day: day)
    }

    @ViewBuilder private func noteSheet(_ day: LocalDay) -> some View {
        if store.note(of: task, on: day) == nil {
            AddNoteView(habit: task, day: day)
        } else {
            NavigationStack { NoteView(habit: task, day: day, startsEditing: true) }
                .presentationDetents([.large])
                .presentationBackground(Color(.systemGroupedBackground))
        }
    }

    // MARK: The ⋯ menu

    /// Figma's Menu open: Edit Task, Move to Another Day…, Duplicate, Archive, Delete in red. Done, a one-time task has
    /// Mark as Not Done where Move is; archived, Restore where Archive is.
    private func menu(today: LocalDay) -> some View {
        let done = task.dueDay != nil && !(data?.groups.isEmpty ?? true)
        let shownOn = data?.openDay ?? today
        return Menu {
            Button("Edit Task", systemImage: "pencil") { showEdit = true }
            if !task.archived {
                if done {
                    Button("Mark as Not Done", systemImage: "arrow.uturn.backward.circle") {
                        if let day = store.entries(of: task.id).last?.day { store.toggleCheck(task, on: day) }
                    }
                } else if store.rescheduleRange(of: task, shownOn: shownOn) != nil {
                    Button("Move to Another Day…", systemImage: "calendar") { moving = true }
                }
                Button("Duplicate", systemImage: "plus.square.on.square") { duplicate() }
                Button("Archive", systemImage: "archivebox") { store.archive([task]) }
            } else {
                Button("Restore", systemImage: "arrow.uturn.backward") { if !store.restore(task) { restoring = task } }
            }
            Button("Delete", systemImage: "trash", role: .destructive) { confirmingDelete = true }
        } label: {
            Image(systemName: "ellipsis")
                .accessibilityLabel("More")
        }
        .accessibilityIdentifier("habit-menu")
    }

    @ViewBuilder private func moveSheet(today: LocalDay) -> some View {
        let from = data?.openDay ?? task.dueDay ?? today
        if let range = store.rescheduleRange(of: task, shownOn: from) {
            RescheduleSheet(range: range, current: task.dueDay ?? from, title: "Another Day") { day in
                moving = false
                move(from: from, to: day)
            }
        }
    }

    private func move(from: LocalDay, to day: LocalDay) {
        if task.dueDay == nil {
            store.moveOccurrence(task, from: from, to: day)
        } else if var current = store.habits.first(where: { $0.id == task.id }) {
            current.dueDay = day
            store.update(current)
        }
        let words = day == store.today() ? "Today" : DayWords.short(day, calendar: store.calendar)
        say("Moved to \(words)")
    }

    private func duplicate() {
        var copy = task
        copy.id = UUID()
        copy.createdAt = .now
        copy.steps = task.steps.map { var step = $0; step.id = UUID(); return step }
        copy.reminders = task.reminders.map { var time = $0; time.id = UUID(); return time }
        store.add(copy)
        say("\(task.name) duplicated")
    }

    private func say(_ text: String) {
        withAnimation { banner = text }
        bannerTask?.cancel()
        bannerTask = Task {
            try? await Task.sleep(for: .seconds(3))
            guard !Task.isCancelled else { return }
            withAnimation { banner = nil }
        }
    }
}

/// What Task details shows, worked out once per change (walking a repeating task to its next day is up to a year of
/// checks: S8).
struct TaskPageData {
    struct Key: Equatable {
        let task: Habit
        let version: Int
        let today: LocalDay
    }

    struct Day: Identifiable, Equatable {
        let day: LocalDay
        let title: String
        let time: String
        let note: String?
        var id: String { day.key }
    }

    struct Group: Identifiable, Equatable {
        /// "Done", or the year.
        let title: String
        /// "Done 4 times" under a year; nil for a one-time task's "Done".
        let summary: String?
        let days: [Day]
        var id: String { title }
    }

    /// Under the name.
    let line: String
    /// A one-time task not done yet: "Wed, 4 Nov, Morning".
    let planned: String?
    /// Newest first.
    let groups: [Group]
    /// The day the task is open on (a repeating task's next one), for Move to Another Day….
    let openDay: LocalDay?

    @MainActor static func make(_ task: Habit, store: HabitStore, key: Key) -> TaskPageData {
        let calendar = store.calendar
        let today = key.today
        // Each day it was done, once, at its first tick.
        var firsts: [LocalDay: Entry] = [:]
        for entry in store.entries(of: task.id) where entry.stepID == nil && entry.value > 0 && entry.day <= today {
            if let seen = firsts[entry.day], seen.createdAt <= entry.createdAt { continue }
            firsts[entry.day] = entry
        }
        let done = firsts.values.sorted { $0.day > $1.day }
        func row(_ entry: Entry) -> Day {
            Day(day: entry.day, title: DayWords.short(entry.day, calendar: calendar),
                time: "Done at " + DayWords.clock(entry.createdAt, calendar: calendar),
                note: store.note(of: task, on: entry.day).flatMap { $0.isEmpty ? nil : $0 })
        }

        if let due = task.dueDay {
            let part = task.parts.first.map { store.section($0).name }
            let anytime = task.parts.first == nil || task.parts.first == .anytime
            let planned = DayWords.short(due, calendar: calendar) + (anytime ? "" : ", " + (part ?? ""))
            if let last = done.first {
                let when = last.day == today ? "done today" : "done " + DayWords.short(last.day, calendar: calendar)
                return TaskPageData(line: "One-time · " + when, planned: nil,
                                    groups: [Group(title: "Done", summary: nil, days: [row(last)])], openDay: nil)
            }
            return TaskPageData(line: "One-time · " + planned, planned: planned, groups: [], openDay: due)
        }

        // Repeating: a card per year, newest first.
        var years: [(Int, [Day])] = []
        for entry in done {
            let year = entry.day.year
            if let i = years.firstIndex(where: { $0.0 == year }) { years[i].1.append(row(entry)) } else { years.append((year, [row(entry)])) }
        }
        let groups = years.map { year, days in
            Group(title: "\(year)", summary: days.count == 1 ? "Done once" : "Done \(days.count) times", days: days)
        }
        let open = store.isDue(task, on: today) && !store.isDone(task, on: today) ? today : store.nextOccurrence(of: task, after: today)
        return TaskPageData(line: TaskLists.next(task, store), planned: nil, groups: groups, openDay: open)
    }
}

/// One card of days a task was done: its title row folds it, then a row per day (a tick in the task's colour, the
/// date, "Done at 9:12 AM", the day's note, ›), as History's month cards.
private struct TaskDoneCard: View {
    let group: TaskPageData.Group
    let color: HabitColor
    let isOpen: Bool
    let toggle: () -> Void
    let open: (LocalDay) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: toggle) {
                HStack(alignment: .center, spacing: 16) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(group.title).font(.body).foregroundStyle(.primary)
                        if let summary = group.summary {
                            Text(summary).font(.subheadline).foregroundStyle(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "chevron.right")
                        .font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
                        .rotationEffect(.degrees(isOpen ? 90 : 0))
                }
                .padding(.horizontal, WeekSpacing.card)
                .padding(.vertical, 15)
                .frame(minHeight: group.summary == nil ? 52 : 72)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityElement(children: .combine)
            .accessibilityValue(isOpen ? "Open" : "Folded")
            .accessibilityIdentifier("task-group-\(group.title)")
            if isOpen {
                Divider().padding(.horizontal, WeekSpacing.card)
                ForEach(group.days) { day in
                    row(day)
                    if day.id != group.days.last?.id {
                        Divider().padding(.leading, WeekSpacing.card + 36 + 16).padding(.trailing, WeekSpacing.card)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.card, in: CardShape.shape)
        .clipShape(CardShape.shape)
    }

    private func row(_ day: TaskPageData.Day) -> some View {
        Button { open(day.day) } label: {
            HStack(spacing: 16) {
                // The done square, as a done day's square on History.
                Image(systemName: "checkmark")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .frame(width: 24, height: 24)
                    .background(color.color, in: RoundedRectangle(cornerRadius: 6, style: .continuous))
                    .frame(width: 36, height: 36)
                    .accessibilityHidden(true)
                VStack(alignment: .leading, spacing: 0) {
                    Text(day.title).font(.body).foregroundStyle(.primary)
                    Text(day.time).font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
                    if let note = day.note {
                        HStack(alignment: .firstTextBaseline, spacing: 8) {
                            Image(systemName: "note.text").foregroundStyle(.secondary)
                            Text(note).foregroundStyle(.primary).lineLimit(2)
                        }
                        .font(.subheadline)
                        .padding(.top, 4)
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("Note: " + note)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
            }
            .padding(.horizontal, WeekSpacing.card)
            .padding(.vertical, 15)
            .frame(minHeight: 72)
            .contentShape(Rectangle())
        }
        .buttonStyle(PageRowStyle())
        .accessibilityElement(children: .combine)
        .accessibilityHint("Opens the day")
        .accessibilityIdentifier("task-day-\(day.day.key)")
    }
}
