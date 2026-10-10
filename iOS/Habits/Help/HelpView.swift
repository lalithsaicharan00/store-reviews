import SwiftUI
import UIKit

/// ≡ → Help & Feedback (Build Plan #71): a searchable How It Works, a way to write to us, and the welcome again.
/// Research: "Onboarding — The Name, What's Free, and a First Habit" §5 and "Settings — What People Need There"
/// (482 reviews say a missing help screen cost them; C075). Every answer names the exact place to tap, in the app's own
/// words. **When a way in changes, change its answer here too.**
struct HelpView: View {
    /// A topic opened and shown on arrival (a widget's Choose a habit: "Choose a habit for a widget").
    var open: String? = nil
    @State private var query = ""
    @State private var observedSearch = false
    @State private var showWelcome = false
    @State private var showAddress = false
    @Environment(\.openURL) private var openURL

    var body: some View {
        ScrollViewReader { proxy in
            list
                .task {
                    guard let open else { return }
                    try? await Task.sleep(for: .milliseconds(150))
                    withAnimation { proxy.scrollTo(open, anchor: .top) }
                }
        }
    }

    private var list: some View {
        List {
            if trimmedQuery.isEmpty {
                Section {
                    Button(action: contact) {
                        HelpRowLabel(title: "Contact Us", detail: Support.email, symbol: "envelope")
                    }
                    .accessibilityIdentifier("help-contact")
                    Button { Analytics.shared.count(.welcomeReplay, ticket: Analytics.shared.ticket); showWelcome = true } label: {
                        HelpRowLabel(title: "Show the Welcome Again", detail: "What's free, and what \(Onboarding.appName) can do", symbol: "hand.wave")
                    }
                    .accessibilityIdentifier("help-welcome")
                } footer: {
                    Text("We read every message. Tell us what happened and when; your habits are never sent with it.")
                }
                ForEach(HelpTopics.sections) { section in
                    Section(section.title) {
                        // Widgets: a problem publishing them, at the top, only while there is one, with Try again
                        // (it was on the Widgets page, spec §1).
                        if section.title == HelpTopics.widgets { WidgetProblemRows() }
                        ForEach(section.topics) { TopicRow(topic: $0, expanded: $0.question == open).id($0.question) }
                    }
                }
            } else {
                Section {
                    ForEach(matches) { TopicRow(topic: $0) }
                }
            }
        }
        .overlay {
            if !trimmedQuery.isEmpty && matches.isEmpty { ContentUnavailableView.search(text: trimmedQuery) }
        }
        .searchable(text: $query, prompt: "Search help")
        .onChange(of: query) {
            if !query.isEmpty && !observedSearch && Analytics.shared.consented {
                observedSearch = true
                Analytics.shared.count(.helpSearch, ticket: Analytics.shared.ticket)
            }
        }
        .navigationTitle("Help & Feedback")
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showWelcome) {
            OnboardingView(replay: true) { showWelcome = false }
        }
        .alert("Write to Us", isPresented: $showAddress) {
            Button("Copy Address") { UIPasteboard.general.string = Support.email }
            Button("OK", role: .cancel) {}
        } message: {
            Text("Email \(Support.email). Say what happened and when, and which iPhone you use.")
        }
    }

    private var trimmedQuery: String { query.trimmingCharacters(in: .whitespacesAndNewlines) }

    private var matches: [HelpTopic] {
        let q = trimmedQuery
        return HelpTopics.sections.flatMap(\.topics).filter {
            $0.question.localizedCaseInsensitiveContains(q) || $0.answer.localizedCaseInsensitiveContains(q)
        }
    }

    /// The phone's mail app with the versions filled in; with no mail app, the address to copy.
    private func contact() {
        Analytics.shared.count(.contactSupport, ticket: Analytics.shared.ticket)
        guard let url = Support.mailURL() else { showAddress = true; return }
        openURL(url) { opened in
            if !opened { showAddress = true }
        }
    }
}

/// Where people write to us, and what the email starts with: the app and iOS versions, never their habits.
enum Support {
    /// The shared support mailbox on our domain (Architecture 08, decided 28 Sep). Must exist before release (#72).
    static let email = "support@oftenenough.com"

