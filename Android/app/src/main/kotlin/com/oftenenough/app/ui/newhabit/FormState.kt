package com.oftenenough.app.ui.newhabit

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import com.oftenenough.app.data.DaySection
import com.oftenenough.app.data.GoalPeriod
import com.oftenenough.app.data.Habit
import com.oftenenough.app.data.HabitColor
import com.oftenenough.app.data.HabitCopy
import com.oftenenough.app.data.HabitKind
import com.oftenenough.app.data.HabitPlan
import com.oftenenough.app.data.HabitStore
import com.oftenenough.app.data.HowOften
import com.oftenenough.app.data.OftenDraft
import com.oftenenough.app.data.ReminderTime
import com.oftenenough.app.data.Step
import com.oftenenough.app.data.TextLimit
import com.oftenenough.app.data.newId
import com.oftenenough.app.ui.onboarding.HabitIdea
import com.oftenenough.app.ui.record.GoalNumber
import com.oftenenough.app.ui.theme.HabitIcons

/** One reminder on the form; [part] is the time of day it belongs to (null: Anytime). */
data class DraftTime(val id: String = newId(), val minute: Int, val part: String?)

/**
 * Everything the New Habit form holds while it's open (the iPhone's `HabitForm` state), surviving its pages. [makeHabit]
 * is the one place the habit is built, so the preview, the sentence and what's saved always agree.
 */
class FormState(initialType: ItemType, val original: Habit?, private val store: HabitStore, template: Habit? = null) {
    /** Where the form's values come from: the habit being edited, or the one being duplicated (Habits, Figma 2.2). */
    private val from: Habit? = original ?: template
    /** The kind of habit. Edit can change it (Figma 6.3): saving then starts the habit over, after asking. */
    var type by mutableStateOf(initialType)
    /** The name as the previews show it: it catches up when typing pauses (S11); saving reads the live field. */
    var name by mutableStateOf(original?.name ?: template?.let { TextLimit.clean("${it.name} (copy)", TextLimit.NAME) } ?: "")
    /** Whether the live field has a name: changes only when it becomes empty or not, so Add follows at once. */
    var nameFilled by mutableStateOf(name.isNotBlank())
    var description by mutableStateOf(from?.let { store.descriptions[it.id] } ?: "")
    var reminderWords by mutableStateOf(from?.reminderText ?: "")
    /** Tell me at milestones (quit and cut down; Figma N.1): off until the person turns it on. */
    var milestoneAlerts by mutableStateOf(from?.let { store.setting(com.oftenenough.app.app.reminders.MilestoneAlerts.key(it.id)) == "true" } ?: false)
    private val originalAlerts = milestoneAlerts
    var symbol by mutableStateOf(from?.symbol ?: when (initialType) { ItemType.QUIT -> "nosign"; ItemType.TASK -> "calendar"; else -> "star.fill" })
    var pickedSymbol by mutableStateOf(from != null)
    var color by mutableStateOf(from?.color ?: store.suggestedColor())
    var amountText by mutableStateOf("")
    var unit by mutableStateOf("")
    var hours by mutableStateOf("")
    var minutes by mutableStateOf("")
    var step by mutableStateOf<Double?>(null)
    var asks by mutableStateOf(false)
    var often by mutableStateOf(OftenDraft())
    var taskRepeats by mutableStateOf(false)
    var items by mutableStateOf<List<Step>>(from?.steps ?: emptyList())
    var quitSince by mutableStateOf(original?.let { it.quitSince ?: it.createdAt } ?: store.clock())
    var taskDate by mutableStateOf(store.today())
    /** No date (Tasks, Figma 6.2): it stays on the Tasks page and never shows on Today until it has a day. */
    val taskHasNoDate: Boolean get() = type == ItemType.TASK && !taskRepeats && taskDate == com.oftenenough.app.data.NO_DATE_DAY
    var taskHasTime by mutableStateOf(false)
    var taskMinute by mutableStateOf(9 * 60)
    var timesOfDay by mutableStateOf(from?.parts?.ifEmpty { listOf(DaySection.ANYTIME) } ?: listOf(DaySection.ANYTIME))
    var remindOn by mutableStateOf(from?.let { it.remind && it.reminders.isNotEmpty() } ?: false)
    var times by mutableStateOf<List<DraftTime>>(from?.reminders?.map { DraftTime(if (original != null) it.id else newId(), it.minuteOfDay, null) } ?: emptyList())
    var remindersEdited by mutableStateOf(from != null)
    var startDate by mutableStateOf(original?.let { it.startsOn ?: store.rules.calendarDayOf(it.createdAt) } ?: store.today())
    var hasEnd by mutableStateOf(original?.endsOn != null)
    var endDate by mutableStateOf(original?.endsOn ?: store.today())
    var alert by mutableStateOf(from?.alert ?: "notification")
    var followUp by mutableStateOf(from?.followUpMinutes)
    var groupId by mutableStateOf(from?.let { store.groupOf(it.id)?.id })
    private val originalGroup = groupId
    private val originalDescription = description

