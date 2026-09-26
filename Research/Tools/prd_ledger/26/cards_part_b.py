"""Cards for report 26 — Part 3 (global findings), Part 4 (ratings), Part 5 (paid users)."""
import json, re
R = 26
rep = open("App Store Reports/26. Eden - Daily Routine Planner - Self care habit tracker, to do (REPORT).md").read().split("\n")
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

c(29, "§3.1 Verified theme table (verbatim), 37 themes with per-star counts", "data-caveat", "Master theme table, denominator 3,837, with per-band counts", "n/a", "mixed", table("## 3.1 Verified theme table"), "none", "corpus-level fact", "app-specific", [])
T = [
 (30,"Aesthetic / design praise","feature","Aesthetic / design praised","1,068 (27.83%, high-priority), mean 4.64; 1★ 10 · 5★ 812","do","praise"),
 (31,"Music / calm / ambience praise","feature","Music / calm / ambience praised","559 (14.57%, high-priority), mean 4.68; 5★ 446","build-free","praise"),
 (32,"Simplicity / ease praise","insight","Simplicity / ease praised","411 (10.71%, high-priority), mean 4.70; 5★ 334","product-rule","praise"),
 (33,"Any monetisation gating","monetization","Any monetisation gating (union)","436 (11.36%, high-priority), mean 3.42; 1★ 63 · 2★ 51 · 3★ 82 · 4★ 121 · 5★ 119","product-rule","complaint"),
 (34,"Paywall friction (general)","monetization","General paywall friction","281 (7.32%, high-priority), mean 3.55; 1★ 31","product-rule","complaint"),
 (35,"Garden-growth motivation praise","insight","Garden-growth metaphor as motivation","229 (5.97%, high-priority), mean 4.68; 5★ 180","build-free","praise"),
 (36,"Free habit-count cap","monetization","Free habit-count cap complaint","148 (3.86%, very strong), mean 3.51; 4★ 47 · 5★ 40","product-rule","complaint"),
 (37,"ADHD / autism / OCD self-ID","audience","ADHD / autism / OCD self-identified — mixed","81 (2.11%, meaningful), mean 3.84; 1★ 5 · 5★ 33","do","mixed"),
 (38,"Explicit payer","monetization","Explicit payer segment","72 (1.88%, meaningful), mean 3.56; 1★ 11 · 5★ 30","none","mixed"),
 (39,"Quotes praise","feature","Daily quotes praised","58 (1.51%, meaningful), mean 4.74; 5★ 48","build-free","praise"),
 (40,"Defends the price","monetization","Defends the price","57 (1.49%, meaningful), mean 4.18; 5★ 38","build-paid","praise"),
 (41,"Garden/flower count cap","monetization","Garden/flower count cap — 'my reward stopped'","53 (1.38%, meaningful), mean 3.13; 3★ 17","product-rule","complaint"),
 (42,"Flower/garden not growing","anti-pattern","Flower/garden not growing (verified)","50 (1.30%, meaningful), mean 2.96; 3★ 16","product-rule","complaint"),
 (43,"Praises the free tier","monetization","Praises the free tier as generous","45 (1.17%, meaningful), mean 4.49; 5★ 33","free","praise"),
 (44,"No statistics / history / calendar","feature","No statistics / history / calendar (verified)","40 (1.04%, meaningful), mean 3.83; 4★ 16","free","complaint"),
 (45,"Crash / launch failure","must-never-break","Crash / launch failure","33 (0.86%, emerging), mean 2.79; 1★ 12","must-never-break","complaint"),
 (46,"Mental-health context","audience","Mental-health context","32 (0.83%, emerging), mean 4.66; 5★ 26","do","praise"),
 (47,"Price objection","monetization","Price objection — the smallest of the four monetisation objections","29 (0.76%, emerging), mean 2.76; 1★ 9","research","complaint"),
 (48,"No backfill / day boundary","feature","No backfill / configurable day boundary (verified)","29 (0.76%, emerging), mean 3.03; 3★ 11","build-free","complaint"),
 (49,"Praises gentleness / no streak","insight","Praises gentleness / no streak","25 (0.65%, emerging), mean 4.76; 5★ 20","product-rule","praise"),
 (50,"Teen / child / student","audience","Teen / child / student","25 (0.65%, emerging), mean 4.16","do","praise"),
 (51,"Purchase lost / not delivered","must-never-break","Purchase lost / not delivered","24 (0.63%, emerging), mean 2.71; 1★ 7","must-never-break","complaint"),
 (52,"Trial / billing dispute","must-never-break","Trial / billing dispute — the lowest-rated theme","23 (0.60%, emerging), mean 1.48; 1★ 17","must-never-break","1★-burst"),
 (53,"Widget (mentions)","feature","Widget mentions","21 (0.55%, emerging), mean 4.14","free","mixed"),
 (54,"All-or-nothing reward rule","product-rule","All-or-nothing reward rule (verified)","20 (0.52%, emerging), mean 2.80","product-rule","complaint"),
 (55,"Reorder / group / per-habit garden","feature","Reorder / group / per-habit garden","18 (0.47%, weak), mean 4.06","free","complaint"),
 (56,"Music fault (can't disable / won't play)","must-never-break","Music fault — can't disable / won't play (verified)","16 (0.42%, weak), mean 2.94","must-never-break","complaint"),
 (57,"Cannot complete purchase","monetization","Cannot complete purchase — willing buyers blocked","16 (0.42%, weak), mean 4.06; 5★ 10","do","blocked-conversion"),
 (58,"Flexible recurrence (N×/week)","feature","Flexible recurrence (N×/week)","12 (0.31%, weak), mean 3.50","must-have","complaint"),
 (59,"Review incentivised by unlock","tactic","Review incentivised by unlock","13 (0.34%, weak — floor), mean 4.77","dont","5★-burst"),
 (60,"Support unreachable","must-have","Support unreachable (verified)","13 (0.34%, weak), mean 2.77","must-have","complaint"),
 (61,"Support praised","do","Support praised — all 5★","10 (0.26%, weak), mean 5.00","do","praise"),
 (62,"Custom habits not creatable","feature","Custom habits not creatable (verified) — preset-only onboarding","8 (0.21%, weak), mean 2.50","must-have","complaint"),
 (63,"Apple Watch requested","feature","Apple Watch requested","8 (0.21%, weak), mean 4.00","research","complaint"),
 (64,"Multi-count per day","feature","Multi-count per day","7 (0.18%, weak), mean 4.14","must-have","complaint"),
 (65,"No sync / no account","must-have","No sync / no account","7 (0.18%, weak), mean 3.57","must-have","complaint"),
 (66,"Accessibility (incl. VoiceOver)","feature","Accessibility incl. VoiceOver","5 (0.13%, weak — promoted on inclusion grounds), mean 4.00","must-have","complaint"),
]
for seq, w, kind, claim, mag, d, react in T:
    c(seq, f"§3.1 theme table {w}", kind, claim, "see §3.1", react, mag, d, "theme-table signal", "yes", [])
