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
    /// The time Today is drawn for; `tick()` moves it on (a minute, or a timer's goal time).
    @State private var clock = Date.now
    @Environment(\.scenePhase) private var scenePhase

    @State private var showCalendar = false
    @State private var showNewHabit = false
    @State private var showFilter = false
    /// The group Today shows ("" is All), remembered when the app reopens (Navigation, Round 3; groups spec §2).
    @AppStorage(GroupFilter.today) private var groupRaw = ""
    /// The habit just added, revealed once the sheet closes.
    @State private var added: UUID?
    /// A row or header to scroll to, and the row that flashes briefly after Add.
    @State private var scrollTarget: String?
    @State private var highlighted: String?
    /// Rows now on screen, so a running timer whose row is out of sight gets the timer bar.
    /// Kept outside Today's own state: only the timer bars read it, so a row scrolling in or out redraws them,
    /// not every section (30 Sep).
    @State private var visibleRows = VisibleRows()
    @Environment(AppRouter.self) private var router
    /// The ≡ menu. Today only writes to it (opening it) and follows its navigation path; it never reads whether the
    /// menu is open, so the menu sliding over Today doesn't redraw Today (`Docs/Checklists/Sidebar Menu.md`).
    @Environment(MenuModel.self) private var menu
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        NavigationStack(path: Bindable(menu).path) {
            Group {
                if covered {
                    Color(.systemGroupedBackground).ignoresSafeArea()
                } else {
                    // Once a minute (Now moves, a new day starts), and when a running timer reaches its goal so
                    // "N left" and the day bar change on time. A running row ticks its own clock every second;
                    // redrawing the whole list every second made every tap wait (29 Sep). A plain clock, not a
                    // TimelineView: one around the list marked every row changed on every scroll frame (30 Sep).
                    content(now: clock)
                        .task(id: goalTimes()) { await tick() }
                }
            }
            .toolbar { if !covered { topBar } }
            // Every place in the ≡ menu is pushed here, so Back and the edge swipe return to Today.
            .navigationDestination(for: MenuPlace.self) { MenuPage(place: $0) }
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
            .sheet(isPresented: $showFilter) {
                FilterSheet(day: selectedDay, selection: $groupRaw)
                    .presentationBackground(Color(.systemBackground))
                    .presentationDragIndicator(.visible)
            }

            .sheet(isPresented: $showNewHabit, onDismiss: revealAdded) {
                NewItemView(group: filterGroup) { added = $0 }
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
        // Back from the background: Today is drawn for now at once, not at the next minute.
        .onChange(of: scenePhase) { if scenePhase == .active { clock = .now } }
        .onChange(of: router.showDay) {
            // Progress's Day sheet: "Show on Today" has closed Progress; open that day here, where logging happens.
            guard let shown = router.showDay else { return }
            router.showDay = nil
            day = shown == store.today() ? nil : shown
        }
        .onChange(of: router.focusSection) {
            // A tapped notification opens today's section.
            guard let section = router.focusSection else { return }
            router.focusSection = nil
            // Back to Today itself first: the menu closes and any page it opened goes. The whole day shows, so the
            // section's habits aren't hidden by a group filter.
            menu.reset()
            groupRaw = ""
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
    /// The group Today is filtered to; nil is All (a deleted group reads as All).
    private var filterGroup: UUID? { store.existingGroup(groupRaw) }

    /// The note bar for a habit's note or the day's note.
    @ViewBuilder private func noteBar(_ target: HabitStore.NoteTarget) -> some View {
        let dayText = NoteSheet.dayText(target.day, today: store.today(), calendar: store.calendar)
        let close = {
            withAnimation(.snappy) {
                store.noteTarget = nil
                if let id = target.habit, store.noteOffer == .init(habit: id, day: target.day) { store.noteOffer = nil }
            }
        }
        if let id = target.habit, let habit = store.habits.first(where: { $0.id == id }) {
            NoteBar(title: habit.name + " · " + dayText, initial: store.note(of: habit, on: target.day) ?? "",
                    onSave: { store.setNote($0, of: habit, on: target.day) }, onClose: close)
                .id(id.uuidString + target.day.key)
        } else {
            NoteBar(title: "Note for the day · " + dayText, initial: store.dayNote(on: target.day) ?? "",
                    onSave: { store.setDayNote($0, on: target.day) }, onClose: close)
                .id("day" + target.day.key)
        }
    }
    /// Today comes back the moment the player starts closing, so it's drawn while the cover slides away.
    private var covered: Bool { playerCovering && routine != nil }

    /// Moves `clock` on at each of `TodaySchedule`'s moments until Today is covered or the goal times change.
    private func tick() async {
        clock = .now
        while !Task.isCancelled {
            var moments = TodaySchedule(goalTimes: goalTimes()).entries(from: .now, mode: .normal)
            _ = moments.next() // the start itself
            guard let next = moments.next() else { return }
            try? await Task.sleep(for: .seconds(max(0.05, next.timeIntervalSinceNow)))
            if Task.isCancelled { return }
            clock = .now
        }
    }

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
    private static let pausedCard = "paused-card"

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
            // Put in another group than the one shown (or none): show everything, so it doesn't seem lost.
            if !store.isInGroup(habit, filterGroup) { groupRaw = "" }
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
        // A group filter shows only that group's habits, in every card (groups spec §2); All shows everything.
        let group = filterGroup
        let active = store.habits.filter { !$0.archived && store.startDay(of: $0) <= shown && store.isInGroup($0, group) }
        let quitting = active.filter { $0.kind == .quit && !store.isPaused($0, on: today) }
        // Paused habits leave their cards for one folded card at the bottom, so they're never lost (pause report).
        let paused = active.filter { store.isPaused($0, on: shown) && ($0.kind != .quit || isToday) }
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
                // Filtered to a group with nothing on this day: say so, with the way back (report 18).
                if let group, let shownGroup = store.groups.first(where: { $0.id == group }),
                   tracked.isEmpty && quitting.isEmpty && paused.isEmpty {
                    Section {
                        VStack(spacing: 10) {
                            Text("Nothing from \(shownGroup.name) on this day.")
                                .foregroundStyle(.secondary)
                                .accessibilityIdentifier("group-empty-day")
                            Button("Show All") { withAnimation { groupRaw = "" } }
                                .buttonStyle(.bordered)
                                .accessibilityIdentifier("group-show-all")
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                    }
                }
                // The day's note, when there is one: context for the whole day, above its habits (notes report).
                if shown <= today, let note = store.dayNote(on: shown) {
                    Section {
                        Button { store.noteTarget = .init(habit: nil, day: shown) } label: {
                            Label { Text(note).foregroundStyle(Color.primary).multilineTextAlignment(.leading) }
                                icon: { Image(systemName: "note.text").foregroundStyle(.secondary) }
                        }
                        .accessibilityHint("Edit the note for the day")
                        .accessibilityIdentifier("day-note")
                    }
                }
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
                if !paused.isEmpty {
                    let open = foldOverrides[Self.pausedCard] ?? false
                    Section {
                        PartHeader(title: "Paused", habits: paused, left: nil, isNow: false, isOpen: open, onStart: nil,
                                   onToggle: { withAnimation { foldOverrides[Self.pausedCard] = !open } })
                            .accessibilityIdentifier("paused-card")
                        if open {
                            ForEach(paused) { habit in
                                PausedRow(habit: habit, day: shown)
                                    .id(Self.rowKey(Self.pausedCard, habit.id))
                            }
                        }
                    }
                }
                Section {
                    HStack(spacing: 20) {
                        if shown <= today && store.dayNote(on: shown) == nil {
                            Button { store.noteTarget = .init(habit: nil, day: shown) } label: {
                                Label("Note for the Day", systemImage: "note.text")
                            }
                            .accessibilityIdentifier("add-day-note")
                        }
                        Button { showSections = true } label: {
                            Label("Edit Times of Day", systemImage: "rectangle.split.3x1")
                        }
                    }
                    .buttonStyle(.borderless)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.insetGrouped)
            // The filter is always obvious, and one tap clears it (Day Structure report §2.8: no hidden habits). Pinned
            // above the list, so it stays in sight while scrolling. Not a list row: a row holding one button made the
            // whole row that button, so a tap beside the chip did nothing (GroupsUITests on CI, 1 Oct 2026).
            .safeAreaInset(edge: .top, spacing: 0) {
                if let group, let shownGroup = store.groups.first(where: { $0.id == group }) {
                    GroupFilterBar(group: shownGroup) { withAnimation { groupRaw = "" } }
                }
            }
            .listSectionSpacing(14)
            .environment(\.defaultMinListRowHeight, 44)
            .contentMargins(.top, 4, for: .scrollContent)
            // Another day is open: one tap back to today, just above the day bar, in the primary style
            // (reviews: people get lost on another date). Its space is kept on today too (invisible), so the
            // list never shifts as ‹ › change the day (the user, 29 Sep). Running timers sit above it, today.
            .safeAreaInset(edge: .bottom) {
                if let target = store.noteTarget {
                    // Writing a note: the bar sits above the keyboard, the row stays in view above it.
                    noteBar(target)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                } else {
                VStack(spacing: 8) {
                    if isToday {
                        // A running timer whose row is scrolled away or folded stays in sight here
                        // ("Timing a Habit — Start, See and Stop"). Timers only run today.
                        HiddenTimerBars(visible: visibleRows) { show($0) }
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
            }
            // The row the note is for scrolls into view above the note bar.
            .onChange(of: store.noteTarget) {
                guard let target = store.noteTarget, let id = target.habit,
                      let habit = store.habits.first(where: { $0.id == id }) else { return }
                let key = store.isPaused(habit, on: target.day) ? Self.rowKey(Self.pausedCard, id)
                    : habit.kind == .quit ? Self.rowKey(Self.quitting, id)
                    : store.placements(of: habit).first.map { Self.rowKey($0.section, id) }
                guard let key else { return }
                Task {
                    try? await Task.sleep(for: .milliseconds(350)) // after the keyboard has come up
                    withAnimation { proxy.scrollTo(key, anchor: .bottom) }
                }
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
                // Done habits sink to the bottom, keeping their order otherwise. The row just logged stays put while it
                // offers "Add note" (or its note is being written), so the offer is where the person is looking.
                let held = store.noteOffer.flatMap { $0.day == day ? $0.habit : nil }
                let ordered = items.filter { !isDone($0, on: day) || $0.habit.id == held }
                    + items.filter { isDone($0, on: day) && $0.habit.id != held }
                ForEach(ordered) { item in
                    let habit = item.habit
                    let key = Self.rowKey(part, habit.id)
                    HabitRow(habit: habit, day: day, isToday: isToday, slot: item.placement.slot,
                             time: item.placement.times.first, highlighted: highlighted == key, stepsOpen: stepsBinding(habit))
                        .id(key)
                        .onAppear { visibleRows.show(key) }
                        .onDisappear { visibleRows.hide(key) }
                    if habit.kind == .checklist && openSteps.contains(habit.id) {
                        ForEach(habit.steps) { StepRow(step: $0, habit: habit, day: day) }
                    }
                }
            }
        }
    }

    /// From the timer bar: open the timer's section and bring its row into view.
    private func show(_ habit: Habit) {
        // Its row may be filtered out: show everything so the row is there.
        if !store.isInGroup(habit, filterGroup) { groupRaw = "" }
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

    /// ≡ · Filter · +. Progress, Habits, Tasks and every setting live in the ≡ menu (the user's final decision,
    /// 30 Sep 2026). Filter is Apple Mail's circled symbol, so it can't be mistaken for ≡ (Navigation, Round 3).
    @ToolbarContentBuilder
    private var topBar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button("Menu", systemImage: "line.3.horizontal") {
                menu.setOpen(true, reduceMotion: reduceMotion)
            }
            .accessibilityIdentifier("menu-button")
        }
        ToolbarItemGroup(placement: .topBarTrailing) {
            // Filled while a group is chosen, so a filtered Today never passes for the whole day.
            let shownGroup = filterGroup.flatMap { id in store.groups.first { $0.id == id } }
            Button("Filter", systemImage: shownGroup == nil ? "line.3.horizontal.decrease.circle" : "line.3.horizontal.decrease.circle.fill") {
                showFilter = true
            }
            .accessibilityValue(shownGroup?.name ?? "")
            .accessibilityIdentifier("filter-button")
            Button("New Habit", systemImage: "plus") { showNewHabit = true }
        }
    }
}

/// "● Health ✕" above Today's list while a group is chosen: tap to show everything again.
private struct GroupFilterBar: View {
    let group: HabitGroup
    let onClear: () -> Void

    var body: some View {
        HStack {
            Button(action: onClear) {
                HStack(spacing: 6) {
                    Circle().fill(group.color.color).frame(width: 9, height: 9)
                    Text(group.name).lineLimit(1)
                    Image(systemName: "xmark").font(.caption.weight(.bold))
                }
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color.onInk)
                .padding(.horizontal, 12)
                .frame(minHeight: 32)
                .background(Color.ink, in: Capsule())
                .contentShape(Capsule())
            }
            .buttonStyle(.plain)
            .frame(minHeight: 44)
            .accessibilityLabel("Showing \(group.name) only")
            .accessibilityHint("Shows all habits")
            .accessibilityIdentifier("group-filter-chip")
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 20)
        .background(Color(.systemGroupedBackground))
    }
}

/// The rows now on screen, so a running timer whose row is out of sight gets the timer bar.
@Observable final class VisibleRows {
    private(set) var keys: Set<String> = []
    func show(_ key: String) { if !keys.contains(key) { keys.insert(key) } }
    func hide(_ key: String) { if keys.contains(key) { keys.remove(key) } }
}

/// Running timers with no row of theirs on screen, oldest first, each as a bar above the day bar.
private struct HiddenTimerBars: View {
    let visible: VisibleRows
    let onShow: (Habit) -> Void
    @Environment(HabitStore.self) private var store

    var body: some View {
        let timers = store.timers
            .compactMap { id, start in store.habits.first { $0.id == id && !$0.archived }.map { (habit: $0, start: start) } }
            .filter { timer in !visible.keys.contains { $0.hasSuffix(timer.habit.id.uuidString) } }
            .sorted { $0.start < $1.start }
        ForEach(timers, id: \.habit.id) { timer in
            TimerBar(habit: timer.habit, start: timer.start) { onShow(timer.habit) }
                .transition(.move(edge: .bottom).combined(with: .opacity))
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
