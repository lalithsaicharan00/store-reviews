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
        repeat(2) { if (callDay >= callWeek) { log(call, callDay, 1.0); callDay-- } }
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

    /** Saves the demo habits into an empty test database, then reads them back. */
    suspend fun seed(store: HabitStore, year: Boolean = false, many: Boolean = false) {
        if (store.habits.isNotEmpty()) return
        store.repo.importAll(snapshot(store, store.clock(), year, many))
        store.load()
    }
}
