import SwiftUI

/// What's on Completed Tasks: every task done on a day that has ended, one row per time it was done, newest first.
/// A one-time task done today stays at the end of the Tasks page's Today until the day ends (U38).
@MainActor enum CompletedTasks {
    struct Row: Identifiable, Equatable {
        let task: Habit
        let entry: Entry
        let line: String
        var id: UUID { entry.id }
    }

    static func rows(_ store: HabitStore) -> [Row] {
        let calendar = store.calendar
        let today = store.today()
        var rows: [Row] = []
        for task in store.habits where task.kind == .task && !task.archived {
            let entries = store.entries(of: task.id)
            if let due = task.dueDay {
                // A one-time task is done once: its last tick.
                guard let done = entries.last, done.day < today else { continue }
                var line = "Done " + DayWords.clock(done.createdAt, calendar: calendar)
                // Done on another day than planned: "· planned for Wed" within the week before, the date otherwise.
                if done.day != due {
                    let close = due < done.day && due.days(to: done.day, calendar: calendar) < 7
                    line += " · planned for " + (close ? due.date(calendar: calendar).formatted(.dateTime.weekday(.abbreviated))
                                                       : DayWords.dayMonth(due, calendar: calendar))
                }
                rows.append(Row(task: task, entry: done, line: line))
            } else {
                let rhythm = HabitCopy.rhythm(task.frequency, weekStart: store.settings.weekStart, short: true)
                for entry in entries where entry.day < today {
                    let line = "Done " + DayWords.clock(entry.createdAt, calendar: calendar) + (rhythm.isEmpty ? "" : " · " + rhythm)
                    rows.append(Row(task: task, entry: entry, line: line))
                }
            }
        }
        return rows.sorted { $0.entry.day != $1.entry.day ? $0.entry.day > $1.entry.day : $0.entry.createdAt > $1.entry.createdAt }
    }
}

/// Completed Tasks (Figma's Completed tasks page 1002:230, one shape with Archived Habits and Archived Tasks): ‹ and the
/// title, an intro line, one inset list per day it was done, newest first; each row the task's icon, name, "Done 9:12
/// AM" and a ⋯ More button (Mark as Not Done, then Delete in red). A row opens the task. Mark as Not Done puts it back
/// on its list with a Banner and Undo. The bar's ⋯ has Delete All Completed, which asks first (D9). Empty: a
/// `ContentUnavailableView` with no button.
struct CompletedTasksPage: View {
    @Environment(HabitStore.self) private var store
    @State private var rows: [CompletedTasks.Row] = []
    @State private var opened: Habit?
    @State private var deleting: Habit?
    @State private var deletingAll = false
    @State private var reopened: CompletedTasks.Row?
    @State private var bannerText: String?
    @State private var bannerTask: Task<Void, Never>?

    private struct Key: Equatable { let version: Int; let today: LocalDay }

