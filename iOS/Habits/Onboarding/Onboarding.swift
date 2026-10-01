import SwiftUI

/// The first launch (Build Plan #62): four short screens, each skippable, then Today. Research: "Onboarding — The Name,
/// What's Free, and a First Habit" (1 Oct 2026). Nothing here touches the network, asks for a permission or an
/// account, or saves anything the person didn't choose.
enum Onboarding {
    /// Set once the welcome is finished, skipped or left for a restore. Kept in UserDefaults: it's about this phone.
    static let doneKey = "onboarding.done"

    /// The app's name as people see it in the welcome and help. The home-screen name changes with the bundle ID on
    /// `claude/server-and-sync` (Architecture "App Identity"); these words already use it.
    static let appName = "Often Enough"

    /// Shown on a fresh install only: never over a storage problem (the error stays visible, C235), never to someone
    /// who already has habits (an update from an earlier build), and never in UI or speed tests unless asked for
    /// with `-onboarding`.
    static func shouldShow(_ store: HabitStore) -> Bool {
        let arguments = ProcessInfo.processInfo.arguments
        if arguments.contains("-onboarding") { return store.isLoaded }
        if arguments.contains("-uitest") || arguments.contains("-dbname") { return false }
        guard !UserDefaults.standard.bool(forKey: doneKey) else { return false }
        guard store.isLoaded, store.isStorageReady, store.problem == nil else { return false }
        guard store.habits.isEmpty else {
            markDone()
            return false
        }
        return true
    }

    static func markDone() {
        UserDefaults.standard.set(true, forKey: doneKey)
    }
}

/// One idea on the last welcome screen and in Start From an Idea. It only fills in the New Habit form: the name, how
/// it's tracked and how often. Nothing is saved until Add (C292), and amounts stay empty (Design Rules).
struct HabitIdea: Identifiable, Hashable {
    let name: String
    let type: ItemType
    let often: HowOften
    let symbol: String
    var id: String { name }

    /// One per common shape, so the list also shows what the app can do; "3 times a week" shows the name at work.
    static let all: [HabitIdea] = [
        HabitIdea(name: "Drink water", type: .amount, often: .everyDay, symbol: "drop.fill"),
        HabitIdea(name: "Exercise", type: .doIt, often: .times(.week, 3), symbol: "figure.run"),
        HabitIdea(name: "Read", type: .time, often: .everyDay, symbol: "book.fill"),
        HabitIdea(name: "Meditate", type: .time, often: .everyDay, symbol: "brain.head.profile"),
        HabitIdea(name: "Walk", type: .amount, often: .everyDay, symbol: "figure.walk"),
        HabitIdea(name: "Go to bed on time", type: .doIt, often: .everyDay, symbol: "bed.double.fill"),
        HabitIdea(name: "Stop smoking", type: .quit, often: .everyDay, symbol: "nosign"),
        HabitIdea(name: "Less coffee", type: .cutBack, often: .everyDay, symbol: "cup.and.saucer.fill"),
    ]

    /// "Check it off · 3 times a week": how it's tracked, then how often, in the form's own words.
    var line: String {
        switch type {
        case .quit: return "Quit · counts the time since you stopped"
        case .cutBack: return "Cut down · a limit each day"
        default: return type.title + " · " + often.phrase(hasAmount: type == .amount || type == .time, weekStart: 2)
        }
    }
}

/// The welcome. `replay` (Help → Show the Welcome Again) shows only the name and what's free, then Done.
struct OnboardingView: View {
    var replay = false
    /// Called once, however it ends: finished, skipped, a habit added, or Restore chosen (`restore` true).
    var onFinish: (_ restore: Bool) -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var page = 0
    @State private var forward = true
    @State private var showNew = false
    @State private var addedFromNew = false

    private var pageCount: Int { replay ? 2 : 4 }
    private var isLast: Bool { page == pageCount - 1 }

