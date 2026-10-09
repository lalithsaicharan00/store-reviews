import SwiftUI

// The welcome's first screen and the new person's pages (Current Work 73.1; Figma rows 1–2, 9 Oct 2026). The wireframes
// set the screens, their order and their words; the controls are the app's own (lists, the bottom button, the back
// chevron), as the user asked: "you should sync everything with our app".

// MARK: - 01 · Welcome

/// The first screen anyone sees after installing: the app, what it's for, and one question. **The words are the
/// user's, final** (9 Oct 2026). Each answer moves on at the first tap; there's nothing to skip or go back to.
struct WelcomePage: View {
    @Environment(OnboardingFlow.self) private var flow
    @Environment(\.dynamicTypeSize) private var typeSize

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 0) {
                    Spacer(minLength: 24)
                    identity
                    Spacer(minLength: 32)
                    question
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
                .frame(maxWidth: 560)
                .frame(maxWidth: .infinity, minHeight: proxy.size.height)
            }
            .scrollBounceBehavior(.basedOnSize)
        }
        .background(Color(.systemGroupedBackground))
        .toolbar(.hidden, for: .navigationBar)
        .onAppear { flow.reached("welcome") }
    }

    /// The icon, the name and what it's for, centred. There's no app icon yet: its place is a plain grey square of the
    /// icon's size and shape, so the layout doesn't move when it comes (the user, 9 Oct 2026).
    private var identity: some View {
        VStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 19, style: .continuous)
                .fill(Color(.systemGray4))
                .frame(width: 84, height: 84)
                .accessibilityHidden(true)
                .accessibilityIdentifier("onboarding-icon-space")
            Text(Onboarding.appName)
                .font(.largeTitle.weight(.bold))
                .accessibilityAddTraits(.isHeader)
                .accessibilityIdentifier("onboarding-page-welcome")
            Text("Habits grow through repetition. You choose how often is enough.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 330)
        }
        .fixedSize(horizontal: false, vertical: true)
    }

    private var question: some View {
        VStack(spacing: 12) {
            Text("Have you used \(Onboarding.appName) before?")
                .font(.headline)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 4)
                .accessibilityAddTraits(.isHeader)
            OnboardingCard(symbol: "sparkle", title: "I'm new here", detail: "Build habits and keep track of your tasks.",
                           id: "onboarding-new") { flow.go(.included) }
            OnboardingCard(symbol: "arrow.counterclockwise", title: "I've used it before",
                           detail: "Sign in or restore a backup to get your habits back.",
                           id: "onboarding-returning") { flow.go(.welcomeBack) }
            // Kept from the first welcome (U5): what's shared, before anything is (Analytics Contract).
            Button("Privacy & Optional Usage Sharing") { flow.go(.privacy) }
                .font(.footnote)
                .foregroundStyle(.secondary)
                .frame(minHeight: 44)
                .accessibilityIdentifier("onboarding-privacy")
        }
    }
}

// MARK: - 02 · What's included

/// What the free plan has, said before any effort (C236), and that no account is needed. Plus is named once, with no
/// button (no buying in the welcome). List only what this build has (C218).
struct IncludedPage: View {
    var replay = false
    @Environment(OnboardingFlow.self) private var flow

    var body: some View {
        OnboardingList(title: "What's included.", lead: nil, id: "onboarding-page-free") {
            Section {
                Text("Free plan").font(.headline).padding(.top, 4)
                IncludedRow(symbol: "repeat", title: "Up to \(HabitStore.freeHabitLimit) habits")
                IncludedRow(symbol: "infinity", title: "Unlimited tasks")
                IncludedRow(symbol: "square.grid.2x2", title: "Widgets included")
            }
            .listRowSeparator(.hidden)
            Section {
                IncludedRow(symbol: "person.crop.circle", title: "No account needed")
                if BackupFeatures.iCloudBackup {
                    IncludedRow(symbol: "icloud", title: "iCloud backup", detail: "Uses your iPhone's iCloud account.")
                }
            } footer: {
                Text("More habits with optional Plus.").formNote()
            }
            .listRowSeparator(.hidden)
        } bottom: {
            OnboardingButton(title: "Continue", id: "onboarding-continue") { flow.go(.build) }
        }
        .skipSetup(!replay)
        .onAppear { flow.reached("free_plan") }
    }
}

private struct IncludedRow: View {
    let symbol: String
    let title: String
    var detail: String? = nil

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: symbol)
                .font(.system(size: 20))
                .foregroundStyle(Color.primary)
                .frame(width: 30)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.body.weight(.semibold))
                if let detail { Text(detail).font(.footnote).foregroundStyle(.secondary) }
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .accessibilityElement(children: .combine)
    }
}

// MARK: - 03–05 · What the app does

