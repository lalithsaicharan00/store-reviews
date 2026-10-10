import SwiftUI

/// The first launch, rebuilt from the user's wireframes (Current Work 73.1, 9 Oct 2026; Figma "Onboarding — Current
/// wireframes", one row per path). One question first, **Have you used Often Enough before?**, then either the new
/// person's pages (what's included, what the app does, days and weeks, a first habit) or every way back (iCloud brings
/// the habits by itself; a backup in iCloud or a file, Architecture 11 §13.1). Research: "Onboarding for New and
/// Returning People — Research and Proposed Flow" (9 Oct 2026). Nothing here asks for a permission or a purchase, and
/// there's no account to make.
enum Onboarding {
    /// Set once the welcome is finished, skipped or left for a restore. Kept in UserDefaults: it's about this phone.
    static let doneKey = "onboarding.done"
    static let outcomeKey = "onboarding.outcome"

    /// The app's name as people see it in the welcome and help.
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

/// One idea on "Your first habit" and in Start From an Idea. It only fills in the New Habit form: the name, how it's
/// tracked and how often. Nothing is saved until Add (C292), and amounts stay empty (Design Rules).
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

    /// "Check it off · 3 times a week": how it's tracked, then how often, in the form's own words (the wireframe's
    /// shorter lines for quitting and cutting down, 9 Oct 2026).
    var line: String {
        switch type {
        case .quit: return "Quit · time since you stopped"
        case .cutBack: return "Cut down · a daily limit"
        default: return type.title + " · " + often.phrase(hasAmount: type == .amount || type == .time, weekStart: 2)
        }
    }
}

/// The list of ideas: onboarding's "Your first habit" and Start From an Idea on an empty Today. An idea is pushed onto
/// the stack the list is in, whose `navigationDestination(for: HabitIdea.self)` opens `IdeaForm` straight away: the
/// idea already says how it's tracked, so "What do you want to do?" is never asked first (the user, 9 Oct 2026).
struct IdeasList: View {
    /// Start From an Idea shows "Something Else…" as the last row; onboarding has its own button at the bottom.
    var ownRow = true
    var onSomethingElse: () -> Void = {}

    var body: some View {
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
}

/// The New Habit form, filled in from an idea. Past the free limit, Add opens the 6th-habit sheet and the form is kept
/// (Current Work 80).
struct IdeaForm: View {
    let idea: HabitIdea
    var onAdded: (UUID) -> Void

    var body: some View {
        HabitForm(type: idea.type, idea: idea, onSaved: onAdded)
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
            List {
                Section {
                    OnboardingHeading(title: "What's one habit to start with?",
                                      lead: "Pick an idea or make your own. You can change everything before adding it.")
                }
                IdeasList(onSomethingElse: { showNew = true })
            }
            .scrollContentBackground(.hidden)
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

// MARK: - The flow

/// Every page of the welcome after the first, pushed on one stack so Back and the edge swipe always go back a page.
enum OnboardingRoute: Hashable {
    // I'm new here (row 2)
    case included, build, quit, tasks, days, firstHabit, createOwn
    // I've used it before (rows 5–9)
    case welcomeBack, restore, review
    case working(OnboardingWork)
    case privacy
}

/// How the welcome ended, for the outcome it records and what comes after.
enum OnboardingOutcome {
    /// A first habit or task was added.
    case completed
    /// Skip setup, or Done in the replay.
    case skipped
    /// "Start without restoring" on Welcome back.
    case startedFresh
    /// Signed in and the account's data came back (or there was none to bring).
    case signedIn
    /// A backup (iCloud or a file) was restored.
    case restored
    /// The data came from the other device.
    case transferred
    /// The data already on this iPhone was kept.
    case keptOnDevice

    var analytics: String {
        switch self {
        case .completed: "completed"
        case .skipped: "skipped"
        case .startedFresh: "started_fresh"
        case .signedIn: "signed_in"
        case .restored: "restored"
        case .transferred: "transferred"
        case .keptOnDevice: "kept_on_device"
        }
    }
}

/// What the pages share: the stack's path, the backup waiting for the person's choice, and how to end the welcome.
/// Pages read only what they need (`review` is read by the review page alone), so a push never redraws the others.
@Observable
final class OnboardingFlow {
    var path = NavigationPath()
    /// A checked backup on its way back, waiting on "Restore" (the review page), and where it came from.
    var review: ReturningBackup?
    /// Ends the welcome; set by `OnboardingView`.
    @ObservationIgnored var finish: (OnboardingOutcome) -> Void = { _ in }
    /// A page has appeared: its analytics step, once per welcome; set by `OnboardingView`.
    @ObservationIgnored var reached: (String) -> Void = { _ in }

    func go(_ route: OnboardingRoute) { path.append(route) }

    /// Replaces the page on top (a "Getting your data" page that has done its job) with `route`, so Back never
    /// returns to a finished loading page.
    func replaceTop(with route: OnboardingRoute) {
        if !path.isEmpty { path.removeLast() }
        path.append(route)
    }
}

/// The welcome. `replay` (Help → Show the Welcome Again) shows only what's included and what the app does, then Done.
struct OnboardingView: View {
    var replay = false
    /// Called once, however it ends.
    var onFinish: () -> Void

    @Environment(HabitStore.self) private var store
    @State private var flow = OnboardingFlow()
    @State private var analyticsStepTicket: AnalyticsTicket?
    @State private var analyticsFinished = false
    @State private var observedSteps: Set<String> = []

    var body: some View {
        @Bindable var flow = flow
        NavigationStack(path: $flow.path) {
            Group {
                if replay {
                    IncludedPage(replay: true)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button { end(.skipped) } label: { Image(systemName: "xmark") }
                                    .accessibilityLabel("Close")
                                    .accessibilityIdentifier("onboarding-close")
                            }
                        }
                } else {
                    WelcomePage()
                }
            }
            .navigationDestination(for: OnboardingRoute.self) { route in
                page(route)
            }
            .navigationDestination(for: HabitIdea.self) { idea in
                IdeaForm(idea: idea) { _ in finishAfterSave() }
            }
        }
        .environment(flow)
        .onAppear {
            flow.finish = { end($0) }
            flow.reached = { observe($0) }
            #if DEBUG
            // Screenshots and UI tests: `-onboarding-page build,quit` opens the welcome on those pages, in order.
            let arguments = ProcessInfo.processInfo.arguments
            if let at = arguments.firstIndex(of: "-onboarding-page"), at + 1 < arguments.count {
                for name in arguments[at + 1].split(separator: ",") {
                    if let route = OnboardingRoute.perf(String(name)) { flow.go(route) }
                }
            }
            #endif
        }
        .analyticsScreen(.onboarding)
        .interactiveDismissDisabled()
        .onPerfCommand { action in
            switch action {
            case .onboardingPage(let name): if let route = OnboardingRoute.perf(name) { flow.go(route) }
            case .onboardingBack: if !flow.path.isEmpty { flow.path.removeLast() }
            case .close: onFinish()
            default: break
            }
        }
    }

