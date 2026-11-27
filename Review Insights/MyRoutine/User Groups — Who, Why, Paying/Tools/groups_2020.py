# MyRoutine 2020: pain-point user groups, assigned by hand from the labels' who/why_chose fields (27 Nov 2026).
# key = the review's line number in Review Labels/MyRoutine/2020/labels.jsonl (1 = first line)
# Left out (identity, a device or how they found the app, with no pain or goal): 2 47 51 52 59 65 67 69 77 87 98 100
# 101 106 107 108 109 122 125 and 24 (an editors' pick; paid after the trial).
GROUPS = {
 "START": "Can't start or keep going: plan but don't act, low willpower, give up new habits within days (작심삼일)",
 "NOTHING": "Tried other apps, planners or a paper diary; nothing stuck",
 "OVERWHELM": "Overwhelmed: other apps too much to learn, or a blank first list feels daunting",
 "FORGET": "Forget small habits (medicine, tasks at set times)",
 "DISTRACT": "Lose time: hectic, frantic days",
 "GOAL": "State only a goal (build habits, a routine, the days they want), no pain",
}
M = """
4 START|5 GOAL|10 GOAL|15 GOAL|23 NOTHING START|30 NOTHING|36 GOAL|37 START|38 FORGET|39 OVERWHELM|42 GOAL
46 START NOTHING|50 START|54 NOTHING|58 START NOTHING|66 START|71 OVERWHELM NOTHING|72 START|92 START NOTHING
93 DISTRACT FORGET|96 START|103 GOAL|104 GOAL|114 GOAL|126 GOAL|127 NOTHING START|130 NOTHING
"""
MAP = {}
for part in M.replace("\n", "|").split("|"):
    if part.strip():
        n, *codes = part.split()
        MAP[int(n)] = codes