c(67, "§3.2 The positive core — aesthetic and calm are the mechanism: other trackers overwhelmed me → this one is beautiful and quiet → I keep opening it → the habit stuck ('Growing a garden feels like growing myself'; 'It's not just an app it's a piece of art')", "insight",
  "Aesthetic and calm are not decoration; reviewers describe them as the mechanism — other trackers overwhelmed me → this one is beautiful and quiet → therefore I keep opening it → therefore the habit stuck ('Most other habit tracking apps are too technical… Growing a garden feels like growing myself'; 'they are all really aggressively focussed on being productive… it's so gentle' from a reviewer almost entirely bedbound; 'It's not just an app it's a piece of art')",
  "calm aesthetic as retention mechanism", "praise", "aesthetic 1,068; 14 representative reviews", "do", "high-priority", "yes",
  ["8809983265","13024796099","12393951903","9280888384","8788448563","9062177143","9945145056","10084378650","10023340564","11064426818","12157437413","13291395738","13781551382","14068662243"])
c(68, "§3.2 Gentleness as against streaks — 'when you break a streak you feel dispirited and give up'; 'accountability and motivation without the shame'", "insight",
  "Gentleness specifically, as against streaks: 'it doesn't work on building a streak because then when you break a streak you feel dispirited and give up'; 'because you don't have a streak it is purely for your own benefit'; 'accountability and motivation without the shame' — Eden's defensible position is calm, non-punitive, beautiful, and every recommendation is filtered through whether it protects that", "no streaks", "praise", "25 (0.65%), mean 4.76", "product-rule", "emerging", "yes",
  ["10056813574","13772603777","13781551382","9204099812","12192324803","13178231487","13823192383","13291395738"])
