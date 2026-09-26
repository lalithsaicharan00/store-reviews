import json, re
R = 20
rep = open("App Store Reports/20. Habit — Daily Tracker - Crush your goals like a boss (REPORT).md").read().split("\n")
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

# ---- PART 2 ----
c(14, "§2.1 Feature inventory, reconstructed from reviews (verbatim table)", "feature",
  "Inventory: named habits with emoji (free → capped at 3 after Jan 2021); tap to check off and back-fill previous days (free, heavily praised); habit-strength % '2-day rule'/91-day model (free; decay broke in 2021); 5-day strip on home (users want 7); per-habit calendar + line graph (free); frequency 'N times in M days' (free; no weekday selection, ever); one reminder per habit with custom message text (free, widely loved); extended notifications (paid); colour per habit (3 free / rest paid); dark mode (was free-ish → paid); widget, Today-view only (paid, largely non-functional); manual iCloud backup/restore (paid after Jan 2021); drag to reorder (free, buggy); no account/no signup (praised — and the root cause of data loss); never shipped: Apple Watch (62 requests), iPad (43), cross-device sync (84), streak counter (71), notes/journal (79), categories (58), multiple check-ins per day (54), bad-habit marking (34), export (9)",
  "see table", "mixed", table("## 2.1 Feature inventory"), "none", "inventory", "app-specific",
  ["4249750910","5548125389","7556821463","8294993952","4002933043","6212755668","4786240616","4547198891","5985102033","4406637526","4760160029","4556013072","3902556063","5507533196","9354551485","6503718035","9954684066","5963669614","12486017227","5085465606","3989149597","6038787492"])
c(15, "§2.1 The striking fact: across 92 months, no significant new capability shipped", "anti-pattern",
  "Across 92 months the corpus records no significant new capability shipping — the only material product changes are the paywall (2021), a widget that never worked and two data-destroying updates; 'This app provides ZERO updates, content, features… NOTHING that justifies a yearly subscription fee'",
  "subscription with no delivery", "churn", "92 months, zero shipped capabilities", "product-rule", "close reading", "yes", ["6939282534"])
c(16, "§2.1 5-day strip on home screen — users want 7", "feature",
  "The home screen shows a 5-day strip; a persistent complaint asks for 7", "5-day strip", "complaint", "N-7days 25 (0.62%, mean 3.32)", "free", "emerging", "yes", ["4002933043","6212755668","6391933344"])
c(17, "§2.1 Frequency 'N times in M days' — no weekday selection, ever", "feature",
  "Frequency is 'N times in M days' only; specific-weekday selection never shipped — '3× a week ≠ Mon/Wed/Fri'", "no weekday selection", "complaint", "N-weekday-select 22 (0.54%, mean 3.64)", "must-have", "emerging", "yes", ["4547198891","5985102033"])
c(18, "§2.1 One reminder per habit with custom message text — widely loved", "feature",
  "One reminder per habit with custom message text — users write their own motivational line and get it back in the notification; small feature, outsized affection", "free custom reminder text", "praise", "P-custom-reminder 25 (0.62%), mean 4.60", "free", "emerging", "yes",
  ["3892496995","4035547945","4406637526","4760160029","5181431978"])
c(19, "§2.1 No account / no signup — praised, and the root cause of data loss", "contradiction",
  "No account and no signup was praised — and is the root cause of data loss; manual iCloud backup was paywalled after Jan 2021", "no account; paid manual backup", "mixed", "praised in E1; N-data-loss 233; N-no-account 16 (0.40%, mean 2.19)", "must-have", "close reading", "yes",
  ["3989149597","6038787492","5963669614","12486017227"])
c(20, "§2.2 The price ladder — before 27 Jan 2021: pay-what-you-want, one-time, non-crippling", "monetization",
  "Before 27 Jan 2021: three pay-what-you-want one-time tiers granting identical features — $2.99 / $4.99 / $14.99, £4.99 / £6.98 / £14.99, €5.49, 449–500₽, ₹399, CHF 5; the model was itself a marketing asset: '£4.99 to say thank you, £6.98 for liking the app and £14.99 for loving it and buy the developers a bottle of champagne'",
  "pay-what-you-want one-time tiers, no feature difference", "purchase-driver", "35 reviews (0.86%) praise the pricing model explicitly, mean 4.83", "build-paid", "emerging / exceptional magnitude", "yes",
  ["4035547945","4945935338","6922843265","6926974009","7290434920","6927207629","6956239325","6172057750"])
