"""Seeded reading samples from habit-tier hits (seed 20261003), weighted toward 1-3 stars.
A review is read once; its row lists every theme it was drawn for. Writes batches/<theme>NN.txt and sample.jsonl.
Strata:
  ORDER   : habit-tier ORDER hits that also match STRONG (drops 'top of the list', 'sort of'-type noise): 100 low (1-3) + 60 high (4-5)
  ORDREM  : ORDER-STRONG hits that also mention reminders / times (targeted, for 'what do people with no reminders want'): 30
  ORDCHG  : 45 low + 20 high
  DISC    : 45 low + 25 high
  FILTER  : 40 low + 30 high
"""
import json, random, re, os, collections
os.chdir(os.path.dirname(os.path.abspath(__file__)))
C = [json.loads(l) for l in open("cand.jsonl")]
H = [c for c in C if c["tier"] == "habit"]
STRONG = re.compile(r"(re-?order|re-?arrang|drag|alphabet|a[\s-]?(to|-)[\s-]?z\b|custom\s+order|manual\w*\s+(order|sort)|own\s+order|sort\w*\s+(by|habits|tasks|them|option|order|function|feature)|(change|set|choose|keep|save)\s+(the\s+|my\s+)?order|order\s+(of|in\s+which)\s+(the\s+|my\s+)?(habits?|tasks?|items?|routines?|things|activities)|(habits?|tasks?)\s+order|move\s+(habits?|tasks?|them|it|items?)\s+(up|down|around)|jump\w*\s+around|random\w*\s+order|(goes|go|move|moves|moved)\s+(down\s+)?to\s+the\s+(bottom|top|end)"
                    r"|reorden|ordenar|orden\s+de|ordem|arrast|sortier|reihenfolge|verschieb|r[ée]organis|ordre|trier|riordin|ordine|порядок|порядк|сортир|перетаск|並び|順番|順序|ソート|순서|정렬|排序|顺序|拖|sırala|ترتيب)", re.I)
REM = re.compile(r"(remind|notif|alarm|time\s+of\s+(the\s+)?day|by\s+time|scheduled?\s+time|clock|morning|evening|night|lembrete|recordatorio|erinnerung|rappel|promemoria|напомин|リマインド|通知|알림|提醒)", re.I)
rnd = random.Random(20261003)
def pick(pool, n_low, n_high, taken):
    pool = [c for c in pool if c["cite"] not in taken]
    low = [c for c in pool if (c["rating"] or 0) <= 3]; high = [c for c in pool if (c["rating"] or 0) >= 4]
    rnd.shuffle(low); rnd.shuffle(high)
    return low[:n_low] + high[:n_high]
plan = [("ORDER", [c for c in H if "ORDER" in c["fam"] and STRONG.search(c["text"])], 100, 60),
        ("ORDREM", [c for c in H if "ORDER" in c["fam"] and STRONG.search(c["text"]) and REM.search(c["text"])], 20, 10),
        ("ORDCHG", [c for c in H if "ORDCHG" in c["fam"]], 45, 20),
        ("DISC", [c for c in H if "DISC" in c["fam"]], 45, 25),
        ("FILTER", [c for c in H if "FILTER" in c["fam"]], 40, 30)]
taken = {}; pools = {}
for theme, pool, nl, nh in plan:
    pools[theme] = len(pool)
    for c in pick(pool, nl, nh, taken):
        taken[c["cite"]] = dict(c, drawn=theme)
print("pool sizes (habit tier):", pools)
os.makedirs("batches", exist_ok=True)
by = collections.defaultdict(list)
for c in taken.values(): by[c["drawn"]].append(c)
with open("sample.jsonl", "w") as w:
    for theme, rows in by.items():
        for b in range(0, len(rows), 40):
            with open(f"batches/{theme}{b//40:02d}.txt", "w") as f:
                for c in rows[b:b+40]:
                    f.write(f"{c['cite']} ★{c['rating']} [{c['folder'][:28]}] {c['text']}\n\n")
        for c in rows: w.write(json.dumps({k: c[k] for k in ("cite", "id", "folder", "rating", "date", "fam", "drawn")}, ensure_ascii=False) + "\n")
print({k: len(v) for k, v in by.items()})