c(69, "§3.3 The negative core — monetisation: 21.2% of substantive reviews raise the paywall; objection breakdown table (verbatim): cap 148, general 281, garden cap 53, price too high 29; price-defenders to price-objectors ~2:1", "monetization",
  "Monetisation gating is 11.36% of all reviews and 21.2% of substantive ones (380/1,791) — roughly one in five reviewers who write more than a sentence raises the paywall; what they object to: habit-count cap 148 ('I can't fit my routine in'), general paywall 281 ('too much is locked'), garden/flower cap 53 ('my reward stopped'), price too high only 29 (mean 2.76); against this 57 defend the price and 45 praise the free tier — defenders to objectors roughly 2:1 in favour of the price",
  "n/a", "complaint", table("Breakdown of what they actually object to:") + " ; substantive 380/1,791 = 21.2%", "product-rule", "high-priority", "yes", [])
c(70, "§3.3 Interpretation — an evaluation-window problem, not a pricing problem: 'You get about 5 days free to make one flower then you have to pay'; 'the flower stops growing once you reach 17%, which I finished in about 2 weeks'; a user writes the product hypothesis: give 1 garden free plus ads and 'that would probably get me intrigued enough to get a subscription'", "product-rule",
  "Eden does not have a pricing problem; it has an evaluation-window problem — the free tier gives enough to fall in love with the aesthetic and not enough to test the product, and it terminates the most visible feedback signal (garden growth) without saying so; 'You get about 5 days free to make one flower then you have to pay'; 'the flower stops growing once you reach 17%, which I finished in about 2 weeks. makes the app pretty pointless now'; one user writes the product hypothesis — 'I'd have been more invested if 1 garden was given as part of the free version (plus ads if needed). That would probably get me intrigued enough to get a subscription eventually'",
  "free tier ends before evaluation", "blocked-conversion", "3 named reviews; 436 (11.36%)", "product-rule", "interpretation", "yes",
  ["9502925206","9715657325","9879336314"])
c(71, "§3.4 Unmet needs table (verbatim) — stats/history/calendar 40; backfill/day boundary 29; partial credit 20; reorder/per-habit gardens/categories 18; flexible recurrence/vacation 12; Watch 8; multi-count 7; account/sync 7; interactive widget ~5; journal/gratitude ~4", "data-caveat",
  "Unmet needs ranked: statistics/history/calendar per habit 40 (1.04%); backfill previous day / configurable day boundary 29 (0.76%); partial credit 20 (0.52%); reorder habits / per-habit gardens / categories 18 (0.47%); flexible recurrence ('3× per week'), vacation mode 12 (0.31%); Apple Watch 8; multi-count per day (5 glasses of water, 10 pages) 7; account / cloud sync 7; interactive widget ~5; journal / gratitude note ~4",
  "n/a", "complaint", table("## 3.4 Unmet needs, ranked by evidence"), "none", "corpus-level fact", "yes",
  ["8558719429","8836532479","8933857624","9085912312","9441258136","9509282059","9843813677","10006259845","10282667264","11497891805","12104864958","12251741381","12265166141","14443983125","14477621410","8874333151","8875094753","9274330602","9449546415","10108096197","11176218907","12137473742","12531678334","12646839757","13080138566","13819651033","8628572813","8772022784","8807578550","8999474738","10206828410","11189660127","11873650347","12057271899","12932219546","14317196415","14468283183","8296733263","9267531151","9846065416","11563266717","12263431554","12520372421","12629745864","9237768812","10028179642","10073204122","10661938586","10828145441","10970096330","11420767261","9906136301","10388741373","11370282796","12254996375","12404001288","9052145225","9280888384","10958830676","11162718591","11655204052","12042680917","13358263218","9608846258","10103075953","13648793040","8475403176","9085913110","11932654664","12921283639"])