    init {
        val o = from
        if (o != null) {
            when (val k = o.kind) {
                is HabitKind.Amount -> { amountText = GoalNumber.text(o.goal); unit = k.unit; step = k.increment.takeIf { it > 0 }; asks = k.increment <= 0 }
                HabitKind.Duration -> if (o.atMost) { amountText = GoalNumber.text(o.goal); unit = HabitPlan.TIME_UNIT }
                    else { hours = (o.goal.toInt() / 60).takeIf { it > 0 }?.toString() ?: ""; minutes = (o.goal.toInt() % 60).toString().padStart(2, '0') }
                else -> {}
            }
            often = OftenDraft().seed(startDate, store.weekStart).choose(HowOften.of(o))
            taskRepeats = o.kind == HabitKind.Task && o.dueDay == null
            o.dueDay?.let { taskDate = it }
            o.dueMinute?.let { taskHasTime = true; taskMinute = it }
            times = times.map { it.copy(part = partFor(it.minute)) }
        } else {
            often = OftenDraft().seed(store.today(), store.weekStart)
            if (initialType != ItemType.QUIT) syncReminders(force = true)
        }
    }

    fun applyIdea(idea: HabitIdea) {
        name = idea.name
        nameFilled = true
        symbol = HabitIcons.suggest(idea.name) ?: idea.symbol
        often = when (idea.name) { "Exercise" -> often.choose(HowOften.Times(GoalPeriod.WEEK, 3)); else -> often.choose(HowOften.EveryDay) }
    }

    val editing: Boolean get() = original != null
    /** Edit chose another kind: saving starts the habit over (Figma 6.3.1, 6.4.2). */
    val typeChanged: Boolean get() = original != null && type != ItemType.of(original)

    /** Another kind chosen in Edit: what the new kind needs starts from a sensible place (Time it: 10 min, Figma 6.3.1). */
    fun changeType(to: ItemType) {
        if (to == type) return
        type = to
        if (to == ItemType.TIME && (hours.toIntOrNull() ?: 0) == 0 && (minutes.toIntOrNull() ?: 0) == 0) { hours = ""; minutes = "10" }
        if (to == ItemType.AMOUNT || to == ItemType.CUT_DOWN) { if (GoalNumber.parse(amountText) == null) amountText = "" }
        if (to == ItemType.CUT_DOWN && timesOfDay != listOf(DaySection.ANYTIME)) timesOfDay = listOf(DaySection.ANYTIME)
    }
    val weekStart: Int get() = store.weekStart
    val originalGroupId: String? get() = originalGroup
    val isHabit: Boolean get() = type.isBuild || type == ItemType.CUT_DOWN
    val hasAmount: Boolean get() = type == ItemType.AMOUNT || type == ItemType.TIME || type == ItemType.CUT_DOWN
    val timed: Boolean get() = type == ItemType.TIME
    val trimmedName: String get() = TextLimit.clean(name, TextLimit.NAME)
    val filledItems: List<Step> get() = items.mapNotNull { s -> TextLimit.clean(s.name, TextLimit.CHECKLIST_PART).takeIf { it.isNotEmpty() }?.let { Step(s.id, it) } }
    val remind: Boolean get() = remindOn && times.isNotEmpty()

    /** A time amount can't be longer than its period. */
    val amountPeriod: GoalPeriod get() = (often.often(true) as? HowOften.Total)?.takeIf { often.choice == OftenDraft.Choice.TOTAL }?.period ?: GoalPeriod.DAY

    val amountValue: Double? get() {
        if (!hasAmount) return null
        if (timed) {
            val h = hours.trim().ifEmpty { "0" }.toIntOrNull() ?: return null
            val m = minutes.trim().ifEmpty { "0" }.toIntOrNull() ?: return null
            if (m >= 60 || h < 0 || m < 0) return null
            val total = (h * 60 + m).toDouble()
            val max = when (amountPeriod) { GoalPeriod.DAY -> 24 * 60.0; GoalPeriod.WEEK -> 7 * 24 * 60.0; GoalPeriod.MONTH -> 31 * 24 * 60.0; GoalPeriod.YEAR -> 366 * 24 * 60.0 }
            return total.takeIf { it > 0 && it <= max }
        }
        return GoalNumber.parse(amountText)?.takeIf { it > 0 }
    }

