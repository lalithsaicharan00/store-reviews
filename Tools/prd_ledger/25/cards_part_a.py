"""Cards for report 25 — header, warnings, executive summary, Part 1, Part 2."""
import json, re
R = 25
rep = open("App Store Reports/25. Grit - Daily Habit Tracker - Routines & Goals ADHD Planner (REPORT).md").read().split("\n")
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

c(1, "header lines 1-9; §12.4 External sources", "positioning",
  "Grit — Daily Habit Tracker · Routines & Goals ADHD Planner (App Store ID 6446997766) — a young (May 2023→) single-developer freemium tracker with a hard 3-habit free cap, then monthly / annual / lifetime IAP, no ads; a monetisation corpus, not a feature corpus",
  "developer of record GrittyApps (a single maker, 'Stephan'); bundle stoope.Grit; extracted 8 Sep 2026; analysis 11 Sep 2026; store rank 25; free 3-habit cap → monthly/annual/lifetime", "mixed",
  "1,309 reviews · 91 storefronts · 22 May 2023 → 6 Sep 2026; mean 3.671; 5★ 722 (55.16%) / 4★ 122 (9.32%) / 3★ 79 (6.04%) / 2★ 84 (6.42%) / 1★ 302 (23.07%)", "none", "corpus-level fact", "app-specific", [])
c(2, "How to read this; Seven warnings; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Known limitations; §12.1 counting rules; §12.3 validation; §12.5 Reproduction", "data-caveat",
  "Method: 1,309/1,309 read in full in 12 batches of 110, country-then-date order; 52-theme multilingual regex classifier with four disclosed corrections (free-cap 176→138 by requiring a limit-context word; 'ai' matched French j'ai → 1 genuine AI review, no AI finding; freeze regex inflated by Spanish 'nada' → reliability cluster hand-curated from 126 candidates to 51 launch-blocker + 12 data-loss IDs; ADHD split into adhd_named 41 and exec_difficulty 24); ambiguous surfaces split into mention/positive/problem; every aggregate computed twice — all 1,309 and the 801 substantive records (body > 60 chars) — because an in-app review prompt inflates the headline; corpus is small and back-weighted (44.8% in the 8 months of 2026); only 7 storefronts ≥50 (820, 62.64%); the free cap is not a constant (2–5 reported, 3 dominant); no version field; paid evidence self-selecting (57, 4.35%); 43 first-impression reviews (3.28%, mean 4.21, 31 5★) from people who have not used it; storefront ≠ language (French in mx, Spanish/Arabic in us); price claims not reconcilable (30+ figures, 12 currencies, pesos-vs-dollars confusion); no external source consulted; vote fields too sparse to weight (139)",
  "n/a", "none", "1,309/1,309; 91 storefronts; 0 empty; 3 duplicate groups (7 records) kept; is_edited 11 (several visible downgrades — 'Moved to 3 stars because they're not listening'); substantive n=801", "none", "method", "yes",
  ["13992368997","14461664452","14252109539","10930050142","13421495866","13433865029","13630801788","14368847160","13672090254","12319455814","13290152980","14164700184","13976982513","12658607281"])
c(3, "Warning #1 — the headline rating is inflated by an in-app review prompt, and the inflation grows: ≤25-char reviews 7.2% (E1) → 13.8% (2025) → 33.4% (2026), 150 of 196 5★; eight reviewers say it asked before they had used it", "data-caveat",
  "The headline rating is inflated by an in-app review prompt and the inflation grows: reviews with a body of ≤25 characters rise from 7.2% of 2023–24 (17/236) to 13.8% of 2025 (67/487) to 33.4% of 2026 (196/586), 150 of those 196 are 5★, and eight reviewers explicitly complain the app asked for a review before they had used it",
  "early, aggressive review prompt", "5★-burst", "7.2% → 13.8% → 33.4%; 150/196 5★; 8 explicit complaints", "dont", "very strong", "yes",
  ["12424719394","12591004629","12876930985","12957806563","13386578145","13411399713","13419192067","13764701322"])
