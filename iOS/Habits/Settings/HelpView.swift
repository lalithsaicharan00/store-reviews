import SwiftUI

/// How it works: short answers, searchable (Feature Ledger C075: a searchable in-app help screen; users show "no
/// instructions" is a one-star reason on its own). Every answer names the exact place to tap, in the app's own words.
/// Keep these in step with the app: when a way in changes, change its answer here too.
struct HelpView: View {
    @State private var query = ""

    struct Topic: Identifiable {
        let id: String
        let answer: String
    }

    static let topics: [Topic] = [
        Topic(id: "Log a habit",
              answer: "Tap ✓ or + on its row. Tap the row itself to type an amount or a time. ▶ starts a timer right in the row."),
        Topic(id: "Tick habits from the Home Screen",
              answer: "Touch and hold the Home Screen, tap Edit, then Add Widget, and choose Habits. Tap ✓ or + on the widget to log without opening the app; it shows what's left first. The Lock Screen has one too."),
        Topic(id: "Log with Siri or Shortcuts",
              answer: "Say \"Log Water in Habits\", \"What's left in Habits\" or \"How's Water going in Habits\". In the Shortcuts app, Log a Habit can run from an automation, like tapping an NFC tag or arriving home, or from the Action button. It only ever adds; remove a wrong one on the habit's page."),
        Topic(id: "Undo a wrong tap",
              answer: "Tap Undo in the bar that appears at the bottom after you log. A tick can also be tapped again. For amounts and time, touch and hold the row, then Undo Last Entry."),
        Topic(id: "Fill in a day I forgot",
              answer: "On Today, go back with ‹ at the bottom, or tap the date for the calendar, and log as usual. Or touch and hold the habit, choose View Habit, and tap the day in its calendar."),
        Topic(id: "Change or delete what I logged",
              answer: "Touch and hold the habit, choose View Habit, and tap the day. Each thing logged that day is listed, with Delete."),
        Topic(id: "Skip a day",
              answer: "A skipped day isn't a missed day: it doesn't count for or against the streak. Skip from the habit's day on its page (View Habit, then tap the day), or from Habit options in a routine."),
        Topic(id: "Pause a habit while I'm away or ill",
              answer: "Touch and hold the habit and choose Pause… for a week, two weeks, until a date, or until you turn it back on. Paused habits wait in a folded Paused card at the bottom of Today, and the streak is kept."),
        Topic(id: "Edit a habit",
              answer: "Touch and hold it and choose Edit Habit. Changes apply from today; past days keep the goal they had."),
        Topic(id: "Add a note",
              answer: "After you log, tap Add note in the row. Or swipe the row left, or touch and hold it. A note for the whole day is at the bottom of Today."),
        Topic(id: "How streaks count",
              answer: "A streak counts the days, weeks or months in a row you met the goal: \"23\" is days, \"4 wk\" is weeks. Days that aren't the habit's days, and skipped or paused days, never break it, and today only counts once it's done. You can hide streaks in Settings."),
        Topic(id: "Milestones",
              answer: "When a tap reaches 7, 30, 100 or 365 in a row, or finishes the day, the bar under what you logged says so. Each habit's page lists every milestone it has reached and the next one. Turn them off in Settings → Milestones."),
        Topic(id: "How Progress counts",
              answer: "Each day a habit was planned counts once, and a weekly or monthly goal once for its week or month. Skipped and paused days don't count, and today counts once it's done. \"3 times a week\" done three times is 100%."),
        Topic(id: "My day ends after midnight",
              answer: "In Settings, set Day Ends At, from midnight to noon. Anything you log before then counts for the day before."),
        Topic(id: "Run a routine",
              answer: "Tap ▶ Start on a time of day. Its unfinished habits open one at a time; move with ‹ ›, and use Habit options to skip or log by hand."),
        Topic(id: "Archive or delete a habit",
              answer: "In All Habits (☑︎ on Today) swipe a habit, or open it. Archive stops it and keeps its history, and frees a place on the free plan. Delete removes it and its history for good."),
        Topic(id: "Turn off vibration or sound",
              answer: "In Settings, under When You Log, switch Haptics or Sounds. Sounds are off until you turn them on."),
        Topic(id: "Where my data is",
              answer: "On this iPhone only, and in its own iCloud or computer backups. There's no account and nothing is sent anywhere."),
        Topic(id: "Back up or move to a new phone",
              answer: "In Settings, under Your Data, Save a Backup File and keep it in Files or send it to yourself. On the new phone, Restore from a Backup File. Restoring only adds what's missing."),
        Topic(id: "Open my history in a spreadsheet",
              answer: "In Settings, under Your Data, Export a Spreadsheet (CSV). Each row is a day's entry or note, with its date."),
    ]

    private var shown: [Topic] {
        let q = query.trimmingCharacters(in: .whitespaces)
        guard !q.isEmpty else { return Self.topics }
        return Self.topics.filter { $0.id.localizedCaseInsensitiveContains(q) || $0.answer.localizedCaseInsensitiveContains(q) }
    }

    var body: some View {
        List {
            ForEach(shown) { topic in
                DisclosureGroup(topic.id) {
                    Text(topic.answer).foregroundStyle(.secondary).fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .overlay {
            if shown.isEmpty { ContentUnavailableView.search(text: query) }
        }
        .searchable(text: $query, prompt: "Search help")
        .navigationTitle("How It Works")
    }
}
