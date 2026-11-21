import SafariServices
import SwiftUI
import UserNotifications

/// Settings (Figma 1173:547: Default, End of the list, Nothing set up; 21 Nov 2026). One inset-grouped `List` in four
/// sections, each a sentence-case header: **Backup** (Backup & Sync, saying what its page's card says), **Your day**
/// (Day Starts At, Week Starts On), **General** (Appearance, Haptics, Sound When Done, Notifications) and **About**
/// (Privacy Policy, Version). Figma's three variants are this one screen's states: End of the list is it scrolled, and
/// Nothing set up is Backup & Sync's *Not backed up yet* with Notifications *Off*.
///
/// Everything the old page listed that Figma doesn't (Progress, Times of Day, Reminders, Plus, Privacy & Security,
/// Help, About) is gone from it: routines are made from Create New and edited from the Habits tab, every feature is
/// free, and Help & Feedback is the menu's own place. It's a place the menu opens, so ☰ stands where Back would be.
struct SettingsPage: View {
    @Environment(HabitStore.self) private var store
    @Environment(MenuModel.self) private var menu
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.openURL) private var openURL
    @AppStorage(Preferences.theme) private var theme = Theme.automatic.rawValue
    @AppStorage(Preferences.haptics) private var haptics = true
    @AppStorage(Preferences.sound) private var sound = false
    @State private var notifications: UNAuthorizationStatus?
    @State private var showsPolicy = false

    var body: some View {
        List {
            Section("Backup") {
                NavigationLink { MenuPage(place: .backup) } label: { BackupRow() }
                    .accessibilityIdentifier("settings-backup")
            }

            Section("Your day") {
                NavigationLink { DayStartsAtPage() } label: {
                    SettingsRow(symbol: "moon.fill", title: "Day Starts At", value: DaySection.clock(store.settings.dayEndHour * 60))
                }
                .accessibilityIdentifier("settings-day-start")
                NavigationLink { WeekStartsOnPage() } label: {
                    SettingsRow(symbol: "calendar", title: "Week Starts On", value: WeekStartsOnPage.name(store.settings.weekStart))
                }
                .accessibilityIdentifier("settings-week-start")
            }

            Section("General") {
                NavigationLink { AppearancePage() } label: {
                    SettingsRow(symbol: "circle.lefthalf.filled", title: "Appearance", value: (Theme(rawValue: theme) ?? .automatic).title)
                }
                .accessibilityIdentifier("settings-appearance")
                // The whole row is the switch, as iOS's own Settings: tapping the words toggles it too.
                Toggle(isOn: $haptics) { SettingsRow(symbol: "iphone.radiowaves.left.and.right", title: "Haptics") }
                    .tint(.green)
                    .accessibilityIdentifier("settings-haptics")
                Toggle(isOn: $sound) { SettingsRow(symbol: "speaker.wave.2", title: "Sound When Done") }
                    .tint(.green)
                    .accessibilityIdentifier("settings-sound")
                    .onChange(of: sound) { if sound { TickFeedback.playChime() } }
                Button { Task { await openNotifications() } } label: {
                    SettingsRow(symbol: "bell.badge", title: "Notifications", value: notifications == .authorized
                                || notifications == .provisional || notifications == .ephemeral ? "On" : "Off", chevron: true)
                }
                .accessibilityIdentifier("settings-notifications")
            }

            Section("About") {
                Button { showsPolicy = true } label: {
                    SettingsRow(symbol: "hand.raised", title: "Privacy Policy", trailingSymbol: "arrow.up.right")
                }
                .accessibilityIdentifier("settings-privacy-policy")
                .accessibilityHint("Opens in Safari")
                SettingsRow(symbol: "info.circle", title: "Version", value: Self.version)
                    .accessibilityIdentifier("settings-version")
            }
        }
        .listStyle(.insetGrouped)
        // iOS puts its own room above a header, so 24 between sections in Figma is 8 here (measured on the Simulator).
        .listSectionSpacing(8)
        .contentMargins(.top, 8, for: .scrollContent)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Menu", systemImage: "line.3.horizontal") { menu.setOpen(true, reduceMotion: reduceMotion) }
                    .accessibilityIdentifier("settings-menu")
            }
        }
        // Full screen with ✕, as Figma's browser tab (1179:1158) and as Safari's view is meant to be shown.
        .fullScreenCover(isPresented: $showsPolicy) { SafariView(url: Self.privacyPolicy).ignoresSafeArea() }
        .onChange(of: theme) { Theme.apply(theme) }
        .onChange(of: haptics) { store.analyticsConfiguration() }
        .onChange(of: sound) { store.analyticsConfiguration() }
        // Coming back from iPhone Settings, the row says what's true now.
        .task(id: scenePhase) { if scenePhase == .active { await readNotifications() } }
    }

    /// The website's policy, always the current one (the same page as Android's).
    static let privacyPolicy = URL(string: "https://oftenenough.com/privacy")!

    /// "1.0 (1)": the version people see, then the build.
    static var version: String {
        let info = Bundle.main.infoDictionary
        let short = info?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = info?["CFBundleVersion"] as? String ?? "1"
        return "\(short) (\(build))"
    }

    private func readNotifications() async {
        notifications = await UNUserNotificationCenter.current().notificationSettings().authorizationStatus
    }

    /// Never asked: iOS's own question, here, because the person came for it. Asked before: the app's own
    /// Notifications page in iPhone Settings, the one place it can be changed (iOS has no way to ask twice).
    private func openNotifications() async {
        if notifications == .notDetermined {
            _ = try? await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
            await readNotifications()
        } else if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
            openURL(url)
        }
    }
}

