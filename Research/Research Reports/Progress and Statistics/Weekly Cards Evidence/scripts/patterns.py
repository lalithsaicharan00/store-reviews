# Type wording used by the weekly-cards screen.
T = {
 "times_day": r"\b(\d+|two|three|four|five|several|multiple)\s*(x|times)\s*(a|per|each)\s*day\b|times a day|glasses of water|(twice|2x) (a|per) day|multiple times (a|per|in a) day",
 "amount": r"\b(pages|steps|km|kilometers|miles|liters|litres|ml|glasses|reps|push-?ups|calories|grams|cups|words)\b.{0,40}\b(total|average|avg|sum|per week|a week|this week|weekly|over the week|each day)\b|\b(total|average|sum)\b.{0,30}\b(pages|steps|km|miles|liters|ml|glasses|reps|push-?ups|calories|words)\b",
 "time": r"\b(minutes|mins|hours|hrs|time spent|time tracked|timer)\b.{0,40}\b(total|average|avg|per week|a week|this week|weekly|summary|each day|per day)\b|\b(total|average)\b.{0,25}\b(minutes|hours|time)\b",
 "checklist": r"\b(checklist|sub-?tasks?|sub-?habits?|sub-?items?|steps? (of|in) (the|a|my) (routine|habit))\b",
 "weekly_goal": r"\b(\d|one|two|three|four|five|six)\s*(x|times|days)\s*(a|per|each)\s*week\b|times a week|days a week|weekly goal|weekly habit|per week goal",
 "monthly_goal": r"\b(\d|one|two|three|four|five)\s*(x|times|days)\s*(a|per|each)\s*month\b|times a month|monthly goal|monthly habit|once a month",
 "every_n": r"every (other|second|2nd|third|3rd|two|three|four|few|\d+) (day|days|week|weeks)|alternate days|bi-?weekly|every couple of days",
 "limit": r"\b(limit|cut (down|back)|reduce|fewer than|less than|no more than|at most|maximum|max)\b.{0,40}\b(coffee|caffeine|drinks?|alcohol|sugar|cigarettes?|screen time|social media|beers?|snacks?|cups|units)\b",
 "quit": r"\b(relaps\w*|slip(s|ped)?|clean days?|sober\w*|days? since|money saved|quit (smoking|drinking|vaping|porn|sugar)|abstain\w*|abstinence)\b",
 "best_day": r"best day|worst day|which day(s)? (of the week|i)|day of the week|weekday(s)? (i|stat|pattern)|most (productive|consistent) day",
 "notes_week": r"\bnotes?\b.{0,40}\b(week|history|calendar|look back|review)\b",
}
