import json, re
R = 7
rep = open("App Store Reports/7. Habit Tracker - HabitKit - Streaks & Accountability (REPORT).md").read().split("\n")
def table(after, k=0):
    """k-th markdown table after the first line containing `after`, flattened."""
    i = next(n for n, l in enumerate(rep) if after in l)
    blocks, cur = [], []
    for l in rep[i+1:]:
        if l.startswith("|"): cur.append(l)
        elif cur:
            blocks.append(cur); cur = []
            if len(blocks) > k: break
        elif l.startswith("#") and blocks == [] and k == 0 and False: pass
    if cur: blocks.append(cur)
    rows = [l for l in blocks[k] if not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))


# ---- PART 9 — PRODUCT IMPLICATIONS ----
c(121, "Part 9 #1 Fix the Pro entitlement / widget-unlock failure (Immediate)", "must-never-break",
  "Fix the Pro entitlement / widget-unlock failure — highest severity: cache entitlement locally, render the widget optimistically from the last-known-good receipt instead of blocking on a live server call, then proactively email the eight reviewers",
  "widget blocks on network entitlement check", "1★-burst", "8 reviews, mean 2.25, 100% payers, 15 months unresolved; newest 6 Sep 2026", "must-never-break", "immediate", "yes", ["14519062888"], cond="evidence: R07-012, R07-014")
c(122, "Part 9 #2 Put a support address in the app, visibly (Immediate)", "must-have",
  "Put a support address in the app, visibly — the two reviewers who could not reach the developer produced two 1★s; discoverability, not staffing",
  "support not visible in-app", "1★-burst", "2 × 1★; developer praise 133 at 93.2% 5★", "must-have", "immediate", "yes", ["14351190258","13952801052"], cond="evidence: R07-020")
c(123, "Part 9 #3 Investigate the Aug 2026 compact-list redesign (Immediate)", "must-never-break",
  "Investigate the Aug 2026 compact-list redesign and ship a text-size / density option or an opt-out",
  "redesign shipped without a density option", "1★-burst", "5 reviews in 12 days, mean 2.43, three from payers, one 'going to hunt for an alternative app'", "must-never-break", "immediate", "yes", ["14452046441","14447636722"], cond="evidence: R07-024")
c(124, "Part 9 #4 Audit the streak count for 'X per week/month' habits (Immediate)", "must-never-break",
  "Audit the streak count for 'X per week/month' habits — a wrong number in a trust-based app is worse than no number",
  "12-week streak on an 8-week-old habit", "complaint", "1 wrong count + 2 who stopped using the streak number", "must-never-break", "immediate", "yes", ["13578452293"], cond="evidence: R07-089")
c(125, "Part 9 Monetization — repackage, don't reprice #5 Raise the free habit cap from 4 to 6–8", "monetization",
  "Raise the free habit cap from 4 to 6–8 — move the wall past the 5-to-8-habit user, not in front of them",
  "4-habit cap", "churn", "27 complaints, mean 2.56, 55.6% 1–2★, zero conversions among complainers; 11 say 4 is enough", "build-free", "recommendation", "yes", [], cond="evidence: R07-006, R07-007")
c(126, "Part 9 #6 Make one widget free", "monetization",
  "Make one widget free (more with Pro) — the widget paywall is the only theme with a 0% 5★ rate, and free widgets create the habit that later justifies Pro",
  "all widgets Pro", "complaint", "13 objections, 0% 5★", "build-free", "recommendation", "yes", ["12622891075","14305420985"], cond="evidence: R07-009, R07-011")
c(127, "Part 9 #7 Keep the lifetime SKU prominent, and make subscription→lifetime possible in-app", "monetization",
  "Keep the lifetime SKU prominent, and make subscription → lifetime possible in-app — two 5★ customers in one July 2026 week tried to hand over the lifetime price and could not",
  "no in-app cross-grade", "blocked-conversion", "lifetime top trigger 45 (35.6% payers); 2 blocked buyers", "product-rule", "recommendation", "yes", ["14288167581","14289596763"], cond="evidence: R07-036, R07-047")
c(128, "Part 9 #8 Review Canadian and emerging-market pricing", "market",
  "Review Canadian and emerging-market pricing — regional lifetime pricing, or lead with the $12/year SKU in price-sensitive storefronts",
  "one price ladder; CA$40", "complaint", "CA worst eligible market; cap complaints 4.2% vs 2.3% outside high-spend", "do", "recommendation", "yes", [], cond="evidence: R07-110, R07-112")
c(129, "Part 9 #9 Add a real trial for the two features screenshots cannot sell: charts and widgets", "monetization",
  "Add a real trial for charts and widgets, the two features screenshots cannot sell",
  "no trial", "blocked-conversion", "7 requests", "undecided", "recommendation", "yes", [], cond="evidence: R07-046")
c(130, "Part 9 #10 Do NOT add upsell pressure to solve conversion", "dont",
  "Do NOT add upsell pressure to solve conversion — multiple 5★ reviews name the absence of nagging as the reason they stayed and paid; giving it up trades a durable asset for a short-term lift",
  "light upsell", "praise", "only 8 nagging complaints", "dont", "recommendation", "yes", [], cond="evidence: R07-051")
c(131, "Part 9 Product — converts 3★/4★ into 5★ #11 Ship iCloud/CloudKit sync", "feature",
  "Ship iCloud/CloudKit sync — the single largest rating lever — opt-in, end-to-end, CloudKit private database, and say so in the release notes, so the privacy promise holds",
  "absent", "blocked-conversion", "54 reviews; 18.9% of 4★; 31.4% of 3★; 3 years unfixed", "build-paid", "recommendation", "yes", ["12386725682","12139974588","13833569208","13499288017","11241317063"], cond="evidence: R07-016, R07-072")
