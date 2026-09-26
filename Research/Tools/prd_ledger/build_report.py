# -*- coding: utf-8 -*-
"""Stage 5 — build Research Reports/Feature Ledger.md from canonical.json and every cards.jsonl.

    python3 Tools/prd_ledger/build_report.py

Structure: ranked decision views first (what wins, what loses, what drives purchases, what is a
hero feature), then the full evidence for every canonical point, then the card-level material the
points do not carry (the nuance register, contradictions, audiences and markets, timelines,
data caveats) and finally an index of all cards.

Every canonical point's full entry appears exactly once, anchored; the ranked views link to it.
"""
import sys, os, json, re, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import ledger_lib as L

cards, by_report, points = L.load()
live = [p for p in points if not p.get("merged_into")]
merged_away = [p for p in points if p.get("merged_into")]
P = {p["id"]: p for p in points}
TITLES = L.report_titles()
APP_REPORTS = sorted(r for r in by_report if isinstance(r, int))
DOC_REPORTS = sorted(r for r in by_report if isinstance(r, str))

CONF = {}; TALLY = {}
for p in live:
    CONF[p["id"]] = L.confidence(p, cards)
    pos, neg, pd, pdc, appspec = set(), set(), set(), [], []
    for cid in p["cards"]:
        c = cards.get(cid)
        if not c: continue
        b = L.reaction_bucket(c.get("user_reaction"))
        if b == "positive": pos.add(c["report"])
        if b == "negative": neg.add(c["report"])
        if L.is_purchase_driver(c):
            pd.add(c["report"]); pdc.append(cid)
            if c.get("generalisable") == "app-specific": appspec.append(cid)
    TALLY[p["id"]] = dict(pos=pos, neg=neg, pd=pd, pdc=pdc, appspec=appspec)

def anchor(pid): return pid.lower()
def ref(pid):
    p = P[pid]
    return f"[{pid}](#{anchor(pid)}) {p['title']}"
def plain(reports, limit=None):
    """Report numbers as plain text — for dense ranked tables, where a linked list of 30 long
    filenames makes the row unreadable. The point's own entry below carries the linked list."""
    rs = L.sort_reports(set(reports))
    shown = rs if limit is None or len(rs) <= limit else rs[:limit]
    s = ", ".join(str(r)[:-3] if isinstance(r, str) else str(r) for r in shown)
    if limit is not None and len(rs) > limit: s += f" +{len(rs)-len(shown)} more"
    return s

def links(reports, limit=None):
    rs = L.sort_reports(set(reports))
    shown = rs if limit is None or len(rs) <= limit else rs[:limit]
    s = ", ".join(L.report_link(r) for r in shown)
    if limit is not None and len(rs) > limit: s += f" … (+{len(rs)-len(shown)} more)"
    return s
def esc(s): return (s or "").replace("|", "\\|").replace("\n", " ")
def short(s, n):
    s = re.sub(r"\s+", " ", s or "").strip()
    return s if len(s) <= n else s[:n].rsplit(" ", 1)[0] + "…"

O = []
def w(*lines): O.extend(lines)

# ===================================================================== front matter
total_cards = len(cards)
nuance = sorted([c for c in cards.values() if not c.get("canonical")],
                key=lambda c: (-len(L.magnitude_score(c)), str(c["report"]), c["id"]))