c(4, "Warning #5 — the free cap is not a constant: reviewers report 2, 3, 4 or 5 free habits; three dominant", "data-caveat",
  "The free cap is not a constant — reviewers report 2, 3, 4 or 5 free habits ('2 goals', 'solo 2 habitos', 'more than one task', 'four tasks', '3-5 alışkanlık'); three is dominant, so a 2024 and a 2026 '3 habits' complaint may be about different builds and paywall placements", "cap varied across builds", "complaint", "5 reviews naming different caps", "none", "method", "app-specific",
  ["11855794951","12293948829","13693237309","14200651675","14118452913"])
c(5, "Executive summary #1 — the 3-habit free cap is the single largest fact and the first thing most new users meet; all monetisation friction = 56.0% of all 1★", "monetization",
  "The 3-habit free cap is the single largest fact in the corpus and the first thing most new users meet; widened to all monetisation friction (cap, paywall, upsell pop-ups, price, paywalled statistics, survey-then-paywall) it is 22.77% of reviews at mean 1.99 and 56.0% of all 1★ reviews",
  "hard 3-habit free cap with paywalled stats", "1★-burst", "cap 138 (10.54%, high-priority), mean 2.13, 68 1★; all friction 298 (22.77%), mean 1.99, 169 1★ (56.0% of 1★)", "product-rule", "high-priority", "yes",
  ["11344752179","11580010213","12038603986","12418313250","12594456123","13570261114","13653480657","13759652099","14119383340","14452682730","14500984459"])
c(6, "Executive summary #2 — the complaint is not 'too expensive', it is 'I could not evaluate the product'; 64 praise the price as fair; 19 defend the cap; the pricing level is not the problem, the trial design is", "insight",
  "The complaint is not 'too expensive' — it is 'I could not evaluate the product': three habits is not enough to test a habit tracker ('impossibile da capire se effettivamente é utile senza pagare'; 'how do you expect me to subscribe without trying anything??'); price objection alone is only 4.20%, 64 reviews (mean 4.31) praise the price as cheap or fair and 19 (mean 4.32) defend the cap on principle — the pricing level is not the problem, the trial design is; the cheapest high-value fix available",
  "3-habit cap prevents evaluation; price itself judged fair", "blocked-conversion", "price objection 55 (4.20%); price praised 64 (4.89%, mean 4.31); cap defended 19 (1.45%, mean 4.32)", "product-rule", "high-priority", "yes",
  ["13392619767","13557314925","13927978729"])
c(7, "Executive summary #3 — paid-reviewer satisfaction is collapsing: explicit payers E1 mean 4.23 → E2 3.16 → E3 2.68; 14% raise a billing dispute, 8.8% lost access to something bought, 8.8% reliability failure", "timeline",
  "Paid-reviewer satisfaction is collapsing — the business-critical trend: explicit payers E1 (2023-05→2024-12) n=13 mean 4.23 → E2 (2025) n=25 mean 3.16 → E3 (2026) n=19 mean 2.68; within the 57 explicit payers 8 (14.0%) raise a billing dispute (mean 1.12), 5 (8.8%) report losing access to something already bought (mean 1.40), 5 (8.8%) report reliability failure (mean 1.80)",
  "paid experience degrading", "churn", "4.23 → 3.16 → 2.68 (n=13/25/19); 14.0% billing; 8.8% lost access; 8.8% reliability", "must-never-break", "meaningful; small n", "yes",
  ["12379398566","12473304418","13178225257","13184003965","13528421192","13599650667","13605686247","14355199654","14132304435","14379122842","14486983673"])
c(8, "Executive summary #4 — an un-fixed launch/interaction blocker is the fastest-growing negative theme: freezes on or after onboarding, main screen stops responding to touch; 1.3% → 2.9% → 5.8%", "must-never-break",
  "An un-fixed launch/interaction blocker is the fastest-growing negative theme: the app freezes on or just after the onboarding screen and the main screen stops responding to touch — iPhone 11, iPhone 14 Pro Max, iPhone 16 Pro / iOS 26.5, iOS 26.1; one reviewer says the freeze survived two updates over a month",
  "freeze at onboarding / unresponsive touch", "1★-burst", "51 (3.90%, very strong), mean 1.63, 33 1★; 1.3% (E1) → 2.9% (E2) → 5.8% (E3)", "must-never-break", "very strong, rising", "yes",
  ["14156928722","14228794250","14269477606","13970830961","14102414142","14065834606","13448927787","14147118069","13637569981","14021915764","14112998455","14183996590","14262738292","14308159391","14312587468","14097129502","14336842171","14121146392","14049857126"])
