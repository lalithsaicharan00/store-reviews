package com.oftenenough.app.data

import app.habits.rules.Milestones
import app.habits.rules.Period

// THE ADAPTER, the habit page's part (see RulesGateway.kt): the few shared rules Habit details needs that the gateway
// itself doesn't expose. Only files named RulesGateway*.kt may reach the shared rules.

/** Whether any pause touches [days] (a week or month with a paused day can't count against anyone). */
fun RulesGateway.hasPause(habit: Habit, days: IntRange): Boolean = rules.hasPause(r(habit), range(days))

/** The streak lengths worth a medal, up to [n], smallest first (spec/streaks.md ST-7). */
fun RulesGateway.milestonesUpTo(unit: StreakUnit, n: Int): List<Int> =
    Milestones.upTo(app.habits.rules.StreakUnit.valueOf(unit.name), n)

/** The next streak length worth a medal after [after]. */
fun RulesGateway.nextMilestone(unit: StreakUnit, after: Int): Int =
    Milestones.next(app.habits.rules.StreakUnit.valueOf(unit.name), after)

/** Goals met in total worth a medal, for a goal of [kind]'s period. */
fun RulesGateway.totalMilestones(kind: GoalPeriod): List<Int> = Milestones.totalLadder(Period.valueOf(kind.name))
