#!/usr/bin/env python3
"""Coverage validator for one report's cards. Run from anywhere:

    python3 Tools/prd_ledger/validate.py <N>

Checks (see Report Synthesis Prompt.md, Stage 2):
  1. every heading in the analytical body is cited by a card or excused in coverage.json
  2. every table row maps to a card
  3. every bold phrase is referenced by a card
  4. every Part 8 numbered item maps to a card
  5. every review ID on a card exists in reviews.jsonl
  6. no card has an empty claim / kind / direction / magnitude / where
  7. every kind was searched for (zero-card kinds must be excused in coverage.json)

Matching is token-based and deliberately generous; anything it cannot match is
listed so a human resolves it — by adding a card or an explicit coverage.json entry:
  {"heading": "...", "cards": ["R01-012"]}          or  {"heading": "...", "no_new_insight": "..."}
  {"table_row": "...", "cards": [...]}              or  {"table_row": "...", "no_new_insight": "..."}
  {"bold": "...", "cards": [...]}                   or  {"bold": "...", "no_new_insight": "..."}
  {"kind": "...", "none_in_report": "..."}
"""
import json, re, sys, glob, os

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
KINDS = ["feature","monetization","product-rule","must-have","must-never-break","do","dont","tactic",
         "insight","audience","market","timeline","anti-pattern","contradiction","positioning","data-caveat"]
REQUIRED = ["id","report","where","kind","claim","this_app_does","user_reaction","magnitude","direction",
            "report_confidence","generalisable","review_ids"]
STOP = set("the and for with that this from what into over your than then them they have been were will "
           "does about after before which while where when there these those only also just more most "
           "very each into onto".split())

def find_report(n):
    hits = glob.glob(os.path.join(ROOT, "App Store Reports", f"{n}. *.md"))
    assert len(hits) == 1, hits
    return hits[0]

def find_reviews(n):
    hits = glob.glob(os.path.join(ROOT, "App Store Reviews", f"{n}. *", "reviews.jsonl"))
    assert len(hits) == 1, hits
    return hits[0]

def stem(t):
    t = t.lower()
    for suf in ("ies", "es", "s"):
        if t.endswith(suf) and len(t) - len(suf) >= 4:
            return t[: -len(suf)] + ("y" if suf == "ies" else "")
    return t

def tokens(s):
    return {stem(t) for t in re.findall(r"[\w★%$¥£€₹₺]+", s)
            if (len(t) >= 4 or "★" in t or (len(t) >= 2 and t.isupper())) and t.lower() not in STOP}

def numbers(s):
    # bare numbers: strip x/× prefixes, % suffixes, thousands commas, trailing punctuation
    out = set()
    for m in re.findall(r"\d[\d,]*(?:\.\d+)?", s):
        m = m.rstrip(",.").replace(",", "")
        if m: out.add(m)
    return out

