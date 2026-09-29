import SwiftUI
import UniformTypeIdentifiers
import UserNotifications

/// Settings, behind the avatar on Today (Build Plan #61; report "Settings — What People Need There", 29 Sep). A sheet,
/// as account and settings sheets are across iOS. Everything applies at once; nothing here changes a day already logged.
///
/// Only what people ask to control: when their day ends (night owls and night shifts, C170), the first day of the
/// week (C038), whether Today shows streaks (C157, C207), notifications turned off by mistake (C288), Times of Day
/// (C142: where people look), how things work (C075), the free plan's limit (C236), and what happens to their data (C085).
struct SettingsView: View {
    @Environment(HabitStore.self) private var store
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    @Environment(\.scenePhase) private var scenePhase
    @State private var draft = DaySettings()
    @State private var loaded = false
    @State private var notifications: UNAuthorizationStatus?
    @State private var showSections = false
    @State private var showPlus = false
    @State private var sharing: SharedFile?
    @State private var restoring = false
    @State private var working = false
    @State private var message: DataMessage?

    struct SharedFile: Identifiable { let id = UUID(); let url: URL }
    struct DataMessage: Identifiable { let id = UUID(); let title: String; let text: String }

    var body: some View {
        NavigationStack {
            Form {
                planSection
                Section {
                    Picker("Day Ends At", selection: $draft.dayEndHour) {
                        ForEach(0...12, id: \.self) { Text(Self.hour($0)).tag($0) }
                    }
                    .accessibilityIdentifier("settings-day-end")
                    Picker("Week Starts On", selection: $draft.weekStart) {
                        ForEach(1...7, id: \.self) { Text(Calendar.current.weekdaySymbols[$0 - 1]).tag($0) }
                    }
                    .accessibilityIdentifier("settings-week-start")
                    Button("Times of Day") { showSections = true }
                        .foregroundStyle(.primary)
                } header: {
                    Text("Your Day")
                } footer: {
                    Text(dayFooter)
                }
                Section {
                    Toggle("Show Streaks", isOn: $draft.showStreaks)
                        .accessibilityIdentifier("settings-streaks")
                } header: {
                    Text("Today")
                } footer: {
                    Text(draft.showStreaks
                         ? "The flame and number beside each habit."
                         : "Streaks are hidden on Today. They're still counted, and each habit's page shows them.")
                }
                Section {
                    Toggle("Haptics", isOn: $draft.haptics)
                        .accessibilityIdentifier("settings-haptics")
                    Toggle("Sounds", isOn: $draft.sounds)
                        .accessibilityIdentifier("settings-sounds")
                } header: {
                    Text("When You Log")
                } footer: {
                    Text("Haptics: a click each time you log, and a firmer one when a habit is done. Sounds: a short sound when a habit is done; it follows the silent switch and doesn't stop your music.")
                }
                notificationsSection
                dataSection
                Section("Help") {
                    NavigationLink("How It Works") { HelpView() }
                    if let email = AppInfo.supportEmail, let url = URL(string: "mailto:\(email)") {
                        Button("Contact Support") { openURL(url) }
                    }
                }
                Section {
                    Label("Your habits stay on this iPhone", systemImage: "lock.fill")
                } header: {
                    Text("Privacy")
                } footer: {
                    Text("No account, no ads and no tracking. Nothing leaves your phone unless you share it.")
                }
                Section {
                    LabeledContent("Version", value: AppInfo.version)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) { Button("Done") { dismiss() }.fontWeight(.semibold) }
            }
            .sheet(isPresented: $showSections) { DaySectionsView() }
            .sheet(isPresented: $showPlus) { PlusView() }
            .sheet(item: $sharing) { ShareSheet(url: $0.url).ignoresSafeArea() }
            .fileImporter(isPresented: $restoring, allowedContentTypes: [.item]) { result in
                guard case .success(let url) = result else { return }
                working = true
                Task { @MainActor in
                    defer { working = false }
                    do {
                        let added = try await store.restore(from: url)
                        message = added.habits + added.entries == 0
                            ? DataMessage(title: "Nothing New", text: "Everything in this backup is already on this iPhone.")
                            : DataMessage(title: "Restored",
                                          text: "Added \(added.habits == 1 ? "1 habit" : "\(added.habits) habits") and \(added.entries == 1 ? "1 logged entry" : "\(added.entries) logged entries"). Nothing already here was changed.")
                    } catch {
                        message = DataMessage(title: "Couldn't Restore", text: error.localizedDescription)
                    }
                }
            }
            .alert(item: $message) { Alert(title: Text($0.title), message: Text($0.text)) }
            .onAppear {
                draft = store.settings
                loaded = true
            }
            // Applies at once, as in iOS Settings; the store plans reminders again after the save.
            .onChange(of: draft) { if loaded && draft != store.settings { store.saveSettings(draft) } }
            .task(id: scenePhase) { notifications = await UNUserNotificationCenter.current().notificationSettings().authorizationStatus }
        }
    }