c(21, "§2.2 After 27 Jan 2021 — annual subscription; the multiple is the finding", "monetization",
  "After 27 Jan 2021: annual subscription at $39.99 / £38.99 / €43.99–45 / CAD 52.99 / AUD 65.99 / 3,150→3,199₽ / HUF 15,500 / PLN ~150–200 / EGP 600+; promo prices $11.99, $19.99, $9.99, $5.99, £11.99, 900–970₽, 499₽, €13.49; for a US user $4.99 once became $39.99 per year — ~8× first-year and unbounded thereafter; Russian users 449₽ once → 3,150₽/year, a 7× annual multiple",
  "one-time → annual at ~8× the old price", "1★-burst", "84 (2.08%) quote the full annual price, 68 (1.68%) the old one-time price; both cohorts mean ~1.5", "product-rule", "meaningful", "yes", [])
c(22, "§2.3 Free / paid / trial classification (post-2021) (verbatim table)", "monetization",
  "Post-2021: free = 3 habits, 3 colours, light theme, 1 basic reminder per habit, calendar + graph, back-fill; paid annual = unlimited habits, all colours, dark mode, extended notifications, manual iCloud backup/restore, widget (advertised, frequently non-functional); trial inconsistent — several charged immediately on what they believed was a trial; unclear whether legacy lifetime entitlements survive a device change — evidence says often not",
  "3-habit free cap; paid layer of colours/dark/backup/widget", "mixed", table("## 2.3 Free / paid / trial"), "product-rule", "review-derived", "app-specific",
  ["7199706726","6973740694","7744703720","12463560595","11331516789","12851060314","13813023344","9496355399"])
c(23, "§2.3 Legacy lifetime entitlements often do not survive a device change", "must-never-break",
  "Legacy lifetime entitlements often do not survive a device change — restore purchase fails for pre-2021 buyers years later", "restore fails on new device", "churn", "4 named IDs; N-restore-fail 91 (2.25%, mean 1.59)", "must-never-break", "meaningful", "yes",
  ["11331516789","12851060314","13813023344","9496355399"])
c(24, "§2.4 #1 The non-expiring countdown", "anti-pattern",
  "A 'limited time offer' timer that resets on expiry, forever — 'When the premium offer ending counter finishes it just resets back to 60 hours' — reported continuously Jan 2021 → Mar 2025", "fake countdown that resets", "1★-burst", "part of N-aggressive-popup 225 (5.56%, high-priority, mean 1.80)", "dont", "high-priority", "yes",
  ["6960081353","7285176283","7159264561","7016202698","9598232878"])
c(25, "§2.4 #2 Full-screen interstitial on every launch with a small/low-contrast dismiss", "anti-pattern",
  "A full-screen interstitial on every launch with a small, low-contrast dismiss control — 'Dark patterns make bad UX!'", "launch interstitial", "complaint", "within N-aggressive-popup 225", "dont", "high-priority", "yes", ["6927664461"])
c(26, "§2.4 #3 Add-habit button routed to the paywall — including after deleting a habit to make room", "anti-pattern",
  "The add-habit button routes to the paywall, including after the user deleted a habit to make room — the mechanic that converted annoyance into uninstalls", "core action → paywall", "churn", "4 named IDs", "dont", "close reading", "yes",
  ["7266229179","7090282099","8381455001","7266633441"])
c(27, "§2.4 #5 The review prompt whose decline option was 'let the developers be sad'", "anti-pattern",
  "The review prompt's decline option read 'let the developers be sad'; 26 reviews say it worked on them; two call it emotionally manipulative and dock stars for it", "guilt-worded review prompt", "mixed", "26 (0.64%) prompt-driven, mean 4.54; 2 dock stars", "dont", "emerging", "yes", ["9069346040","7133029560"])

