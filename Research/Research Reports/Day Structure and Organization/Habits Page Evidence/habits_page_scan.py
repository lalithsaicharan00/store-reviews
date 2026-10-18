#!/usr/bin/env python3
"""Screen every review for the Habits page (the list of all of a person's habits): why people open it and what they
want there. Writes every match per screen, with its citation (A/P/N<N>#line), for hand reading.
Run from Research/:  python3 -I Temp/habits-page/scan.py
"""
import json, os, re, sys
ROOTS = {"A": "App Store Reviews", "P": "Play Store Reviews", "N": "Native Store Reviews"}
H = r"(habits?|tasks?|goals?|routines?|trackers?|counters?)"
PATTERNS = {
 # 1. a place that lists every habit
 "all_list": r"(\ball (of )?(my |the |your )?habits? (view|list|page|screen|tab|section|overview)"
             r"|(list|overview|page|screen|view|tab|inventory) (of|with) (all )?(my |the |your )?(current |active )?habits"
             r"|see (all|every) (of )?(my |the |your )?habits|view (all|every) (of )?(my |the |your )?habits"
             r"|manage (my |the |your |all )?habits|habit (list|manager|management|overview)\b|my habits (page|screen|tab|list|view))",
 # 2. a habit that can't be found / isn't shown on other days
 "find": r"(can'?t find (the |my |a |an |any )?(old |archived |paused |deleted )?" + H +
         r"|where (is|are|did|do) (my|the|all) (old |archived |paused )?" + H +
         r"|(habits?|tasks?) (that )?(are|is)? ?(not|n't) (due|scheduled) (today|that day)"
         r"|(see|view|show) (the )?(habits?|tasks?) (for|on) (other|future|different|upcoming) days"
         r"|habits? (that )?(don'?t|do not) (show|appear) (up )?(today|every day|on today))",
 # 3. archive / retire / restore
 "archive": r"(archiv|unarchiv|retire[ds]? (a |the |my )?(habit|goal|tracker)|(old|past|finished|former|inactive|completed) habits? (list|section|page|archive|history)"
            r"|restore (a |the |my )?(deleted |archived |old )?habit|bring (a |the )?habits? back|reactivat)",
 # 4. finding edit / delete
 "edit_delete": r"((how|can'?t|cannot|couldn'?t|unable|no way|impossible|figure out how|find how|find a way) (do i |to |you |i )?(\w+ )?(delete|remove|edit|rename|change|modify) (a |the |my |an |any |old )?(\w+ )?(habit|task|goal|routine)"
                r"|(delete|edit|rename) (button|option)"
                r"|(edit|delete|remove|change) (a |the |my )?habits? (is|are) (hard|difficult|hidden|impossible|confusing|not possible))",
 # 5. order and sorting
 "order": r"(reorder|re-order|rearrang|re-arrang|(sort|order|organi[sz]e) (my |the |your |all )?(\w+ )?(habits|tasks|goals|list)"
          r"|order of (my |the |your )?(habits|tasks|goals|list)|drag (and drop|to (re)?order|habits)|sort(ing)? (by|option|function|feature)"
          r"|alphabetic|chronolog)",
 # 6. groups / categories / folders / tags, as a way of viewing the list
 "groups_view": r"((group|categor|folder|tag|area|list)\w* (view|page|tab|screen|section|header|filter)"
                r"|(by|per|into|in) (group|category|categories|folder|area|tag|life area)s?\b"
                r"|(group|sort|organi[sz]e|separate|split) (them |habits |my habits |tasks )?by (time|time of day|category|group|area|tag|type)"
                r"|morning,? (afternoon|evening)|time of (the )?day (section|group|categor))",
 # 7. search
 "search": r"(search (bar|box|field|function|feature|option)|(search|find) (for )?(a |my |the )?(specific |particular )?habit|search (through|my|habits|tasks)|filter (habits|tasks|by))",
 # 8. several at once / duplicate
 "bulk_dup": r"(bulk|(select|delete|edit|archive|move|pause) (multiple|several|many|all) (\w+ )?(habits|tasks|goals)|multi-?select"
             r"|duplicat\w* (a |the |my )?(habit|task|routine)|(copy|clone) (a |the |my |an existing )?(habit|task|routine))",
 # 9. too many / long list / clutter
 "long_list": r"((too many|lots of|a lot of|so many|dozens of|\d\d+|hundreds of) (habits|tasks|goals|trackers|counters)\b.{0,80}(scroll|list|clutter|messy|find|overwhelm|long|organi)"
              r"|(list|screen|page) (gets|is|becomes|got) (too )?(long|cluttered|messy|crowded|overwhelming)|endless scroll|scroll(ing)? (forever|through (all|a long|my)))",
 # 10. an overview of every habit's stats at once
 "overview_stats": r"((stats|statistics|streaks?|progress|overview|summary|completion rate) (of|for|across) (all|every|each) (of )?(my |the )?habits"
                   r"|(all|every) (my )?habits'? (stats|statistics|streaks|progress) (at once|in one|on one|together)"
                   r"|compare (my |the )?habits|at a glance)",
}
PATTERNS = {k: re.compile(v, re.I) for k, v in PATTERNS.items()}
def text_of(r):
    return " ".join(x for x in (r.get("title"), r.get("body"), r.get("text")) if x)
def main():
    out = {k: [] for k in PATTERNS}; total = 0
    for prefix, root in ROOTS.items():
        for folder in sorted(os.listdir(root)):
            path = os.path.join(root, folder, "reviews.jsonl")
            if not os.path.exists(path): continue
            n = folder.split(".")[0]
            with open(path, encoding="utf-8") as f:
                for i, line in enumerate(f):
                    total += 1
                    r = json.loads(line); t = text_of(r)
                    if len(t) < 25: continue
                    for k, p in PATTERNS.items():
                        if p.search(t):
                            out[k].append({"cite": f"{prefix}{n}#{i}", "app": r.get("app_name"), "rating": r.get("rating"),
                                           "date": (r.get("date") or "")[:10], "lang": r.get("language") or r.get("country"),
                                           "text": t})
    print("screened", total, file=sys.stderr)
    for k, v in out.items():
        print(k, len(v), sum(1 for x in v if x['cite'][0] in 'AP'), file=sys.stderr)
        with open(f"Temp/habits-page/{k}.jsonl", "w", encoding="utf-8") as f:
            for row in v: f.write(json.dumps(row, ensure_ascii=False) + "\n")
if __name__ == "__main__": main()
