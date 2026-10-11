import SwiftUI
import WatchKit

/// Where Today's stack can go: two levels at most (Design Notes, navigation).
enum WatchRoute: Hashable {
    case day(UUID)
    case logManually(UUID)
    case log(UUID)
    case allLogs(UUID)
}

/// Today on the Watch (A): opens straight from the Watch's own database (WA1), today's habits and tasks in Today's own
/// sections and order, each with its round button. One NavigationStack, a large title, the time top right (system).
struct TodayScreen: View {
    @Environment(WatchModel.self) private var model
    @Environment(HabitStore.self) private var store
    @Environment(WatchNavigation.self) private var navigation
    @State private var hold = TodayHold()

    var body: some View {
        @Bindable var navigation = navigation
        NavigationStack(path: $navigation.path) {
            content
                .navigationTitle("Today")
                .navigationDestination(for: WatchRoute.self) { route in
                    switch route {
                    case .day(let id): DayDetailsScreen(habitID: id)
                    case .logManually(let id): LogManuallyScreen(habitID: id)
                    case .log(let id): LogScreen(entryID: id)
                    case .allLogs(let id): AllLogsScreen(habitID: id)
                    }
                }
        }
        .fullScreenCover(item: $navigation.routine) { session in
            RoutineScreen(session: session)
        }
    }

    @ViewBuilder
    private var content: some View {
        if model.openFailed {
            ContentUnavailableView("Couldn't open your habits", systemImage: "exclamationmark.triangle",
                                   description: Text("Nothing has been changed. Restart the app."))
        } else if !store.isLoaded {
            ProgressView()
        } else if store.habits.isEmpty && !model.filled {
            // Never "no habits" before hearing back from the iPhone (WA2, A6).
            FirstLaunchView()
        } else if store.habits.isEmpty {
            EmptyStateView(symbol: "iphone", title: "No habits yet", detail: "Add one in Often Enough on your iPhone.")
                .accessibilityIdentifier("no-habits")
        } else {
            let plan = TodayPlan.make(store)
            if plan.isEmpty {
                EmptyStateView(symbol: "checkmark.circle", title: "Nothing planned for today",
                               detail: "Habits for other days show on their day.")
                    .accessibilityIdentifier("nothing-planned")
            } else {
                TodayList(plan: plan, hold: hold)
            }
        }
    }
}

/// Today holds still through a run of taps and settles 1.5 s after the last (U4): only then do done rows sink (U13).
@Observable final class TodayHold {
    private(set) var order: [String: [String]]?
    @ObservationIgnored private var release: Task<Void, Never>?

    func tapped(_ plan: TodayPlan, current: [String: [String]]) {
        if order == nil { order = current }
        release?.cancel()
        release = Task { @MainActor [weak self] in
            try? await Task.sleep(for: .seconds(1.5))
            guard !Task.isCancelled else { return }
            withAnimation(.snappy) { self?.order = nil }
        }
    }
}

struct TodayList: View {
    let plan: TodayPlan
    let hold: TodayHold
    @Environment(HabitStore.self) private var store
    @Environment(WatchNavigation.self) private var navigation
    @AppStorage(Preferences.doneOrder) private var doneOrder = DoneOrder.bottom.rawValue

    var body: some View {
        let ordered = orderedRows()
        ScrollViewReader { proxy in
        List {
            if store.problem != nil {
                SaveProblemBanner()
            }
            // Only when something counts toward it: a day of limits and quits alone has no bar (H1), never
            // "Nothing planned" above habits.
            if plan.total > 0 {
                DayBarView(done: plan.done, total: plan.total)
                    .listRowBackground(Color.clear)
            }
            ForEach(plan.sections) { section in
                Section {
                    ForEach(ordered[section.id] ?? section.rows) { row in
                        WatchRow(row: row, day: plan.day,
                                 open: { navigation.path.append(WatchRoute.day(row.habit.id)) },
                                 tapped: { hold.tapped(plan, current: currentOrder(ordered)) })
                    }
                } header: {
                    SectionHeaderView(section: section, plan: plan)
                }
            }
            if !plan.paused.isEmpty {
                PausedRow(habits: plan.paused, day: plan.day)
            }
        }
        .listStyle(.plain)
        .accessibilityIdentifier("today-list")
        .onAppear { WatchPerf.todayAppeared() }
        .background {
            #if DEBUG
            PerfScroller(proxy: proxy, ids: plan.sections.flatMap { ordered[$0.id] ?? $0.rows }.map(\.id))
            #endif
        }
        }
    }

