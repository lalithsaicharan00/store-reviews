package com.oftenenough.app.data

import app.habits.core.Snapshot

/**
 * The habits from the design, with some history (the iPhone's `buildDemo`): for test launches, speed runs and screenshots
 * only, never the person's database (D8). [year]: a year of history on every daily habit, missed about one day in nine
 * (the speed runs' "a year of history", S2); [many]: 30 habits and two years (Progress).
 */
object DemoData {
    fun snapshot(store: HabitStore, now: Long, year: Boolean = false, many: Boolean = false): Snapshot {
        val today = store.today(now)
        val dayMs = 86_400_000L
        fun ago(days: Int) = now - days * dayMs
        fun h(name: String, symbol: String, color: HabitColor, kind: HabitKind, parts: List<String> = listOf(DaySection.ANYTIME),
              goal: Double = 1.0, frequency: Frequency = Frequency.Daily, steps: List<Step> = emptyList(), quitSince: Long? = null, created: Int) =
            Habit(name = name, symbol = symbol, color = color, kind = kind, parts = parts, goal = goal, frequency = frequency, steps = steps,
                quitSince = quitSince, createdAt = ago(created), remind = false)

        val smoking = h("Smoking", "nosign", HabitColor.GRAY, HabitKind.Quit, quitSince = now - (12 * 86400 + 11 * 3600 + 23 * 60) * 1000L, created = 60)
        val alcohol = h("Alcohol", "wineglass", HabitColor.GRAY, HabitKind.Quit, quitSince = now - (47 * 86400 + 2 * 3600 + 2 * 60) * 1000L, created = 60)
        val read = h("Read", "book.fill", HabitColor.ORANGE, HabitKind.Duration, goal = 20.0, created = 30)
        val call = h("Call family", "phone.fill", HabitColor.GREEN, HabitKind.Check, frequency = Frequency.PerWeek(3), created = 40)
        val water = h("Water", "drop.fill", HabitColor.BLUE, HabitKind.Amount("glasses", 1.0), goal = 8.0, created = 40)
        val stretch = h("Stretch", "figure.flexibility", HabitColor.TEAL, HabitKind.Duration, listOf(DaySection.MORNING), 10.0, created = 20)
        val skincare = h("Skincare", "sparkles", HabitColor.PURPLE, HabitKind.Checklist, listOf(DaySection.MORNING),
            steps = listOf("Cleanser", "Serum", "Moisturiser", "Sunscreen").map { Step(name = it) }, created = 20)
        val teeth = h("Brush teeth", "mouth.fill", HabitColor.MINT, HabitKind.Duration, listOf(DaySection.MORNING), 2.0, created = 100)
        val meds = h("Meds", "pills.fill", HabitColor.RED, HabitKind.Check, listOf(DaySection.MORNING), created = 70)
        val walk = h("Walk", "figure.walk", HabitColor.GREEN, HabitKind.Amount("steps", 1000.0), listOf(DaySection.AFTERNOON), 8000.0, created = 20)
        val lunch = h("Lunch, no phone", "fork.knife", HabitColor.ORANGE, HabitKind.Check, listOf(DaySection.AFTERNOON), created = 5)
        val floss = h("Floss", "mouth.fill", HabitColor.CYAN, HabitKind.Check, listOf(DaySection.EVENING), created = 40)
        val plan = h("Plan tomorrow", "checklist", HabitColor.INDIGO, HabitKind.Check, listOf(DaySection.EVENING), created = 20)
        val meds2 = h("Meds 14:00", "pills.fill", HabitColor.RED, HabitKind.Check, listOf(DaySection.AFTERNOON), created = 70)
        val noScreens = h("No screens", "iphone.slash", HabitColor.PINK, HabitKind.Check, listOf(DaySection.EVENING), created = 10)
        val meditate = h("Meditate", "figure.mind.and.body", HabitColor.PURPLE, HabitKind.Duration, listOf(DaySection.EVENING), 10.0, created = 30)
        val bed = h("Bed by 23:00", "bed.double.fill", HabitColor.INDIGO, HabitKind.Check, listOf(DaySection.EVENING), created = 10)
        val habits = mutableListOf(smoking, alcohol, read, call, water, stretch, skincare, teeth, meds, walk, lunch, meds2, floss, plan, noScreens, meditate, bed)
        val entries = ArrayList<Entry>()
        fun log(habit: Habit, day: Int, value: Double, stepId: String? = null, at: Long? = null) =
            entries.add(Entry(habitId = habit.id, stepId = stepId, day = day, value = value, createdAt = at ?: (store.rules.dayStart(day) + 12 * 3_600_000L).coerceAtMost(now)))

        for ((habit, streak) in listOf(read to 6, water to 22, stretch to 4, teeth to 90, meds to 58, walk to 13, lunch to 2, floss to 30,
            plan to 11, bed to 5, meds2 to 58, noScreens to 3, meditate to 21)) for (d in 1..minOf(streak, 120)) log(habit, today - d, habit.goal)
        for (d in 1..12) for (s in skincare.steps) log(skincare, today - d, 1.0, s.id)
        val callWeek = store.rules.period(PeriodKind.WEEK, today).first
        for (w in 1..4) for (i in 0 until 3) log(call, callWeek - 7 * w + i, 1.0)
        var callDay = today - 1
        // Two calls this week whatever day it is: on the week's first day both are today's (WidgetDataTest failed on Sundays).
        repeat(2) { i ->
            if (callDay >= callWeek) { log(call, callDay, 1.0); callDay-- }
            else log(call, today, 1.0, at = (store.rules.dayStart(today) + (8 + i) * 3_600_000L).coerceAtMost(now))
        }
        log(smoking, store.today(ago(15)), 1.0, at = ago(15))
        log(alcohol, store.today(ago(47)), 1.0, at = ago(47))
        log(read, today, 12.0, at = now)
        repeat(3) { log(water, today, 1.0, at = now) }
        log(stretch, today, 4.0, at = now)
        log(skincare, today, 1.0, skincare.steps[0].id, at = now)
        log(teeth, today, 2.0, at = now)
        log(meds, today, 1.0, at = now)
        log(walk, today, 5200.0, at = now)

        if (year || many) {
            if (many) {
                val daily = habits.filter { it.kind != HabitKind.Quit && it.frequency.isDayBased }
                var n = 0
                while (habits.size < 30) {
                    val copy = daily[n % daily.size]
                    habits.add(copy.copy(id = newId(), name = (copy.name + " ${n / daily.size + 2}").take(TextLimit.NAME), steps = copy.steps.map { Step(name = it.name) }))
                    n++
                }
            }
            val days = if (many) 730 else 365
            val logged = entries.map { it.habitId + it.day }.toHashSet()
            for (i in habits.indices) {
                if (habits[i].kind == HabitKind.Quit || !habits[i].frequency.isDayBased) continue
                habits[i] = habits[i].copy(createdAt = ago(days + 35))
                val hb = habits[i]
                for (d in 1..days) {
                    if (d % 9 == 0) continue
                    val day = today - d
                    if ((hb.id + day) in logged) continue
                    if (hb.kind == HabitKind.Checklist) hb.steps.forEach { log(hb, day, 1.0, it.id) } else log(hb, day, hb.goal)
                }
            }
        }
        val positioned = habits.mapIndexed { i, hb -> hb.record(i, now) }
        return Snapshot(positioned, habits.flatMap { it.stepRecords() }, emptyList(), entries.map { it.record }, emptyList())
    }

