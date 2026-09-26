import json, re
R = 10
rep = open("App Store Reports/10. Finch - Self-Care Pet - Daily Journal & Habit Tracker (REPORT).md").read().split("\n")
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

# ---- 4.2 ----
c(45, "§4.2 Monetization — the billing-dispute cluster table (verbatim)", "data-caveat",
  "Billing-dispute cluster: six themes with n, %, signal, mean, 1★ and paid-evidence counts",
  "n/a", "1★-burst", table("## 4.2 Monetization"), "none", "verbatim", "app-specific", [])
c(46, "§4.2 Four of these six sit below the 0.1% line on volume alone — They are reported anyway under the financial-integrity carve-out; Segment rates", "data-caveat",
  "Four of the six billing themes sit below the 0.1% 'ignore by default' line on volume alone and are reported anyway under the standard's financial-integrity carve-out; as segment rates the family is 13.86% of all 1★ and 17.45% of all paid-evidence reviews",
  "n/a", "1★-burst", "family 404 (0.577%, EMERGING) mean 1.97; 244/1,761 one-star (13.86%); 241/1,381 paid (17.45%)", "must-never-break", "method", "yes", [])
c(47, "§4.2 The specific mechanism, stated the same way for five years", "must-never-break",
  "The trial-reminder failure mechanism is stated the same way for five years: the app tells the user it will notify them before the trial converts; the notification does not arrive; an annual charge lands — 'They said free 1-week trial and that they would notify us before payment went through and they did not honor that either of these statements'; 'It's kinda lame to market an app heavily towards ADHD and tell you specifically that you'll get a reminder before the free trial ends only to not do exactly that'",
  "promised pre-charge reminder not delivered; trial defaults to annual", "1★-burst",
  "M-trial-no-reminder 160 (0.228%) mean 1.98, 92 one-star, 89 paid-evidence; appears 2022 through 2026 every year (5/8/12/14/13 cited IDs per year)", "must-never-break", "weak volume / highest intensity", "yes",
  ["8450449406","9377363892","10894998349","12165793458","13684684762","12821877102","12761313447","14512967242"])
c(48, "§4.2 Why this is worse than an ordinary billing complaint (ADHD + promised reminder)", "insight",
  "Why this is worse than an ordinary billing complaint: the product is marketed to and adopted by people who state they cannot reliably remember things — a promised reminder is not a courtesy in that context, it is the feature; reviewers make this argument unprompted dozens of times",
  "ADHD-marketed app that fails its own reminder promise", "1★-burst", "7.36% of corpus self-identifies as ADHD/ND; 6 cited IDs making the argument", "product-rule", "argued by reviewers", "yes",
  ["11939993235","11959224161","12738181086","13571872699","13042542238","14043265448"])
c(49, "§4.2 Charged at trial start, not trial end", "must-never-break",
  "'Charged at trial START, not trial end' is a distinct and more severe claim — whether a real charge, a pre-authorisation, or a store-side display artefact cannot be determined from text, but 149 people believe it happened and 99 of them gave one star",
  "trial appears to charge immediately", "1★-burst", "M-trial-charged 149 (0.213%) mean 1.79, 99 one-star, 96 paid-evidence", "must-never-break", "weak volume / highest intensity", "yes",
  ["12117168256","12154514925","12238194934","12242821032","12267858614","12489141814","12515680303","12742313476","12814366937","13309759497","13323080135","14163733137","14334922614","14403016858"])
c(50, "§4.2 Refund refusal closes the loop", "must-never-break",
  "Refund refusal closes the loop and is the lowest-rated theme in the corpus: reviewers describe being routed between the developer and Apple with neither accepting responsibility",
  "refunds refused / routed to Apple", "1★-burst", "M-refund-denied 98 (0.140%) mean 1.48, 71 one-star, 91 paid-evidence", "must-never-break", "weak volume / lowest mean", "yes",
  ["12409091682","12518605995","12655037808","13005792453","13869988823","14020090949","14242421063","14275458594","14466997995","11753119019","10405832029"])
c(51, "§4.2 M-cancel-hard, M-unauthorized, M-double-charge rows", "must-never-break",
  "Cancellation friction / cancelled-but-still-charged, unauthorised-charge reports and duplicate charges complete the billing-dispute family",
  "cancellation friction; charges perceived as unauthorised; double charges", "1★-burst", "M-cancel-hard 66 (0.094%) mean 2.18, 36 one-star, 30 paid; M-unauthorized 51 (0.073%) mean 2.12, 31 one-star, 24 paid; M-double-charge 10 (0.014%) mean 1.60, 5 one-star, 8 paid", "must-never-break", "ignore-band volume, carve-out", "yes", [])

