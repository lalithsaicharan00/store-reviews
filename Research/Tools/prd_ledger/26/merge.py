"""Stage 3 merge for report 26."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C236","product-rule","A free-tier limit must announce itself — never silently stop a visible progress signal","Report 26: the free tier lets the garden grow to ~17% and then silently stops; 50 verified reviews (1.30%, mean 2.96) report the flower 'not growing', 17 of them naming the same 17% across April 2022 → December 2025, filed as 'Glitches 🙄', 'Bug', 'Fake Flowers' — several learned only from support that it was intentional. Users conclude the app is broken and say so publicly. A one-line in-app explanation at the moment the ceiling is hit converts a 1–3★ 'it's broken' review into a legible upgrade prompt — the cheapest high-value fix in the corpus.")
add("C237","must-have","The reward loop needs a content runway — finite gardens, themes or levels exhaust long-term users","Report 26: garden-motivation praise declined monotonically 7.93% → 8.41% → 5.65% → 5.03% → 3.76% across five years while aesthetic praise strengthened, and reviewers report running out of gardens ('when I grew all the gardens, there is nothing to do'; 'YOU NEED MORE GARDEN DESIGNS!!'; 'I'll get bored if more aren't added'). For a product whose entire retention mechanism is the garden this is the most strategically important soft signal; per-habit gardens would also soften the all-or-nothing rule.")
add("C238","research","A rewarded-ad unlock path for users who cannot pay (teens, students)","Report 26: teens and students (25, mean 4.16; ages 10–21) cannot pay and say so, and three independently ask to watch ads instead ('I will watch ads all day long if I have to'); report 25: six reviewers volunteer 'show me ads instead' of a paywall. Demand exists in a segment converting at zero — but it conflicts with the reviews that praise having no ads (report 26: 7 at mean 5.00), so it is research, not a decision.")

ext("C007", " Report 26: a free cap of 3→5→6 habits plus a garden that stops growing at 17% — monetisation gating is 11.36% of reviews (57.8% of all 1★, 21.2% of substantive reviews) while price objection is only 0.76%; 57 defend the price and 45 call the free tier generous; the cap is the single most common reason for withholding the fifth star (47 of 535 4★: 'amazing app, but you can only add 5'); ADHD users who praise the simplicity say five slots cannot hold a morning routine.")
ext("C147", " Report 26: an evaluation-window problem, not a pricing problem — 'You get about 5 days free to make one flower then you have to pay'; 'the flower stops growing once you reach 17%, which I finished in about 2 weeks'; a user writes the hypothesis: give one garden free 'and that would probably get me intrigued enough to get a subscription'; proposed tests: time-boxed full access, cap 8–10, or one garden to 100%.")
ext("C133", " Report 26: the gate sits on quantity (habit count) and on the visible reward (growth stops at 17%) rather than on capability; extra gardens, themes and 'no wither' mode are the paid layer that users accept.")
ext("C216", " Report 26: the garden only grows if every habit is checked that day — 'If I miss only one out of 6 of my habits, nothing happens. Behaviourally this means people will say it's not worth trying'; 'doing 90% should be rewarded'; 'No room for off days… I'm human' (20 verified, mean 2.80) — while 25 (mean 4.76) praise the app for being gentle and streak-free; partial credit as a setting reconciles the two.")
ext("C201", " Report 26: partial completion earns nothing (all-or-nothing garden growth, 20 reviews, mean 2.80); ship partial credit as a setting, with full completion still rewarded more — the existing 'no wither' option is the precedent.")
ext("C157", " Report 26: a 'no wither' / Zen mode (the garden does not decay) exists as a premium option; gentleness and no streaks are praised at mean 4.76 and the mental-health segment (32, mean 4.66 — 'this app helped me fix my severe depression') is the clearest argument against any harsher rule.")
ext("C095", " Report 26: 'accountability and motivation without the shame' — gentleness, no streaks and a calm garden metaphor are the moat (25, mean 4.76; mental-health users 32, mean 4.66).")
ext("C006", " Report 26: an aesthetics-and-calm product whose four largest themes are design (27.83%, mean 4.64), music/ambience (14.57%), simplicity (10.71%) and the garden metaphor (5.97%), stable across five years — 'A lot of apps in this area are too busy… This app is like a warm hug'; ADHD users say every other routine app 'has been deleted within a day because it's too complicated'; keep new configuration behind an advanced toggle.")
ext("C057", " Report 26: reviewers convert on beauty within minutes of install ('I bought premium within the first couple minutes of downloading'; 'as soon as I saw the visuals and music I bought premium') — aesthetic is the mechanism, not decoration, and 'It's not just an app it's a piece of art'.")
ext("C185", " Report 26: Eden converts on beauty and on the absence of a subscription, fast, often before the user has evaluated the functionality — which explains both high purchase velocity and payers rating a full point below the corpus (3.56 vs 4.570): 'I bought this one a little too soon I think'.")
ext("C116", " Report 26: background music and nature sounds (559, 14.57%, mean 4.68), daily quotes (58, mean 4.74), themes, backgrounds, seasons, app icons and extra gardens are the content layer — partly free, more paid.")
ext("C094", " Report 26: the app rewards a review with a cosmetic unlock and 13 reviewers say so ('I'm just doing this to get the backgrounds 😋 I haven't even used the app at all'; '(I'm NOT a bot btw)'); ≤25-character reviews rose from 16.5% to 35.0% of the corpus, 83–91% of them 5★; true inflation is unmeasurable and there is App Store policy exposure.")
ext("C054", " Report 26: a review-for-cosmetic-unlock reward produced reviewers who volunteer they have not used the app; the ≤25-char 5★ tier doubled to ~35% of the corpus.")
ext("C186", " Report 26: the late-2022 move from a $5–7 / €6.99 one-time unlock to $25 lifetime / $19.99 yr / $4.99 mo withdrew the unlock earlier buyers had paid for — 'the premium version I bought was taken away from me… I consider that a breach of contract' (7 in Sept–Oct 2022, recurring in 2024–25); losing what they bought is the top paid-user complaint (16.7% of explicit payers).")
ext("C003", " Report 26: one-time pricing is a repeatedly praised differentiator in a calm-aesthetic tracker — 57 (mean 4.18) defend the price, most because it is not a subscription, and 11 name it as the purchase trigger; the lifetime option survived the 2022 restructure ($25) but rose to €40 by 2026.")
ext("C004", " Report 26: lifetime moved $5–7 (2021) → $25 (late 2022) → €40 (2026) — roughly 5× — while price objection stayed the smallest of the four monetisation objections (29, 0.76%); the €40 point 'risks spending' goodwill.")
ext("C064", " Report 26: price objection 29 (0.76%, mean 2.76) vs 57 defending the price — 2:1 in favour; high-spend markets (de 19.83%, fr 20.37%, au 18.52%, ca 15.60% friction) are where price-defence arguments are also most articulate.")
ext("C033", " Report 26: purchase lost or not delivered is the top paid-user failure (24, 0.63%; 12 of 72 explicit payers = 16.7%) by three mechanisms — the 2022 repricing withdrew a purchased unlock, restore-purchases fails or the button is dead, payment succeeded but premium never activated.")
ext("C035", " Report 26: no account system anywhere in the corpus — a device change, a reinstall, or support's own advice to reinstall destroys both progress and entitlement ('It also deletes the purchase price of the app if you bought it as there is no account to sign into'); absent accounts every other entitlement bug is unrecoverable — the root cause behind the top paid-user complaint.")
ext("C034", " Report 26: with no account or sync, a support-recommended reinstall deleted 'all the lovely growth you have achieved' along with the purchase.")
ext("C109", " Report 26: a '3-day free trial' that charges immediately (incl. a lifetime tier charged instantly with no trial disclosed), cancelled before trial end and charged anyway, renewal with no notice — 23 disputes at mean 1.48, the lowest-rated theme in the corpus, and the source of the only accusations of deception ('Scam company. Impossible to cancel and tricks you into renewing'; 'Estafadores').")
ext("C112", " Report 26: two reviewers could not find any way to unsubscribe; 'well hidden there is a way to contact support… but the button is not enabled'.")
ext("C221", " Report 26: renewal with no advance notice (2) inside the lowest-rated theme.")
ext("C026", " Report 26: 16 reviews (mean 4.06 — willing buyers, not complaints) cannot pay — 8 Russian ('the trial button is not clickable… possibly because I live in Russia'; cards cannot be linked), 3 Chinese/Taiwanese ('tap subscribe and nothing happens'; a ¥38 tier shown with no in-app path), 2 Vietnamese (ShopeePay / MoMo requested); Russia is 19.18% of the corpus and its highest-satisfaction market — the highest-yield-per-effort monetisation item.")
ext("C062", " Report 26 (the reverse pattern): the high-spend markets (us, gb, de, fr, ca, au = 40.84%) rate lowest (4.489 vs 4.626) and complain most about the paywall (15.3% vs 8.7%; cap 6.2% vs 2.2%) — the free-tier design is costing most where the money is; Russia (19.18%, mean 4.697, 85.3% 5★) and Brazil (4.663) are the happiest markets.")
ext("C231", " Report 26: Germany (63.6% 5★, 19.83% friction), France (20.37%), Australia (18.52%) and Canada (cap 10.09%) vs Russia (85.3% 5★, 7.34% friction) and Vietnam (86.8%, 5.15%) on the same product — though Russia's low friction may be a payment-availability effect: if users cannot reach the paywall, low friction is not satisfaction.")
ext("C031", " Report 26: crash/launch failure fell 3.37% (2021–22) → 0.13% (2024) after a visible engineering turnaround, then a 2026 cluster (n=4, three Russian, two paying — a premium subscriber crashing on the onboarding screen after reinstall) flagged for telemetry.")
ext("C059", " Report 26: a visible 2024 engineering turnaround — crashes 3.37% → 0.13%, the 'music can't be turned off' bug 2.88% → 0.00%, mean 4.339 → 4.675 — with the substantive-only mean rising too; a reviewer thanked the team for adding a calendar; Russian localisation criticised in 2023 was praised by 2025.")
ext("C175", " Report 26: the 2022 'music cannot be turned off' defect (10 reviews, May–Nov 2022) was fixed and stayed fixed — a clean, closed defect; the later inverse (music won't play) is 3 reviews.")
ext("C012", " Report 26: statistics/history/calendar per habit was the top unmet need (40, 1.04% — 'this is a cosmetic habit tracker, it does not offer really understanding of progress'), something shipped ~late 2024, and the rate returned to 4.26% of substantive 2026 reviews because it is hard to find and stats cannot be reset.")
ext("C142", " Report 26: a calendar/statistics view shipped ~late 2024 and users still cannot find it ('the calendar could be more easily accessible, I currently have to search for it') — a cheap discoverability fix on built functionality.")
ext("C010", " Report 26: backfill the previous day and a configurable day boundary (29 verified, 0.76%) — night-owl and after-midnight complaints recur across five years; a next-day 'did you do it?' prompt exists and is praised.")
ext("C170", " Report 26: a user-set day boundary requested alongside backfill (29); persistent across five years.")
ext("C043", " Report 26: flexible recurrence ('3× per week') and a vacation/pause mode ('exception periods' while travelling) requested by 12 (0.31%); only per-habit day-of-week scheduling exists.")
ext("C016", " Report 26: a vacation/pause mode is requested with flexible recurrence (12).")
ext("C143", " Report 26: multi-count per day (5 glasses of water, 10 pages) requested by 7.")
ext("C073", " Report 26: reorder habits / per-habit gardens / categories requested by 18 (0.47%).")
ext("C045", " Report 26: per-habit gardens or categories requested (18).")
ext("C203", " Report 26: onboarding offers preset-only habits and custom habits could not be created (8 verified, mean 2.50).")
ext("C023", " Report 26: an interactive widget to tick from the home screen requested (~5); the garden-view widget is free.")
ext("C009", " Report 26: a garden-view home-screen widget, reminders, a timer and day-of-week scheduling are free (21 widget mentions, mean 4.14).")
ext("C022", " Report 26: no Apple Watch app throughout; requested by 8 (0.21%).")
ext("C172", " Report 26: a journal / gratitude note requested (~4).")
ext("C171", " Report 26: a detailed, actionable VoiceOver defect report — images without alt text, focus loss, elements announced only as 'botão' — plus larger text and low-contrast reports; dynamic type was added and praised; promoted on inclusion/legal grounds at 5 reviews.")
ext("C042", " Report 26: ADHD/neurodivergent users (81, 2.11%, mean 3.84 — the lowest of any positively-framed segment) succeed because of simplicity and are hit hardest by the 5-habit cap; mental-health users (32, mean 4.66) are the highest-affect reviews; teens and students (25, ages 10–21, mean 4.16) cannot pay.")
ext("C103", " Report 26: users describing severe depression, being bedbound, three years clean and wartime anxiety ('This app helped me return to life') — the gentle, non-punitive frame is what serves them; children as young as 10 review the app.")
ext("C068", " Report 26: one reviewer bought it for an elderly parent and one for their children; ages 10–21 self-identify.")
ext("C027", " Report 26: localisation requests in Arabic, Thai and Spanish; Russian localisation quality criticised in 2023 ('hire a competent localiser') and praised by 2025; the German store listing carried a typo ('Gewohnheitstrinker' — habit drinker); Chinese reviewers ask for the community features of a discontinued app ('种子习惯'); the cn aesthetic rate of 3.12% is a classifier artefact.")
ext("C218", " Report 26: the German store listing carried a typo — 'Eden-Gewohnheitstrinker' (habit drinker) for 'Gewohnheitstracker'.")
ext("C051", " Report 26: Android asked about repeatedly (CN, FR, SE).")
ext("C015", " Report 26: eight Chinese reviewers ask for the community features of the discontinued '种子习惯' (Seed Habit) app.")
ext("C002", " Report 26: engineering fixes moved the corpus mean 4.34 → 4.68 while payer satisfaction stayed flat at ~3.5 for five years — the paid experience is set by entitlement and trial mechanics, not by product quality.")
ext("C065", " Report 26: explicit payers (72) rate a full point below the corpus (3.56 vs 4.570), flat across five years; their top problems are losing the purchase (16.7%) and paywall friction after paying (23.6%).")
ext("C036", " Report 26: support unreachable 13 (mean 2.77), support praised 10 (all 5★); support's own advice to reinstall destroyed a paying user's progress and purchase; a premium subscriber's crash went unanswered for months.")
ext("C061", " Report 26: 'bought premium right away just to support the developers'; 45 call the free tier generous (mean 4.49).")
ext("C082", " Report 26: three teens independently ask for a rewarded-ad path to extra habits ('I will watch ads all day long if I have to') while 7 reviews (mean 5.00) praise having no ads.")
ext("C089", " Report 26: China App Store shows a ¥38 tier with no in-app purchase path.")
ext("C222", " Report 26 (the reward side): the cap is 3→5→6 habits plus a growth ceiling; users who love the constraint-free gentleness still say five slots cannot hold a routine, and propose their own valve — one full garden free.")
ext("C005", " Report 26: reviewers compare against 'too busy', 'too technical', 'aggressively productive' trackers and choose calm; Chinese users compare to the discontinued 种子习惯.")
ext("C134", " Report 26: reviewers convert on the aesthetic within minutes — the listing's visuals and music are doing the selling; the German listing typo 'Gewohnheitstrinker' shows the listing is read closely.")

M = {
 "R26-003":["C094","C054"], "R26-004":["C094"], "R26-005":["C059"], "R26-006":["C006","C057","C095"], "R26-007":["C007","C147"], "R26-008":["C236","C133"],
 "R26-009":["C216","C201","C157"], "R26-010":["C059","C175","C031","C012"], "R26-011":["C033","C109","C112"], "R26-012":["C186","C004"], "R26-013":["C026","C062","C012"],
 "R26-014":["C012","C201","C010","C073","C043","C022","C143"], "R26-015":["C236","C201","C109","C033","C010","C147","C026","C171"], "R26-016":["C002"],
 "R26-019":["C007"], "R26-020":["C236","C133","C116"], "R26-021":["C116","C009"], "R26-022":["C116","C009"], "R26-023":["C009","C008","C066","C043"], "R26-024":["C157","C216"],
 "R26-025":["C012","C142"], "R26-026":["C035","C022"], "R26-027":["C004","C003","C186"], "R26-028":["C003","C004"],
 "R26-030":["C057","C006"], "R26-031":["C116"], "R26-032":["C006"], "R26-033":["C007","C147"], "R26-034":["C007"], "R26-035":["C024","C237"], "R26-036":["C007"], "R26-037":["C042"],
 "R26-038":["C065"], "R26-039":["C116"], "R26-040":["C003","C064"], "R26-041":["C236","C133"], "R26-042":["C236"], "R26-043":["C061","C110"], "R26-044":["C012"], "R26-045":["C031"],
 "R26-046":["C042","C103"], "R26-047":["C064"], "R26-048":["C010","C170"], "R26-049":["C095","C157"], "R26-050":["C042","C068"], "R26-051":["C033"], "R26-052":["C109","C029"],
 "R26-053":["C009"], "R26-054":["C216","C201"], "R26-055":["C073","C045"], "R26-056":["C175"], "R26-057":["C026"], "R26-058":["C043","C016"], "R26-059":["C094","C054"], "R26-060":["C036"],
 "R26-061":["C036"], "R26-062":["C203"], "R26-063":["C022"], "R26-064":["C143"], "R26-065":["C035"], "R26-066":["C171"],
 "R26-067":["C006","C057"], "R26-068":["C095","C157","C216"], "R26-069":["C007","C064"], "R26-070":["C147","C236","C007"], "R26-072":["C012"], "R26-073":["C010","C170"],
 "R26-074":["C073","C043","C143","C016"], "R26-075":["C023","C172"], "R26-076":["C171"], "R26-078":["C094","C007"], "R26-079":["C007"], "R26-080":["C012","C203"], "R26-081":["C007","C236"],
 "R26-082":["C109","C002"], "R26-084":["C065","C002"], "R26-085":["C065","C033"], "R26-086":["C033","C186"], "R26-087":["C035","C034"], "R26-088":["C057","C003","C061","C185"],
 "R26-089":["C185","C065"], "R26-090":["C026","C089"], "R26-091":["C109","C112","C221"],
 "R26-093":["C062","C026"], "R26-094":["C062","C231","C007"], "R26-095":["C027","C218","C051"], "R26-096":["C015","C027","C005"],
 "R26-097":["C042","C007","C006"], "R26-098":["C103","C157","C042"], "R26-099":["C238","C082","C042","C068"],
 "R26-101":["C002"], "R26-103":["C059","C002"], "R26-104":["C175","C059"], "R26-105":["C012","C142"], "R26-106":["C031"], "R26-107":["C002","C007"], "R26-108":["C237","C024"],
 "R26-109":["C236"], "R26-110":["C035","C033"], "R26-111":["C109","C112"], "R26-112":["C031"], "R26-113":["C026"], "R26-114":["C171"], "R26-115":["C142","C012"],
 "R26-116":["C147","C007"], "R26-117":["C201","C216"], "R26-118":["C010","C170"], "R26-119":["C237","C045"], "R26-120":["C043","C016"],
 "R26-122":["C094","C054"], "R26-123":["C186"], "R26-124":["C216","C157"], "R26-125":["C064","C062","C147"],
}
# unattached (nuance register): 001-002 header/method, 017 validation table, 018 inventory table, 029 theme table, 071 unmet-needs table,
# 077 ratings table, 083 rating/text mismatches, 092 country table, 100 era table, 102 substantive table, 121 research questions
cards = [json.loads(l) for l in open("Tools/prd_ledger/26/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/26/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
