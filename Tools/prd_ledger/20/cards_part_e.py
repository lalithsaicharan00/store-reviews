import json, re
R = 20
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- PART 8 ----
c(90, "§8.1 F1. Honour every legacy entitlement, permanently and verifiably", "product-rule",
  "Honour every legacy entitlement permanently and verifiably — restore on the receipt, not on local state; make it survive reinstall and device change; publish a note saying it is done", "revoked; partial non-durable patch", "1★-burst", "615 (mean 1.37); 52% of payers; recurrences to Jan 2026", "product-rule", "recommendation (immediate)", "yes", [])
c(91, "§8.1 F2. Fix the App Store listing", "do",
  "Fix the App Store listing — it promised 'unlimited habits… without paying a penny' for at least two years after that stopped being true; zero engineering cost", "stale listing", "1★-burst", "24 reviews, mean 1.21", "dont", "recommendation (immediate)", "yes", [])
c(92, "§8.1 F3. Kill the non-expiring countdown and the launch interstitial", "dont",
  "Kill the non-expiring countdown and the launch interstitial — a four-year 'limited time offer' is a documented reason people uninstalled; cap the paywall at one dismissible prompt per session with a durable 'no'", "permanent countdown + launch interstitial", "1★-burst", "225 reviews", "dont", "recommendation (immediate)", "yes", [])
c(93, "§8.1 F4. Audit the promo-price-to-charge path", "must-never-break",
  "Audit the promo-price-to-charge path — 28 reports of advertised-discount-then-full-price across 8 storefronts, Dec 2021 → Apr 2025; low volume, high exposure; reproduce it or prove it cannot happen", "discount shown, full charged", "1★-burst", "28 (0.69%); 8 storefronts", "must-never-break", "recommendation (immediate)", "yes", [])
c(94, "§8.1 F5. Stand up a support channel that answers", "must-have",
  "Stand up a support channel that answers — fix the dead 'Contact Us' address first; even an autoresponder with a real queue behind it is worth ~2 stars per incident", "dead support address", "1★-burst", "148 (mean 1.33) vs 3.63 when helped", "must-have", "recommendation (immediate)", "yes", [])
c(95, "§8.1 F6. Make backup automatic, free, and continuous", "must-never-break",
  "Make backup automatic, free and continuous — paywalling the recovery path for a data-loss event caused by your own update was the single most damaging decision of the 2025 window; automatic daily local + iCloud snapshots, restore available to free users; ship regression tests on the migration path — the same class of bug fired in Jan 2021 and again in Mar 2025", "paid manual backup", "1★-burst", "233 data-loss; 78.3% of E4", "must-never-break", "recommendation (immediate)", "yes", [])
c(96, "§8.1 F7. Make the free tier viable again — and at minimum fix the delete-then-add dead end", "product-rule",
  "The 3-habit cap behaving as a lifetime cap is almost certainly a bug and converts a pricing choice into a broken app; separately, 3 is below the threshold of usefulness for this category — 7–10 free habits with paid depth elsewhere is the defensible line", "3-habit lifetime cap", "1★-burst", "99 cap complaints; 63 unlimited-removed", "free", "recommendation (immediate)", "yes", [])
c(97, "§8.2 P1. Ship the widget, properly, or stop selling it", "feature",
  "Ship a real Home Screen widget (iOS 14+) with direct check-off, or remove it from the paywall copy and screenshots immediately and refund on request", "sold, not delivered", "1★-burst", "182 reviews, five years, #1 named purchase trigger", "must-never-break", "recommendation", "yes", [])
c(98, "§8.2 P2. Add a streak counter alongside the percentage", "feature",
  "Add a streak counter alongside the percentage — nobody asks to replace the percentage; users want the streak for the daily dopamine and the strength score for the honest long-run picture", "absent", "complaint", "71 requests, mean 3.72", "undecided", "recommendation", "yes", [])
c(99, "§8.2 P3. Explain the percentage", "must-have",
  "A one-screen explainer — 'a weekly habit completed once shows 4% because the score measures strength over ~91 repetitions, not this week's completion' — plus an optional 'this period' toggle; the cheapest satisfaction win available", "unexplained metric", "complaint", "20 classified (undercounted)", "must-have", "recommendation", "yes", [])
