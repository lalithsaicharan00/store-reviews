import SwiftUI

/// Search habits and tasks (Figma's Search page 991:8050, 6 Nov 2026), from either side of Habits & Tasks: iOS's own
/// search field, active from the start with the keyboard up, and its ✕ to leave. Results are habits first, then tasks,
/// each under a count ("4 habits") in one inset list, archived and done ones too; a row opens its page. No match: one
/// line and Add “yoga”, which opens Create New with the name filled in, so the person says what it is.
struct HabitsSearch: View {
    /// A habit or task made from Add “yoga”: the page behind scrolls to it.
    var onAdded: (UUID) -> Void = { _ in }
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var query = ""
    @State private var active = true
    @State private var path: [UUID] = []
    @State private var adding = false

    private var words: String { query.trimmingCharacters(in: .whitespacesAndNewlines) }

    var body: some View {
        NavigationStack(path: $path) {
            content
                .background(Color(.systemGroupedBackground))
                .navigationTitle("Search")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $query, isPresented: $active, placement: .navigationBarDrawer(displayMode: .always),
                            prompt: "Search habits and tasks")
                .navigationDestination(for: UUID.self) { HabitPageView(id: $0) }
        }
        // The field's ✕ ends the search, and the page with it; coming back from a habit's page keeps it open.
        .onChange(of: active) { _, isActive in
            if !isActive && path.isEmpty { dismiss() }
        }
        .onChange(of: path) { _, now in if now.isEmpty { active = true } }
        .sheet(isPresented: $adding) {
            NewItemView(name: words) { id in
                onAdded(id)
                dismiss()
            }
        }
    }

    @ViewBuilder private var content: some View {
        let words = words
        if words.isEmpty {
            Color(.systemGroupedBackground).ignoresSafeArea()
        } else {
            let found = store.habits.filter { $0.name.localizedStandardContains(words) }
            let habits = found.filter { $0.kind != .task }
            let tasks = found.filter { $0.kind == .task }
            if found.isEmpty {
                ContentUnavailableView {
                    Label("No Results for “\(words)”", systemImage: "magnifyingglass")
                } description: {
                    Text("Check the spelling, or add it as a new habit or task.")
                } actions: {
                    Button { adding = true } label: { Text("Add “\(words)”").foregroundStyle(Color.onInk) }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        .controlSize(.large)
                        .tint(.ink)
                        .accessibilityIdentifier("search-add")
                }
            } else {
                List {
                    section(habits, noun: "habit")
                    section(tasks, noun: "task")
                }
                .listStyle(.insetGrouped)
                .scrollDismissesKeyboard(.immediately)
            }
        }
    }

    @ViewBuilder private func section(_ items: [Habit], noun: String) -> some View {
        if !items.isEmpty {
            Section {
                ForEach(items) { item in
                    // A button that pushes, so the row has no › (Figma's List item).
                    Button { path.append(item.id) } label: { row(item).contentShape(Rectangle()) }
                        .buttonStyle(.plain)
                        .accessibilityIdentifier("search-" + item.name)
                }
            } header: {
                Text("\(items.count) \(noun)\(items.count == 1 ? "" : "s")")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.ink)
                    .textCase(nil)
            }
        }
    }

    private func row(_ item: Habit) -> some View {
        HStack(spacing: 16) {
            HabitIcon(symbol: item.symbol, color: item.color, size: 32)
            VStack(alignment: .leading, spacing: 0) {
                Text(item.name).font(.body).lineLimit(1)
                Text(detail(item)).font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
            }
        }
        .padding(.vertical, 2)
    }

    /// "Afternoon · 30 min a day", "Archived 12 Oct", or a task's plan.
    private func detail(_ item: Habit) -> String {
        if item.archived {
            return store.archivedOn[item.id].map { "Archived \(DayWords.dayMonth($0, calendar: store.calendar))" } ?? "Archived"
        }
        let summary = HabitPageView.summary(item, store: store)
        guard item.kind != .task, item.kind != .quit, let section = store.placements(of: item).first?.section else { return summary }
        return "\(store.section(section).name) · \(summary)"
    }
}