    static var appVersion: String {
        let info = Bundle.main.infoDictionary
        let version = info?["CFBundleShortVersionString"] as? String ?? "?"
        let build = info?["CFBundleVersion"] as? String ?? "?"
        return "\(version) (\(build))"
    }

    @MainActor static func mailURL() -> URL? {
        var parts = URLComponents()
        parts.scheme = "mailto"
        parts.path = email
        parts.queryItems = [
            URLQueryItem(name: "subject", value: "\(Onboarding.appName) \(appVersion)"),
            URLQueryItem(name: "body", value: "\n\n\n—\n\(Onboarding.appName) \(appVersion) · \(UIDevice.current.model) · iOS \(UIDevice.current.systemVersion)"),
        ]
        return parts.url
    }
}

/// "Widget updates": widgets couldn't be updated, and Try again (spec §1; shown only while there's a problem).
private struct WidgetProblemRows: View {
    @Environment(HabitStore.self) private var store

    var body: some View {
        if let problem = AppModel.shared.widgets.problem {
            VStack(alignment: .leading, spacing: 4) {
                Text("Widget updates").font(.headline)
                Text(problem).foregroundStyle(.secondary)
            }
            .accessibilityElement(children: .combine)
            Button("Try again") { Task { await AppModel.shared.widgets.publish(store) } }
                .accessibilityIdentifier("help-widgets-try-again")
        }
    }
}

/// One question and its answer, opened in place.
private struct TopicRow: View {
    let topic: HelpTopic
    @State private var expanded: Bool

    init(topic: HelpTopic, expanded: Bool = false) {
        self.topic = topic
        _expanded = State(initialValue: expanded)
    }

    var body: some View {
        DisclosureGroup(isExpanded: $expanded) {
            Text(topic.answer)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical, 2)
        } label: {
            Text(topic.question).foregroundStyle(Color.primary)
        }
        .onChange(of: expanded) {
            if expanded { Analytics.shared.count(.faq, ticket: Analytics.shared.ticket) }
        }
        .accessibilityIdentifier("help-topic-" + topic.question)
    }
}

/// A row that does something: an icon, its name and one line.
private struct HelpRowLabel: View {
    let title: String
    let detail: String
    let symbol: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: symbol)
                .foregroundStyle(Color.ink)
                .frame(width: 26)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 2) {
                Text(title).foregroundStyle(Color.primary)
                Text(detail).font(.subheadline).foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
    }
}

struct HelpTopic: Identifiable {
    let question: String
    let answer: String
    var id: String { question }
}

struct HelpSection: Identifiable {
    let title: String
    let topics: [HelpTopic]
    var id: String { title }
}

/// The answers, grouped as people look for them. The questions are the ones reviews show people couldn't answer:
/// undo, filling in a day, deleting, skip or pause, how streaks and Progress count, a late night, where the data is.
enum HelpTopics {
    static let widgets = "Widgets"
    static let chooseHabitForWidget = "Choose a habit for a widget"

