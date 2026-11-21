import SwiftUI

/// ≡ → Times of Day: Anytime plus the named parts of the user's day, in time order (Today reports 8, 16 and 25), with
/// the editor pushed on the same stack. On Today, times of day are arranged in Edit (`ArrangeDayView`), which opens the
/// same editor (`SectionEditor`).
struct TimesOfDayList: View {
    @Environment(HabitStore.self) private var store
    @State private var editing: DaySection?
    @State private var adding = false
    @State private var createdRoutine: CreatedRoutine?

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
            SectionEditor(existing: nil) { createdRoutine = $0 }
        }
        .routineCreatedBanner($createdRoutine)
    }

    private func timeRange(_ section: DaySection) -> String {
        guard !section.isAnytime else { return "No set time" }
        let end = store.timedSections.first { $0.section.id == section.id }?.end ?? 0
        return "\(DaySection.clock(section.start ?? 0))–\(DaySection.clock(end))"
    }
}

/// New Routine and Edit Routine (Figma's Edit routine, 830:265; New: 4761:33352 with a time, 4761:33668 without).
///
/// A `Form`, not Figma's stacked frames: the Name card, the Time card and Your day are its sections, so iOS draws the
/// cards, separators, switch and compact time picker, and Dynamic Type and VoiceOver come with them.
///
/// Only Starts is picked: a routine ends when the next one starts (the user, 10 Nov 2026, Android A122), so the page
/// asks `SectionPlan` with the next routine's start as the end. A start inside another routine makes that one end
/// there; the line under Starts says so before anything changes, and Undo on the "created" banner puts it back. That
/// line and the banner's Undo replace the old "Split …?" question.
///
/// Set a Time starts off, as in Figma (Calendar's All-day, Reminders' Time). A routine with no set time can't be saved
/// yet: the model still reads a section with no start as Anytime. Until the logic pass gives routines their own "no
/// time", Add waits for the switch (Create New checklist, "Left for the logic pass").
struct SectionEditor: View {
    let existing: DaySection?
    /// Called once it's saved: its ID and name, and the list as it was, for the banner's Undo.
    let onSaved: (CreatedRoutine) -> Void

    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var name: String
    @State private var hasTime: Bool
    @State private var start: Date
    @State private var confirmDelete = false
    @State private var newID = UUID().uuidString
    @FocusState private var nameFocused: Bool

    init(existing: DaySection?, onSaved: @escaping (CreatedRoutine) -> Void) {
        self.existing = existing
        self.onSaved = onSaved
        _name = State(initialValue: existing?.name ?? "")
        // Every saved routine has a time today; a new one starts without, as in Figma.
        _hasTime = State(initialValue: existing != nil)
        // A new one: the next whole hour.
        let hour = Calendar.current.component(.hour, from: .now)
        _start = State(initialValue: Self.date(existing?.start ?? ((hour + 1) % 24) * 60))
    }

    private static func date(_ minutes: Int) -> Date {
        Calendar.current.date(bySettingHour: (minutes / 60) % 24, minute: minutes % 60, second: 0, of: .now)!
    }

    private func minutes(_ date: Date) -> Int {
        let c = Calendar.current.dateComponents([.hour, .minute], from: date)
        return (c.hour ?? 0) * 60 + (c.minute ?? 0)
    }

    private var trimmed: String { TextLimit.clean(name, TextLimit.section) }
    private var dayEnd: Int { 24 * 60 + store.settings.dayEndHour * 60 }

    /// The whole day with this routine in it: it runs from Starts until the next routine starts, or to the day's end.
    private var plan: SectionPlan {
        let s = minutes(start)
        let others = store.timedSections.filter { $0.section.id != existing?.id }
        let end = others.compactMap(\.section.start).filter { $0 > s }.min()
            ?? others.last.map { max($0.end, s + 15) } ?? dayEnd
        let subject = DaySection(id: existing?.id ?? newID, name: trimmed.isEmpty ? "New Routine" : trimmed, start: nil, end: nil)
        return SectionPlan.make(sections: store.sections, subject: subject, start: s, end: end, defaultEnd: dayEnd)
    }

