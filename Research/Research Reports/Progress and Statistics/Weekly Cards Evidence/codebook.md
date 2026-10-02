# Weekly habit cards — codebook (2 Oct 2026)
What a reviewer wants shown (or praises / complains about) for ONE habit over a period. + praise, ? ask, - complaint.
TOTAL   the period's total in the habit's unit (km, minutes, pages, times)
AVG     average per day or per session
DAYS    number of days the goal was met / done (x of y days)
PART    partial days visible or counted (2 of 3 glasses, 15 of 20 min)
DAYVAL  each day's own value visible (number or bar per day)
OVER    going over the goal shown (extra, more than planned)
PERIOD  progress toward a week/month goal (2 of 3 this week)
LEFT    what's left: times still needed, days left in the period
NOTDUE  days it wasn't due shown as neutral / different from missed
SKIP    skipped / paused / excused days shown and kept separate
STREAK  current or best streak (days)
PSTREAK streak counted in weeks/months (goal met N weeks in a row)
NEXT    next due day (every N days, set days)
TIMES   when it was done (time of day, which slot of the day)
STEPS   which checklist items were done or missed, per item
RUN     quit: current run / time since last slip / best run
SLIPS   quit: number of slips, when they happened
CLEAN   quit: clean days counted
SAVED   quit/limit: money saved, units avoided
LIMIT   cut down: amount against the limit, days within, days over
PREV    compared with last week / last period
WEEKDAY patterns by day of week, best day
NOTES   notes or reasons visible in the history
WRONG   the period figure is counted wrongly for this type
CLUTTER too many numbers / repeated information
NA      not about showing a habit's progress

Remaps applied when tallying (tally.py): in quit reviews (rows 1476–2339) PSTREAK and CLEAN were used for "longest streak" and "days since" and are counted as RUN; in best_day, notes_week and confusing rows PSTREAK means a plain best streak and is counted as STREAK.

Groups (row ranges in coded_reviews.tsv): times_day 0–87, partial 88–259, amount 260–273, time 274–331, amount_time 332–894, checklist 895–1024, weekly_goal 1025–1363, monthly_goal 1364–1420, every_n 1421–1466, limit 1467–1475, quit 1476–2339, best_day 2340–2746, notes_week 2747–2757, confusing 2758–2993.
