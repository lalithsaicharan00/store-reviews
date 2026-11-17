import SwiftUI

/// Habits & Tasks › Tasks (Figma's Tasks page 999:1061, 6 Nov 2026): the same page as Habits, read in the same order.
/// One-time | Repeating sits in the bottom bar where Habits has its view and period; tasks have no period, so nothing
/// is beside it. One-time lists tasks by when (Today, Tomorrow, the next days by name, then by month); Repeating by how
/// often. Tasks are done on Today, never here (U38): a row is the task's icon, name, one line and a More button, and a
/// tap opens it. Completed and Archived close the list. The lists are worked out once per change of the data or the
/// day (`TaskLists.make`), never while drawing (S5).
struct TasksPage: View {
    enum Plan: String, CaseIterable, Identifiable {
        case oneTime = "One-time", repeating = "Repeating"
        var id: String { rawValue }
    }

    /// A task just made from Create New or Search: the list shows its kind and scrolls to it (Figma's Task added).
    @Binding var added: UUID?
    @Environment(HabitStore.self) private var store
    @Environment(MenuModel.self) private var menu
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var plan: Plan = .oneTime
    @State private var lists: TaskLists?
    @State private var opened: Habit?
    @State private var editing: Habit?
    @State private var picking: Habit?
    @State private var deleting: Habit?
    @State private var newTask = false
    @State private var banner: TaskBanner?
    @State private var bannerTask: Task<Void, Never>?

    private struct Key: Equatable { let version: Int; let today: LocalDay; let count: Int }