/// 03: the four ways to build a habit, drawn as Today draws them.
struct BuildPage: View {
    var replay = false
    @Environment(OnboardingFlow.self) private var flow

    var body: some View {
        OnboardingList(title: "Your habit. Your goal.", lead: "Count, check off, time or follow steps. You choose the goal.",
                       id: "onboarding-page-build") {
            ShowcaseCard(title: "Morning", subtitle: "Starts " + DaySection.clock(6 * 60), rows: [
                ShowcaseItem(symbol: "drop.fill", color: .blue, name: "Water", line: "3/8 glasses", streak: 3, button: .text("+1"), progress: 3 / 8,
                             spoken: "Water, 3 of 8 glasses"),
                ShowcaseItem(symbol: "pills.fill", color: .green, name: "Take vitamins", line: "Every day", streak: 2, button: .symbol("checkmark"),
                             spoken: "Take vitamins, every day"),
                ShowcaseItem(symbol: "book.fill", color: .orange, name: "Read", line: "6 min/10 min", streak: 4, button: .symbol("play.fill"), progress: 0.6,
                             spoken: "Read, 6 of 10 minutes"),
                ShowcaseItem(symbol: "checklist", color: .purple, name: "Tidy desk", line: "0/3 steps", streak: 2, button: .symbol("chevron.down"),
                             spoken: "Tidy desk, 0 of 3 steps"),
            ])
        } bottom: {
            OnboardingButton(title: "Continue", id: "onboarding-continue") { flow.go(.quit) }
        }
        .skipSetup(!replay)
        .onAppear { flow.reached("build") }
    }
}

/// 04: quitting (the time since you stopped) and cutting down (a limit), in their own card as on Today.
struct QuitPage: View {
    var replay = false
    @Environment(OnboardingFlow.self) private var flow

    var body: some View {
        OnboardingList(title: "Quit or cut down.", lead: "Quit completely, or set a limit on how much or how long.",
                       id: "onboarding-page-quit") {
            ShowcaseCard(title: TodayView.quittingTitle, subtitle: nil, rows: [
                ShowcaseItem(symbol: "nosign", color: .gray, name: "Smoking", line: "Best 45 days", clock: "19d 12:32:45",
                             spoken: "Smoking, 19 days 12 hours since you stopped, best 45 days"),
                ShowcaseItem(symbol: "cup.and.saucer.fill", color: .orange, name: "Coffee", line: "0/2 cups max", button: .text("+1"),
                             spoken: "Coffee, 0 of at most 2 cups"),
                ShowcaseItem(symbol: "iphone", color: .purple, name: "Social media", line: "0 min/30 min max", streak: 7, button: .symbol("play.fill"),
                             spoken: "Social media, 0 of at most 30 minutes"),
            ])
        } bottom: {
            OnboardingButton(title: "Continue", id: "onboarding-continue") { flow.go(.tasks) }
        }
        .skipSetup(!replay)
        .onAppear { flow.reached("quit") }
    }
}

/// 05: tasks, once or on repeat, unlimited on the free plan.
struct TasksPage: View {
    var replay = false
    @Environment(OnboardingFlow.self) private var flow

    var body: some View {
        OnboardingList(title: "Tasks, once or on repeat.", lead: "Plan one-off jobs and repeating tasks. Keep them alongside your habits.",
                       id: "onboarding-page-tasks") {
            ShowcaseCard(title: "Anytime", subtitle: "Once or on repeat", rows: [
                ShowcaseItem(symbol: "shippingbox.fill", color: .orange, name: "Pick up parcel", line: "Task · Once", button: .symbol("checkmark"),
                             spoken: "Pick up parcel, a task, once"),
                ShowcaseItem(symbol: "creditcard.fill", color: .orange, name: "Pay rent", line: "Task · Every month", button: .symbol("checkmark"),
                             spoken: "Pay rent, a task, every month"),
                ShowcaseItem(symbol: "leaf.fill", color: .orange, name: "Water plants", line: "Task · 7 days after done", button: .symbol("checkmark"),
                             spoken: "Water plants, a task, 7 days after it's done"),
            ])
            Section {
                IncludedRow(symbol: "infinity", title: "Unlimited tasks", detail: "Included in the free plan")
            }
        } bottom: {
            if replay {
                OnboardingButton(title: "Done", id: "onboarding-continue") { flow.finish(.skipped) }
            } else {
                OnboardingButton(title: "Continue", id: "onboarding-continue") { flow.go(.days) }
            }
        }
        .skipSetup(!replay)
        .onAppear { flow.reached("tasks") }
    }
}

/// A Today card drawn from the same parts as Today (`HabitIcon`, `StreakLabel`, `RoundActionButton`, `ProgressFill`),
/// with example habits that aren't saved anywhere. Nothing in it can be tapped; VoiceOver reads each row as one line.
private struct ShowcaseCard: View {
    let title: String
    let subtitle: String?
    let rows: [ShowcaseItem]