    val plan: HabitPlan get() = HabitPlan(
        amount = amountValue, unit = if (timed) HabitPlan.TIME_UNIT else TextLimit.clean(unit, TextLimit.UNIT), step = step,
        asks = type == ItemType.AMOUNT && asks, often = often.often(hasAmount), atMost = type == ItemType.CUT_DOWN, checklist = type == ItemType.CHECKLIST,
    )

    val canAdd: Boolean get() {
        if (!nameFilled) return false
        if (hasAmount && amountValue == null) return false
        if (type == ItemType.CHECKLIST && filledItems.isEmpty()) return false
        val o = plan.often
        if (isHabit && o is HowOften.Weekdays && o.days.isEmpty()) return false
        if (isHabit && o is HowOften.Calendar) {
            if (o.rule.unit == GoalPeriod.WEEK && o.rule.weekdays.isEmpty()) return false
            if (o.rule.unit == GoalPeriod.MONTH && o.rule.pattern == "Dates" && o.rule.dates.isEmpty()) return false
        }
        return true
    }

    val hasChanges: Boolean get() = if (editing) editChanged else trimmedName.isNotEmpty() || filledItems.isNotEmpty()

    val editChanged: Boolean get() {
        val o = original ?: return false
        return edited(o.name) != o || trimmedName != o.name || TextLimit.clean(reminderWords, TextLimit.REMINDER_TEXT) != (o.reminderText ?: "") ||
            TextLimit.clean(description, TextLimit.DESCRIPTION) != originalDescription || groupId != originalGroup ||
            milestoneAlerts != originalAlerts || typeChanged
    }

    fun edited(name: String): Habit? {
        val o = original ?: return null
        var h = makeHabit(name).copy(id = o.id, createdAt = o.createdAt, archived = o.archived)
        if (type == ItemType.CHECK) h = h.copy(checkUnit = o.checkUnit)
        if (h.startsOn == store.rules.calendarDayOf(h.createdAt) && o.startsOn == null) h = h.copy(startsOn = null)
        if (h.reminders.isEmpty() && o.reminders.isEmpty()) h = h.copy(remind = o.remind)
        // Its steps keep their IDs, so past days' ticks stay theirs.
        return h
    }

    /** The habit as chosen: the one place it's built. */
    fun makeHabit(name: String): Habit {
        var h = Habit(name = name, symbol = symbol, color = color, kind = HabitKind.Check)
        when (type) {
            ItemType.QUIT -> h = h.copy(kind = HabitKind.Quit, quitSince = quitSince)
            ItemType.TASK -> {
                h = h.copy(kind = HabitKind.Task, dueDay = if (taskRepeats) null else taskDate)
                if (taskRepeats) h = h.copy(frequency = often.often(false).frequency(false, false))
                if (taskHasTime && !taskHasNoDate) h = h.copy(dueMinute = taskMinute)
            }
            else -> {
                h = plan.apply(h)
                if (type == ItemType.CHECKLIST) h = h.copy(steps = filledItems)
            }
        }
        if (type != ItemType.QUIT) h = h.copy(parts = timesOfDay)
        if (remind && type != ItemType.QUIT) {
            val seen = HashSet<Int>()
            h = h.copy(reminders = times.mapNotNull { t -> ReminderTime(t.id, t.minute / 60, t.minute % 60).takeIf { seen.add(t.minute) } }
                .sortedBy { store.rules.dayMinute(it.minuteOfDay) })
        }
        val words = TextLimit.clean(reminderWords, TextLimit.REMINDER_TEXT)
        h = h.copy(remind = remind, reminderText = words.ifEmpty { null })
        if (isHabit || (type == ItemType.TASK && taskRepeats)) h = h.copy(startsOn = startDate, endsOn = if (hasEnd) maxOf(endDate, startDate) else null)
        return h.copy(alert = alert, followUpMinutes = if (h.atMost) null else followUp)
    }

    /** The habit as the previews show it: "Your habit" until named, a stand-in amount until set. */
    fun previewHabit(): Habit {
        var h = makeHabit(trimmedName.ifEmpty { if (type == ItemType.TASK) "Your task" else "Your habit" })
        if (hasAmount && amountValue == null) h = plan.copy(amount = 7_777_777.0, step = step ?: 1.0).apply(h)
        return h
    }

