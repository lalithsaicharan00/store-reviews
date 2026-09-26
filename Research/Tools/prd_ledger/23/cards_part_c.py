"""Cards for report 23 — Part 4 (core design bet) and Part 5 (ratings analysis)."""
import json, re
R = 23
rep = open("App Store Reports/23. Streaks - The habit-forming to-do list (REPORT).md").read().split("\n")
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

# ---- §4.1 capacity
c(117, "§4.1 Capacity by-year table (verbatim)", "timeline",
  "Capacity requests by year against the cap at the time: each cap increase produces a visible drop in the complaint rate (8.76% → 5.06% around the 12-task release; 11.90% → 6.16% around the 24-task release) that then partially rebounds; the rate never goes below ~6% — raising the cap works and is never sufficient",
  "cap raised twice", "complaint", table("**By year (denominator = that year's reviews):**") + " ; ratio asks:defends 5.3:1", "undecided", "high-priority", "yes", [])
c(118, "§4.1 What people want the extra slots for #1 — time-of-day segmentation", "feature",
  "Extra capacity is wanted for time-of-day segmentation: morning / work / evening / bedtime routines, one page each", "pages exist but capped", "complaint", "9 representative reviews", "undecided", "high-priority (sub-reason)", "yes",
  ["1420887296","2210300778","3628077362","5451202886","6744050161","8299170626","10431684079","13631874444","14265126334"])
c(119, "§4.1 #2 — life-domain segmentation", "feature",
  "Extra capacity is wanted for life-domain segmentation: health / work / relationships / creative", "absent grouping", "complaint", "6 representative reviews", "undecided", "high-priority (sub-reason)", "yes",
  ["1276552134","3401507494","4845782428","5860788478","9592334909","10655113870"])
c(120, "§4.1 #3 — graduated habits: keep tracking an automatic habit while starting a new one", "insight",
  "The single most persuasive argument for more capacity, made repeatedly: people want to keep tracking a habit that has become automatic while starting a new one — a 'graduated' state",
  "no graduated/automatic state; a mastered habit still occupies a slot", "complaint", "4 representative reviews; 'most persuasive argument in the corpus'", "undecided", "high-priority (sub-reason)", "yes",
  ["1417118522","4011854670","6522763838","10527629911"])
c(121, "§4.1 #4 — non-daily items eat daily slots", "feature",
  "A once-a-month or once-a-week habit consumes one of the 24 daily slots — non-daily items eat capacity", "non-daily habits count against the cap", "complaint", "5 representative reviews", "undecided", "high-priority (sub-reason)", "yes",
  ["1424093667","3480265806","5230479351","6050921044","10096479510"])
c(122, "§4.1 #5 — family / multi-person use: a child's chores alongside your own", "audience",
  "Extra capacity is wanted to track a child's chores alongside one's own — family/multi-person use inside one account", "no profiles", "complaint", "3 representative reviews", "research", "limited evidence", "yes",
  ["1784849811","11003956267","11316685590"])
c(123, "§4.1 Counter-evidence — defenders say the cap is the reason the app works; four-page structure segments the day", "insight",
  "The 118 defenders make a substantive argument: the cap is the reason the app works ('Limiting to only six … is a feature, not an area for improvement'); one credits the four-page structure with segmenting the day",
  "cap as feature", "praise", "118 (1.62%, meaningful)", "undecided", "meaningful", "yes",
  ["1223740791","1262758739","1324612441","1421300604","1509068759","3229553941","6819955202","10779334259","13400151593","13312978008"])
c(124, "§4.1 Product implication — the request and the defence are compatible: move the ceiling, not the default", "product-rule",
  "Nobody in the 620 asks for the default to change — they ask for the ceiling to move; the request and the defence are compatible if extra capacity is an opt-in that leaves the default untouched",
  "cap is a hard default", "mixed", "620 ask vs 118 defend", "product-rule", "interpretation", "yes", [])