    var body: some View {
        Section {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 1) {
                    Text(title).font(.headline).lineLimit(1)
                    if let subtitle { Text(subtitle).font(.footnote).foregroundStyle(.secondary).lineLimit(1) }
                }
                Spacer(minLength: 8)
                Image(systemName: "chevron.down")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .accessibilityHidden(true)
            }
            .frame(minHeight: 44)
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.isHeader)
            ForEach(rows) { row in
                ShowcaseRow(item: row)
                    .listRowBackground(ProgressFill(progress: row.progress, color: row.color))
            }
        }
        .allowsHitTesting(false)
        .accessibilityIdentifier("onboarding-showcase")
    }
}

private struct ShowcaseItem: Identifiable {
    enum Action { case none, text(String), symbol(String) }
    let symbol: String
    let color: HabitColor
    let name: String
    let line: String
    var streak = 0
    var button: Action = .none
    var progress = 0.0
    /// A quit row's time since: the large number at the end of the row.
    var clock: String? = nil
    let spoken: String
    var id: String { name }
}

private struct ShowcaseRow: View {
    let item: ShowcaseItem

    var body: some View {
        HStack(spacing: RowSpace.iconToText) {
            HabitIcon(symbol: item.symbol, color: item.color)
            VStack(alignment: .leading, spacing: RowSpace.nameToLine) {
                Text(item.name).font(.body).lineLimit(1)
                Text(item.line).font(.subheadline).foregroundStyle(.secondary).monospacedDigit().lineLimit(1)
            }
            Spacer(minLength: RowSpace.textToTrailing)
            if item.streak > 0 { StreakLabel(count: item.streak, onFill: item.progress >= 0.7) }
            if let clock = item.clock {
                Text(clock).font(.headline.monospacedDigit()).lineLimit(1).fixedSize()
            }
            switch item.button {
            case .none: EmptyView()
            case .text(let text): RoundActionButton(symbol: "plus", done: false, color: item.color, label: "", text: text) {}
            case .symbol(let symbol): RoundActionButton(symbol: symbol, done: false, color: item.color, label: "", popsOnTap: false) {}
            }
        }
        .frame(minHeight: RowBand.height)
        .padding(.vertical, RowSpace.rowPadding)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Example: " + item.spoken + (item.streak > 0 ? ", a \(item.streak) day streak" : ""))
    }
}

// MARK: - 06 · Your days and weeks

/// When a day starts and which day a week starts on, already set to the usual answer (Backlog, 28 Sep); both can be
/// changed later in ≡ → Day and Week.
struct DaysPage: View {
    @Environment(HabitStore.self) private var store
    @Environment(OnboardingFlow.self) private var flow

    var body: some View {
        OnboardingList(title: "Your days and weeks.", lead: nil, id: "onboarding-page-days") {
            Section {
                Picker("A new day starts at", selection: Binding(get: { store.settings.dayEndHour },
                                                                  set: { store.setDayEnd($0) })) {
                    ForEach(0...12, id: \.self) { hour in
                        Text(DayAndWeekView.hourName(hour)).tag(hour)
                    }
                }
                .accessibilityIdentifier("onboarding-day-start")
            }
            Section {
                Picker("Weeks start on", selection: Binding(get: { store.settings.weekStartChosen ? store.settings.weekStart : 0 },
                                                             set: { store.setWeekStart($0 == 0 ? nil : $0) })) {
                    Text("Automatic (\(DayAndWeekView.weekdayName(Calendar.autoupdatingCurrent.firstWeekday)))").tag(0)
                    ForEach(DayAndWeekView.weekOrder, id: \.self) { day in
                        Text(DayAndWeekView.weekdayName(day)).tag(day)
                    }
                }
                .accessibilityIdentifier("onboarding-week-start")
            } footer: {
                // "You can later change these later in Settings", put right (the user, 9 Oct 2026), naming the place
                // as the app names it: there's no Settings page, only ≡ → Day and Week (Help's rule).
                Text("You can change these later in ≡ › Day and Week.").formNote()
            }
        } bottom: {
            OnboardingButton(title: "Continue", id: "onboarding-continue") { flow.go(.firstHabit) }
        }
        .skipSetup(true)
        .onAppear { flow.reached("day_week") }
    }
}

// MARK: - 07 · Your first habit

/// Ideas that open the form already filled in (the idea says how it's tracked, so New's two questions are skipped),
/// or the whole New flow for anything else. Skip setup ends the welcome with nothing added.
struct FirstHabitPage: View {
    @Environment(OnboardingFlow.self) private var flow