w(f"""# Feature Ledger — every finding from {len(APP_REPORTS)} App Store review reports

**What this is.** One consolidated record of everything the review analysis found, built so that
any statement here resolves back to a report section and to individual review IDs. It reports the
evidence; it does not choose the product. The decisions are made on top of it, in
`PRD for App Store.md`.

**Scope.** {len(APP_REPORTS)} per-app reports in `App Store Reports/`, plus {len(DOC_REPORTS)} research documents in
`Research Reports/`. Every review in every corpus was read individually in its original language —
no sampling, no keyword filtering. Apps whose corpora were too small to support claims were never
analysed, so the {len(APP_REPORTS)} reports here are the ones with enough evidence to carry findings.

**How it was built.** Each report was read section by section and turned into cards — one card per
distinct thing the report says, keeping the report's own words, numbers and review IDs
({total_cards:,} cards). Cards were then attached to canonical points ({len(live)} live points,
{len(merged_away)} merged away and kept for history). Cards are never rewritten or deleted, so
merging cannot lose a detail: {len(nuance):,} cards attached to no point at all and are reproduced in full
in Part 9.

| | |
|---|---|
| App reports | {len(APP_REPORTS)} |
| Research documents | {len(DOC_REPORTS)} |
| Cards | {total_cards:,} |
| Canonical points (live) | {len(live)} |
| Points merged away (history kept) | {len(merged_away)} |
| Cards attached to a point | {total_cards - len(nuance):,} |
| Cards in the nuance register (Part 9) | {len(nuance):,} |

---

## How to read this

**Apps are counted, not reviews.** Corpora differ in size by more than 100×, so two large apps must
not outvote forty small ones. Review totals appear as supporting magnitude, never as the ranking unit.

**Confidence** is computed from the ledger, not asserted:

| Level | Rule |
|---|---|
| **Certain** | ≥ 8 apps, same direction, and ≥ 2 reports label it high-priority |
| **Strong** | 4–7 apps, same direction |
| **Moderate** | 2–3 apps, **or** 1 app with exceptional magnitude (mean ≤ 1.7★ or ≥ 4.8★, lift ≥ ×4, or ≥ 50 reviews behind it) |
| **Single-source** | 1 app, ordinary magnitude — kept, and labelled research before deciding |
| **Contested** | apps genuinely disagree on free vs paid for the same capability — both sides listed with their conditions |

A point holding both `do` and `dont` cards is not a disagreement — those are the two faces of one
rule. *Contested* is reserved for the free-versus-paid axis, which is the one that changes what gets built.

**Positive and negative evidence** are counted separately, in apps. A point can be high on both
(the habit cap is praised in {len(TALLY['C007']['pos'])} apps and complained about in {len(TALLY['C007']['neg'])}) — that is a signal about
the decision being contested, not a contradiction in the data.

**Every number carries its denominator.** Where a percentage appears it is the report's own, against
that report's corpus. Country claims need 50 reviews in that storefront to stand alone; below that the
report labels the evidence as limited and so does this ledger.

---

## Contents

1. [What wins — ranked](#part-1)
2. [What loses — ranked](#part-2)
3. [What drives purchases — ranked](#part-3)
4. [Hero features — what one app won on](#part-4)
5. [Product rules and insights](#part-5)
6. [Features — free, paid, undecided, research](#part-6)
7. [Must-haves and must-never-break](#part-7)
8. [Things to do and not to do, with the tactics that produced them](#part-8)
9. [High-impact rare findings — the complete nuance register](#part-9)
10. [Contradictions](#part-10)
11. [Audiences and markets](#part-11)
12. [Timeline lessons](#part-12)
13. [Data caveats](#part-13)
14. [Card index](#part-14)

---
""")

# ===================================================================== Part 1-4 ranked views
def ranked_table(rows, headers, note):
    w(note, "")
    w("| " + " | ".join(headers) + " |")
    w("|" + "|".join(["---"] * len(headers)) + "|")
    for r in rows: w("| " + " | ".join(str(x) for x in r) + " |")
    w("")