# ---- 4.3 ----
c(52, "§4.3 Reliability and data integrity table (verbatim)", "data-caveat",
  "Reliability and data-integrity themes: thirteen defect themes with n, %, signal, mean, 1★",
  "n/a", "1★-burst", table("## 4.3 Reliability and data integrity") + " ; segment: reliability family 20.95% of all 1★ (369/1,761) and 21.03% of all 2★ (156/742)", "none", "verbatim", "app-specific", [])
c(53, "§4.3 D-crash row; §8.2", "must-never-break",
  "Crashes are the largest single defect theme",
  "crash on launch during events", "1★-burst", "D-crash 568 (0.811%, EMERGING) mean 3.07, 151 one-star", "must-never-break", "emerging", "yes", [])
c(54, "§4.3 The data-loss mechanism, as users describe it", "must-never-break",
  "The data-loss mechanism as users describe it: progress lives on the device; a cloud backup exists but is manual and opt-in and many users only discover this after the loss; failure modes: (a) 'your pet data got corrupted' with only re-hatching offered, (b) app deleted/offloaded for storage and unrecoverable, (c) phone change and account unrecoverable, (d) backup file exists but restores empty or fails",
  "local-only progress; manual opt-in cloud backup", "1★-burst", "D-data-loss 551 (0.787%, EMERGING) mean 3.10, 160 one-star; D-no-backup 37; D-login-account 90 mean 2.89; D-sync-devices 31 mean 4.16, 0 one-star; IDs every year 2021–2026", "must-never-break", "emerging / 9.09% of 1★", "yes",
  ["7603837966","8124198861","9714150379","11291619797","12595515502","13683756253","14245428205","13411041280"])
c(55, "§4.3 The compensation is described as insulting relative to the loss", "anti-pattern",
  "The data-loss compensation is described as insulting relative to the loss: the standard remedy is 5,000 rainbow stones, and reviewers itemise 20,000–200,000 stones lost, multi-year streaks and event-exclusive items that cannot be re-earned (~10,000 items lost, 30 offered back)",
  "flat 5,000-stone compensation regardless of loss", "1★-burst", "losses itemised: 20,000 / 30,000+ / 35,000 / 40,000 / 200,000 stones; ~10,000 items lost vs 30 returned", "dont", "reviewer-itemised", "yes",
  ["12925432031","13033899041","10411200153","13923371591","13434160590","13787017447"])
c(56, "§4.3 It hits paying users no less than free users (data loss)", "must-never-break",
  "Data loss hits paying users no less than free users — the paid cohort is over-represented in the data-loss theme",
  "no automatic backup for subscribers either", "churn", "48 of 551 data-loss reviews carry purchase evidence; paid cohort 4.4× over-represented", "must-never-break", "segment rate", "yes",
  ["12595515502","13411041280","13732070192","14156611933","13646312358","14273682143"])
c(57, "§4.3 It is described in bereavement language", "insight",
  "Data loss is described in bereavement language — 'It feels like a pet died', 'my birb Bean… she liked tea, chocolate chip cookies, and hated Blues Clues. And now she's gone', 'planning the funeral for her birb', 'murdered my bird, my heart, and my soul' — the emotional-attachment mechanic firing in reverse",
  "single-pet attachment with no backup", "1★-burst", "4 cited bereavement reviews within 551 data-loss reviews", "must-never-break", "qualitative", "yes",
  ["9583838100","13033899041","14243659017","13732070192"],
  side="the stronger the attachment mechanic, the larger the data-loss liability")
c(58, "§4.3 Support closes this loop badly too (D-support)", "must-have",
  "Support closes the loop badly: unanswered emails, weeks-long delays, AI or canned replies and 'we're a small team' — and paying users are 13× over-represented among support complaints",
  "slow / AI / canned support; small team", "complaint", "D-support 185 (0.264%, WEAK) mean 3.10, 71 one-star; 48 of 185 (26%) carry purchase evidence — 13.2× over-representation", "must-have", "weak / paid-skewed", "yes",
  ["12508862481","13005792453","13192704866","13756726098","14225501459","14366340795","14251210046","12907317317","12518605995","14207705711","13428425479","14025215424"])
