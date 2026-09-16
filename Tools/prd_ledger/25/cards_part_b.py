"""Cards for report 25 — Part 3 (global findings)."""
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

c(42, "§3.1 Complete ranked theme table (verbatim), 52 themes", "data-caveat", "Master theme table, denominator 1,309", "n/a", "mixed", table("## 3.1 Complete ranked theme table"), "none", "corpus-level fact", "app-specific", [])
T = [
 (43,"#1 Monetisation friction (union)","monetization","Monetisation friction union — cap, paywall, pop-ups, price, paywalled stats, survey-then-paywall","298 (22.77%, high-priority), mean 1.99, 5★ 31, 1★ 169","product-rule","1★-burst"),
 (44,"#2 General paywall complaint ('can't use it free')","monetization","General paywall complaint — 'can't use it free'","163 (12.45%, high-priority), mean 2.01, 1★ 90","product-rule","complaint"),
 (45,"#3 Free-tier habit cap (the '3 habits' complaint)","monetization","The 3-habit free-tier cap complaint","138 (10.54%, high-priority), mean 2.13, 5★ 16, 1★ 68","product-rule","complaint"),
 (46,"#4 Simplicity / ease of use","insight","Simplicity / ease of use praised","126 (9.63%, high-priority), mean 4.20, 5★ 89","product-rule","praise"),
 (47,"#5 Motivation / streaks / accountability works","insight","Motivation / streaks / accountability works","84 (6.42%, high-priority), mean 4.58, 5★ 64, 1★ 1","build-free","praise"),
 (48,"#6 Customisation, groups, colours, icons","feature","Customisation, groups, colours, icons praised","65 (4.97%, very strong), mean 4.49, 5★ 47","build-free","praise"),
 (49,"#7 Price praised as cheap / fair","monetization","Price praised as cheap / fair","64 (4.89%, very strong), mean 4.31, 5★ 45","build-paid","praise"),
 (50,"#8 Interface / visual design praised","feature","Interface / visual design praised","62 (4.74%, very strong), mean 4.42","do","praise"),
 (51,"#9 Price objection ('too expensive')","monetization","Price objection","55 (4.20%, very strong), mean 1.76, 1★ 35","research","complaint"),
 (52,"#10 Launch / interaction blocker (freeze, unresponsive)","must-never-break","Launch / interaction blocker","51 (3.90%, very strong), mean 1.63, 5★ 1, 1★ 33","must-never-break","1★-burst"),
 (53,"#11 Lifetime / one-time purchase discussed","monetization","Lifetime / one-time purchase discussed","44 (3.36%, very strong), mean 3.95, 5★ 27, 1★ 8","build-paid","mixed"),
 (54,"#12 Billing dispute / unwanted charge / refund","must-never-break","Billing dispute / unwanted charge / refund","44 (3.36%, very strong), mean 1.59, 1★ 32","must-never-break","1★-burst"),
 (55,"#13 ADHD / autism / OCD self-identified","audience","ADHD / autism / OCD self-identified","41 (3.13%, very strong), mean 4.44, 5★ 32","do","praise"),
 (56,"#14 Competitor named (switched from / compared)","positioning","Competitor named — switched from / compared","37 (2.83%, meaningful), mean 4.16, 5★ 24","do","praise"),
 (57,"#15 Upsell pop-ups interrupt use","dont","Upsell pop-ups interrupt use","35 (2.67%, meaningful), mean 1.80, 1★ 20","dont","complaint"),
 (58,"#16 Bug / glitch / error (generic)","must-never-break","Bug / glitch / error (generic)","33 (2.52%, meaningful), mean 3.09","must-never-break","complaint"),
 (59,"#17 Apple Health integration praised","feature","Apple Health integration praised","32 (2.44%, meaningful), mean 3.97","build-paid","praise"),
 (60,"#18 Widgets (mention)","feature","Widgets mentioned — positively","30 (2.29%, meaningful), mean 4.43, 1★ 0","build-free","praise"),
 (61,"#19 Wants per-habit clock time + timed notification","feature","Wants per-habit clock time + timed notification","29 (2.22%, meaningful), mean 3.41","must-have","complaint"),
 (62,"#20 Confusing / unintuitive / no guidance","anti-pattern","Confusing / unintuitive / no guidance","27 (2.06%, meaningful), mean 2.70, 1★ 11","must-have","complaint"),
 (63,"#21 Executive-function difficulty, no diagnosis named","audience","Executive-function difficulty without a named diagnosis","24 (1.83%, meaningful), mean 4.67, 5★ 20","do","praise"),
 (64,"#22 Calendar (mention / integration ask)","feature","Calendar mention / integration ask","22 (1.68%, meaningful), mean 3.68","undecided","mixed"),
 (65,"#23 Trial discussed","monetization","Trial discussed — net negative","21 (1.60%, meaningful), mean 2.62, 1★ 10","research","complaint"),
 (66,"#24 Localisation request","market","Localisation request","21 (1.60%, meaningful), mean 3.90","do","complaint"),
 (67,"#25 Apple Watch (mention)","feature","Apple Watch mentioned — positively","21 (1.60%, meaningful), mean 4.48, 1★ 0","build-paid","praise"),
 (68,"#26 Support / developer responsiveness","do","Support / developer responsiveness","20 (1.53%, meaningful), mean 4.10","do","mixed"),
 (69,"#27 Free cap actively defended","insight","Free cap actively defended","19 (1.45%, meaningful), mean 4.32","undecided","praise"),
 (70,"#28 'Life-changing' / major life outcome claimed","insight","'Life-changing' / major life outcome claimed","19 (1.45%, meaningful), mean 4.84, 1★ 0","none","praise"),
 (71,"#29 Timer praised","feature","Built-in timer praised","15 (1.15%, meaningful), mean 4.60","build-free","praise"),
 (72,"#30 Sync between devices failing","must-never-break","Sync between devices failing","14 (1.07%, meaningful), mean 3.29","must-never-break","complaint"),
 (73,"#31 Data loss / reset","must-never-break","Data loss / reset","12 (0.92%, emerging), mean 3.00","must-never-break","complaint"),
 (74,"#32 Wants reorder / order resets itself","feature","Wants reorder / order resets itself","11 (0.84%, emerging), mean 3.55","free","mixed"),
 (75,"#33 Lag / slowness","must-never-break","Lag / slowness","10 (0.76%, emerging), mean 3.80","must-never-break","complaint"),
 (76,"#34 Wants one-off, non-repeating tasks","feature","Wants one-off, non-repeating tasks","10 (0.76%, emerging), mean 3.90","research","complaint"),
 (77,"#35 Wants friends / accountability / leaderboard","feature","Wants friends / accountability / leaderboard — from fans","10 (0.76%, emerging), mean 4.80, 5★ 8","research","complaint"),
 (78,"#36 Apple Health data wrong / incomplete","must-never-break","Apple Health data wrong / incomplete","9 (0.69%, emerging), mean 3.33","must-never-break","complaint"),
 (79,"#37 Already paid, asked to pay again","must-never-break","Already paid, asked to pay again","8 (0.61%, emerging), mean 1.50, 5★ 0, 1★ 5","must-never-break","1★-burst"),
 (80,"#38 Statistics weak / unreadable","feature","Statistics weak / unreadable","8 (0.61%, emerging), mean 4.00","undecided","mixed"),
 (81,"#39 Review prompt fired before use","dont","Review prompt fired before use","8 (0.61%, emerging), mean 2.00, 1★ 5","dont","complaint"),
 (82,"#40 Mac / desktop / Vision Pro","feature","Mac / desktop / Vision Pro","8 (0.61%, emerging), mean 4.00","undecided","mixed"),
 (83,"#41 Over-achievement / carry-over behaviour wrong","must-never-break","Over-achievement / carry-over behaviour wrong","7 (0.53%, emerging), mean 3.29","must-never-break","mixed"),
 (84,"#42 Wants notes / journal / mood field","feature","Wants notes / journal / mood field","7 (0.53%, emerging), mean 4.43","free","complaint"),
 (85,"#43 Wants long-term goals above habits","feature","Wants long-term goals above habits","7 (0.53%, emerging), mean 4.71","research","complaint"),
]
for seq, w, kind, claim, mag, d, react in T:
    c(seq, f"§3.1 theme table {w}", kind, claim, "see §3.1", react, mag, d, "theme-table signal", "yes", [])