c(132, "Part 9 #12 Make the existing weekly/monthly goal modes discoverable", "must-have",
  "Surface frequency in habit creation rather than behind 'Advanced Options' — the highest rating-gain to engineering-cost ratio in the report",
  "hidden since changelog 1.11", "complaint", "17 reviews incl. a payer and a 3★ offering to re-rate", "must-have", "recommendation", "yes", ["10266075296","11800436326"], cond="evidence: R07-088")
c(133, "Part 9 #13 Native iPad layout before Apple Watch", "feature",
  "Native iPad layout before Apple Watch — worse mean, and a layout problem rather than a new product",
  "stretched phone UI", "complaint", "iPad mean 3.61 vs Watch 4.15", "must-have", "recommendation", "yes", [], cond="evidence: R07-076, R07-078")
c(134, "Part 9 #14 More colours, and a colour picker", "feature",
  "More colours and a colour picker — the 21-colour palette directly limits the value of Pro's unlimited habits",
  "21 presets, 4 greys", "complaint", "13 requests", "undecided", "recommendation", "yes", ["13621381288"], cond="evidence: R07-061")
c(135, "Part 9 #15 Rest/skip days, and a configurable day boundary", "feature",
  "Rest/skip days and a configurable day boundary — small counts but all 5★ and both cheap",
  "absent", "praise", "3 + 3", "must-have", "recommendation", "yes", ["13604363091","12632001002","13776739735","11670099719"], cond="evidence: R07-090, R07-091")
c(136, "Part 9 Positioning — free rating and revenue, no engineering #17 Say 'ADHD' and 'no-guilt tracking' in the store listing", "do",
  "Say 'ADHD' and 'no-guilt tracking' in the store listing — ADHD reviewers rate 5.00 across all 13 and the no-shaming property appears nowhere in the listing",
  "listing silent on both", "praise", "ADHD 13 at 5.00; no-guilt 6 at 5.00", "do", "recommendation", "yes", [], cond="evidence: R07-064, R07-065")
c(137, "Part 9 #18 Market the generic-tracker use case", "do",
  "Market the generic-tracker use case — the listing ('form new habits or break old ones') is narrower than what users do",
  "listing narrow", "praise", "11 reviews, mean 4.91", "do", "recommendation", "yes", [], cond="evidence: R07-066")
c(138, "Part 9 #19 Localise the listing, starting with Chinese and German", "market",
  "Localise the listing, starting with Chinese and German",
  "EN-only listing", "blocked-conversion", "DE 12.1% of corpus; CN cannot buy", "do", "recommendation", "yes", [], cond="evidence: R07-048, R07-084")
c(139, "Part 9 #20 Lean into the YouTube/Threads discovery channel", "do",
  "Lean into the YouTube / Threads discovery channel with a creator brief — discovery is named via YouTube (incl. 'The Studio' channel, also cited on the marketing site), Threads, Twitter, LinkedIn and Product Hunt, and one video drove an annual purchase for a lock-screen widget that does not exist",
  "organic creator coverage, no brief", "purchase-driver", "12 discovery mentions", "do", "recommendation", "yes",
  ["12898756160","12949502025","13053618099","14516845857","11877901803","11039862982","10984473093","9980285580","12450937418"])
c(140, "Part 9 Research questions — What is the actual free→paid conversion rate?", "data-caveat",
  "Research: the actual free → paid conversion rate is unknown — 75 self-declared payers out of 882 reviewers is a review-writing rate; never quote 8.5% as conversion",
  "n/a", "none", "75 / 882 = 8.5% (not conversion)", "research", "open", "yes", [])
c(141, "Part 9 Research questions — How many people hit the 4-habit cap and silently leave?", "data-caveat",
  "Research: how many people hit the 4-habit cap and silently leave? The 27 complaints are a floor, not an estimate",
  "n/a", "none", "27 (floor)", "research", "open", "yes", [])
c(142, "Part 9 Research questions — Would raising the cap to 8 reduce revenue?", "data-caveat",
  "Research: would raising the cap to 8 reduce revenue? Untestable from reviews — needs an A/B test with cohort LTV",
  "n/a", "none", "report gives none", "research", "open", "yes", [])
c(143, "Part 9 Research questions — Is the P4 rating decline compositional?", "data-caveat",
  "Research: is the 2026 rating decline partly compositional? More payers write reviews each year (2.11% → 12.63%) and payers rate 0.44 lower, so some of the decline is mix, not deterioration — store-side cohort data would separate them",
  "n/a", "none", "payers 2.11% → 12.63%; payer gap −0.44", "research", "open", "yes", [])
c(144, "Part 9 Research questions — How widespread is the entitlement failure among non-reviewers?", "data-caveat",
  "Research: how widespread is the entitlement failure among non-reviewers? 8 reviews is what surfaced — RevenueCat logs would give the true rate",
  "n/a", "none", "8 (surfaced)", "research", "open", "yes", [])
c(145, "Part 9 Research questions — Which SKU do buyers actually pick?", "data-caveat",
  "Research: which SKU do buyers actually pick? Reviewers name lifetime far more than yearly, but review-writing is biased toward one-time purchasers who feel good about the transaction",
  "n/a", "none", "report gives none", "research", "open", "yes", [])

with open("Tools/prd_ledger/7/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