c(59, "§4.3 The widget is the longest-running unfixed defect in the corpus", "must-never-break",
  "The home-screen widget is the longest-running unfixed defect in the corpus: across all five years it renders as a grey/black box or fails to update — mostly fans reporting it, which is why it never generated pressure",
  "widget chronically broken 2021–2026", "complaint", "D-widget-bug 117 (0.167%, WEAK) mean 3.91, 6 one-star; IDs in every year 2021–2026; widget mentioned 493 times", "must-never-break", "weak, persistent", "yes",
  ["8028480594","8063339783","9504481447","10233025213","11832970239","13215675126","13720918256","14361444262","14407038000"])
c(60, "§4.3 D-lag-perf, D-notif-broken, D-goals-bug, D-event-bug, D-sound-bug rows", "must-never-break",
  "Remaining defect themes: lag/overheating/battery, notifications not delivered or not switchable off, goals disappearing/duplicating/reordering, monthly event/quest/reward bugs, audio/soundscape breakage",
  "multiple defects", "complaint", "D-lag-perf 149 (0.213%) mean 3.62; D-notif-broken 86 (0.123%) mean 3.47; D-goals-bug 83 (0.119%) mean 3.81; D-event-bug 73 (0.104%) mean 3.23; D-sound-bug 19 mean 3.47", "must-never-break", "weak", "yes", [])

# ---- 4.4 ----
c(61, "§4.4 Product-change backlash table (verbatim)", "timeline",
  "Product-change backlash themes with peak periods: UI change (Feb 2024 redesign; continuous 2025–26), feature-removed-generic (2026), mood check-in removed (Oct 2025–Mar 2026), Journeys removed (Apr–Jun 2025), timed goals removed (Nov 2025–Jan 2026)",
  "repeated redesigns and removals", "complaint", table("## 4.4 Product-change backlash"), "none", "verbatim", "app-specific", [])
c(62, "§4.4 Collectively they are the corpus's clearest statement about product direction", "product-rule",
  "Individually the product-change themes are small; collectively they are the corpus's clearest statement about product direction, all dated, all pointing the same way",
  "removed features users bought the app for", "complaint", "FAM-product-change 269 (0.384%, WEAK) mean 3.43, 51 one-star; U-ui-change 94 mean 3.53", "product-rule", "weak volume / coherent", "yes", [])

# ---- 4.5 ----
c(63, "§4.5 Gamification harm table (verbatim)", "data-caveat",
  "Gamification-harm themes: overwhelm, boring, economy, just-checklist, streak pressure, too many clicks, notification spam, blob micropets, FOMO events",
  "n/a", "complaint", table("## 4.5 Gamification harm"), "none", "verbatim", "app-specific", [])
c(64, "§4.5 U-overwhelm is the largest single UX complaint in the corpus", "anti-pattern",
  "Overwhelm is the largest single UX complaint: an app sold to people with executive-function difficulty has accumulated so many interstitials that reaching the checklist is itself an executive-function task — 'I don't wanna be required to go through 800 different screens before I can get to the checklist'; one review lists six sequential screens before the goal list",
  "interstitial-heavy path to the core checklist", "complaint", "U-overwhelm 1,046 (1.493%, MEANINGFUL) mean 4.50; U-too-many-clicks 84 (0.120%) mean 3.49", "dont", "meaningful", "yes",
  ["12951667597","12095378263","12823843140","13661516668","14168702702","12658682757","11766242787","9330701695","10529428569","13237881486"])
c(65, "§4.5 Streaks are a net-negative mechanic in the written record — design harm", "anti-pattern",
  "Streaks are a net-negative mechanic in the written record — design harm: the streak reintroduces exactly the guilt the app was praised for removing, and repairing it costs 1,000 gems ('I dread going into finch because of this new feature')",
  "streaks added ~mid-2024; paid/gem-cost streak repair", "complaint", "U-streak-pressure 96 (0.137%) mean 3.96; 5 reviews in 2022–23 combined, 24/41/23 in 2024/2025/2026", "dont", "weak, rising", "yes",
  ["11591661994","11548301986","11688717901","12179584982","12488852403","14075929805","12176073009","13003497273","14513803336","11900885112"])