    var body: some View {
        NavigationStack {
            ZStack {
                switch page {
                case 0: NamePage().transition(slide)
                case 1: FreePage().transition(slide)
                case 2: DaysPage().transition(slide)
                default: IdeasPage(ownRow: false, onSomethingElse: { showNew = true }).transition(slide)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGroupedBackground))
            .safeAreaInset(edge: .bottom, spacing: 0) { bottomBar }
            .toolbar {
                if page > 0 {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Back") { move(to: page - 1) }
                            .accessibilityIdentifier("onboarding-back")
                    }
                }
                if !replay && !isLast {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Skip") { finish() }
                            .accessibilityIdentifier("onboarding-skip")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: HabitIdea.self) { idea in
                IdeaForm(idea: idea) { _ in finish() }
            }
        }
        // New closes itself after Add; the welcome ends once it has gone, never while it's still closing.
        .sheet(isPresented: $showNew, onDismiss: { if addedFromNew { finish() } }) {
            NewItemView { _ in addedFromNew = true }
        }
        .interactiveDismissDisabled()
    }

    /// Continue (or Done), the one secondary action for the page, and where the person is: "1 of 4".
    private var bottomBar: some View {
        VStack(spacing: 12) {
            if !isLast || replay {
                Button {
                    if isLast { finish() } else { move(to: page + 1) }
                } label: {
                    Text(isLast ? "Done" : "Continue")
                        .font(.headline)
                        .foregroundStyle(Color.onInk)
                        .frame(maxWidth: .infinity, minHeight: 50)
                }
                .buttonStyle(.borderedProminent)
                .tint(.ink)
                .accessibilityIdentifier("onboarding-continue")
            }
            if page == 0 && !replay {
                // For someone coming back: their history first, nothing to set up (First Run report).
                Button("Restore from a Backup File") { finish(restore: true) }
                    .font(.subheadline)
                    .frame(minHeight: 44)
                    .accessibilityIdentifier("onboarding-restore")
            }
            if isLast && !replay {
                Button { showNew = true } label: {
                    Text("Make Your Own")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 50)
                }
                .buttonStyle(.bordered)
                .tint(.ink)
                .accessibilityIdentifier("onboarding-make-own")
                Button("Not Now") { finish() }
                    .font(.body.weight(.semibold))
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .accessibilityIdentifier("onboarding-not-now")
            }
            PageDots(count: pageCount, current: page)
        }
        .padding(.horizontal, 24)
        .padding(.top, 12)
        .padding(.bottom, 8)
        .background(Color(.systemGroupedBackground))
    }

    private var slide: AnyTransition {
        guard !reduceMotion else { return .opacity }
        return .asymmetric(insertion: .move(edge: forward ? .trailing : .leading),
                           removal: .move(edge: forward ? .leading : .trailing)).combined(with: .opacity)
    }

    private func move(to next: Int) {
        forward = next > page
        withAnimation(reduceMotion ? .easeInOut(duration: 0.2) : .snappy(duration: 0.35)) { page = next }
    }

    private func finish(restore: Bool = false) {
        if !replay { Onboarding.markDone() }
        onFinish(restore)
    }
}

// MARK: - Pages