c(86, "§3.1 theme table #44–#52 weak rows", "data-caveat",
  "Weak rows: onboarding survey then immediate paywall 6 (0.46%, mean 1.17); statistics paywalled named 5 (0.38%, 1.40); editing gated 5 (0.38%, 1.20); privacy/tracking 4 (0.31%, 3.00); archive loses history 4 (0.31%, 3.75); wants Android/Windows 3 (0.23%, 4.67); arrived via clinician 3 (0.23%, 4.67); export/CSV inadequate 3 (0.23%, 4.33); notifications wrong/absent 3 (0.23%, 3.00)", "see §3.1", "mixed", "9 weak rows as listed", "none", "weak", "yes", [])
c(87, "§3.1 #44 Onboarding survey then immediate paywall — mean 1.17, 83.3% 1★: the whole first-run experience is spent, then gated", "anti-pattern",
  "An onboarding survey followed by an immediate paywall — the whole first-run experience is spent, then gated", "survey → paywall", "1★-burst", "6 (0.46%, weak), mean 1.17, 83.3% 1★", "dont", "weak, lowest mean", "yes", [])
c(88, "§3.1 Below-threshold themes recorded — AI (1), accessibility (0), family sharing (1), Shortcuts gaps (1); six reviewers volunteer 'show me ads instead' of a paywall", "data-caveat",
  "Looked for and not found: AI expectations (1), accessibility beyond neurodivergence (0), family sharing (1), Shortcuts gaps (1); notably, ads-as-alternative-to-paywall is requested rather than complained about — six reviewers volunteer 'show me ads instead'", "no ads", "mixed", "6 'show me ads instead' reviews", "research", "below threshold", "yes",
  ["13516169817","12263453452","13009063073","12903710049","13065644863","14122841864","13607579176","11913092460","10569395314"])
