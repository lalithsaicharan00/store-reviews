import json, re
R = 13
rep = open("App Store Reports/13. Productive - Habit Tracker - Daily Routine & Goals Planner (REPORT).md").read().split("\n")
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
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- PART 3 ----
c(22, "§3.1 Complete ranked theme table (verbatim)", "data-caveat",
  "Ninety themes ranked with n, %, signal, mean, 1★ n, 5★ n and direction",
  "n/a", "mixed", table("## 3.1 Complete ranked theme table"), "none", "verbatim", "app-specific", [])
c(23, "§3.1 M-sub-objection; M-pay-required; M-want-onetime", "monetization",
  "Subscription objection and 'pay required' are high-priority themes in their own right, and 239 reviews ask for the one-time purchase back",
  "subscription-only since 2017", "complaint", "M-sub-objection 1,998 (10.07%, HIGH) mean 2.45; M-pay-required 1,692 (8.52%) mean 2.13; M-want-onetime 239 (1.20%) mean 2.37", "build-paid", "high-priority", "yes", [])
c(24, "§3.1 M-upsell-nag; M-crossapp-ads; C-rebrand ('Balanced', copycat, Apalon); C-stale-content; C-update-fake; C-rate-prompt; C-fake-reviews", "dont",
  "Smaller conduct themes: upsell nagging, cross-app ads, a 'Balanced' rebrand / copycat / Apalon confusion, stale COVID-era copy, changelogs that describe nothing, a rating prompt, and fake-review allegations (every one a 1★)",
  "n/a", "complaint", "M-upsell-nag 397 (2.00%) mean 2.27; M-crossapp-ads 48 mean 2.38; C-rebrand 98 (0.49%) mean 3.38; C-stale-content 20; C-update-fake 7; C-rate-prompt 10 mean 2.10; C-fake-reviews 5 mean 1.00", "dont", "weak–meaningful", "yes", [])
c(25, "§3.1 U-confusing; U-clutter; U-onboarding; U-icons; U-stats", "feature",
  "UX themes: confusing to use, cluttered (content tabs), onboarding complaints; icons and stats requested or praised",
  "n/a", "mixed", "U-confusing 558 (2.81%) mean 2.62; U-clutter 202 (1.02%) mean 4.21; U-onboarding 80 (0.40%) mean 2.75; U-icons 308 (1.55%) mean 4.16; U-stats 365 (1.84%) mean 3.76", "research", "meaningful", "yes", [])
c(26, "§3.1 P-flexible-good; U-skip-flex; U-multi-daily; U-week-start; U-swipe-back; U-overview; U-order-sort; U-touchid; U-dark-mode; U-calendar; U-onetime-task; U-bad-habit; U-more-free; U-signin-required", "feature",
  "Smaller requests: flexibility praised where present, skip flexibility, multiple-times-daily, week-start setting, swipe-back gesture, upcoming-days overview, sort order, Touch ID / app lock, dark mode, calendar integration, one-off tasks, bad-habit mode, more free habits, and objections to required sign-in",
  "n/a", "mixed", "P-flexible-good 365 (1.84%) mean 4.40; U-skip-flex 155 (0.78%) 4.21; U-multi-daily 34; U-week-start 28 mean 4.11; U-swipe-back 26; U-overview 24; U-order-sort 22; U-touchid 31; U-dark-mode 36; U-calendar 35; U-onetime-task 81 (0.41%); U-bad-habit 69 (0.35%) mean 4.45; U-more-free 56; U-signin-required 7", "research", "weak–emerging", "yes", [])
c(27, "§3.1 D-ipad; D-watch; D-widget; D-update-regression; D-perf; D-notif-spam; D-wrongday; D-auth-prompt; D-add-broken; D-cannot-edit-delete; D-premium-not-applied; M-purchase-fail", "must-never-break",
  "Reliability tail: iPad layout problems, Apple Watch broken for extended periods, widget long absent, update regressions, lag, notification spam, wrong day of week, auth prompts, cannot add/edit/delete, premium not applied, purchase failure",
  "n/a", "complaint", "D-ipad 277 (1.40%) mean 2.88; D-watch 210 (1.06%) 3.55; D-widget 186 (0.94%) 3.58; D-update-regression 87 (0.44%) 2.39; D-perf 56; D-notif-spam 33; D-wrongday 27 mean 2.63; D-auth-prompt 7; D-add-broken 6; D-cannot-edit-delete 16; D-premium-not-applied 2; M-purchase-fail 19", "must-never-break", "weak–meaningful", "yes", [])
c(28, "§3.2 The monetisation family dominates everything else", "insight",
  "The monetisation family dominates everything else: a third of the corpus raises a monetisation issue at the lowest ratings in the corpus, ~3.7× more discussed than reliability — any roadmap that starts with features is mis-prioritised against this evidence",
  "n/a", "1★-burst", "M-* union 6,516 (32.83%) mean 2.34; D-* union 1,785 (8.99%); U-* union 2,911 (14.66%); P-* union 9,393 (47.32%)", "product-rule", "high-priority", "yes", [])
