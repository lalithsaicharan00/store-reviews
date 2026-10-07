import SwiftUI
import Observation

// Notes: Add note, Note (view) and Edit note (7 October 2026 redesign, design decisions §7; Rulebook U19, U21). The
// same mental model as a log: adding is one job; a saved note opens to be read, with Delete note | Edit at the bottom;
// Edit switches to edit mode with Save. No habit card: one line under the one-line title, [icon] habit name at its start
// and the date at its end. The note itself fills the rest of the screen. A note has no time of its own: it belongs to
// its day. Optional, never prompted; saving an empty note removes it (report "Habit Notes and Day Notes", 29 Sep).

/// The typed note, read only by the text box (Rulebook S11). The screen reads only whether there's any text, set when
/// that changes.
@Observable final class NoteDraft {
    var text: String
    var hasText: Bool
    /// Set once, on the first change, and never cleared: the sheet then stops a swipe from throwing it away.
    var edited = false
    private(set) var opened: String

    init(_ text: String) {
        self.text = text
        opened = text
        hasText = !TextLimit.clean(text, TextLimit.noteText).isEmpty
    }

    /// Whether what's written differs from what the box opened with. Read on a tap, never while drawing.
    var differs: Bool { TextLimit.clean(text, TextLimit.noteText) != TextLimit.clean(opened, TextLimit.noteText) }

    /// Puts another day's note in the box (Add note, a day picked that already has one).
    func reset(_ text: String) {
        self.text = text
        opened = text
        let has = !TextLimit.clean(text, TextLimit.noteText).isEmpty
        if has != hasText { hasText = has }
    }

    func binding() -> Binding<String> {
        Binding(get: { self.text }, set: { new in
            guard new != self.text else { return }
            self.text = new
            let has = !TextLimit.clean(new, TextLimit.noteText).isEmpty
            if has != self.hasText { self.hasText = has }
            if !self.edited && self.differs { self.edited = true }
        })
    }
}

/// The note's text box, filling the room it's given and scrolling inside as the note grows (the top complaint about
/// note editors is room to write: report "Habit Notes and Day Notes"). Its own view, so typing redraws only this.
struct NoteTextBox: View {
    let draft: NoteDraft
    var focused: FocusState<Bool>.Binding

    var body: some View {
        let text = draft.binding()
        ZStack(alignment: .topLeading) {
            TextEditor(text: text)
                .focused(focused)
                .scrollContentBackground(.hidden)
                .limitText(text, to: TextLimit.noteText)
                .accessibilityLabel("Note")
                .accessibilityIdentifier("note-field")
            if draft.text.isEmpty {
                Text("Write a note")
                    .foregroundStyle(.tertiary)
                    .padding(.top, 8).padding(.leading, 5)
                    .allowsHitTesting(false)
                    .accessibilityHidden(true)
            }
        }
        .padding(.horizontal, 11).padding(.vertical, 8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(alignment: .bottomTrailing) {
            if let note = TextLimit.note(draft.text, TextLimit.noteText) {
                Text(note).formNote().padding(10)
            }
        }
    }
}

/// [icon] habit name at the start, the date at the end; one line. No habit for a note on the whole day.
struct NoteLine<Trailing: View>: View {
    let habit: Habit?
    @ViewBuilder let trailing: Trailing

    var body: some View {
        HStack(spacing: 8) {
            if let habit {
                HStack(spacing: 6) {
                    HabitIcon(symbol: habit.symbol, color: habit.color, size: 22)
                    Text(habit.name).font(.subheadline.weight(.semibold)).lineLimit(1).truncationMode(.tail)
                }
                .layoutPriority(0)
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Habit, \(habit.name)")
            }
            Spacer(minLength: 8)
            trailing.layoutPriority(1)
        }
        .frame(minHeight: 36)
    }
}

/// Add note: ✕ and the title; the habit and the day on one line (from Day details or Today, that day as plain text;
/// from the Notes tab, "Today" and a compact date picker); the box; Save above the keyboard, off until something is
/// written. A day that already has a note fills the box with it, and the line says so (U5).
struct AddNoteView: View {
    /// Nil for a note on the whole day (Today's "Note for the Day").
    let habit: Habit?
    /// From the Notes tab: the day can be chosen (any day from the habit's start to today).
    var picksDay = false
    var onSaved: (() -> Void)? = nil
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var day: LocalDay
    @State private var draft: NoteDraft
    @State private var confirmingDiscard = false
    @State private var asked = false
    @FocusState private var focused: Bool

    init(habit: Habit?, day: LocalDay, picksDay: Bool = false, onSaved: (() -> Void)? = nil) {
        self.habit = habit
        self.picksDay = picksDay
        self.onSaved = onSaved
        _day = State(initialValue: day)
        _draft = State(initialValue: NoteDraft(""))
    }