    var body: some View {
        let key = Key(version: store.dataVersion, today: store.today())
        Group {
            if rows.isEmpty {
                ContentUnavailableView {
                    Label("Nothing Completed Yet", systemImage: "checkmark.circle")
                } description: {
                    Text("Tasks you tick off on Today come here when the day ends.")
                }
            } else {
                list
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Completed Tasks")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button("Delete All Completed", systemImage: "trash", role: .destructive) { deletingAll = true }
                } label: {
                    Label("More", systemImage: "ellipsis")
                }
                .disabled(!rows.contains { $0.task.dueDay != nil })
                .accessibilityIdentifier("completed-more")
            }
        }
        .overlay(alignment: .bottom) { banner }
        .onChange(of: key, initial: true) { rows = CompletedTasks.rows(store) }
        .navigationDestination(item: $opened) { HabitPageView(id: $0.id) }
        .alert("Delete \(deleting?.name ?? "")?", isPresented: Binding { deleting != nil } set: { if !$0 { deleting = nil } },
               presenting: deleting) { task in
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) { store.delete([task]) }
        } message: { task in
            Text(task.dueDay == nil
                 ? "It's a repeating task: it goes for good, with every time it was done and its notes. Its progress can't come back."
                 : "Its notes are deleted too, and this can't be undone.")
        }
        .alert(allTitle, isPresented: $deletingAll) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) { deleteAll() }
        } message: {
            Text("Done tasks that don't repeat are deleted with their notes, and this can't be undone. Repeating tasks keep going.")
        }
        .onDisappear { bannerTask?.cancel() }
    }

    private var oneTimeDone: [Habit] { rows.filter { $0.task.dueDay != nil }.map(\.task) }

    private var allTitle: String {
        let n = oneTimeDone.count
        return n == 1 ? "Delete 1 Completed Task?" : "Delete \(n) Completed Tasks?"
    }

    private var list: some View {
        let days = Dictionary(grouping: rows, by: \.entry.day)
        return List {
            Section {
            } header: {
                Text("Done tasks stay here, by the day they were done. Open one again with Mark as Not Done.")
                    .font(.body)
                    .foregroundStyle(Color(.secondaryLabel))
                    .textCase(nil)
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
            ForEach(days.keys.sorted(by: >), id: \.self) { day in
                Section {
                    ForEach(days[day] ?? []) { row($0) }
                } header: {
                    Text(DayWords.short(day, calendar: store.calendar))
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Color(.label))
                        .textCase(nil)
                }
            }
        }
        .listStyle(.insetGrouped)
        .contentMargins(.bottom, 80, for: .scrollContent)
    }

    private func row(_ row: CompletedTasks.Row) -> some View {
        HStack(spacing: 16) {
            Button { opened = row.task } label: {
                HStack(spacing: 16) {
                    HabitIcon(symbol: row.task.symbol, color: row.task.color, size: 32)
                    VStack(alignment: .leading, spacing: 0) {
                        Text(row.task.name).font(.body).foregroundStyle(.primary).lineLimit(1)
                        Text(row.line).font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(minHeight: 44)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityIdentifier("completed-" + row.task.name)
            Menu {
                Button("Mark as Not Done", systemImage: "arrow.uturn.backward.circle") { reopen(row) }
                Button("Delete", systemImage: "trash", role: .destructive) { deleting = row.task }
            } label: {
                Image(systemName: "ellipsis")
                    .font(.body)
                    .foregroundStyle(Color.ink)
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            .accessibilityLabel("More, \(row.task.name)")
            .accessibilityIdentifier("completed-more-" + row.task.name)
        }
        .padding(.vertical, 2)
        .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 4))
        .alignmentGuide(.listRowSeparatorLeading) { _ in 48 }
    }

    // MARK: Actions

    private func reopen(_ row: CompletedTasks.Row) {
        store.toggleCheck(row.task, on: row.entry.day)
        reopened = row
        show("\(row.task.name) is open again")
    }

    private func deleteAll() {
        let tasks = oneTimeDone
        store.delete(tasks)
        reopened = nil
        show(tasks.count == 1 ? "1 completed task deleted" : "\(tasks.count) completed tasks deleted")
    }

    private func show(_ text: String) {
        withAnimation { bannerText = text }
        bannerTask?.cancel()
        bannerTask = Task {
            try? await Task.sleep(for: .seconds(4))
            guard !Task.isCancelled else { return }
            hideBanner()
        }
    }

    private func hideBanner() {
        bannerTask?.cancel()
        withAnimation { bannerText = nil; reopened = nil }
    }

    /// "Send the parcel is open again · Undo"; after Delete All, only the words (a delete can't come back yet).
    @ViewBuilder private var banner: some View {
        if let bannerText {
            Banner(text: bannerText) {
                if let reopened {
                    Button("Undo") {
                        if let task = store.habits.first(where: { $0.id == reopened.task.id }) {
                            store.toggleCheck(task, on: reopened.entry.day)
                        }
                        hideBanner()
                    }
                    .accessibilityIdentifier("completed-undo")
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
            .transition(.opacity.combined(with: .move(edge: .bottom)))
        }
    }
}