    var body: some View {
        OnboardingList(title: "Your first habit.", lead: "Choose an idea to get started. You can edit it before adding.",
                       id: "onboarding-page-ideas") {
            IdeasList(ownRow: false)
        } bottom: {
            // "Create on my own" in the wireframe; "my own what?" (the user, 9 Oct 2026). It opens exactly what + opens:
            // a habit, something to quit, or a task.
            OnboardingButton(title: "Create my own habit", id: "onboarding-make-own") { flow.go(.createOwn) }
        }
        .skipSetup(true)
        .onAppear { flow.reached("first_item") }
    }
}

// MARK: - Shared parts

/// A welcome page that's a list: its heading (a large title and one plain line), its sections, and its bottom
/// actions, which stay in view above the home indicator at every text size (C145).
struct OnboardingList<Content: View, Bottom: View>: View {
    let title: String
    let lead: String?
    let id: String
    @ViewBuilder var content: Content
    @ViewBuilder var bottom: Bottom

    var body: some View {
        List {
            Section {
                OnboardingHeading(title: title, lead: lead, id: id)
            }
            content
        }
        .listSectionSpacing(16)
        .scrollContentBackground(.hidden)
        .background(Color(.systemGroupedBackground))
        .safeAreaInset(edge: .bottom, spacing: 0) {
            // A page whose actions are in its list (Welcome back, Sign back in) has no bar at all.
            if Bottom.self != EmptyView.self { OnboardingBottomBar { bottom } }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// A page's heading, as a row with no card (a section header would fade its text).
struct OnboardingHeading: View {
    let title: String
    let lead: String?
    var id: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title.weight(.bold))
                .foregroundStyle(Color.primary)
                .accessibilityAddTraits(.isHeader)
                .accessibilityIdentifier(id ?? "")
            if let lead {
                Text(lead)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .infinity, alignment: .leading)
        .listRowInsets(EdgeInsets(top: 4, leading: 4, bottom: 0, trailing: 4))
        .listRowBackground(Color.clear)
    }
}

/// The bottom of a page: its main button, full width (U18's place for a screen's one filled action).
struct OnboardingBottomBar<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        VStack(spacing: 4) { content }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 8)
            .frame(maxWidth: .infinity)
            .background(Color(.systemGroupedBackground))
    }
}

/// The welcome's main button: filled in ink, full width, a capsule; or a plain text button under it.
struct OnboardingButton: View {
    let title: String
    let id: String
    var prominent = true
    let action: () -> Void

    var body: some View {
        if prominent {
            Button(action: action) {
                Text(title).font(.headline).foregroundStyle(Color.onInk).frame(maxWidth: .infinity, minHeight: 32)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .tint(.ink)
            .accessibilityIdentifier(id)
        } else {
            Button(action: action) {
                Text(title).font(.body).foregroundStyle(.secondary).frame(maxWidth: .infinity, minHeight: 44)
            }
            .buttonStyle(.plain)
            .accessibilityIdentifier(id)
        }
    }
}

/// One answer on the welcome's cards: an icon in a tile, a title and one line, and a chevron; the whole card is the
/// button.
struct OnboardingCard: View {
    let symbol: String
    let title: String
    let detail: String
    let id: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                OnboardingTile(symbol: symbol)
                VStack(alignment: .leading, spacing: 3) {
                    Text(title).font(.body.weight(.semibold)).foregroundStyle(Color.primary)
                    Text(detail).font(.subheadline).foregroundStyle(.secondary)
                }
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                Spacer(minLength: 4)
                Image(systemName: "chevron.right")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.tertiary)
                    .accessibilityHidden(true)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
        }
        .buttonStyle(OnboardingCardStyle())
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityIdentifier(id)
    }
}

/// A rounded card that darkens a little while pressed, as a list row does.
struct OnboardingCardStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color(.systemGray4) : Color.card,
                        in: RoundedRectangle(cornerRadius: 22, style: .continuous))
    }
}

/// A symbol in a small rounded tile: the welcome's cards and the ways back.
struct OnboardingTile: View {
    let symbol: String

    var body: some View {
        Image(systemName: symbol)
            .font(.system(size: 19, weight: .medium))
            .foregroundStyle(Color.primary)
            .frame(width: 44, height: 44)
            .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            .accessibilityHidden(true)
    }
}

extension View {
    /// "Skip setup" at the top right: ends the welcome on Today, with nothing added.
    func skipSetup(_ shown: Bool) -> some View { modifier(SkipSetup(shown: shown)) }
}

private struct SkipSetup: ViewModifier {
    let shown: Bool
    @Environment(OnboardingFlow.self) private var flow

    func body(content: Content) -> some View {
        content.toolbar {
            if shown {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Skip setup") { flow.finish(.skipped) }
                        .accessibilityIdentifier("onboarding-skip")
                }
            }
        }
    }
}