    var body: some View {
        let key = Key(version: store.dataVersion, today: store.today(), count: store.habits.count)
        Group {
            if let lists {
                content(lists)
            } else {
                Color(.systemGroupedBackground)
            }
        }
        .background(Color(.systemGroupedBackground))
        .toolbar { planBar }
        .overlay(alignment: .bottom) { bannerView }
        .onChange(of: key, initial: true) { lists = TaskLists.make(store) }
        .navigationDestination(item: $opened) { HabitPageView(id: $0.id) }
        .navigationDestination(for: CompletedTasksLink.self) { _ in CompletedTasksPage() }
        .navigationDestination(for: ArchivedTasksLink.self) { _ in ArchivedPage(kind: .tasks) }
        .sheet(item: $editing) { EditHabitSheet(habit: $0) }
        .sheet(isPresented: $newTask) {
            NavigationStack { HabitForm(type: .task, onSaved: { id in newTask = false; added = id }) }
        }
        .sheet(item: $picking) { task in
            if let range = store.rescheduleRange(of: task, shownOn: task.dueDay ?? store.today()) {
                RescheduleSheet(range: range, current: task.dueDay ?? store.today(), title: "Pick a Day") { day in
                    picking = nil
                    move(task, to: day)
                }
            }
        }
        .alert("Delete \(deleting?.name ?? "")?", isPresented: Binding { deleting != nil } set: { if !$0 { deleting = nil } },
               presenting: deleting) { task in
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                if banner?.task == task.id { hideBanner() }
                store.delete([task])
            }
        } message: { task in
            Text(task.dueDay == nil
                 ? "It's a repeating task: it goes for good, with every time it was done and its notes. Archiving stops it and keeps its history."
                 : "Its notes are deleted too, and this can't be undone. Archiving keeps it.")
        }
        .onDisappear { bannerTask?.cancel() }
    }

    // MARK: The list

    @ViewBuilder private func content(_ lists: TaskLists) -> some View {
        let groups = plan == .oneTime ? lists.oneTime : lists.repeating
        if groups.isEmpty && (plan == .repeating || (lists.completed == 0 && lists.archived == 0)) {
            ContentUnavailableView {
                Label(plan == .oneTime ? "No Tasks Yet" : "No Repeating Tasks", systemImage: "checkmark.circle")
            } description: {
                Text(plan == .oneTime ? "Tasks you add show here by their day, and on Today when it comes."
                                      : "A task that comes back, like watering the plants every 3 days, shows here. Choose Repeat when you add it.")
            } actions: {
                Button { newTask = true } label: { Text("New Task").foregroundStyle(Color.onInk) }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .controlSize(.large)
                    .tint(.ink)
                    .accessibilityIdentifier("tasks-new")
            }
        } else {
            ScrollViewReader { proxy in
                List {
                    ForEach(groups) { group in
                        Section {
                            ForEach(group.items) { row($0) }
                        } header: {
                            Text(group.title)
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(Color(.label))
                                .textCase(nil)
                        }
                    }
                    if lists.completed > 0 {
                        Section {
                            NavigationLink(value: CompletedTasksLink()) {
                                endRow("checkmark.circle", "Completed", lists.completed == 1 ? "1 task done" : "\(lists.completed) tasks done")
                            }
                            .accessibilityIdentifier("tasks-completed")
                        }
                    }
                    if lists.archived > 0 {
                        Section {
                            NavigationLink(value: ArchivedTasksLink()) {
                                endRow("archivebox.fill", "Archived", lists.archived == 1 ? "1 task" : "\(lists.archived) tasks")
                            }
                            .accessibilityIdentifier("tasks-archived")
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .listSectionSpacing(20)
                // Room at the end for a banner, so it never covers the last row.
                .contentMargins(.bottom, 64, for: .scrollContent)
                .onChange(of: arrival(lists), initial: true) { _, found in
                    guard let found else { return }
                    plan = found.plan
                    Task { @MainActor in
                        withAnimation { proxy.scrollTo(found.id, anchor: .center) }
                        added = nil
                    }
                }
            }
        }
    }

    /// The task just added, once the lists have it, and which tab it's on.
    private func arrival(_ lists: TaskLists) -> TaskArrival? {
        guard let added else { return nil }
        if lists.oneTime.contains(where: { $0.items.contains { $0.id == added } }) { return TaskArrival(id: added, plan: .oneTime) }
        if lists.repeating.contains(where: { $0.items.contains { $0.id == added } }) { return TaskArrival(id: added, plan: .repeating) }
        return nil
    }

    private func row(_ item: TaskLists.Item) -> some View {
        HStack(spacing: 16) {
            Button { opened = item.task } label: {
                HStack(spacing: 16) {
                    HabitIcon(symbol: item.task.symbol, color: item.task.color, size: 32)
                        .opacity(item.done ? 0.45 : 1)
                    VStack(alignment: .leading, spacing: 0) {
                        Text(item.task.name).font(.body)
                            .foregroundStyle(item.done ? Color(.secondaryLabel) : Color(.label))
                            .lineLimit(1)
                        Text(item.line).font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(minHeight: 44)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityIdentifier("task-" + item.task.name)
            more(item)
        }
        .padding(.vertical, 2)
        .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 4))
        .alignmentGuide(.listRowSeparatorLeading) { _ in 48 }
        .id(item.id)
    }

    /// The row's More button (Figma's Menu open): Edit Task, then for a one-time task not done Do Today and Pick a
    /// Day…, or Mark as Not Done once it's done; Duplicate, Archive, and Delete in red.
    private func more(_ item: TaskLists.Item) -> some View {
        let task = item.task
        let today = store.today()
        return Menu {
            Button("Edit Task", systemImage: "pencil") { editing = task }
            if item.done {
                Button("Mark as Not Done", systemImage: "arrow.uturn.backward.circle") {
                    if let day = store.entries(of: task.id).last?.day { store.toggleCheck(task, on: day) }
                }
            } else if let due = task.dueDay {
                if due != today {
                    Button("Do Today", systemImage: "calendar") { doToday(task) }
                }
                Button("Pick a Day…", systemImage: "calendar.badge.clock") { picking = task }
            }
            Button("Duplicate", systemImage: "plus.square.on.square") { duplicate(task) }
            Button("Archive", systemImage: "archivebox") { store.archive([task]) }
            Button("Delete", systemImage: "trash", role: .destructive) { deleting = task }
        } label: {
            Image(systemName: "ellipsis")
                .font(.body)
                .foregroundStyle(Color.ink)
                .frame(width: 44, height: 44)
                .contentShape(Rectangle())
        }
        .accessibilityLabel("More, \(task.name)")
        .accessibilityIdentifier("task-more-" + task.name)
    }

    private func endRow(_ symbol: String, _ title: String, _ subtitle: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: symbol).font(.title3).foregroundStyle(.secondary).frame(width: 32)
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }

    // MARK: The bottom bar

    /// Figma's Bar segmented, centred: One-time | Repeating.
    @ToolbarContentBuilder private var planBar: some ToolbarContent {
        if #available(iOS 26, *) { ToolbarSpacer(.flexible, placement: .bottomBar) }
        ToolbarItem(placement: .bottomBar) {
            Picker("Tasks", selection: $plan) {
                ForEach(Plan.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            .frame(width: 216)
            .accessibilityIdentifier("tasks-plan")
        }
        if #available(iOS 26, *) { ToolbarSpacer(.flexible, placement: .bottomBar) }
    }

    // MARK: Actions

    private func doToday(_ task: Habit) {
        guard var current = store.habits.first(where: { $0.id == task.id }) else { return }
        current.dueDay = store.today()
        store.update(current)
        show(TaskBanner(task: task.id, text: "\(task.name) is on Today", action: .show))
    }

    private func move(_ task: Habit, to day: LocalDay) {
        guard var current = store.habits.first(where: { $0.id == task.id }), let was = current.dueDay else { return }
        current.dueDay = day
        store.update(current)
        let words = day == store.today() ? "Today" : DayWords.short(day, calendar: store.calendar)
        show(TaskBanner(task: task.id, text: "Moved to \(words)", action: .undo(was)))
    }

    private func duplicate(_ task: Habit) {
        var copy = task
        copy.id = UUID()
        copy.createdAt = .now
        copy.steps = task.steps.map { var step = $0; step.id = UUID(); return step }
        copy.reminders = task.reminders.map { var time = $0; time.id = UUID(); return time }
        store.add(copy)
        added = copy.id
        show(TaskBanner(task: copy.id, text: "\(task.name) duplicated", action: .none))
    }

    // MARK: The banner

    private func show(_ next: TaskBanner) {
        withAnimation { banner = next }
        bannerTask?.cancel()
        bannerTask = Task {
            try? await Task.sleep(for: .seconds(4))
            guard !Task.isCancelled else { return }
            hideBanner()
        }
    }

    private func hideBanner() {
        bannerTask?.cancel()
        withAnimation { banner = nil }
    }

    /// Floats 8 above the bottom bar: "Fix the bike light is on Today · Show", "Moved to Fri 30 Oct · Undo".
    @ViewBuilder private var bannerView: some View {
        if let banner {
            Banner(text: banner.text) {
                switch banner.action {
                case .show:
                    Button("Show") {
                        hideBanner()
                        menu.reset()
                    }
                    .accessibilityIdentifier("tasks-banner-show")
                case .undo(let day):
                    Button("Undo") {
                        if var current = store.habits.first(where: { $0.id == banner.task }) {
                            current.dueDay = day
                            store.update(current)
                        }
                        hideBanner()
                    }
                    .accessibilityIdentifier("tasks-banner-undo")
                case .none:
                    EmptyView()
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
            .transition(.opacity.combined(with: .move(edge: .bottom)))
        }
    }
}

private struct TaskArrival: Equatable {
    let id: UUID
    let plan: TasksPage.Plan
}

private struct TaskBanner: Equatable {
    enum Action: Equatable { case show, undo(LocalDay), none }
    let task: UUID
    let text: String
    let action: Action
}

/// Where Completed and Archived go from the Tasks page.
struct CompletedTasksLink: Hashable {}
struct ArchivedTasksLink: Hashable {}

// MARK: - The lists, worked out once

/// The Tasks page's two lists and its end rows, from the store, once per change (Android's `TaskWords`, in iOS's
/// date words). Walking a repeating task to its next day is up to a year of checks, so it never runs while drawing.
@MainActor struct TaskLists {
    struct Item: Identifiable, Equatable {
        let task: Habit
        let line: String
        let done: Bool
        var id: UUID { task.id }
    }

    struct Group: Identifiable, Equatable {
        let title: String
        let items: [Item]
        var id: String { title }
    }

    var oneTime: [Group] = []
    var repeating: [Group] = []
    var completed = 0
    var archived = 0

    static func make(_ store: HabitStore) -> TaskLists {
        let calendar = store.calendar
        let today = store.today()
        let tasks = store.habits.filter { $0.kind == .task }
        var lists = TaskLists()
        lists.archived = tasks.filter(\.archived).count
        lists.completed = CompletedTasks.rows(store).count
        let active = tasks.filter { !$0.archived }

        // One-time: Today (with anything carried from an earlier day, then what's done today, at the end), Tomorrow,
        // the next six days by name, then each month.
        var todayOpen: [Item] = [], todayDone: [Item] = [], tomorrow: [Item] = []
        var days: [(LocalDay, [Item])] = [], months: [(String, LocalDay, [Item])] = []
        let tomorrowDay = today.adding(days: 1, calendar: calendar)
        let week = today.adding(days: 7, calendar: calendar)
        for task in active {
            guard let due = task.dueDay else { continue }
            if let done = store.entries(of: task.id).last {
                // Done on an earlier day: it's on Completed now.
                guard done.day >= today else { continue }
                todayDone.append(Item(task: task, line: "Done " + DayWords.clock(done.createdAt, calendar: calendar), done: true))
                continue
            }
            if due <= today {
                let line = due < today ? "Planned for " + DayWords.short(due, calendar: calendar) : when(task, store)
                todayOpen.append(Item(task: task, line: line, done: false))
            } else if due == tomorrowDay {
                tomorrow.append(Item(task: task, line: when(task, store), done: false))
            } else if due < week {
                let item = Item(task: task, line: when(task, store), done: false)
                if let i = days.firstIndex(where: { $0.0 == due }) { days[i].1.append(item) } else { days.append((due, [item])) }
            } else {
                let date = due.date(calendar: calendar)
                let sameYear = calendar.component(.year, from: date) == calendar.component(.year, from: today.date(calendar: calendar))
                let title = date.formatted(sameYear ? .dateTime.month(.wide) : .dateTime.month(.wide).year())
                let item = Item(task: task, line: DayWords.short(due, calendar: calendar) + " · " + when(task, store), done: false)
                if let i = months.firstIndex(where: { $0.0 == title }) { months[i].2.append(item) } else { months.append((title, due, [item])) }
            }
        }
        // By day, and within a day in the person's own order (U13): nothing sorts itself by time.
        func byDay(_ items: [Item]) -> [Item] {
            items.enumerated().sorted { a, b in
                let x = a.element.task.dueDay, y = b.element.task.dueDay
                if x != y, let x, let y { return x < y }
                return a.offset < b.offset
            }.map(\.element)
        }
        if !todayOpen.isEmpty || !todayDone.isEmpty { lists.oneTime.append(Group(title: "Today", items: byDay(todayOpen) + todayDone)) }
        if !tomorrow.isEmpty { lists.oneTime.append(Group(title: "Tomorrow", items: byDay(tomorrow))) }
        for (day, items) in days.sorted(by: { $0.0 < $1.0 }) {
            lists.oneTime.append(Group(title: DayWords.short(day, calendar: calendar), items: byDay(items)))
        }
        for (title, _, items) in months.sorted(by: { $0.1 < $1.1 }) {
            lists.oneTime.append(Group(title: title, items: byDay(items)))
        }

        // Repeating: by how often, each with what comes next.
        var rhythms: [Rhythm: [Item]] = [:]
        for task in active where task.dueDay == nil {
            rhythms[Rhythm(task.frequency), default: []].append(Item(task: task, line: next(task, store), done: false))
        }
        for rhythm in Rhythm.allCases {
            if let items = rhythms[rhythm], !items.isEmpty { lists.repeating.append(Group(title: rhythm.title, items: items)) }
        }
        return lists
    }

    /// "5:00 PM · Evening", "Morning", "Anytime".
    private static func when(_ task: Habit, _ store: HabitStore) -> String {
        let part = store.section(task.parts.first ?? .anytime).name
        guard let minute = task.dueMinute ?? task.reminders.first?.minuteOfDay else { return part }
        return DaySection.clock(minute) + " · " + part
    }

    /// "Done today", "8:00 AM · Next today", "Every 3 days · Next Sun, 25 Oct".
    private static func next(_ task: Habit, _ store: HabitStore) -> String {
        let calendar = store.calendar
        let today = store.today()
        if store.isDone(task, on: today) && store.isDue(task, on: today) { return "Done today" }
        let rhythm = Rhythm(task.frequency)
        var parts: [String] = []
        if rhythm == .day {
            if let minute = task.dueMinute ?? task.reminders.first?.minuteOfDay { parts.append(DaySection.clock(minute)) }
        } else {
            let words = HabitCopy.rhythm(task.frequency, weekStart: store.settings.weekStart, short: true)
            if !words.isEmpty { parts.append(HabitCopy.capitalized(words)) }
        }
        let due = store.isDue(task, on: today) ? today : store.nextOccurrence(of: task, after: today)
        if let due {
            let words = due == today ? "today" : due == today.adding(days: 1, calendar: calendar) ? "tomorrow"
                : DayWords.short(due, calendar: calendar)
            parts.append("Next " + words)
        }
        return parts.isEmpty ? "Repeats" : parts.joined(separator: " · ")
    }

    /// How often a repeating task comes back (Android's `taskRhythm`).
    enum Rhythm: CaseIterable {
        case day, fewDays, week, month, longer

        var title: String {
            switch self {
            case .day: "Every day"
            case .fewDays: "Every few days"
            case .week: "Every week"
            case .month: "Every month"
            case .longer: "Every few months or longer"
            }
        }

        init(_ frequency: Frequency) {
            switch frequency {
            case .daily: self = .day
            case .everyNDays(let n): self = n <= 1 ? .day : n < 7 ? .fewDays : n < 28 ? .week : .month
            case .weekdays(let days): self = days.count >= 7 ? .day : days.count > 1 ? .fewDays : .week
            case .everyNWeeks(let n): self = n <= 2 ? .week : .month
            case .monthDates: self = .month
            case .calendar(let rule): self = Rhythm(unit: rule.unit, interval: rule.interval, weekdays: rule.weekdays.count)
            case .afterCompletion(let n, let unit): self = Rhythm(unit: unit, interval: n, weekdays: 0)
            case .perWeek: self = .week
            case .perMonth: self = .month
            case .perYear, .flexible: self = .longer
            }
        }

        private init(unit: ScheduleUnit, interval: Int, weekdays: Int) {
            switch unit {
            case .day: self = interval <= 1 ? .day : interval < 7 ? .fewDays : interval < 28 ? .week : .month
            case .week: self = interval == 1 && weekdays > 1 ? .fewDays : interval <= 2 ? .week : .month
            case .month: self = interval <= 1 ? .month : .longer
            case .year: self = .longer
            }
        }
    }
}