c(29, "§3.3 The five findings with the lowest mean ratings table (verbatim); M-trial-autocharge is the most consequential single number", "must-never-break",
  "The five lowest-mean themes reliably produce a 1★: fake-review allegations, trial auto-charge (the single most damaging mechanic — 5.55% of every review ever written about this app, 999 of 1,102 one-star), support failure, canned replies, refund friction (a distinct, separate injury)",
  "trial auto-charge; unreachable support; canned replies; refund friction", "1★-burst", table("## 3.3 The five findings"), "must-never-break", "high-priority", "yes", [])
c(30, "§3.4 What the product genuinely does well table (verbatim); the product's real job", "insight",
  "What the product genuinely does well, consistent across eleven years and all major storefronts: it works — keeps me on track; simplicity (chosen OVER more powerful tools because it is small); visual design (named even inside 1★ reviews); motivation/accountability (highest mean of any theme); habit actually formed; life change; ADHD/neurodivergent segment; mental-health contexts — the real job is 'remind me, let me tick it off, show me I did it'; nobody asks for content, coaching, courses or AI; the three most-upvoted 5★ reviews describe exactly this loop",
  "simple checklist + reminders", "praise", table("## 3.4 What the product genuinely does well") + " ; top upvoted 144 / 112 / 53 votes", "product-rule", "high-priority", "yes",
  ["6929025111","1537523702","4250072408","5875165421","1417054726","3026852113","7806022477","3573097080","4949195093","1339259899","4371666634","9550964281","4725668608","2622642664","2284758864"])
c(31, "§3.4 Serves mental-health contexts — the corpus's 3rd most-upvoted review from a reviewer with paranoid schizophrenia", "audience",
  "Mental-health users are a small but highly rated context — the corpus's third most-upvoted review is from a reviewer with paranoid schizophrenia",
  "simple structure", "praise", "P-mentalhealth 100 (0.50%) mean 4.34; 53 net votes", "do", "emerging", "yes",
  ["2622642664"])
c(32, "§3.5 Genuinely missing capabilities table (verbatim)", "feature",
  "Missing capabilities ranked: habit notes/journaling, exact reminder times without paying, numeric/quantity goals, localisation (Arabic, Portuguese, Russian, Turkish), flexible frequency, widget, bad-habit mode, one-off tasks, data export, Apple Health, web/Android/macOS, categories/folders, back-dating a missed check-off",
  "absent", "praise", table("## 3.5 Unmet needs"), "build-free", "verbatim", "yes",
  ["1289775574","5092478493","2804919606","5951908643","3743847782","5907419362","1471553000","8471728362","1571196484","2344695224","8273087572","6893540461","1233009943"])
c(33, "§3.5 Numeric / quantity goals (pages, glasses, minutes)", "feature",
  "Numeric / quantity goals (pages, glasses, minutes) are an emerging request",
  "absent", "praise", "U-quantity 165 (0.83%, emerging) mean 3.86", "undecided", "emerging", "yes",
  ["2804919606","5951908643","8389382415","6988565357"])
c(34, "§3.5 Flexible frequency (every-N-days, N×/week, specific weekdays)", "feature",
  "Flexible frequency — every N days, N times per week, specific weekdays — is an emerging request",
  "daily only (or limited)", "praise", "U-weekday-schedule 79 + U-multi-daily 34 (0.57%, emerging)", "must-have", "emerging", "yes",
  ["3743847782","5907419362","7806022477","9402208057"])
c(35, "§3.5 Habit notes / journaling per entry", "feature",
  "Per-entry habit notes / journaling is the largest missing capability",
  "limited or absent", "praise", "U-notes 251 (1.26%, meaningful) mean 3.45", "build-free", "meaningful", "yes",
  ["1289775574","5092478493","5822571198"])
c(36, "§3.5 Broken existing capabilities table (verbatim); the sync failure is the most important item", "must-never-break",
  "Broken capabilities: iCloud sync does not work (the most important item — 8.90% of 3★ reviews where people still want to like the app, rising 0.7% in 2015 to 7.4% in 2026, the defect most likely costing renewals), crashes, data/streak loss, reminders don't fire, reordering doesn't persist, bricked on launch, timer stops when locked, wrong day of week, cannot edit/delete",
  "sync advertised, non-functional", "1★-burst", table("## 3.5 Unmet needs", 1) + " ; D-sync 8.90% of 3★; 0.7% (2015) → 7.4% (2026)", "must-never-break", "meaningful, worsening", "yes",
  ["3386723296","3070069271","4356794558","5778564141","5121372777","1893314966","1292927622","5343328336","1812417285","3207908444"])
c(37, "§3.5 Habit reordering doesn't persist", "must-never-break",
  "Habit reordering does not persist — a small but repeated defect",
  "reorder resets", "complaint", "D-reorder 77 (0.39%, weak) mean 3.36", "must-never-break", "weak", "yes",
  ["5343328336","5538242964","5454764650","7881326098"])

with open("Tools/prd_ledger/13/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
