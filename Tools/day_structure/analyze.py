"""analyze.py -> secondary breakdowns on the hand-coded set (coded.jsonl).

Keyword sub-typing below runs ONLY inside reviews already hand-coded with the parent code,
so it splits a validated set; it never adds reviews."""
import json, re, collections, statistics, sys
IDX = [json.loads(l) for l in open("index.jsonl")]
C = [json.loads(l) for l in open("coded.jsonl")]
TXT = {r["i"]: r["text"] for r in IDX}
FLAGS = {"$", "L", "W", "I", "D"}

def has(c, k): return k in c["codes"]
def pct(a, b): return f"{a}/{b} ({100*a/b:.1f}%)" if b else "0/0"

def subtype(code, rules, only_habit=True):
    rows = [c for c in C if has(c, code) and not (only_habit and has(c, "D"))]
    out = collections.Counter(); hits = collections.defaultdict(list)
    for c in rows:
        t = TXT[c["i"]]; matched = False
        for name, rx in rules:
            if name == "$" and has(c, "$") or name != "$" and re.search(rx, t, re.I):
                out[name] += 1; hits[name].append(c["i"]); matched = True
        if not matched: out["(other)"] += 1
    print(f"\n{code} subtypes (n={len(rows)}{', habit context' if only_habit else ''}):")
    for k, v in out.most_common(): print(f"  {k:28} {pct(v, len(rows))}   e.g. {hits[k][:8]}")
    return rows, hits

# mean rating and low-star share per code
print("code  n  mean★  1-2★share  L")
per = collections.defaultdict(list)
for c in C:
    for k in c["codes"]:
        if k not in FLAGS: per[k].append(c)
for k in sorted(per):
    rs = [c["rating"] for c in per[k]]
    print(f'{k:3} {len(rs):5} {statistics.mean(rs):.2f} {100*sum(r<=2 for r in rs)/len(rs):5.1f}%  L={sum(has(c,"L") for c in per[k])}')

# GROUPS: display form
g = [c for c in C if any(has(c, k) for k in ("G+", "G?", "GF", "GV", "GL", "GS", "GD", "GN")) and not has(c, "D")]
print("\nGROUP reviews (habit context):", len(g))
gv = [c for c in g if has(c, "GV")]; gl = [c for c in g if has(c, "GL")]
print("  GV visible headers/collapsible:", len(gv), "| GL filter/tab/list switching:", len(gl), "| both:", sum(has(c, "GL") for c in gv))
FILTER_CRIT = r"(not (just|only) (as )?a filter|without (having to )?filter|instead of (just )?filter|(filter|tabs?).{0,40}(burden|annoying|tedious|extra (tap|click|step)|lose sight|hidden|hide)|display tags under|visible without|lose sight of the other)"
fc = [c["i"] for c in g if re.search(FILTER_CRIT, TXT[c["i"]], re.I)]
print("  explicit critique of filter-only / hidden-behind-filter wording:", len(fc), fc[:20])
COLOR_WORK = r"(colou?r).{0,60}(categor|group|separat|sort|workaround)|(categor|group).{0,60}(by|with|using) colou?r"
cw = [c["i"] for c in g if re.search(COLOR_WORK, TXT[c["i"]], re.I)]
print("  colour-as-category workaround mentions:", len(cw))
LONG = r"(long list|scroll|clutter|overwhelm|messy|jumbl|mixed|one (big|long|giant))"
ll = [c["i"] for c in g if has(c, "G?") and re.search(LONG, TXT[c["i"]], re.I)]
print("  G? citing long list / scrolling / clutter:", pct(len(ll), sum(has(c, 'G?') for c in g)))
tod_as_group = [c["i"] for c in g if re.search(r"\b(morning|evening|night|afternoon|am\b|pm\b)", TXT[c["i"]], re.I)]
print("  group reviews that name a time of day as a group:", len(tod_as_group))

