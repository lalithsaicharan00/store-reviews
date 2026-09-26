# -*- coding: utf-8 -*-
"""Shared analysis engine for the Feature Ledger (Stage 4 of Report Synthesis Prompt).

Normalises the free-text card fields into the buckets the confidence rubric and the
free/paid 2x2 need, and computes both. Imported by build_report.py.
"""
import json, glob, os, re, collections

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
LEDGER = os.path.join(ROOT, "Tools", "prd_ledger")

RESEARCH_DOC = {"research_quit_habit": "Quit Habit Decision.md",
                "research_feature_gating": "Feature Gating vs Quantity.md"}

# ---------------------------------------------------------------- loading
def load():
    cards, by_report = {}, collections.defaultdict(list)
    for p in sorted(glob.glob(os.path.join(LEDGER, "*", "cards.jsonl"))):
        for line in open(p):
            if line.strip():
                c = json.loads(line)
                cards[c["id"]] = c
                by_report[c["report"]].append(c)
    points = json.load(open(os.path.join(LEDGER, "canonical.json")))
    return cards, by_report, points

def report_titles():
    t = {}
    for p in glob.glob(os.path.join(ROOT, "App Store Reports", "*.md")):
        b = os.path.basename(p)
        n = int(b.split(".")[0])
        t[n] = b[:-len(" (REPORT).md")].split(". ", 1)[1]
    for f, doc in RESEARCH_DOC.items():
        t[doc] = doc[:-3]
    return t

def report_link(r):
    """Markdown link to a report or research document."""
    import urllib.parse
    if isinstance(r, int):
        hits = glob.glob(os.path.join(ROOT, "App Store Reports", f"{r}. *.md"))
        if hits:
            return f"[{r}](<../App Store Reports/{os.path.basename(hits[0])}>)"
        return str(r)
    return f"[{r[:-3]}](<../Research Reports/{r}>)"

def sort_reports(reports):
    return sorted(reports, key=lambda r: (1, str(r)) if isinstance(r, str) else (0, r))

# ---------------------------------------------------------------- normalisers
POS = ("purchase-driver", "praise", "5★-burst", "5-star", "worth it", "converts", "satisfied",
       "life outcomes", "trust", "gold", "chose it", "switch-to", "loyal", "advocacy", "5★")
NEG = ("complaint", "1★-burst", "churn", "blocked-conversion", "downgrade", "refund", "1★", "one-star",
       "resent", "backlash", "rating drop", "worst", "hurt", "without recourse", "withholds", "deleted",
       "uninstall", "abandon", "negative", "scam", "anger", "frustrat")
REQ = ("request", "asked", "wanted")

def reaction_bucket(v):
    """positive | negative | request | neutral — from a 204-value free-text field."""
    s = (v or "").lower()
    if not s or s in ("none", "n/a", "na", ""): return "neutral"
    # an explicit mixed label stays mixed even though it contains both sides
    if s.strip() == "mixed": return "neutral"
    p = any(k in s for k in POS)
    n = any(k in s for k in NEG)
    if p and n: return "neutral"
    if p: return "positive"
    if n: return "negative"
    if any(k in s for k in REQ): return "request"
    return "neutral"

def is_purchase_driver(c):
    return "purchase-driver" in (c.get("user_reaction") or "").lower()

DIRECTION_CANON = {
    "build-free": "build-free", "free": "build-free",
    "build-paid": "build-paid", "paid": "build-paid",
    "must-have": "must-have", "must-never-break": "must-never-break",
    "product-rule": "product-rule", "do": "do", "dont": "dont", "don't": "dont",
    "research": "research", "undecided": "undecided",
}
def direction_bucket(v):
    s = (v or "").strip().lower()
    return DIRECTION_CANON.get(s)          # None for 'none', 'mixed', 'positive', kind-names etc.

HIGH = ("high-priority", "high priority", "very strong")
def is_high_priority(c):
    return any(k in (c.get("report_confidence") or "").lower() for k in HIGH)

# ---------------------------------------------------------------- magnitude
NUM = re.compile(r"(\d[\d,]*(?:\.\d+)?)")
def magnitude_score(c):
    """Exceptional-magnitude test from the Stage 4 rubric:
    mean <= 1.7 or >= 4.8 stars, a lift >= x4, or >= 50 reviews behind the point."""
    m = (c.get("magnitude") or "") + " " + (c.get("claim") or "")
    hits = []
    for mt in re.finditer(r"(\d(?:\.\d+)?)\s*(?:★|stars?\b|-star\b)", m):
        v = float(mt.group(1))
        if v <= 1.7: hits.append(f"mean {v}★")
        elif v >= 4.8: hits.append(f"mean {v}★")
    for mt in re.finditer(r"[x×]\s*(\d+(?:\.\d+)?)|(\d+(?:\.\d+)?)\s*[x×]\b", m):
        v = float(mt.group(1) or mt.group(2))
        if v >= 4: hits.append(f"lift x{v:g}")
    biggest = 0
    for mt in NUM.finditer(m):
        try: v = float(mt.group(1).replace(",", ""))
        except ValueError: continue
        if v == int(v) and v > biggest and v < 200000: biggest = int(v)
    if biggest >= 50: hits.append(f"n={biggest}")
    return hits

