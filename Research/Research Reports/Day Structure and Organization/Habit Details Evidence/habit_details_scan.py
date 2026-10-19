#!/usr/bin/env python3
"""Habit details page research (Current Work 133, 19 Oct 2026): habit apps only. Why people open one habit's own page
(its details: history, calendar, stats, streaks, milestones, notes, editing past days, settings) and what they do there.
To-do apps (Reminders, Google Tasks, Microsoft To Do and the Play Store's to-do apps) are left out. Run from Research/:
  python3 -I "Research Reports/Day Structure and Organization/Habit Details Evidence/habit_details_scan.py"
"""
import json, os, re, sys
ROOTS = {"A": "App Store Reviews", "P": "Play Store Reviews"}
TODO_P = {"84", "85", "95", "97", "100", "117", "121", "126"}
HABITW = re.compile(r"\b(habits?|streaks?|routines?|goals?)\b", re.I)
S = {
 "page": r"(habit('s)? (page|details?|detail page|screen|view|card|profile|overview|info)|(details?|info|overview|individual|single) (page|screen|view) (of|for) (a |each |the |every )?habit|(individual|single|specific|particular|each|every) habit('s)? (page|screen|view|details?|stats?|statistics|history|calendar|progress|chart|graph|data|record)s?)",
 "open": r"((tap|tapping|click|clicking|press|pressing|open|opening|select|selecting)( on| into)? (a|the|any|each|one|my|an individual|a specific|a single) habit\b)",
 "per_stats": r"((stats|statistics|progress|history|calendar|chart|graph|analytics|data|records?|heat ?map|year in pixels|streak history|completion rate|success rate|percentage)s? (for|of|per|on|by) (each|every|individual|a single|a specific|a particular|one) habit)",
 "history": r"(habit|streak)s?\b.{0,40}\b(history|past (days|entries|logs|records|months|weeks)|previous (days|entries|months)|log ?book|past data|record of)\b|\b(history|past entries|previous days)\b.{0,40}\bhabits?\b",
 "past_edit": r"((edit|change|fix|correct|update|mark|check off|log|fill in|backfill|add)( a| the| my| an)? (past|previous|missed|earlier|old|forgotten|yesterday'?s?) (days?|dates?|entries|entry|logs?|records?|completions?|check-?ins?))",
 "calendar": r"(calendar (view|page|of|for|showing|where|to see)|monthly (view|calendar)|year (view|overview|calendar)|heat ?map|year in pixels|github(-| )style|contribution (graph|grid))",
 "streak_info": r"((best|longest|current|previous|old|past|record) streak|streak (history|record|count|counter|freeze))",
 "notes": r"((notes?|journal|comments?|memos?|reflections?) (for|on|per|to|with|about) (each|every|a|the|my|individual) (habit|day|entry|check-?in)|(add|write|see|read|view|find|search) (my |a |the |past |old )?(notes?|memos?|comments?))",
 "milestones": r"(milestones?|badges?|achievements?|trophies|medals?)\b.{0,50}\b(habit|streak|days?)",
 "settings": r"((edit|change|adjust|modify|rename|pause|archive|delete|reset|restart) (the |a |my |an? individual |each )?habits?('s)? (settings|goal|schedule|frequency|name|icon|colou?r|reminder|start date|target)|habit settings)",
}
S = {k: re.compile(v, re.I) for k, v in S.items()}
def text_of(r): return " ".join(x for x in (r.get("title"), r.get("body"), r.get("text")) if x)
def main():
    out = {k: [] for k in S}; total = 0
    for p, root in ROOTS.items():
        for folder in sorted(os.listdir(root)):
            path = os.path.join(root, folder, "reviews.jsonl")
            if not os.path.exists(path): continue
            n = folder.split(".")[0]
            if p == "P" and n in TODO_P: continue
            with open(path, encoding="utf-8") as f:
                for i, line in enumerate(f):
                    total += 1; r = json.loads(line); t = text_of(r)
                    if len(t) < 30 or not HABITW.search(t): continue
                    for k, rx in S.items():
                        if rx.search(t):
                            out[k].append({"cite": f"{p}{n}#{i}", "app": r.get("app_name") or folder, "rating": r.get("rating"), "date": (r.get("date") or "")[:10], "text": t})
    print("screened", total, file=sys.stderr)
    os.makedirs("Temp/habit-details", exist_ok=True); allc = set()
    for k, v in out.items():
        print(k, len(v), file=sys.stderr); allc |= {x["cite"] for x in v}
        with open(f"Temp/habit-details/{k}.jsonl", "w", encoding="utf-8") as f:
            for row in v: f.write(json.dumps(row, ensure_ascii=False) + "\n")
    print("unique", len(allc), file=sys.stderr)
if __name__ == "__main__": main()
