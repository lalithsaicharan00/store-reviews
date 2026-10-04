import SwiftUI
import Observation

/// The same native entry rows in both sheets. Reads the indexed habit/day bucket, never all history.
struct DayEntriesSection: View {
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store

    var body: some View {
        let _ = perfTimed("Count: the Day sheet's entries drawn") { () }
        let entries = store.entries(of: habit.id, on: day)
        Section(day == store.today() ? "Today's Entries" : "Entries") {
            if entries.isEmpty {
                // "Yet" only while the day can still change; a past day with nothing says so plainly (research History D).
                Text(day < store.today() ? "No entries recorded" : "No entries yet").foregroundStyle(.secondary)
            }
            ForEach(entries.reversed()) { entry in
                if entry.opensEditor(for: habit) {
                    NavigationLink {
                        EntryEditView(habit: habit, entry: entry)
                    } label: { label(entry) }
                    .accessibilityIdentifier("entry-\(entry.id)")
                    .swipeActions { delete(entry) }
                } else {
                    label(entry)
                        .swipeActions { delete(entry) }
                }
            }
        }
    }

    private func label(_ entry: Entry) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(entry.description(for: habit)).foregroundStyle(.primary)
            Text(store.clockText(of: entry) + " · " + (entry.source?.label ?? "Source not recorded"))
                .font(.caption).foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
    }

    private func delete(_ entry: Entry) -> some View {
        Button("Delete", systemImage: "trash", role: .destructive) { store.undoEntry(entry.id) }
    }
}

/// Edit Log / Edit Slip: one saved record, corrected on its own (Rulebook U19; handoff "Editing One Habit Log").
/// The record's own fact comes first (an amount and its unit, a session's hours, minutes and seconds, a multi-check
/// record's count, a slip's time), the habit and the record's day and source as context, Save in the toolbar, and
/// Delete at the bottom, which asks first. Only this record changes: other logs, the note and a skip stay.
///
/// Native throughout (the user, 4 Oct 2026): the system back chevron with no title, Form rows and fields, a red-text
/// destructive row for Delete, as Apple's own Contacts and Calendar end an editor; a filled red button would make
/// the rare destructive action the loudest thing on the screen (Apple HIG, Buttons: use the destructive role for its
/// colour; reserve prominence for the likely action). A draft with changes asks before Back throws it away.
struct EntryEditView: View {
    let habit: Habit
    let entry: Entry
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var draft: ProgressValueDraft
    @State private var slipTime: Date
    @State private var confirmingDelete = false
    @State private var confirmingDiscard = false
    @FocusState private var focus: Field?
    private enum Field: Hashable { case amount, hours, minutes, seconds }

    init(habit: Habit, entry: Entry) {
        self.habit = habit
        self.entry = entry
        _draft = State(initialValue: ProgressValueDraft(kind: habit.kind, value: entry.value))
        _slipTime = State(initialValue: entry.createdAt)
    }

    private var value: Double? { draft.value }
    private var isSlip: Bool { habit.kind == .quit }
    private var noun: String { isSlip ? "slip" : "log" }
    /// Something was typed or picked: Back asks first. Changes once per editor (Rulebook S11).
    private var touched: Bool { draft.edited || slipTime != entry.createdAt }
    /// Whether there's really something to lose or save, worked out on a tap.
    private var changed: Bool { draft.differs || slipTime != entry.createdAt }

    private var validSlipTime: Bool {
        !isSlip || (store.recordingDay(at: slipTime, for: entry) == entry.day && slipTime <= .now
                   && slipTime >= min(habit.quitSince ?? habit.createdAt, habit.createdAt))
    }