    /**
     * Today exactly as Figma draws it (`1958:2`, "1.1 · Today, full length"): the same habits, logs, streaks and pause, so
     * the phone can be put beside the design (test launches and Debug builds only, D8). Launch with clockHour 9.
     */
    fun design(store: HabitStore, now: Long): Snapshot {
        val today = store.today(now)
        val dayMs = 86_400_000L
        fun ago(days: Int) = now - days * dayMs
        fun h(name: String, symbol: String, color: HabitColor, kind: HabitKind, part: String = DaySection.ANYTIME, goal: Double = 1.0,
              frequency: Frequency = Frequency.Daily, steps: List<Step> = emptyList(), atMost: Boolean = false, reminders: List<ReminderTime> = emptyList(),
              quitSince: Long? = null, dueDay: Int? = null) =
            Habit(name = name, symbol = symbol, color = color, kind = kind, parts = listOf(part), goal = goal, frequency = frequency, steps = steps,
                atMost = atMost, reminders = reminders, remind = reminders.isNotEmpty(), quitSince = quitSince, dueDay = dueDay, createdAt = ago(400))
        val stretch = h("Stretch", "figure.flexibility", HabitColor.TEAL, HabitKind.Duration, DaySection.MORNING, 10.0)
        val skincare = h("Skincare", "sparkles", HabitColor.PURPLE, HabitKind.Checklist, DaySection.MORNING,
            steps = listOf("Cleanser", "Serum", "Moisturiser", "Sunscreen").map { Step(name = it) })
        val meds = h("Meds", "pills.fill", HabitColor.RED, HabitKind.Check, DaySection.MORNING, reminders = listOf(ReminderTime(hour = 8, minute = 0)))
        val walk = h("Walk", "figure.walk", HabitColor.GREEN, HabitKind.Amount("steps", 1000.0), DaySection.AFTERNOON, 10000.0)
        val study = h("Study", "book.fill", HabitColor.ORANGE, HabitKind.Check, DaySection.AFTERNOON)
        val refill = h("Refill water", "drop.fill", HabitColor.BLUE, HabitKind.Check, DaySection.AFTERNOON)
        val vitamins = h("Take vitamins", "pills.fill", HabitColor.GREEN, HabitKind.Check, DaySection.AFTERNOON)
        val bed = h("Bed on time", "moon.fill", HabitColor.INDIGO, HabitKind.Check, DaySection.EVENING)
        val night = h("Skincare (night)", "sparkles", HabitColor.PURPLE, HabitKind.Check, DaySection.EVENING)
        val journal = h("Journal", "book.fill", HabitColor.ORANGE, HabitKind.Check, DaySection.EVENING)
        val read = h("Read", "book.fill", HabitColor.ORANGE, HabitKind.Duration, goal = 20.0)
        val call = h("Call family", "phone.fill", HabitColor.GREEN, HabitKind.Check, goal = 3.0, frequency = Frequency.PerWeek(3))
        val water = h("Water", "drop.fill", HabitColor.BLUE, HabitKind.Amount("glasses", 1.0), goal = 8.0)
        val parcel = h("Pick up parcel", "shippingbox.fill", HabitColor.BROWN, HabitKind.Task, dueDay = today)
        // Smoking: a first run of 30 days, the best of 45, and the current one 19 days and 12 and a half hours.
        val lastSlip = now - (19 * 86400 + 12 * 3600 + 32 * 60 + 45) * 1000L
        val earlier = lastSlip - 45 * dayMs
        val smoking = h("Smoking", "nosign", HabitColor.GRAY, HabitKind.Quit, quitSince = earlier - 30 * dayMs).copy(createdAt = earlier - 30 * dayMs)
        val coffee = h("Coffee", "cup.and.saucer.fill", HabitColor.BROWN, HabitKind.Amount("cups", 1.0), goal = 2.0, atMost = true).copy(createdAt = now)
        val social = h("Social media", "iphone.slash", HabitColor.PINK, HabitKind.Duration, goal = 30.0, atMost = true).copy(createdAt = ago(7))
        val meditate = h("Meditate", "figure.mind.and.body", HabitColor.GREEN, HabitKind.Duration, DaySection.EVENING, 10.0)
        val habits = listOf(stretch, skincare, meds, walk, study, refill, vitamins, bed, night, journal, read, call, water, parcel, smoking, coffee, social, meditate)
        val entries = ArrayList<Entry>()
        fun log(habit: Habit, day: Int, value: Double, stepId: String? = null, at: Long? = null) =
            entries.add(Entry(habitId = habit.id, stepId = stepId, day = day, value = value, createdAt = at ?: (store.rules.dayStart(day) + 12 * 3_600_000L).coerceAtMost(now)))
        for ((habit, streak) in listOf(stretch to 4, meds to 57, read to 6, water to 23, bed to 30, night to 5, journal to 9, study to 2, refill to 3))
            for (d in 1..streak) log(habit, today - d, habit.goal)
        for (d in 1..12) for (step in skincare.steps) log(skincare, today - d, 1.0, step.id)
        val week = store.rules.period(PeriodKind.WEEK, today).first
        for (w in 1..4) for (i in 0 until 3) log(call, week - 7 * w + i, 1.0)
        for (d in 1..7) log(social, today - d, 10.0)
        log(smoking, store.today(lastSlip), 1.0, at = lastSlip)
        log(smoking, store.today(earlier), 1.0, at = earlier)
        log(stretch, today, 4.0, at = now)
        log(skincare, today, 1.0, skincare.steps[0].id, at = now)
        log(meds, today, 1.0, at = now)
        log(read, today, 12.0, at = now)
        log(call, week, 1.0, at = now)
        log(call, week, 1.0, at = now)
        repeat(8) { log(water, today, 1.0, at = now) }
        val positioned = habits.mapIndexed { i, hb -> hb.record(i, now) }
        // Figma's order: the times of day, then Anytime, then Quitting.
        val order = app.habits.core.SettingRecord(HabitStore.Keys.CARD_ORDER, SwiftJson.strings(listOf(DaySection.MORNING, DaySection.AFTERNOON,
            DaySection.EVENING, DaySection.ANYTIME, DaySection.QUITTING)))
        return Snapshot(positioned, habits.flatMap { it.stepRecords() }, habits.flatMap { it.reminderRecords() }, entries.map { it.record }, listOf(order))
    }