    var body: some View {
        let plan = plan
        Form {
            Section {
                TextField("Name", text: $name)
                    .focused($nameFocused)
                    .limitText($name, to: TextLimit.section)
                    .submitLabel(.done)
                    .accessibilityIdentifier("section-name-field")
            } footer: {
                if let note = TextLimit.note(name, TextLimit.section) { Text(note) }
            }
            Section {
                Toggle("Set a Time", isOn: $hasTime.animation())
                    .tint(.green)
                    .accessibilityIdentifier("section-set-time")
                if hasTime {
                    DatePicker("Starts", selection: $start, displayedComponents: .hourAndMinute)
                }
            } header: {
                FormHeader("Time")
            } footer: {
                Text(hasTime ? (plan.problem ?? endsText(plan)) : "Turn on to choose when this routine starts.")
            }
            if hasTime {
                Section {
                    ForEach(plan.rows) { row in
                        DayRow(row: row, isNew: existing == nil)
                    }
                } header: {
                    FormHeader("Your day")
                }
            }
            if existing != nil {
                Section {
                    Button("Delete Routine", role: .destructive) { confirmDelete = true }
                }
            }
        }
        .contentMargins(.top, 16, for: .scrollContent)
        .navigationTitle(existing == nil ? "New Routine" : "Edit Routine")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", systemImage: "xmark") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button(existing == nil ? "Add" : "Save") { save(plan) }
                    .fontWeight(.semibold)
                    .disabled(trimmed.isEmpty || !hasTime || plan.problem != nil)
                    .accessibilityIdentifier("section-save")
            }
        }
        .confirmationDialog("Delete \(existing?.name ?? "")?", isPresented: $confirmDelete, titleVisibility: .visible) {
            Button("Delete Routine", role: .destructive) {
                store.saveSections(store.sections.filter { $0.id != existing?.id })
                dismiss()
            }
        } message: {
            Text("Its habits move to Anytime. Nothing else changes.")
        }
        .task { if existing == nil { nameFocused = true } }
        .navigationBarBackButtonHidden()
    }

    /// "Ends at 6:00 AM, when Morning starts." and, for each routine this one cuts short, "Morning will now end at
    /// 7:00 AM." (Figma's footer; the user, 10 Nov 2026).
    private func endsText(_ plan: SectionPlan) -> String {
        guard let subject = plan.subject else { return "" }
        let next = plan.rows.first { $0.start == subject.end && !$0.isSubject }
        var text = "Ends at \(DaySection.clock(subject.end))" + (next.map { ", when \($0.name) starts." } ?? ", at the end of your day.")
        for row in plan.split {
            text += " \(row.name) will now \(row.oldStart == row.start ? "end at \(DaySection.clock(row.end))" : "start at \(DaySection.clock(row.start))")."
        }
        return text
    }

    private func save(_ plan: SectionPlan) {
        guard plan.problem == nil, !trimmed.isEmpty, hasTime else { return }
        let before = store.sections
        store.saveSections(plan.sections)
        onSaved(CreatedRoutine(id: existing?.id ?? newID, name: trimmed, before: before))
        dismiss()
    }
}

/// A section's header in Figma's forms: Subheadline Semibold in Secondary Label, sentence case ("Time", "Your day").
private struct FormHeader: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        // Secondary Label itself: the hierarchical `.secondary` dims again on top of the header's own grey.
        Text(text).font(.subheadline.weight(.semibold)).foregroundStyle(Color(.secondaryLabel)).textCase(nil)
    }
}

/// One routine in "Your day": its name, its times as they will be, and "New" on the one being added.
private struct DayRow: View {
    let row: SectionPlan.Row
    let isNew: Bool

    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                Text(row.name).lineLimit(1)
                Text("\(DaySection.clock(row.start)) – \(DaySection.clock(row.end))")
                    .font(.subheadline).foregroundStyle(.secondary).monospacedDigit()
            }
            Spacer(minLength: 8)
            if row.isSubject && isNew {
                Text("New").foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("plan-row-\(row.name)")
    }
}

/// A routine just made or saved, for the "“Meds” created · Undo" banner: Undo puts the whole list back as it was,
/// so any routine the new one cut short gets its times back too.
struct CreatedRoutine: Equatable, Identifiable {
    let id: String
    let name: String
    let before: [DaySection]
}

extension View {
    /// "“Meds” created · Undo", where the person is (the user, 10 Nov 2026: making a routine shows a banner and goes
    /// nowhere else). Each page New Routine opens from keeps the routine in its own state and attaches this, so the
    /// banner floats over whichever page the person comes back to, Figma's Banner at the bottom, gone after 4 seconds.
    func routineCreatedBanner(_ created: Binding<CreatedRoutine?>) -> some View {
        modifier(RoutineCreatedBanner(created: created))
    }
}

private struct RoutineCreatedBanner: ViewModifier {
    @Binding var created: CreatedRoutine?
    @Environment(HabitStore.self) private var store

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if let created {
                    Banner(text: "“\(created.name)” created") {
                        Button("Undo") {
                            store.saveSections(created.before)
                            withAnimation { self.created = nil }
                        }
                        .accessibilityIdentifier("routine-created-undo")
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
            }
            .animation(.default, value: created?.id)
            .task(id: created?.id) {
                guard created != nil else { return }
                try? await Task.sleep(for: .seconds(4))
                guard !Task.isCancelled else { return }
                withAnimation { created = nil }
            }
    }
}
