import json
R = 3
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

c(101, "Part 8 #1", "product-rule", "Never paywall the widget — it is the intervention, not a convenience; 26% of all 1★ reviews are about this one decision; if the widget must be monetised, monetise VARIANTS (multi-counter widgets, custom art, goal-progress rings) and keep a single-counter widget free forever",
  "paywalled the base widget", "1★-burst", "26% of 1★; a full quarter's rating", "build-free", "high-priority", "yes", [],
  cond="evidence: R03-008, R03-016; the 'monetise variants' rule reconciles with report 1 where widget customisation is a purchase driver")
c(102, "Part 8 #2", "must-have", "Ship iCloud sync and automatic backup, free — losing a 2-year sobriety streak on a phone upgrade is an unrecoverable brand event; 'Back up is literally PREMIUM?' is the line that will follow you",
  "backup paid", "1★-burst", "44 reviews, 9 confirmed data losses", "build-free", "high-priority (severity)", "yes", ["13629061971"], cond="evidence: R03-076")
c(103, "Part 8 #3", "must-never-break", "Make reset undoable and the widget reset button optional — add a confirmation, an undo window, and a per-widget toggle",
  "un-undoable widget reset", "complaint", "33 reviews, several payers", "must-never-break", "meaningful (safety)", "yes", [], cond="evidence: R03-075")
c(104, "Part 8 #4", "must-never-break", "Honour entitlements the moment they're purchased — Lifetime buyers being asked to subscribe is the most damaging bug class in the corpus",
  "entitlement failures", "1★-burst", "6 of 11 1–2★ payers", "must-never-break", "high-priority", "yes", [], cond="evidence: R03-030, R03-031, R03-039")
c(105, "Part 8 #5", "product-rule", "Offer a cheap one-time purchase — 18 explicit requests, ~12 unsolicited offers to donate with no mechanism, and the most-quoted objection is subscription-as-principle, not amount: 'subscription fatigue is real'",
  "subscription-first, $49.99 lifetime", "blocked-conversion", "18 + ~12", "product-rule", "weak count, clear principle", "yes", ["14060380344"], cond="evidence: R03-032, R03-033, R03-042")
c(106, "Part 8 #6", "market", "Regional pricing for IN, TR, UA, BR, MX, SA — India has 346 reviews, a 4.79 mean, near-zero monetisation friction and three reviews naming price as the only blocker: the largest untapped conversion pool visible",
  "single global price", "blocked-conversion", "IN 346 at 4.79", "do", "meaningful", "yes", [], cond="evidence: R03-034, R03-090")
c(107, "Part 8 #7", "dont", "Add a 'don't ask again' control for the upgrade prompt — 176 reviews, 73% from 5★ users; costs nothing and buys back a percentage point of rating",
  "no opt-out", "complaint", "176 (1.66%)", "dont", "meaningful", "yes", [], cond="evidence: R03-035, R03-041")
c(108, "Part 8 #8", "dont", "Respect the iOS 'no in-app review prompts' setting — a lifetime customer is telling you you're violating a system preference",
  "review prompts ignore the OS opt-out", "complaint", "11 reviews, 3 payers", "dont", "weak", "yes", ["10818110589"], cond="evidence: R03-036")
c(109, "Part 8 #9", "feature", "Pause / stop / archive a counter — 44 requests, mean 4.02, several explicit 'this is the only thing keeping it at 4 stars'",
  "missing", "complaint", "44 (0.41%), mean 4.02", "must-have", "high-priority (leverage)", "yes", [], cond="evidence: R03-051, R03-074")
c(110, "Part 8 #10", "feature", "Milestone celebration and achievements — 235 requests over six years; v4.1.0 appears to address this, validate against the 3–4★ band in the next corpus",
  "shipped Aug 2026", "complaint", "235 (2.21%)", "undecided", "meaningful", "yes", [], cond="evidence: R03-077")
c(111, "Part 8 #11", "feature", "A proper notes / journaling field — 152 reviews; the current field is a single cramped line; 'an important part of recovery is journaling to help identify common triggers'",
  "single-line note on reset", "complaint", "152 reviews", "research", "meaningful", "yes",
  ["12151285522","14270251700","9673744206","12251429856","12662372114","10483620131"], cond="evidence: R03-078")
c(112, "Part 8 #12", "feature", "Graphs and trend analytics — streak length over time, resets per month, average-streak trend; two users describe the exact chart they want",
  "basic stats only", "complaint", "48 (0.45%), mean 4.60", "build-paid", "weak", "yes", ["10193651577","13974353363"], cond="evidence: R03-063")