c(9, "Executive summary #5 — the genuine moat is configurability plus Apple-platform depth; 37 arrive after abandoning a named competitor ('I have tried them all and this is the one')", "positioning",
  "The product's genuine moat is configurability plus Apple-platform depth, stated in unusually specific terms — simplicity/ease (mean 4.20), customisation/groups/colours (4.49), interface (4.42), Apple Health, widgets (4.43), Apple Watch (4.48), built-in timer (4.60); 37 reviews arrive after explicitly abandoning Streaks, Habitify, Habitica, HabitKit, Strides, Done, Me+, Ripples, Tiimo or Habit — 'I have tried them all and this is the one'",
  "deep customisation + Health/Watch/widgets/Mac", "purchase-driver", "simplicity 126 (9.63%, 4.20); customisation 65 (4.97%, 4.49); interface 62 (4.74%, 4.42); Health 32 (2.44%); widgets 30 (2.29%, 4.43); Watch 21 (1.60%, 4.48); timer 15 (1.15%, 4.60); switchers 37 (2.83%)", "do", "very strong", "yes",
  ["10653626434","11656905076","12427277456","12584418650","13191422909","13470655832","13516169817","14342011720","14394846065"])
c(10, "Executive summary #6 — billing disputes are a dated, growing cluster: 0.8% → 3.9% → 3.9%; a 7-day trial renews into the annual plan rather than the plan chosen; charged during the trial; no recollection of consent; subscription settings not findable in-app", "must-never-break",
  "Billing disputes are a dated, growing, reputationally expensive cluster (~5× step after 2024): a 7-day trial renews into the annual plan rather than the plan the user chose, a charge lands during the trial window, a charge arrives with no recollection of consent, and two reviewers could not find subscription settings in-app at all",
  "trial → annual auto-convert; no in-app subscription management", "1★-burst", "44 (3.36%, very strong), mean 1.59, 32 1★; 0.8% (E1) → 3.9% (E2) → 3.9% (E3)", "must-never-break", "very strong", "yes",
  ["13431450922","14075475519","13749925993","13588325969","13926135435","12470598228","12956024975","13424912655","14512117424","13608769744","13860427881","12250584386","12941350904"])
c(11, "Executive summary #7 — the paywall is also a UX interruption and breaks the app's ADHD promise: repeated full/half-screen upsell pop-ups blocking navigation ('en 20 secondes j'ai eu 10 popup'; 'hyper désagréable et malvenu pour des TDAH')", "dont",
  "The paywall is also a UX interruption that breaks the app's own audience promise: repeated full- or half-screen upsell pop-ups block ordinary navigation ('en 20 secondes j'ai eu 10 popup'; 'jedes Mal mit der Premium Version geworben… erst die App wieder schließen'; 'Eine Gewohnheitsapp die gleich mal mit dark pattern anfängt'), and one reviewer names it as 'hyper désagréable et malvenu pour des TDAH' in an app marketed to ADHD users",
  "frequent upsell interstitials", "complaint", "35 (2.67%, meaningful), mean 1.80", "dont", "meaningful", "yes",
  ["13469881270","12795905617","14130753059","13493408148"])
c(12, "Executive summary #8 — ADHD is the strongest positioning and strongest satisfaction signal (mean 4.44, 32 of 41 5★) — and supplies the sharpest paywall anger ('profit off of your disability')", "audience",
  "ADHD is the app's strongest positioning and its strongest satisfaction signal — 41 self-identify ADHD/autism/Asperger's/OCD at mean 4.44 (32 5★), a further 24 (mean 4.67) describe procrastination, forgetfulness, task paralysis or depression without a diagnosis, three arrive via a clinician including a psychologist who recommends it to clients — but the same segment supplies the sharpest paywall anger: 'It is just another app trying to profit off of your disability'",
  "ADHD positioning delivered on product, undercut by paywall", "mixed", "41 (3.13%, very strong), mean 4.44, 32 5★; 24 (1.83%, mean 4.67); 3 clinician referrals", "do", "very strong", "yes",
  ["12404912935","11680828081","13158925619","13742936226","11544311590","11831643030","11809645737"])