    /**
     * One habit for each of Day details' states (Figma `2308:2`): a test launch's `demo days` (D8: never the person's).
     * Take vitamins is 13 days in a row and Floss 29, so one Mark done reaches a milestone (the ribbon) or a landmark
     * (the pop-up); Run isn't planned today (a Sunday).
     */
    fun days(store: HabitStore, now: Long): Snapshot {
        val today = store.today(now)
        val dayMs = 86_400_000L
        fun h(name: String, symbol: String, color: HabitColor, kind: HabitKind, goal: Double = 1.0, frequency: Frequency = Frequency.Daily,
              part: String = DaySection.ANYTIME, steps: List<Step> = emptyList(), atMost: Boolean = false, quitSince: Long? = null, dueDay: Int? = null) =
            Habit(name = name, symbol = symbol, color = color, kind = kind, parts = listOf(part), goal = goal, frequency = frequency, steps = steps,
                atMost = atMost, quitSince = quitSince, dueDay = dueDay, remind = false, createdAt = now - 120 * dayMs)
        val water = h("Water", "drop.fill", HabitColor.BLUE, HabitKind.Amount("glasses", 1.0), 8.0)
        val read = h("Read", "book.fill", HabitColor.ORANGE, HabitKind.Duration, 20.0)
        val vitamins = h("Take vitamins", "checkmark", HabitColor.YELLOW, HabitKind.Check)
        val floss = h("Floss", "mouth.fill", HabitColor.CYAN, HabitKind.Check)
        val breaks = h("Stretch breaks", "plus", HabitColor.BLUE, HabitKind.Check, 3.0)
        val call = h("Call family", "phone.fill", HabitColor.GREEN, HabitKind.Check, 3.0, Frequency.PerWeek(3))
        val clean = h("Deep clean", "house.fill", HabitColor.RED, HabitKind.Check, 4.0, Frequency.PerMonth(4))
        val gym = h("Gym", "dumbbell.fill", HabitColor.RED, HabitKind.Check, 1.0, Frequency.Flexible(GoalPeriod.WEEK, 3))
        val run = h("Run", "figure.run", HabitColor.TEAL, HabitKind.Check, 1.0, Frequency.Weekdays(setOf(2, 4, 6)), DaySection.MORNING)
        val desk = h("Tidy desk", "sparkles", HabitColor.TEAL, HabitKind.Checklist, steps = listOf("Clear papers", "Wipe the surface", "Put pens away").map { Step(name = it) })
        val smoking = h("Smoking", "nosign", HabitColor.GRAY, HabitKind.Quit, quitSince = now - 21 * dayMs)
        val coffee = h("Coffee", "cup.and.saucer.fill", HabitColor.BROWN, HabitKind.Amount("cups", 1.0), 2.0, atMost = true)
        val social = h("Social media", "iphone", HabitColor.PINK, HabitKind.Duration, 30.0, atMost = true)
        val bill = h("Pay the phone bill", "calendar", HabitColor.BLUE, HabitKind.Task, dueDay = today)
        val meditate = h("Meditate", "figure.mind.and.body", HabitColor.GREEN, HabitKind.Duration, 10.0)
        val pushups = h("Push-ups", "figure.strengthtraining.traditional", HabitColor.GREEN, HabitKind.Amount("push-ups", 20.0), 300.0, Frequency.PerWeek(1))
        val savings = h("Savings", "banknote.fill", HabitColor.GREEN, HabitKind.Amount("$", 0.0), 500.0, Frequency.PerMonth(1))
        val piano = h("Piano", "pianokeys", HabitColor.PURPLE, HabitKind.Duration, 180.0, Frequency.PerWeek(1), DaySection.EVENING)
        val habits = listOf(water, read, vitamins, floss, breaks, call, clean, gym, run, desk, smoking, coffee, social, bill, meditate, pushups, savings, piano)
        val entries = ArrayList<Entry>()
        fun at(day: Int, hour: Int, minute: Int = 0) = (store.rules.dayStart(day) + (hour * 60 + minute) * 60_000L).coerceAtMost(now)
        fun log(habit: Habit, day: Int, value: Double, time: Long = at(day, 12), stepId: String? = null, source: EntrySource? = EntrySource.TODAY) =
            entries.add(Entry(habitId = habit.id, stepId = stepId, day = day, value = value, createdAt = time, source = source))
        for (d in 1..13) log(vitamins, today - d, 1.0)
        for (d in 1..29) log(floss, today - d, 1.0)
        for (d in 1..20) log(water, today - d, 8.0)
        for (d in 1..6) log(read, today - d, 20.0)
        for ((hh, mm) in listOf(7 to 45, 9 to 10)) log(water, today, 1.0, at(today, hh, mm))
        log(water, today, 1.0, at(today, 9, 20), source = EntrySource.MANUAL)
        log(water, today, 1.0, at(today, 9, 25))
        log(read, today, 12 + 34 / 60.0, at(today, 7, 40), source = EntrySource.TIMER)
        log(breaks, today, 1.0, at(today, 7, 30)); log(breaks, today, 1.0, at(today, 9, 0))
        log(call, today, 1.0, at(today, 8, 40))
        log(clean, today, 1.0, at(today, 8, 20))
        log(desk, today, 1.0, at(today, 8, 0), desk.steps[0].id); log(desk, today, 1.0, at(today, 8, 5), desk.steps[1].id)
        val week = store.rules.period(PeriodKind.WEEK, today).first
        for (d in week until today) log(pushups, d, 20.0)
        log(pushups, today, 20.0, at(today, 7, 30)); log(pushups, today, 20.0, at(today, 9, 0))
        val month = store.rules.period(PeriodKind.MONTH, today).first
        log(savings, maxOf(month, today - 5), 200.0, source = EntrySource.MANUAL)
        log(savings, today, 50.0, at(today, 9, 20), source = EntrySource.MANUAL)
        log(piano, maxOf(week, today - 1), 60.0, source = EntrySource.TIMER)
        log(piano, today, 30.0, at(today, 8, 0), source = EntrySource.TIMER)
        log(smoking, today - 21, 1.0, now - 21 * dayMs)
        val positioned = habits.mapIndexed { i, hb -> hb.record(i, now) }
        return Snapshot(positioned, habits.flatMap { it.stepRecords() }, emptyList(), entries.map { it.record }, emptyList())
    }

    /** Saves the demo habits into an empty test database, then reads them back. */
    suspend fun seed(store: HabitStore, year: Boolean = false, many: Boolean = false, design: Boolean = false, days: Boolean = false) {
        if (store.habits.isNotEmpty()) return
        store.repo.importAll(when {
            days -> days(store, store.clock())
            design -> design(store, store.clock())
            else -> snapshot(store, store.clock(), year, many)
        })
        store.load()
        if (days) store.habits.firstOrNull { it.name == "Meditate" }?.let { store.pause(it, store.today(), store.today() + 6) }
        if (design) {
            store.habits.firstOrNull { it.name == "Meditate" }?.let { store.pause(it, store.today(), store.today() + 6) }
        }
    }
}
