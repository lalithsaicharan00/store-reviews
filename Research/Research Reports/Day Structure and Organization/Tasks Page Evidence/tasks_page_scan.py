#!/usr/bin/env python3
"""Screen every review for the Tasks page (the list of all of a person's tasks): why people open it and what they do
there. Two groups: habit apps (App Store and Play Store, the review must mention a task or to-do) and to-do apps
(Reminders, Google Tasks, Microsoft To Do and the Play Store's to-do apps). Run from Research/:
  python3 -I Temp/tasks-page/scan.py
"""
import json, os, re, sys
ROOTS = {"A": "App Store Reviews", "P": "Play Store Reviews", "N": "Native Store Reviews"}
TODO_P = {"84", "85", "95", "97", "100", "117", "121", "126"}
TODO_N = {"1", "6", "10"}
TASKW = re.compile(r"\b(tasks?|to-?dos?|todo list|to do list|reminders?|chores?|errands?|one[- ]time|one[- ]off)\b", re.I)
S = {
 "upcoming": r"(upcoming|future (tasks|days|dates)|next (week|7 days|few days)|later (this|in the) week|scheduled (tasks|for)|tasks? (for|on) (other|future|later|another) days?|planned (tasks|for)|see (all|everything) (i have )?(coming|planned|scheduled)|what('s| is) coming( up)?|ahead of time|plan (ahead|my week|the week))",
 "all_list": r"(all (my |of my |the )?(tasks|to-?dos|reminders)( in one| at once| together| list| view| page| screen)?|(list|view|page|overview) of (all )?(my |the )?(tasks|to-?dos|reminders)|see (all|every) (my |of my |the )?(tasks|to-?dos|reminders)|master list|everything in one (place|list))",
 "completed": r"(completed (tasks|items|to-?dos|reminders|list|section)|finished tasks|done tasks|clear (all )?(the )?completed|delete (all )?completed|hide completed|show completed|see (what|everything) i('ve| have) (done|completed|accomplished)|history of (completed|done|finished)|completed history|log of (completed|done)|archive (completed|done|finished))",
 "undone": r"(overdue|missed (tasks|ones)|carr(y|ies|ied) (it )?over|roll(s|ed)? over|move (it|them|tasks?|undone|unfinished) to (tomorrow|today|the next day|next day)|unfinished tasks|incomplete tasks|undone tasks|didn'?t (do|finish|complete) (it|them|yesterday)|push (it|them|tasks?) to (tomorrow|later)|postpone|reschedul|snooze (a |the )?task)",
 "nodate": r"(no (due )?date|without a (due )?date|someday|undated|no deadline|any ?time (this|in the) (week|month)|not (tied to|on) a (specific )?(day|date))",
 "recurring": r"((recurring|repeating|repeated|repeat) (tasks?|to-?dos?|reminders?|items?).{0,80}(edit|delete|stop|end|see|list|manage|find|change|skip|remove|history|next)|(edit|delete|stop|end|see|list|manage|find|change|skip|remove) .{0,40}(recurring|repeating) (tasks?|to-?dos?|reminders?))",
 "search": r"(search (bar|box|function|feature|option|for (a |my )?(task|reminder|to-?do))|(find|look up|locate) (a |an |my |the )?(old |specific |particular )?(task|reminder|to-?do))",
 "sort": r"(sort (by|tasks|my|the|option|order)|(by|in) (due date|date|priority) order|chronolog|order (by|of) (due date|date|priority|time)|alphabetic)",
 "lists": r"((tasks?|to-?dos?) (into|in|by) (lists|categories|projects|folders|groups|tags)|(categor|folder|project|tags?|lists?) for (my )?(tasks|to-?dos)|separate lists|multiple lists|sub-?lists)",
 "edit_delete": r"((can'?t|cannot|how (do i|to)|unable to|no way to|couldn'?t) (edit|delete|remove|change|rename|move) (a |the |my |an |old )?(tasks?|to-?dos?|reminders?|items?)|(edit|delete) (button|option) .{0,20}task)",
 "bulk": r"((select|delete|move|complete|mark|clear) (multiple|several|all|many|a bunch of) (tasks|to-?dos|reminders|items)|multi-?select|bulk)",
 "calendar": r"((calendar|week|month|monthly|weekly) view .{0,40}(tasks|to-?dos)|(tasks|to-?dos) .{0,40}(calendar|week|month) view|see (my )?(tasks|to-?dos) (on|in) (a|the) calendar)",
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
                    if len(t) < 25: continue
                    if group == "HT" and not TASKW.search(t): continue
                    for k, rx in S.items():
                        if rx.search(t):
                            out[k].append({"cite": f"{p}{n}#{i}", "app": r.get("app_name"), "rating": r.get("rating"), "date": (r.get("date") or "")[:10], "group": group, "text": t})
    print("screened", total, file=sys.stderr)
    for k, v in out.items():
        print(k, "HT", sum(1 for x in v if x["group"] == "HT"), "TD", sum(1 for x in v if x["group"] == "TD"), file=sys.stderr)
        with open(f"Temp/tasks-page/{k}.jsonl", "w", encoding="utf-8") as f:
            for row in v: f.write(json.dumps(row, ensure_ascii=False) + "\n")
if __name__ == "__main__": main()