    private func saved(on day: LocalDay) -> String? {
        habit.map { store.note(of: $0, on: day) } ?? store.dayNote(on: day)
    }

    var body: some View {
        let c = store.calendar
        let today = store.today()
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                NoteLine(habit: habit) {
                    if picksDay, let habit {
                        let first = habit.kind == .quit ? store.quitStartDay(of: habit) : store.startDay(of: habit)
                        HStack(spacing: 8) {
                            if let word = DayWords.relative(day, today: today, calendar: c) { Text(word).foregroundStyle(.secondary) }
                            DatePicker("Date", selection: Binding(get: { day.date(calendar: c) }, set: { day = LocalDay($0, calendar: c) }),
                                       in: min(first, today).date(calendar: c)...today.date(calendar: c), displayedComponents: .date)
                                .labelsHidden()
                                .environment(\.calendar, c).environment(\.timeZone, c.timeZone)
                                .accessibilityIdentifier("note-date")
                        }
                    } else {
                        Text(DayWords.withDate(day, today: today, calendar: c))
                            .font(.subheadline.weight(.semibold)).foregroundStyle(.secondary)
                            .accessibilityIdentifier("note-day")
                    }
                }
                if !draft.opened.isEmpty {
                    Text("\(DayWords.short(day, calendar: c).replacingOccurrences(of: ",", with: "")) already has a note; you're changing it.")
                        .font(.footnote).foregroundStyle(.secondary)
                        .accessibilityIdentifier("note-existing")
                }
                NoteTextBox(draft: draft, focused: $focused)
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Add note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    RecordCancelButton { if draft.differs { confirmingDiscard = true } else { dismiss() } }
                }
            }
            .safeAreaInset(edge: .bottom) {
                RecordBottomBar {
                    DayButton("Save", prominent: true, id: "note-save") { save() }
                        .disabled(!draft.hasText)
                }
            }
            .alert("Discard this note?", isPresented: $confirmingDiscard) {
                Button("Keep Writing", role: .cancel) {}
                Button("Discard Changes", role: .destructive) { dismiss() }
            }
            .onAppear {
                guard !asked else { return }
                asked = true
                draft.reset(saved(on: day) ?? "")
            }
            // The keyboard comes up once the sheet has arrived: focus asked for while the sheet still slides in was
            // sometimes dropped (HabitPageUITests, 5 Oct 2026).
            .task {
                try? await Task.sleep(for: .milliseconds(350))
                focused = true
            }
            .onChange(of: day) {
                // Another day: its own note, if it has one, unless something new has been written already.
                guard !draft.differs else { return }
                draft.reset(saved(on: day) ?? "")
            }
            .onPerfCommand { action in if action == .closeLog { dismiss() } }
        }
        .analyticsScreen(nil)
        .presentationDetents([.large])
        .interactiveDismissDisabled(draft.edited)
        // Solid, like the calendar sheet: see-through, Today's rows showed through behind the text (29 Sep).
        .presentationBackground(Color(.systemGroupedBackground))
    }

    private func save() {
        focused = false
        if let habit { store.setNote(draft.text, of: habit, on: day) } else { store.setDayNote(draft.text, on: day) }
        onSaved?()
        dismiss()
    }
}

/// Note (view) and Edit note: one saved note, read first, changed with an explicit Edit (U19). The view: the habit and
/// the date on one line (from the Notes tab, "Sun, 4 Oct · 6 of 8 glasses ›", which opens that day's Day details: the
/// reader's "View Day", kept), the full text, and Delete note | Edit at the bottom. Edit note: the date only (a note's
/// day doesn't change), the box with the cursor at the end, Save always on; ✕ leaves edit mode, asking first if anything
/// changed. Saving an empty note removes it.
struct NoteView: View {
    /// Nil for a note on the whole day.
    let habit: Habit?
    let day: LocalDay
    /// From the Notes tab: the date line opens that day's Day details.
    var linksDay = false
    /// Opened straight into edit mode, as its own sheet (Today's "Edit Note"): ✕ and Save close it.
    var startsEditing = false
    var onSaved: (() -> Void)? = nil
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var editing = false
    @State private var draft = NoteDraft("")
    @State private var confirmingDelete = false
    @State private var confirmingDiscard = false
    @State private var showDay = false
    @State private var started = false
    @FocusState private var focused: Bool

    private var note: String? { habit.map { store.note(of: $0, on: day) } ?? store.dayNote(on: day) }