w('<a id="part-1"></a>\n## Part 1 — What wins, ranked\n')
w("""Points ranked by the number of apps whose reviews show a **positive** reaction — praise, purchase
or explicit loyalty — attached to that point. This is the "get this right and people say so" list.
`+apps` is the count of apps with positive evidence; `−apps` is the count with negative evidence on
the same point, shown because the two together are what makes a point worth attention: a point high
on both is a live decision, a point high only on `+` is a safe bet.
""")
winners = sorted(live, key=lambda p: (-len(TALLY[p["id"]]["pos"]), -L.apps(p)))
winners = [p for p in winners if len(TALLY[p["id"]]["pos"]) >= 3]
ranked_table([(i, f"**{len(TALLY[p['id']]['pos'])}**", len(TALLY[p["id"]]["neg"]), len(TALLY[p["id"]]["pd"]),
               CONF[p["id"]][0], esc(ref(p["id"])))
              for i, p in enumerate(winners, 1)],
             ["#", "+apps", "−apps", "buy", "Confidence", "Point"],
             f"{len(winners)} points carry positive evidence from 3 or more apps.")

w('<a id="part-2"></a>\n## Part 2 — What loses, ranked\n')
w("""Points ranked by the number of apps whose reviews show a **negative** reaction — complaint, churn,
a 1★ burst, or a purchase blocked. This is the "get this wrong and it costs you" list, and it is
where the category's ratings are actually made and lost.
""")
losers = sorted(live, key=lambda p: (-len(TALLY[p["id"]]["neg"]), -L.apps(p)))
losers = [p for p in losers if len(TALLY[p["id"]]["neg"]) >= 3]
ranked_table([(i, f"**{len(TALLY[p['id']]['neg'])}**", len(TALLY[p["id"]]["pos"]), CONF[p["id"]][0], esc(ref(p["id"])))
              for i, p in enumerate(losers, 1)],
             ["#", "−apps", "+apps", "Confidence", "Point"],
             f"{len(losers)} points carry negative evidence from 3 or more apps.")

w('<a id="part-3"></a>\n## Part 3 — What drives purchases, ranked\n')
w(f"""Ranked by apps in which a reviewer's own words tie the point to a purchase — a card marked
`purchase-driver`, meaning the review says why they paid, or what they would have paid for, or what
stopped them paying. {sum(1 for c in cards.values() if L.is_purchase_driver(c))} cards across the corpus carry that marking. This is the closest thing
in review data to a revenue signal, and it is a different ranking from Part 1: the things people
praise and the things people pay for only partly overlap.
""")
drivers = sorted(live, key=lambda p: (-len(TALLY[p["id"]]["pd"]), -len(TALLY[p["id"]]["pdc"])))
drivers = [p for p in drivers if TALLY[p["id"]]["pd"]]
ranked_table([(i, f"**{len(TALLY[p['id']]['pd'])}**", len(TALLY[p["id"]]["pdc"]), CONF[p["id"]][0],
               esc(ref(p["id"])), plain(TALLY[p["id"]]["pd"], 12))
              for i, p in enumerate(drivers, 1)],
             ["#", "apps", "cards", "Confidence", "Point", "Reports where a reviewer tied it to paying"],
             f"{len(drivers)} points have at least one app where a reviewer tied the point to paying.")

w('<a id="part-4"></a>\n## Part 4 — Hero features: what one app won on\n')
w("""Things that exist in only one or a few apps and carry outsized weight there — the feature a single
app's purchases hang on, or a finding with exceptional magnitude behind a single corpus. These do not
rank in Parts 1–3, because those rank by app count and these appear in one or two apps by definition.
They are listed separately so a narrow-but-decisive finding is not buried under a broad one.

**A. Purchase drivers marked app-specific.** The report judged the mechanism tied to that app's own
situation rather than portable — which is exactly why each one needs reading before it is copied.
""")
appspec_cards = sorted([c for c in cards.values() if c.get("generalisable") == "app-specific" and L.is_purchase_driver(c)],
                       key=lambda c: (str(c["report"]), c["id"]))
