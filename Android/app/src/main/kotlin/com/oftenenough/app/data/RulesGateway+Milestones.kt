package com.oftenenough.app.data

import app.habits.rules.MilestoneRule

// THE ADAPTER, the milestones' part (see RulesGateway.kt): the decided milestone rule (spec/streaks.md ST-8) for
// MilestoneCenter. Only files named RulesGateway*.kt may reach the shared rules.

/** Four buckets, picked by two questions (ST-8). */
enum class MilestoneBucket { DAYS, WEEKS, MONTHS, YEARS }

/** A habit's bucket from how often it's judged on the day its rule holds. */
fun RulesGateway.milestoneBucket(habit: Habit): MilestoneBucket =
    MilestoneBucket.valueOf(MilestoneRule.bucket(r(habit).judging.frequency).name)

private fun MilestoneBucket.core() = MilestoneRule.Bucket.valueOf(name)

fun MilestoneBucket.isRowMilestone(n: Int): Boolean = MilestoneRule.isRowMilestone(core(), n)
/** A pop-up length: a month, six months and each year. */
fun MilestoneBucket.isLandmark(n: Int): Boolean = MilestoneRule.isLandmark(core(), n)
fun MilestoneBucket.nextRow(n: Int): Int? = MilestoneRule.nextRow(core(), n)
fun MilestoneBucket.totalCrossed(periodGoal: Double, before: Double, after: Double): Double? =
    MilestoneRule.totalCrossed(core(), periodGoal, before, after)
fun MilestoneBucket.nextTotal(periodGoal: Double, total: Double): Double? = MilestoneRule.nextTotal(core(), periodGoal, total)
fun milestoneAnniversary(first: Int, day: Int): Int? = MilestoneRule.anniversaryYears(first, day)
