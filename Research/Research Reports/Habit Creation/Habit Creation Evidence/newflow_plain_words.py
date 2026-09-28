# Plain phrases people use for each choice (English habit-app reviews). Counts reviews containing each phrase.
import json, glob, re, collections
ROOT = "/Users/lalith/Desktop/store reviews/Research/"
files = glob.glob(ROOT + "App Store Reviews/*/reviews.jsonl") + glob.glob(ROOT + "Play Store Reviews/*/reviews.jsonl")
groups = {
 "Q1 build": {"good habit": r"\bgood habits?\b", "new habit": r"\bnew habits?\b", "build (a) habit": r"\bbuild(ing)? (a |new |good )?habits?\b", "form (a) habit": r"\bform(ing)? (a |new )?habits?\b", "start (a) habit": r"\bstart(ing)? (a |new )?habits?\b"},
 "Q1 quit": {"bad habit": r"\bbad habits?\b", "quit": r"\bquit(ting)?\b", "break (a) habit": r"\bbreak(ing)? (a |bad |the )?habits?\b", "stop (doing)": r"\bstop (smoking|drinking|doing|vaping|biting)", "cut down/back": r"\bcut(ting)? (down|back)\b"},
 "Q1 task": {"task": r"\btasks?\b", "to-do": r"\bto-?dos?\b|\bto do list", "one-time": r"\bone[- ]time (task|thing|event)", "recurring task": r"\brecurring (tasks?|to-?dos?)\b", "chores": r"\bchores?\b"},
 "Q2 tick": {"done or not": r"\bdone or not\b", "yes or no": r"\byes ?(or|/) ?no\b", "did it or not": r"\bdid (it|i do it) or not\b", "check off": r"\bcheck(ed|ing)? (it |them )?off\b", "tick off": r"\btick(ed|ing)? (it |them )?off\b", "mark (as) done": r"\bmark(ed|ing)? (it |them )?(as )?(done|complete)"},
 "Q2 number": {"how many": r"\bhow many\b", "how much": r"\bhow much\b", "count": r"\bcount(s|ing|er)?\b", "number of": r"\bnumber of\b", "amount": r"\bamounts?\b"},
 "Q2 time": {"how long": r"\bhow long\b", "timer": r"\btimers?\b", "minutes": r"\bminutes?\b", "for X minutes": r"\bfor \d+ ?(min|minutes|hours?)\b"},
 "Q2 list": {"checklist": r"\bcheck ?lists?\b", "list of": r"\ba list of\b", "subtasks": r"\bsub-?tasks?\b", "steps": r"\bsteps\b(?! ?(count|counter|a day|per day))"},
}
c = {g: collections.Counter() for g in groups}
n = 0
for f in files:
    app = f.split("Research/")[1].split("/reviews")[0]
    for line in open(f, encoding="utf-8"):
        r = json.loads(line)
        t = f"{r.get('title') or ''} {r.get('body') or r.get('text') or r.get('content') or ''}"
        if not re.search(r"\b(the|and|is|it)\b", t): continue  # English only
        if not re.search(r"\bhabit", t, re.I) and "habit" not in app.lower(): continue
        n += 1
        for g, ps in groups.items():
            for k, p in ps.items():
                if re.search(p, t, re.I): c[g][k] += 1
print("English habit-context reviews:", n)
for g, cc in c.items(): print(g, cc.most_common())
