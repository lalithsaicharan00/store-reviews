"""Pick every Feature Ledger card that touches progress, stats, history, streaks or quit/cut-down records."""
import json, glob, re, collections
ROOT = "/home/user/store-reviews/Research/Tools/prd_ledger"
# Points whose subject IS progress/stats/history/streak/quit records
CORE = set("C011 C012 C019 C024 C032 C038 C047 C100 C101 C157 C158 C201 C216 C217 C227 C234 C243 C256 C303 C308 C265 C098 C193 C176".split())
# Points that bear on stats as a side (only if the card text also says something stats-like)
SIDE = set("C010 C016 C041 C043 C045 C048 C095 C108 C143 C155 C170 C207 C254 C262 C309 C020 C049 C052 C083 C171 C021 C135 C136 C009 C001 C002 C131 C119 C099 C102 C166 C117 C237".split())
KW = re.compile(r"\bstat(s|istic|istics|istical)?\b|chart|graph|\bprogress (view|page|screen|tab|report|bar|ring|circle)|calendar (view|history|grid)|heat ?map|history|\binsights?\b|analytic|completion (rate|%|percent)|success rate|percentage|streak|best (run|streak)|longest|relapse|\bslips?\b|trend|overview|dashboard|year(ly)? (view|grid|review|report|summary)|contribution|github|cumulative|total (days|count|time|hours)|days? since|average|\bscore\b|milestone|achievement|badge|(weekly|monthly|annual|yearly|year-end|end-of-year) (report|review|summary|recap)|recap|month(ly)? view|week(ly)? view|visuali[sz]|pie|bar chart|line chart|money saved|export|numbers?\b.{0,20}(motivat|see)|data (view|visual)|graph", re.I)
cards = []
for f in sorted(glob.glob(ROOT + "/*/cards.jsonl")):
    for l in open(f):
        c = json.loads(l)
        text = " ".join(str(c.get(k, "")) for k in ("claim", "this_app_does", "conditions", "side_effects"))
        canon = set(c.get("canonical") or [])
        k = bool(KW.search(text))
        if canon & CORE: why = "core"
        elif canon & SIDE and k: why = "side+kw"
        elif k: why = "kw"
        else: continue
        c["_why"] = why
        cards.append(c)
cards.sort(key=lambda c: (str(c["report"]).zfill(4), c["id"]))
print(len(cards), collections.Counter(c["_why"] for c in cards))
json.dump(cards, open("ledger_candidates.json", "w"), ensure_ascii=False)