c(72, "§3.4 Statistics / history / calendar per habit — the top unmet need; 'this is a cosmetic habit tracker, it does not offer really understanding of progress'", "feature",
  "Statistics, history and a per-habit calendar are the top unmet need — 'this is a cosmetic habit tracker, it does not offer really understanding of progress'; a calendar appears to have shipped ~late 2024", "no per-habit stats for most of the corpus", "complaint", "40 verified (1.04%, meaningful), mean 3.83, 16 4★", "free", "meaningful", "yes",
  ["12251741381","12265166141","10006259845","14443983125"])
c(73, "§3.4 Backfill previous day / configurable day boundary", "feature", "Backfill of the previous day and a configurable day boundary (midnight reset) are requested", "no backfill; midnight cut-off", "complaint", "29 verified (0.76%, emerging), mean 3.03", "build-free", "emerging", "yes",
  ["8874333151","8875094753","9274330602","9449546415","10108096197","11176218907"])
c(74, "§3.4 Reorder habits / per-habit gardens / categories; flexible recurrence ('3× per week') and vacation mode; multi-count per day (5 glasses, 10 pages)", "feature",
  "Reordering habits, per-habit gardens or categories (18), flexible recurrence such as '3× per week' plus a vacation mode (12), and multi-count per day for water or pages (7) are requested", "absent", "complaint", "18 (0.47%); 12 (0.31%); 7 (0.18%)", "must-have", "weak", "yes",
  ["8772022784","10206828410","8296733263","9267531151","9906136301","10388741373"])
c(75, "§3.4 Interactive widget (tick from home screen) ~5; journal / gratitude note ~4", "feature", "An interactive widget to tick from the home screen (~5) and a journal / gratitude note (~4) are requested", "absent", "complaint", "~5; ~4", "undecided", "weak", "yes",
  ["9608846258","10103075953","13648793040","8475403176","9085913110","11932654664","12921283639"])
c(76, "§3.4 Accessibility — promoted on legal/inclusion grounds: a detailed, actionable VoiceOver defect report (images without alt text, focus loss, elements announced only as 'botão'); larger text; low contrast later fixed; dynamic type added and praised", "must-have",
  "Accessibility is weak by rate but promoted on legal/inclusion grounds: a detailed, actionable VoiceOver defect report — images without alt text, focus loss during navigation, elements announced only as 'botão' with no function (Brazil, June 2026) — plus larger text size, a low-contrast report later resolved by the developer, and praise for dynamic type being added",
  "VoiceOver defects; dynamic type shipped", "complaint", "5 (0.13%, weak)", "must-have", "weak, promoted", "yes",
  ["14231051461","10416666181","9959396034","14068662243"])
# Part 4
c(77, "Part 4 Ratings table (verbatim) — dominant themes per band", "data-caveat",
  "Per-band dominant themes: 5★ 2,898 (75.53%) aesthetic 812 · music 446 · simplicity 334 · garden 180 · paywall 82; 4★ 535 (13.94%) aesthetic 165 · paywall 83 · habit cap 47; 3★ 208 (5.42%) aesthetic 61 · paywall 55 · cap 26 · garden cap 17 · flower not growing 16 · backfill 11; 2★ 87 (2.27%) paywall 30 · aesthetic 20 · cap 19 · flower not growing 10; 1★ 109 (2.84%) paywall 31 · billing 17 · cap 16 · crash 12 · payer 11 · price 9 · flower not growing 9",
  "n/a", "mixed", table("# PART 4 — RATINGS ANALYSIS"), "none", "corpus-level fact", "app-specific", [])