c(13, "Executive summary #9 — the biggest unshipped feature is a specific clock time per habit with a notification at that time, requested by satisfied users; clusters with one-off tasks, every-N-minutes reminders, calendar/agenda view", "feature",
  "The biggest unshipped feature is time-of-day scheduling — a specific clock time per habit with a notification at that time, not a generic reminder — requested by satisfied users; three requests cluster with it: one-off non-repeating tasks (10), recurring intra-day reminders every N minutes, and a calendar/agenda view (22 mention calendar)",
  "no per-habit clock time; no one-off tasks; no agenda view", "complaint", "29 (2.22%, meaningful), mean 3.41, 17 4–5★; one-off 10 (0.76%); calendar 22 (1.68%)", "must-have", "meaningful", "yes",
  ["10975371211","11185726438","11512786062","11830672328","12559128903","12647535093","12682799984","12889328356","13846488281","14092149470","14303953237","14437910533","13466380366","13082959947","12152603849","13711288403"])
c(14, "Executive summary #10 — cheapest unshipped wins in evidence order", "do",
  "Cheapest unshipped wins in evidence order: fix the launch freeze → make the free tier evaluable (time-boxed full access, or ~8–10 habits, and unlock read-only statistics) → make trial-to-paid-plan mapping explicit and put subscription management in-app → fix 'already paid, asked to pay again' → per-habit clock time with notification → stop blocking navigation with upsell pop-ups → ship Turkish, Russian, Korean, Chinese, Italian localisation",
  "none shipped as of Sep 2026", "complaint", "report gives none (ranked list)", "do", "summary ranking", "yes", [])
c(15, "§1.3 is_edited — several are visible rating revisions downward ('Moved to 3 stars because they're not listening'; 'I did love this app, but now looking for another')", "timeline",
  "Several of the 11 edited reviews are visible downward revisions from formerly loyal users", "loyal users revising down", "churn", "11 is_edited", "none", "limited evidence", "yes",
  ["11312965919","12152603849","12247101227","12394918811","12658607281","12839381685","13410996727","13660452698","13976982513","14045743771","14122841864"])
c(16, "§1.5 — 43 first-impression reviews (3.28%, mean 4.21, 31 5★) from people who say they have not used the product yet — marketing-response signal, not product signal", "data-caveat",
  "43 reviews (3.28%, mean 4.21, 31 of them 5★) are first-impression reviews from people who say they have not used the product yet ('Aún estoy por probarla'; 'Just downloaded') — marketing-response signal, not product signal", "review prompt fires pre-use", "5★-burst", "43 (3.28%), mean 4.21, 31 5★", "dont", "meaningful", "yes",
  ["13992368997","14461664452","14252109539","10930050142"])
c(17, "§1.5 — rating is not a feature preference: 43 of 138 cap complaints are 3★+, 27 4★+, 16 5★ — people who like the app and object to the gate", "insight",
  "43 of the 138 cap complaints are 3★ or better, 27 are 4★ or better and 16 are 5★ — people who like the app and object to the gate", "n/a", "complaint", "43 / 27 / 16 of 138", "product-rule", "corpus-level fact", "yes", [])
c(18, "§1.6 Ratings table (verbatim) — bimodal: 55.16% 5★, 23.07% 1★, 21.78% middle; two populations — people who got past the paywall and people who did not", "data-caveat",
  "The distribution is bimodal (55.16% 5★, 23.07% 1★, 21.78% in the middle three bands) — two populations reviewing two products: people who got past the paywall and people who did not", "n/a", "mixed", table("**Ratings (denominator 1,309):**"), "none", "corpus-level fact", "app-specific", [])
c(19, "§1.6 By year table (verbatim) — all-records mean 4.67 → 3.79 → 3.66 → 3.60 vs substantive 4.56 → 3.76 → 3.51 → 3.10", "timeline",
  "Per year: 2023 n=21 mean 4.67 (substantive 4.56); 2024 215 / 3.79 (3.76); 2025 487 / 3.66 (3.51); 2026 586 / 3.60 (3.10) — the substantive series falls three times faster than the headline", "n/a", "churn", table("**By year:**"), "none", "corpus-level fact", "app-specific", [])
