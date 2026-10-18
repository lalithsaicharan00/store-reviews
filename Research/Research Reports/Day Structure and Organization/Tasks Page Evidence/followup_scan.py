#!/usr/bin/env python3
"""Tasks page follow-up (18 Oct 2026): the user's open questions. Run from Research/:
  python3 -I Temp/tasks-page/followup_scan.py
Screens:
  roll      - an unfinished task moving on (one-time or repeating), missed repeats, doubling, repeat after completion
  group     - a task list grouped by when (today/tomorrow/upcoming/later sections) or one flat list
  tick      - where people tick tasks (from a list, ahead of time, by accident)
  done      - completed tasks: history, kept or cleared, by date
  repeatview- seeing repeating tasks (all of them, their next date, hidden until due)
"""
import json, os, re, sys
ROOTS = {"A": "App Store Reviews", "P": "Play Store Reviews", "N": "Native Store Reviews"}
TODO_P = {"84", "85", "95", "97", "100", "117", "121", "126"}
TODO_N = {"1", "6", "10"}
TASKW = re.compile(r"\b(tasks?|to-?dos?|todo list|to do list|reminders?|chores?|errands?|one[- ]time|one[- ]off)\b", re.I)
REP = r"(recurring|repeating|repeated|repeat|reoccurring|daily|weekly|monthly)"
T = r"(tasks?|to-?dos?|reminders?|chores?|items?)"
S = {
 "roll": rf"(roll(s|ed|ing)? ?over|carr(y|ies|ied|ying) (it |them |tasks? )?(over|forward)|(move|moves|moved|push|pushed|bring|brings|brought) (it |them |unfinished |undone |incomplete |uncompleted )?(tasks? )?(forward|over )?to (the )?next day|stay(s)? (on|in) (my |the )?(list|today) until|until (it'?s |i |they'?re )?(done|completed|checked|ticked|finished)|{REP} {T}.{{0,140}}(missed|overdue|didn'?t (do|complete|finish|get)|not (done|completed)|pil(e|es|ing) up|stack|duplicat|twice|double|next day|skip|late)|(missed|overdue|didn'?t do).{{0,80}}{REP} {T}|repeat(s|ing)? (from|after) (the )?(completion|complet|done|last)|from (the )?(date|day) (i|it was|it'?s) (completed|done|finished)|every (2|3|4|two|three|four|few|other|x) (days|weeks).{{0,100}}(late|missed|overdue|complet|done))",
 "group": r"((today|tomorrow|upcoming|this week|next week|later|someday|overdue|planned).{0,30}(section|heading|header|group|grouped|tab|view|list|category)|(sections?|grouped|groups?|organi[sz]ed|sorted|separated|divided) (by|into) (date|day|due date|days|today)|my day|today view|upcoming view|(one|single|flat|long|endless|never.ending) list|scroll(ing)? (forever|down|through) .{0,40}(tasks|list|to-?dos))",
 "tick": r"((check|tick|mark|complete|cross)(ing|ed)? (it |them |tasks? |things |items? |off )*(off )?(from|in|on|right from|directly (from|in|on)) (the )?(list|widget|notification|calendar|upcoming|all|home|lock|main|planned|any)|(can'?t|cannot|unable to|no way to|won'?t let me) (check|tick|complete|mark).{0,40}(future|tomorrow|ahead|early|in advance|another day|other days)|(complete|check|tick|mark).{0,25}(ahead of time|in advance|early|before (the|its) (due|date|day))|accident(al(ly)?)? .{0,25}(check|tick|complet|mark|tap)|(check|tick|complet|mark|tap)\w* .{0,25}by (accident|mistake))",
 "done": r"(completed (tasks?|items?|to-?dos?|reminders?|list|section|folder|tab|ones)|(done|finished) (tasks|items|list|section)|(history|log|logbook|record|archive|list) of (my )?(completed|done|finished|accomplished)|(completed|done) (history|log|archive)|date (completed|finished|done)|(when|what day) (i|it was) (completed|finished|done)|clear (all )?(the )?(completed|done|finished)|delete (all )?(the )?(completed|done|finished)|hide (the )?(completed|done|finished)|show (the )?(completed|done|finished)|look back at (what|everything|all))",
 "repeatview": rf"({REP} {T}.{{0,120}}(see|show|showing|shown|list|view|visible|appear|upcoming|next|future|hidden|disappear|vanish|until the day|ahead)|(see|show|list|view|find|manage) (all )?(of )?(my |the )?(recurring|repeating|repeated) {T}|(all|list of) (my )?(recurring|repeating) {T})",
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
            if p == "N" and n not in TODO_N: continue
            group = "TD" if (p == "N" or (p == "P" and n in TODO_P)) else "HT"
            with open(path, encoding="utf-8") as f:
                for i, line in enumerate(f):
                    total += 1; r = json.loads(line); t = text_of(r)
                    if len(t) < 25 or not TASKW.search(t): continue
                    for k, rx in S.items():
                        if rx.search(t):
                            out[k].append({"cite": f"{p}{n}#{i}", "app": r.get("app_name"), "rating": r.get("rating"), "date": (r.get("date") or "")[:10], "group": group, "text": t})
    print("screened", total, file=sys.stderr)
    for k, v in out.items():
        print(k, "HT", sum(1 for x in v if x["group"] == "HT"), "TD", sum(1 for x in v if x["group"] == "TD"), file=sys.stderr)
        with open(f"Temp/tasks-page/followup/{k}.jsonl", "w", encoding="utf-8") as f:
            for row in v: f.write(json.dumps(row, ensure_ascii=False) + "\n")
if __name__ == "__main__": main()
