import SwiftUI
import UserNotifications

/// Saved reminder rules and iPhone permission recovery; never asks permission just for opening this page.
struct RemindersView: View {
    @Environment(HabitStore.self) private var store
    @Environment(ReminderScheduler.self) private var scheduler
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.openURL) private var openURL
    @State private var permission: UNAuthorizationStatus = .notDetermined
    @State private var loading = true
    @State private var editing: Habit?

    private var configured: [Habit] { store.habits.filter { $0.kind != .quit && $0.remind && !$0.reminders.isEmpty } }
    private var other: [Habit] { store.habits.filter { $0.kind != .quit && (!$0.remind || $0.reminders.isEmpty) && !$0.archived } }

    var body: some View {
        Form {
            Section {
                LabeledContent("Notifications", value: permissionText)
                    .accessibilityIdentifier("reminders-permission")
                if permission == .notDetermined {
                    Button("Allow Notifications") { Task { _ = await scheduler.requestPermission(); await refresh() } }
                        .accessibilityIdentifier("reminders-allow")
                } else if permission == .denied || permission == .provisional || permission == .ephemeral {
                    settingsButton
                }
                if ReminderScheduler.alarmsAvailable {
                    LabeledContent("Alarms", value: scheduler.alarmsAuthorized ? "Allowed" : scheduler.alarmsDenied() ? "Off in iPhone Settings" : "Not Allowed Yet")
                    if !scheduler.alarmsAuthorized {
                        if scheduler.alarmsDenied() { settingsButton }
                        else { Button("Allow Alarms") { Task { _ = await scheduler.requestAlarmPermission(); await refresh() } } }
                    }
                }
            } header: { Text("On This iPhone") } footer: {
                Text("Notifications respect silent mode, Focus and Scheduled Summary. An alarm is used only when you choose Alarm for that item and allow it on this iPhone.")
            }
            if let problem = scheduler.problem {
                Section {
                    Text(problem)
                    Button("Try Scheduling Again") { Task { await refresh() } }
                }
            }
            Section {
                if configured.isEmpty { Text("No reminders yet").foregroundStyle(.secondary) }
                ForEach(configured) { habit in reminderRow(habit) }
            } header: { Text("With Reminders") } footer: {
                Text("Only planned days are scheduled. Completing it stops that day’s reminders; paused and archived items stay saved without alerting you.")
            }
            if !other.isEmpty {
                Section {
                    ForEach(other) { habit in reminderRow(habit) }
                } header: { Text("Without Reminders") } footer: { Text("Tap an item to add a time or turn Remind Me on.") }
            }
            Section("Scheduled Ahead") {
                if let through = scheduler.scheduledThrough {
                    Text("Latest scheduled alert: \(through.formatted(date: .abbreviated, time: .shortened)).")
                        .accessibilityIdentifier("reminders-through")
                } else { Text(loading ? "Checking…" : "No upcoming alerts are scheduled.").foregroundStyle(.secondary) }
                Text("iPhone limits how many alerts an app can schedule. Often Enough schedules the nearest ones first. Some items may have fewer days scheduled when the limit is reached. Opening Often Enough refreshes the schedule. iOS decides when background refresh can run; open Often Enough periodically to extend the dates shown here.")
                    .foregroundStyle(.secondary)
                Text("If an alarm can’t be added, Often Enough tries a notification instead. With notification permission off, that fallback can’t alert you.")
                    .foregroundStyle(.secondary)
            }
        }
        .analyticsScreen(.reminders)
        .navigationTitle("Reminders").navigationBarTitleDisplayMode(.inline)
        .toolbar { if loading { ToolbarItem(placement: .topBarTrailing) { ProgressView() } } }
        .sheet(item: $editing, onDismiss: { Task { await refresh() } }) { EditHabitSheet(habit: $0) }
        .task { await refresh() }
        .onChange(of: scenePhase) { if scenePhase == .active { Task { await refresh() } } }
    }

    private var permissionText: String {
        switch permission {
        case .authorized: "Allowed"
        case .provisional: "Delivered Quietly"
        case .ephemeral: "Allowed Temporarily"
        case .denied: "Off in iPhone Settings"
        case .notDetermined: "Not Allowed Yet"
        @unknown default: "Check iPhone Settings"
        }
    }
    private var settingsButton: some View {
        Button("Open iPhone Settings") { if let url = URL(string: UIApplication.openSettingsURLString) { openURL(url) } }
    }
    private func reminderRow(_ habit: Habit) -> some View {
        Button { editing = habit } label: {
            HStack(spacing: 12) {
                HabitIcon(symbol: habit.symbol, color: habit.color)
                VStack(alignment: .leading, spacing: 3) {
                    Text(habit.name).foregroundStyle(.primary).lineLimit(1)
                    Text(detail(habit)).font(.subheadline).foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right").font(.footnote).foregroundStyle(.tertiary)
            }
        }.accessibilityIdentifier("reminder-item-" + habit.id.uuidString)
    }
    private func detail(_ habit: Habit) -> String {
        if habit.archived { return "Archived · reminders off" }
        if store.isPaused(habit, on: store.today()) { return "Paused · reminders off" }
        guard habit.remind && !habit.reminders.isEmpty else { return "Reminders off" }
        let times = habit.reminders.sorted { store.dayMinute($0.minuteOfDay) < store.dayMinute($1.minuteOfDay) }
            .map { DaySection.clock($0.minuteOfDay) }.joined(separator: ", ")
        var detail = times + (habit.alert == .alarm ? " · Alarm" : " · Notification")
        if let minutes = habit.followUpMinutes, !habit.atMost { detail += " · up to 3 more, every \(minutes) min" }
        return detail
    }
    private func refresh() async {
        loading = true
        permission = await scheduler.notificationStatus()
        let status: String
        switch permission {
        case .authorized, .provisional, .ephemeral: status = "authorized"
        case .denied: status = "denied"
        case .notDetermined: status = "not_determined"
        @unknown default: status = "unknown"
        }
        store.analyticsConfiguration(reminderPermission: status)
        await scheduler.reconcile(store)
        loading = false
    }
}