c(89, "§3.2 Worst rating profile table (verbatim) — every one of the twelve worst-rated themes is monetisation-mechanics or reliability; no feature gap appears", "insight",
  "The twelve worst-rated themes (n ≥ 8): survey→paywall 1.17; editing gated 1.20; statistics paywalled 1.40; already paid asked again 1.50; billing dispute 1.59; launch blocker 1.63; price objection 1.76; upsell pop-ups 1.80; general paywall 2.01; free cap 2.13; trial 2.62; confusing UX 2.70 — every one is monetisation-mechanics or reliability; no feature gap appears; that is where the rating risk lives",
  "n/a", "1★-burst", table("## 3.2 The findings with the worst rating profile"), "product-rule", "corpus-level fact", "yes", [])
c(90, "§3.3 Reading the price objection correctly (verbatim table) — ~31 'can't evaluate on 3 habits', ~12 'too high for category', ~8 'cannot afford', ~7 'make it a paid app instead of fake-free', ~5 'self-improvement should be free'", "insight",
  "The 55 price objections split by argument: ~31 'I can't evaluate it on 3 habits' (a gate objection), ~12 'too high for this category' ('£25 for a basic box checker'; 'an app you could build yourself in a few days'), ~8 'I cannot afford it' (a student, a child, 'no está diseñado para personas con bajo presupuesto'), ~7 'make it a paid app instead of fake-free', ~5 'self-improvement should be free'",
  "n/a", "complaint", table("Separating the 55 price-objection reviews by what they actually argue:"), "product-rule", "qualitative split", "yes",
  ["13392619767","13557314925","13927978729","12384352203","12609243324","11676088428","14483086667","13681645142","12407220130","13567924370","14244904942","13405360163","12428670326","12993678135","12709066735","13723968661","14193180633","14239812567","13734318899","14218926067","13897905905","12085816881","14509705008","12113656689","11917804472","12347768247","13386578145"])