for c in appspec_cards:
    pts = ", ".join(esc(ref(x)) for x in c.get("canonical", [])) or f"nuance register — [full card in Part 9](#{c['id'].lower()})"
    w(f"- **{L.report_link(c['report'])} {esc(short(str(TITLES.get(c['report'],'')), 46))}** — {esc(short(c['claim'], 340))}  ")
    mag = esc(short(c['magnitude'], 260))
    w(f"  *What the app does:* {esc(short(c['this_app_does'], 120))} · *Magnitude:* {mag}  ")
    if c.get("conditions"): w(f"  *Conditions:* {esc(short(c['conditions'], 200))}  ")
    w(f"  `{c['id']}` · {pts}")
w("")
big = [c for c in appspec_cards if len(c["magnitude"]) > 260]
if big:
    w(f"""Several of those cards are whole **purchase-trigger tables** the report built by reading its payer
cohort — {", ".join(f"`{c['id']}` ({L.report_link(c['report'])})" for c in big)}. They are reproduced in full, table
included, in [Part 9](#part-9); they are the most direct statements of *why people paid* in the
entire corpus and are worth reading before anything else in this ledger.
""")
w("""**B. Narrow points with exceptional magnitude.** Canonical points standing on 1–3 apps that the
confidence rubric still rates *Moderate* because the magnitude behind them is extreme — a mean at or
below 1.7★, at or above 4.8★, a lift of ×4 or more, or 50+ reviews behind a single finding.
""")
narrow = [p for p in live if L.apps(p) <= 3 and CONF[p["id"]][0] == "Moderate"]
narrow.sort(key=lambda p: (L.apps(p), p["id"]))
ranked_table([(L.apps(p), len(p["cards"]), esc(ref(p["id"])), plain(p["reports"]), esc(short(CONF[p["id"]][1], 90)))
              for p in narrow],
             ["apps", "cards", "Point", "Reports", "Why Moderate"],
             f"{len(narrow)} points.")
w("""**C. Everything rare that never became a point** is in [Part 9](#part-9) — the complete nuance
register, every card that attached to no canonical point, reproduced in full.

---
""")

# ===================================================================== full point entries
def point_entry(p, show_2x2=False):
    pid = p["id"]; lvl, why = CONF[pid]; t = TALLY[pid]
    w(f'<a id="{anchor(pid)}"></a>')
    w(f"### {pid} — {p['title']}")
    w("")
    w(f"**{lvl}** · {L.apps(p)} apps · {len(p['cards'])} cards · positive in {len(t['pos'])} apps · "
      f"negative in {len(t['neg'])} apps" + (f" · tied to a purchase in {len(t['pd'])} apps" if t["pd"] else ""))
    w("")
    w(f"*Why {lvl}:* {why}")
    w("")
    if show_2x2:
        grid, detail = L.two_by_two(p, cards)
        if any(grid.values()):
            w("| | reaction positive | reaction negative |")
            w("|---|---|---|")
            w(f"| **app makes it free** | free-praised — {len(grid['free-praised'])} apps | "
              f"free-expected-but-broken — {len(grid['free-expected-but-broken'])} apps |")
            w(f"| **app makes it paid** | paid-converts — {len(grid['paid-converts'])} apps | "
              f"paid-resented — {len(grid['paid-resented'])} apps |")
            w("")
            w(f"**Verdict from the table:** {L.verdict(grid)}")
            w("")
    w(p["statement"])
    w("")
    w(f"**Reports:** {links(p['reports'])}")
    w("")
    w(f"<details><summary>{len(p['cards'])} cards</summary>\n")
    w("`" + "`, `".join(p["cards"]) + "`")
    if p.get("merged_from"):
        w("")
        for m in p["merged_from"]:
            if m.get("from"): w(f"- Merged in **{m['from']}** ({m.get('title','')}) — {m.get('when','')}. {m.get('note','')}")
            elif m.get("narrowed"): w(f"- Narrowed at {m['narrowed']}: was *{m.get('old_title','')}* — {m.get('note','')}")
            elif m.get("reviewed"): w(f"- Reviewed at {m['reviewed']}: {m.get('note','')}")
    w("\n</details>")
    w("")