# ---- §4.2 simplicity degrades
c(125, "§4.2 Simplicity is measurable and it degrades — E1 32.30% → E2 20.80% → E3 18.36%; UI confusion E1 0.69% → E2 4.93% → E3 5.33%", "timeline",
  "Simplicity praise as a share of the period's reviews fell E1 32.30% → E2 20.80% → E3 18.36% while UI-confusion complaints rose E1 0.69% → E2 4.93% → E3 5.33% — the property that produced 1,780 positive reviews is being spent one feature at a time to answer requests from a minority",
  "adds features over time (negative tasks, pages, sounds, themes, stats, timers, notes, AI)", "churn",
  "simplicity 32.30% → 20.80% → 18.36%; UI confusion 0.69% → 4.93% → 5.33%", "product-rule", "very strong", "yes", [])
c(126, "§4.2 v3.0 late July 2017 — reaction splits the same week: delighted vs alarmed at loss of simplicity", "timeline",
  "The v3.0 update (late Jul 2017: negative tasks, second page, sounds, themes, statistics) split reviewers the same week — delighted vs alarmed ('The new UI is confusing, annoying, inefficient… all in the service of aesthetics'; 'The great thing used to be having to pare down'; 'like they dipped a pickle in chocolate'); later waves repeat it in 2022 ('Feature overload ruined core functionality'), 2023 ('adding complexity for the sake of complexity') and 2025",
  "feature-expansion release", "mixed", "6 delighted, 6 alarmed cited at v3.0; 5 later-wave reviews 2022–2025", "product-rule", "very strong", "yes",
  ["1698329281","1700895077","1702216092","1708201423","1723164061","1762432110","1699860194","1704290647","1706842643","1708307755","1244333793","3554375156","8872999798","9132739356","9522443552","9974958402","12133468213"])

# ---- §4.3 three interactions
c(127, "§4.3 Three specific interactions carry the entire UX complaint (verbatim table)", "anti-pattern",
  "All 250 UI-confusion reviews resolve into three actions: deleting a task, editing/renaming/moving a task, and undoing an accidental completion — not diffuse, not architectural",
  "gesture-hidden delete/edit; shake-only undo", "complaint", "250 (3.44%), mean 2.66; undo 77 (1.06%)", "must-have", "very strong", "yes",
  ["1428576781","1736489826","3627060299","3813274742","3934184360","3969877398","4219370308","5503321016","5453294830","9212927813","13176889519","1347730758","3772828822","3821585068","3931904391","4515004865","8435327387","12670297933","13127255768","14243139067"])
c(128, "§4.3 The undo problem — shake gesture only; workaround is resetting all history", "must-have",
  "The only undo is a shake gesture available immediately after the action; reviewers across 12 storefronts call this unacceptable, and several report the only workaround is resetting all history",
  "shake-to-undo only, time-limited", "complaint", "77 (1.06%, meaningful), 12 storefronts; mean 3.38", "must-have", "meaningful", "yes",
  ["1215117154","1303004020","3934671711","5528374045","5652418303","6499306517","7060772966","7273743439","8879991437","9212927813","9893956395","10535886439","10912008189","12894788718","13171890468","14245262334","14391501375"])
c(129, "§4.3 Interpretation — these three actions are the entire gap between 4.19 and higher; one Edit/Delete/Undo affordance plus in-app text", "do",
  "A single visible 'Edit / Delete / Undo' affordance and an in-app text explanation would address the majority of 250 reviews carrying a 2.66 mean — the gap is not architectural",
  "hidden affordances", "complaint", "250 reviews, mean 2.66", "must-have", "interpretation", "yes", [])

# ---- §4.4 binary completion
c(130, "§4.4 Over-achievement is discarded — 'goal 30 minutes, read 90, it stops at 30'", "feature",
  "Over-achievement is discarded: a timed or counted goal stops recording at the target", "counts stop at goal", "complaint", "17 representative reviews within the 77", "undecided", "meaningful", "yes",
  ["1230386714","2749205687","6753878706","7249290170","7353753973","7622168499","8341383590","8847760481","10504293132","11851969749","11936906855","12190462519","12209604326","12750955556","13211973709","14106848070","14472714750"])