    // MARK: Sections

    private var planSection: some View {
        Section {
            if store.isPlus {
                LabeledContent("Plan", value: "Plus")
            } else {
                LabeledContent("Plan", value: "Free")
                LabeledContent("Habits", value: "\(store.activeHabitCount) of \(HabitStore.freeHabitLimit)")
                Button("Plus…") { showPlus = true }
            }
        } footer: {
            if !store.isPlus {
                Text("Free keeps \(HabitStore.freeHabitLimit) habits at a time. Archived habits don't count, and everything else is free.")
            }
        }
    }

    /// A person who said no to notifications at first has a way back (C288): what's wrong, and a button to fix it.
    @ViewBuilder private var notificationsSection: some View {
        Section {
            switch notifications ?? .notDetermined {
            case .denied:
                Label("Notifications are off for this app, so reminders can't reach you.", systemImage: "bell.slash")
                Button("Turn On in iPhone Settings") {
                    if let url = URL(string: UIApplication.openNotificationSettingsURLString) { openURL(url) }
                }
            case .authorized, .provisional, .ephemeral:
                LabeledContent("Notifications", value: "On")
            default:
                LabeledContent("Notifications", value: "Not asked yet")
            }
        } header: {
            Text("Notifications")
        } footer: {
            Text("Reminders are set on each habit, in New Habit or Edit Habit, and are off until you turn them on.")
        }
    }

    /// Your data (C020, C034, C176): it's in the phone's own backups; a spreadsheet to read; a file to keep or move;
    /// restoring that file only adds. All free, always.
    private var dataSection: some View {
        Section {
            Label("Included in your iPhone's backups", systemImage: "externaldrive.badge.checkmark")
            Button("Export a Spreadsheet (CSV)") {
                do { sharing = SharedFile(url: try DataExport.file(from: store)) } catch {
                    message = DataMessage(title: "Couldn't Export", text: error.localizedDescription)
                }
            }
            .accessibilityIdentifier("settings-export-csv")
            Button("Save a Backup File") {
                working = true
                Task { @MainActor in
                    defer { working = false }
                    do { sharing = SharedFile(url: try await store.backupFile()) } catch {
                        message = DataMessage(title: "Couldn't Make a Backup", text: error.localizedDescription)
                    }
                }
            }
            .accessibilityIdentifier("settings-backup")
            Button("Restore from a Backup File…") { restoring = true }
                .accessibilityIdentifier("settings-restore")
        } header: {
            HStack {
                Text("Your Data")
                if working { ProgressView().controlSize(.small) }
            }
        } footer: {
            Text("A backup file holds everything: habits, history, notes and settings. Save it to Files or send it to yourself. Restoring adds what's missing and never changes or removes what's on this iPhone.")
        }
        .disabled(working)
    }

    private var dayFooter: String {
        let end = draft.dayEndHour == 0
            ? "Your day ends at midnight."
            : "Anything logged before \(Self.hour(draft.dayEndHour)) counts for the day before, for night owls and night shifts."
        return end + " Weekly goals and streaks count from \(Calendar.current.weekdaySymbols[draft.weekStart - 1]). Days already logged keep their dates."
    }

    /// "Midnight", "1 AM" … "12 PM" in the phone's own clock (24-hour phones read "01:00").
    static func hour(_ h: Int) -> String {
        if h == 0 { return "Midnight" }
        let date = Calendar.current.date(bySettingHour: h, minute: 0, second: 0, of: .now) ?? .now
        return date.formatted(date: .omitted, time: .shortened)
    }
}

/// The app's name and version, and the support address (set before release; the row hides while it's nil).
enum AppInfo {
    static let supportEmail: String? = nil
    static var version: String {
        let info = Bundle.main.infoDictionary
        let short = (info?["CFBundleShortVersionString"] as? String) ?? "1.0"
        let build = (info?["CFBundleVersion"] as? String) ?? "1"
        return "\(short) (\(build))"
    }
}

/// The iOS share sheet for a file (Save to Files, AirDrop, Mail).
struct ShareSheet: UIViewControllerRepresentable {
    let url: URL
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: [url], applicationActivities: nil)
    }
    func updateUIViewController(_ controller: UIActivityViewController, context: Context) {}
}