def section_block(part, anchor_id, title, intro, sections, show_2x2=False, group=False):
    w(f'<a id="{anchor_id}"></a>\n## Part {part} — {title}\n')
    w(intro, "")
    sel = [p for p in live if p["section"] in sections]
    sel.sort(key=lambda p: (L.CONF_ORDER[CONF[p["id"]][0]], -L.apps(p), p["id"]))
    if group:
        for s in sections:
            grp = [p for p in sel if p["section"] == s]
            if not grp: continue
            w(f"### {s} — {len(grp)} points\n")
            ranked_table([(L.apps(p), CONF[p["id"]][0], esc(ref(p["id"]))) for p in grp],
                         ["apps", "Confidence", "Point"], "")
        for p in sel: point_entry(p, show_2x2)
    else:
        ranked_table([(L.apps(p), len(p["cards"]), CONF[p["id"]][0], esc(ref(p["id"]))) for p in sel],
                     ["apps", "cards", "Confidence", "Point"], f"{len(sel)} points, strongest evidence first.")
        for p in sel: point_entry(p, show_2x2)
    w("---\n")

section_block(5, "part-5", "Product rules and insights",
    """Rules the evidence says must not be broken, and the *why* findings that explain the rest of the
ledger. These are not features — they are the constraints every feature decision sits inside.""",
    ["product-rule", "insight"])

section_block(6, "part-6", "Features — free, paid, undecided, research",
    """One block per capability, with the free/paid 2×2 computed from the cards: what each app did with
the feature, and how its users reacted. The verdict is read off the table — mostly `paid-resented`
means the evidence leans free, mostly `paid-converts` means it leans paid, and a split means the
conditions in the statement decide. Grouped by where the ledger currently files each feature; the
2×2 and the confidence are what should move a feature between groups, not the current grouping.""",
    ["free", "paid", "undecided", "research"], show_2x2=True, group=True)

section_block(7, "part-7", "Must-haves and must-never-break",
    """**Must-have** is what the product needs regardless of the free/paid split. **Must-never-break** is
the reliability set — the things that generate 1★ reviews when they fail, which in this category is
where most of the rating damage comes from. Each statement carries the magnitude of what happened in
the apps where it broke.""",
    ["must-have", "must-never-break"], group=True)

section_block(8, "part-8", "Things to do and not to do, with the tactics that produced them",
    """Everything around the product rather than in it: listing, pricing presentation, launch, support,
localisation, campaigns and programmes. Tactic cards keep the outcome attached, so this reads as
"what worked for whom", not just "do X".""",
    ["do", "dont"], group=True)

# tactics
tac = sorted([c for c in cards.values() if c["kind"] == "tactic"], key=lambda c: (str(c["report"]), c["id"]))
w(f"### Every tactic card, with its outcome — {len(tac)} cards\n")
w("A specific thing an app did to grow, rank, convert or retain, and what happened.\n")
w("| Report | App | Tactic and outcome | Reaction | Magnitude | Card |")
w("|---|---|---|---|---|---|")
for c in tac:
    w(f"| {L.report_link(c['report'])} | {esc(short(str(TITLES.get(c['report'], '')), 40))} | {esc(short(c['claim'], 420))} | "
      f"{esc(c['user_reaction'])} | {esc(short(c['magnitude'], 160))} | `{c['id']}` |")
w("\n---\n")

