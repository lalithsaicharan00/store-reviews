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
                if entry.stepID == nil && habit.kind != .task {
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
            Text(clock(entry) + " · " + (entry.source?.label ?? "Source not recorded"))
                .font(.caption).foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
    }

    private func clock(_ entry: Entry) -> String {
        let c = store.recordingCalendar(for: entry)
        let text = entry.createdAt.formatted(Date.FormatStyle(date: .omitted, time: .shortened, calendar: c, timeZone: c.timeZone))
        return c.timeZone == store.calendar.timeZone ? text : text + " " + (c.timeZone.abbreviation(for: entry.createdAt) ?? entry.timeZone)
    }

    private func delete(_ entry: Entry) -> some View {
        Button("Delete", systemImage: "trash", role: .destructive) { store.undoEntry(entry.id) }
    }
}

/// Editing one entry replaces its value, never the day total. All controls are standard Form controls.
struct EntryEditView: View {
    let habit: Habit
    let entry: Entry
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var draft: ProgressValueDraft
    @State private var slipTime: Date
    @FocusState private var typing: Bool

    init(habit: Habit, entry: Entry) {
        self.habit = habit
        self.entry = entry
        _draft = State(initialValue: ProgressValueDraft(kind: habit.kind, value: entry.value))
        _slipTime = State(initialValue: entry.createdAt)
    }

    private var value: Double? { draft.value }

    private var validSlipTime: Bool {
        habit.kind != .quit || (store.recordingDay(at: slipTime, for: entry) == entry.day && slipTime <= .now
                               && slipTime >= min(habit.quitSince ?? habit.createdAt, habit.createdAt))
    }

    var body: some View {
        // Speed runs count how often the whole editor is drawn: once per letter typed would be the rule 11 mistake.
        let _ = perfTimed("Entry editor: whole editor drawn") { () }
        Form {
            Section {
                Text(habit.name).font(.headline)
                Text(entry.day.date(calendar: store.calendar).formatted(date: .complete, time: .omitted)).foregroundStyle(.secondary)
                LabeledContent("Source", value: entry.source?.label ?? "Source not recorded")
            }
            if habit.kind == .duration {
                DurationInput(hours: draft.binding(\.hours), minutes: draft.binding(\.minutes))
                Section {
                    LabeledContent("Seconds") {
                        DraftTextField(draft: draft, key: \.seconds, placeholder: "0", keyboard: .decimalPad).focused($typing)
                            .multilineTextAlignment(.trailing)
                            .accessibilityIdentifier("entry-seconds")
                    }
                }
            } else if habit.kind == .quit {
                let c = store.recordingCalendar(for: entry)
                let bounds = store.dayBounds(entry.day, calendar: c)
                let lower = max(bounds.lowerBound, min(habit.quitSince ?? habit.createdAt, habit.createdAt))
                Section {
                    DatePicker("Slipped at", selection: $slipTime, in: lower...max(lower, min(bounds.upperBound, .now)))
                        .environment(\.calendar, c).environment(\.timeZone, c.timeZone)
                    if c.timeZone != store.calendar.timeZone {
                        LabeledContent("Time zone", value: c.timeZone.localizedName(for: .generic, locale: .current) ?? entry.timeZone)
                    }
                }
            } else {
                Section {
                    LabeledContent(habit.kind == .check ? "Times" : "Amount") {
                        DraftTextField(draft: draft, key: \.amount, placeholder: "Amount", keyboard: habit.kind == .check ? .numberPad : .decimalPad)
                            .multilineTextAlignment(.trailing).focused($typing)
                            .accessibilityIdentifier("entry-amount")
                    }
                } footer: { Text("Change this entry only. Other entries stay as they are.") }
            }
            Section { Button("Delete Entry", role: .destructive) { typing = false; store.undoEntry(entry.id); dismiss() } }
        }
        .selectsNumbersOnFocus()
        .analyticsScreen(nil)
            .navigationTitle("Edit Entry")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    if let value { typing = false; store.editEntry(entry.id, value: value, at: habit.kind == .quit ? slipTime : nil); dismiss() }
                }.disabled(!draft.isValid || !validSlipTime)
            }
            ToolbarItemGroup(placement: .keyboard) { if typing { Spacer(); Button("Done") { typing = false } } }
        }
        #if DEBUG
        .task {
            // Open the real number keyboard before the profiling driver's typing window.
            if ProcessInfo.processInfo.arguments.contains("-perf-drive"), habit.kind != .duration && habit.kind != .quit { typing = true }
        }
        #endif
        .onPerfCommand { action in
            switch action {
            case .saveEntry: if let value { typing = false; store.editEntry(entry.id, value: value); dismiss() }
            default: break
            }
        }
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

/// Only the native fields read these strings. The Form reads the validation flag, which changes
/// only when input becomes valid/invalid; metadata and history do not rebuild for every character.
@Observable final class ProgressValueDraft {
    let kind: HabitKind
    var amount: String
    var hours: String
    var minutes: String
    var seconds: String
    var isValid: Bool

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
    }

    var value: Double? {
        if kind == .quit { return 1 }
        if kind == .duration {
            guard let h = GoalNumber.parse(hours, decimals: 0), let m = GoalNumber.parse(minutes, decimals: 0), m < 60,
                  let s = GoalNumber.parse(seconds), s < 60 else { return nil }
            let v = h * 60 + m + s / 60
            return v > 0 && v <= GoalNumber.maximum ? v : nil
        }
        guard let v = GoalNumber.parse(amount, decimals: kind == .check ? 0 : 2), v > 0 else { return nil }
        return v
    }

    func binding(_ key: ReferenceWritableKeyPath<ProgressValueDraft, String>) -> Binding<String> {
        Binding(get: { self[keyPath: key] }, set: { text in
            guard self[keyPath: key] != text else { return }
            self[keyPath: key] = text
            let valid = self.value != nil
            if valid != self.isValid { self.isValid = valid }
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
    func undoLabel(for habit: Habit) -> String {
        switch habit.kind {
        case .amount: return "Undo +" + description(for: habit)
        case .duration: return "Undo " + description(for: habit)
        default: return "Undo"
        }
    }
}