c(78, "§4.1 5★ — two populations; the ≤25-char tier is 1,181 reviews (30.78%) inflated by the review reward; 82 five-star reviews still raise the paywall and 40 the cap", "insight",
  "5★ (75.53%) has two populations — a substantive one (aesthetic + calm + garden + simplicity) and the ≤25-character tier (1,181 reviews, 30.78% of the corpus, overwhelmingly 5★, almost no product information, inflated by the review reward); 82 five-star reviews still raise the paywall and 40 the habit cap — users who love the app and flag the gate", "n/a", "mixed", "1,181 (30.78%) ≤25 chars; 82 paywall + 40 cap inside 5★", "product-rule", "corpus-level fact", "yes",
  ["11201646002","11567448179","12494163107","13081671996","14368304623"])
c(79, "§4.1 4★ is the 'one thing away' band — the cap is the single most common reason for withholding the fifth star (47 of 535, 8.8%): 'amazing app, but you can only add 5'; widening or time-boxing the free tier converts 4★ to 5★ with no feature work", "insight",
  "4★ (13.94%) is the 'one thing away' band and the most commercially informative: the single most common reason for withholding the fifth star is the cap — 47 of 535 (8.8%) — with a near-identical sentence across languages, 'amazing app, but you can only add 5'; widening or time-boxing the free tier converts a measurable slice of 4★ to 5★ with no feature work", "free cap", "complaint", "47 of 535 (8.8%)", "product-rule", "meaningful", "yes",
  ["8568171880","10231187604","11531054327","12179799133","13036834858","14086191609","14371694907","14514107557"])
c(80, "§4.1 3★ is the diagnostic band — paywall and cap dominate but product critiques concentrate here: flower not growing, backfill, missing stats, partial credit, preset-only onboarding, VoiceOver", "insight",
  "3★ (5.42%) is the diagnostic band: paywall (55) and cap (26) dominate but the product critiques concentrate here — flower not growing (16), backfill (11), missing stats ('a cosmetic habit tracker'), partial credit, onboarding with preset-only habits, VoiceOver; reviewers are engaged and specific", "n/a", "complaint", "n=208", "must-have", "corpus-level fact", "yes",
  ["12251741381","12599605564","12265166141","13260660833","14231051461"])
c(81, "§4.1 2★ — 'beautiful but I can't use it': 20 of 87 still compliment the design", "insight", "The characteristic 2★ is 'beautiful but I can't use it' — 20 of 87 still compliment the design alongside the cap and the growth failure", "n/a", "complaint", "20 of 87", "product-rule", "corpus-level fact", "yes",
  ["13395181371","12298596229","13931019513","13967376763"])
c(82, "§4.1 1★ — 57.8% carry a monetisation theme; the distinctive content is transactional: 17 billing disputes (mean 1.48), 12 crashes, 7 lost purchases; angriest language reserved for charges ('Scam company. Impossible to cancel and tricks you into renewing')", "insight",
  "1★ (2.84%): 63 of 109 (57.8%) carry a monetisation theme and the distinctive content is transactional, not feature-based — 17 billing disputes (mean 1.48, the lowest-rated theme), 12 crashes, 7 lost purchases; the angriest language is reserved for charges: 'Scam company. Impossible to cancel and tricks you into renewing'; 'Estafadores'; '故意引君入甕'; 'Деньги на ветер'", "n/a", "1★-burst", "63/109; billing 17; crash 12; lost purchase 7", "must-never-break", "corpus-level fact", "yes",
  ["11858690687","14097593436","13526453417","9659384900"])
c(83, "§4.1 Rating/text mismatches disclosed — positive text with 1–2★ ('Me encanta 😍' 1★; 'perfect app!!' 2★) left at stated rating; do not treat star rating alone as a preference signal", "data-caveat",
  "A handful of reviews carry positive text with a 1–2★ rating ('Me encanta 😍' 1★; 'очень крутое приложение' 1★; 'perfect app!!' 2★) and are left at their stated rating — do not treat star rating alone as a preference signal", "n/a", "mixed", "5 named", "none", "method", "yes",
  ["11707621415","13338337959","12271851798","14098241981","13123175238"])