# ===================================================================== Part 9 nuance register
w('<a id="part-9"></a>\n## Part 9 — High-impact rare findings: the complete nuance register\n')
w(f"""Every card that attached to **no** canonical point — {len(nuance):,} of {total_cards:,}. A card lands here when nothing
in the ledger fitted it and widening an existing point to swallow it would have destroyed the detail.
That makes this section the opposite of a leftovers pile: it is where the one-app tactics, the
market-specific blockers and the single findings with extreme magnitude survive intact.

Ordered by magnitude strength — cards whose numbers hit the exceptional thresholds (mean ≤ 1.7★ or
≥ 4.8★, lift ≥ ×4, 50+ reviews) first. Each is reproduced with everything the card carries.
""")
cur = None
for c in nuance:
    tag = " · ".join(sorted({h.split()[0] for h in L.magnitude_score(c)})) or "—"
    w(f'<a id="{c["id"].lower()}"></a>')
    w(f"#### `{c['id']}` · {L.report_link(c['report'])} {esc(short(str(TITLES.get(c['report'],'')), 60))} · *{c['kind']}*")
    w("")
    w(esc(c["claim"]) if False else c["claim"])
    w("")
    bits = [f"**Where:** {c['where']}", f"**App does:** {c['this_app_does']}",
            f"**Reaction:** {c['user_reaction']}", f"**Magnitude:** {c['magnitude']}",
            f"**Direction:** {c['direction']}", f"**Report confidence:** {c['report_confidence']}",
            f"**Generalisable:** {c['generalisable']}"]
    if c.get("side_effects"): bits.append(f"**Side effects:** {c['side_effects']}")
    if c.get("conditions"): bits.append(f"**Conditions:** {c['conditions']}")
    if c.get("review_ids"): bits.append("**Review IDs:** " + ", ".join(f"`{r}`" for r in c["review_ids"]))
    w(" · ".join(bits))
    w("")
w("---\n")

# ===================================================================== Part 10 contradictions
contra = sorted([c for c in cards.values() if c["kind"] == "contradiction"], key=lambda c: (str(c["report"]), c["id"]))
w('<a id="part-10"></a>\n## Part 10 — Contradictions\n')
w(f"""Two kinds of disagreement. First, the **Contested points**: capabilities where apps genuinely
split on free versus paid, which the confidence rubric flags rather than averages away. Second, every
`contradiction` card — {len(contra)} places where a report disagrees with a common assumption or with another report.
""")
contested = [p for p in live if CONF[p["id"]][0] == "Contested"]
contested.sort(key=lambda p: -L.apps(p))
w(f"### Contested points — {len(contested)}\n")
ranked_table([(L.apps(p), esc(ref(p["id"])), esc(CONF[p["id"]][1])) for p in contested],
             ["apps", "Point", "How the split falls"], "")
w(f"### Contradiction cards — {len(contra)}\n")
w("| Report | Finding that cuts against the grain | Magnitude | Conditions | Card |")
w("|---|---|---|---|---|")
for c in contra:
    w(f"| {L.report_link(c['report'])} | {esc(short(c['claim'], 460))} | {esc(short(c['magnitude'], 140))} | "
      f"{esc(short(c.get('conditions',''), 140))} | `{c['id']}` |")
w("\n---\n")

# ===================================================================== Part 11 audiences and markets
aud = sorted([c for c in cards.values() if c["kind"] == "audience"], key=lambda c: (str(c["report"]), c["id"]))
mkt = sorted([c for c in cards.values() if c["kind"] == "market"], key=lambda c: (str(c["report"]), c["id"]))
w('<a id="part-11"></a>\n## Part 11 — Audiences and markets\n')
w(f"""{len(aud)} audience cards and {len(mkt)} market cards: which user groups behave differently, and what a
country or language changes about conversion, payment and rating.

### Audiences — {len(aud)} cards
""")
w("| Report | App | Audience finding | Reaction | Magnitude | Card |")
w("|---|---|---|---|---|---|")
for c in aud:
    w(f"| {L.report_link(c['report'])} | {esc(short(str(TITLES.get(c['report'],'')), 34))} | {esc(short(c['claim'], 440))} | "
      f"{esc(c['user_reaction'])} | {esc(short(c['magnitude'], 150))} | `{c['id']}` |")
