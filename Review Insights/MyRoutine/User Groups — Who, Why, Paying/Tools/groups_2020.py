# MyRoutine 2020: pain-point user groups, made from MyRoutine's own who/why_chose labels (27 Nov 2026).
# The groups come from these labels alone: every who and why_chose of the year was read and the people whose words
# say the same pain were put together. No other app's groups were used.
# key = the review's line number in Review Labels/MyRoutine/2020/labels.jsonl (1 = first line)
# Left out (identity, a device or how they found the app, with no pain or goal): 2 47 51 52 59 65 67 69 77 87 98 100
# 101 106 107 108 109 122 125 and 24 (an editors' pick; paid after the trial).
GROUPS = {
 "NOACT": "Know what to do but don't do it: plan in their head, keep meaning to, too much bother to start, no willpower",
 "DROPOFF": "Start, then give up within days: habits last three days (작심삼일), apps installed and dropped",
 "TRACKING": "Their way of keeping track didn't fit: a paper diary, reminders in a to-do app, apps that track one habit or take too much learning",
 "FORGET": "Forget things: tasks at set times, medicine",
 "BLANK": "Don't know what routine to make: a first list feels daunting",
 "GOAL": "State only a goal (build habits, a routine, the days they want), no pain",
}
M = """
4 NOACT|37 NOACT|50 NOACT|66 NOACT|72 NOACT|92 NOACT TRACKING
23 DROPOFF|46 DROPOFF|58 DROPOFF|96 DROPOFF|127 DROPOFF
30 TRACKING|54 TRACKING|71 TRACKING|130 TRACKING
38 FORGET|93 FORGET|39 BLANK
5 GOAL|10 GOAL|15 GOAL|36 GOAL|42 GOAL|103 GOAL|104 GOAL|114 GOAL|126 GOAL
"""
MAP = {}
for part in M.replace("\n", "|").split("|"):
    if part.strip():
        n, *codes = part.split()
        MAP[int(n)] = codes