# Part 5
c(84, "§5.1 The explicit-payer segment — 72 (1.88%), mean 3.56, a full point below the corpus; by era 3.67 → 3.41 → 3.47 → 3.69 → 4.00 (n=21/22/15/13/1): flat and consistently below; the 2024 turnaround does not show up in payer satisfaction", "timeline",
  "Explicit payers (72, 1.88%; 1★ 11 · 2★ 8 · 3★ 13 · 4★ 10 · 5★ 30) rate Eden a full point below the corpus (3.56 vs 4.570); by era 3.67 (2021–22, n=21) → 3.41 (2023, 22) → 3.47 (2024, 15) → 3.69 (2025, 13) → 4.00 (2026, 1) — no meaningful trend; payer satisfaction is flat and consistently below the corpus mean across five years, and the 2024 quality turnaround does not show up in it",
  "paid experience flat while free experience improved", "mixed", table("By era (segment is small; read as directional only):") + " ; mean 3.56 vs 4.570", "must-never-break", "meaningful; small n", "yes", [])
c(85, "§5.2 What goes wrong for people who paid (verbatim table) — purchase lost 16.7%; paywall friction after paying 23.6%; billing 8.3%; cap still felt 11.1%; flower not growing 5.6%; crash 4.2%; support unreachable 4.2%; defends the price anyway 9.7%", "must-never-break",
  "Within 72 payers: purchase lost or not delivered 12 (16.7%; global 24, 0.63%); paywall friction after paying 17 (23.6%); trial/billing dispute 6 (8.3%; global 23); habit cap still felt after paying 8 (11.1%); flower not growing 4 (5.6%); crash 3 (4.2%); support unreachable 3 (4.2%); defends the price anyway 7 (9.7%)",
  "n/a", "churn", table("## 5.2 What goes wrong for people who paid"), "must-never-break", "meaningful; small n", "yes",
  ["8460123418","8904827978","9832692472","10180446556","12305193972","8807578550","9659384900","11805806530","11961817820","8630163595","9273659264","9012190142","11346819935","10661952185","9510970460","10081166801","8823685044","9023289235","10899320628"])
c(86, "§5.2 Three mechanisms for losing what they bought — the 2022 repricing withdrew a purchased unlock; restore-purchases fails or the button is dead; payment succeeded but premium never activated", "must-never-break",
  "The dominant paid-user failure is losing what they bought, by three mechanisms: the 2022 repricing withdrew a purchased unlock; restore-purchases fails or the restore button is dead (incl. Korea); payment succeeded but premium never activated (one resolved by support)",
  "entitlement fragile", "1★-burst", "8 + 8 + 8 IDs", "must-never-break", "meaningful", "yes",
  ["9091405863","9171397848","9199616690","9126251428","9201257502","10780468727","12116109329","12754805799","9110825123","10081166801","10607202811","10820076320","11037255753","12455426263","12189296095","10101213721","8936510590","9100759613","11704889459","11793200692","11998240319","12438244732","12087503101","11440749807"])
c(87, "§5.2 No account system — a device change, reinstall or support-recommended reinstall destroys both progress and entitlement ('deletes all the lovely growth… It also deletes the purchase price… as there is no account'); absent accounts every other entitlement bug becomes unrecoverable — the root cause", "must-have",
  "There is no account system, so a device change, a reinstall, or a support-recommended reinstall destroys both progress and entitlement — 'The support told me to delete and reinstall the app which of course deletes all the lovely growth you have achieved… It also deletes the purchase price of the app if you bought it as there is no account to sign into'; absent accounts, every other entitlement bug becomes unrecoverable — the root cause behind the top paid-user complaint",
  "no account, no sync", "churn", "sync/account 7 (0.18%); 3 named reviews", "must-have", "interpretation", "yes",
  ["9280888384","13358263218","10653056353"])