/// Screen 1: the name, said once and backed by what the app does (research §1).
private struct NamePage: View {
    var body: some View {
        WelcomePage(title: Onboarding.appName, lead: "A habit doesn't need a perfect record. It needs to happen often enough.",
                    id: "onboarding-page-name") {
            WeekPicture()
            PointRow(symbol: "calendar", title: "You choose how often",
                     text: "Every day, 3 times a week, or 20 km a month.")
            PointRow(symbol: "flame", title: "Streaks count your goal",
                     text: "3 times a week, every week, is a streak. Days you didn't plan never break it.")
            PointRow(symbol: "leaf", title: "Life gets in the way",
                     text: "Skip a day or pause a habit. Skipped and paused days never count against you.")
            Text("Missing a day now and then doesn't stop a habit forming. Doing it often enough does.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

/// Screen 2: what's free, no account, where the habits live, and Plus named once with no button (research §2).
private struct FreePage: View {
    var body: some View {
        WelcomePage(title: "Free, with no account", lead: "Here's what you get, so nothing comes as a surprise later.",
                    id: "onboarding-page-free") {
            // Widgets join the first line when they're merged (Build Plan #63); never list what isn't here (C218).
            PointRow(symbol: "checkmark.circle", title: "Free forever: up to \(HabitStore.freeHabitLimit) habits",
                     text: "With reminders, streaks, progress and all your history. Tasks are unlimited.")
            PointRow(symbol: "person.crop.circle.badge.xmark", title: "No account, no ads",
                     text: "Nothing to sign up for. Just start.")
            PointRow(symbol: "iphone", title: "Your habits stay on this iPhone",
                     text: "They're included in your iPhone's backup, and you can save a backup file any time in ≡ › Backup & Export.")
            PointRow(symbol: "plus.circle", title: "Plus, if you want more",
                     text: "One payment, not a subscription: unlimited habits, iPad, Apple Watch and sync.")
        }
    }
}

/// Screen 3: when a day starts and which day a week starts on, already set to the usual answer (Backlog, 28 Sep).
private struct DaysPage: View {
    @Environment(HabitStore.self) private var store

    var body: some View {
        Form {
            Section {
                PageHeading(title: "Your days and weeks", lead: "Both are set to the usual answer. Change them only if they don't fit.")
            }
            Section {
                Picker("A New Day Starts At", selection: Binding(get: { store.settings.dayEndHour },
                                                                  set: { store.setDayEnd($0) })) {
                    ForEach(0...12, id: \.self) { hour in
                        Text(DayAndWeekView.hourName(hour)).tag(hour)
                    }
                }
                .accessibilityIdentifier("onboarding-day-start")
            } footer: {
                Text("Up late or working nights? Pick a later hour: what you log before then counts for the day before.")
            }

            Section {
                Picker("Weeks Start On", selection: Binding(get: { store.settings.weekStartChosen ? store.settings.weekStart : 0 },
                                                             set: { store.setWeekStart($0 == 0 ? nil : $0) })) {
                    Text("Automatic (\(DayAndWeekView.weekdayName(Calendar.autoupdatingCurrent.firstWeekday)))").tag(0)
                    ForEach(DayAndWeekView.weekOrder, id: \.self) { day in
                        Text(DayAndWeekView.weekdayName(day)).tag(day)
                    }
                }
                .accessibilityIdentifier("onboarding-week-start")
            } footer: {
                Text("Weekly goals and week streaks count in these weeks. You can change both later in ≡ › Day and Week.")
            }
        }
        .scrollContentBackground(.hidden)
    }
}

/// Screen 4 and Start From an Idea: a few ideas that fill in the form, or anything else (research §4). An idea is
/// pushed onto the stack the page is in, whose `navigationDestination` opens `IdeaForm`.
struct IdeasPage: View {
    /// The welcome has its own Make Your Own button in the bar below; the sheet shows it as the last row.
    var ownRow = true
    var onSomethingElse: () -> Void

    var body: some View {
        List {
            Section {
                PageHeading(title: "What's one habit to start with?",
                            lead: "Pick an idea or make your own. You can change everything before adding it.")
            }
            Section {
                ForEach(HabitIdea.all) { idea in
                    NavigationLink(value: idea) {
                        ChoiceLabel(icon: idea.symbol, title: idea.name, detail: idea.line)
                    }
                    .accessibilityIdentifier("idea-" + idea.name)
                }
            } footer: {
                Text("An idea only fills in the form. Nothing is added until you tap Add.").formNote()
            }
            if ownRow {
                Section {
                    Button(action: onSomethingElse) {
                        ChoiceLabel(icon: "plus", title: "Something Else…", detail: "A habit of your own, something to quit, or a task.")
                    }
                    .foregroundStyle(Color.primary)
                    .accessibilityIdentifier("idea-something-else")
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}

/// The New Habit form, filled in from an idea. A habit past the free limit gets the Plus screen, as in New.
struct IdeaForm: View {
    let idea: HabitIdea
    var onAdded: (UUID) -> Void
    @Environment(HabitStore.self) private var store

    var body: some View {
        if idea.type.isHabit && !store.canAddHabit {
            PlusView()
        } else {
            HabitForm(type: idea.type, idea: idea, onSaved: onAdded)
        }
    }
}

/// Start From an Idea on an empty Today: the same list in a sheet, with Cancel.
struct IdeasSheet: View {
    var onAdded: (UUID) -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var showNew = false
    @State private var addedFromNew: UUID?

    var body: some View {
        NavigationStack {
            IdeasPage(onSomethingElse: { showNew = true })
                .background(Color(.systemGroupedBackground))
                .navigationTitle("Ideas")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar { ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } } }
                .navigationDestination(for: HabitIdea.self) { idea in
                    IdeaForm(idea: idea) { added($0) }
                }
        }
        .sheet(isPresented: $showNew, onDismiss: { if let addedFromNew { added(addedFromNew) } }) {
            NewItemView { addedFromNew = $0 }
        }
    }

    private func added(_ id: UUID) {
        onAdded(id)
        dismiss()
    }
}

// MARK: - Parts

/// A welcome page: a large title, one plain sentence, then its points. Scrolls when the text is large, so Continue
/// is never pushed off a small screen (C145).
private struct WelcomePage<Content: View>: View {
    let title: String
    let lead: String
    let id: String
    @ViewBuilder var content: Content

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 26) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .font(.largeTitle.weight(.bold))
                        .accessibilityAddTraits(.isHeader)
                        .accessibilityIdentifier(id)
                    Text(lead)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                .fixedSize(horizontal: false, vertical: true)
                content
            }
            .frame(maxWidth: 560, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.top, 8)
            .padding(.bottom, 24)
            .frame(maxWidth: .infinity)
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}

/// The heading of a page that is a list: the same title and sentence as the other pages, as a row with no card (a
/// section header fades its text).
private struct PageHeading: View {
    let title: String
    let lead: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.largeTitle.weight(.bold))
                .foregroundStyle(Color.primary)
                .accessibilityAddTraits(.isHeader)
            Text(lead)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.top, 8)
        .listRowInsets(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
        .listRowBackground(Color.clear)
    }
}

/// One point: an icon in a fixed column, a bold line and a plain one, read as one by VoiceOver.
private struct PointRow: View {
    let symbol: String
    let title: String
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: symbol)
                .font(.title2)
                .foregroundStyle(Color.ink)
                .frame(width: 34)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 3) {
                Text(title).font(.headline)
                Text(text).font(.subheadline).foregroundStyle(.secondary)
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .accessibilityElement(children: .combine)
    }
}

