"""Item 54-56, question 3 (6 Oct 2026): hide a week/month goal from one day ("not today")?
Hand-coded from Temp/54-period_show.jsonl (narrowed, 98 read) and Temp/54-hide_day.jsonl (349 non-notification + 98
snooze-near-habit/day matches read). Each review sits in exactly one theme. Run: python3 -I Temp/54-review-classification.py
"""
import json

THEMES = {
    # The user's exact case: a week/month goal not done today, hidden from today without skip or fail.
    "H1_hide_period_goal_today": ["P3#14071", "P2#7844"],
    # Hide or snooze any habit for the day without it counting as done, skipped or failed.
    "H2_hide_any_habit_today": ["A1#46783", "P98#753", "P20#81", "N1#24517", "N1#23646"],
    # An app's existing hide-for-today that doesn't stay hidden (people who use one).
    "H3_hide_feature_bugs": ["A1#52088", "A1#54853"],
    # Hide a period goal once it's been done today, or once the period is met (already: done sinks, Hide Completed).
    "H4_hide_after_done": ["P36#545", "P2#12230", "P2#12620", "A13#16273", "A41#768", "A69#66", "P8#7785"],
    # Move or postpone a habit or task to another day (scheduled days; a different feature from hiding a quota).
    "P1_postpone_request": [
        "A1#694", "A1#52978", "A1#55213", "A10#1443", "A10#2800", "A10#30140", "A10#3894", "A10#5100",
        "A13#9053", "A13#12870", "A13#17146", "A13#18371", "A23#4057", "A24#2323", "A25#340",
        "A33#80", "A33#1115", "A36#244", "A4#2997", "A4#16434", "A4#17554", "A41#623", "A43#502", "A49#1038",
        "A49#1103", "A59#1919", "P11#3842", "P11#5876", "P12#16268", "P12#19587", "P12#46319", "P125#17370",
        "P19#901", "P2#7555", "P2#8000", "P2#9685", "P2#9890", "P2#10267", "P2#11143", "P2#12334", "P2#12610",
        "P24#4418", "P4#6660", "P4#11000", "P4#11356", "P4#22310", "P4#26421", "P4#29348", "P4#30532", "P5#3008",
        "P65#4164", "P8#494", "P8#5747", "N10#9905", "N10#18756", "N8#9440", "N5#275",
    ],
    # Praise for an existing snooze/postpone to another day.
    "P2_postpone_praise": [
        "A10#116", "A10#4242", "A10#19107", "A10#26365", "A10#28841", "A10#35364", "A10#35533", "A10#38271",
        "A10#40588", "A10#42863", "A10#43433", "A10#48052", "A10#53606", "A10#61087", "A13#17615", "P12#15555",
        "P49#237", "P49#514", "P49#669", "P49#1462", "P61#186", "P61#397", "P63#1018", "P97#2857",
    ],
    # Counter-evidence: a week/month goal should show every day until it's met (or complaints it didn't show).
    "C1_show_every_day_until_met": [
        "A10#27797", "A10#29857", "A10#31812", "A10#57326", "A4#13489", "A85#1095", "P22#1076", "P61#1108",
        "A13#13498", "A24#20432", "A25#1162", "A13#4696", "A13#13640", "A13#9447", "A13#13646", "A53#32",
    ],
    # Keep a met quota visible to log extra (we do: the row stays, done sinks).
    "C2_keep_after_met": ["A13#6266", "A13#15961", "P19#65", "P2#1834", "P2#7157", "P2#10957", "P3#1306", "P3#7271"],
    # A weekly habit on a non-due day, or one counted against days (fixed days or stats; already handled).
    "O1_offday_or_counting": [
        "A1#45779", "A4#4179", "P3#8820", "P3#12015", "P3#14550", "P8#4595", "P8#8663", "P92#99", "P98#326",
        "A86#1180", "P84#53864",
    ],
}


def main():
    known = set()
    for f in ("Temp/54-period_show.jsonl", "Temp/54-hide_day.jsonl"):
        for line in open(f, encoding="utf-8"):
            known.add(json.loads(line)["cite"])
    seen, problems = {}, []
    for theme, ids in THEMES.items():
        if len(ids) != len(set(ids)):
            problems.append(f"duplicate in {theme}")
        for i in ids:
            if i not in known:
                problems.append(f"unknown {i} in {theme}")
            if i in seen:
                problems.append(f"{i} in {seen[i]} and {theme}")
            seen[i] = theme
    for theme, ids in THEMES.items():
        print(f"{theme}: {len(ids)}")
    print("coded", len(seen), "problems", problems or "none")


if __name__ == "__main__":
    main()
