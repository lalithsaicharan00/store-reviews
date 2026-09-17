"""Stage 3 merge for report 36."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C253", "do", "Notification restraint — few, finely controllable notifications keep the users that spammy rivals lose",
    "Report 36: notification restraint is praised by 12 (2.22%, mean 4.67) and framed as the reason people switched — 'fine-tuned control over the notifications you receive — probably the #1 reason I've deleted other habit apps was that they spammed me with a billion distracting notifications' (13967987039); a US talking point (3.97% vs 0.69% non-US). More / snoozable reminders are also requested (7) — make any escalation opt-in so the restraint is not lost.")
add("C254", "must-have", "An all-habits overview with one-tap check-off — never force one-habit-at-a-time navigation",
    "Report 36: a full-screen one-habit canvas with names in a small strip at the top produced 27 distinct navigation complaints (5.00%, mean 3.56, mostly 4–5★), asked continuously from Dec 2021 to Apr 2026 (one review 45 helpful votes): the centre check button swallows horizontal swipes, the strip is 'quite a reach', and it gets worse with more habits — i.e. for the paying user ('I have to swipe through 16 habits. That alone is enough for me to not want to use this app anymore'); 12 ask for 'a consolidated list / calendar view of all of your habits' to 'check or uncheck' on one page. A Dec 2025 partial fix was praised the same week, but complaints continued.")

ext("C001", " Report 36: the same retraction was run twice — widgets moved behind the paywall ~4 Oct 2023 (three 1★ from us / eg / in inside 36 hours: 'Tap to Unlock … I am deleting the widget and the app'; 2023 H2 mean 3.56) and unlimited free habits capped at 2 (Dec 2025) then 1 (Mar 2026) — CAP 30 (mean 2.30, 26.9% of E5), REGRESS 19 (mean 1.95, zero 5★): 'Never expect rewards for loyalty … 3 years and all my history is on there'; 'Bait and switch'. 2026 mean 3.636 with 27.3% 1–2★ vs 2024 4.312 / 9.9%, while usability complaints were at their lowest; the report's policy: if a tier must change, change it for new users only.")
ext("C002", " Report 36: E5's rating collapse (3.722, 25.0% 1–2★) coincides with monetisation friction more than doubling (16.9% → 37.0%) while usability complaints halved (12.0% → 6.5%) and design praise fell 32.5% → 13.9% — 'the product did not get worse; the offer did'.")
ext("C003", " Report 36: subscription-only for 4.7 years — SUB- 35 (6.48%, mean 2.60, ~6% every era) and ONETIME 24 (4.44%, mean 3.42, only one 1★), volunteering £5, $20–30, €5–7.99, ¥50 and ~$100 ('I would be more than happy to pay for it outright, but that is not an option. So, I'm not gonna be paying anything at all'); a ¥398 one-time price appeared in China in Aug 2026.")
ext("C004", " Report 36: $14.99/yr was anchored as 'less than a quarter of the price for competitor habit trackers' (4 of 34 payers); the price objection is about ratio to substance ('$15 for permission to buy a $10 skin. Scam!'), and by 2026 prices of $59–70 met 'the demographic which can drop 60$ on a reminder app'.")
ext("C005", " Report 36: rivals named — Streaks (one-time £5.99, where payers say they will go), Atoms, Me+, Onrise, Dayrise (cheaper in India), Habitica, Things, Notion, Habit Grid, Apple Reminders; the app wins on feel and loses on price model.")
ext("C006", " Report 36: simplicity 80 (14.81%, zero 1★) — 'Other habit trackers have too much other gunk like blogs or media'; a style-rejecting minority (6, mean 1.17) finds the 3D and piano soundtrack 'viel zu verspielt'.")
ext("C007", " Report 36: an unlimited free tier (praised: 'you can still get limitless habits w/ the free version — please keep it that way', 2023) capped at 2 then 1 in 2026; three reviewers volunteer three as the fair number ('Three would be reasonable for a paywall but only one??'; 'Ein Cap bei 3 Gewohnheiten hätte ich in Ordnung gefunden'); one mistook the cap for a bug; the cap upset US and non-US equally (5.56% each).")
ext("C009", " Report 36: widgets gated in Oct 2023 (WIDGETGATE 14, mean 2.64) are load-bearing for adherence — '62 days in a row … wouldn't be possible without this app and it's widgets'; 'Ojalá los widget fueran gratuitos eso mejoraría el apego' — and reviewers accept paid skins but not paid widgets ('I can understand locking skins behind a paywall but ALL widgets???').")
ext("C011", " Report 36: statistics / counts / year-in-review requested by 10, the newest rising request (4.6% of E5); one reviewer counts completions per month by hand.")
ext("C019", " Report 36: a quit-a-habit inverse mode requested once.")
ext("C021", " Report 36: Apple Health requested by 3 — a 10,000-step habit that auto-completes.")
ext("C022", " Report 36: Apple Watch requested by 9 (mean 4.11), one wanting the haptics on the wrist.")
ext("C023", " Report 36: 'instead of taking advantage of the iOS 17 update with interactive widgets, they preferred to make that option paid' (2★); interactive widget requested by 4.")
ext("C025", " Report 36: AFFORD 5 (mean 2.20) — two on disability, a student, and 'there is no way I can afford it without being part of the demographic which can drop 60$ on a reminder app'.")
ext("C027", " Report 36: localisation requests were 7.0% of E1 (six Chinese-market, May–June 2022, plus MX 1★ 'solo esté en inglés me hace perder el interés') and stopped after mid-2022, consistent with localisation shipping.")
ext("C029", " Report 36: all 3 billing reviews are 1★ — a cancellation link that returns 'Cannot cancel subscription' ('roach motel'), an unauthorised annual charge on a disabled reviewer, and five annual fees for one bundle membership with two refunds denied (China) — triaged regardless of 0.56% share as the only consumer-protection records.")
ext("C030", " Report 36: private sync is the resolution of the privacy-vs-sync tension — local-only praised ('not harvesting your data') while sync is the top request.")
ext("C033", " Report 36: entitlements don't travel — skins 'unlocking them on each device'; a payer who cannot find out whether the subscription covers one device.")
ext("C034", " Report 36: 'everything you save and track is reset when the app is deleted … I do not recommend' (1★); DATALOSS 3 (mean 1.67); a new phone met the new cap ('5 habits on the old phone, 1 on the new').")
ext("C035", " Report 36: no account at all; Chinese-market users ask for login specifically ('希望可以登陆', 17 helpful votes, third most-voted).")
ext("C036", " Report 36: both support-failure records are payers ('contacted the developer twice … I waited too long for a reply and I have now paid. Service matters'; 'a small company and cannot solve problems in mainland China').")
ext("C043", " Report 36: flexible schedules (every N days, N×/week or month) requested by 7 in E1–E3 and not since Dec 2024 (probably addressed); habits shown on unscheduled days (3, all 4–5★).")
ext("C048", " Report 36: multiple completions per day / quantity targets (water in ounces) requested by 5.")
ext("C056", " Report 36: exactly one review mentions AI — as a substitute after uninstalling over the cap ('doing it with AI daily tasks until I find an alternative').")
ext("C058", " Report 36: an App Store Awards / Apple Design Award feature drove discovery at launch (Jun 2022); a professional coach prescribes the app to clients.")
ext("C060", " Report 36: a 5-app 'Not Boring' membership — SUITE+ 34 (mean 4.41; 'I purchased the S2 for the weather app, but Habits is really the star for me'; 4 of 34 payers bought for the suite) vs SUITE- 9 (mean 3.22; 'Theoretically it includes 3 other apps, but this is the only good one … the calculator app … lags'): the weakest app in the bundle drags the perceived value of the price.")
ext("C061", " Report 36: patronage 5 of 34 payers (14.7%) — 'l'idée de payer 15€ par an pour féliciter, soutenir et remercier le travail d'une équipe indépendante'; proof-first 6 of 34 (17.6%) — 'Have been having it for free until today and decided to purchase'.")
ext("C062", " Report 36: US 252 (4.095) is the outcome market (outcomes 15.08% vs 6.94%) and reports confusion 3.4× more (onboarding 4.76% vs 1.39%); non-US reviews are feature-request-shaped (unmet 25.69% vs 11.90%) and ask for sync 4× more (9.72% vs 2.38%); the monetisation problem is identical across both.")
ext("C063", " Report 36: TRIAL 7 (mean 2.43) — 'any sort of trial period — even just an hour — before you blow $15'; 'these issues aren't readily apparent from the free version when you only have two habits to look at'.")
ext("C064", " Report 36: ~$15/£15/€18 a year for Habits alone and ~$30 for the suite (2022–25) rising to $59–70 by 2026; price objection 36 (mean 2.31) and 'not worth it' 21 (mean 2.24, zero 5★).")
ext("C065", " Report 36: payers are the least satisfied identifiable group — 34 payers average 3.794 (23.5% 1–2★) vs corpus 4.039 and free-tier praisers 4.88 — because paying exposes no sync (9 of 34, 26.5%), entitlements that don't travel, billing edge cases and bugs ('please fix the bugs (paying user)').")
ext("C066", " Report 36: a timer / pomodoro requested by 4 (mean 2.50), one because a screenshot habit was named 'Run 15 minutes'.")
ext("C069", " Report 36: hold-to-check with haptics, sound and music is the most specific praise (57, 10.56%, mean 4.61) — 'a small dose of dopamine every time you check something off' — 'the hardest for a competitor to copy'; 'the music is absolutely gorgeous, please upload it to Spotify'.")
ext("C073", " Report 36: cannot delete or rename a habit easily (10, mean 3.00) and a habit-name character limit (3).")
ext("C075", " Report 36: onboarding complaints 16 (mean 1.81, 12 of 16 1–2★), 7.9% of E1 → 1.9% of E5 — 'Is there no manual? Or user guide? I see no way to add new items like a + sign'; 'Is it a game or some kind of something else?'")
ext("C085", " Report 36: 'Does what it's meant to do while respecting your privacy and not harvesting your data'; 'the developers don't collect your data'.")
ext("C092", " Report 36: regional pricing complaints from Turkey and a cheaper local rival in India (₹499/yr vs Dayrise).")
ext("C093", " Report 36: a full-page subscribe screen on every launch — POPUP 24 (mean 2.67), rising to 15.0% of 2026 H2, the only negative theme regularly in 5★ (4 of 24): 'i said no already, please respect that'; 'Can't use the app on my iPhone 13 mini because of a freaking pop up' (5★ titled 'Unusable'); the report calls a once-a-week cap the cheapest change available.")
ext("C095", " Report 36: 'As an easily discouraged perfectionist, I LOVE that if you miss a day (or a week) that it doesn't become the app of shame' (20 votes); the motivational text is 'encouraging but never guilt inducing' (13, all 5★).")
ext("C104", " Report 36: the Oct 2023 widget gate was read as a bug for months ('the widget app has not been working properly … says that I have to unlock it') and the 2026 cap as 'extremely bugged. I cannot add a second habit'.")
ext("C107", " Report 36: once widgets were paid, widget-improvement demand peaked (titles, colours, streak display, interactivity) — 'now that widgets cost money, people want them to do more'.")
ext("C112", " Report 36: 'Dark pattern: roach motel … Clicking on link In email returns Cannot cancel subscription' (1★).")
ext("C119", " Report 36: a 2026 layout / scaling regression — font clipped on iPhone SE3, schedule options overflowing on iPhone 13 Plus / iOS 26.2 at first run (an immediate uninstall), an overview 'zoomed in like it was designed for desktop' — 4 of 6 UIBUG records in E5.")
ext("C133", " Report 36 contests the widgets part: reviewers accept paid skins but reject paid widgets and habit caps — skins-only gate mean 2.77 vs widgets 2.64 vs habit cap 2.30 ('Pay for the skins. I am fine with widget restrictions but 59$?').")
ext("C137", " Report 36: the report recommends never showing the upsell before the first habit is created.")
ext("C141", " Report 36: landscape / rotation (5) and a real iPad layout (4) requested in early 2022, fading later.")
ext("C143", " Report 36: multiple completions per day requested by 5.")
ext("C147", " Report 36: a 1-habit free tier 'you can't really test the app without paying'; roughly half of 121 friction reviews are willingness to pay the model cannot accept.")
ext("C155", " Report 36: 'Antes: Excelente. Ahora: Pésima' — a 2★ after widgets went paid.")
ext("C157", " Report 36: 7 ask for streaks / reps / loss-on-break (incl. a 45-vote review) while 11 praise the absence of streak shame — make streaks optional, with a 'don't skip twice' rule proposed.")
ext("C167", " Report 36: cosmetic gating (≈10 premium skins) is 'broadly accepted when it is the only gate' — 'So far the app is mostly free aside from cosmetics (understandable)' — and 3 of 34 payers bought for skins; selling skins separately on top of the membership reads as double-charging ('$15 for permission to buy a $10 skin').")
ext("C171", " Report 36: respect the silence switch and add a global audio toggle (2, one an uninstall).")
ext("C172", " Report 36: notes on a habit requested by 3.")
ext("C176", " Report 36: 'the most dangerous customer' is the multi-year free user who changed device or ran out of habits in 2026 — data in the app, no export and no sync, 'cannot leave cleanly and cannot continue without paying' (LOCKIN).")
ext("C181", " Report 36: 'It's not free. You can't do more than 1 habit without paying'; 'Si c'est payant mettez le là c'est caché après avoir téléchargé' — DISCLOSE 6, mean 1.67.")
ext("C207", " Report 36: daily motivational messages loved by 13 (all 5★) and disliked by 4 ('strangely negative — talking about destruction or a kind of wasteland'; 'Wish I could disable those') — make them switchable, don't rewrite them.")
ext("C218", " Report 36: a store screenshot showing a habit named 'Run 15 minutes' made a buyer expect a built-in timer (2★).")
ext("C219", " Report 36: archived / completed habits counted against the cap — 'when I went to archive one of my completed habits and tried to make a new one it wouldn't let me … seems like kind of a ripoff'.")
ext("C229", " Report 36: 'very satisfying to hold down a button … and get actual physical feedback from my phone … Much nicer than just tapping a complete button on a reminder list'.")
ext("C237", " Report 36: a 60-day monument that is the same journey for every habit — curiosity brings people back on day 3 ('I can't stop because I'm curious about what the next reward is'; GAME+ 74, mean 4.69) and the identical journey and hard stop drive them away around day 60–120 (17 distinct, mean 2.76: 'the story is repeated for all habits … pretty boring', 8 votes; 'it's a shame that it lasts only 60 days … I could have built something infinitely').")
ext("C246", " Report 36: no ads — '0 ad clutter. 0 monthly charges'; NOADS 6 (mean 4.33).")
ext("C247", " Report 36: 'I only want to buy this one' / 'Me gustaría que vendieran el premium de solo esta app' — SUITE- 9; one buyer bought Habits alone as 'the only app in the pack truly worth it'; the report: sell Habits standalone, prominently.")

M = {
 "R36-001":["C060"], "R36-005":["C006","C069"], "R36-006":["C069","C229"], "R36-007":["C237","C024"], "R36-009":["C095","C157","C253"],
 "R36-010":["C001","C007","C002"], "R36-011":["C007","C001"], "R36-012":["C001","C104"], "R36-013":["C001","C009"], "R36-014":["C001"],
 "R36-015":["C002"], "R36-016":["C003"], "R36-017":["C003"], "R36-018":["C064","C004"], "R36-019":["C093","C137","C145"], "R36-020":["C075"],
 "R36-021":["C254"], "R36-022":["C002"], "R36-023":["C030","C153","C013"], "R36-024":["C065"], "R36-025":["C033"], "R36-026":["C060","C247"],
 "R36-027":["C029"], "R36-028":["C027"], "R36-029":["C007","C001","C030","C003","C181","C093","C254"],
 "R36-032":["C002","C001"], "R36-034":["C002"],
 "R36-036":["C254"], "R36-037":["C069","C229"], "R36-038":["C237"], "R36-039":["C095"], "R36-040":["C012","C043","C219"], "R36-041":["C167"],
 "R36-042":["C030","C035","C022","C023","C048","C043","C172","C011","C021","C066","C237","C080","C141"],
 "R36-043":["C001"], "R36-044":["C001","C007","C061"], "R36-045":["C058"], "R36-046":["C104","C009"], "R36-047":["C064"], "R36-048":["C003","C231"],
 "R36-049":["C167","C064"], "R36-050":["C167","C001","C133"], "R36-051":["C167","C001","C133","C009"],
 "R36-052":["C059"], "R36-053":["C036","C215"], "R36-054":["C093"],
 "R36-056":["C006"], "R36-061":["C064"], "R36-063":["C004"], "R36-064":["C064"], "R36-066":["C175"], "R36-067":["C012"],
 "R36-069":["C009"], "R36-070":["C246","C085"], "R36-071":["C068"],
 "R36-074":["C006","C057"], "R36-075":["C181","C218"], "R36-076":["C075"],
 "R36-077":["C003","C001","C007","C167","C093","C063","C064","C025","C092"], "R36-078":["C147","C003"], "R36-079":["C063","C147"],
 "R36-080":["C025"], "R36-081":["C092"],
 "R36-082":["C069"], "R36-083":["C237","C024"], "R36-084":["C095","C157"], "R36-085":["C253"], "R36-086":["C095"], "R36-087":["C005"],
 "R36-089":["C011","C234"], "R36-090":["C022"], "R36-091":["C043"], "R36-092":["C039","C253"], "R36-093":["C157","C024"], "R36-094":["C107"],
 "R36-095":["C035"], "R36-096":["C141"], "R36-097":["C143","C048"], "R36-098":["C023"], "R36-099":["C066"], "R36-100":["C021","C172","C045"],
 "R36-101":["C019","C050"],
 "R36-102":["C175","C040","C039","C034","C119"], "R36-103":["C218"], "R36-104":["C207"],
 "R36-105":["C237"], "R36-106":["C024"], "R36-107":["C237"],
 "R36-108":["C001","C007"], "R36-109":["C219"], "R36-110":["C147","C056"], "R36-111":["C001","C186"], "R36-112":["C007"], "R36-113":["C236","C104"],
 "R36-114":["C002","C001"], "R36-115":["C104","C009"], "R36-116":["C009"], "R36-117":["C023","C001"],
 "R36-118":["C030","C013"], "R36-119":["C030","C065"], "R36-120":["C030","C065"], "R36-121":["C033"], "R36-122":["C035"], "R36-123":["C034","C153"], "R36-124":["C085","C030"],
 "R36-125":["C254"], "R36-126":["C254"], "R36-127":["C059","C254"], "R36-128":["C073","C043"], "R36-129":["C237"],
 "R36-131":["C003","C030","C254"], "R36-134":["C075","C001"], "R36-135":["C029","C112"], "R36-136":["C002"],
 "R36-139":["C065"], "R36-141":["C061","C147"], "R36-142":["C061"], "R36-143":["C004"], "R36-144":["C060"], "R36-145":["C167"],
 "R36-147":["C030","C167"], "R36-148":["C167"], "R36-150":["C065","C030","C029","C033","C036"], "R36-151":["C003","C005"],
 "R36-152":["C003","C009","C007","C063","C093","C181","C025"], "R36-153":["C176","C001"], "R36-154":["C034","C007"],
 "R36-157":["C062"], "R36-158":["C058"], "R36-159":["C005"], "R36-160":["C075"], "R36-161":["C030","C062"], "R36-162":["C062","C003"],
 "R36-163":["C007"], "R36-164":["C253"], "R36-165":["C062"], "R36-166":["C003"], "R36-167":["C003","C030","C035","C027"], "R36-168":["C092","C030"],
 "R36-169":["C112"], "R36-170":["C003","C007"], "R36-171":["C061"],
 "R36-175":["C002","C001"], "R36-176":["C001","C061"], "R36-177":["C075","C119"], "R36-178":["C093"], "R36-179":["C027"], "R36-181":["C107"],
 "R36-182":["C119","C171"], "R36-183":["C056"],
 "R36-184":["C069","C006"], "R36-185":["C095","C157"], "R36-186":["C253"], "R36-187":["C167","C001","C133"], "R36-188":["C003"],
 "R36-189":["C030","C085"], "R36-190":["C237"], "R36-191":["C007"],
 "R36-192":["C007","C219"], "R36-193":["C001","C186"], "R36-194":["C093","C137"], "R36-195":["C181","C218"], "R36-196":["C218"], "R36-197":["C029"],
 "R36-198":["C119"], "R36-199":["C254"], "R36-200":["C073"], "R36-201":["C043"], "R36-202":["C171"], "R36-203":["C207"],
 "R36-204":["C167","C009","C001"], "R36-205":["C003"], "R36-206":["C247","C060"], "R36-207":["C063","C109"], "R36-208":["C092"], "R36-209":["C001"],
 "R36-210":["C030","C085"], "R36-211":["C237"], "R36-212":["C254"], "R36-213":["C011"], "R36-214":["C022"], "R36-215":["C023","C107"],
 "R36-216":["C157"], "R36-217":["C048","C143"], "R36-218":["C253","C039"], "R36-219":["C021"],
 "R36-223":["C007"], "R36-224":["C003"], "R36-226":["C237"], "R36-227":["C093"],
 "R36-230":["C007","C009","C003","C093","C237","C030","C181"],
}
# unattached (nuance register): 002 method, 003 negative corpus, 004 free tier not one thing, 008 outcomes, 030–031/033/035 tables, 055 master table,
# 057 generic, 058 motiv, 059 best, 060 useful, 062 churn, 065 misrate, 068 science framing, 072 weak rows, 073 worst-rating table, 088 unmet table,
# 130–133 band tables, 137 cross-band, 138 payer framing, 140 triggers table, 146 social proof, 149 payer value, 155–156 US scope/table,
# 172–174 limited storefronts / language / era method, 180 request rotation, 220–222/225/228/229 weak roadmap + research questions, 221 music
cards = [json.loads(l) for l in open("Tools/prd_ledger/36/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/36/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