def main(n):
    n = int(n)
    folder = os.path.join(ROOT, "Tools", "prd_ledger", str(n))
    cards = [json.loads(l) for l in open(os.path.join(folder, "cards.jsonl")) if l.strip()]
    cov_path = os.path.join(folder, "coverage.json")
    cov = json.load(open(cov_path)) if os.path.exists(cov_path) else []
    report = open(find_report(n)).read().split("\n")

    # --- analytical body: stop at Part 9 / Appendix ---
    end = len(report)
    for i, l in enumerate(report):
        if re.match(r"^#{1,2} .*(PART 9|Appendix|APPENDIX)", l):
            end = i; break
    body = report[:end]

    problems = []

    # 6. required fields
    ids = set()
    for c in cards:
        for k in REQUIRED:
            if k not in c or c[k] in ("", None, []) and k != "review_ids":
                problems.append(f"card {c.get('id')} missing/empty field {k}")
        if c["id"] in ids: problems.append(f"duplicate card id {c['id']}")
        ids.add(c["id"])
        if c["kind"] not in KINDS: problems.append(f"card {c['id']} unknown kind {c['kind']}")

    # card text used for matching
    ctext = {c["id"]: (" ".join(str(c.get(k, "")) for k in
             ["where","claim","this_app_does","magnitude","side_effects","conditions"]) + " " +
             " ".join(c.get("review_ids", []))) for c in cards}
    ctok = {cid: tokens(t) for cid, t in ctext.items()}
    cnum = {cid: numbers(t) for cid, t in ctext.items()}

    def excused(kind, key):
        for e in cov:
            if e.get(kind) == key:
                return e.get("cards") or e.get("no_new_insight") or e.get("none_in_report")
        return None

    # 1. headings
    heads = [(i, l) for i, l in enumerate(body) if re.match(r"^#{1,3} ", l)]
    for i, h in heads:
        text = re.sub(r"^#+ ", "", h)
        m = re.match(r"^(\d+)\.(\d+)", text)
        key_sec = f"§{m.group(1)}.{m.group(2)}" if m else None
        pm = re.match(r"^PART (\d+)", text)
        key_part = f"part {pm.group(1)}" if pm else None
        ok = False
        for cid, w in ((c["id"], c["where"].lower()) for c in cards):
            if key_sec and key_sec.lower() in w: ok = True; break
            if key_part and (key_part in w or ("§" + key_part.split()[1] + ".") in w): ok = True; break
        if not ok and not key_sec and not key_part:
            tk = tokens(text)
            for cid in ctok:
                if tk and len(tk & ctok[cid]) >= max(1, len(tk)//2): ok = True; break
        if not ok and not excused("heading", text):
            problems.append(f"HEADING not covered (line {i+1}): {text}")

    # 2. table rows
    for i, l in enumerate(body):
        if not l.startswith("|") or re.match(r"^\|[\s\-:|]+\|$", l): continue
        cells = [c.strip().strip("*").strip("`") for c in l.strip("|").split("|")]
        if all(not re.search(r"\d", c) for c in cells[1:]) and i+1 < len(body) and re.match(r"^\|[\s\-:|]+\|$", body[i+1]):
            continue  # header row
        label = cells[0]
        if not label: continue
        rownums = {x for x in numbers(l) if len(x.replace(".", "")) >= 2}
        rowids = set(re.findall(r"`(\d{6,})`", l))
        ltok = tokens(label)
        ok = False
        for cid in ctok:
            if rowids and rowids & set(re.findall(r"\d{6,}", ctext[cid])): ok = True; break
            strong = {x for x in rownums if len(x.replace(".", "")) >= 3 or "." in x}
            if len(rownums & cnum[cid]) >= 2 and (not ltok or ltok & ctok[cid] or len(strong & cnum[cid]) >= 2): ok = True; break
            if strong & cnum[cid] and ltok and ltok & ctok[cid]: ok = True; break
            if ltok and len(ltok & ctok[cid]) >= max(1, (len(ltok)+1)//2) and (not rownums or rownums & cnum[cid]): ok = True; break
        if not ok and not excused("table_row", label):
            problems.append(f"TABLE ROW not covered (line {i+1}): {label} | {' | '.join(cells[1:])[:80]}")

    # 3. bold phrases
    seen = set()
    for i, l in enumerate(body):
        if l.startswith("#"): continue
        for b in re.findall(r"\*\*(.+?)\*\*", l):
            b = b.strip().strip("`").strip()
            if b in seen: continue
            seen.add(b)
            btok = tokens(b); bnum = {x for x in numbers(b) if len(x.replace(".", "")) >= 2}
            if not btok and not bnum: continue
            ok = False
            for cid in ctok:
                if btok and len(btok & ctok[cid]) >= max(1, (len(btok)+1)//2): ok = True; break
                if bnum and bnum <= cnum[cid]: ok = True; break
            if not ok and not excused("bold", b):
                problems.append(f"BOLD not covered (line {i+1}): {b[:90]}")

    # 4. Part 8 numbered items
    in8 = False
    for i, l in enumerate(body):
        if re.match(r"^# PART 8", l): in8 = True; continue
        if in8 and re.match(r"^# PART", l): in8 = False
        if in8:
            m = re.match(r"^(\d+)\. ", l)
            if m:
                k = f"part 8 #{m.group(1)}"
                if not any(k in c["where"].lower() for c in cards):
                    problems.append(f"PART 8 item #{m.group(1)} has no card (line {i+1})")

    # 5. review IDs
    valid = set()
    with open(find_reviews(n)) as f:
        for l in f:
            valid.add(json.loads(l)["review_id"])
    for c in cards:
        for rid in c.get("review_ids", []):
            if rid not in valid:
                problems.append(f"card {c['id']} cites unknown review id {rid}")

    # 7. kinds
    present = {c["kind"] for c in cards}
    for k in KINDS:
        if k not in present and not excused("kind", k):
            problems.append(f"KIND {k} has zero cards and no none_in_report note")

    print(f"report {n}: {len(cards)} cards, {len(heads)} headings, body lines {end}")
    for p in problems: print("  -", p)
    print(f"{len(problems)} problems")
    return 1 if problems else 0

if __name__ == "__main__":
    sys.exit(main(sys.argv[1]))