# ---- PART 3 ----
c(28, "§3.1 Complete ranked theme table (verbatim, 48 rows)", "data-caveat",
  "All 48 themes (n / % / mean / era-relative): P-simple 1,111 (27.45%, 4.25, 42.8% of E1); N-subscription-model 829 (20.48%, 1.56, 48.4% of E2); N-revoked-purchase 615 (15.19%, 1.37, 41.3% of E2); P-design 537 (13.27%, 4.16, 20.8% of E1); M-onetime-model 275 (6.79%, 1.81); N-price-too-high 242 (5.98%, 1.52, 13.0% of E2); N-data-loss 233 (5.76%, 1.43, 78.3% of E4); N-aggressive-popup 225 (5.56%, 1.80); N-widget-broken 182 (4.50%, 1.94, 12.1% of E3); N-support-silent 148 (3.66%, 1.33, 13.0% of E4); X-widget-mention 128; N-cancel-refund 125 (3.09%, 1.28); N-habit-cap-3 99 (2.45%, 1.94); N-restore-fail 91 (2.25%, 1.59); N-dark-mode 89 (2.20%, 2.69); N-sync-backup 84 (2.08%, 2.43, 9.9% of E4); N-notes-journal 79 (1.95%, 3.66); P-outcome 71 (1.75%, 4.17); N-streak-count 71 (1.75%, 3.72); N-unlimited-removed 63 (1.56%, 1.51); N-no-watch 62 (1.53%, 4.15); N-notifications 59 (1.46%, 3.07); N-categories 58 (1.43%, 3.57); P-unlimited-free 54 (1.33%, 4.94); N-multi-per-day 54 (1.33%, 3.87); P-no-ads 49 (1.21%, 4.86); N-no-ipad 43 (1.06%, 3.33); P-forgiving-algo 38 (0.94%, 3.95); P-onetime-praise 35 (0.86%, 4.83); N-bad-habits 34 (0.84%, 3.94); N-colors 33 (0.82%); N-widget-request 28 (0.69%, 3.82); N-billing-mismatch 28 (0.69%, severe, 1.64); N-crash 27 (0.67%, 2.52); P-review-nag 26 (0.64%, 4.54); N-compact-layout 26 (0.64%, 4.27); P-custom-reminder 25 (0.62%, 4.60); N-7days 25 (0.62%, 3.32); N-false-advertising 24 (0.59%, 1.21); N-weekday-select 22 (0.54%, 3.64); N-percent-confusion 20 (0.49%, undercounted, 3.30); N-privacy 17 (0.42%, 1.94); N-no-account 16 (0.40%, 2.19); N-localization 10 (0.25%); N-export 9 (0.22%, 4.44); N-checks-disappear 7 (0.17%); N-archive 4 (0.10%, 4.50); N-timezone 3 (0.07%)",
  "n/a", "mixed", table("## 3.1 Complete ranked theme table"), "none", "theme table", "app-specific", [])
c(29, "§3.1 N-subscription-model — objection to subscription is the #1 negative theme", "monetization",
  "Objection to the subscription model is the largest negative theme — 48.4% of the conversion era", "subscription-only after one-time", "1★-burst", "829 (20.48%, high-priority, mean 1.56); 48.4% of E2", "product-rule", "high-priority", "yes", ["6921814497","6922110474"])
c(30, "§3.1 N-revoked-purchase — paid entitlement taken away", "product-rule",
  "Paid entitlements were taken away at conversion — 41.3% of the conversion era", "revoked lifetime purchases", "1★-burst", "615 (15.19%, high-priority, mean 1.37); 41.3% of E2", "product-rule", "high-priority", "yes", [])
c(31, "§3.1 N-dark-mode — dark mode moved to paid", "feature",
  "Dark mode was free-ish and became paid after Jan 2021; requested from E1", "dark mode paid", "complaint", "89 (2.20%, meaningful, mean 2.69)", "free", "meaningful", "yes", ["5507533196","9354551485"])
c(32, "§3.1 N-privacy — weak but low-rated", "feature",
  "Privacy concerns are weak in volume but low-rated (mean 1.94)", "n/a", "complaint", "17 (0.42%, weak, mean 1.94)", "do", "weak", "yes", [])
c(33, "§3.2 The trust family dominates everything else", "insight",
  "Union of revoked-purchase, restore-fail, cancel-refund, billing-mismatch, false-advertising and support-silent = 810 reviews (20.01%, mean 1.39) versus the union of every feature-gap theme = 513 (12.67%, mean 3.57); trust complaints outnumber feature complaints by 1.58× and carry 2.2 stars less — this app did not fail on features, it failed on keeping promises",
  "n/a", "1★-burst", "810 (20.01%, mean 1.39) vs 513 (12.67%, mean 3.57)", "product-rule", "high-priority", "yes", [])