c(20, "§1.6 By month 2026 table (verbatim) — month-level volatility; no single month supports a trend claim", "data-caveat",
  "2026 by month (n 135 / 79 / 51 / 44 / 82 / 58 / 64 / 60 / 13; means 3.69 → 3.72 → 3.53 → 3.84 → 3.26 → 3.59 → 3.56 → 3.73 → 3.38) shows the volatility a 1,309-record corpus has at month level — none of these months alone supports a trend claim", "n/a", "mixed", table("**By month, 2026**"), "none", "method", "app-specific", [])
c(21, "§1.6 Eras table (verbatim) — E1 2023-05→2024-12 n=236 mean 3.87 / substantive 3.83; E2 2025 n=487 3.66 / 3.51; E3 2026 n=586 3.60 / 3.10", "timeline",
  "Eras chosen from corpus volume: E1 (2023-05-22 → 2024-12-31, n=236, 18.03%, mean 3.87, substantive 3.83); E2 (2025, n=487, 37.20%, 3.66 / 3.51); E3 (2026 to 6 Sep, n=586, 44.77%, 3.60 / 3.10)", "n/a", "churn", table("**Eras used throughout**"), "none", "corpus-level fact", "app-specific", [])
c(22, "§1.6 Storefronts — 91; seven ≥50 (us 310, mx 203, br 100, fr 53, gb 53, de 51, ca 50) = 820 (62.64%)", "market",
  "91 storefronts; seven clear 50 reviews (us 310, mx 203, br 100, fr 53, gb 53, de 51, ca 50) = 820 (62.64%); the other 84 hold 489 (37.36%)", "n/a", "none", "7 storefronts = 820 (62.64%)", "none", "corpus-level fact", "app-specific", [])

# ---- §2.1
c(23, "§2.1 Feature inventory table (verbatim)", "data-caveat", "Feature inventory attested by review text with free/paid state", "n/a", "mixed", table("## 2.1 Feature inventory derived from reviews"), "none", "inventory", "app-specific", [])
c(24, "§2.1 Habit creation with custom name, icon, colour (incl. hex input) — free up to 3 habits, then paid", "feature",
  "Habit creation with custom name, icon and colour including hex input is free up to 3 habits, then paid", "3 free habits", "mixed", "138 cap complaints (10.54%)", "free", "inventory", "yes", ["11694650718","13467469049","12382945489"])
c(25, "§2.1 'Bad habit' / quit-habit mode — paid beyond the cap", "feature", "A 'bad habit' / quit-habit mode exists, paid beyond the cap", "quit mode counts against cap", "mixed", "inventory row", "research", "inventory", "yes",
  ["10381805436","11353433253","13605094837","12778092747"])
c(26, "§2.1 Track-only habits with no goal number; measurement units count / minutes / distance / custom; built-in timer that runs past the goal", "feature",
  "Track-only habits with no goal number, measurement units (count, minutes, distance, custom steps) and a built-in timer that runs past the goal — the timer is praised at mean 4.60", "flexible units + timer, included", "praise", "timer 15 (1.15%, mean 4.60)", "build-free", "inventory", "yes",
  ["10785911508","10305734583","10381805436","12584418650","12918071192","10346042202","12889328356","13528811393"])
c(27, "§2.1 Groups and sub-groups — paid (groups locked)", "feature", "Groups and sub-groups exist and are paid — a reviewer reports group creation locked", "grouping paid", "mixed", "customisation/groups praised 65 (4.97%, mean 4.49); 1 locked report", "undecided", "inventory", "yes",
  ["12184038268","13207258224","12652539241","13585132870"])
c(28, "§2.1 / §2.3 Statistics (success %, graphs, per-habit calendar, performance charts) — paywalled in all eras; calendar view 'Pay to even look at calendar'", "feature",
  "Statistics of any kind — success %, graphs, per-habit calendar, performance charts — are paywalled in every era, and by 2026 the calendar view too ('Pay to even look at calendar')", "stats and calendar paid", "complaint", "5 dated reviews 2024-05 → 2026-06", "free", "inventory", "yes",
  ["10305734583","12404912935","13601387355","11282934508","13318920074","13603068257","13636020247","14225842901"])
c(29, "§2.1 Streaks with fire symbol; gamified achievements, confetti, completion sound (one wants it off)", "feature",
  "Streaks with a fire symbol, gamified achievements, confetti and a completion sound — one reviewer wants the celebration off", "streaks + celebrations", "mixed", "inventory rows", "undecided", "inventory", "yes",
  ["14129450366","13261289225","13543602021","12352612203","13879673780","13301076677"])