c(100, "§8.2 P4. Multiple check-ins per day", "feature",
  "Multiple check-ins per day — water, medication, brushing teeth; table stakes against Streaks and Productive", "absent", "complaint", "54 requests", "must-have", "recommendation", "yes", [])
c(101, "§8.2 P5. Specific weekdays, not just 'N times in M days'", "feature",
  "Specific weekdays — 'Gym Mon/Wed/Fri' is not expressible today; also behind a large share of notification complaints", "absent", "complaint", "22 requests + notification complaints", "must-have", "recommendation", "yes", [])
c(102, "§8.2 P6. Notes per day", "feature",
  "Notes per day — the single most-requested feature in the corpus", "absent", "complaint", "79 requests, mean 3.66", "free", "recommendation", "yes", [])
c(103, "§8.2 P7. Categories/folders + a compact row option", "feature",
  "Categories/folders and a compact row option co-occur — both are what happens when a power user exceeds ~8 habits", "absent", "complaint", "58 + 26 requests", "undecided", "recommendation", "yes", [])
c(104, "§8.2 P8. Apple Watch app", "feature",
  "An Apple Watch app — asked for by the happiest users and named explicitly in churn-to-Streaks reviews", "absent", "complaint", "62 requests, mean 4.15", "paid", "recommendation", "yes", [])
c(105, "§8.3 D1. Fix the habit-strength decay — the highest-leverage product item", "feature",
  "After 2021 the percentage stopped decaying — habits sat at 100% after weeks of non-completion; the forgiving-but-decaying model was the product's one genuine intellectual differentiator and the thing its most articulate advocates loved; 'Please bring that algorithm back!'; the only feature no competitor has", "decay broken since 2021", "churn", "5 named IDs", "must-have", "recommendation (highest leverage)", "yes",
  ["7303014090","7330745927","7641636642","8231849401","7464605501"])
c(106, "§8.4 Monetisation — repackage around what the corpus actually values; part 8 #1; part 8 #2; part 8 #3", "monetization",
  "Three clear things: (1) this audience will pay — they paid voluntarily at self-chosen prices when nothing forced them, 35 praising the model at 4.83; (2) this audience will not rent a checkbox — stated willingness clusters at $5–15 one-time or $10–15/year at the top; $39.99/year is rejected in every market and language for seven years; (3) the price is not the objection, the broken bargain is — Spain (never lost anything) complains about price 16.9% and revocation 2.8%, high-spend markets (which lost something) complain about revocation 19.3%; recommendation: offer a lifetime unlock alongside any subscription in the $15–25 band and grandfather every legacy purchaser into it free — multiple users say they would buy this",
  "n/a", "blocked-conversion", "$5–15 one-time WTP; 4 explicit would-buy IDs", "build-paid", "recommendation", "yes",
  ["7470777218","8537740813","8053917590","9459852981"])
c(107, "§8.5 What a competitor entering this category gets free from this corpus; part 8 #4", "positioning",
  "(1) the positioning gap is wide open — 'unlimited habits, one-time price, no subscription' was a winning position this product abandoned and 26 reviewers walked to Streaks for it; (2) the forgiving-decay model is unclaimed and the most emotionally resonant mechanic in the corpus, particularly for ADHD and perfectionist users who describe streak-resets as actively harmful; (3) the feature checklist is written — Home Screen widget, Watch, streak and strength, multi-daily, weekday scheduling, notes, categories, automatic free backup, iPad — roughly 400 reviews of specification; (4) trust is the moat, not features — a visible honest pricing promise plus a support address that answers would outperform any feature",
  "n/a", "mixed", "26 to Streaks; ~400 spec reviews", "do", "recommendation", "yes",
  ["6179162507","6815111095","11139240840"])
c(108, "§8.6 Research questions this corpus cannot answer", "data-caveat",
  "Research questions: what share of the installed base paid and churned vs stayed silent; did the subscription conversion increase revenue (it plainly destroyed reputation; the corpus says nothing about the P&L); did the Feb 2021 restoration reach everyone or only loud complainers; why did the widget fail (consistent with an entitlement/extension bug); what happened in March 2025 — migration bug, backend change, or entitlement reset; is the product still maintained (2026: 12 reviews)",
  "n/a", "none", "6 questions", "research", "research questions", "yes", [])

with open("Tools/prd_ledger/20/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
