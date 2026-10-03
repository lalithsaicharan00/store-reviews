"""Screen for reviews that talk about habits AND one-time tasks/to-dos in the same app, plus order/placement/separation words.
Cite ids as in ../screen.py (store letter + folder number + '#' + 0-based line). Writes mix_cand.jsonl.
Run: python3 tasks_screen.py (from Research/Temp/arrange/tasks/)"""
import json, re, os, sys, collections
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))
os.chdir(os.path.dirname(os.path.abspath(__file__)))
import screen
HAB = re.compile(r"\bhabits?\b|\bh[áa]bitos?\b|\bgewohnheit|\bhabitudes?\b|привычк", re.I)
TASK = re.compile(r"\bto-?\s?dos?\b|\btodo\s?lists?\b|\btasks?\b|\bone[\s-]?(time|off)\b|\bsingle\s+tasks?\b|\btareas?\b|\btarefas?\b|\baufgaben?\b|\bt[âa]ches?\b|задач", re.I)
# both item kinds named as distinct things: "habits and tasks", "tasks and habits", "habits ... to-dos", "habits as well as tasks"...
PAIR = re.compile(r"(habits?|h[áa]bitos)\W+(and|&|\+|or|vs\.?|versus|y|e|with|plus|as\s+well\s+as|along\s+with|together\s+with|alongside)\W+(to-?\s?dos?|tasks?|tareas|tarefas|one[\s-]?time)"
                  r"|(to-?\s?dos?|tasks?|tareas|tarefas|one[\s-]?time\s+\w+)\W+(and|&|\+|or|vs\.?|versus|y|e|with|plus|as\s+well\s+as|along\s+with|together\s+with|alongside)\W+(habits?|h[áa]bitos|recurring)"
                  r"|(to-?\s?dos?|todo\s?list|one[\s-]?time\s+tasks?|one[\s-]?off)", re.I)
PLACE = re.compile(r"re-?order|re-?arrang|\bsort|drag|\border\b|\btop\b|\bbottom\b|\bfirst\b|\babove\b|\bbelow\b|\bbefore\b|\bafter\b|separat|\bmix|together|same\s+(list|screen|page|view|place)"
                   r"|clutter|combin|merge|\bbur(y|ied)|push\w*\s+(down|up)|mess|confus|distinguish|differentiat|tell\s+(them\s+)?apart|\bsplit|\btab\b|own\s+(list|section|tab|page)|different\s+(list|section|tab|page|screen)"
                   r"|integrat|in\s+one\s+(place|list|app|screen)|one\s+list|single\s+list|\bseparad|\bjunt|mezcl|misturad|orden|ordem", re.I)
out = []; tot = collections.Counter(); hit = collections.Counter()
for store, folder, n, i, r, text in screen.recs():
    t = screen.tier(store, n); tot[t] += 1
    if not (HAB.search(text) and TASK.search(text) and PAIR.search(text) and PLACE.search(text)): continue
    hit[t] += 1
    out.append({"cite": f"{screen.LET[store]}{n}#{i}", "folder": folder, "tier": t, "id": r["review_id"], "rating": r.get("rating"),
                "date": (r.get("date") or "")[:10], "text": text})
with open("mix_cand.jsonl", "w") as w:
    for c in out: w.write(json.dumps(c, ensure_ascii=False) + "\n")
print("totals", dict(tot), "hits", dict(hit))