c(30, "§2.1 Apple Health two-way integration; Apple Watch app + complications; Home/Lock Screen/Control Center widgets; Mac app (formerly Vision Pro); iCloud sync; Siri Shortcuts; calendar integration", "feature",
  "Apple-platform depth: two-way Apple Health, a Watch app with complications, Home-screen / Lock Screen / Control Center widgets, a Mac app (and formerly Vision Pro), iCloud sync across iPhone/iPad/Watch/Mac, Siri Shortcuts and calendar integration — all included", "full Apple platform surface", "praise", "Health 32 (2.44%); Watch 21 (1.60%, 4.48); widgets 30 (2.29%, 4.43)", "build-paid", "inventory", "yes",
  ["10081083127","11399786219","12201042880","13543602021","10054970793","11965539196","12659238964","12584418650","12320067097","13197146903","13905166366","10899816769","11656905076","12539663591","13531929434","11057930335","12199187753","11248554918","13278531866","13472318627","12585991664","10569395314","13927028841","13937721688"])
c(31, "§2.1 'Vacation' / pause habits; 'Jump' and 'Cancel' / skip a day, mark not-done; archive habits", "feature",
  "Vacation/pause, skip-a-day ('Jump'), mark-not-done ('Cancel') and archive exist", "pause/skip/archive included", "praise", "inventory rows", "build-free", "inventory", "yes",
  ["13811962013","12176241214","13543602021","10468572229","12191332041","10971903648","12201042880"])
c(32, "§2.1 Data export (CSV) — described as weak", "feature", "CSV export exists but is described as weak", "weak export", "complaint", "inventory row", "free", "inventory", "yes", ["12849182179","12355886317","12264249799"])
c(33, "§2.1 Onboarding questionnaire → suggested habits (free); day-start time setting for shift workers, capped at 11:45", "feature",
  "An onboarding questionnaire suggests starter habits (free); a day-start time setting exists for shift workers but is capped at 11:45", "questionnaire onboarding; day boundary capped", "mixed", "inventory rows", "undecided", "inventory", "yes",
  ["13162172214","13627235273","14341726601","14509705008","12659238964","11007220268","12014982215"])
c(34, "§2.1 / §2.3 Habit editing — reported as paid from Nov 2025, including the starter habits onboarding creates: 'You need to get the premium to edit habits (even the ones they start you out with)'", "product-rule",
  "From November 2025 editing an existing habit — including the starter habits the onboarding creates — is reported as paid ('Tengo 3 hábitos, y ya ni siquiera me deja editarlos'; 'You need to get the premium to edit habits (even the ones they start you out with)'); five 1–2★ reviews, zero before Nov 2025 — weak by rate, high by consequence: the free tier stops being a reduced product and becomes a demo; flagged as a verification question, not a confirmed regression",
  "editing gated behind premium (2025-11+)", "1★-burst", "5 (0.38%, weak), all 1–2★, all after Nov 2025", "product-rule", "weak-by-rate, high-by-consequence", "yes",
  ["13428241426","13585132870","14339204663","14277782327","14067453636"])
c(35, "§2.1 Not present — Android/Windows, accounts independent of iCloud, social/accountability, per-habit clock time, one-off tasks, landscape, Turkish/Russian/Korean/Chinese/Italian UI", "feature",
  "Not present per reviewers: Android and Windows versions, accounts/login independent of iCloud, social/accountability features, per-habit clock time, one-off tasks, landscape mode, and Turkish/Russian/Korean/Chinese/Italian UI", "absent", "complaint", "inventory note", "research", "inventory", "yes",
  ["12936939329","13801191230","12208303239","13595608629","11680828081","13085696025","14000988461"])