/// The name in one picture: a 3-times-a-week habit, done on three days this week, on a 4-week streak.
private struct WeekPicture: View {
    private let done: Set<Int> = [0, 2, 4]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "figure.run").foregroundStyle(Color.ink)
                Text("Exercise").font(.headline)
                Text("3 times a week").font(.subheadline).foregroundStyle(.secondary)
                Spacer(minLength: 8)
                Label("4 wk", systemImage: "flame.fill")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.orange)
            }
            HStack(spacing: 0) {
                ForEach(0..<7, id: \.self) { day in
                    VStack(spacing: 6) {
                        Text(Self.letters[day]).font(.caption2).foregroundStyle(.secondary)
                        Image(systemName: done.contains(day) ? "checkmark.circle.fill" : "circle")
                            .font(.title3)
                            .foregroundStyle(done.contains(day) ? Color.ink : Color.secondary.opacity(0.5))
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(16)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Example: Exercise, 3 times a week. Done on 3 days this week. A 4 week streak.")
    }

    /// The week from Monday, in the phone's language.
    private static let letters: [String] = {
        let symbols = Calendar.autoupdatingCurrent.veryShortStandaloneWeekdaySymbols
        return (0..<7).map { symbols[($0 + 1) % 7] }
    }()
}

/// Where the person is: one dot per page, read as "Page 2 of 4".
private struct PageDots: View {
    let count: Int
    let current: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<count, id: \.self) { index in
                Circle()
                    .fill(index == current ? Color.primary : Color.secondary.opacity(0.35))
                    .frame(width: 7, height: 7)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Page \(current + 1) of \(count)")
        .accessibilityIdentifier("onboarding-dots")
    }
}
