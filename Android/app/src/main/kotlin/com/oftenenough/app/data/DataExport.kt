package com.oftenenough.app.data

// MOVE TO CORE: the spreadsheet export, ported from the iPhone's DataExport.swift. One row per thing logged or noted,
// with the local calendar date it counts for (never a UTC moment); archived habits included. For reading, not restoring.

object DataExport {
    val header = listOf("Date", "Habit", "What", "Amount", "Unit", "Note")

    class Row(val key: String, val fields: List<String>)

    fun rows(store: HabitStore): List<Row> {
        val rows = ArrayList<Row>()
        for (habit in store.habits) {
            for (entry in store.entries(habit.id)) {
                val rule = store.rule(habit, entry.day)
                var amount = number(entry.value)
                var unit = rule.unit
                val what: String
                when (rule.kind) {
                    HabitKind.Quit -> { what = "Slip"; amount = ""; unit = "" }
                    HabitKind.Checklist -> { what = "Step: " + (rule.steps.firstOrNull { it.id == entry.stepId }?.name ?: ""); amount = ""; unit = "" }
                    HabitKind.Duration -> { what = "Time"; unit = "min" }
                    HabitKind.Check, HabitKind.Task -> { what = "Done"; if (unit.isEmpty()) unit = if (entry.value == 1.0) "time" else "times" }
                    is HabitKind.Amount -> what = "Amount"
                }
                rows += Row(dayKey(entry.day) + habit.id + entry.id,
                    listOf(dayKey(entry.day), spreadsheetText(habit.name), spreadsheetText(what), amount, spreadsheetText(unit), ""))
            }
            for ((day, text) in store.notes(habit)) {
                rows += Row(dayKey(day) + habit.name, listOf(dayKey(day), spreadsheetText(habit.name), "Note", "", "", spreadsheetText(text)))
            }
        }
        for ((day, text) in store.dayNotes) rows += Row(dayKey(day), listOf(dayKey(day), "", "Note for the day", "", "", spreadsheetText(text)))
        return rows
    }

    fun csv(rows: List<Row>): String = (listOf(line(header)) + rows.sortedBy { it.key }.map { line(it.fields) }).joinToString("\r\n") + "\r\n"

    fun number(value: Double): String {
        if (!value.isFinite()) return ""
        val text = value.toString()
        return if (text.endsWith(".0")) text.dropLast(2) else text
    }

    /** Text people typed stays text, even when it starts like a spreadsheet formula. */
    fun spreadsheetText(value: String): String = if (value.isNotEmpty() && value[0] in "=+-@\t\r\n") "'$value" else value

    /** Quotes a field with a comma, a quote or a line break (RFC 4180). */
    fun line(fields: List<String>): String = fields.joinToString(",") { f ->
        if (f.any { it == ',' || it == '"' || it == '\n' || it == '\r' }) "\"" + f.replace("\"", "\"\"") + "\"" else f
    }
}