    static let sections: [HelpSection] = [
        HelpSection(title: "Logging", topics: [
            HelpTopic(question: "Log a habit",
                      answer: "Tap ✓ or + on its row. For an amount or a time, tap the row itself to type it. On a Time it row, ▶ starts a timer."),
            HelpTopic(question: "Undo a wrong tap",
                      answer: "Right after you log, Undo shows under the habit's name: tap it. A ✓ can also be tapped again. For amounts and times, touch and hold the row and choose Undo Last Entry."),
            HelpTopic(question: "Fill in a day I forgot",
                      answer: "Go back a day with ‹ in the bar at the bottom of Today, or tap the date there to pick one from the calendar. Then log as usual."),
            HelpTopic(question: "Change or delete what I logged",
                      answer: "Touch and hold the habit and choose Edit Today's Progress…. Everything logged that day is listed, and each entry can be changed or deleted."),
            HelpTopic(question: "Log without opening the app",
                      answer: "A reminder's notification has Done, or + for amounts. Siri and the Shortcuts app can log a habit, say what's left today, or tell you how a habit is going."),
        ]),
        HelpSection(title: "Habits", topics: [
            HelpTopic(question: "Edit a habit",
                      answer: "Touch and hold it on Today and choose Edit Habit. Changes apply from today; past days keep the goal they had."),
            HelpTopic(question: "Skip a day",
                      answer: "Touch and hold the habit, choose Edit Today's Progress…, then Skip today. A skipped day isn't a missed day: it never breaks a streak."),
            HelpTopic(question: "Pause a habit while I'm away or ill",
                      answer: "Touch and hold it and choose Pause… for a week, two weeks, until a date, or until you turn it back on. Paused habits wait in a Paused card at the bottom of Today, and their streak is kept. Skip is for one day; Pause is for a stretch of days."),
            HelpTopic(question: "Archive or delete a habit",
                      answer: "In ≡ › Habits, swipe a habit left. Archive keeps its history and frees its place on the free plan. Delete removes the habit and its history for good."),
            HelpTopic(question: "See a habit's history",
                      answer: "In ≡ › Habits, tap a habit for its page: its streak and best, a calendar of its days, its notes, and how it's gone over time."),
            HelpTopic(question: "Morning, Afternoon and Evening",
                      answer: "Each time of day is a card on Today. Pick one or more in a habit's Time of Day, or Anytime. Change them or add your own in ≡ › Times of Day."),
            HelpTopic(question: "Run a routine",
                      answer: "Tap ▶ Start on a time of day. Its habits open one at a time: move with ‹ ›, and use Habit options to skip or log by hand."),
            HelpTopic(question: "Groups",
                      answer: "Tap Filter beside + on Today and choose New Group. Filter then shows just that group's habits, and Progress can show one group too."),
            HelpTopic(question: "Add a note",
                      answer: "After you log, tap Add note under the habit. Or swipe the row left, or touch and hold it. A note for the whole day is at the bottom of Today."),
            HelpTopic(question: "Tasks",
                      answer: "In New, choose Add a task: something to get done once, or on repeat. Tasks have no streaks or stats, and they're always free. See them all in ≡ › Tasks."),
        ]),
        HelpSection(title: "Quitting and Cutting Down", topics: [
            HelpTopic(question: "Log a slip",
                      answer: "Touch and hold the quit habit and choose Log a Slip…. The clock starts again from then; your best run and your history are kept, and Undo is right there."),
            HelpTopic(question: "When a daily limit counts",
                      answer: "A Cut down limit is judged when the day ends, so it never shows as met in the morning before you've had the chance to go over it."),
        ]),
        HelpSection(title: "How Things Count", topics: [
            HelpTopic(question: "What the streak number means",
                      answer: "It counts your goal in a row. \"23\" is 23 days; \"4 wk\" is 4 weeks in a row at a weekly goal. Days that aren't the habit's days, and skipped or paused days, never break it."),
            HelpTopic(question: "Why a weekly habit shows done today",
                      answer: "A habit like 3 times a week counts as done for the day once you've logged it that day, and its row shows how many days so far this week."),
            HelpTopic(question: "How Progress counts",
                      answer: "≡ › Progress shows each week, month or year. Each planned day counts once; skipped, paused and archived days never count against you. How It's Counted on that page explains every number."),
            HelpTopic(question: "Count a good day below 100%",
                      answer: "In ≡ › Progress, open View Options and set Full Day to 80% Done or 60% Done."),
            HelpTopic(question: "Hide streaks",
                      answer: "In ≡ › Progress, open View Options and turn off Show Streaks. They're hidden on Today and on habit pages too."),
        ]),
        HelpSection(title: "Reminders", topics: [
            HelpTopic(question: "Set a reminder",
                      answer: "In a habit's form, turn on Remind Me and set the times. Remind Me With chooses a notification or, on iOS 26 and later, an alarm. If Not Done, Remind Again repeats it every 15, 30 or 60 minutes."),
            HelpTopic(question: "Notifications are off",
                      answer: "If you said no when the iPhone asked, ≡ › Reminders says so and has a button to open iPhone Settings, where you can allow them."),
        ]),
        HelpSection(title: "Settings", topics: [
            HelpTopic(question: "My day ends after midnight",
                      answer: "In ≡ › Day and Week, set New Day Starts At to a later hour, up to noon. What you log before then counts for the day before."),
            HelpTopic(question: "Change the first day of the week",
                      answer: "In ≡ › Day and Week, choose Week Starts On. Weekly goals and week streaks count in those weeks."),
            HelpTopic(question: "Dark mode, sound and vibration",
                      answer: "In ≡ › Appearance: Theme, Haptics and Sound When Done."),
        ]),
        // What the Widgets page explained (Current Work 58, spec §1 and §4): every answer names the exact button.
        HelpSection(title: widgets, topics: [
            HelpTopic(question: "Which widgets are there?",
                      answer: "One habit (small), Today (medium and large: your habits for today, or one time of day), This week (one habit, medium) and Tasks (medium and large). On the Lock Screen: one habit, Today, and a line above the clock."),
            HelpTopic(question: "What the buttons on a widget do",
                      answer: "✓ and + log right on the widget, and ▶ and ⏸ start and stop a timer, without opening the app. An amount you type, a slip, or a checklist's steps open their own screen in the app. Lists keep your order and show five (large) or two (medium) at a time: ‹ › show the rest."),
            HelpTopic(question: "Add a widget",
                      answer: "Home Screen: touch and hold an empty area, tap Edit, then Add Widget. Search for Often Enough, choose a size, and tap Add Widget. Lock Screen: touch and hold the Lock Screen, tap Customize, choose Lock Screen, then tap the widget area and choose Often Enough."),
            HelpTopic(question: chooseHabitForWidget,
                      answer: "Touch and hold the widget, tap Edit Widget, then tap Habit (or Section, for a list) and choose. Each widget keeps its own choice. While names are hidden outside the app, the choices show each habit's icon and its place in your order instead of its name."),
            HelpTopic(question: "A widget looks out of date",
                      answer: "Open the app: it updates every widget when it opens, and after you change your time zone. iPhone decides when widgets refresh, so a widget can take a moment to follow a change."),
        ]),
        HelpSection(title: "Privacy & Security", topics: [
            HelpTopic(question: "Lock the app",
                      answer: "In ≡ › Privacy & Security, tap App Lock and turn it on. Choose how the app opens day to day: Face ID, your iPhone passcode, or an app passcode. Then create a six-digit app passcode: it's the backup when Face ID or your iPhone passcode can't be used, or the only way in if you chose it. Lock Again sets how long it stays open after you leave it; locking your iPhone always locks it."),
            HelpTopic(question: "Use an app passcode instead of your iPhone passcode",
                      answer: "In ≡ › Privacy & Security › App Lock, under Open the App With, choose App Passcode. Only your app passcode opens the app then: Face ID and your iPhone passcode can't, so people who know your iPhone passcode can't get in."),
            HelpTopic(question: "Forgot your app passcode",
                      answer: "On the lock screen, tap Forgot App Passcode?. If the app opens with Face ID and Face ID still works, it lets you choose a new one straight away; if it opens with your iPhone passcode, your iPhone passcode does. Otherwise tap Start 24-Hour Reset: after 24 hours you choose a new one (with your iPhone passcode if the app opens with Face ID). Entering your app passcode before then cancels the reset. Your habits stay as they are."),
            HelpTopic(question: "\"Face ID was changed\"",
                      answer: "Whenever Face ID is changed on your iPhone, the app asks for your app passcode once, so no one else can get in with their face. Then it asks Did you change Face ID?: choose Yes, Use Face ID if you did; if not, choose No, Turn It Off and check Settings › Face ID & Passcode. You can turn Face ID back on later in ≡ › Privacy & Security › App Lock › Use Face ID Again."),
            HelpTopic(question: "Hide names outside the app",
                      answer: "In ≡ › Privacy & Security, turn on Hide Names Outside the App. Widgets, reminders, alarms, the timer on the Lock Screen and Siri then show icons and numbers without habit names, and ✓ and + still work. It's always on while App Lock is on. To make a reminder say something you'll recognise, add Reminder Says in the habit's Reminders."),
            HelpTopic(question: "Make a reminder say something else",
                      answer: "Edit the habit, tap Reminders, and type your words in Reminder Says. They're shown in its reminders, and instead of its name while names are hidden outside the app."),
            HelpTopic(question: "App Lock on a new iPhone",
                      answer: "App Lock and your app passcode stay on the iPhone they were set on. After moving to a new iPhone or restoring a backup, App Lock is off: turn it on again in ≡ › Privacy & Security › App Lock. Your Reminder Says words come with your habits."),
        ]),
        HelpSection(title: "Your Data", topics: [
            HelpTopic(question: "Where my habits are",
                      answer: "On this iPhone, and kept in one place at a time. Without an account, they're backed up to your iCloud as you go. Signed in, every change syncs to your account instead (an account is optional and free). ≡ › Backup & Export says where and when. Nothing else is sent anywhere unless you share it."),
            HelpTopic(question: "What a free account and Plus sync",
                      answer: "A free account syncs your habits on one device and brings them back when you sign in on a new device, with a copy of each of the last 7 days. Plus syncs across all your devices (iPhone, iPad, Apple Watch), with a copy of each day for 90 days."),
            HelpTopic(question: "Use another phone or tablet with a free account",
                      answer: "Sign in on it with the same account. The app asks first, then your account is used there and this iPhone is signed out. It keeps all its habits and goes back to backing them up to iCloud. With Plus, every device stays signed in."),
            HelpTopic(question: "Signed out on this iPhone",
                      answer: "Your free account was signed in on another phone or tablet, so it's used there now. This iPhone keeps all its habits and backs them up to iCloud. To use the account here again, sign in: anything you changed here meanwhile is added to it, and the other device is signed out."),
            HelpTopic(question: "Back up or move to a new phone",
                      answer: "On this iPhone go to ≡ › Backup & Export › Move to Another Device: it shows a code. On the new phone or tablet, install Often Enough, choose I've used it before, then Move from another device, and type the code. The two can be anywhere with an internet connection; keep this screen open until it says Done (a code works for an hour). Your habits are sealed with the code, so nobody else can read them on the way. Signed in? Sign in on the new one with the same account too. Or save a backup file (≡ › Backup & Export › Save a Backup File) and on the new one choose Restore a backup › Backup file. On a device that already has habits, you see what's coming before anything changes."),
            HelpTopic(question: "Before deleting the app",
                      answer: "With iCloud or an account, your habits stay: after reinstalling, choose I've used it before, then Restore a backup (or Sign in to your account). Nothing is backed up over them until you've chosen. With neither, save a backup file outside the app first. Offload App in iPhone Settings keeps everything."),
            HelpTopic(question: "Restore from a backup",
                      answer: "In ≡ › Backup & Export, choose Restore From a Backup and where it's stored: iCloud, your account (any of the last 7 days; with Plus, any day in the last 90) or a backup file. You see what's in it first. Restoring replaces the habits here (with Plus, on all your devices) and can be undone for 30 days with Undo Last Restore."),
            HelpTopic(question: "Sign in or create an account",
                      answer: "In ≡ › Account, choose Sign In if you've used an account before, or Create Account, then Apple or Google. Signing in never makes a new account without asking. Signed in, every change syncs to the account instead of being backed up to iCloud. A free account syncs one device; Plus syncs all of them."),
            HelpTopic(question: "Open my history in a spreadsheet",
                      answer: "In ≡ › Backup & Export, choose Export a Spreadsheet (CSV). Each row is a day's entry or note, with its date."),
            HelpTopic(question: "What's free, and what Plus adds",
                      answer: "Free: up to \(HabitStore.freeHabitLimit) habits with everything else included, and unlimited tasks. Archiving a habit frees its place. Plus is one payment, not a subscription: unlimited habits, iPad, Apple Watch and sync."),
        ]),
    ]
}