c(131, "§4.4 Partial progress is shown as failure — '6 of 8 glasses shows an ✗'", "feature",
  "Partial progress is shown as failure: 6 of 8 glasses renders as an ✗ on the calendar", "binary complete/incomplete", "complaint", "13 representative reviews within the 77", "undecided", "meaningful", "yes",
  ["1451333906","2547471027","6317641073","8112114156","8164065134","9227205533","9613837462","10204901614","10320667734","10914768023","12169314722","13566507177","11968580277"])
c(132, "§4.4 Why it matters psychologically — 'do 30 push-ups' breaks on a 25 day; 'push-ups per day' would record 25 and preserve momentum", "insight",
  "The most articulate statement of the psychology: a habit stated as 'do 30 push-ups' breaks on a 25-push-up day, whereas 'push-ups per day' would have recorded a 25 and preserved momentum; a jp 5★ review sets out five specific sub-requests",
  "binary model demotivates on near-miss days", "complaint", "2 named reviews; 2 of the 3 most-upvoted reviews in the corpus (313, 126 votes)", "undecided", "meaningful", "yes",
  ["11968580277","9592238918","9145507788","8642992805"])

# ---- §4.5 frequency & history
c(133, "§4.5 Frequency — shipped over time; still absent: yearly, arbitrary intervals (every 6 weeks / quarterly / 4–5-day shift rotation), specific dates of the month", "feature",
  "Frequency shipped incrementally (times-per-week late 2015, times-per-day 2016, times-per-month, every-N-days); still absent at the last review: yearly goals, arbitrary intervals such as every 6 weeks / quarterly / a Korean shift worker's 4–5-day rotation, and specific dates of the month",
  "partial frequency model", "complaint", "101 (1.39%, meaningful)", "must-have", "meaningful", "yes",
  ["1295254379","1450537959","5358836760","9436431103","10397702118","11891384654","12537226420","13735945699","11315859157","14320549167","9989040594","8577016754","9939580410","6914988991"])
c(134, "§4.5 History depth — statistics limited to current and previous month; year heat-map / GitHub grid most requested", "feature",
  "Statistics are limited to the current and previous month; the most-requested visualisation is a year heat-map / GitHub contribution grid",
  "two-month history depth", "complaint", "46 (0.63%, emerging)", "undecided", "emerging", "yes",
  ["1384736153","1463992819","1499824611","3911574614","8409036350","9579170708","10287328470","11032222087","13136255685","13611043861","13647744905","10674342410","6494025558","5393033193","13991866349"])

# ---- §5.1 5★
c(135, "§5.1 5★ drivers table (verbatim)", "data-caveat", "What 5★ reviewers say, denominator 4,586", "n/a", "praise", table("What 5★ reviewers actually say (denominator = 4,586):"), "none", "corpus-level fact", "app-specific",
  ["1258150191","1272281889","1298436176","1417122973","1264562226","1210218319","3650471870","1704396672","1458766203","7461351458","1712133587","1457647167"])
c(136, "§5.1 Notable — 5.5% of 5★ contain a capacity complaint and 2.9% a sync caveat: advocates telling it what to fix", "insight",
  "5.5% of 5★ reviews contain a capacity complaint and 2.9% a sync caveat — the app's advocates telling it what to fix; treating 5★ as unqualified approval would discard the highest-quality feedback in the corpus",
  "n/a", "mixed", "250 of 4,586 (5.5%) capacity; 132 (2.9%) sync; 133 (2.9%) 'changed my life' verbatim", "do", "corpus-level fact", "yes",
  ["1210218319","2008517387","5946603412","9474096582","12231562082","7461351458","8639765578","8746727569","10511894011"])
# ---- §5.2 4★
c(137, "§5.2 4★ is 'five stars minus the cap' — 207 reviews = 17.9% of 4★; a mechanically identifiable uplift block", "insight",
  "4★ is overwhelmingly 'five stars minus the cap': capacity is 17.9% of all 4★, just behind simplicity (20.2%), and dozens say so in the title ('Remove the limit and it gets 5 stars instead of 4') — a mechanically identifiable ~207-review block of ratings uplift from one change",
  "hard cap", "complaint", "207 of 1,154 4★ (17.9%); simplicity 233 (20.2%); other 4★: Watch 94 (8.1%), widget 74 (6.4%), sync 64 (5.5%), rewards 35 (3.0%), multiple-per-day 33 (2.9%), frequency 32 (2.8%)", "undecided", "meaningful", "yes",
  ["1230386714","1351860446","1417249455","2065457103","3624120327","4927142814","5365517703","7445407807","8975182976","12868795563"])
