import SwiftUI

/// ≡ → Times of Day: Anytime plus the named parts of the user's day, in time order (Today reports 8, 16 and 25), with
/// the editor pushed on the same stack. On Today, times of day are arranged in Edit (`ArrangeDayView`), which opens the
/// same editor (`SectionEditor`).
struct TimesOfDayList: View {
    @Environment(HabitStore.self) private var store
    @State private var editing: DaySection?
    @State private var adding = false

    var body: some View {
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
        .analyticsScreen(.timesOfDay)
        .navigationTitle("Times of Day")
        .navigationBarTitleDisplayMode(.inline)
        // Pushed, like the pages in the New flow.
        .navigationDestination(item: $editing) { section in
            SectionEditor(existing: section) { _ in }
        }
        .navigationDestination(isPresented: $adding) {
            SectionEditor(existing: nil) { _ in }
        }
    }

    private func timeRange(_ section: DaySection) -> String {
        guard !section.isAnytime else { return "No set time" }
        let end = store.timedSections.first { $0.section.id == section.id }?.end ?? 0
        return "\(DaySection.clock(section.start ?? 0))–\(DaySection.clock(end))"
    }
}

/// Add or edit one time of day: a name, when it starts and when it ends. Times that overlap other times of day split
/// them (the user, 3 Oct 2026): the form shows how the whole day will look, and asks before splitting (`SectionPlan`).
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
    @State private var confirmSplit = false
    @State private var newID = UUID().uuidString
    @FocusState private var nameFocused: Bool

    init(existing: DaySection?, onSaved: @escaping (String) -> Void) {
        self.existing = existing
        self.onSaved = onSaved
        _name = State(initialValue: existing?.name ?? "")
        // A new one: the next whole hour, for two hours.
        let hour = Calendar.current.component(.hour, from: .now)
        let startMinute = existing?.start ?? ((hour + 1) % 24) * 60
        _start = State(initialValue: Self.date(startMinute))
        _end = State(initialValue: Self.date(existing.map { _ in startMinute + 60 } ?? startMinute + 120))
    }

    private static func date(_ minutes: Int) -> Date {
        Calendar.current.date(bySettingHour: (minutes / 60) % 24, minute: minutes % 60, second: 0, of: .now)!
    }

    private func minutes(_ date: Date) -> Int {
        let c = Calendar.current.dateComponents([.hour, .minute], from: date)
        return (c.hour ?? 0) * 60 + (c.minute ?? 0)
    }

    private var trimmed: String { TextLimit.clean(name, TextLimit.section) }
    private var plan: SectionPlan {
        let subject = DaySection(id: existing?.id ?? newID, name: trimmed.isEmpty ? "New time of day" : trimmed, start: nil, end: nil)
        return SectionPlan.make(sections: store.sections, subject: subject, start: minutes(start), end: minutes(end),
                                defaultEnd: 24 * 60 + store.settings.dayEndHour * 60)
    }

    var body: some View {
        let plan = plan
            Form {
                Section {
                    TextField("e.g. Before work", text: $name)
                        .focused($nameFocused)
                        .limitText($name, to: TextLimit.section)
                        .submitLabel(.done)
                        .accessibilityLabel("Name")
                        .accessibilityIdentifier("section-name-field")
                } footer: {
                    if let note = TextLimit.note(name, TextLimit.section) { Text(note) }
                }
                Section {
                    DatePicker("Starts", selection: $start, displayedComponents: .hourAndMinute)
                    DatePicker("Ends", selection: $end, displayedComponents: .hourAndMinute)
                } footer: {
                    if let problem = plan.problem { Text(problem).foregroundStyle(.red) }
                    else { Text("Habits can still be ticked at any time; the time of day only orders Today and marks what's Now.") }
                }
                Section {
                    ForEach(plan.rows) { row in
                        PlanRow(row: row)
                    }
                } header: {
                    Text("Your day")
                } footer: {
                    if !plan.split.isEmpty {
                        Text("Times of day that overlap are split, so each part of the day is in one only.")
                    }
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
                    Button(existing == nil ? "Add" : "Save") {
                        if plan.split.isEmpty { save(plan) } else { confirmSplit = true }
                    }
                    .fontWeight(.semibold)
                    .disabled(trimmed.isEmpty || plan.problem != nil)
                    .accessibilityIdentifier("section-save")
                }
            }
            // Before splitting: every time of day that changes, with its new times (the user, 3 Oct 2026).
            .confirmationDialog("Split \(HabitCopy.join(plan.split.map(\.name)))?", isPresented: $confirmSplit, titleVisibility: .visible) {
                Button(existing == nil ? "Split and Add \(trimmed)" : "Split and Save") { save(plan) }
                    .accessibilityIdentifier("section-split-confirm")
                Button("Cancel", role: .cancel) {}
            } message: {
                Text(plan.rows.filter { $0.isSubject || $0.changed }.map { "\($0.name): \($0.range)" }.joined(separator: "\n"))
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

    private func save(_ plan: SectionPlan) {
        guard plan.problem == nil, !trimmed.isEmpty else { return }
        store.saveSections(plan.sections)
        onSaved(existing?.id ?? newID)
        dismiss()
    }
}

/// One time of day in the form's "Your day": its new times, and what they were if they change.
private struct PlanRow: View {
    let row: SectionPlan.Row

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 1) {
                Text(row.name).fontWeight(row.isSubject ? .semibold : .regular).lineLimit(1)
                if row.isSubject {
                    Text(row.oldRange == nil ? "New" : row.changed ? "Was \(row.oldRange!)" : "No change")
                        .font(.footnote).foregroundStyle(.secondary)
                } else if row.changed, let old = row.oldRange {
                    Text("Was \(old)").font(.footnote).foregroundStyle(.secondary)
                }
            }
            Spacer(minLength: 8)
            Text(row.range).monospacedDigit().foregroundStyle(row.isSubject || row.changed ? Color.primary : .secondary)
                .lineLimit(1).fixedSize()
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("plan-row-\(row.name)")
    }
}
