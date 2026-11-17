import SwiftUI

/// Archived Habits and Archived Tasks (Figma's Archived habits page 988:7736 and Archived tasks page 1001:178, one shape,
/// 6 Nov 2026): ‹ and the title; an intro line saying what's kept; one inset list, newest first, each row the item's
/// filled icon in its colour, its name, "Archived 12 Oct" and a ⋯ More button (Restore, then Delete in red). A row opens
/// the item's page. Restore says so in a Banner with Undo; Delete asks first with Cancel and Delete only (D9). Empty: a
/// `ContentUnavailableView` with no button.
struct ArchivedPage: View {
    enum Kind: Hashable { case habits, tasks }
    let kind: Kind

    @Environment(HabitStore.self) private var store
    @State private var deleting: Habit?
    @State private var restoring: Habit?
    /// The last restore, for the banner's Undo.
    @State private var restored: Habit?
    @State private var bannerTask: Task<Void, Never>?
    /// The row tapped: its page, pushed by the list (a row's own NavigationLink would draw a › the design doesn't have).
    @State private var opened: Habit?

    private var items: [Habit] {
        let list = store.habits.filter { $0.archived && ($0.kind == .task) == (kind == .tasks) }
        // Newest first; one with no saved day (archived before days were kept) goes last.
        return list.enumerated().sorted { a, b in
            let x = store.archivedOn[a.element.id], y = store.archivedOn[b.element.id]
            switch (x, y) {
            case let (x?, y?) where x != y: return x > y
            case (.some, nil): return true
            case (nil, .some): return false
            default: return a.offset < b.offset
            }
        }.map(\.element)
    }

    private var noun: String { kind == .habits ? "Habits" : "Tasks" }

    var body: some View {
        let items = items
        Group {
            if items.isEmpty {
                ContentUnavailableView {
                    Label("No Archived \(noun)", systemImage: "shippingbox.fill")
                } description: {
                    Text(kind == .habits ? "When you archive a habit, it waits here with its history."
                                         : "When you archive a task, it waits here.")
                }
            } else {
                List {
                    Section {
                        ForEach(items) { row($0) }
                    } header: {
                        Text(kind == .habits ? "Archived habits keep everything they had. They’re off Today and send no reminders."
                                             : "Archived tasks keep everything they had. They’re off Today and send no reminders.")
                            .font(.body)
                            .foregroundStyle(Color(.secondaryLabel))
                            .textCase(nil)
                            .padding(.bottom, 8)
                            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                }
                .listStyle(.insetGrouped)
                .contentMargins(.bottom, 80, for: .scrollContent)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Archived \(noun)")
        .navigationBarTitleDisplayMode(.inline)
        .overlay(alignment: .bottom) { banner }
        .restoringPastTheLimit($restoring)
        .alert("Delete \(deleting?.name ?? "")?", isPresented: Binding { deleting != nil } set: { if !$0 { deleting = nil } },
               presenting: deleting) { item in
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                if restored?.id == item.id { hideBanner() }
                store.delete([item])
            }
        } message: { _ in
            Text(kind == .habits ? "Its history and notes are deleted too, and this can't be undone."
                                 : "This can't be undone.")
        }
        .navigationDestination(item: $opened) { HabitPageView(id: $0.id) }
        .onDisappear { bannerTask?.cancel() }
    }

    private func row(_ item: Habit) -> some View {
        HStack(spacing: 16) {
            Button { opened = item } label: {
                HStack(spacing: 16) {
                    HabitIcon(symbol: item.symbol, color: item.color, size: 32)
                    VStack(alignment: .leading, spacing: 0) {
                        Text(item.name).font(.body).foregroundStyle(.primary)
                        if let day = store.archivedOn[item.id] {
                            Text("Archived \(DayWords.dayMonth(day, calendar: store.calendar))")
                                .font(.subheadline).foregroundStyle(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(minHeight: 44)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityIdentifier("archived-" + item.name)
            Menu {
                Button("Restore", systemImage: "tray.and.arrow.up") { restore(item) }
                Button("Delete", systemImage: "trash", role: .destructive) { deleting = item }
            } label: {
                Image(systemName: "ellipsis")
                    .font(.body)
                    .foregroundStyle(Color.ink)
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            .accessibilityLabel("More, \(item.name)")
            .accessibilityIdentifier("archived-more-" + item.name)
        }
        .padding(.vertical, 2)
        .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 4))
        .alignmentGuide(.listRowSeparatorLeading) { _ in 48 }
    }

    // MARK: Restore and its banner

    private func restore(_ item: Habit) {
        guard store.restore(item) else { restoring = item; return }
        withAnimation { restored = item }
        bannerTask?.cancel()
        bannerTask = Task {
            try? await Task.sleep(for: .seconds(4))
            guard !Task.isCancelled else { return }
            hideBanner()
        }
    }

    private func hideBanner() {
        bannerTask?.cancel()
        withAnimation { restored = nil }
    }

    /// "Water plants restored · Undo": Undo archives it again, so it comes straight back here with everything it had.
    @ViewBuilder private var banner: some View {
        if let restored {
            Banner(text: "\(restored.name) restored") {
                Button("Undo") {
                    if let current = store.habits.first(where: { $0.id == restored.id }) { store.archive([current]) }
                    hideBanner()
                }
                .accessibilityIdentifier("archived-undo")
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
            .transition(.opacity.combined(with: .move(edge: .bottom)))
        }
    }
}
