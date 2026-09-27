import SwiftUI

struct RoutineSession: Identifiable {
    let id = UUID()
    let part: String
    let day: LocalDay
    let habits: [Habit]
}

/// Uses the same entries and actions as Today; skipping never marks a habit done.
struct RoutinePlayer: View {
    let session: RoutineSession
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @State private var index = 0
    @State private var busy = false
    @State private var stepsOpen = true

    private var current: Habit? { session.habits.indices.contains(index) ? session.habits[index] : nil }
    private func done(_ habit: Habit) -> Bool {
        store.slots(of: habit).isEmpty ? store.isDone(habit, on: session.day)
            : store.isSlotDone(habit, slot: session.part, on: session.day)
    }

    var body: some View {
        NavigationStack {
            TimelineView(.periodic(from: .now, by: 1)) { context in
                if session.day != store.today(now: context.date) {
                    ContentUnavailableView("A new day has started", systemImage: "sunrise", description: Text("Close this routine and open today's habits to continue."))
                } else if let habit = current {
                    List {
                        Section {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Habit \(index + 1) of \(session.habits.count)").font(.subheadline).foregroundStyle(.secondary)
                                Text(habit.name).font(.title2.weight(.semibold)).fixedSize(horizontal: false, vertical: true)
                                if habit.kind == .duration {
                                    let seconds = max(0, Int((store.goal(of: habit) - store.progress(of: habit, on: session.day)) * 60))
                                    Text(String(format: "%02d:%02d", seconds / 60, seconds % 60))
                                        .font(.largeTitle.monospacedDigit()).accessibilityLabel("Time remaining")
                                }
                                ProgressView(value: Double(index), total: Double(session.habits.count)).tint(.ink)
                            }.padding(.vertical, 12)
                            HabitRow(habit: habit, day: session.day, isToday: true,
                                     slot: store.slots(of: habit).isEmpty ? nil : session.part, stepsOpen: $stepsOpen)
                            if habit.kind == .checklist && stepsOpen {
                                ForEach(habit.steps) { StepRow(step: $0, habit: habit, day: session.day) }
                            }
                        } footer: {
                            if index + 1 < session.habits.count { Text("Up next: \(session.habits[index + 1].name)") }
                        }
                        Section {
                            Button(index + 1 == session.habits.count ? "Finish routine" : "Next habit") { advance() }
                                .disabled(!done(habit) || busy)
                            Button("Skip for now") { advance() }.disabled(busy)
                        }
                    }
                    .disabled(busy)
                } else {
                    ContentUnavailableView {
                        Label("Routine finished", systemImage: "checkmark.circle")
                    } description: {
                        let remaining = session.habits.filter { !done($0) }.count
                        Text(remaining == 0 ? "All habits in this routine are done." : "\(remaining) left for later. Your progress is saved.")
                    } actions: {
                        Button("Done") { dismiss() }.buttonStyle(.borderedProminent).tint(.ink)
                    }
                }
            }
            .navigationTitle("\(store.section(session.part).name) routine")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ToolbarItem(placement: .cancellationAction) { Button("Close") { dismiss() }.disabled(busy) } }
        }
        .task(id: index) {
            guard session.day == store.today(), let habit = current, habit.kind == .duration,
                  !done(habit), store.timers[habit.id] == nil else { return }
            store.toggleTimer(habit)
            await store.flush()
        }
        .alert("Something went wrong", isPresented: Binding(get: { store.problem != nil }, set: { if !$0 { store.problem = nil } })) {
            Button("OK", role: .cancel) {}
        } message: { Text(store.problem ?? "") }
        .interactiveDismissDisabled(busy)
        .onDisappear {
            let leaving = current
            Task { @MainActor in
                await store.flush()
                if let leaving, store.timers[leaving.id] != nil {
                    store.toggleTimer(leaving)
                    await store.flush()
                }
            }
        }
    }

    private func pauseCurrent() {
        if let habit = current, store.timers[habit.id] != nil { store.toggleTimer(habit) }
    }

    private func advance() {
        guard !busy else { return }
        busy = true
        Task { @MainActor in
            await store.flush()
            pauseCurrent()
            await store.flush()
            guard store.problem == nil else { busy = false; return }
            index += 1
            stepsOpen = true
            busy = false
        }
    }
}
