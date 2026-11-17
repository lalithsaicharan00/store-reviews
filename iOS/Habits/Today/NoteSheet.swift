import SwiftUI
import Observation
import UIKit

/// Brings a text field's keyboard up once its screen has arrived (Current Work 32's runs, 8–9 Oct 2026). Focus asked
/// for while a sheet still slides in is dropped, and SwiftUI can still report the field as focused, so neither one
/// request nor the focus state can be trusted: it asks again, focus off and on, until iOS says the keyboard is showing,
/// for up to about 6 s (a slow hosted simulator: runs 37841204161, 37889919376 never showed it). A person who puts the
/// keyboard away after it has come up isn't overruled.
@MainActor enum KeyboardArrival {
    /// How many times the keyboard has come up, so a keyboard shown once and put away stops the asking too.
    private(set) static var shown = 0
    /// Whether the keyboard is on screen now (it can already be up when a screen opens from a typing field).
    private(set) static var visible = false
    private static var watching = false

    /// Called at launch (`HabitsApp`), so it knows about a keyboard already up when a note screen opens.
    static func watch() {
        guard !watching else { return }
        watching = true
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { _ in
            MainActor.assumeIsolated { shown += 1; visible = true }
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) { _ in
            MainActor.assumeIsolated { visible = false }
        }
    }

    static func bringUp(_ focused: FocusState<Bool>.Binding, after first: Int = 350) async {
        watch()
        let before = shown
        for attempt in 0..<16 {
            try? await Task.sleep(for: .milliseconds(attempt == 0 ? first : 400))
            if Task.isCancelled || shown > before || (visible && focused.wrappedValue && attempt > 0) { return }
            if focused.wrappedValue {
                focused.wrappedValue = false
                try? await Task.sleep(for: .milliseconds(50))
                if Task.isCancelled { return }
            }
            focused.wrappedValue = true
        }
    }
}

// Notes: Add Note, Note (view) and Edit Note (Figma's Note screen, 17 Nov 2026). The same mental model as a log: adding
// is one job; a saved note opens to be read, with Edit in the bar and Delete Note under it; Edit switches to edit mode
// with Save. One row holds [icon] habit name and the day ("9 Nov"); the note itself fills the rest of the screen. A note has no time of its own: it belongs to
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
                Text("Note")
                    .foregroundStyle(.tertiary)
                    .padding(.top, 8).padding(.leading, 5)
                    .allowsHitTesting(false)
                    .accessibilityHidden(true)
            }
        }
        .padding(.horizontal, 11).padding(.vertical, 8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 26, style: .continuous))
        .overlay(alignment: .bottomTrailing) {
            if let note = TextLimit.note(draft.text, TextLimit.noteText) {
                Text(note).formNote().padding(10)
            }
        }
    }
}

/// [icon] habit name at the start, the date at the end: one row of an inset-grouped list, as Figma's Note screen draws
/// it. No habit for a note on the whole day.
struct NoteLine<Trailing: View>: View {
    let habit: Habit?
    @ViewBuilder let trailing: Trailing

    var body: some View {
        HStack(spacing: 8) {
            if let habit {
                Label {
                    Text(habit.name).lineLimit(1).truncationMode(.tail)
                } icon: {
                    HabitIcon(symbol: habit.symbol, color: habit.color, size: 24)
                }
                .labelStyle(NoteLineLabel())
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Habit, \(habit.name)")
            }
            Spacer(minLength: 8)
            trailing.layoutPriority(1)
        }
        .padding(.horizontal, 16)
        .frame(minHeight: 46)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 26, style: .continuous))
    }
}

/// The icon 12 from the name, as a list row's leading symbol.
private struct NoteLineLabel: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 12) { configuration.icon; configuration.title }
    }
}

/// A note's day: "9 Nov", plain Secondary Label.
private struct NoteDay: View {
    let day: LocalDay
    let calendar: Calendar
    var body: some View {
        Text(DayWords.dayMonth(day, calendar: calendar)).foregroundStyle(.secondary).accessibilityIdentifier("note-day")
    }
}