w("")
COUNTRIES = ["Germany", "German", "France", "French", "Japan", "Japanese", "Korea", "Korean", "China", "Chinese",
             "Russia", "Russian", "Brazil", "Brazilian", "Portuguese", "Spain", "Spanish", "Mexico", "Argentina",
             "Turkey", "Turkish", "Italy", "Italian", "Poland", "Polish", "Netherlands", "Dutch", "Vietnam",
             "Vietnamese", "Thai", "Indonesia", "India", "Saudi", "Arabic", "Ukraine", "Ukrainian", "Taiwan",
             "Hong Kong", "Australia", "Canada", "United States", "US ", "UK", "Great Britain", "Sweden", "Swedish",
             "Norway", "Denmark", "Finland", "Czech", "Hungary", "Romania", "Greece", "Israel", "Hebrew", "Egypt",
             "Kazakhstan", "Switzerland", "Austria", "Belgium", "Ireland", "New Zealand", "Singapore", "Malaysia",
             "Philippines", "Colombia", "Chile", "Peru", "Ecuador", "Nigeria", "South Africa", "Pakistan", "Algeria"]
bycountry = collections.defaultdict(list)
for c in mkt:
    blob = c["claim"] + " " + c["magnitude"] + " " + c.get("conditions", "")
    for k in COUNTRIES:
        if re.search(r"\b" + re.escape(k.strip()) + r"\b", blob): bycountry[k.strip()].append(c)
w(f"### Markets — {len(mkt)} cards\n")
w("**Where the market cards concentrate.** A card is counted under every country or language it names, so the counts overlap.\n")
w("| Market or language | Cards | Apps |")
w("|---|---|---|")
for k, v in sorted(bycountry.items(), key=lambda kv: -len(kv[1])):
    if len(v) >= 5:
        w(f"| {k} | {len(v)} | {len({x['report'] for x in v})} |")
w("")
w(f"**Every market card, by report.**\n")
w("| Report | App | Market finding | Magnitude | Card |")
w("|---|---|---|---|---|")
for c in mkt:
    w(f"| {L.report_link(c['report'])} | {esc(short(str(TITLES.get(c['report'],'')), 30))} | {esc(short(c['claim'], 460))} | "
      f"{esc(short(c['magnitude'], 150))} | `{c['id']}` |")
w("\n---\n")

# ===================================================================== Part 12 timelines
tl = sorted([c for c in cards.values() if c["kind"] == "timeline"], key=lambda c: (str(c["report"]), c["id"]))
w('<a id="part-12"></a>\n## Part 12 — Timeline lessons\n')
w(f"""{len(tl)} dated cause → effect chains: a change shipped, and what the reviews did next. These are the
ledger's strongest evidence of causation, because the date of the change and the date of the rating
move are both observable.
""")
w("| Report | App | Dated chain | Reaction | Magnitude | Card |")
w("|---|---|---|---|---|---|")
for c in tl:
    w(f"| {L.report_link(c['report'])} | {esc(short(str(TITLES.get(c['report'],'')), 28))} | {esc(short(c['claim'], 470))} | "
      f"{esc(c['user_reaction'])} | {esc(short(c['magnitude'], 140))} | `{c['id']}` |")
w("\n---\n")

# ===================================================================== Part 13 caveats
dc = sorted([c for c in cards.values() if c["kind"] == "data-caveat"], key=lambda c: (str(c["report"]), c["id"]))
w('<a id="part-13"></a>\n## Part 13 — Data caveats\n')
w(f"""{len(dc)} cards recording what weakens a specific number: review bursts, solicited or seeded reviews,
rating-versus-text contradictions, storefronts below the 50-review threshold, corpora dominated by one
language, and what each report said it could not establish. Read the caveat for a report before
leaning on that report's numbers.
""")
w("| Report | App | Caveat | Magnitude | Card |")
w("|---|---|---|---|---|")
for c in dc:
    w(f"| {L.report_link(c['report'])} | {esc(short(str(TITLES.get(c['report'],'')), 28))} | {esc(short(c['claim'], 470))} | "
      f"{esc(short(c['magnitude'], 150))} | `{c['id']}` |")
