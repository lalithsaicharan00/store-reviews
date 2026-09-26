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

# ---- PART 9 ----
c(152, "§9.1 F1. Make the trial-conversion reminder real, and make it provable", "must-never-break",
  "F1: make the trial-conversion reminder real and provable — send the promised pre-charge notification as a blocking in-app card on next open, not only as a push (users report the push arriving at 1am and drowning in the app's own notification volume); show exact amount and charge date on the trial-acceptance screen and permanently in Settings; investigate and publicly explain the 149 'charged at trial start' reports; put a working cancel path inside the app rather than deep-linking to Apple",
  "push-only reminder; annual default; cancel via Apple deep link", "1★-burst", "404 billing-dispute reviews mean 1.97; 244 one-star; 241 of 1,381 payers; rate up 4–6× 2022→2025; 149 trial-charged, 99 one-star; M-cancel-hard 66 mean 2.18", "must-never-break", "recommendation (fix)", "yes",
  ["13126279553"])
c(153, "§9.1 F2. Ship automatic cloud backup, on by default", "must-never-break",
  "F2: ship automatic cloud backup on by default — no manual 'create save file' step (37 reviews did not know a manual backup was required until after the loss); never present 'your pet data got corrupted → re-hatch' as the only option — offer server-side recovery, and if impossible restore INVENTORY rather than 5,000 stones to someone who lost 30,000; fix account recovery (90 reviews describe email/phone not recognised for accounts that demonstrably exist — their friends can still see the bird); warn before the destructive path (users delete the app for storage every year in every market)",
  "manual opt-in backup; account recovery fails", "1★-burst", "551 data-loss reviews; 9.09% of 1★ band; family rate quadrupled 2022H1→2026H1; 37 no-backup; 90 login-account", "must-never-break", "recommendation (fix)", "yes",
  ["14141439529","13806982854","14102886128","13583950351"])
c(154, "§9.1 F3. Gate monthly events behind a crash test", "must-never-break",
  "F3: gate monthly events behind a crash test across device generations — the corpus contains the exact repro ('after the growth potion'); a pre-release check would have prevented the largest quality event in the app's history and, because of streaks, the largest single destruction of user progress",
  "no pre-release crash gate on event content", "1★-burst", "Feb 2026 120 crash-tagged reviews from a single event asset; June 2026 second cluster", "must-never-break", "recommendation (fix)", "yes", [])
c(155, "§9.1 F4. Fix the widget", "do",
  "F4: fix the widget — low severity per review, the single longest-running unresolved complaint in the corpus; fixing it is cheap goodwill",
  "widget broken 5 years", "complaint", "117 reviews over five years, mean 3.91, still open in 2026", "do", "recommendation (fix)", "yes", [])
c(156, "§9.1 F5. Answer support email", "must-have",
  "F5: answer support email — weeks of silence, canned replies that do not address the question, AI responses repeating the same three troubleshooting steps; the minimum viable fix: 'Please get some humans involved in your tech support'",
  "AI/canned support", "complaint", "185 reviews; 26% from payers; 13.2× paid over-representation", "must-have", "recommendation (fix)", "yes",
  ["14366340795"])
c(157, "§9.2 The single highest-leverage product decision — self-care tool with a game attached or a collection game with self-care attached; convergence table (verbatim); 'a pay-to-play loot box checklist simulator'", "insight",
  "The single highest-leverage decision: decide explicitly and publicly whether Finch is a self-care tool with a game attached or a collection game with self-care attached, then align the roadmap — the product has drifted from the first to the second without ever saying so, shown by the convergence of six signals; long-form reviewers state the drift as a thesis ('a pay-to-play loot box checklist simulator'); this is NOT a recommendation to remove the game (the game is why 10,074 call it cute and 11,175 say it motivates them) — it is to stop making the therapeutic layer pay for the game layer's growth: put First Aid back on the home screen, restore an OPTIONAL automatic mood check-in, stop moving breathing/soundscapes/reflections further behind menus",
  "therapeutic layer buried under collection game", "churn", table("## 9.2 The single highest-leverage") + " ; P-cute-design 10,074; P-motivation 11,175", "product-rule", "recommendation (strategic)", "yes",
  ["13828330334","14268143502","14420113173","13688122090","12551489443","14425330451","13456598701","13828096584","13971066794"])