c(34, "§3.3 The five findings with the lowest mean ratings (verbatim table) — every one an integrity failure", "insight",
  "Lowest-mean themes: false advertising 24 (1.21); cancel/refund 125 (1.28); support silent 148 (1.33); revoked purchase 615 (1.37); data loss 233 (1.43) — every one an integrity failure, not a capability gap; not one requires new product surface to fix",
  "n/a", "1★-burst", table("## 3.3 The five findings"), "must-never-break", "high-priority", "yes", [])
c(35, "§3.4 Minimalism — the most-praised attribute", "feature",
  "Minimalism is the most-praised attribute by a wide margin, framed against competitors — reviewers had tried 5, 10, 20 trackers and found them cluttered or gamified", "minimal", "praise", "1,111 (27.45%), 42.8% of E1, mean 4.25", "must-have", "high-priority", "yes",
  ["3601977788","4423183878","4633148866","4836612463","5097711923","5946775063","6496027991"])
c(36, "§3.4 Visual design — colour-filling bubbles that grow with habit strength", "feature",
  "Colour-filling bubbles that grow with habit strength, repeatedly described as the reason they open the app", "bubbles that fill with strength", "praise", "537 (13.27%), 20.8% of E1, mean 4.16", "must-have", "high-priority", "yes",
  ["3940095679","4121063134","4497709123","4723686998","5202604486","5603920265","6430207073"])
c(37, "§3.4 Unlimited habits, free — the highest-mean theme in the corpus", "feature",
  "Unlimited habits free is the highest-mean theme in the entire corpus", "unlimited free (pre-2021)", "praise", "54 explicit (1.33%), mean 4.94", "free", "meaningful / exceptional magnitude", "yes",
  ["3608816066","3895739282","3999790253","4184551703","4503098570","4723577547","4979659555","5006450649","5146953030","6272244857"])
c(38, "§3.4 No ads", "feature",
  "No ads is a top-rated praise theme", "ad-free", "praise", "49 (1.21%), mean 4.86", "free", "meaningful", "yes",
  ["3601977788","3904267605","3980990590","4120408877","4321444813","4994394779","5272119146","5953213628"])
c(39, "§3.4 The forgiving habit-strength model — the real differentiator", "feature",
  "A non-streak habit-strength percentage that decays instead of resetting — missing a day reduces the score instead of zeroing a streak, which prevents the 'what the hell' abandonment spiral: 'most focus too much on streaks… missing one day and breaking my streak tends to send me into a spiral where I give up'; a DE user explains it as logarithmic rather than linear and 'much closer to psychological reality'; the decay behaviour broke in the 2021 rewrite and was never restored",
  "decaying strength % instead of streaks; broken 2021", "praise", "38 explicit (0.94%), mean 3.95 — highest-affection language in the corpus", "must-have", "emerging / differentiator", "yes",
  ["6179162507","7556821463","4249750910","5548125389","6213055572","6815111095","7520606500","8294993952"])
c(40, "§3.4 Documented outcomes — real behaviour change", "insight",
  "Real behaviour change: medication adherence, exercise, study, sobriety, hydration; a RU user credits the app with the discipline that led to moving country, starting a relationship and founding a company — 'and it all starts with make your bed every day'", "n/a", "praise", "71 (1.75%), mean 4.17", "none", "meaningful", "yes", ["8294993952"])
c(41, "§3.5 Genuine capability gaps (verbatim table) — polite requests, ratings stay high", "feature",
  "Never built, requested politely by people who wanted to stay: notes/journal per day 79 (3.66, most-requested); streak counter 71 (3.72, alongside not instead of the % model); Apple Watch 62 (4.15, highest-mean gap, asked by fans); categories/folders 58 (3.57); multiple check-ins per day 54 (3.87 — water, medication, teeth); iPad 43 (3.33); bad-habit/'failed' marking 34 (3.94); specific weekdays 22 (3.64); export 9 (4.44); archive completed habits 4 (4.50)",
  "none shipped", "complaint", table("**Genuine capability gaps**"), "none", "request table", "app-specific", [])