w("\n---\n")

# ===================================================================== Part 14 card index
INDEX_NAME = "Feature Ledger — Card Index.md"
w('<a id="part-14"></a>\n## Part 14 — Card index\n')
w(f"""Every statement in this ledger resolves to a report section and to review IDs through the cards
behind it, and every review resolves to the findings it supports. The complete card-level index —
all {total_cards:,} cards with their section, claim, review IDs and canonical points — is the companion file
[{INDEX_NAME}](<{INDEX_NAME}>), split out because it is larger than the rest of this
ledger put together. Each report's own card file carries every field of every card.
""")
w("| Report | App | Cards | Attached | Nuance | Card file |")
w("|---|---|---|---|---|---|")
for r in L.sort_reports(by_report):
    folder = r if isinstance(r, int) else next(k for k, v in L.RESEARCH_DOC.items() if v == r)
    cs = by_report[r]
    att = sum(1 for c in cs if c.get("canonical"))
    w(f"| {L.report_link(r)} | {esc(short(str(TITLES.get(r,'')), 58))} | {len(cs)} | {att} | {len(cs)-att} | "
      f"[cards.md](<../Tools/prd_ledger/{folder}/cards.md>) |")
w("")

out = os.path.join(L.ROOT, "Research Reports", "Feature Ledger.md")
open(out, "w").write("\n".join(O) + "\n")

# ---------------------------------------------------------------- companion card index
X = [f"""# Feature Ledger — Card Index

Companion to [Feature Ledger.md](<Feature Ledger.md>). All {total_cards:,} cards, grouped by report, so any
statement in the ledger resolves to a report section and to review IDs, and any review resolves to the
findings it supports.

`Points` lists the canonical points a card is attached to; `—` means the card is in the nuance
register and is reproduced in full in [Part 9 of the ledger](<Feature Ledger.md#part-9>). Every field of
every card lives in that report's own `Tools/prd_ledger/<report>/cards.md`.

| Report | App | Cards | Attached | Nuance |
|---|---|---|---|---|"""]
for r in L.sort_reports(by_report):
    cs = by_report[r]; att = sum(1 for c in cs if c.get("canonical"))
    X.append(f"| {L.report_link(r)} | {esc(short(str(TITLES.get(r,'')), 58))} | {len(cs)} | {att} | {len(cs)-att} |")
X.append("")
for r in L.sort_reports(by_report):
    cs = sorted(by_report[r], key=lambda c: c["id"])
    folder = r if isinstance(r, int) else next(k for k, v in L.RESEARCH_DOC.items() if v == r)
    X.append(f"## {r if isinstance(r,int) else r[:-3]} — {esc(short(str(TITLES.get(r,'')),70))}")
    X.append("")
    X.append(f"{len(cs)} cards · source: {L.report_link(r)} · full cards: "
             f"[cards.md](<../Tools/prd_ledger/{folder}/cards.md>)")
    X.append("")
    X.append("| Card | Kind | Where | Claim | Review IDs | Points |")
    X.append("|---|---|---|---|---|---|")
    for c in cs:
        pts = ", ".join(c.get("canonical", [])) or "—"
        ids = ", ".join(f"`{x}`" for x in c.get("review_ids", [])[:6]) or "—"
        X.append(f"| `{c['id']}` | {c['kind']} | {esc(short(c['where'], 60))} | {esc(short(c['claim'], 300))} | {ids} | {pts} |")
    X.append("")
xout = os.path.join(L.ROOT, "Research Reports", "Feature Ledger — Card Index.md")
open(xout, "w").write("\n".join(X) + "\n")

print(f"{out}\n  {len(O):,} lines, {os.path.getsize(out)/1e6:.2f} MB")
print(f"{xout}\n  {len(X):,} lines, {os.path.getsize(xout)/1e6:.2f} MB")
print(f"points {len(live)} · cards {total_cards} · nuance {len(nuance)} · contested {len(contested)}")