c(158, "§9.3 P1. Restore cumulative, non-streak progress tracking", "feature",
  "P1: restore cumulative, non-streak progress tracking — the requirement is not the old UI, it is credit for non-consecutive progress; chronic-illness and ADHD users state a streak-only model is structurally incompatible with their lives; ship it alongside streaks, not instead of them",
  "removed cumulative progress (Journeys)", "churn", "U-journeys-removed mean 2.76, lowest-rated change", "must-have", "recommendation", "yes", [])
c(159, "§9.3 P2. Make every guilt mechanic optional — 'gentle mode' toggle; §9.5 #2", "product-rule",
  "P2: make every guilt mechanic optional — streak display, streak repair prompts, event countdowns, commitment prompts; a single 'gentle mode' toggle would resolve streak pressure and a large share of FOMO complaints",
  "guilt mechanics mandatory since mid-2024", "complaint", "476 praise non-guilt; 96 now say it guilts; U-fomo-events 40", "product-rule", "recommendation", "yes", [])
c(160, "§9.3 P3. Reduce the interstitial cost of the core action", "must-have",
  "P3: reduce the interstitial cost of the core action — a path from launch to checkbox that does not pass through a quote, a mood prompt, an event cutscene, a visitor, a chest, and a claim-confirm-claim sequence (one review counts the claim button appearing three times for one reward)",
  "six+ interstitials before the checklist", "complaint", "1,046 overwhelm; 84 too-many-taps", "must-have", "recommendation", "yes",
  ["12717371857"])
c(161, "§9.3 P4. Let users buy what they can see; §9.5 #6", "feature",
  "P4: let users buy what they can see — the catalogue shows items that cannot be purchased, the shop rotates randomly, the re-roll costs currency; this frustrates engaged, currency-rich users, the ones most likely to subscribe",
  "random shop rotation; paid re-roll; unpurchasable catalogue items", "complaint", "U-economy 196 mean 4.10", "do", "recommendation", "app-specific",
  ["13291611680","14437464706","12896721169","13528610213","14277989798"])
c(162, "§9.3 P5. Ship the platform integrations people are asking to pay for", "feature",
  "P5: ship the platform integrations people are asking to pay for — Apple Health, Apple Watch, cross-device sync, Family Sharing — the stated price of a fifth star and, for Family Sharing, of two or four subscriptions instead of one",
  "absent", "praise", "Apple Health 608 mean 4.69; Apple Watch 92 mean 4.71; sync 31 mean 4.16 zero 1★; Family Sharing 30", "undecided", "recommendation", "yes", [])
c(163, "§9.3 P6. Ship dark mode and finish the accessibility work you started", "must-have",
  "P6: ship dark mode and finish the accessibility work — and close the loop the onboarding opens: if a user declares a mobility limitation, stop suggesting walks",
  "asks about disability then ignores it", "complaint", "90 dark-mode requests since 2022; 597 accessibility reviews", "must-have", "recommendation", "yes",
  ["14249655239"])
c(164, "§9.3 P7. Localise — priority order; §9.5 #5", "market",
  "P7: localise — English-only is HIGH-PRIORITY at country level in eight storefronts simultaneously; priority order by combined volume and intensity: German, Spanish (es-419 + es-ES), French, Brazilian Portuguese, Russian, Japanese",
  "English-only", "blocked-conversion", "cn 26.4%, tr 19.0%, ru 18.5%, br 13.4%, es 11.9%, mx 8.9%, fr 7.0%, de 5.9%; paid-evidence rate de 1.29% / es 0.66% / mx 0.68%", "build-free", "recommendation", "yes", [])
c(165, "§9.3 P8. Make the values screens optional in both directions", "product-rule",
  "P8: make the values screens optional in both directions — a 'skip pronoun selection' toggle addresses the delete-at-onboarding reviews; a show/hide filter for themed cosmetic categories addresses the objectors and, by giving the same control to everyone, defuses the framing; the users asking for MORE representation have a higher mean than those asking for less, and the missing-lesbian-flag complaint recurs 2022–2026 unfixed",
  "mandatory pronoun step; no cosmetic-category filter", "mixed", "54 delete-at-onboarding; 109 objection mean 3.50; 111 want more mean 4.57", "product-rule", "recommendation", "yes", [])
c(166, "§9.4 Stop spending the ad-free reputation", "dont",
  "Stop spending the ad-free reputation: if brand partnerships continue, make them opt-in for subscribers",
  "sponsored IP events shown to payers", "churn", "857 name ad-free as trust reason; brand-collab 8.0× among payers, mean 3.09", "dont", "recommendation", "yes", [])