c(91, "§3.3 'Make it a paid app instead of fake-free' — ~7 reviewers would rather pay up front than meet a disguised paywall", "monetization",
  "About seven reviewers ask for the app to be paid up front instead of 'fake-free' — an honest paid listing is preferred to a free download that gates at habit four", "free download, gated at 4", "blocked-conversion", "~7 of 55", "research", "qualitative", "yes",
  ["13734318899","14218926067","13897905905","12085816881","14509705008"])
c(92, "§3.3 Against the 55 sit 64 praising the price ('por menos de 30 euros la tienes de por vida'; 'Premium is 1000% worth it') and 19 defending the cap ('helps me to only keep track of what is the most important')", "monetization",
  "64 reviews (4.89%, mean 4.31) praise the price — 'less than 30 euros for life', 'for as little as 2.30 euros', 'Premium is 1000% worth it' — and 19 (1.45%) defend the cap itself: 'I don't mind the limit of only 3 habits since it helps me to only keep track of what is the most important to me'",
  "price fair; cap defended by some", "praise", "64 (4.89%), mean 4.31; 19 (1.45%)", "build-paid", "very strong", "yes",
  ["12348445268","11694650718","13963611699","12651898098","10960460814","11592867713","12488599791","12299954486","11391330335","10380895839"])
c(93, "§3.3 Interpretation — price level and fairness are net positives; the paywall's position (habit 4, before any statistics, editing gated) is the liability; do not conclude 'lower the price'", "product-rule",
  "Price level and price fairness are net positives for this product; the paywall's position — at habit 4, before any statistics, with editing also gated — is the liability; a reader should not conclude 'lower the price'", "gate placement, not price", "mixed", "64 praise vs 55 object; ~31 of 55 are gate objections", "product-rule", "interpretation", "yes", [])
c(94, "§3.4 What the product does well (verbatim table) — configurability without bloat; feels like a first-party Apple app; ecosystem coverage; timer past goal; flexible scheduling primitives; motivating stats (paid); good and bad habits in one model; responsive developer; real-world outcomes", "data-caveat",
  "Strengths: configurability without bloat (65, mean 4.49); feels like a first-party Apple app ('went back to check if the app was made by apple'); iPhone+iPad+Watch+Mac+widgets+Shortcuts+Health coverage (3.97–4.48); the timer that keeps counting past the goal (15, 4.60); flexible scheduling primitives — every N days ('the ONLY APP I've found'), N×/week, skip, vacation, custom day start for shift workers; motivating statistics once paid ('I can visually see what my weakest days of the week are'); good and bad habits in one model; responsive solo developer (20, 4.10); measurable outcomes claimed (19, 4.84 — 45 kg lost over 8 months, recovery from depression)",
  "n/a", "praise", table("## 3.4 What the product genuinely does well"), "do", "corpus-level fact", "yes",
  ["11694650718","12584418650","12652539241","13467469049","12454642037","12592966841","11543202644","11656905076","12191332041","12752790900","10653626434","11687820487","12539663591","13197146903","13905166366","10346042202","12889328356","12615038002","12659238964","13811962013","10468572229","12404912935","13601387355","10381805436","12510281974","13605094837","14070420374","13848909054","14308003772","12627746599","13751037946"])
c(95, "§3.4 Feels like a first-party Apple app ('went back to check if the app was made by apple'; ''Apple' design all over it')", "positioning",
  "Reviewers say the app feels first-party — 'went back to check if the app was made by apple'; ''Apple' design all over it'", "native Apple design language", "praise", "4 named reviews", "do", "qualitative", "yes",
  ["11543202644","11656905076","12191332041","12752790900"])