c(66, "§4.5 Streaks — defect harm (D-streak-bug)", "must-never-break",
  "Streaks — defect harm: the streak resets despite eligibility, or repair tokens fail outright, and this defect grew 74× in three years",
  "streak counter unreliable; repair fails", "complaint", "D-streak-bug 171 (0.244%) mean 3.26, 45 one-star; 0.01% of 2023 → 0.74% of 2026 (74×)", "must-never-break", "weak, rising fast", "yes",
  ["14155454118","14156037444","14156043295","14158910349","14158945706","14160185561","14161950158","14184548492","14190841447","14258840772","13645979333","14020891685"])
c(67, "§4.5 The economy is a friction generator (U-economy)", "anti-pattern",
  "The in-game economy is a friction generator: goals yield 3–12 stones while shop items cost 500–900, the shop rotates randomly with a paid re-roll, and the item you want never appears (one review does the arithmetic: 50 tasks for one 250-stone item)",
  "stone scarcity; random shop; paid re-roll", "complaint", "U-economy 196 (0.280%, WEAK) mean 4.10", "dont", "weak", "yes",
  ["13291611680","12199427863","14437464706","12896721169","14277989798","13512928462","13899596152","12783240976","13528610213","14415321702"])
c(68, "§4.5 'It's just a checklist' is the churn thesis; U-goal-verification sibling", "insight",
  "'It's just a checklist' is the churn thesis, stated by people who still rate it highly ('Just create a Notes app checklist and add it as a widget'); its sibling, completion verification, is the same observation as a feature request — users volunteer that they check boxes without doing the task and ask to be held accountable",
  "no completion verification", "mixed", "U-just-checklist 111 (0.158%) mean 4.13; U-goal-verification 158 (0.226%) mean 4.59", "research", "weak", "yes",
  ["11976062097","11688717901","13649889390","12241418903","14263816049","11584654564","12966352245"])
c(69, "§4.5 U-boring, U-notif-spam, U-blob-micropets, U-fomo-events rows; §2.1 adventures cooldown", "anti-pattern",
  "Engagement decays into repetition; notification volume is a complaint; monthly-event micropets are seen as low-quality 'blobs' or duplicates; event/FOMO pressure and non-recoverable rewards; the adventure cooldown is itself a complaint",
  "content treadmill with FOMO", "complaint", "U-boring 518 (0.740%, EMERGING) mean 4.39; U-notif-spam 77 (0.110%) mean 3.65; U-blob-micropets 52 mean 3.81; U-fomo-events 40 mean 3.52; adventures 2,290 mentions (3.27%)", "dont", "emerging / weak", "yes", [])

# ---- 4.6 ----
c(70, "§4.6 Unmet needs — requests, not defects table (verbatim)", "feature",
  "Unmet needs are retention offers from users who already like the product — almost all 4–5★: more pet interaction, Apple Health, accessibility, localisation, completion verification, Apple Watch, dark mode, night-shift schedule, cross-device sync, Family Sharing, desktop/web",
  "absent", "praise", table("## 4.6 Unmet needs"), "build-free", "verbatim", "yes", [])
c(71, "§4.6 More pet interaction / mini-games — largest single feature request", "feature",
  "More pet interaction / mini-games is the largest single feature request",
  "pet interaction limited to adventures and dressing", "praise", "829 (1.184%, MEANINGFUL) mean 4.64", "undecided", "meaningful", "app-specific", [])
c(72, "§4.6 Apple Health (608 requests) is the largest ignored integration ask in the corpus", "feature",
  "Apple Health integration is the largest ignored integration ask in the corpus — mindful minutes, water, medication — almost entirely from satisfied users",
  "absent", "praise", "608 (0.868%, EMERGING) mean 4.69", "undecided", "emerging", "yes",
  ["14408516417","12160927071","13818669914","8601859891","8323353137","11470496389","12397154442","13053497310","9878449464"])
c(73, "§4.6 Apple Watch (92, mean 4.71) is the most emotionally coherent ask", "feature",
  "Apple Watch is the most emotionally coherent ask: users want it specifically to stop looking at their phone, which is the app's own stated goal — 'I got an Apple Watch because I felt like my phone was sucking attention and energy from me… I would love to be able to check on my birb and mark off goals on the watch'",
  "absent", "praise", "92 (0.131%, WEAK) mean 4.71", "undecided", "weak, high mean", "yes",
  ["11451565056","14471258544","13919785505","8316004742","8310431154","12865399088"])