c(88, "§5.3 What triggers a purchase (verbatim table) — the aesthetic within minutes of install ('I bought premium within the first couple minutes'); one-time pricing; hitting the cap ('worth it for $6.99'); supporting the developer; wanting more gardens; intent stated but blocked by the rail", "monetization",
  "Purchase triggers: the aesthetic within minutes of install ('I bought premium within the first couple minutes of downloading'; 'bought the full version five minutes into trying it'; 'as soon as I saw the visuals and music I bought premium'); one-time pricing specifically (11 IDs); hitting the habit cap ('got premium for more tasks and was worth it for $6.99'); supporting the developer ('bought premium right away just to support the developers'); wanting more gardens after finishing one ('If more are added I'll probably subscribe forever'); intent stated but not completed because of the payment rail",
  "n/a", "purchase-driver", table("Direct purchase evidence — reviewers naming what made them buy:"), "build-paid", "meaningful", "yes",
  ["8529349059","9538949221","9278204636","10980121651","12517241963","13088087272","13014264724","8336140876","8772348836","9062393771","10399539290","10695074415","12157437413","12407593622","12771044340","13499175461","14139725862","14450189261","8336251610","9763250548","11754786694","10433282734","10056813574","9501729733","11848653184","8542291903","10394231453","11145405840","12206803821","12594654731"])
c(89, "§5.3 Interpretation — Eden converts on beauty and on the absence of a subscription, fast, often before evaluating functionality; that explains both purchase velocity and payer dissatisfaction ('I bought this one a little too soon I think')", "insight",
  "Eden converts on beauty and on the absence of a subscription, fast, and often before the user has evaluated the functionality — which explains both the high purchase velocity and the payer dissatisfaction: people buy in minutes on aesthetics, then discover the missing statistics, the all-or-nothing rule or the lost entitlement; 'I bought this one a little too soon I think, I wish I had waited to use it a while before spending money on it'",
  "aesthetic-led impulse conversion", "mixed", "payers mean 3.56 vs 4.570", "product-rule", "interpretation", "yes", ["11435151688"])
c(90, "§5.4 Purchase blocked by the payment rail — 16 willing buyers (mean 4.06) unable to pay: Russia 8 ('the button to start the trial is not clickable… possibly because I live in Russia'), China/Taiwan 3 (App Store shows a ¥38 tier with no in-app path), Vietnam 2 (ShopeePay / MoMo), GB / TR / DE — the highest-yield-per-effort monetisation item", "market",
  "16 reviews (0.42%, mean 4.06) describe wanting to pay and being unable to — unconverted willing buyers, not complaints: Russia 8 ('won't let me link a card'; 'the trial button is not clickable… possibly because I live in Russia'), China/Taiwan 3 ('tap subscribe and nothing happens… want to buy but can't'; a ¥38 tier shown on the App Store with no in-app purchase path), Vietnam 2 (requests ShopeePay / MoMo), plus GB (buy button not working), TR (price not displayed, button dead), DE (persistent error); Russia is 19.18% of the corpus and the highest-satisfaction market and supplies half of all 'I cannot pay you' reviews — the highest-yield-per-unit-effort monetisation item because the demand is already qualified",
  "no working purchase path in RU/CN/VN", "blocked-conversion", "16 (0.42%), mean 4.06; ru 8, cn/tw 3, vn 2", "do", "weak globally, high yield", "yes",
  ["8478822922","10156327013","10454824450","10635690558","11145405840","12774568544","13926278152","11704889459","11049310428","11440793102","13287745467","12761795981","13461522997","11037255753","11460280739","11793200692"])
c(91, "§5.5 Refund and cancellation friction — '3 days free' then charged immediately (lifetime tier charged instantly with no trial disclosed); cancelled before trial end, charged anyway; renewal with no notice; cannot find how to cancel ('the support button is not enabled'); refund requested, support unreachable", "must-never-break",
  "Trial/billing disputes (23, 0.60%, mean 1.48): '3 days free' then charged immediately (incl. a lifetime tier charged instantly with no trial disclosed); cancelled before trial end, charged anyway; renewal with no advance notice; cannot find how to cancel / no in-app cancellation ('well hidden there is a way to contact support… but the button is not enabled'); refund requested and support unreachable",
  "trial charges at once; no in-app cancel", "1★-burst", "23 (0.60%), mean 1.48; 7 + 3 + 2 + 3 + 4 IDs", "must-never-break", "emerging, lowest mean", "yes",
  ["10909221823","11504294876","12370651672","12404082975","11234070366","13526453417","12128361462","9541684420","11805806530","10971264763","14097593436","11858690687","11617459927","11961817820","9449546415","9510970460","13523628780","10180446556"])

with open("Tools/prd_ledger/26/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