# ---- §2.2
c(36, "§2.2 Monetisation — three plans named consistently: monthly ($1.08–$13, €1.25–€10), annual (€35, A$19.99, ₹1,299, R$199.90, 299.99 MXN, $33, $42 vs $24.99 expected), lifetime (£25 → £29.99, $24.99–25 rising to $49 / 50€ / MXN 500 by mid-2025)", "monetization",
  "Three plans: monthly ($1.08, 40 MXN, R$5, €2.99, €1.25, $10, $13, €9.90, €10), annual (€35, A$19.99, ₹1,299, R$199.90, 299.99 MXN, $33, $42 charged against a $24.99 expectation), lifetime (£25 → £29.99, $24.99–25 rising to $49 / 50€ / $29.99 / MXN 500 from mid-2025, ~23–30€ promotional)",
  "monthly / annual / lifetime", "mixed", "30+ figures in 12 currencies", "build-paid", "corpus-level fact", "app-specific",
  ["12230465395","11856825871","11975068830","12830065250","13612032880","13405360163","11100933308","13493408148","13391520278","11185726438","14132304435","14244904942","13605094837","13927028841","12956024975","14164700184","13424912655","12386056078","11422195516","12407220130","13418259698","11007220268","11461120524","12045596500","11122925794","12904556624","13660452698","13299143006","14379122842","13582066669","12478039620","12348445268","14167301638"])
c(37, "§2.2 The one-time option is a named purchase driver ('you dont have to do subscription stuff thank you'); one reviewer could not find it", "monetization",
  "The lifetime/one-time option is a named purchase driver — 'good option that u can just buy the app you dont have to do subscription stuff thank you' — and one Brazilian reviewer could not find it and thought only a monthly plan existed", "lifetime offered alongside subscription", "purchase-driver", "44 (3.36%) mention lifetime, mean 3.95", "build-paid", "very strong", "yes",
  ["11248554918","12178717768","13547124162","12199187753","12486962813"])
c(38, "§2.2 Direction of travel — lifetime price roughly doubles ($24.99 → $49) between early 2024 and mid-2025 while price objection does not rise (3.8% → 4.9% → 3.8%)", "monetization",
  "The lifetime price roughly doubles between early 2024 ($24.99/£25) and mid-2025 onward ($49/50€) while monthly/annual spread rather than rise; price objection does not rise with it (3.8% E1 → 4.9% E2 → 3.8% E3) — the objection is to the gate, not the number", "lifetime price doubled", "mixed", "$24.99 → $49; objection 3.8% → 4.9% → 3.8%", "build-paid", "interpretation", "yes", [])

# ---- §2.3
c(39, "§2.3 Gates table (verbatim) — >3 habits all eras; statistics all eras; calendar E3; editing from Nov 2025; group creation E3", "data-caveat",
  "What is gated and when: more than ~3 habits (138, all eras); statistics of any kind (all eras); calendar view (E3); editing an existing habit including starter habits (Nov 2025 onward); group creation (E3)", "n/a", "complaint", table("## 2.3 What is gated, and the gating that changed"), "product-rule", "corpus-level fact", "app-specific", [])

# ---- §2.4
c(40, "§2.4 Signals about the developer — responsive single-maker: requests implemented 'in less than 24hrs', update within a day of an e-mail, bug fixed 'within half a day', 'I can't believe one developer made this'; praise-support rate 3.0% → 1.6% → 0.9%", "do",
  "A responsive single-maker operation is unusually strong evidence in E1–E2 — feature requests implemented 'in less than 24hrs', an update within a day of an e-mail, a bug fixed 'within half a day', a suggestion shipped 'after merely a week', a subscription problem resolved 'sem burocracia', 'I can't believe one developer made this' (developer's first name Stephan appears) — but the praise-support rate thins 3.0% → 1.6% → 0.9% across eras, coinciding with the launch-blocker rise and the paid-satisfaction collapse",
  "solo developer, fast turnaround early, thinning", "praise", "20 (1.53%, mean 4.10); 3.0% → 1.6% → 0.9%", "do", "meaningful", "yes",
  ["10305734583","10590265798","12490332504","11793376300","12863353889","12171554899","12168338279","12404912935","13806651974","11061261761","12585991664","12152603849"])
c(41, "§2.4 Against — 4 of 20 are 1★; 'the developer preferred to argue about what I could see on my end' (cancelled trial); 'Service client qui ne fait rien' after €50", "dont",
  "Against: 4 of the 20 developer/support reviews are 1★, including a serious service failure — when contacted about habits not saving, 'the developer preferred to argue about what I could see on my end', and the reviewer cancelled their trial; 'Service client qui ne fait rien' after a €50 purchase", "argumentative support reply", "churn", "4 of 20 1★", "dont", "limited evidence", "yes", ["14422160795","13299143006"])

with open("Tools/prd_ledger/25/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