    /** The whole habit in one sentence: name, how much, how often and the parts of the day. */
    fun sentence(): String {
        if (type == ItemType.TASK && !taskRepeats && taskDate == com.oftenenough.app.data.NO_DATE_DAY) return trimmedName
        if (type == ItemType.TASK && !taskRepeats) {
            val day = when (taskDate) { store.today() -> "today"; store.today() + 1 -> "tomorrow"; else -> null }
            return trimmedName + (day?.let { " $it" } ?: (" on " + com.oftenenough.app.data.DayWords.short(taskDate))) +
                (if (taskHasTime) " at " + com.oftenenough.app.data.DayWords.clockMinute(taskMinute) else "")
        }
        val base = previewHabit().let { if (hasAmount && amountValue == null) it.copy(kind = HabitKind.Check, goal = 1.0) else it }
        val text = HabitCopy.sentence(base.copy(name = trimmedName), store.weekStart)
        if (type == ItemType.CUT_DOWN) return text
        val parts = if (timesOfDay == listOf(DaySection.ANYTIME)) "anytime" else HabitCopy.join(timesOfDay.map { store.section(it).name.let { n -> if (n.lowercase() in setOf("morning", "afternoon", "evening", "night")) n.lowercase() else n } })
        return "$text, $parts"
    }

    /** Before a name: only how much and how often; with one, the whole sentence (the pages' chip). */
    fun chipText(): String {
        if (trimmedName.isEmpty()) {
            if (hasAmount && amountValue == null) return plan.often.label(true, weekStart = store.weekStart)
            return HabitCopy.capitalized(HabitCopy.plan(previewHabit(), store.weekStart))
        }
        return sentence()
    }

    // ------------------------------------------------------------------ Times of day and reminders

    fun choose(id: String) {
        timesOfDay = if (id == DaySection.ANYTIME) listOf(DaySection.ANYTIME) else {
            val chosen = timesOfDay.filter { it != DaySection.ANYTIME }.toMutableList()
            if (id in chosen) chosen.remove(id) else chosen.add(id)
            val order = store.sections.map { it.id }
            if (chosen.isEmpty()) listOf(DaySection.ANYTIME) else chosen.sortedBy { order.indexOf(it).let { i -> if (i < 0) 99 else i } }
        }
        syncReminders()
    }

    private val reminderParts: List<String> get() = if (type == ItemType.CUT_DOWN) listOf(DaySection.ANYTIME) else timesOfDay

    /** An hour into a time of day (or halfway, for a short one); 9:00 AM for Anytime. */
    fun defaultMinute(id: String): Int {
        if (type == ItemType.TASK && taskHasTime) return taskMinute
        val timed = store.timedSections().firstOrNull { it.first.id == id } ?: return 9 * 60
        return (timed.first.start!! + minOf(60, (timed.second - timed.first.start!!) / 2)) % (24 * 60)
    }

    fun syncReminders(force: Boolean = false) {
        if (!force && !(remind && !remindersEdited)) return
        times = reminderParts.mapIndexed { i, id -> DraftTime(times.getOrNull(i)?.id ?: newId(), defaultMinute(id), id.takeIf { it != DaySection.ANYTIME }) }
    }

    fun addReminder() {
        if (times.isEmpty()) { syncReminders(force = true); return }
        remindersEdited = true
        val parts: List<String?> = if (reminderParts == listOf(DaySection.ANYTIME)) listOf(null) else reminderParts
        val part = parts.minByOrNull { p -> times.count { it.part == p } }
        val last = times.lastOrNull { it.part == part }?.minute
        times = times + DraftTime(minute = ((last?.plus(60)) ?: defaultMinute(part ?: DaySection.ANYTIME)) % (24 * 60), part = part)
    }

    /** Add a time (Figma 2.1.6.2.1): the minute picked, in whichever time of day it falls. */
    fun addReminderAt(minute: Int) {
        remindersEdited = true
        if (times.none { it.minute == minute }) times = (times + DraftTime(minute = minute, part = partFor(minute))).sortedBy { store.rules.dayMinute(it.minute) }
    }

    fun partFor(minute: Int): String? {
        val id = store.rules.sectionForMinute(minute)
        return if (id in reminderParts && id != DaySection.ANYTIME) id else null
    }

    /** "9:00 AM", "9:00 AM and 6:00 PM", "3 reminders", "Off". */
    fun remindersSummary(): String {
        if (!remind) return "Off"
        val sorted = times.map { it.minute }.sortedBy { store.rules.dayMinute(it) }
        if (sorted.size > 2) return "${sorted.size} reminders"
        return HabitCopy.join(sorted.map { com.oftenenough.app.data.DayWords.clockMinute(it) })
    }

    fun suggestIcon() { if (!pickedSymbol) HabitIcons.suggest(name)?.let { symbol = it } }

    @Suppress("unused") fun colorName(c: HabitColor) = c.key.replaceFirstChar { it.uppercase() }
}