c(74, "§4.6 Dark mode (90 requests since 2022) is an accessibility issue, not a preference", "feature",
  "Dark mode is an accessibility issue, not a preference — 'a self-care app could keep producing popular cosmetic items for the pets while leaving light-sensitive users without a basic accessibility feature. Cute clothes for the bird were apparently shippable' (migraine, light sensitivity)",
  "absent since 2022", "complaint", "90 (0.128%, WEAK) mean 4.28; requested since 2022", "build-free", "weak", "yes",
  ["14284922425","13690970916","13654406960","14008031999","13145721783","12557849777","13945397134"])
c(75, "§4.6 Accessibility (broad) row; §7.5", "feature",
  "Broad accessibility demand (screen reader, motion, disability representation, text size) is emerging-band and from satisfied users",
  "partial", "praise", "597 (0.852%, EMERGING) mean 4.56; FAM-accessibility 1,150 (1.64%) mean 4.47", "must-have", "emerging", "yes", [])
c(76, "§4.6 Localisation row (11+ languages requested); §7.4", "feature",
  "Localisation is requested in 11+ languages",
  "English-only", "blocked-conversion", "292 (0.417%, WEAK) mean 4.27", "build-free", "weak globally, very strong in RU/CN", "yes", [])
c(77, "§4.6 Completion verification row", "feature",
  "Completion verification (photo proof / anti-cheat) is asked for by users who admit checking boxes without doing the task",
  "absent", "praise", "158 (0.226%, WEAK) mean 4.59", "research", "weak", "yes", [])
c(78, "§4.6 Night-shift / non-standard schedule row (U-schedule-night)", "feature",
  "The app assumes a conventional daytime schedule and northern-hemisphere seasons; night-shift workers and southern-hemisphere users ask for a configurable day boundary and seasons",
  "fixed day boundary and seasons", "complaint", "146 (0.208%, WEAK) mean 4.64", "build-free", "weak", "yes", [])
c(79, "§4.6 Cross-device sync row", "feature",
  "Cross-device sync / account portability is requested with zero one-star reviews — a pure request",
  "absent", "praise", "31 (0.044%) mean 4.16, 0 one-star", "undecided", "ignore-band", "yes", [])
c(80, "§4.6 Family Sharing row; §2.2 Family Sharing not supported", "monetization",
  "Family Sharing is not supported and the objection is per-seat pricing — households asked to pay twice",
  "no Family Sharing", "complaint", "30 (0.043%) mean 3.63", "research", "ignore-band", "yes", [])
c(81, "§4.6 Desktop / web row", "feature",
  "Desktop / web version is barely requested in this corpus",
  "absent", "praise", "6 (0.009%) mean 3.83", "research", "ignore-band", "yes", [])

# ---- 4.7 ----
c(82, "§4.7 Content, values and trust table (verbatim)", "data-caveat",
  "Content, values and trust themes: age rating, pronouns, safety, diagnosis quiz, community moderation, AI, brand collab, religion, LGBT-more, LGBT-objection, privacy, pronouns-objection, national flag, review manipulation, hiring ethics",
  "n/a", "mixed", table("## 4.7 Content, values and trust"), "none", "verbatim", "app-specific", [])
c(83, "§4.7 C-age-rating row", "audience",
  "Child-appropriateness / 4+ age-rating concerns are a meaningful theme, mostly from parents, mixed in direction",
  "4+ rated with mental-health quizzes", "mixed", "C-age-rating 920 (1.314%, MEANINGFUL) mean 4.74", "research", "meaningful", "yes", [])
c(84, "§4.7 The pronoun screen is a measurable acquisition leak, and it is small", "dont",
  "The pronoun-selection screen is a measurable but small acquisition leak: users delete the app at that step — reported only because the intervention is cheap and non-editorial (a skip option) and the same intervention serves the opposite constituency",
  "mandatory pet-pronoun question at onboarding", "churn", "C-pronouns-objection 54 (0.077%) mean 3.24; peaked 2022 (1.19% of that year's pronoun mentions), flat since; C-pronouns all 428 (0.611%) mean 4.42", "do", "ignore-band volume", "yes",
  ["8580844131","8474636545","9487215463","9891211417","11733826774","12309043500","13004599450","13000860998","13283702073","13678224974","13680058420","14012193700","14416401473","14488479244"])