# ---- §5.3 3★
c(138, "§5.3 3★ is the 'beautiful but' band — capacity and design praise appear together", "insight",
  "3★ is 'beautiful but': capacity leads (17.3%) with design praise (16.4%) appearing together, then Watch, widget, sync and UX confusion",
  "n/a", "mixed", "n=538: capacity 93 (17.3%), design 88 (16.4%), Watch 75 (13.9%), widget 60 (11.2%), sync 57 (10.6%), UX 47 (8.7%)", "none", "corpus-level fact", "yes",
  ["1416743063","2076300664","3303247598","5348667492","6613034447","9522443552","10327827837","13180845529"])
# ---- §5.4 2★
c(139, "§5.4 2★ — UX and reliability overtake capacity", "insight",
  "2★ is where UX and reliability overtake capacity: non-standard interface, sync/data destruction, price/value mismatch, Watch failure, and the 'it's only a checklist' argument",
  "n/a", "complaint", "n=342 read in full", "none", "corpus-level fact", "yes",
  ["2256538710","2178770367","9176441512","11812335594","12995797717","8591937731","8657672267","9146983436","11738653741","13491181225","1307823162","2082928612","2074625050","12989179143","1928204873","8537067616","8846625627","12008652692","1922531600","8489597297","11243132812"])
# ---- §5.5 1★
c(140, "§5.5 1★ drivers table (verbatim)", "data-caveat", "What drives 1★, denominator 650", "n/a", "churn", table("## 5.5 1★ — n = 650 (8.94%)"), "must-never-break", "corpus-level fact", "app-specific",
  ["1823336677","1869849987","5132838929","5982716099","7429308564" if False else "7429308689","8378091564","10788221893","12697390401","1772778535","3317081904","3339756991","12001043575","12377981887","13940202198","1213415787","3979151493","4592779297","7199898184","10383442127","1369851749","1384399238","3658903640","5846397266","12696000566","1228688696","1315739671","1844808692","7174509755","11450516665","12692528270","1222021317","3463334680","7060873731","9540311476","5656583902","8539670819","8789907313","11200491931","11379255315","13404336916","1756115186","6984267893","6995147748","9387245377","9618815433","11300138584","13684634678","2045708512","2304429841","2378622100","6473643467","9198217952"])
c(141, "§5.5 The 'no value / it's just a reminder' argument — a positioning failure, not a product failure", "positioning",
  "68 one-star reviews make a coherent, non-frivolous case: this is a checklist, iOS Reminders does it free, and it cost me money — a positioning failure: the listing does not set the expectation that the value is streak psychology plus HealthKit automation, not the checklist",
  "listing sells a checklist", "complaint", "68 of 650 1★ (10.5%; 0.94% of corpus, emerging)", "do", "emerging", "yes",
  ["1358168074","3606167716","5393057080","8489597297","11243132812","12687610729","10919386441","11277169610","12133468213"])
# ---- §5.6
c(142, "§5.6 Themes that cut across the rating line (verbatim table)", "data-caveat",
  "Capacity (40.3% 5★ / 6.9% 1★) is a request not a grievance; Watch (52.7/12.1) and widget (42.1/8.2) are bimodal — the best and worst experiences share a surface; sync (37.9/16.1) tilts negative but many 5★ flag it as a caveat; rewards (61.8/1.5) and record-beyond-goal (39.0/3.9) are purely aspirational from fans; UI confusion (18.4/31.6), price objection (13.8/50.4) and refund (13.9/70.9) are almost purely destructive",
  "n/a", "mixed", table("## 5.6 Themes that cut across the rating line"), "none", "corpus-level fact", "yes", [])

with open("Tools/prd_ledger/23/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