    var body: some View {
        // Speed runs count how often the whole editor is drawn: once per letter typed would be the rule 11 mistake.
        let _ = perfTimed("Entry editor: whole editor drawn") { () }
        Form {
            Section {
                DayIdentityRow(habit: habit)
            } footer: {
                Text(contextLine)
            }
            valueSection
            Section {
                Button(role: .destructive) {
                    focus = nil
                    confirmingDelete = true
                } label: {
                    Text("Delete this \(noun)").frame(maxWidth: .infinity)
                }
                .accessibilityIdentifier("entry-delete")
            }
        }
        .selectsNumbersOnFocus()
        .scrollDismissesKeyboard(.interactively)
        .analyticsScreen(nil)
        .navigationTitle(isSlip ? "Edit Slip" : "Edit Log")
        .navigationBarTitleDisplayMode(.inline)
        // The back control is the chevron alone, as iOS draws it (the user, 4 Oct 2026).
        .toolbarRole(.editor)
        .navigationBarBackButtonHidden(touched)
        .interactiveDismissDisabled(touched)
        .toolbar {
            if touched {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back", systemImage: "chevron.backward") {
                        focus = nil
                        if changed { confirmingDiscard = true } else { dismiss() }
                    }
                        .accessibilityIdentifier("entry-back")
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") { save() }
                    .disabled(!draft.isValid || !validSlipTime)
                    .accessibilityIdentifier("entry-save")
            }
            ToolbarItemGroup(placement: .keyboard) {
                if let field = focus {
                    Spacer()
                    if field == .hours || field == .minutes {
                        Button("Next") { focus = field == .hours ? .minutes : .seconds }
                    } else {
                        Button("Done") { focus = nil }
                    }
                }
            }
        }
        .alert(isSlip ? "Delete this slip?" : "Delete this log?", isPresented: $confirmingDelete) {
            Button("Cancel", role: .cancel) {}
            Button(isSlip ? "Delete Slip" : "Delete Log", role: .destructive) {
                store.undoEntry(entry.id)
                dismiss()
            }
        } message: {
            Text(deleteMessage)
        }
        .confirmationDialog("Discard your changes to this \(noun)?", isPresented: $confirmingDiscard, titleVisibility: .visible) {
            Button("Discard Changes", role: .destructive) { dismiss() }
            Button("Keep Editing", role: .cancel) {}
        }
        #if DEBUG
        .task {
            // Open the real number keyboard before the profiling driver's typing window.
            if ProcessInfo.processInfo.arguments.contains("-perf-drive"), habit.kind != .duration && !isSlip { focus = .amount }
        }
        #endif
        .onPerfCommand { action in
            switch action {
            case .saveEntry: if let value { focus = nil; store.editEntry(entry.id, value: value); dismiss() }
            default: break
            }
        }
    }

    // MARK: The record's own fact

    @ViewBuilder private var valueSection: some View {
        switch habit.kind {
        case .duration:
            // Hours, minutes and seconds together: tap one to replace it (the keyboard stays closed until then), Next
            // moves on, fractional seconds are kept ("1.23 sec"). Each field is its own small view (Rulebook S11).
            Section {
                timeField("Hours", key: \.hours, field: .hours, keyboard: .numberPad, id: "entry-hours")
                timeField("Minutes", key: \.minutes, field: .minutes, keyboard: .numberPad, id: "entry-minutes")
                timeField("Seconds", key: \.seconds, field: .seconds, keyboard: .decimalPad, id: "entry-seconds")
            } header: {
                Text("Time in this session")
            } footer: {
                Text(draft.problem ?? "Tap a value to type. Only this session changes.")
            }
        case .quit:
            let c = store.recordingCalendar(for: entry)
            let bounds = store.dayBounds(entry.day, calendar: c)
            let lower = max(bounds.lowerBound, min(habit.quitSince ?? habit.createdAt, habit.createdAt))
            Section {
                // The day stays as recorded: moving a slip to another day needs the same record moved between days in
                // storage and sync at once, which doesn't exist yet (handoff; D7). A picker that couldn't save would lie.
                LabeledContent("Date", value: entry.day.date(calendar: store.calendar).formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated).year()))
                DatePicker("Time", selection: $slipTime, in: lower...max(lower, min(bounds.upperBound, .now)), displayedComponents: .hourAndMinute)
                    .environment(\.calendar, c).environment(\.timeZone, c.timeZone)
                    .accessibilityIdentifier("entry-slip-time")
                LabeledContent("Time zone", value: c.timeZone.localizedName(for: .generic, locale: .current) ?? entry.timeZone)
            } header: {
                Text("When it happened")
            } footer: {
                Text("Changing the time updates your quit run.")
            }
        default:
            let check = habit.kind == .check
            // The unit as this log's saved value reads it ("1 glass", "2 times"): set once, never per keystroke.
            let raw = check ? (habit.checkUnit ?? "times") : HabitCopy.unit(of: habit)
            let unit = raw.isEmpty ? "" : HabitCopy.unitWord(entry.value, raw)
            Section {
                LabeledContent(check ? "Checks in this log" : "Amount logged") {
                    HStack(spacing: 6) {
                        DraftTextField(draft: draft, key: \.amount, placeholder: "0", keyboard: check ? .numberPad : .decimalPad)
                            .multilineTextAlignment(.trailing)
                            .font(.body.monospacedDigit().weight(.semibold))
                            .focused($focus, equals: .amount)
                            .accessibilityLabel(unit.isEmpty ? "Amount" : "Amount, in \(unit)")
                            .accessibilityIdentifier("entry-amount")
                        if !unit.isEmpty { Text(unit).foregroundStyle(.secondary) }
                    }
                }
            } header: {
                Text("Correct this log")
            } footer: {
                Text(draft.problem ?? (check ? "Other checks for this day stay as they are." : "Only this log changes. Other logs stay as they are."))
            }
        }
    }

    private func timeField(_ title: String, key: ReferenceWritableKeyPath<ProgressValueDraft, String>, field: Field,
                           keyboard: UIKeyboardType, id: String) -> some View {
        LabeledContent(title) {
            DraftTextField(draft: draft, key: key, placeholder: "0", keyboard: keyboard)
                .multilineTextAlignment(.trailing)
                .font(.body.monospacedDigit().weight(.semibold))
                .focused($focus, equals: field)
                .accessibilityLabel(title)
                .accessibilityIdentifier(id)
        }
    }

    // MARK: Words

    /// "Sat, 4 Oct 2026 · Manual log": which record this is, never a control.
    private var contextLine: String {
        let day = entry.day.date(calendar: store.calendar).formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated).year())
        return day + " · " + (entry.source?.label ?? "Source not recorded")
    }

    /// Names the one record and its day, and says what stays (U19).
    private var deleteMessage: String {
        let day = PauseSheet.short(entry.day, calendar: store.calendar)
        if isSlip { return "The slip at \(store.clockText(of: entry)) on \(day) will be removed, and your quit run worked out again." }
        let what = entry.description(for: habit)
        return what + " will be removed from \(day). Other logs stay."
    }

    private func save() {
        focus = nil
        guard changed else { dismiss(); return }
        guard let value else { return }
        store.editEntry(entry.id, value: value, at: isSlip ? slipTime : nil)
        dismiss()
    }
}

