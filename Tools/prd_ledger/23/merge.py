"""Stage 3 merge for report 23."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C222","product-rule","A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes","Report 23: a paid one-time tracker capped at 6 → 12 → 24 tasks drew the largest request in twelve years (620, 8.53%) in every market and every year; each raise cut the complaint rate roughly in half (8.76% → 5.06%; 11.90% → 6.16%) and bought about three years before it rebounded, and it never fell below ~6%. Against it 118 (1.62%) defend the cap as the reason the app works, and nobody in the 620 asks for the default to change — they ask for the ceiling to move. The cap is a durable position and a permanent 6–12% complaint tax; ship extra capacity off by default behind a setting that states the rationale.")
add("C223","must-have","Undo / un-complete is a visible button — never a gesture-only path","Report 23: the only undo for an accidental completion was a shake gesture available immediately after the action; 77 reviews (1.06%, mean 3.38) across 12 storefronts called it unacceptable, several found the only workaround was resetting all history, and some deleted the app over it. Keep the gesture, add a button and a long-press-to-uncomplete path.")
add("C224","do","Disclose product limits in the listing — an undisclosed cap or scope becomes a refund request","Report 23: reviewers said the task cap was not disclosed in the App Store description and asked for refunds on that basis; the 68 'no value / it's just a checklist' 1★ reviews (0.94%) and most of the 123 price objections are expectation failures the listing could pre-empt.")
add("C225","do","A one-off free promotion (App of the Week, partner promo) acquires durable users","Report 23: a Starbucks 'Pick of the Week' promo in 2015–16 drew 13 reviews at mean 4.62, and one of those users was still active in July 2025 — ten-year retention from a free promo on a paid-up-front app.")
add("C226","undecided","App-icon badge count of outstanding habits, with an active-hours window","Report 23: a badge count of tasks still open today, limited to an active-hours window, is named by many reviewers as the core motivator of a paid one-time tracker.")
add("C227","research","A 'graduated' state — keep tracking a mastered habit without it occupying an active slot","Report 23: the single most persuasive argument for more capacity, made repeatedly, is that people want to keep tracking a habit that has become automatic while starting a new one; a mastered/graduated state that keeps history but frees the slot answers it without raising the cap.")
add("C228","must-never-break","Text fields must handle IME composition — Hangul and CJK input","Report 23: the task-title field mangled Hangul (typing 약 stored 야ㄱ), reported four separate times over five years and never fixed, producing 1★–4★ reviews from otherwise-satisfied Korean users in the storefront with the worst refund rate.")
add("C229","undecided","A deliberate completion gesture — press-and-hold with haptic and sound, not a bare tap","Report 23: press-and-hold completion is described as physically satisfying and as accident-proofing, attested inside the two largest positive themes; some criticise it. Copying 'tap to complete' loses something real; pair any tap model with a visible undo.")
add("C230","must-never-break","Sync merges an append-only, timestamped event log — never last-writer-wins state replacement","Report 23: after a 2022 migration to direct iCloud sync, complaint-framed sync went from 1.42% of 2015–17 reviews to 7.60% of post-2022 reviews (mean 2.90) and data loss from 0.33% to 4.62% of the era; failure modes were a device overwriting newer state with older state, deleted tasks resurrecting, Watch completions never reaching the phone, and completions un-completing seconds later. A customer review spells out the correct architecture: immutable timestamped events applied in order.")

ext("C006", " Report 23: simplicity is the moat — 1,780 reviews (24.48%, mean 4.58) praise it, and it measurably degrades as features are added: simplicity praise fell 32.30% → 20.80% → 18.36% of each era while UI-confusion complaints rose 0.69% → 4.93% → 5.33%; reviewers date the loss to the July 2017 expansion ('like they dipped a pickle in chocolate'). Every addition to a minimal product must be opt-in or off by default.")
ext("C003", " Report 23: a paid-up-front one-time tracker where 'no subscription' praise (398, 5.47%, mean 4.43) rose 3.61% → 5.55% → 8.00% across eras as the category subscription-ised — the one competitive position that strengthened; 'worth it' outnumbered 'not worth it' 3.2:1, and an entire cohort arrived after a competitor revoked already-purchased premium features.")
ext("C004", " Report 23: the one-time price rose ~2.5× nominal over eleven years ($3.99 → $9.99) and the objection rate stayed flat (1.75% → 2.41% → 2.21%); objections are feature-per-dollar and paired with the cap or 'Reminders does this free', never the number itself.")
ext("C064", " Report 23: price objection 123 (1.69%, mean 2.21, 50.4% 1★) with au 5.7%, de 3.8%, ca 3.6% vs us 1.3%; flat across a 2.5× price rise; China's 1★ reviews are almost uniformly '¥25/30 for a reminder'; Germany objected to €3.99 at launch ('99Ct wären OK').")
ext("C214", " Report 23: 68 one-star reviews (0.94%) make the coherent case 'this is a checklist, iOS Reminders does it free, and it cost me money' — a positioning failure: the listing sold a to-do list rather than streak psychology plus HealthKit automation; Apple Reminders is the low-end competitor (9 mentions, mean 3.67).")
ext("C134", " Report 23: lead with the streak mechanism and HealthKit automation, not 'to-do list' — the 'just a checklist' 1★ block is an expectation failure; award/editorial traffic (17 reviews naming the Apple Design Award, mean 2.53, the worst channel) arrives expecting 'best app'.")
ext("C007", " Report 23 (a paid app, cap as design not paywall): raising the cap 6 → 12 → 24 cut complaints roughly in half each time and bought about three years; the request re-anchors on the new number and never falls below ~6%.")
ext("C022", " Report 23: the Watch is the app's strongest differentiator and most fragile surface — 626 mentions (8.61%), 241 negative (mean 3.13) vs 385 positive (mean 4.35); it breaks on each watchOS generation (2016, watchOS 7, 2021–22 mirroring, watchOS 10 complications, 2024–26 blank complications); in Korea (13.5%) and Japan (13.3%) it is the dominant topic; 'I bought this for the Watch and it doesn't work' are the highest-value churn events.")
ext("C078", " Report 23: the Apple Watch is a purchase driver, not a feature — ≥15 reviews name it as the reason to buy and the explicit-bug subset runs at mean 2.57; if you ship a Watch app its reliability budget is your main reliability budget.")
ext("C021", " Report 23: HealthKit auto-completion (277, 3.81%, mean 4.35) is 'the single highest-leverage integration in the category' — it removes the friction that killed every other habit app the reviewer tried; a weak tail of misfires (auto-completing without action 11; Health data miscounting 9).")
ext("C048", " Report 23: 77 reviews (1.06%) in seven languages ask to record effort beyond the goal or short of it — over-achievement is discarded ('goal 30 minutes, read 90, it stops at 30') and partial progress renders as failure ('6 of 8 glasses shows an ✗'); the two most-upvoted reviews in the 7,270-review corpus (313 and 126 votes) are this request; 'do 30 push-ups' breaks on a 25 day where 'push-ups per day' would record 25 and preserve momentum. Ship floor-without-ceiling goals and a partial-progress calendar state without changing the streak rule.")
ext("C201", " Report 23: a 6-of-8 day rendered as ✗ is named as demotivating and the reason people keep a second app; render a partial ring, not a failure mark.")
ext("C043", " Report 23: times-per-week, per-day, per-month and every-N-days shipped incrementally; still absent after eleven years — yearly goals, arbitrary intervals (every 6 weeks, quarterly, a shift worker's 4–5-day rotation) and specific dates of the month (101 requests, 1.39%); a non-daily habit also consumes a daily slot under the cap.")
ext("C012", " Report 23: statistics limited to the current and previous month (46 requests); the most-requested visualisation is a year heat-map / GitHub contribution grid, the single most-named competitor gap (Habitify).")
ext("C040", " Report 23: widgets rendering blank or losing configuration (57 explicit widget-bug reviews, mean 3.16; 20 blank/config reports) alongside the interactive-widget regression.")
ext("C023", " Report 23: an interactive Today-view widget shipped Jan 2017 to enthusiasm, was lost at iOS 14 (Sept 2020) and asked for back continuously for five years (36 named requests) — one of the top three reasons for a downgrade from a previously-happy user; restore it via App Intents.")
ext("C155", " Report 23: the interactive widget lost at iOS 14 was partly an Apple platform change, but the five-year gap before restoration cost a top-three downgrade reason; a capability users bought for must be restored, not left behind.")
ext("C030", " Report 23: sync is the single largest reliability finding — 348 mentions (4.79%), 223 complaint-framed (3.07%, mean 3.08, 23.3% 1★), only 22 positive; the 2022 migration produced a spike (25 → 60 → 40 → 24 by year) with visible recoveries within weeks and a tail still visible in 2026 — a migration with a long, damaging tail; Germany 10.0%, Spain 10.1%, Sweden 9.7%.")
ext("C034", " Report 23: data loss 81 (1.11%, mean 2.17, 45.7% 1★), 60 of them after the 2022 sync rewrite (3.38% of post-2022 reviews, mean 2.03; 2024 peak 22) — the only theme that destroys a long-tenure customer outright ('my 3+ years record to null'; 'It's like I'm a brand new user'); an in-app backup existed and was discovered by support, not the user.")
ext("C153", " Report 23: Settings > Manage Data > Backups existed but was repeatedly discovered via support e-mail; several reviewers upgraded their rating on learning it existed — surface backups in the first-run tutorial, not a support reply.")
ext("C142", " Report 23: a hidden backup/restore path, and edit/delete/undo actions hidden behind gestures — 250 UI-confusion reviews (3.44%, mean 2.66, 31.6% 1★) resolve into three actions: deleting a task, editing a task, undoing a completion; a single visible Edit / Delete / Undo affordance plus in-app text would address most of them.")
ext("C075", " Report 23: an icon-only first run left new users unable to delete, edit or undo — 63 of 650 1★ reviews; a 66-upvote review asks for plain-language in-app instructions; replace it with a short text-labelled walkthrough covering add / complete / edit / delete / undo / pages.")
ext("C039", " Report 23: 97 (1.33%, mean 3.48, 18.6% 1★) — reminders that don't fire (Thailand 4 of 22, 18.2%, limited evidence), fire for already-completed tasks, fire all at once at night, ignore Do Not Disturb, or interrupt a meditation to say meditate; the 'smart' auto-timing algorithm is widely disliked.")
ext("C095", " Report 23: a reminder framed as loss — 'You will lose your streak of X days if you don't do this today' — drew requests in four languages to reframe positively ('pedagogy from the early 20th century'); one string change per locale.")
ext("C157", " Report 23: loss-framed reminder copy is a guilt mechanic users in four languages ask to switch off or reframe.")
ext("C031", " Report 23: crashes 46 (0.63%, mean 2.80, 34.8% 1★) on three dated bugs — iPhone X freeze-on-close 2017–18, an iOS 14-era freeze, a stuck splash screen 2023–26 — plus Watch-app crashes on each watchOS generation.")
ext("C016", " Report 23: pausing a task and un-pausing it marked the paused days as missed and destroyed the streak — the defect defeats the feature's entire purpose; reported 2023–24 with no visible fix (57 archive/pause mentions).")
ext("C038", " Report 23: un-pausing a task marks paused days as missed and resets the streak; a completion 'un-completes' seconds later under sync conflict.")
ext("C027", " Report 23: bad German localisation ('Die Übersetzung ins Deutsche ist total fehlgeschlagen') undercut the premium price in the corpus's worst large market (mean 3.62); machine-translated Chinese help text drew 52 upvotes and was still cited seven years later; localisation-quality complaints span de, ru, se, kr, cn, tw, jp and es (mixed EN/ES notifications, English-only icon search); a Hangul IME bug went unfixed five years.")
ext("C042", " Report 23: self-identified ADHD/autism/executive-dysfunction users are a growing, high-satisfaction segment (73, 1.00%, mean 4.45; 0.66% → 0.70% → 1.90% across eras) the app never marketed to; 28 arrived on a therapist/coach/doctor recommendation (mean 4.50); several of them are the strongest capacity complaints because task decomposition is what executive-function support requires, and one calls the help-page wording ableist.")
ext("C058", " Report 23: therapists and psychologists recommending it to ADHD clients (28, mean 4.50), Atomic Habits and habit literature (14, mean 4.79), podcasts and blogs (Daring Fireball, MacBreak Weekly, Do By Friday, Diary of a CEO; 12, mean ~4.6); Apple editorial / Design Award traffic was the worst channel (17, mean 2.53).")
ext("C070", " Report 23: 14 reviews name Atomic Habits (mean 4.79); also Mini Habits, The Power of Habit, Deep Work and The Power of Full Engagement.")
ext("C062", " Report 23 (counter-evidence): in a paid-up-front app the high-spend and high-volume storefront groups are statistically indistinguishable (4.22 vs 4.22) and only marginally better than the rest of the world (4.12) — what varies by country is which complaint dominates, not how much.")
ext("C005", " Report 23: Momentum 14 (4.64, 'switched from'), Strides 13 (both directions — some leave over the cap), Productive 6 ('Streaks is simpler / not a subscription'), Habitify 5 (year calendar view), Habitica 3 (reward economy), Apple Reminders 9 (mean 3.67, 'does this free'); the frame is Reminders below and subscription rivals above.")
ext("C036", " Report 23: support praised (49, 0.67%) with fixes bringing edited upgrades, but genuine silences recur and one reviewer says support implied they don't own an Apple Watch for testing.")
ext("C059", " Report 23: 12 edited reviews, several visible upgrades after a developer fix; sync-migration recoveries within weeks; reviewers upgraded on learning a backup path existed.")
ext("C063", " Report 23: a paid-up-front app with no trial — 15 (0.21%, mean 2.40) name the absence, it recurs as a stated regret in refund reviews, and accidental one-tap purchases drive Korea's 6.5% refund rate (7× global); counter-evidence: 'There's no trial because it doesn't need one'.")
ext("C113", " Report 23: a weak cluster (7, 0.10%) says the price shown and the amount debited differed (au, ru, tr, mx) — most likely tax or currency conversion, but a recurring, avoidable trust event.")
ext("C029", " Report 23: nothing supports deceptive billing on a single Apple payment; refund friction (79, mean 1.75, 70.9% 1★) is Apple's process, and reviewers address Apple through the review field.")
ext("C044", " Report 23: the Mac app was a separate purchase in 2020–21, then included in the universal purchase from late 2021 (≥8 reviews, a classifier miss at 1); one unverified report of the Mac app creating millions of files and locking the user out.")
ext("C060", " Report 23: Streaks is sold in a bundle with Streaks Workout and HealthFace.")
ext("C037", " Report 23: Family Sharing is supported on the one-time purchase; a few want to track a child's chores alongside their own inside one account.")
ext("C020", " Report 23: CSV export is included in the one-time price.")
ext("C009", " Report 23: custom app icons and theme colours (324, 4.46%, mean 4.51) are 'a small feature with an outsized delight response'; 54 more ask for more/custom icons.")
ext("C018", " Report 23: the alternate app icon is frequently cited as a delight (included in the one-time price).")
ext("C019", " Report 23: negative ('don't') tasks shipped in v3.0, Jul 2017.")
ext("C046", " Report 23: Siri Shortcuts, URL actions and NFC triggers are a power-user favourite (72, 0.99%, mean 3.94).")
ext("C024", " Report 23: streak psychology is the highest-satisfaction theme (902, 12.41%, mean 4.75, 0.7% 1★ — reviewers get out of bed to preserve a streak); rewards/badges/levels are requested by fans (136, 1.87%, mean 4.43).")
ext("C101", " Report 23: the gold-theme completion state — the whole screen turns gold when every task is done — is named by 80 5★ reviews; rewards, badges and milestones requested 136 times by happy users.")
ext("C172", " Report 23: per-completion notes were requested from 2015 (43, 0.59%) and shipped ~Mar 2023; the residual ask is navigation between notes.")
ext("C015", " Report 23: task sharing / accountability partner exists but is described as weak and one-way; social layer requested by 28 (0.39%).")
ext("C045", " Report 23: extra capacity is wanted for time-of-day pages (morning / work / evening / bedtime) and life-domain segmentation (health / work / relationships / creative).")
ext("C053", " Report 23: one page per time of day — morning, work, evening, bedtime — is the top reason people ask for more capacity.")
ext("C068", " Report 23: tracking a child's chores alongside your own is one reason for more capacity (3 reviews).")
ext("C174", " Report 23: family/multi-person use inside one account is a stated reason for more task slots.")
ext("C170", " Report 23: day-boundary / midnight reset requested (54, 0.74%, emerging, mean 4.02).")
ext("C119", " Report 23: a list view or density control (45, 0.62%) must be opt-in — 8.9% of that theme's reviews are 1★ precisely because the app changed on them; the v3.0 feature expansion split reviewers the same week.")
ext("C094", " Report 23: review-prompt nagging 25 (0.34%, mean 2.72, 40% 1★).")
ext("C171", " Report 23: accessibility / VoiceOver 19 (0.26%, mean 3.79).")
ext("C141", " Report 23: iPad layout not optimised 8 (0.11%).")
ext("C056", " Report 23: exactly one review mentions the 'Break It Down' AI feature (May 2026) — and asks for it to be removed.")
ext("C143", " Report 23: multiple-per-day / partial increments (111, 1.53%) largely shipped in 2016; residual complaints are about partial-progress display.")
ext("C010", " Report 23: 'today or yesterday?' retroactive completion and calendar backfill are included; backfill older days still requested 76 times (1.05%).")
ext("C066", " Report 23: timed tasks and a built-in Pomodoro exist; the Pomodoro break cycle was reported broken in 2022 and timers desync between devices.")
ext("C065", " Report 23 (everyone paid): reviewers who discuss the transaction average 3.52 vs 4.27 for the rest — a dissonance signal; 'I bought this for the Watch and it doesn't work' are the highest-value churn events.")
ext("C002", " Report 23 (a one-time paid app with no offer change in eleven years): the rating decline 4.56 → 4.08 → 3.83 tracks reliability — sync 7.1×, data loss 14×, widget bugs 52× — while price objection stayed flat; when the offer is stable, ratings follow reliability.")
ext("C092", " Report 23: price objection concentrates in au (5.7%), de (3.8%), ca (3.6%) against us 1.3%; China's number is ¥25–30.")
ext("C186", " Report 23 (receiving side): an entire cohort arrived at a one-time-purchase competitor after another app revoked already-purchased premium features.")
ext("C099", " Report 23: an end-date / countdown / long-term goal is requested by very happy users (17, 0.23%, mean 4.76, 0% 1★).")
ext("C093", " Report 23: 4 reviews object to ads for the developer's other apps inside a paid app.")

M = {
 "R23-003":["C222","C007"], "R23-004":["C222"], "R23-005":["C006","C222"], "R23-006":["C002","C030","C034"], "R23-007":["C022","C078"],
 "R23-008":["C142","C223","C075"], "R23-009":["C003","C004"], "R23-010":["C048","C201"], "R23-011":["C023","C155"], "R23-012":["C042","C058"],
 "R23-013":["C230","C222","C223","C048","C023","C075","C012"], "R23-014":["C059"], "R23-016":["C002"], "R23-018":["C048"], "R23-019":["C012"],
 "R23-020":["C048","C043"], "R23-021":["C075","C027"],
 "R23-023":["C222","C045"], "R23-024":["C229"], "R23-025":["C010"], "R23-026":["C039"], "R23-027":["C226"], "R23-028":["C021"], "R23-029":["C022"],
 "R23-030":["C023","C155"], "R23-031":["C019"], "R23-032":["C043"], "R23-033":["C066","C065"], "R23-034":["C012"], "R23-035":["C020"], "R23-036":["C030","C044"],
 "R23-037":["C046"], "R23-038":["C009","C018"], "R23-039":["C016"], "R23-040":["C172"], "R23-041":["C015"], "R23-042":["C037"], "R23-043":["C044"],
 "R23-044":["C056"], "R23-045":["C042"], "R23-047":["C003"], "R23-048":["C225"], "R23-049":["C060"], "R23-050":["C004","C064"], "R23-051":["C029"],
 "R23-052":["C063"], "R23-053":["C003","C186"],
 "R23-055":["C006"], "R23-056":["C134"], "R23-057":["C024"], "R23-059":["C022"], "R23-060":["C222","C007"], "R23-061":["C003"], "R23-062":["C030"],
 "R23-063":["C009"], "R23-064":["C040","C023"], "R23-065":["C021"], "R23-066":["C142","C223"], "R23-067":["C030"], "R23-068":["C024","C101"], "R23-069":["C064"],
 "R23-070":["C222"], "R23-071":["C143"], "R23-072":["C043"], "R23-073":["C039"], "R23-074":["C034"], "R23-075":["C029"], "R23-076":["C223"], "R23-077":["C048"],
 "R23-078":["C010"], "R23-079":["C042"], "R23-080":["C046"], "R23-082":["C040"], "R23-083":["C016"], "R23-084":["C170"], "R23-085":["C009"], "R23-086":["C036"],
 "R23-087":["C022"], "R23-088":["C012"], "R23-089":["C031"], "R23-090":["C119"], "R23-091":["C172"], "R23-093":["C094"], "R23-094":["C063"], "R23-095":["C171","C141"],
 "R23-096":["C021"], "R23-097":["C093"], "R23-098":["C065"], "R23-099":["C065","C034"],
 "R23-100":["C006"], "R23-101":["C024"], "R23-102":["C022"], "R23-103":["C101"], "R23-104":["C036","C059"], "R23-106":["C024","C101"], "R23-107":["C143"],
 "R23-108":["C043"], "R23-109":["C172"], "R23-110":["C119"], "R23-111":["C012"], "R23-112":["C015"], "R23-113":["C099"], "R23-115":["C005"], "R23-116":["C214","C005"],
 "R23-117":["C222","C007"], "R23-118":["C053","C045"], "R23-119":["C045"], "R23-120":["C227"], "R23-121":["C043","C222"], "R23-122":["C068","C174"],
 "R23-123":["C222"], "R23-124":["C222"], "R23-125":["C006","C119"], "R23-126":["C006","C119"], "R23-127":["C142","C223"], "R23-128":["C223","C090"],
 "R23-129":["C142"], "R23-130":["C048"], "R23-131":["C048","C201"], "R23-132":["C048"], "R23-133":["C043"], "R23-134":["C012"],
 "R23-136":["C059"], "R23-137":["C222"], "R23-141":["C214","C134","C224"],
 "R23-143":["C030","C230"], "R23-144":["C230","C030"], "R23-145":["C230"], "R23-146":["C030","C175"], "R23-147":["C034"], "R23-148":["C153","C142"],
 "R23-149":["C022","C031"], "R23-150":["C078","C022","C065"], "R23-151":["C036"], "R23-152":["C023","C155"], "R23-153":["C040"], "R23-154":["C039"],
 "R23-155":["C039"], "R23-156":["C095","C157"], "R23-157":["C031"], "R23-158":["C016","C038"], "R23-159":["C065"], "R23-160":["C003","C058"], "R23-161":["C042","C058"],
 "R23-162":["C070","C058"], "R23-163":["C134","C058"], "R23-164":["C058"], "R23-166":["C003"], "R23-167":["C064","C092"], "R23-168":["C064","C224"],
 "R23-169":["C063"], "R23-170":["C224","C063"], "R23-171":["C113"], "R23-172":["C029"],
 "R23-175":["C027","C064","C030"], "R23-176":["C063","C022"], "R23-177":["C228","C027"], "R23-178":["C222"], "R23-179":["C064"], "R23-180":["C048","C172","C043"],
 "R23-181":["C027"], "R23-182":["C022"], "R23-185":["C062"], "R23-186":["C062"], "R23-187":["C027"], "R23-188":["C039"], "R23-190":["C044"],
 "R23-192":["C002","C030","C034","C040"], "R23-194":["C030","C034"], "R23-195":["C222","C007"], "R23-196":["C006"], "R23-197":["C003"], "R23-198":["C042"],
 "R23-201":["C222"], "R23-202":["C229"], "R23-203":["C021"], "R23-204":["C048"], "R23-205":["C078","C022"], "R23-206":["C003"], "R23-207":["C095"], "R23-208":["C230"],
 "R23-209":["C223"], "R23-210":["C027"],
 "R23-211":["C230","C030"], "R23-212":["C153","C142"], "R23-213":["C022"], "R23-214":["C016"], "R23-215":["C228"], "R23-216":["C223"], "R23-217":["C142"], "R23-218":["C075"],
 "R23-219":["C222"], "R23-220":["C048","C201"], "R23-221":["C095"], "R23-222":["C023"], "R23-223":["C012"], "R23-224":["C043"], "R23-225":["C119"],
 "R23-226":["C224"], "R23-227":["C134","C214"], "R23-228":["C063"], "R23-229":["C027"], "R23-230":["C042"],
 "R23-236":["C062"], "R23-237":["C004","C064"], "R23-238":["C134","C058"], "R23-239":["C006"],
}
# unattached (nuance register): 001-002 header/method, 015 ratings table, 017 storefronts, 022 inventory table, 046 monetisation table,
# 054 theme table, 058 'it works', 081 updates, 092 weak rows, 105 unmet-needs table, 114 taxonomy note, 135/138-140/142 rating-band tables,
# 165 buyer-value table, 173-174 eligibility/country table, 183-184 group definitions, 189 Danish essay, 191 era table, 193 confounder,
# 199 corpus drying up, 200 non-claims, 231-235 experiments and research questions
cards = [json.loads(l) for l in open("Tools/prd_ledger/23/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/23/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
