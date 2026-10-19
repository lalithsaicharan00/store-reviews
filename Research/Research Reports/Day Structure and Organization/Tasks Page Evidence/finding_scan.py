#!/usr/bin/env python3
"""Tasks page, third pass (19 Oct 2026, Current Work 130): habit apps only. How people find their tasks on a habit
app's task list (a repeating task on some days, a task far ahead, done and archived ones), and how they reach them.
Reviews already coded in the first two passes are left out, so the counts can be added. Run from Research/:
  python3 -I "Research Reports/Day Structure and Organization/Tasks Page Evidence/finding_scan.py"
"""
import importlib.util, json, os, re, sys
HERE = os.path.dirname(os.path.abspath(__file__))
ROOTS = {"A": "App Store Reviews", "P": "Play Store Reviews"}
TODO_P = {"84", "85", "95", "97", "100", "117", "121", "126"}
TASKW = re.compile(r"\b(tasks?|to-?dos?|todo list|to do list|chores?|errands?|one[- ]time|one[- ]off)\b", re.I)
S = {
 "cant_find": r"(can'?t|cannot|couldn'?t|unable to|hard to|no way to|how (do i|can i|to)|where (do i|can i|to)|impossible to) (find|see|view|locate|get to|access|look at|check) .{0,50}(tasks?|to-?dos?|recurring|repeating|scheduled)",
 "hidden": r"(tasks?|to-?dos?)\b.{0,50}(only (show|appear)s?( up)? (on|when|the day)|(don'?t|doesn'?t|do not|does not|won'?t) (show|appear)|disappear|vanish|are hidden|is hidden|not (show|visible|listed))",
 "manage_list": r"((list|view|page|screen|tab|overview|section) (of|for|with|showing) (all )?(my |the )?(recurring|repeating|scheduled|future|upcoming|single|one[- ]time) (tasks?|to-?dos?)|(recurring|repeating|scheduled|single|one[- ]time|future|upcoming) (tasks?|to-?dos?) (tab|list|section|page|view|screen))",
 "all_tasks": r"(all (of )?(my |the )?(tasks|to-?dos)\b.{0,30}(in one|at once|together|list|view|page|screen|tab|place|overview)|(see|view|show|list) (all|every) (of )?(my |the )?(tasks|to-?dos))",
 "tabs_filter": r"(\b(tabs?|filters?|filtering)\b.{0,30}\b(tasks?|to-?dos?)\b|\b(tasks?|to-?dos?)\b.{0,30}\b(tabs?|filters?|filtering)\b)",
 "far_ahead": r"((months?|years?|yearly|annual|annually|next year|weeks? (ahead|from now|away)|far (ahead|in advance)|long[- ]term|in advance) .{0,40}\b(tasks?|to-?dos?)\b|\b(tasks?|to-?dos?)\b.{0,40}(months? (ahead|away|from now|later)|next year|yearly|annual|far (ahead|in advance)|long[- ]term|in advance))",
 "scroll": r"(scroll(ing)? (all the way|down|to the bottom|forever|through|and scroll)|endless scroll|long list).{0,80}",
 "where_done": r"((where|how) (are|is|do i|can i|to) .{0,20}(see |find |view )?(the |my )?(completed|finished|done|archived|old|past) (tasks?|to-?dos?))",
 "separate": r"((habits?|routines?) (and|from|vs\.?|versus) (tasks?|to-?dos?)|(tasks?|to-?dos?) (and|from|vs\.?|versus) (habits?|routines?)).{0,60}(separate|apart|mixed|mix|together|distinct|different|split)",
}
S = {k: re.compile(v, re.I) for k, v in S.items()}
def coded():
    out = set()
    for f in ("review_classification.py", "followup_classification.py"):
        s = importlib.util.spec_from_file_location(f[:-3], os.path.join(HERE, f)); m = importlib.util.module_from_spec(s); s.loader.exec_module(m)
        out |= set(m.CODES)
    return out
def text_of(r): return " ".join(x for x in (r.get("title"), r.get("body"), r.get("text")) if x)
def main():
    seen = coded(); out = {k: [] for k in S}; total = 0; skipped = 0
    for p, root in ROOTS.items():
        for folder in sorted(os.listdir(root)):
            path = os.path.join(root, folder, "reviews.jsonl")
            if not os.path.exists(path): continue
            n = folder.split(".")[0]
            if p == "P" and n in TODO_P: continue
            with open(path, encoding="utf-8") as f:
                for i, line in enumerate(f):
                    total += 1; cite = f"{p}{n}#{i}"
                    r = json.loads(line); t = text_of(r)
                    if len(t) < 25 or not TASKW.search(t): continue
                    hit = [k for k, rx in S.items() if rx.search(t)]
                    if not hit: continue
                    if cite in seen: skipped += 1; continue
                    for k in hit:
                        out[k].append({"cite": cite, "app": r.get("app_name") or folder, "rating": r.get("rating"), "date": (r.get("date") or "")[:10], "text": t})
    print("screened", total, "already coded", skipped, file=sys.stderr)
    allc = set()
    os.makedirs("Temp/tasks-page/finding", exist_ok=True)
    for k, v in out.items():
        print(k, len(v), file=sys.stderr); allc |= {x["cite"] for x in v}
        with open(f"Temp/tasks-page/finding/{k}.jsonl", "w", encoding="utf-8") as f:
            for row in v: f.write(json.dumps(row, ensure_ascii=False) + "\n")
    print("unique", len(allc), file=sys.stderr)
if __name__ == "__main__": main()