subtype("GF", [
    ("$", None),
    ("cannot edit/delete/rename", r"(delet|remov|rename|edit|chang|modif|borrar|eliminar|editar|excluir|l[öo]sch|удал|измен|수정|삭제).{0,40}(tag|categor|label|etiquet|group|folder|карег|тег|категор|태그|카테고리)|(tag|categor|label|etiquet|тег|категор|태그|카테고리).{0,40}(delet|remov|rename|edit|chang|borrar|eliminar|editar|excluir|удал|измен|수정|삭제)"),
    ("preset/forced/limited set", r"(preset|predefin|pre-?defin|built.?in|default|only \d|only (four|five|two|three)|limited|fixed|forced|must (choose|pick|select)|have to (choose|pick|select)|obligator|predetermin|vienen|precargad|встроенн|нужно выбирать|надо выбирать)"),
    ("order/sort of groups", r"(order|reorder|sort|arrang|rearrang|orden|ordenar|reihenfolge|порядок|순서|alphabet)"),
    ("bug/lost/disappear", r"(bug|crash|glitch|disappear|lost|vanish|sumir|desapare|verschwind|исчез|error|오류)"),
    ("colour/icon choice", r"(colou?r|icon|emoji|cores|colores|farb|цвет|иконк|아이콘|색)"),
])
subtype("TF", [
    ("$", None),
    ("hidden/auto-switch/split", r"(hide|hidden|disappear|only shows?|can'?t see|auto(matic)?ally (switch|move)|switch(es)? to|separate (page|tab|screen)|one (page|list)|overview|all day)"),
    ("removed/changed in update", r"(remov|update|no longer|took away|gone|got rid|used to)"),
    ("wrong section/rollover time", r"(midnight|reset|day (end|start)|late|night shift|after 12|wrong (section|time)|rollover|4 ?am|3 ?am)"),
    ("too coarse/need exact time", r"(exact|specific time|clock|hour|timeline|schedule)"),
])
subtype("RF", [
    ("$", None),
    ("forced timer / want plain check-off", r"(without (a |the )?timer|no timer|don'?t (want|need).{0,20}timer|forced|have to (wait|use the timer)|can'?t (just )?(check|tick|mark)|timer.{0,30}(annoy|stress|anxi|pressure|rush))"),
    ("timer stops/background/notification", r"(background|lock(ed)? screen|screen off|stops?|pause|notification|close the app|minimi[sz])"),
    ("rigid order / skip / reorder", r"(skip|order|rearrang|reorder|go back|previous|rigid|sequence|out of order)"),
    ("watch", r"(watch|wear ?os)"),
    ("auto-advance / manual next", r"(auto(matic)?(ally)? (start|next|advance|move)|next (step|task).{0,30}(automatic|manual)|press(ing)? next|tap next)"),
    ("start-time tied / schedule", r"(start time|scheduled|specific time|set time|time of day|at \d)"),
])
subtype("S?", [("threshold/partial credit", r"(partial|percent|%|some of|x of|out of|at least|half)"),
               ("parent auto-complete", r"(automatic|auto[- ]?complete|mark(s|ed)? (the )?(whole|parent|main)|when all)"),
               ("typed/timer/count per item", r"(timer|minutes|duration|count|number|reps|amount|how many)")])
subtype("SF", [("$", None),
               ("partial / all-or-nothing", r"(partial|all or nothing|every single|not (considered )?done|incomplete|percent|%)"),
               ("display/collapse/inline", r"(expand|collapse|inline|show|display|visible|click (in|into)|open)"),
               ("reorder/edit/limit", r"(order|reorder|edit|limit|max|only \d)"),
               ("bug/lost", r"(bug|crash|lost|disappear|reset)")])

# sub-habits: checkbox vs typed demand in habit context
h = [c for c in C if not has(c, "D")]
s_any = [c for c in h if any(has(c, k) for k in ("S+", "S?", "ST", "SP", "SF", "SN"))]
print("\nSUB habit-context reviews:", len(s_any),
      "| S+", sum(has(c, "S+") for c in s_any), "| S?", sum(has(c, "S?") for c in s_any),
      "| ST", sum(has(c, "ST") for c in s_any), "| SP", sum(has(c, "SP") for c in s_any),
      "| SF", sum(has(c, "SF") for c in s_any), "| SN", sum(has(c, "SN") for c in s_any))
st_only = [c for c in s_any if has(c, "ST")]
print("  ST share of sub-habit reviews:", pct(len(st_only), len(s_any)))
ST_KIND = [("time/duration/timer", r"(timer|time|minute|duration|hour|seconds)"), ("count/number/amount", r"(count|number|reps|amount|how many|quantity|\d+ ?x)"),
           ("per-item stats/reminders", r"(stat|track|progress|reminder|history|streak)")]
for n, rx in ST_KIND:
    print(f"   ST mentions {n}: {sum(bool(re.search(rx, TXT[c['i']], re.I)) for c in st_only)}")

# routines: dual-mode praise, container
r_all = [c for c in C if any(has(c, k) for k in ("R+", "R?", "RF", "RC", "RS", "RU", "HT"))]
print("\nROUTINE reviews:", len(r_all))
DUAL = r"(checklist|check ?off|tick).{0,80}(or|and|without).{0,40}(timer|guided|play|start)|(timer|guided|play).{0,60}(optional|or (just )?(check|tick))|without (a |the )?timer"
dual = [c["i"] for c in r_all if re.search(DUAL, TXT[c["i"]], re.I)]
print("  mentions checklist-vs-timer choice:", len(dual), dual[:15])
ADHD = [c for c in r_all if re.search(r"adhd|add\b|tdah|сдвг|autis|executive function", TXT[c["i"]], re.I)]
print("  routine reviews mentioning ADHD/autism/EF:", len(ADHD), "| of which R+:", sum(has(c, "R+") for c in ADHD))
print("  R+ apps:", collections.Counter(f'{c["store"][0]}{c["folder"].split(".")[0]}' for c in C if has(c, "R+")).most_common(8))