/// One of a draft's text fields in its own view (2 Oct 2026). The binding is made, and the typed text read, here, so a
/// keystroke redraws this field, never the editor around it (PERFORMANCE.md rule 11). Modifiers put on it (focus,
/// alignment, accessibility) reach the field inside.
struct DraftTextField: View {
    let draft: ProgressValueDraft
    let key: ReferenceWritableKeyPath<ProgressValueDraft, String>
    let placeholder: String
    let keyboard: UIKeyboardType

    var body: some View {
        TextField(placeholder, text: draft.binding(key)).keyboardType(keyboard)
    }
}

/// Only the native fields read these strings. The Form reads the validation flag, the problem and whether anything
/// changed, each set only when it changes; metadata and history do not rebuild for every character.
@Observable final class ProgressValueDraft {
    let kind: HabitKind
    var amount: String
    var hours: String
    var minutes: String
    var seconds: String
    var isValid: Bool
    /// Why the text can't be saved, said near the field (never silently clamped or rounded); nil when it can, or
    /// while a field is simply empty.
    var problem: String?
    /// Set once, on the first keystroke that changes a field, and never cleared: an editor swaps in its asking Back
    /// button then. A flag that followed every keystroke back and forth redrew the editor and its navigation bar each
    /// time (Entry editor typing 26–40 ms/s against 1–11 before, CI 4 Oct 2026; Rulebook S11). `differs` says whether
    /// there's really anything to lose.
    var edited = false
    @ObservationIgnored private var opened: [String] = []