    /// Each section's rows: the held order while Today holds still, otherwise done rows below the rest (unless the
    /// iPhone's Appearance keeps them in place).
    private func orderedRows() -> [String: [TodayPlan.Row]] {
        var result: [String: [TodayPlan.Row]] = [:]
        for section in plan.sections {
            if let held = hold.order?[section.id] {
                let byID = Dictionary(section.rows.map { ($0.id, $0) }, uniquingKeysWith: { a, _ in a })
                let kept = held.compactMap { byID[$0] }
                let keptIDs = Set(held)
                result[section.id] = kept + section.rows.filter { !keptIDs.contains($0.id) }
            } else if doneOrder != DoneOrder.inPlace.rawValue && !section.isQuitting {
                let done = section.rows.filter { TodayPlan.isDone($0, on: plan.day, store: store) }
                let doneIDs = Set(done.map(\.id))
                result[section.id] = section.rows.filter { !doneIDs.contains($0.id) } + done
            } else {
                result[section.id] = section.rows
            }
        }
        return result
    }

    private func currentOrder(_ ordered: [String: [TodayPlan.Row]]) -> [String: [String]] {
        ordered.mapValues { $0.map(\.id) }
    }
}

/// "1 of 7 done" and a segment per habit (A1, U10: habits, not ticks).
struct DayBarView: View {
    let done: Int
    let total: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if total > 0 && total <= 12 {
                HStack(spacing: 3) {
                    ForEach(0..<total, id: \.self) { i in
                        Capsule().fill(i < done ? Color.white : Color.white.opacity(0.22)).frame(height: 4)
                    }
                }
            } else if total > 12 {
                Capsule().fill(Color.white.opacity(0.22)).frame(height: 4)
                    .overlay(alignment: .leading) {
                        Capsule().fill(Color.white).scaleEffect(x: Double(done) / Double(total), y: 1, anchor: .leading)
                    }
            }
            Text(total == 0 ? "Nothing planned" : done == total ? "All \(total) done" : "\(done) of \(total) done")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("day-bar")
    }
}

/// A section's header: its name ("Morning", with Now), what's left, and ▶ to run it as a routine (filled in the Now
/// section, grey elsewhere, none for Quitting; a ✓ once the section is done).
struct SectionHeaderView: View {
    let section: TodayPlan.Section
    let plan: TodayPlan
    @Environment(HabitStore.self) private var store
    @Environment(WatchNavigation.self) private var navigation

    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 6) {
                    Text(section.title).font(.headline).foregroundStyle(.primary).lineLimit(1)
                    if section.isNow {
                        Text("Now").font(.caption2.weight(.semibold))
                            .padding(.horizontal, 6).padding(.vertical, 2)
                            .background(Capsule().fill(Color.white.opacity(0.2)))
                    }
                }
                if let left = section.left, left > 0 {
                    Text("\(left) left").font(.footnote).foregroundStyle(.secondary)
                }
            }
            Spacer(minLength: 4)
            if let left = section.left {
                if left == 0 {
                    Image(systemName: "checkmark.circle")
                        .font(.system(size: 22)).foregroundStyle(.secondary)
                        .accessibilityLabel("\(section.title) done")
                } else {
                    Button {
                        start()
                    } label: {
                        Image(systemName: "play.fill")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(section.isNow ? Color.black : Color.white)
                            .frame(width: 38, height: 38)
                            .background(Circle().fill(section.isNow ? Color.white : Color.white.opacity(0.2)))
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Start \(section.title)")
                    .accessibilityIdentifier("start-\(section.id)")
                }
            }
        }
        .textCase(nil)
        .padding(.top, 8)
        .padding(.bottom, 2)
    }

    /// Any section's ▶ opens its unfinished habits one at a time (C1, the iPhone's rule).
    private func start() {
        let pending = section.rows.filter { !TodayPlan.isDone($0, on: plan.day, store: store) }.map(\.habit)
        guard !pending.isEmpty else { return }
        WKInterfaceDevice.current().play(.click)
        navigation.routine = RoutineSession(part: section.id, title: section.title, day: plan.day, habits: pending)
    }
}

