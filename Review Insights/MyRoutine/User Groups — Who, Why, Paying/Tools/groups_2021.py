# MyRoutine 2021: pain-point user groups, made from MyRoutine's own who/why_chose labels (27 Nov 2026).
# Every who and why_chose of the year was read; people saying the same pain were put together. 2020's codes are kept
# for the same pain; TIME, UNSETTLED, SEEN and SELF are new in 2021, from this year's words.
# key = the review's line number in Review Labels/MyRoutine/2021/labels.jsonl (1 = first line)
# Left out (a device, an identity, how they found it, or "just what I was looking for", with no pain or goal):
# 7 9 10 24 40 41 51 61 80 90 93 94 111 113 118 139 147 150 154 175 183 185 197 207 221 224 248 254 255 267 279 281
# 292 294 299 310 321 350 374 378 385 386
GROUPS = {
 "NOACT": "Know what to do but don't do it: lazy, procrastinate, leave things to the deadline, plans never finished",
 "TRACKING": "Their way of keeping track didn't fit: hopped between apps, deleted them in days, apps too complex or too plain, a missed day meant starting over",
 "TIME": "Time slips away: too much to do for the hours, planning itself eats time, routines with no set time don't happen",
 "UNSETTLED": "Their days have no steady shape: shift work, an irregular life lately, a new job, recovering from surgery",
 "DROPOFF": "Start, then give up within days: three-day resolve (작심삼일), willpower that fades, diaries bought and dropped",
 "FORGET": "Forget things: medicine, the routine itself",
 "SEEN": "Keep going when others can see them",
 "SELF": "Feel they've been neglecting themselves",
 "GOAL": "State only a goal (self-care, build habits, manage time, a planned life), no pain",
}
M = """
27 NOACT DROPOFF|72 NOACT TIME|100 NOACT|250 NOACT|293 NOACT|346 NOACT
45 TRACKING|153 TRACKING|261 TRACKING|326 TRACKING|348 TRACKING|381 TRACKING
164 UNSETTLED TIME|195 TIME|285 TIME|300 TIME|305 UNSETTLED|307 UNSETTLED|339 UNSETTLED
275 DROPOFF|343 DROPOFF|229 FORGET|244 FORGET|44 SEEN|200 SELF
32 GOAL|125 GOAL|188 GOAL|276 GOAL|278 GOAL|295 GOAL|297 GOAL|313 GOAL|337 GOAL|344 GOAL|384 GOAL
"""
MAP = {}
for part in M.replace("\n", "|").split("|"):
    if part.strip():
        n, *codes = part.split()
        MAP[int(n)] = codes