def point_exceptional(point, cards):
    out = []
    for cid in point["cards"]:
        c = cards.get(cid)
        if c:
            for h in magnitude_score(c): out.append((cid, h))
    return out

# ---------------------------------------------------------------- Stage 4
def apps(point):
    return len(set(point["reports"]))

FAMILY = {"build-free": "free", "build-paid": "paid",
          "do": "act", "dont": "act", "must-have": "act", "must-never-break": "act",
          "product-rule": "act", "research": "open", "undecided": "open"}

def confidence(point, cards):
    """Stage 4 rubric. Returns (level, why).

    'Same direction' is judged on the decision axis, not on the literal direction string: a point
    legitimately carries both `do` and `dont` cards (the two faces of one rule), so those collapse
    into one 'act' family. Genuine disagreement is free-vs-paid on the same capability, which is
    what 'Contested' is reserved for; contradiction cards are reported in their own section rather
    than being allowed to demote a point's confidence.
    """
    n = apps(point)
    cs = [cards[c] for c in point["cards"] if c in cards]
    dirs = collections.Counter(d for d in (direction_bucket(c.get("direction")) for c in cs) if d)
    fams = collections.Counter()
    fam_apps = collections.defaultdict(set)
    for c in cs:
        d = direction_bucket(c.get("direction"))
        if d:
            fams[FAMILY[d]] += 1
            fam_apps[FAMILY[d]].add(c["report"])
    free_n, paid_n = len(fam_apps.get("free", ())), len(fam_apps.get("paid", ()))
    if free_n >= 2 and paid_n >= 2 and max(free_n, paid_n) < 2 * min(free_n, paid_n):
        return "Contested", (f"{n} apps; free vs paid genuinely split — {free_n} apps' cards say build-free, "
                             f"{paid_n} say build-paid")
    agree, modal = 1.0, None
    if fams:
        modal, top = fams.most_common(1)[0]
        agree = top / sum(fams.values())
    same = agree >= 0.6 or not fams
    hp_reports = len({c["report"] for c in cs if is_high_priority(c)})
    label = {"free": "build-free", "paid": "build-paid", "act": "act on it", "open": "unresolved"}.get(modal, "n/a")
    if n >= 8 and same and hp_reports >= 2:
        return "Certain", f"{n} apps, same direction ({label}, {agree:.0%}), {hp_reports} reports label it high-priority"
    if n >= 4 and same:
        return "Strong", f"{n} apps, same direction ({label}, {agree:.0%})"
    if n >= 4:
        return "Strong", f"{n} apps, directions mixed ({', '.join(f'{k} {v}' for k, v in fams.most_common(3))})"
    if n in (2, 3):
        return "Moderate", f"{n} apps"
    exc = point_exceptional(point, cards)
    if n == 1 and exc:
        uniq = sorted({h for _, h in exc}, key=lambda s: (s[0], s))[:3]
        return "Moderate", f"1 app, exceptional magnitude ({'; '.join(uniq)})"
    if n == 1:
        return "Single-source", "1 app, ordinary magnitude — research before deciding"
    return "Single-source", f"{n} apps"

CONF_ORDER = {"Certain": 0, "Strong": 1, "Contested": 2, "Moderate": 3, "Single-source": 4}

def two_by_two(point, cards):
    """Free/paid 2x2 for a feature or monetization point.
    Rows: what the app does (free / paid). Columns: how users reacted (positive / negative).
    Counted in apps, not cards."""
    grid = {k: set() for k in ("free-praised", "free-expected-but-broken", "paid-converts", "paid-resented")}
    detail = collections.defaultdict(list)
    for cid in point["cards"]:
        c = cards.get(cid)
        if not c or c["kind"] not in ("feature", "monetization"): continue
        does = (c.get("this_app_does") or "").lower()
        react = reaction_bucket(c.get("user_reaction"))
        if react not in ("positive", "negative"): continue
        free = re.search(r"\bfree\b", does) and not re.search(r"\bfree\s+(?:trial|tier only)\b", does)
        paid = re.search(r"\b(paid|premium|pro\b|subscription|paywall|gated|behind)\b", does)
        if paid and not free: key = "paid-converts" if react == "positive" else "paid-resented"
        elif free and not paid: key = "free-praised" if react == "positive" else "free-expected-but-broken"
        else: continue
        grid[key].add(c["report"]); detail[key].append(cid)
    return grid, detail

def verdict(grid):
    fp, fb = len(grid["free-praised"]), len(grid["free-expected-but-broken"])
    pc, pr = len(grid["paid-converts"]), len(grid["paid-resented"])
    if pc + pr == 0 and fp + fb == 0: return "no free/paid evidence on the cards"
    if pr > pc * 1.5 and pr >= 2: return "evidence leans free (paid is mostly resented)"
    if pc > pr * 1.5 and pc >= 2: return "evidence leans paid (paid mostly converts)"
    if pc == 0 and pr == 0: return "only free-tier evidence"
    return "mixed — conditions decide"