/// Paused habits leave Today and sit folded at the end, with when they come back (H6). Resuming is on the iPhone.
struct PausedRow: View {
    let habits: [Habit]
    let day: LocalDay
    @Environment(HabitStore.self) private var store
    @State private var open = false

    var body: some View {
        Button { withAnimation(.snappy) { open.toggle() } } label: {
            HStack {
                VStack(alignment: .leading, spacing: 1) {
                    Text("Paused").font(.body)
                    Text(summary).font(.footnote).foregroundStyle(.secondary).lineLimit(open ? nil : 2)
                }
                Spacer(minLength: 4)
                Image(systemName: open ? "chevron.up" : "chevron.down").foregroundStyle(.secondary)
            }
        }
        .accessibilityIdentifier("paused")
        if open {
            ForEach(habits) { habit in
                VStack(alignment: .leading, spacing: 1) {
                    Text(habit.name)
                    if let pause = store.pause(of: habit, on: day) {
                        Text(DayWords.paused(pause, calendar: store.calendar)).font(.footnote).foregroundStyle(.secondary)
                    }
                }
            }
        }
    }

    private var summary: String {
        let names = habits.map(\.name).joined(separator: ", ")
        let back = habits.compactMap { store.pause(of: $0, on: day)?.through }.min()
        return back.map { names + " · back " + DayWords.short($0.adding(days: 1, calendar: store.calendar), calendar: store.calendar) } ?? names
    }
}

/// A failed write: Today shows what's saved and says so (H18, S7). Rare: the Watch's database is its own.
struct SaveProblemBanner: View {
    @Environment(HabitStore.self) private var store

    var body: some View {
        Button { store.problem = nil } label: {
            VStack(alignment: .leading, spacing: 2) {
                Text("Couldn't save that log").font(.headline)
                Text("Today shows what's saved.").font(.footnote).foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .accessibilityIdentifier("save-problem")
    }
}

/// A centred message with its symbol: nothing planned (A5), no habits yet (A7).
struct EmptyStateView: View {
    let symbol: String
    let title: String
    let detail: String

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                Image(systemName: symbol).font(.system(size: 30)).foregroundStyle(.secondary)
                Text(title).font(.headline).multilineTextAlignment(.center)
                Text(detail).font(.footnote).foregroundStyle(.secondary).multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 12)
            .padding(.horizontal, 4)
        }
    }
}

/// The first launch, before the iPhone's first fill has arrived (A6, WA2): what it's waiting for, never "no habits".
struct FirstLaunchView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ProgressView()
                Text("Getting your habits from your iPhone…").font(.headline).multilineTextAlignment(.center)
                Text("Keep it nearby or on Wi-Fi.").font(.footnote).foregroundStyle(.secondary).multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 12)
        }
        .accessibilityIdentifier("first-launch")
    }
}

#if DEBUG
/// Speed runs only: scrolls Today a row at a time down and back up when the driver says so (WatchPerfControl). Its own
/// small view, so the driver's ticks redraw it and never the list (S6).
private struct PerfScroller: View {
    let proxy: ScrollViewProxy
    let ids: [String]
    private let control = WatchPerfControl.shared

    var body: some View {
        Color.clear
            .onChange(of: control.scrollStep) { _, step in
                guard !ids.isEmpty else { return }
                let cycle = max(1, ids.count * 2 - 2)
                let i = step % cycle
                let index = i < ids.count ? i : cycle - i
                withAnimation(.easeOut(duration: 0.1)) { proxy.scrollTo(ids[index], anchor: .center) }
            }
    }
}
#endif