    var body: some View {
        let c = store.calendar
        let today = store.today()
        VStack(alignment: .leading, spacing: 8) {
            NoteLine(habit: habit) {
                if linksDay && !editing, let habit {
                    Button { showDay = true } label: {
                        HStack(spacing: 4) {
                            Text(DayWords.short(day, calendar: c)).fontWeight(.semibold).foregroundStyle(.primary)
                            Text("· " + DayStatus.make(habit, on: day, store: store).title).foregroundStyle(.secondary).lineLimit(1)
                            Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(.tertiary)
                        }
                        .font(.subheadline)
                    }
                    .buttonStyle(.plain)
                    .accessibilityHint("Opens that day's details")
                    .accessibilityIdentifier("note-view-day")
                } else {
                    Text(DayWords.withDate(day, today: today, calendar: c))
                        .font(.subheadline.weight(.semibold)).foregroundStyle(.secondary)
                        .accessibilityIdentifier("note-day")
                }
            }
            if editing {
                NoteTextBox(draft: draft, focused: $focused)
            } else if let note {
                ScrollView {
                    Text(note)
                        .font(.body)
                        .textSelection(.enabled)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(16)
                        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .accessibilityIdentifier("note-text")
                }
                .scrollBounceBehavior(.basedOnSize)
            } else {
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(.systemGroupedBackground))
        .analyticsScreen(nil)
        .toolbarRole(.editor)
        .navigationTitle(editing ? "Edit note" : "Note")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(editing || startsEditing)
        .toolbar {
            if editing || startsEditing {
                ToolbarItem(placement: .cancellationAction) {
                    RecordCancelButton {
                        focused = false
                        if editing && draft.differs { confirmingDiscard = true } else { leaveEditing() }
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            RecordBottomBar {
                if editing {
                    DayButton("Save", prominent: true, id: "note-save") { save() }
                } else {
                    RecordDeleteButton(title: "Delete note", id: "note-delete") { confirmingDelete = true }
                        .disabled(note == nil)
                    DayButton("Edit", prominent: true, id: "note-edit") { startEditing() }
                        .disabled(note == nil)
                }
            }
        }
        .alert("Delete this note?", isPresented: $confirmingDelete) {
            Button("Cancel", role: .cancel) {}
            Button("Delete Note", role: .destructive) {
                // Back first, then the note goes (as Delete log): removing it first took away the row that opened this
                // screen, and a second dismiss closed the sheet under it (CI, 7 Oct 2026).
                leave(writing: "")
            }
        } message: {
            Text("Only the note for \(DayWords.short(day, calendar: c).replacingOccurrences(of: ",", with: "")) is removed. That day's progress stays.")
        }
        .alert("Discard your changes to this note?", isPresented: $confirmingDiscard) {
            Button("Keep Editing", role: .cancel) {}
            Button("Discard Changes", role: .destructive) { leaveEditing() }
        }
        .sheet(isPresented: $showDay) { if let habit { DaySheet(habit: habit, day: day) } }
        .interactiveDismissDisabled(editing && draft.edited)
        .onAppear {
            guard !started else { return }
            started = true
            if startsEditing { startEditing() }
        }
        .onPerfCommand { action in
            switch action {
            case .editEntry: if !editing { startEditing() }
            case .closeLog: if startsEditing { dismiss() }
            default: break
            }
        }

    }

    private func startEditing() {
        draft = NoteDraft(note ?? "")
        editing = true
        // The cursor goes to the end of the text, with the keyboard up, once the switch has drawn.
        Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(startsEditing ? 350 : 50))
            focused = true
        }
    }

    private func leaveEditing() {
        focused = false
        if startsEditing { dismiss() } else { editing = false }
    }

    private func save() {
        focused = false
        let text = draft.text
        onSaved?()
        // An emptied note is removed: nothing left to view, so back first and then the write (as Delete note).
        if TextLimit.clean(text, TextLimit.noteText).isEmpty { leave(writing: text); return }
        write(text)
        if startsEditing { dismiss() } else { editing = false }
    }

    /// Leaves the screen, then writes once it has gone.
    private func leave(writing text: String) {
        dismiss()
        Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(450))
            write(text)
        }
    }

    private func write(_ text: String) {
        if let habit { store.setNote(text, of: habit, on: day) } else { store.setDayNote(text, on: day) }
    }
}

/// One habit's notes, newest first; tap one to read it (the long-press menu's "All Notes").
struct HabitNotesView: View {
    let habit: Habit
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                let notes = store.notes(of: habit)
                if notes.isEmpty {
                    ContentUnavailableView("No Notes", systemImage: "note.text",
                                           description: Text("Long-press the habit on any day and choose Add Note."))
                }
                ForEach(notes, id: \.day) { note in
                    NavigationLink {
                        NoteView(habit: habit, day: note.day, linksDay: true)
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(DayWords.day(note.day, today: store.today(), calendar: store.calendar))
                                .font(.subheadline.weight(.semibold)).foregroundStyle(.secondary)
                            Text(note.text).foregroundStyle(.primary).lineLimit(3)
                        }
                        .padding(.vertical, 2)
                    }
                }
            }
            .analyticsScreen(nil)
            .navigationTitle("\(habit.name) Notes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() } } }
        }
    }
}

extension LocalDay: Identifiable {
    nonisolated var id: String { key }
}