c(96, "§3.4 Flexible scheduling primitives — every-3-days reminder 'the ONLY APP I've found'; custom day start for shift workers; vacation mode", "feature",
  "Flexible scheduling primitives are a stated reason to choose the app: an every-N-days reminder ('the ONLY APP I've found'), N×/week, skip, vacation mode and a custom day-start time for shift workers", "every-N-days, custom day start, vacation", "praise", "4 named reviews", "must-have", "qualitative", "yes",
  ["12615038002","12659238964","13811962013","10468572229"])
c(97, "§3.4 Measurable real-world outcomes claimed — 45 kg lost over 8 months; recovery from depression", "insight",
  "Reviewers claim measurable outcomes — 45 kg lost over eight months, recovery from depression — at the highest mean of any theme", "n/a", "praise", "19 (1.45%), mean 4.84, 0 1★", "none", "meaningful", "yes",
  ["13848909054","14308003772","11694650718","12627746599","13751037946"])
c(98, "§3.5 Requests table (verbatim) — clock time 29; one-off tasks 10; friends/leaderboard 10; notes/mood 7; long-term goals 7; every-N-minutes 4; hour-by-hour agenda 4; Android/Windows 3; screen-time-linked habits 3; landscape 1", "data-caveat",
  "Requests (capability does not exist): per-habit clock time + notification 29 (2.22%); one-off tasks / to-do tab 10; friends/accountability/leaderboard 10; notes/journal/mood 7; long-term goals above habits 7; intra-day every-N-minutes reminder 4; hour-by-hour agenda 4; Android/Windows 3; screen-time-linked habits 3; landscape 1",
  "n/a", "complaint", table("**Requests (the capability does not exist):**"), "none", "corpus-level fact", "yes",
  ["12608048200","13995532158","12042009982","12205846471","12206675017","12478039620","13085696025","13095424176","13162425122","13581933240","14044102396","14331081664","11419872344","11680828081","12022893185","12124549306","14092271366","14225345969","12352612203","10546108041","10547933356","11557982016","13716543684","13735539068","14139271437","11656905076","12008425939","12605136142","12617239758","13674254597","13758062522","12904899932","13256668642","11154294245","11965539196","13739990490","14000988461"])
c(99, "§3.5 Long-term goals sitting above habits — requested by very satisfied users (mean 4.71)", "feature",
  "A layer of long-term goals sitting above habits is requested by very satisfied users", "habits only, no goal layer", "complaint", "7 (0.53%, emerging), mean 4.71", "research", "emerging", "yes",
  ["11656905076","12008425939","12605136142","12617239758","13674254597","13758062522"])
c(100, "§3.5 Screen-time-linked habits — a habit that reads device screen time", "feature", "Three reviewers want habits linked to Screen Time", "absent", "complaint", "3 (0.23%, weak)", "research", "weak", "yes", ["11154294245","11965539196","13739990490"])
c(101, "§3.5 Broken table (verbatim) — sync not updating 14; data loss 12; order resets 5; Health values wrong 9 (steps off by 568, weight read as entry-count); widget stopped/not interactive/font fixed 6; archive/delete destroys history 4; over-achievement carries over / rewards a bad habit at 200% 7; Watch removed/limited/advertised but not installable 5; notifications 3; Vision Pro withdrawn 1", "must-never-break",
  "Broken existing capabilities: cross-device sync not updating (14, 1.07%); data loss / reset to zero (12); habit/group order resets itself (5); Apple Health values wrong — steps off by 568, weight read as an entry-count, running only in minutes (9); widget stopped working / not interactive / font fixed (6); archive/delete destroys history (4); over-achievement carries into the next day or rewards a bad habit at 200% (7); Watch app removed / limited / date lags / advertised on the listing but not installable (5); notifications wrong or silent (3); Vision Pro support withdrawn (1)",
  "n/a", "complaint", table("**Broken existing capabilities (the feature exists and misbehaves):**"), "must-never-break", "corpus-level fact", "yes",
  ["10774713901","11451647276","12127905359","13766076691","14443285061","14051521559","11792724852","12184884069","12611547585","13602107796","13605590169","13957262391","14283671611","14422160795","12657367016","12658607281","12762998535","13346806948","11278083369","13502878041","12918071192","12158005240","13925995344","11154294245","11845505516","11841522005","11504006411","13410996727","12377678039","12030551048","10971903648","12201042880","12697696657","14074498392","12778092747","14277782327","13195716771","11066420925","13316944137","12013649134","12659238964","14051521559","12865760230","12575813099","12580317312","12720268465","13531929434"])
