#!/usr/bin/env python3
"""Screen every review for item 54-56's third question: do people want to hide a week/month goal from one day
("not today") rather than skip it? Writes every match, with its citation (A/P/N<N>#line), for hand reading.

Run from Research/:  python3 -I Temp/54-hide-weekly-scan.py
"""
import json, os, re, sys

ROOTS = {"A": "App Store Reviews", "P": "Play Store Reviews", "N": "Native Store Reviews"}

# Weekly/monthly/"x times a week" wording near a showing/hiding/clutter word.
PERIOD = r"(weekly|monthly|per week|a week|each week|times a week|x times|times per week|per month|a month|times a month|once a week|twice a week)"
SHOW = r"(show(s|n|ing)? (up )?(every|each|daily|all)|appear(s|ing)? (every|each|daily|all)|every single day|clutter|in the way|on my (daily |today )?list every|daily list|today (list|view|screen|page)|hide|hidden|remove (it |them )?from (today|the day|my day)|disappear)"
HIDE_DAY = (r"(hide (it |them |the habit |a habit |habits |this )?(for|from) (today|the day|that day|the rest of)"
            r"|snooze|not today|remove (it |them |a habit |habits )?from today|dismiss (it |a habit )?(for )?(today|the day)"
            r"|postpone|push (it )?to tomorrow|move (it |a habit |habits )?to (tomorrow|another day|a different day|later)"
            r"|reschedul|defer"
            r"|don'?t want to see (it|them|this|that|a habit|habits)( today| every day| daily)?)")

PATTERNS = {
    "period_show": re.compile(PERIOD + r".{0,120}" + SHOW + r"|" + SHOW + r".{0,120}" + PERIOD, re.I | re.S),
    "hide_day": re.compile(HIDE_DAY, re.I),
}
HABITISH = re.compile(r"\bhabit", re.I)


def text_of(r):
    return " ".join(x for x in (r.get("title"), r.get("body"), r.get("text")) if x)


def main():
    out = {k: [] for k in PATTERNS}
    total = 0
    for prefix, root in ROOTS.items():
        for folder in sorted(os.listdir(root)):
            path = os.path.join(root, folder, "reviews.jsonl")
            if not os.path.exists(path):
                continue
            n = folder.split(".")[0]
            with open(path, encoding="utf-8") as f:
                for i, line in enumerate(f):
                    total += 1
                    r = json.loads(line)
                    t = text_of(r)
                    if len(t) < 25:
                        continue
                    for k, p in PATTERNS.items():
                        if p.search(t):
                            out[k].append({"cite": f"{prefix}{n}#{i}", "app": r.get("app_name"), "rating": r.get("rating"),
                                           "date": (r.get("date") or "")[:10], "lang": r.get("language") or r.get("country"),
                                           "habit_app": prefix in "AP", "text": t})
    print("screened", total, file=sys.stderr)
    for k, v in out.items():
        print(k, len(v), file=sys.stderr)
        with open(f"Temp/54-{k}.jsonl", "w", encoding="utf-8") as f:
            for row in v:
                f.write(json.dumps(row, ensure_ascii=False) + "\n")


if __name__ == "__main__":
    main()