c(42, "§3.5 Notes/journal per day — the most-requested single feature", "feature",
  "Notes/journal per day is the most-requested single feature and never shipped", "absent", "complaint", "79 (1.95%, meaningful, mean 3.66)", "free", "meaningful", "yes", [])
c(43, "§3.5 Streak counter — requested alongside, not instead of, the % model", "feature",
  "A streak counter was requested alongside, not instead of, the strength-% model", "absent", "complaint", "71 (1.75%, meaningful, mean 3.72)", "undecided", "meaningful", "yes", [])
c(44, "§3.5 Apple Watch — the highest-mean gap, asked by fans", "feature",
  "An Apple Watch app never shipped; the highest-mean capability gap, asked by fans", "absent", "complaint", "62 (1.53%, meaningful, mean 4.15)", "paid", "meaningful", "yes", [])
c(45, "§3.5 Categories/folders; multiple check-ins per day; bad-habit marking; archive", "feature",
  "Categories/folders (58, 3.57) scale with habit count; multiple check-ins per day (54, 3.87 — water, medication, teeth); bad-habit/'failed' marking (34, 3.94); archive completed habits (4, 4.50)", "absent", "complaint", "58 + 54 + 34 + 4", "undecided", "meaningful / emerging", "yes", [])
c(46, "§3.5 iPad-native app — never shipped", "feature",
  "An iPad-native app never shipped", "absent", "complaint", "43 (1.06%, meaningful, mean 3.33)", "must-have", "meaningful", "yes", [])
c(47, "§3.5 Data export — never shipped", "feature",
  "Data export never shipped; requested at a high mean", "absent", "complaint", "9 (0.22%, weak, mean 4.44)", "free", "weak", "yes", [])
c(48, "§3.5 Broken existing capabilities (verbatim table) — ratings collapse", "must-never-break",
  "Built or advertised, didn't work: widget 182 (1.94); data loss 233 (1.43); restore purchase fails 91 (1.59); notifications wrong/absent 59 (3.07); crashes 27 (2.52); check marks disappearing 7 (2.14)", "n/a", "1★-burst", table("**Broken existing capabilities**"), "must-never-break", "very strong", "yes", [])
c(49, "§3.5 Misunderstandings — the habit-strength percentage is a documentation failure, not a maths failure", "insight",
  "Users cannot work out what the strength number means — a weekly habit completed once shows 4%, not 100%; the developer's answer that it takes ~91 repetitions to reach 100% reads as arbitrary; a documentation failure, not a maths failure, and the one complaint that is cheap to fix",
  "unexplained strength %", "complaint", "20 classified (0.49%, undercounted), mean 3.30", "must-have", "weak (undercounted)", "yes",
  ["4839534150","5364934470","5698098227","5865009022","6157103566","8231849401","8469399280","10298454471"])
c(50, "§3.5 Pricing objections — many state a price they would pay: $5–15 one-time", "monetization",
  "Pricing objections (242 price-too-high + 829 subscription-model) — many state a price they would pay, $5–15 one-time recurring constantly: 'I would be willing to pay $10–$15 per year, but even the promo price of $20 is too high'", "n/a", "blocked-conversion", "242 + 829; stated willingness $5–15", "build-paid", "high-priority", "yes", ["6922110474"])
c(51, "§3.6 Competitors named (verbatim table) — Streaks is the destination, explicitly because it is a one-time purchase", "positioning",
  "145 reviews (3.58%) name an alternative; Streaks 26 (overwhelmingly Feb 2021, explicitly because it is a one-time purchase — 'I'm gonna use Streaks, even though I like this app better. $40 a year, this ain't worth'), Done 4, Habitica 3, Habit List 3, Todoist 3, Productive 2, Tally 2, (Not Boring) Habits 2, Fabulous 2, Loop/Strides/TickTick/Notion/Onrise/Way of Life 1 each; one churning customer wrote a complete gap analysis: 'it adds things to apple health and has custom icons and you can set multiple reminders. apple watch support and an updated ios14 widget'",
  "compared against Streaks (one-time purchase)", "churn", table("## 3.6 Competitors named"), "do", "very strong", "yes", ["6921814497","6928343835"])

with open("Tools/prd_ledger/20/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