    @ViewBuilder private func page(_ route: OnboardingRoute) -> some View {
        switch route {
        case .included: IncludedPage(replay: replay)
        case .build: BuildPage(replay: replay)
        case .quit: QuitPage(replay: replay)
        case .tasks: TasksPage(replay: replay)
        case .days: DaysPage()
        case .firstHabit: FirstHabitPage()
        case .createOwn: NewItemChoices(onAdded: { _ in finishAfterSave() })
        case .welcomeBack: WelcomeBackPage()
        case .restore: RestoreSourcePage()
        case .review: ReviewBackupPage()
        case .working(let work): WorkingPage(work: work)
        case .privacy: PrivacyView()
        }
    }

    /// A first habit or task was added: the welcome ends once it's saved, so Today shows it.
    private func finishAfterSave() {
        Task { @MainActor in
            await store.flush()
            guard store.problem == nil else { return }
            end(.completed)
        }
    }

    /// Each page once per welcome, in the words the analytics contract allows (`AnalyticsContract.enums["step"]`).
    private func observe(_ step: String) {
        guard let ticket = Analytics.shared.ticket, observedSteps.insert(step).inserted else { return }
        analyticsStepTicket = ticket
        if !replay && step == "welcome" { Analytics.shared.cohort("fresh_first_run", ticket: analyticsStepTicket) }
        let returning = ["returning", "restore_source"].contains(step)
        Analytics.shared.event(.onboardingStep, ["flow_mode": .text(replay ? "replay" : returning ? "restore" : "first_run"),
            "step": .text(step)], ticket: analyticsStepTicket)
    }

    private func end(_ outcome: OnboardingOutcome) {
        guard !analyticsFinished else { return }
        analyticsFinished = true
        if !replay {
            Onboarding.markDone()
            UserDefaults.standard.set(outcome == .skipped ? "skipped" : "completed", forKey: Onboarding.outcomeKey)
        }
        Analytics.shared.event(.onboardingFinished, ["flow_mode": .text(replay ? "replay" : "first_run"),
            "outcome": .text(replay ? "completed" : outcome.analytics)], ticket: analyticsStepTicket)
        onFinish()
    }
}

extension OnboardingRoute {
    /// Speed runs only (`PerfDriver` "onboarding"): a page by name.
    static func perf(_ name: String) -> OnboardingRoute? {
        switch name {
        case "included": .included
        case "build": .build
        case "quit": .quit
        case "tasks": .tasks
        case "days": .days
        case "firstHabit": .firstHabit
        case "createOwn": .createOwn
        case "welcomeBack": .welcomeBack
        case "restore": .restore
        // Screenshots only: the loading page as it looks while setting things up.
        case "gettingData": .working(.thisDevice)
        default: nil
        }
    }
}
