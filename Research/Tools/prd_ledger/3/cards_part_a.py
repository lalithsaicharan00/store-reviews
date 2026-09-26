import json, re
R = 3
rep = open("App Store Reports/3. Days Since - Quit Habit Tracker - Sober Streak Day Counter (REPORT).md").read().split("\n")
def table(start, end):
    rows = [l for l in rep[start-1:end] if l.startswith("|") and not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

c(1, "header line 3-6", "positioning",
  "Days Since is the best-loved free quit-habit counter on the App Store: 10,621 reviews at 4.77, 19,073 US ratings at 4.82, English only, on iPhone / iPad / Mac / Watch / Vision Pro; current version 4.1.0 (31 Aug 2026)",
  "developer A Couple of Friends OOD, bundle npetrova.DaysSince, team named in reviews as Ivo, Nadya, Stan, Petar; free download; IAP 'Count Up Club' monthly $2.99 / $5.99, yearly $17.99, lifetime $49.99 (discounted $11.99); legacy 'Premium' monthly $9.99, yearly $29.99", "praise",
  "10,621 reviews, 111 storefronts, Aug 2019 → Sep 2026; category Health & Fitness / Productivity; age 12+", "none", "corpus-level fact", "app-specific", [],
  cond="a quit-habit / day-counter app, not a routine tracker — audience and moral framing differ (Part 0 §5, Part 5)")
c(2, "How to read this", "data-caveat",
  "Method: bands applied against all 10,621 globally and separately against each of the 23 storefronts with ≥50 reviews (9,667 reviews, 91.0%); the other 88 storefronts hold 954 (9.0%, mean 4.78) and get no standalone claims; one review = 0.0094%; theme membership non-exclusive",
  "n/a", "none", "23 storefronts ≥50; 88 below", "none", "method", "yes", [])

# ---- PART 0 ----
c(3, "Part 0 summary line", "timeline",
  "The best-loved free habit counter put its single most-praised feature — the widget — behind a paywall in July 2025; its 1–2★ rate went from 1.75% to 8.64% in one quarter and had not fully recovered fourteen months later",
  "paywalled the widget July 2025", "1★-burst", "1–2★ 1.75% (2025 Q2) → 8.64% (2025 Q3); mean 4.86 → 4.57", "product-rule", "high-priority", "yes", [],
  side="the clearest single-cause rating collapse in the corpus so far")
c(4, "Part 0 §1", "insight",
  "The product is genuinely excellent: 34.3% praise simplicity (mean 4.90), 8.7% mention the widget (#2 theme), 4.7% praise being free, 1.9% praise no ads, 2.3% praise unlimited counters, 1.4% praise the privacy stack; reviewers call it indistinguishable from a first-party Apple app",
  "minimal, Apple-native feel, free, no ads, unlimited counters, Face ID lock, no account, disguised icon", "praise",
  "simplicity 3,647 (34.3%, 4.90); widget 920 (8.7%); free 495 (4.7%); no ads 206 (1.9%); unlimited counters 244 (2.3%); privacy 145 (1.4%)", "product-rule", "high-priority", "yes",
  ["10404638991","13283082126","9406490807","12367096941","8478010591"],
  side="'The most Apple looking non-Apple app ever' — native-feel design is a praise driver in itself")
c(5, "Part 0 §2 quarter table (verbatim)", "timeline", "Quarterly rating and 1–2★ rate around the July 2025 widget paywall — full table",
  "n/a", "1★-burst", table(42, 50), "none", "high-priority", "app-specific", [],
  cond="2026 Q1 was worse than 2025 Q3 (9.79% 1–2★); partial recovery only by 2026 Q3 (3.14%)")
c(6, "Part 0 §2 monthly line", "timeline", "Widget-paywall complaints by month: 1 in May 2025 → 39 in July 2025 → 12 → 3 → 9 → 6 → 8 → 7, then 2–6 every month through Aug 2026 — 128 reviews total (1.21%, mean 2.48, 59.1% 1–2★)",
  "widget paywalled", "1★-burst", "128 (1.21%), mean 2.48, 59.1% 1–2★; peak 39 in the release month", "product-rule", "high-priority", "yes", [],
  side="a re-paywall produces a spike and then a permanent floor of complaints")
c(7, "Part 0 §2 era table (verbatim)", "timeline", "Four eras A–D: n, mean, 1–2★, free-tier praise, paywall complaint, widget-paywall complaint — full table",
  "n/a", "mixed", table(54, 60), "none", "high-priority", "app-specific", [],
  cond="paywall complaints 1.2% → 5.4% and widget-paywall 0.3% → 4.5% across a single release boundary; 1–2★ 0.83% (A) → 6.95% (D)")
c(8, "Part 0 §3", "insight",
  "The widget is not a nice-to-have, it is the product: 38.2% of 1★ reviews mention it (86 of 225) — the highest concentration of any theme in any star band; users say the widget WAS their reason for keeping the app",
  "widget was free for years, then paywalled", "1★-burst", "86 of 225 1★ (38.2%)", "build-free", "high-priority", "yes",
  ["12866203144","12870567769","12926945945","12862828885","12856046988","12877198255","13876121897","12990450515"],
  side="'Recent update disabled widgets I've been using for 4 years'; 'This app does not have unique qualities to make widgets a premium feature'",
  cond="for a day-counter the widget is the primary surface — the app itself is rarely opened")
c(9, "Part 0 §3 deletion line", "insight", "18 reviews (0.17%) explicitly state they deleted or switched apps over the paywall, mean 1.78",
  "n/a", "churn", "18 (0.17%), mean 1.78", "product-rule", "weak count, explicit churn", "yes",
  ["9178559150","9659762298","10999894947","11129880622","12864082351","12865371985","12875697521","12891028517","12908610575","12926945945","12956539067","12985581259","13017308910","13207861199","13710553115","13950998269","14161669986","14446431929"])
c(10, "Part 0 §4", "anti-pattern",
  "The change was never cleanly resolved: developer replies framed the widget lock-out as a bug and some users saw it reversed, but 31 widget-paywall complaints are dated 2026 (mean 2.32) and one says 'Contrary to the response, widgets are still unavailable for me' — users experienced a paywalled widget continuously from July 2025 to August 2026",
  "called it a bug, partially rolled back (or bug persisted for a subset)", "1★-burst", "31 complaints in 2026, mean 2.32; 3 reviews report reversal", "dont", "inference labelled", "yes",
  ["13144348194","13191073060","12875864707","12948474679","13613452424","13631461492","13636462913","13671837531","13678847520","13695081586","13710553115","13723431455","13876121897","13913566646","13942312007","13961326758","14010071469","14060380344","14066383785","14107888082","14161669986","14191526502","14191530864","14213949714","14245206810","14245784209","14250178496","14254252346","14324807045","14325023621","14340732263","14345891389","14392573700","14475428849","14489833893"],
  side="an ambiguous rollback ('it was a bug') is a second, separate problem: it leaves a subset of users locked out for a year while the developer's public position says otherwise",
  cond="either reading — real paywall partially reversed, or a year-long bug — is bad")
c(11, "Part 0 §5", "audience",
  "The moral framing is unusually hostile and specific to this category: 11 reviews accuse the developer of exploiting vulnerable people ('preying on ppl with addictions'; a widget tracking days since a self-harm attempt 'refusing to work unless I pay $50') — the reputational cost of monetising a recovery tool",
  "monetised a recovery/sobriety tool aggressively", "1★-burst", "11 (0.10%), extreme tone, concentrated post-paywall", "dont", "weak count, reputational", "yes",
  ["12931476120","13452216936","13502020915","12942245612","13723431455","13876121897","13950998269","13172803401","12972611936","8410535615","8206594435"],
  side="users of a quit-habit app include people tracking self-harm, suicidality and addiction; paywall moves read as predatory there in a way they do not in productivity apps",
  cond="see Research Reports/Quit Habit Decision.md")

with open("Tools/prd_ledger/3/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