    init(kind: HabitKind, value: Double? = nil) {
        self.kind = kind
        amount = value.map(GoalNumber.text) ?? ""
        let totalSeconds = ((value ?? 0) * 6000).rounded() / 100
        let wholeMinutes = Int(totalSeconds / 60)
        hours = String(wholeMinutes / 60)
        minutes = String(wholeMinutes % 60)
        seconds = GoalNumber.text(totalSeconds - Double(wholeMinutes) * 60)
        isValid = false
        isValid = self.value != nil
        opened = [amount, hours, minutes, seconds]
    }

    var value: Double? { check().value }

    /// Whether any field differs from what the draft opened with. Read on a tap, never while drawing.
    var differs: Bool { [amount, hours, minutes, seconds] != opened }

    private func check() -> (value: Double?, problem: String?) {
        if kind == .quit { return (1, nil) }
        if kind == .duration {
            if [hours, minutes, seconds].contains(where: { $0.trimmingCharacters(in: .whitespaces).isEmpty }) { return (nil, nil) }
            guard let h = GoalNumber.parse(hours, decimals: 0) else { return (nil, "Hours are a whole number.") }
            guard let m = GoalNumber.parse(minutes, decimals: 0) else { return (nil, "Minutes are a whole number.") }
            guard m < 60 else { return (nil, "Minutes go up to 59.") }
            guard let s = GoalNumber.parse(seconds) else { return (nil, "Seconds take up to 2 decimal places.") }
            guard s < 60 else { return (nil, "Seconds go up to 59.99.") }
            let v = h * 60 + m + s / 60
            guard v > 0 else { return (nil, "A session is longer than zero.") }
            return v <= GoalNumber.maximum ? (v, nil) : (nil, "That's longer than a log can hold.")
        }
        if amount.trimmingCharacters(in: .whitespaces).isEmpty { return (nil, nil) }
        let whole = kind == .check
        guard let v = GoalNumber.parse(amount, decimals: whole ? 0 : 2) else {
            return (nil, whole ? "Checks are a whole number." : "Use a number with up to 2 decimal places.")
        }
        return v > 0 ? (v, nil) : (nil, "Enter more than zero.")
    }

    func binding(_ key: ReferenceWritableKeyPath<ProgressValueDraft, String>) -> Binding<String> {
        Binding(get: { self[keyPath: key] }, set: { text in
            guard self[keyPath: key] != text else { return }
            self[keyPath: key] = text
            let (value, problem) = self.check()
            let valid = value != nil
            if valid != self.isValid { self.isValid = valid }
            if problem != self.problem { self.problem = problem }
            if !self.edited && self.differs { self.edited = true }
        })
    }
}

extension Entry {
    func description(for habit: Habit) -> String {
        if let stepID { return habit.steps.first { $0.id == stepID }?.name ?? "Checklist step" }
        switch habit.kind {
        case .amount(let unit, _): return HabitCopy.amount(value, unit)
        case .duration: return value < 1 ? "\(HabitCopy.number(value * 60)) sec" : Format.minutes(value)
        case .quit: return "Slipped"
        case .check: return value == 1 ? "Check" : HabitCopy.amount(value, habit.checkUnit ?? "times")
        case .task: return "Done"
        case .checklist: return "Step checked"
        }
    }
    /// Says what Undo takes back, before it's tapped (the user, 3 Oct 2026; report "Today's Rows"): always this one
    /// entry, never the day. "Undo +1 glass", "Undo 20 min", "Undo +1", "Undo Done", "Undo Slip", "Undo Cleanser".
    func undoLabel(for habit: Habit) -> String {
        if let stepID { return "Undo " + (habit.steps.first { $0.id == stepID }?.name ?? "Step") }
        switch habit.kind {
        case .amount: return "Undo +" + description(for: habit)
        case .duration: return "Undo " + description(for: habit)
        case .check where habit.frequency.isDayBased && habit.goal > 1:
            return "Undo +" + (habit.checkUnit.map { HabitCopy.amount(value, $0) } ?? HabitCopy.number(value))
        case .check, .task: return "Undo Done"
        case .quit: return "Undo Slip"
        case .checklist: return "Undo"
        }
    }
}