c(102, "§3.5 Over-achievement carries into the next day / a bad habit logged at 200% is rewarded", "must-never-break",
  "Over-achievement carries into the next day, and logging a bad habit at 200% is rewarded as success — the carry-over and bad-habit arithmetic are wrong", "carry-over arithmetic wrong", "complaint", "7 (0.53%, emerging), mean 3.29", "must-never-break", "emerging", "yes",
  ["14074498392","12778092747","14277782327","13195716771","11066420925"])
c(103, "§3.5 Apple Watch advertised on the listing but not installable; Watch app removed / limited; Vision Pro support withdrawn", "must-never-break",
  "The Watch app was reported removed or limited, advertised on the listing but not installable, and Vision Pro support was withdrawn", "platform surfaces withdrawn", "complaint", "5 (0.38%) + 1", "must-never-break", "weak", "yes",
  ["13316944137","12013649134","12659238964","14051521559","12865760230","13531929434"])
c(104, "§3.5 Misunderstandings worth designing against — how to structure a bad habit ('smoked' or 'didn't smoke'), pinning a weekly habit to a day, stopping a repeat, iOS-only, currency of the price", "insight",
  "Product-comprehension failures worth designing against: how bad-habit logging should be structured ('smoked' or 'didn't smoke'), whether a weekly habit can be pinned to a chosen day, how to stop a task repeating, whether the app is iOS-only, and the currency of the displayed price", "n/a", "complaint", "5 clusters", "must-have", "qualitative", "yes",
  ["12778092747","11312965919","12201453432","12549275458","13688911525","12319455814","13290152980","14164700184"])
c(105, "§3.6 Competitors named table (verbatim) — Streaks 6 (outgrew), Habitify 4 (cluttered / no widget completion), Habitica 3 (became work), Strides 3 (dull, weak sound), Done 2 (buggy), HabitKit/Ripples 2 (better heat-map widget), Me+ 1, Tiimo 1 (calendar import), Apple Reminders/Health/Notes/paper ~9 as the free alternative", "positioning",
  "Competitors named (37, 2.83%), almost all as the app they left: Streaks 6 (outgrew it), Habitify 4 (too cluttered / no widget completion), Habitica 3 (over-complex, became work), Strides 3 (dull colours, weak sound), Done 2 (became buggy), HabitKit/Ripples 2 (better heat-map widget), Me+ 1, Tiimo 1 (better calendar import), Apple Reminders/Health/Notes/paper ~9 as the free alternative in paywall complaints",
  "n/a", "mixed", table("## 3.6 Competitors named in the corpus"), "do", "meaningful", "yes",
  ["11424393777","11432101846","13516169817","10468572229","10545731685","12778092747","12357300364","12715120271","14139271437","12617239758","12427277456","11055146979","12904899932","11735599652","11839202129","12405675497","13731487622","13291399300","13759652099","14486983673"])
c(106, "§3.6 Two distinct competitive statements — payers compare other habit apps and Grit wins on configurability; paywall-hitters compare Apple's free apps and a paper notebook", "positioning",
  "Two competitive frames: among people who paid or intended to, the comparison set is other habit apps and Grit wins on configurability; among people who hit the paywall, the comparison set is Apple's own free apps and a paper notebook — a far harder frame (nine reviews make it explicitly)", "n/a", "mixed", "9 free-alternative comparisons", "do", "interpretation", "yes", [])

with open("Tools/prd_ledger/25/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