/// A Settings row (Figma's List item there): the symbol in Secondary Label in a 24 column, 16 before the words; the
/// title, an optional line under it, and an optional value in Secondary Label at the trailing edge. A pushed row gets
/// iOS's own chevron from its `NavigationLink`; a row that leaves the app draws one (`chevron`) or its own symbol (↗).
/// The separator starts at the words, as in Figma.
struct SettingsRow: View {
    let symbol: String
    let title: String
    var line: String? = nil
    var value: String? = nil
    var chevron = false
    var trailingSymbol: String? = nil
    var tint: Color = .primary

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: symbol)
                .font(.title3)
                .foregroundStyle(tint == .primary ? Color(.secondaryLabel) : tint)
                .frame(width: 24)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 0) {
                Text(title).foregroundStyle(tint)
                if let line { Text(line).font(.subheadline).foregroundStyle(.secondary) }
            }
            .alignmentGuide(.listRowSeparatorLeading) { $0[.leading] }
            Spacer(minLength: 8)
            if let value { Text(value).foregroundStyle(.secondary).lineLimit(1) }
            if chevron || trailingSymbol != nil {
                Image(systemName: trailingSymbol ?? "chevron.forward")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Color(.tertiaryLabel))
                    .accessibilityHidden(true)
            }
        }
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
    }
}

/// Backup & Sync on Settings: the same state as its page's card, in a line (Figma: *iCloud · Today, 9:14 AM* with a
/// ticked cloud, or *Not backed up yet* with a crossed-out one). Its own view, so only it redraws as a backup runs.
private struct BackupRow: View {
    var body: some View {
        let backup = AppModel.shared.backup
        if let last = ICloudPage.lastBackedUp(backup: backup, cloud: AppModel.shared.cloud) {
            SettingsRow(symbol: "checkmark.icloud", title: "Backup & Sync", line: "iCloud · " + BackupWords.when(last))
        } else {
            SettingsRow(symbol: "icloud.slash", title: "Backup & Sync", line: backup?.working == true ? "Backing up…" : "Not backed up yet")
        }
    }
}

enum BackupWords {
    /// "Just now", "Today, 9:14 AM", "Yesterday, 9:40 PM", "18 Nov, 9:14 AM" (Figma's Backup & Sync row and card).
    static func when(_ date: Date) -> String {
        if Date.now.timeIntervalSince(date) < 120 { return "Just now" }
        let time = date.formatted(date: .omitted, time: .shortened)
        if Calendar.current.isDateInToday(date) { return "Today, " + time }
        if Calendar.current.isDateInYesterday(date) { return "Yesterday, " + time }
        return date.formatted(.dateTime.day().month(.abbreviated)) + ", " + time
    }

    /// The same moment in a sentence: "Just now", "Today at 9:14 AM", "18 Nov at 9:14 AM" (Backup & Sync's card).
    static func at(_ date: Date) -> String {
        if Date.now.timeIntervalSince(date) < 120 { return "Just now" }
        let time = date.formatted(date: .omitted, time: .shortened)
        if Calendar.current.isDateInToday(date) { return "Today at " + time }
        if Calendar.current.isDateInYesterday(date) { return "Yesterday at " + time }
        return date.formatted(.dateTime.day().month(.abbreviated)) + " at " + time
    }
}

/// Safari's own view (SFSafariViewController), for a web page that belongs to the app: its own bars, Done, share and
/// reader, nothing of ours (Figma's browser tab 1179:1158: ✕, the page's title over its address, share and ⋯).
struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safari = SFSafariViewController(url: url)
        safari.dismissButtonStyle = .close
        return safari
    }

    func updateUIViewController(_ controller: SFSafariViewController, context: Context) {}
}