c(167, "§9.4 Offer a genuine monthly plan and price it visibly (M-no-monthly)", "monetization",
  "Offer a genuine monthly plan and price it visibly — the default-to-annual is the mechanism behind most of the billing disputes; several reviewers say plainly they would have paid monthly",
  "annual default; monthly absent or hidden", "blocked-conversion", "M-no-monthly 23 reviews ask directly; 404 billing disputes", "build-paid", "recommendation", "yes",
  ["11241544851","11243997394","12547404473"])
c(168, "§9.4 Offer a one-time purchase tier (M-want-onetime)", "monetization",
  "Offer a one-time purchase tier — asked for explicitly",
  "subscription only", "blocked-conversion", "M-want-onetime 47 reviews, mean 3.62", "research", "recommendation", "yes", [])
c(169, "§9.4 Fix price presentation", "must-never-break",
  "Fix price presentation: household members quoted different prices on the same day, support could not explain — whatever the mechanism, the perception is discriminatory pricing inside families",
  "inconsistent quoted prices", "complaint", "12 reviews", "must-never-break", "recommendation", "yes", [])
c(170, "§9.4 Formalise and publicise the Guardian pathway", "tactic",
  "Formalise and publicise the Guardian pathway — its only consistent complaint is that there is no visible way to apply",
  "Guardian exists, application path invisible", "praise", "mean 4.76 across 708 mentions", "do", "recommendation", "yes", [])
c(171, "§9.4 Do not raise prices to solve the paid-satisfaction problem, and do not cut them either", "dont",
  "Do not raise prices to solve the paid-satisfaction problem, and do not cut them either — price complaints are falling while billing complaints rise; the problem is the transaction, not the number",
  "n/a", "none", "price complaints falling; billing up 4–6×", "dont", "recommendation", "yes", [])
c(172, "§9.5 #1 Blocking in-app trial reminder vs push-only; part 9 #1", "do",
  "Experiment 1: blocking in-app trial reminder vs push-only; measure billing-dispute review rate and refund requests — expected to move the single worst-rated family",
  "n/a", "none", "billing family mean 1.97", "do", "experiment", "yes", [])
c(173, "§9.5 #2 'Gentle mode' toggle; part 9 #2", "do",
  "Experiment 2: 'gentle mode' toggle (streak hidden, no repair prompts, no event countdown); measure retention among self-identified ADHD/chronic-illness users against the non-punitive praise baseline",
  "n/a", "none", "476-review non-punitive baseline", "do", "experiment", "yes", [])
c(174, "§9.5 #3 Automatic backup default-on; part 9 #3", "do",
  "Experiment 3: automatic backup default-on with a one-line disclosure; measure data-loss review rate against the 2025H2–2026H1 baseline",
  "n/a", "none", "baseline 1.7–1.8%", "do", "experiment", "yes", [])
c(175, "§9.5 #4 Home-screen First Aid button restored; part 9 #4", "do",
  "Experiment 4: restore the home-screen First Aid button; measure P-tools mention rate",
  "First Aid moved off home screen", "none", "P-tools 15.63% → 2.65%", "do", "experiment", "yes", [])
c(176, "§9.5 #5 German + Spanish localisation as a paired test; part 9 #5", "do",
  "Experiment 5: German + Spanish localisation as a paired test; measure paid-evidence rate in de/es/mx",
  "n/a", "none", "current paid-evidence de 1.29% / es 0.66% / mx 0.68%", "do", "experiment", "yes", [])
c(177, "§9.5 #6 Catalogue-direct purchase vs random rotation; part 9 #6", "do",
  "Experiment 6: catalogue-direct purchase (buy any owned-catalogue item at a premium) vs random rotation; measure U-economy complaint rate and Plus conversion among high-balance users",
  "n/a", "none", "U-economy 196", "do", "experiment", "app-specific", [])
c(178, "§9.6 Research questions this corpus cannot answer", "data-caveat",
  "Research questions the corpus cannot answer: are 'charged at trial start' reports real charges, pre-authorisations or store artefacts (server logs can tell); actual data-corruption rate per active user; did any removed feature improve the metric it was removed for (only the cost side is visible); do sponsored IP events acquire more users than they cost in cancellations; subscriber satisfaction among people who never write about money; why did the paid-evidence RATE stay flat (1.6–2.3%) while paid SENTIMENT fell 1.44 stars — something changed in the experience, not in who was writing",
  "n/a", "none", "149 trial-charged; 551 data-loss; 127 brand-collab; paid 1,381; rate 1.6–2.3%", "research", "research questions", "yes", [])

with open("Tools/prd_ledger/10/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