c(85, "§4.7 111 reviews complain that representation is missing (C-lgbt-more); C-lgbt-objection; C-religion; C-national-flag", "feature",
  "Loyal users complain representation is missing — most often the lesbian flag, aroace, demigirl/demiboy — while a similar number object to LGBTQ+ content or want an opt-out; religious items and national flags are also requested",
  "Pride content; limited flag set", "mixed", "C-lgbt-more 111 (0.158%) mean 4.57; C-lgbt-objection 109 (0.156%) mean 3.50; C-religion 116 (0.166%) mean 4.14; C-national-flag 16 mean 3.00", "undecided", "weak, both directions", "app-specific",
  ["12280237908","11159383290","12379742945","14144887984","12484266125","11477756750","10928423183","14347171250"])
c(86, "§4.7 Safety-sensitive content is present and has produced at least one severe incident class", "must-never-break",
  "Safety-sensitive content produced at least one severe incident class: in 2022 the goal-suggestion system parsed a journal entry about suicidal ideation and generated a goal to 'schedule time for suicide'; in-app depression/anxiety/ADHD quizzes returned severe results to children in a 4+ app; a 'you can do this' notification arrived immediately after a text about suicide — reported regardless of volume under the safety carve-out",
  "auto goal suggestions from journal text; diagnosis quizzes; motivational notifications", "complaint", "C-safety 335 (0.478%) mean 4.55; C-diagnosis-quiz 221 mean 4.86; 3 + 4 + 1 incident IDs", "must-never-break", "safety carve-out", "yes",
  ["8197656256","8249486173","8310957728","10461078232","11680366668","9028127653","8747299439","12943514439"])
c(87, "§4.7 The community-moderation stream is a persistent, dated reputational drag", "anti-pattern",
  "The community-moderation stream is a persistent reputational drag: the Facebook group, Discord and subreddit are described as heavily moderated and hostile to criticism, with a 2022–23 cluster around a Harry Potter / JK Rowling content decision producing accusations in both directions, and an anti-Black moderation allegation; paying users are 7× over-represented",
  "official community channels with heavy moderation", "complaint", "C-community-mod 211 (0.301%, WEAK) mean 3.93; 29 of 211 paid (7.0× over-representation)", "dont", "weak", "yes",
  ["8779142067","8786543457","8809056328","9344350321","9696554036","9954956356","10427260247","12039960855","8714915960","8996753611","12023264733","12205292045","13454522816","14372739263","14201570708","14260047035","14154691963"])
c(88, "§4.7 C-ai, C-privacy, C-review-manip, C-hiring-ethics rows", "data-caveat",
  "Smaller trust themes: use of AI in ads/support/content (mostly 2025–26), privacy (contacts, phone-number-only sign-up, tracking), review-manipulation allegations, and a May 2025 cluster alleging unpaid design work in hiring at the lowest mean of any content theme",
  "n/a", "complaint", "C-ai 156 (0.223%) mean 4.35; C-privacy 101 (0.144%) mean 3.96; C-review-manip 16 mean 4.25; C-hiring-ethics 9 mean 1.67 (May 2025)", "dont", "weak", "yes", [])

# ---- 4.8 ----
c(89, "§4.8 Merch fulfilment", "anti-pattern",
  "Physical merch orders arrive late, wrong or not at all, with no support response",
  "sells plushies/pins/stickers", "complaint", "merch 134 mentions (0.19%); 6 cited fulfilment complaints", "dont", "small", "app-specific",
  ["12100759969","12849337898","14135314999","14172035895","14444272993","13529294099"])
c(90, "§4.8 Update churn", "anti-pattern",
  "Update churn: near-daily updates, large downloads, and monthly events that require an update to unlock",
  "frequent forced updates", "complaint", "7 cited reviews", "dont", "small", "yes",
  ["11198114825","11510475741","12613070528","13513453625","14083723197","14381189233","14382450807"])
c(91, "§4.8 Forced pet ageing / colour change (U-forced-color)", "anti-pattern",
  "Users are made to change their pet's colour at a growth milestone with no way back",
  "forced colour change at growth stage", "complaint", "22 reviews mean 3.59", "dont", "small", "app-specific",
  ["8431474054","9348919175","10666674801","11613982899","12602358290","12671877044","14168221622","14477855392"])
c(92, "§4.8 The pet's randomised likes/dislikes (U-likes-dislikes)", "anti-pattern",
  "The pet's randomised likes/dislikes cause distress — the companion 'hates everything I love'",
  "random personality traits", "complaint", "28 reviews mean 3.79", "dont", "small", "app-specific",
  ["12267413829","13650646547","11882249586","12802871170","10868115871","14114392965","13445215677"])

with open("Tools/prd_ledger/10/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