c(113, "Part 8 #13", "feature", "Countdown / 'days until' mode — 27 requests 2020–2026; users want one app, not two",
  "count-up only", "complaint", "27 (0.25%)", "research", "weak", "yes", [], cond="evidence: R03-067")
c(114, "Part 8 #14", "feature", "Folders / categories — 43 requests, mean 4.67, zero 1–2★: pure power-user demand from people tracking 20–100 counters",
  "flat list", "complaint", "43 (0.40%), mean 4.67, 0 1–2★", "undecided", "weak", "yes", [], cond="evidence: R03-064")
c(115, "Part 8 #15", "feature", "A 'good habit' inverse mode — the chore/ADHD cohort is 4.17% and growing and deserves a first-class mode rather than a workaround",
  "count-up only, recovery framing", "complaint", "10 explicit requests; 443 chore/ADHD users", "research", "very strong (audience)", "yes", [], cond="evidence: R03-081, R03-082")
c(116, "Part 8 #16", "feature", "Money-saved counter — standard in competing quit-smoking apps and repeatedly named as the one thing missing",
  "missing", "complaint", "14 (0.13%), mean 4.57", "research", "weak", "yes", [], cond="evidence: R03-072; category-specific")
c(117, "Part 8 #17", "do", "Lead with 'unlimited counters, free, private' — the three things advocates say unprompted, and all three are why people leave I Am Sober",
  "n/a", "praise", "30 I Am Sober comparisons, mean 4.47", "do", "very strong", "yes", [], cond="evidence: R03-045, R03-054, R03-055")
c(118, "Part 8 #18", "must-have", "Protect the privacy stack as a headline feature — Face ID, no account, neutral name, alternate icons; 145 reviews, mean 4.90, zero negative; it is what makes the app usable by a 13-year-old tracking self-harm on a family phone",
  "privacy stack free", "praise", "145 (1.37%), mean 4.90, 0 1–2★", "must-have", "meaningful", "yes", [], cond="evidence: R03-055, R03-080")
c(119, "Part 8 #19", "product-rule", "Keep the neutral, non-judgemental reset — the competitive differentiation against every 'sobriety coach' app is that this one doesn't talk",
  "no motivational copy, no shame on reset", "praise", "130 reviews praise it", "product-rule", "meaningful", "yes", [], cond="evidence: R03-056, R03-052")
c(120, "Part 8 #20", "product-rule", "Do not remove a feature users already have — the 2022 subscription launch was survivable because it ADDED a tier; the 2025 widget change was not, because it took something away: 'I just don't agree with taking away features that have been free for years'",
  "removed a free feature", "1★-burst", "two shocks compared: +3 pts 1–2★ recovered vs +7 pts not recovered", "product-rule", "high-priority", "yes", ["12887257900"], cond="evidence: R03-095, R03-096")
c(121, "Part 8 #21", "dont", "Do not monetise the vulnerable-user surface — in a category where users track self-harm and suicide attempts, 'preying on addicts' framing spreads faster than any feature",
  "aggressive paywall on a recovery tool", "1★-burst", "11 accusations", "dont", "weak count, reputational", "yes", [], cond="evidence: R03-011, R03-080")
c(122, "Part 8 #22", "dont", "Do not ship a paywall change silently — 'No warning, no version update info about it'; if the July 2025 lock-out really was a bug, the absence of a release note is why nobody believed it",
  "undisclosed change", "complaint", "DK/PL complaints", "dont", "limited evidence, clear mechanism", "yes", ["12882383970"], cond="evidence: R03-010, R03-088")

c(123, "Appendix — method", "data-caveat", "Method: 10,621 records, zero duplicates, 100% reconciliation; all reviews read in full (1–4★ first, then 9,250 5★) across 28 languages; regex candidates then manual false-positive removal; confirmed-payer list fully hand-curated (n=45 — direction robust, figure not); 22.1% of bodies under 40 chars at mean 4.83; 8 of 23 eligible storefronts sit at 50–71 reviews; the July 2025 event cannot be fully adjudicated from reviews alone; causal claim rests on three independent lines (monthly spike 1→39, quarterly discontinuity, first-person narration)",
  "n/a", "none", "10,621 reviews; 5★ 9,250 / 4★ 849 / 3★ 191 / 2★ 106 / 1★ 225; mean 4.7694; is_edited 121 (1.14%); 187 with helpfulness votes; two external sources accessed 2026-09-09", "none", "method", "yes", ["14060380344"])

with open("Tools/prd_ledger/3/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
