import json, re
R = 19
rep = open("App Store Reports/19. Wisey - Habit Builder - Form habits, change your life (REPORT).md").read().split("\n")
def table(after, k=0):
    i = next(n for n, l in enumerate(rep) if after in l)
    blocks, cur = [], []
    for l in rep[i+1:]:
        if l.startswith("|"): cur.append(l)
        elif cur:
            blocks.append(cur); cur = []
            if len(blocks) > k: break
    if cur: blocks.append(cur)
    rows = [l for l in blocks[k] if not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").replace("`","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- PART 1 ----
c(21, "§1.3 Storefronts queried that returned zero reviews; §1.5 Only one storefront clears the 50-review bar; §1.5 Confirmed payer is a conservative judgement", "data-caveat",
  "Nine storefronts queried returned zero (hk nl no ae co ua my cr ec); no Japanese, Korean or Chinese storefront was queried at all; only the US (n=72) clears the 50-review bar; 'confirmed payer' requires a first-person statement — three strongly implied payers are coded INFERRED_PAYER and excluded from the 64-payer denominator; amounts are as reported, currency often unstated, none converted; reviews reflect the reviewer's understanding — several 'charged without consent' reports are consistent with a trial that auto-converted per unread terms",
  "n/a", "none", "9 zero storefronts; 3 inferred payers excluded; 63 theme codes", "none", "method", "yes",
  ["12874978864","13202910675","13754537415","13280826420","13369386593"])
c(22, "§1.6 Corpus composition (verbatim table)", "data-caveat",
  "Corpus: 105 reviews, 14 storefronts, 24 May 2025 → 7 Aug 2026; the first review lands 19 days after the 5 May 2025 launch; mean 1.324; 1★ 96 (91.43%) · 3★ 1 · 5★ 8 (7.62%); 1 edited; 8 with any upvote, max vote_sum 5 on 'Scam'; 3 non-English (de, es/cl, it); mean body 284.2 chars for 1★ (median 197) vs 57.1 for 5★",
  "n/a", "none", table("## 1.6 Corpus composition"), "none", "corpus-level fact", "app-specific",
  ["13754537415","12692126207","13650570635","13710711149","14289131320"])
c(23, "§1.6 Monthly volume (verbatim table) — the collapse in 2026", "timeline",
  "Monthly review volume: 2025-05 2 · 06 12 · 07 9 · 08 8 · 09 12 · 10 10 · 11 8 · 12 11 · 2026-01 8 · 02 9 · 03 6 · 04 4 · 05 2 · 06 2 · 07 1 · 08 1 — the corpus collapses through 2026",
  "review flow dries up", "none", table("**Monthly volume**"), "none", "corpus-level fact", "app-specific", [])

# ---- PART 2 ----
c(24, "§2.1 Feature inventory derived from reviews (verbatim table)", "feature",
  "Feature inventory — only the first four are described by anyone as working: habit checklist (works; 'just a calendar'); reminders/alarms (works; three call it an alarm clock); home-screen widget (one 5★ mention); back-dating a missed habit (broken or absent — 'went to log yesterday's habit and it wouldn't let me'); courses/video lessons (mixed — one finds them useful, five call them thin/boring/generic/AI-generated); e-books/PDFs (uniformly negative); focus music; personalised plan from a quiz (promised, not delivered); a suite of separate apps ('useless little apps'); web portal/account area (the real product surface, never surfaced from inside the app); support chat bot 'Rachel'; login/account access (fragile, error 300); store listing claims statistics and charts — nobody in the corpus mentions them at all",
  "see table", "mixed", table("## 2.1 Feature inventory"), "none", "inventory", "app-specific",
  ["12748055966","13568090356","13571866718","12915336789","13398540937","12998276106","12778540152","13366105778","13251215774","13258914566","12742285860"])
c(25, "§2.1 Back-dating a missed habit — broken or absent", "feature",
  "Back-dating a missed habit is broken or absent — 'Today I went to log yesterday's habit and it wouldn't let me'", "absent/broken", "complaint", "n=1", "free", "single", "yes", ["12915336789"])
c(26, "§2.1 Web portal / account area — the real product surface, never surfaced from inside the app", "feature",
  "The web portal (courses, account area) is the real product surface and the only praised asset, and the app never links to it", "web portal disconnected from app", "mixed", "4 IDs; 1 positive", "do", "close reading", "app-specific",
  ["13398540937","13366105778","13876370915","13150104593"])
c(27, "§2.1 Store-listing claims statistics and charts — nobody in the corpus mentions them", "feature",
  "The listing claims progress statistics and charts, templates, smart reminders and widgets; nobody in the corpus mentions statistics or charts at all — neither to praise nor to complain", "claimed, invisible", "none", "0 of 105 mentions", "none", "external check", "app-specific", [])
c(28, "§2.2 Monetisation model — listing vs reviewer-reported table (verbatim); the mismatch is the finding", "monetization",
  "App Store listing: free download, IAP Premium $6.99 and $29.99; reviewers report web subscriptions of $15–$99.99, a second web subscription for e-books ($17–$45/month) and retention offers ($1/month, $5 lifetime, $49–$49.99 lifetime) — none shown on the listing; $29.99 appears once as an agreed annual price then billed at $59.99/month; no reviewer clearly identifies as an Apple-billed purchaser",
  "listing prices ≠ charged prices", "1★-burst", table("## 2.2 Monetisation model"), "dont", "external + reviews", "app-specific",
  ["13248498967","13671148757","13405220625"])
c(29, "§2.2 Classification of capabilities by gate (verbatim table)", "monetization",
  "Free: downloading the app — nothing else confirmed free; paid: habit tracking itself ('Everything you do requires extra payment'; 'there isn't even the possibility of trying the minimum functions' — it); separately gated: e-books; trial-gated: a trial exists but is described inconsistently ('free 7 days charged trial', '$45 for the initial trial', '$34.99 trial') — whether a genuinely free trial exists is unclear; unclear which capabilities the $6.99/$29.99 IAPs unlock",
  "everything paid; trial ambiguous", "blocked-conversion", table("**Classification of capabilities by gate:**"), "product-rule", "review-derived", "app-specific",
  ["12915335177","14289131320","12985541561","12836726941","13366105778"])
c(30, "§2.2 4 of 105 refused to buy because they could not try first", "monetization",
  "Four refused to buy because they could not try first — 'Not even a free trial? There's no way to see if you'd even like the app before putting down a minimum of $7. I'll pass'; the subscription request 'starts immediately' and is 'excessively expensive' (it); 'there is no trial period where you can try the app first' (ca) — the only conversion-funnel evidence from non-payers",
  "no evaluable free tier", "blocked-conversion", "4 of 105 (3.81%, Very strong)", "product-rule", "very strong", "yes",
  ["13405220625","14289131320","12819961338","12915335177"])
c(31, "§2.2 Developer's published terms — weekly billing permitted; cancel via account settings users lose access to", "monetization",
  "The developer's terms permit renewal 'each week, month, 6 months, year', a 24-hour pre-trial-end cancellation cut-off, non-refundable website purchases, and cancellation 'via settings in your account' or by email; EU withdrawal right 14 days; two observations: weekly billing makes '$59.99 again and again every week' structurally possible, and the cancellation surface the terms point to is precisely the one two reviewers say they lost access to",
  "weekly-capable auto-renew; cancel via a surface that locks users out", "1★-burst", "terms accessed 10 Sep 2026; 3 IDs", "dont", "external", "yes",
  ["13490397655","13876370915","14160038721"])

with open("Tools/prd_ledger/19/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
