"""Stage 3 merge for report 10."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C152","must-never-break","A promised pre-charge trial reminder must actually arrive — in-app, with amount and date","Report 10: 'you promised to remind me before charging' is the highest-intensity complaint in a 70,041-review corpus (billing-dispute family mean 1.97, 60% one-star, 17% of all payers); the reminder must be a blocking in-app card on next open, not only a push, and the exact amount and charge date must sit on the trial screen and permanently in Settings. For an ADHD audience the reminder is the feature, not a courtesy.")
add("C153","must-have","Automatic cloud backup on by default — never manual opt-in","Report 10: progress stored on-device with a manual opt-in backup produced 551 data-loss reviews (9% of all 1★), a family rate that quadrupled in four years, and clinicians publicly withdrawing recommendations; 37 users did not know a backup was required until after the loss. Warn before any destructive path (delete for storage, phone change).")
add("C154","dont","Compensation for lost data must match the loss — never a flat token","Report 10: a flat 5,000-stone remedy offered to users who lost 20,000–200,000 stones, multi-year streaks and unrepeatable items was described as insulting and in bereavement language; restore inventory or history, not a token.")
add("C155","product-rule","Never remove a feature people bought the app for — add alongside, do not replace","Report 10: every major removal (Journeys → streak-based Self-Care Areas, automatic mood check-ins, exact-time goals, milestones, colour palettes) produced a dated backlash, explicit paid cancellations, and none were reversed; generic 'you removed a feature I used' grew 16× in four years.")
add("C156","must-never-break","Content and event releases need a crash gate across device generations","Report 10: a monthly event's 'grow potion' animation crashed the app on load for a large cohort (120 crash reviews in Feb 2026, 4–6× baseline), destroying 600-day streaks and locking paid users out for weeks; reviewers blame the event cadence for shipping untested code.")
add("C157","product-rule","Every guilt mechanic must be optional — streaks, repair prompts, countdowns","Report 10: the app was praised specifically for not guilting users (476 reviews, mean 4.87); after streaks shipped mid-2024, 96 reviews say it now punishes the missed day the audience was promised it wouldn't, and repairing a streak costs currency. A single 'gentle mode' toggle is the corpus's own proposal.")
add("C158","must-have","Credit for non-consecutive, cumulative progress alongside streaks","Report 10: replacing cumulative Journeys with consecutive-streak Self-Care Areas was the lowest-rated change in the corpus (mean 2.76, 21 of 49 one-star); chronic-illness and ADHD users say a streak-only model is structurally incompatible with their lives. Ship cumulative credit next to streaks, not instead of them.")
add("C159","must-have","Launch-to-core-action path with no interstitials","Report 10: 'overwhelm' is the largest UX complaint (1,046 reviews) — an app sold to people with executive-function difficulty accumulated six sequential screens (quote, mood prompt, event cutscene, visitor, chest, claim-confirm-claim) before the checklist.")
add("C160","must-have","Honour what onboarding asks — a declared limitation must change the suggestions","Report 10: the onboarding asks about disability and then ignores the answer ('I have mobility issues, so I clicked that… ever since, the app has been suggesting that I do things that I've told it I can't do'); 597 accessibility reviews at mean 4.56.")
add("C161","product-rule","Values and identity screens are optional in both directions","Report 10: 54 users deleted at a mandatory pet-pronoun step, 109 objected to Pride content, and 111 loyal users (mean 4.57) complained representation was missing; the only intervention the corpus supports is a skip option and a show/hide filter for themed cosmetics — optionality, not editorial change.")
add("C162","must-never-break","Automated suggestions from user text must be safety-filtered; notifications must be crisis-aware","Report 10: the goal-suggestion system parsed a journal entry about suicidal ideation into a goal to 'schedule time for suicide'; diagnosis quizzes returned severe results to children in a 4+ app; a 'you can do this' push arrived right after a text about suicide.")
add("C163","research","Visible monthly plan — annual-default trials drive billing disputes","Report 10: the 7-day trial defaults to an annual charge; 23 reviews ask for a monthly plan and several say they would have paid monthly; the annual default is the mechanism behind most of the 404 billing disputes.")
add("C164","dont","A random-rotation shop with paid re-rolls and unpurchasable catalogue items is a friction generator","Report 10: goals yield 3–12 stones while items cost 500–900, the shop rotates randomly, and the item you want never appears — 196 complaints from engaged, currency-rich users, the ones most likely to subscribe. Let users buy what they can see.")
add("C165","dont","Official community channels must tolerate criticism","Report 10: the Facebook group, Discord and subreddit are described as heavily moderated and hostile to criticism across five years (211 reviews), with paying users 7× over-represented; suppression of criticism resurfaces in every later controversy.")
add("C166","product-rule","Keep the therapeutic core in front of the game layer","Report 10: as breathing, first aid and soundscapes moved behind menus and paywalls, tool mentions fell 15.6% → 2.7% and the core-benefit family 30% → 23%, while reviewers called the product 'a pay-to-play loot box checklist simulator'; the game is why people call it cute and motivating, but it must not be paid for by burying the layer people came for.")
add("C167","paid","Cosmetic and colour variety as the paid layer","Report 10: buyers name extra colour options, seasonal items and a larger shop as the specific hook ('I started getting finch plus solely because I found the extra color options… very motivating'); restricting palettes later (Aug–Sep 2026) drew a backlash.")
add("C168","undecided","Monthly seasonal event with a paid reward track","Report 10: event completion is a stated purchase trigger, but events are also the named cause of the 2026 crash and data-loss clusters, FOMO complaints, and the sponsored-IP values breach.")
add("C169","research","Completion verification / anti-cheat","Report 10: 158 users volunteer that they check boxes without doing the task and ask to be held accountable (mean 4.59); its sibling 'it's just a checklist' (111) is the churn thesis.")
add("C170","research","Configurable day boundary and hemisphere seasons","Report 10: 146 reviews say the app assumes a conventional daytime schedule and northern-hemisphere seasons; night-shift workers and southern-hemisphere users ask for a movable day boundary.")
add("C171","must-have","Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size","Report 10: 597 accessibility reviews (0.85%, mean 4.56) from blind, mobility-limited, chronically ill, motion-, sound- and light-sensitive users; dark mode is argued as an accessibility need, not a preference ('Cute clothes for the bird were apparently shippable').")

# statement extensions on existing points
ext("C025", " Report 10: a 'Guardian' pay-it-forward sponsorship programme is one of the only monetisation themes with a positive mean (4.76 across 708 mentions); its one complaint is that there is no visible way to apply.")
ext("C127", " Report 10: a sponsored movie tie-in as the monthly event drew 'I am paying to be advertised to' from multi-year subscribers (mean 3.09, 8× over-represented among payers) after 857 reviews had praised the app for being ad-free.")
ext("C034", " Report 10: from 2025 the dominant story became app-initiated — 'it told me my pet data got corrupted' — with no automatic backup to fall back on.")
ext("C117", " Report 10: the pet is the causal story users tell — 'I will do for the bird what I will not do for myself' — at 70,041-review scale (companion 1,309, cute design 10,074); the same attachment makes data loss feel like bereavement.")
ext("C109", " Report 10: 149 users believe they were charged at trial START (mean 1.79) and trial length varied between 2 and 7 days across users.")
ext("C113", " Report 10: household members quoted $34.99 vs $41.99 on the same day, support could not explain a $19.99–$99.99 range — perceived as discriminatory pricing inside families.")
ext("C024", " Report 10 (contested): streaks added to a non-punitive pet app generated their own defect stream (171, growing 74×) and pressure stream (96) — net-negative in the written record for an ADHD audience.")
ext("C042", " Report 10: 7.36% of 70,041 reviewers self-identify as ADHD/autistic/ND; Australia's base is 11.4%.")
ext("C058", " Report 10: 381 reviews involve a clinician recommending the app; two clinicians publicly withdrew the recommendation over data loss.")
ext("C027", " Report 10: localisation is HIGH-PRIORITY at country level in eight storefronts at once (cn 26%, ru 18%, tr 19%, br 13%, es 12%); reviewers say they will not pay in English.")
ext("C036", " Report 10: AI and canned support replies; paying users 13× over-represented among support complaints.")
ext("C040", " Report 10: the widget rendered as a grey box for five years (117 reviews) — reported mostly by fans, so it never generated pressure.")
ext("C065", " Report 10: paid-cohort mean fell 4.40 → 2.96 across 2022–2026 while the corpus mean barely moved; the five highest paid lifts are all billing mechanics, not price.")
ext("C080", " Report 10: dark mode requested since 2022 as an accessibility need (migraine, light sensitivity).")
ext("C001", " Report 10: soundscapes, longer timers, the event micropet and the anxiety breathing exercise all moved from free to paid; paywall-creep is the largest monetization theme (715).")

M = {
 "R10-004":["C065","C002"], "R10-005":["C152","C109"], "R10-006":["C034","C153"], "R10-007":["C031","C156"], "R10-008":["C127","C006"],
 "R10-009":["C061","C095","C117"], "R10-010":["C065"], "R10-011":["C031","C156"], "R10-012":["C155"], "R10-013":["C024","C157"],
 "R10-014":["C027","C021","C022","C171"], "R10-015":["C161"], "R10-016":["C152","C153","C156","C155","C166"],
 "R10-017":["C117"], "R10-019":["C116"], "R10-020":["C016"], "R10-021":["C001"], "R10-022":["C133"], "R10-023":["C001"],
 "R10-024":["C001","C116"], "R10-025":["C109"], "R10-026":["C137","C113"], "R10-027":["C064"], "R10-028":["C113"],
 "R10-029":["C168"], "R10-030":["C027"], "R10-032":["C117"], "R10-033":["C117"], "R10-034":["C042"], "R10-035":["C116"],
 "R10-036":["C015"], "R10-037":["C117"], "R10-038":["C059"], "R10-039":["C061","C006"], "R10-040":["C095","C157"],
 "R10-041":["C058"], "R10-042":["C019"], "R10-044":["C029","C065"], "R10-046":["C029"], "R10-047":["C152","C109"],
 "R10-048":["C152","C042"], "R10-049":["C109"], "R10-050":["C029"], "R10-051":["C112","C029"], "R10-053":["C031"],
 "R10-054":["C034","C153","C035"], "R10-055":["C154"], "R10-056":["C065","C034"], "R10-057":["C117","C034"], "R10-058":["C036"],
 "R10-059":["C040"], "R10-060":["C039","C083"], "R10-061":["C155","C119"], "R10-062":["C155"], "R10-064":["C159","C006"],
 "R10-065":["C157","C024"], "R10-066":["C038"], "R10-067":["C164"], "R10-068":["C169"], "R10-069":["C168","C093"],
 "R10-070":["C021","C022","C027","C080"], "R10-071":["C117"], "R10-072":["C021"], "R10-073":["C022"], "R10-074":["C080","C171"],
 "R10-075":["C171"], "R10-076":["C027"], "R10-077":["C169"], "R10-078":["C170"], "R10-079":["C013"], "R10-080":["C037"],
 "R10-081":["C044"], "R10-083":["C103"], "R10-084":["C161"], "R10-085":["C161"], "R10-086":["C162","C103"], "R10-087":["C165"],
 "R10-088":["C085"], "R10-090":["C119"], "R10-096":["C021","C022","C080"], "R10-097":["C031","C034"], "R10-098":["C065"],
 "R10-099":["C002","C065"], "R10-100":["C110"], "R10-102":["C065"], "R10-103":["C065"], "R10-104":["C065"],
 "R10-106":["C029","C065"], "R10-107":["C036","C059"], "R10-108":["C025"], "R10-109":["C063"], "R10-110":["C167"],
 "R10-111":["C168"], "R10-112":["C061"], "R10-113":["C025"], "R10-115":["C029","C034","C155","C127"], "R10-116":["C113"],
 "R10-119":["C062"], "R10-121":["C062"], "R10-122":["C042"], "R10-123":["C062"], "R10-126":["C027"], "R10-127":["C027"],
 "R10-128":["C027"], "R10-129":["C160","C171"], "R10-130":["C029","C034","C155"], "R10-131":["C092"],
 "R10-134":["C031"], "R10-135":["C156","C031","C157"], "R10-136":["C156","C031"], "R10-137":["C034","C153"], "R10-138":["C155"],
 "R10-139":["C001"], "R10-140":["C030","C035"], "R10-141":["C119"], "R10-142":["C024","C157"], "R10-143":["C155","C158","C047"],
 "R10-144":["C155","C049"], "R10-145":["C155"], "R10-146":["C155"], "R10-148":["C127","C006"], "R10-149":["C029","C064"],
 "R10-150":["C166"], "R10-152":["C152","C112"], "R10-153":["C153","C154","C035"], "R10-154":["C156"], "R10-155":["C040"],
 "R10-156":["C036"], "R10-157":["C166"], "R10-158":["C158","C047"], "R10-159":["C157"], "R10-160":["C159"], "R10-161":["C164"],
 "R10-162":["C021","C022","C013","C037"], "R10-163":["C080","C160","C171"], "R10-164":["C027"], "R10-165":["C161"], "R10-166":["C127"],
 "R10-167":["C163"], "R10-168":["C003"], "R10-169":["C113"], "R10-170":["C025"], "R10-171":["C064"], "R10-172":["C152"],
 "R10-173":["C157"], "R10-174":["C153"], "R10-175":["C166"], "R10-176":["C027"], "R10-177":["C164"],
 "R10-179":["C057"], "R10-180":["C064"],
}
# unattached (nuance register): 001-003 header/method, 018 vocabulary table, 031/043/045/052/063/082/093/101/105/117/120/124/132/133 verbatim tables,
# 089 merch, 091 forced colour, 092 likes/dislikes, 094-095 band notes & rating-to-be-seen, 114 no conversion rate, 118 method reminder,
# 125 zero-paid markets, 147 AI-ads/hiring ethics, 151 trends not claimed, 178 research questions
cards = [json.loads(l) for l in open("Tools/prd_ledger/10/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C, (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/10/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
from collections import Counter
print("points by report count:", sorted(Counter(len(x["reports"]) for x in C.values()).items()))
