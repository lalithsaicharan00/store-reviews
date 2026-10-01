import SwiftUI

/// Pause a habit for a stretch of days (report "Pausing a Habit — What People Need", 29 Sep): until a date, which
/// brings it back on its own, or until it's turned back on. Any length, and the streak is kept. A quit habit pauses
/// now: its current run ends and is kept as a run, not a slip.
struct PauseSheet: View {
    /// One habit (its long-press menu), or several chosen in All Habits.
    let habits: [Habit]
    init(habit: Habit) { habits = [habit] }
    init(habits: [Habit]) { self.habits = habits }
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss

    enum Length: Hashable { case week, twoWeeks, date, open }
    @State private var length: Length = .week
    @State private var start = Date.now
    @State private var backOn = Date.now

    private var calendar: Calendar { store.calendar }
    private var today: LocalDay { store.today() }
    private var habit: Habit { habits[0] }
    /// Only quit habits: they pause now, so there's no start day to choose.
    private var isQuit: Bool { habits.allSatisfy { $0.kind == .quit } }
    private var from: LocalDay { isQuit ? today : LocalDay(start, calendar: calendar) }

    /// The day it comes back; nil when it waits to be turned back on.
    private var back: LocalDay? {
        switch length {
        case .week: from.adding(days: 7, calendar: calendar)
        case .twoWeeks: from.adding(days: 14, calendar: calendar)
        case .date: max(LocalDay(backOn, calendar: calendar), from.adding(days: 1, calendar: calendar))
        case .open: nil
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Pause Until") {
                    Picker("Pause until", selection: $length) {
                        choice("1 week", back: from.adding(days: 7, calendar: calendar)).tag(Length.week)
                        choice("2 weeks", back: from.adding(days: 14, calendar: calendar)).tag(Length.twoWeeks)
                        Text("Choose a Date").tag(Length.date)
                        Text("Until I Turn It Back On").tag(Length.open)
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                    if length == .date {
                        DatePicker("Back On", selection: $backOn,
                                   in: from.adding(days: 1, calendar: calendar).date(calendar: calendar)...,
                                   displayedComponents: .date)
                            .datePickerStyle(.graphical)
                    }
                }
                if !isQuit {
                    Section {
                        // Earlier days too: someone who was ill can pause after the fact; days already logged keep it.
                        DatePicker("Starts", selection: $start,
                                   in: habits.map { store.startDay(of: $0) }.min()!.date(calendar: calendar)...,
                                   displayedComponents: .date)
                    }
                }
                Section {} footer: {
                    Text(summary).font(.callout)
                }
            }
            .analyticsScreen(nil)
            .navigationTitle(habits.count == 1 ? "Pause \(habit.name.capped(HabitRow.nameShown))" : "Pause \(habits.count) Habits")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Pause") {
                        for habit in habits {
                            store.pause(habit, from: from, through: back?.adding(days: -1, calendar: calendar))
                        }
                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .accessibilityIdentifier("confirm-pause")
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationBackground(Color(.systemGroupedBackground))
        .onAppear { backOn = from.adding(days: 7, calendar: calendar).date(calendar: calendar) }
    }

    private func choice(_ label: String, back: LocalDay) -> some View {
        HStack {
            Text(label)
            Spacer()
            Text("Back " + Self.short(back, calendar: calendar)).foregroundStyle(.secondary)
        }
    }

    /// What will happen, said before Pause is tapped.
    private var summary: String {
        let name = habits.count == 1 ? habit.name : "\(habits.count) habits"
        if habits.count > 1 {
            let until = back.map { "until \(Self.short($0, calendar: calendar))" } ?? "until you turn them back on"
            var text = "\(name) leave Today \(until). Streaks stay, and reminders stop."
            if habits.contains(where: { $0.kind == .quit }) {
                text += " A quit habit's current run ends now and is kept; a new run starts when it's back."
            }
            return text
        }
        if isQuit {
            let comes = back.map { "when it comes back on \(Self.short($0, calendar: calendar))" } ?? "when you turn it back on"
            return "\(name)'s current run ends now and is kept as a run, not a slip. A new run starts \(comes)."
        }
        let until = back.map { "until \(Self.short($0, calendar: calendar))" } ?? "until you turn it back on"
        let when = from > today ? "From \(Self.short(from, calendar: calendar)), " : ""
        var text = "\(when)\(name) leaves Today \(until). Your streak stays, and reminders stop."
        if from < today { text += " Days from \(Self.short(from, calendar: calendar)) count as paused." }
        return text
    }

    /// "Mon 6 Oct".
    static func short(_ day: LocalDay, calendar: Calendar) -> String {
        day.date(calendar: calendar).formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated))
    }
}

/// Pause…, Resume or Cancel Pause, for a row's long-press menu.
struct PauseMenuItems: View {
    let habit: Habit
    @Binding var showPause: Bool
    @Environment(HabitStore.self) private var store

    var body: some View {
        let today = store.today()
        if let pause = store.pause(of: habit, on: today) {
            if pause.contains(today) {
                Button("Resume", systemImage: "play.circle") { store.resume(habit) }
            } else {
                Button("Cancel Pause from \(PauseSheet.short(pause.from, calendar: store.calendar))", systemImage: "xmark.circle") {
                    store.resume(habit)
                }
            }
        } else if store.canPause(habit) {
            Button("Pause…", systemImage: "pause.circle") { showPause = true }
        }
    }
}

/// A row in the Paused card: the habit, when it comes back, and Resume. It's never lost: the card sits at the
/// bottom of Today (users show paused habits hidden with no way back: "How do i enable them?").
struct PausedRow: View {
    let habit: Habit
    let day: LocalDay
    @Environment(HabitStore.self) private var store
    @State private var showEdit = false

    var body: some View {
        let today = store.today()
        let pause = store.pause(of: habit, on: day)
        let running = store.pause(of: habit, on: today)?.contains(today) == true
        HStack(alignment: .top, spacing: 12) {
            HabitIcon(symbol: habit.symbol, color: habit.color)
                .opacity(0.5)
                .frame(height: RowBand.height)
            VStack(alignment: .leading, spacing: 1) {
                Text(habit.name.capped(HabitRow.nameShown)).font(.body).foregroundStyle(.secondary).lineLimit(1)
                    .accessibilityLabel(habit.name)
                Text(detail(pause)).font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
            }
            .frame(minHeight: RowBand.height)
            Spacer(minLength: 8)
            if running {
                Button("Resume") { store.resume(habit) }
                    .buttonStyle(.bordered)
                    .tint(habit.color.color)
                    .frame(height: RowBand.height)
                    .accessibilityLabel("Resume \(habit.name)")
            }
        }
        .padding(.vertical, 2)
        .contextMenu {
            if running { Button("Resume", systemImage: "play.circle") { store.resume(habit) } }
            Button(habit.kind == .task ? "Edit Task" : "Edit Habit", systemImage: "pencil") { showEdit = true }
            if day <= today {
                Button(store.note(of: habit, on: day) == nil ? "Add Note" : "Edit Note", systemImage: "note.text") {
                    store.noteTarget = .init(habit: habit.id, day: day)
                }
            }
        }
        .sheet(isPresented: $showEdit) { EditHabitSheet(habit: habit) }
    }

    private func detail(_ pause: HabitPause?) -> String {
        guard let pause else { return "Paused" }
        guard let last = pause.through else { return "Paused until you turn it back on" }
        return "Back " + PauseSheet.short(last.adding(days: 1, calendar: store.calendar), calendar: store.calendar)
    }
}