/// Add Note: ✕, the title and Add in the bar (Add off until something is written); the habit and the day in one row
/// (from Day details or Today, that day as plain text; from the Notes tab, a compact date picker); the box down to the
/// keyboard. A day that already has a note fills the box with it, and a line says so.
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
        NavigationStack { page }
            .analyticsScreen(nil)
            .presentationDetents([.large])
            .interactiveDismissDisabled(draft.edited)
            // Solid, like the calendar sheet: see-through, Today's rows showed through behind the text (29 Sep).
            .presentationBackground(Color(.systemGroupedBackground))
    }

    private var page: some View {
        let c = store.calendar
        let today = store.today()
        return VStack(alignment: .leading, spacing: 16) {
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
                        NoteDay(day: day, calendar: c)
                    }
                }
                if !draft.opened.isEmpty {
                    Text("\(DayWords.short(day, calendar: c).replacingOccurrences(of: ",", with: "")) already has a note; you're changing it.")
                        .font(.footnote).foregroundStyle(.secondary)
                        .padding(.horizontal, 16)
                        .accessibilityIdentifier("note-existing")
                }
                NoteTextBox(draft: draft, focused: $focused)
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .background(Color(.systemGroupedBackground))
            .padding(.bottom, 16)
            .navigationTitle("Add Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    RecordCancelButton { if draft.differs { confirmingDiscard = true } else { dismiss() } }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") { save() }
                        .disabled(!draft.hasText)
                        .accessibilityIdentifier("note-save")
                }
            }
            .alert("Discard this note?", isPresented: $confirmingDiscard) {
                Button("Keep Writing", role: .cancel) {}
                Button("Discard", role: .destructive) { dismiss() }
            } message: {
                Text("What you wrote won’t be saved.")
            }
            .onAppear {
                guard !asked else { return }
                asked = true
                draft.reset(saved(on: day) ?? "")
            }
            // The keyboard comes up once the sheet has arrived (`KeyboardArrival`): focus asked for while the sheet
            // still slides in was dropped, and on a slow device the keyboard never came at all.
            .task { await KeyboardArrival.bringUp($focused) }
            .onChange(of: day) {
                // Another day: its own note, if it has one, unless something new has been written already.
                guard !draft.differs else { return }
                draft.reset(saved(on: day) ?? "")
            }
            .onPerfCommand { action in if action == .closeLog { dismiss() } }
    }

    private func save() {
        focused = false
        if let habit { store.setNote(draft.text, of: habit, on: day) } else { store.setDayNote(draft.text, on: day) }
        onSaved?()
        dismiss()
    }
}

/// Note (view) and Edit Note: one saved note, read first, changed with Edit in the bar (U19). The view: the habit and
/// the day in one row (from the Notes tab, "Sun, 4 Oct · 6 of 8 glasses ›", which opens that day's Day details), the
/// text in its own card, and Delete Note, red, in a section of its own. Edit Note: ✕ and Save in the bar, the box with
/// the cursor at the end, Save always on; ✕ leaves edit mode, asking first if anything changed. Saving an empty note
/// removes it.
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
        VStack(alignment: .leading, spacing: 16) {
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
                    NoteDay(day: day, calendar: c)
                }
            }
            if editing {
                NoteTextBox(draft: draft, focused: $focused)
            } else if let note {
                ScrollView {
                    VStack(spacing: 16) {
                        Text(note)
                            .font(.body)
                            .textSelection(.enabled)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16).padding(.vertical, 14)
                            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 26, style: .continuous))
                            .accessibilityIdentifier("note-text")
                        Button(role: .destructive) { confirmingDelete = true } label: {
                            Text("Delete Note")
                                .foregroundStyle(.red)
                                .frame(maxWidth: .infinity, minHeight: 50, alignment: .leading)
                                .padding(.horizontal, 16)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 26, style: .continuous))
                        .accessibilityIdentifier("note-delete")
                    }
                }
                .scrollBounceBehavior(.basedOnSize)
            } else {
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .padding(.bottom, editing ? 16 : 0)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(.systemGroupedBackground))
        .analyticsScreen(nil)
        .backChevronOnly()
        .navigationTitle(editing ? "Edit Note" : "Note")
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
            if editing {
                // Always on (U19): saving an emptied note removes it.
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }.accessibilityIdentifier("note-save")
                }
            } else if !startsEditing {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit") { startEditing() }
                        .disabled(note == nil)
                        .accessibilityIdentifier("note-edit")
                }
            }
        }
        .alert("Delete this note?", isPresented: $confirmingDelete) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                // Back first, then the note goes (as Delete log): removing it first took away the row that opened this
                // screen, and a second dismiss closed the sheet under it (CI, 7 Oct 2026).
                leave(writing: "")
            }
        } message: {
            Text("Only the note for \(DayWords.dayMonth(day, calendar: c)) is removed. That day’s progress stays.")
        }
        .alert("Discard your changes to this note?", isPresented: $confirmingDiscard) {
            Button("Keep Editing", role: .cancel) {}
            Button("Discard", role: .destructive) { leaveEditing() }
        } message: {
            Text("The note stays as it was.")
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
        Task { @MainActor in await KeyboardArrival.bringUp($focused, after: startsEditing ? 350 : 50) }
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
