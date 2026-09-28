import SwiftUI

/// "Day sections": Anytime plus the named parts of the user's day, in time order
/// (Today reports 8, 16 and 25). Reached from the end of Today, a section's long-press menu,
/// and "New Section…" in the habit form.
struct DaySectionsView: View {
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var editing: DaySection?
    @State private var adding = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(store.sections) { section in
                        Button {
                            if !section.isAnytime { editing = section }
                        } label: {
                            HStack {
                                Text(section.name).foregroundStyle(Color.primary).lineLimit(1)
                                Spacer(minLength: 16)
                                Text(timeRange(section)).foregroundStyle(.secondary).monospacedDigit().lineLimit(1).fixedSize()
                                if !section.isAnytime {
                                    Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
                                }
                            }
                        }
                        .disabled(section.isAnytime)
                    }
                    AddRow(title: "Add Time of Day") { adding = true }
                } footer: {
                    Text("Morning, Evening, or your own, like Before work. Each one ends when the next one starts.")
                }
            }
            .navigationTitle("Times of Day")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() } }
            }
            // Pushed, like the pages in the New flow.
            .navigationDestination(item: $editing) { section in
                SectionEditor(existing: section) { _ in }
            }
            .navigationDestination(isPresented: $adding) {
                SectionEditor(existing: nil) { _ in }
            }
        }
    }

    private func timeRange(_ section: DaySection) -> String {
        guard !section.isAnytime else { return "No set time" }
        let end = store.timedSections.first { $0.section.id == section.id }?.end ?? 0
        return "\(DaySection.clock(section.start ?? 0))–\(DaySection.clock(end))"
    }
}

/// Add or edit one section: a name and a start time; the latest section also has an end.
struct SectionEditor: View {
    let existing: DaySection?
    /// Called with the saved section's ID.
    let onSaved: (String) -> Void

    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var name: String
    @State private var start: Date
    @State private var end: Date
    @State private var confirmDelete = false
    @FocusState private var nameFocused: Bool

    init(existing: DaySection?, onSaved: @escaping (String) -> Void) {
        self.existing = existing
        self.onSaved = onSaved
        _name = State(initialValue: existing?.name ?? "")
        let startMinute = existing?.start ?? 7 * 60
        _start = State(initialValue: Self.date(startMinute))
        _end = State(initialValue: Self.date(existing?.end ?? 22 * 60))
    }

    private static func date(_ minutes: Int) -> Date {
        Calendar.current.date(bySettingHour: (minutes / 60) % 24, minute: minutes % 60, second: 0, of: .now)!
    }

    private func minutes(_ date: Date) -> Int {
        let c = Calendar.current.dateComponents([.hour, .minute], from: date)
        return (c.hour ?? 0) * 60 + (c.minute ?? 0)
    }

    private var others: [DaySection] { store.sections.filter { !$0.isAnytime && $0.id != existing?.id } }
    /// The latest section is the only one with its own end.
    private var isLatest: Bool { others.allSatisfy { ($0.start ?? 0) < minutes(start) } }
    private var trimmed: String { TextLimit.clean(name, TextLimit.section) }
    private var problem: String? {
        if trimmed.isEmpty { return nil }
        if others.contains(where: { $0.start == minutes(start) }) { return "Another time of day already starts at \(DaySection.clock(minutes(start)))." }
        if isLatest && minutes(end) <= minutes(start) && minutes(end) > store.settings.dayEndHour * 60 { return "It must end after it starts." }
        return nil
    }

    var body: some View {
            Form {
                Section {
                    TextField("e.g. Before work", text: $name)
                        .focused($nameFocused)
                        .limitText($name, to: TextLimit.section)
                        .submitLabel(.done)
                        .accessibilityLabel("Name")
                }
                Section {
                    DatePicker("Starts", selection: $start, displayedComponents: .hourAndMinute)
                    if isLatest {
                        DatePicker("Ends", selection: $end, displayedComponents: .hourAndMinute)
                    } else if let next = others.filter({ ($0.start ?? 0) > minutes(start) }).min(by: { $0.start! < $1.start! }) {
                        HStack(spacing: 16) {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Ends")
                                Text("When \(next.name) starts").font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
                            }
                            Spacer(minLength: 0)
                            Text(DaySection.clock(next.start!)).foregroundStyle(.secondary).fixedSize()
                        }
                        .accessibilityElement(children: .combine)
                    }
                } footer: {
                    if let problem { Text(problem).foregroundStyle(.red) }
                    else if let note = TextLimit.note(name, TextLimit.section) { Text(note) }
                    else { Text("Habits can still be ticked at any time; the time of day only orders Today and marks what's Now.") }
                }
                if existing != nil {
                    Section {
                        Button("Delete Time of Day", role: .destructive) { confirmDelete = true }
                    }
                }
            }
            .navigationTitle(existing == nil ? "New Time of Day" : "Edit Time of Day")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: save).fontWeight(.semibold).disabled(trimmed.isEmpty || problem != nil)
                }
            }
            .confirmationDialog("Delete \(existing?.name ?? "")?", isPresented: $confirmDelete, titleVisibility: .visible) {
                Button("Delete Time of Day", role: .destructive) {
                    store.saveSections(store.sections.filter { $0.id != existing?.id })
                    dismiss()
                }
            } message: {
                Text("Its habits move to Anytime. Nothing else changes.")
            }
            .task { if existing == nil { nameFocused = true } }
            .navigationBarBackButtonHidden()
    }

    private func save() {
        var section = existing ?? DaySection(id: UUID().uuidString, name: "", start: nil, end: nil)
        section.name = trimmed
        section.start = minutes(start)
        var endMinute = minutes(end)
        if endMinute <= minutes(start) { endMinute += 24 * 60 } // ends after midnight
        section.end = isLatest ? endMinute : nil
        store.saveSections(store.sections.filter { $0.id != section.id } + [section])
        onSaved(section.id)
        dismiss()
    }
}
