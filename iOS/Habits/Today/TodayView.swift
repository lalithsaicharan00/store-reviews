import SwiftUI

/// The home screen: today's habits, one card per part of the day.
struct TodayView: View {
    @Environment(HabitStore.self) private var store
    @State private var day: LocalDay?
    /// Parts the user folded or opened by hand; others follow the default rule.
    @State private var foldOverrides: [String: Bool] = [:]
    @State private var showSections = false
    @State private var openSteps: Set<UUID> = []
    @State private var routine: RoutineSession?
    /// The routine player has finished opening over Today. Until it closes, Today draws nothing: its rows,
    /// streaks and toolbar were recalculated behind the player on every tap and tick, which made the player lag
    /// (found by hand 29 Sep).
    @State private var playerCovering = false
    @State private var returnToPart: String?
    @State private var showCalendar = false
    @State private var showNewHabit = false
    /// The habit just added, revealed once the sheet closes.
    @State private var added: UUID?
    /// A row or header to scroll to, and the row that flashes briefly after Add.
    @State private var scrollTarget: String?
    @State private var highlighted: String?
    /// Rows now on screen, so a running timer whose row is out of sight gets the timer bar.
    @State private var visibleRows: Set<String> = []
    @Environment(AppRouter.self) private var router
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        NavigationStack {
            Group {
                if covered {
                    Color(.systemGroupedBackground).ignoresSafeArea()
                } else {
                    // Once a minute (Now moves, a new day starts), and when a running timer reaches its goal so
                    // "N left" and the day bar change on time. A running row ticks its own clock every second;
                    // redrawing the whole list every second made every tap wait (29 Sep).
                    TimelineView(TodaySchedule(goalTimes: goalTimes())) { context in
                        content(now: context.date)
                    }
                }
            }
            .toolbar { if !covered { topBar } }
            .toolbar { if !covered && store.isLoaded && !store.habits.isEmpty { dayBar } }
            .sheet(isPresented: $showCalendar) {
                CalendarSheet(day: selectedDay, today: store.today()) { day = $0 }
                    // Sized to the calendar and solid, so nothing shows through or gets cut off.
                    .presentationDetents([.height(540), .large])
                    .presentationBackground(Color(.systemBackground))
                    .presentationDragIndicator(.visible)
            }
            .fullScreenCover(item: $routine, onDismiss: { playerCovering = false }) { session in
                RoutinePlayer(session: session)
                    .onAppear { playerCovering = true }
            }
            .sheet(isPresented: $showSections) { DaySectionsView() }
            .sheet(isPresented: $showNewHabit, onDismiss: revealAdded) {
                NewItemView { added = $0 }
            }
        }
        #if DEBUG && targetEnvironment(simulator)
        // Launch the actual player directly for visual review in Simulator, using the isolated fixture.
        .task {
            await AppModel.shared.ensureLoaded()
            let arguments = ProcessInfo.processInfo.arguments
            guard store.isLoaded, arguments.contains("-focus-preview"),
                  arguments.contains("-focus-fixture"), routine == nil else { return }
            var habits = store.habits.filter { $0.kind != .quit && !$0.archived }
            if let flag = arguments.firstIndex(of: "-focus-preview-habit"), flag + 1 < arguments.count,
               let position = habits.firstIndex(where: { $0.name == arguments[flag + 1] }) {
                habits = Array(habits[position...]) + Array(habits[..<position])
            }
            routine = RoutineSession(part: .anytime, day: store.today(), habits: habits)
        }
        #endif
        .onChange(of: selectedDay) { foldOverrides = [:] }
        .onChange(of: router.focusSection) {
            // A tapped notification opens today's section.
            guard let section = router.focusSection else { return }
            router.focusSection = nil
            Task {
                if day != nil && day != store.today() { day = nil; try? await Task.sleep(for: .milliseconds(50)) }
                foldOverrides[section] = true
                scrollTarget = Self.headerKey(section)
            }
        }
        .alert("Something went wrong", isPresented: Binding(get: { store.problem != nil }, set: { if !$0 { store.problem = nil } })) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(store.problem ?? "")
        }
    }

    private var selectedDay: LocalDay { day ?? store.today() }
    /// Today comes back the moment the player starts closing, so it's drawn while the cover slides away.
    private var covered: Bool { playerCovering && routine != nil }

    /// When each running timer reaches its goal: the only moments between minutes that Today's counts change.
    private func goalTimes(now: Date = .now) -> [Date] {
        let today = store.today(now: now)
        return store.timers.keys.compactMap { id in
            guard let habit = store.habits.first(where: { $0.id == id }) else { return nil }
            let left = store.goal(of: habit) - store.progress(of: habit, on: today, now: now)
            // Whole seconds, so the same goal gives the same schedule on every redraw.
            return left > 0 ? Date(timeIntervalSinceReferenceDate: now.addingTimeInterval(left * 60).timeIntervalSinceReferenceDate.rounded(.up)) : nil
        }.sorted()
    }
    /// The fold key for the Quitting card; section IDs are UUIDs or fixed words, so this can't clash.
    private static let quitting = "quitting-card"

    /// One row on Today: a habit in one section (a habit ticked per section has one in each).
    struct TodayItem: Identifiable {
        let habit: Habit
        let placement: HabitStore.Placement
        var id: UUID { habit.id }
    }

    private static func rowKey(_ section: String, _ habit: UUID) -> String { "row-\(section)-\(habit.uuidString)" }
    private static func headerKey(_ section: String) -> String { "header-\(section)" }

    /// Each section's rows: timed rows by their earliest time there, then untimed rows in saved order.
    private func rowsBySection(_ habits: [Habit]) -> [String: [TodayItem]] {
        var rows: [String: [(item: TodayItem, index: Int)]] = [:]
        for (index, habit) in habits.enumerated() {
            for placement in store.placements(of: habit) {
                rows[placement.section, default: []].append((TodayItem(habit: habit, placement: placement), index))
            }
        }
        return rows.mapValues { list in
            list.sorted { a, b in
                let ta = a.item.placement.times.first.map { store.dayMinute($0.minuteOfDay) } ?? .max
                let tb = b.item.placement.times.first.map { store.dayMinute($0.minuteOfDay) } ?? .max
                return ta != tb ? ta < tb : a.index < b.index
            }.map(\.item)
        }
    }

    /// After Add: open the new habit's section on today, scroll to it and flash it. If it isn't due
    /// today, the form already said when it first is.
    private func revealAdded() {
        // However the form was closed (Cancel, Add, or swiped away mid-typing), its keyboard goes with it.
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        guard let id = added else { return }
        added = nil
        Task {
            await store.flush()
            guard let habit = store.habits.first(where: { $0.id == id }) else { return }
            let today = store.today()
            if day != nil && day != today {
                day = nil
                try? await Task.sleep(for: .milliseconds(50)) // lets the day change reset the folds first
            }
            let key: String
            if habit.kind == .quit {
                foldOverrides[Self.quitting] = true
                key = Self.rowKey(Self.quitting, id)
            } else {
                guard store.isDue(habit, on: today), let first = store.placements(of: habit).first else { return }
                foldOverrides[first.section] = true
                key = Self.rowKey(first.section, id)
            }
            try? await Task.sleep(for: .milliseconds(250)) // the sheet finishes closing and the row exists
            scrollTarget = key
            if reduceMotion { highlighted = key } else { withAnimation(.easeOut(duration: 0.25)) { highlighted = key } }
            try? await Task.sleep(for: .seconds(1.5))
            if reduceMotion { highlighted = nil } else { withAnimation(.easeIn(duration: 0.4)) { highlighted = nil } }
        }
    }

    @ViewBuilder
    private func content(now: Date) -> some View {
        let today = store.today(now: now)
        let shown = day ?? today
        let isToday = shown == today
        let active = store.habits.filter { !$0.archived && store.startDay(of: $0) <= shown }
        let quitting = active.filter { $0.kind == .quit }
        let tracked = active.filter { $0.kind != .quit && store.isDue($0, on: shown) }
        let nowPart = isToday ? store.nowSection(now: now)?.id : nil

        if !store.isLoaded {
            Color(.systemGroupedBackground).ignoresSafeArea()
        } else if store.habits.isEmpty {
            ContentUnavailableView {
                Label("No habits yet", systemImage: "checklist")
            } description: {
                Text("Add the first thing you want to do every day.")
            } actions: {
                Button { showNewHabit = true } label: {
                    Text("New Habit").fontWeight(.semibold).foregroundStyle(Color.onInk)
                }
                .buttonStyle(.borderedProminent).tint(.ink)
            }
            .background(Color(.systemGroupedBackground))
        } else {
            let rows = rowsBySection(tracked)
            ScrollViewReader { proxy in
            List {
                if isToday && !quitting.isEmpty {
                    // Quitting folds like the other cards, and starts open.
                    let open = foldOverrides[Self.quitting] ?? true
                    Section {
                        PartHeader(title: "Quitting", habits: quitting, left: nil, isNow: false, isOpen: open, onStart: nil,
                                   onToggle: { withAnimation { foldOverrides[Self.quitting] = !open } })
                        if open {
                            ForEach(quitting) { habit in
                                QuitRow(habit: habit, highlighted: highlighted == Self.rowKey(Self.quitting, habit.id))
                                    .id(Self.rowKey(Self.quitting, habit.id))
                            }
                        }
                    }
                }
                ForEach(store.sections) { section in
                    // Times decide the section; a habit ticked per section shows in each of its sections.
                    if let items = rows[section.id], !items.isEmpty {
                        partSection(section.id, items: items, day: shown, isToday: isToday, isNow: section.id == nowPart)
                    }
                }
                Section {
                    Button { showSections = true } label: {
                        Label("Edit Times of Day", systemImage: "rectangle.split.3x1")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.insetGrouped)
            .listSectionSpacing(14)
            .environment(\.defaultMinListRowHeight, 44)
            .contentMargins(.top, 4, for: .scrollContent)
            // Another day is open: one tap back to today, just above the day bar, in the primary style
            // (reviews: people get lost on another date). Its space is kept on today too (invisible), so the
            // list never shifts as ‹ › change the day (the user, 29 Sep). Running timers sit above it, today.
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 8) {
                    if isToday {
                        // A running timer whose row is scrolled away or folded stays in sight here
                        // ("Timing a Habit — Start, See and Stop"). Timers only run today.
                        ForEach(hiddenTimers(), id: \.habit.id) { timer in
                            TimerBar(habit: timer.habit, start: timer.start) { show(timer.habit) }
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                    }
                    // On today the button isn't there at all (so VoiceOver can't find an invisible button, found
                    // by the UI tests 29 Sep); an empty space of its height keeps the list from shifting.
                    ZStack {
                        Color.clear.frame(height: 44)
                        if !isToday {
                            BackToTodayButton { withAnimation { day = nil } }
                                .transition(.opacity)
                        }
                    }
                    .animation(.snappy, value: isToday)
                }
                .padding(.bottom, 6)
            }
            // Today is rebuilt as the player closes; it comes back at the section the routine started from.
            .onAppear {
                guard let part = returnToPart else { return }
                returnToPart = nil
                proxy.scrollTo(Self.headerKey(part), anchor: .center)
            }
            .onChange(of: scrollTarget) {
                guard let target = scrollTarget else { return }
                if reduceMotion { proxy.scrollTo(target, anchor: .center) } else { withAnimation { proxy.scrollTo(target, anchor: .center) } }
                scrollTarget = nil
            }
            }
        }
    }

    private func isDone(_ item: TodayItem, on day: LocalDay) -> Bool {
        // A habit ticked per section is done here once this section's tick is.
        item.placement.slot.map { store.isSlotDone(item.habit, slot: $0, on: day) } ?? store.isSatisfied(item.habit, on: day)
    }

    @ViewBuilder
    private func partSection(_ part: String, items: [TodayItem], day: LocalDay, isToday: Bool, isNow: Bool) -> some View {
        let habits = items.map(\.habit)
        let left = items.filter { !isDone($0, on: day) }.count
        // Default: the Now part and Anytime are open while anything is left; finished parts fold.
        let open = foldOverrides[part] ?? (left > 0 && (isNow || part == .anytime || !isToday))
        Section {
            PartHeader(title: store.section(part).name, habits: habits, left: left, isNow: isNow, isOpen: open,
                       onStart: isToday && items.contains(where: { $0.habit.atMost || !isDone($0, on: day) })
                           ? { start(part: part, items: items, day: day) } : nil,
                       onToggle: { withAnimation { foldOverrides[part] = !open } })
                .id(Self.headerKey(part))
                .contextMenu {
                    Button("Edit Times of Day…", systemImage: "rectangle.split.3x1") { showSections = true }
                    Button(open ? "Fold" : "Open", systemImage: open ? "chevron.up" : "chevron.down") {
                        withAnimation { foldOverrides[part] = !open }
                    }
                }
            if open {
                // Done habits sink to the bottom, keeping their order otherwise.
                let ordered = items.filter { !isDone($0, on: day) } + items.filter { isDone($0, on: day) }
                ForEach(ordered) { item in
                    let habit = item.habit
                    let key = Self.rowKey(part, habit.id)
                    HabitRow(habit: habit, day: day, isToday: isToday, slot: item.placement.slot,
                             time: item.placement.times.first, highlighted: highlighted == key, stepsOpen: stepsBinding(habit))
                        .id(key)
                        .onAppear { if !visibleRows.contains(key) { visibleRows.insert(key) } }
                        .onDisappear { if visibleRows.contains(key) { visibleRows.remove(key) } }
                    if habit.kind == .checklist && openSteps.contains(habit.id) {
                        ForEach(habit.steps) { StepRow(step: $0, habit: habit, day: day) }
                    }
                }
            }
        }
    }

    /// Running timers with no row of theirs on screen, oldest first.
    private func hiddenTimers() -> [(habit: Habit, start: Date)] {
        store.timers
            .compactMap { id, start in store.habits.first { $0.id == id && !$0.archived }.map { ($0, start) } }
            .filter { timer in !visibleRows.contains { $0.hasSuffix(timer.0.id.uuidString) } }
            .sorted { $0.1 < $1.1 }
            .map { (habit: $0.0, start: $0.1) }
    }

    /// From the timer bar: open the timer's section and bring its row into view.
    private func show(_ habit: Habit) {
        let placements = store.placements(of: habit)
        let slot = store.timerSlots[habit.id]
        guard let section = (placements.first { slot != nil && $0.slot == slot } ?? placements.first)?.section else { return }
        withAnimation { foldOverrides[section] = true }
        Task {
            try? await Task.sleep(for: .milliseconds(100)) // the section opens and the row exists
            scrollTarget = Self.rowKey(section, habit.id)
        }
    }

    private func stepsBinding(_ habit: Habit) -> Binding<Bool> {
        Binding(get: { openSteps.contains(habit.id) },
                set: { if $0 { openSteps.insert(habit.id) } else { openSteps.remove(habit.id) } })
    }

    private func start(part: String, items: [TodayItem], day: LocalDay) {
        guard day == store.today() else { return }
        // Limits are check-ins, not completed goals. Include them even with nothing logged.
        let pending = items.filter { $0.habit.atMost || !isDone($0, on: day) }.map(\.habit)
        guard !pending.isEmpty else { return }
        returnToPart = part
        // Close any keyboard still open from a form, so the player doesn't open with its space reserved.
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        routine = RoutineSession(part: part, day: day, habits: pending)
    }

    private func dayLabel(_ day: LocalDay, today: LocalDay) -> String {
        switch day {
        case today: return "Today"
        case today.adding(days: -1, calendar: store.calendar): return "Yesterday"
        case today.adding(days: 1, calendar: store.calendar): return "Tomorrow"
        default: return day.date(calendar: store.calendar).formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated))
        }
    }

    /// The standard bottom toolbar: ‹ · Today ⌄ 6/15 · ›. On iOS 26 each part is its own
    /// Liquid Glass element (Figma 193:6); before iOS 26 it is a plain bottom bar.
    @ToolbarContentBuilder
    private var dayBar: some ToolbarContent {
        let today = store.today()
        let shown = day ?? today
        let summary = store.daySummary(on: shown)
        let label = dayLabel(shown, today: today)
        ToolbarItem(placement: .bottomBar) {
            Button("Previous day", systemImage: "chevron.left") { day = shown.adding(days: -1, calendar: store.calendar) }
        }
        if #available(iOS 26, *) {
            ToolbarSpacer(.flexible, placement: .bottomBar)
            ToolbarItem(placement: .bottomBar) { dayLabelButton(label, done: summary.done, total: summary.total) }
            ToolbarSpacer(.flexible, placement: .bottomBar)
        } else {
            ToolbarItem(placement: .status) { dayLabelButton(label, done: summary.done, total: summary.total) }
        }
        ToolbarItem(placement: .bottomBar) {
            Button("Next day", systemImage: "chevron.right") { day = shown.adding(days: 1, calendar: store.calendar) }
        }
    }

    private func dayLabelButton(_ label: String, done: Int, total: Int) -> some View {
        Button { showCalendar = true } label: {
            DayLabel(label: label, done: done, total: total)
        }
        .accessibilityLabel("\(label), \(done) of \(total) done. Open calendar")
    }

    @ToolbarContentBuilder
    private var topBar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {} label: {
                Image(systemName: "person.fill")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color.onInk)
                    .frame(width: 30, height: 30)
                    .background(Circle().fill(Color.ink))
            }
            .accessibilityLabel("Settings")
        }
        .hidingSharedBackground()
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button("Progress", systemImage: "chart.bar.xaxis") {}
            Button("All habits", systemImage: "checklist") {}
        }
        if #available(iOS 26, *) {
            ToolbarSpacer(.fixed, placement: .topBarTrailing)
        }
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button("Filter", systemImage: "line.3.horizontal.decrease") {}
            Button("New Habit", systemImage: "plus") { showNewHabit = true }
        }
    }
}

private extension ToolbarContent {
    /// iOS 26 groups toolbar items on glass; the avatar sits on its own without it.
    @ToolbarContentBuilder
    func hidingSharedBackground() -> some ToolbarContent {
        if #available(iOS 26, *) {
            self.sharedBackgroundVisibility(.hidden)
        } else {
            self
        }
    }
}

/// Today's redraws: at the start of every minute, and at each running timer's goal time.
struct TodaySchedule: TimelineSchedule {
    let goalTimes: [Date]

    func entries(from startDate: Date, mode: TimelineScheduleMode) -> AnyIterator<Date> {
        var minute = Date(timeIntervalSinceReferenceDate: (startDate.timeIntervalSinceReferenceDate / 60).rounded(.down) * 60)
        var goals = goalTimes.filter { $0 > startDate }[...]
        var first = true
        return AnyIterator {
            if first { first = false; return startDate }
            if minute <= startDate { minute += 60 }
            if let goal = goals.first, goal <= minute {
                goals.removeFirst()
                if goal < minute { return goal }
            }
            defer { minute += 60 }
            return minute
        }
    }
}
