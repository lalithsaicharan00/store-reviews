"""Stage 3 merge for report 24."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C231","research","Audit the sales funnel per market — the same product can rate 4.3 in one storefront and 2.1 in another on billing alone","Report 24: Latin-American and Gulf storefronts (Brazil 4.266, Mexico 4.381, Peru 4.511, Ecuador 4.593; bill_core 2.35–6.42%) carry the same product that rates 2.1–2.6 in the US/UK/AU/CA during 2024–26 at 42–52% billing disputes; Brazil stays at 4.002 through the worst era. Language-neutral ratings rule out a classifier artefact. Whatever is different in how the product is sold there is the model — and rich English-language markets were the worst, not the best.")
add("C232","must-never-break","Payment retries are bounded — daily dunning against a declined card reads as fraud to the customer and their bank","Report 24: 584 duplicate/repeated-charge reports (1.34%, mean 1.134), 117 describing daily or near-daily retry attempts, and 123 whose bank flagged or blocked the merchant as fraud; a same-day retry loop is indistinguishable from theft from the customer's side.")
add("C233","must-have","Content the user paid for is saveable and replayable — a library, not a stream","Report 24: long-tenure paying users cannot save or re-listen to the morning coaching piece — 'the main reason, every year, I seriously consider whether or not I will even renew'; journal entries cannot be revisited; background music was removed. Missing this is a stated renewal factor for the app's best customers.")

ext("C210", " Report 24 (43,469 reviews): the largest theme in the corpus — 5,791 core billing disputes (13.32%, mean 1.110, 94.2% 1★; 52.4% of all 1★; 38% of 2024–26) — follows mechanically from selling the subscription through a web checkout (Chargebee; 'Fabulous SAS' on statements): it is invisible in Apple Subscriptions, cancelling in the App Store does nothing, Apple cannot refund it, and the user is routed to a 250-character web form with no phone; 212 escalated to their bank, the BBB, the FTC or a lawyer. The failure is dated — quarterly rate 5.4% (2023Q1) → 12.0% (Q4) → 33.1% (2024Q4) → ~50% from 2025Q2 — and an earlier 2018–19 episode was fixed in one month (Dec 2019: 12.7% → 2.6%, mean 2.884 → 4.206), so it is recoverable. Reviews that mention money average 2.006; those that do not, 4.356.")
ext("C211", " Report 24: 324 reviews (0.75%, mean 1.398) describe being enrolled in a multi-app bundle (Clarify, Shape, Sphere…) during onboarding through near-identical full-screen offers whose decline is a small corner 'skip'; the $39.99 + $29.99 same-day pair is the signature in hundreds of 2024–26 reviews, each subscription must be cancelled separately, and 338 report a charge with no consent at all (mean 1.047, the lowest in the corpus). Bundle complaints went 0.30% → 0.06% → 0.17% → 2.62% across eras.")
ext("C212", " Report 24: refund refusals (968, 2.23%, mean 1.070) quote near-verbatim T&C clauses across years and markets — 'the set-up fee for the trial period is non-refundable' and 'unless cancelled at least 24 hours before the renewal date'; 227 reviewers hold an e-mail or screenshot confirming cancellation and were charged anyway. When a refund is actually reached it works and reviewers upgrade in place (1★ → 4★), so the failure is reaching it.")
ext("C213", " Report 24: an app whose subtitle is 'ADHD Help' has ADHD users as its angriest segment (933, mean 2.747, 54.2% 1–2★) and 201 of them (mean 1.159) say the cancellation design exploits the condition — 'they know because of your poor executive function that you won't take the extra effort to find the cancel button'; the segment grew 30× across eras (0.20% → 6.01%) as the marketing worked, and the outcome got worse. Either build for the condition or stop claiming it.")
ext("C215", " Report 24: support unresponsive or automated-only in 947 reviews (2.18%, mean 1.528); the specific obstacle named 17 times is a web contact form with a 250-character limit and no telephone number.")
ext("C221", " Report 24: 197 reviews (mean 1.168, 0% 5★) say the renewal came with no notice — the cheapest item on the report's list; 1,412 edited reviews are largely downgrades added after a later charge.")
ext("C109", " Report 24: the 'free trial' charges a 'pay what you can' set-up fee ($1 / $10 / $16.41) on a donation-style screen, classed in the terms as non-refundable — 506 reviews (1.16%, mean 1.136) say the trial was not free and 100 name the fee mechanism (mean 1.110).")
ext("C113", " Report 24: annual, quarterly, 'bimonthly', monthly and weekly cycles at overlapping prices ('this page says $59 for a year… it's $40 billed every three months'), different prices on different screens, and a cancel flow that discounts $19.99 → $12.99 → $5 → $2/month; the inconsistency of what users believe they bought is the direct cause of 'charged twice' reports.")
ext("C180", " Report 24: the cancellation flow offers progressively lower prices and reviewers publish it as a trick ('keep opting for cancel, you'll eventually get $5/month') — it converts some but establishes that the list price is not the real price.")
ext("C127", " Report 24: in-app advertising of the developer's own sister apps inside paid accounts — 308 reviews, mean 1.932, only 14.6% 4–5★, the lowest satisfied-share of any UX theme ('I'm on the purchased version… I don't want to see adds'); rose 0.11% → 2.03% across eras.")
ext("C060", " Report 24 (counter-evidence): a nine-app family (Clarify, Shape, Elixir, Lumière, Lune, Ambiance, Sphere, Mind, Enchant), each its own download and subscription, is experienced as advertising inside a paid product and as a billing trap; Clarify, the ADHD sister app, is named almost only inside billing complaints (mean 1.637). Cross-sell on brand trust works only while the trust and the billing are clean.")
ext("C093", " Report 24: sister-app upsells (308, mean 1.932), referral/share prompts (131) and pop-ups/unskippable steps (182, mean 2.082) inside a paid subscription.")
ext("C222", " Report 24 (the same principle from the coaching side): the product's real moat is a refusal — it declines to let users add more habits; small-steps pacing is the highest-rated theme of any size in 43,469 reviews (1,817, mean 4.692, 2.0% 1★; 'I stacked everything I wanted to change and failed miserably; this time I followed the program'), and the same constraint produces the four complaint shapes ('I already do this' 124, 'it ignored my answers' 175, 'too slow' 168, 'doesn't fit my week' 31). The corpus asks for one branch — declare a habit already-held and start at habit two — not for the constraint to go.")
ext("C007", " Report 24 (counter-evidence): a coaching app's highest-rated property is that it refuses to let users add more habits — 'anyone shipping a habit tracker with unlimited habits is competing against the wrong thing'; the generous-cap rule is about paywalls, not about pacing.")
ext("C160", " Report 24: a long onboarding questionnaire produces an identical plan for everyone — 'You will answer a ton of questions about your habits and goals and then the app will not take any of your answers into account'; 'I told it I drink water all day. The first habit I'm to build is drinking three glasses of water' (no-customisation 175, mean 2.097; forced first habit 124, mean 2.452, consistent across eleven years and six languages).")
ext("C203", " Report 24: the forced first habit ('drink water', gated three days, then breakfast) is the concrete example inside every larger personalisation complaint; the fix is an 'I already do this' branch, keeping the default.")
ext("C161", " Report 24: onboarding includes a 'letter from your future self' and a held-finger 'contract' signed with the fingerprint sensor, reached via a social ad and a web questionnaire.")
ext("C111", " Report 24: a large share of buyers take the questionnaire in a web browser and enter payment details before ever opening the app; onboarding-too-long runs at mean 1.600.")
ext("C159", " Report 24: an app sold as an ADHD focus aid is described as itself overstimulating ('This app literally GIVES me adhd') — cluttered/overwhelming 1,324 (3.05%, mean 3.068) and confusing navigation 1,507 (3.47%, mean 2.338), rising through the good eras too (1.90% → 4.26%); 46.1% of clutter requests come from 4–5★ users, so a low-stimulus home screen that opens on today's routine with coaching, Discover, Circles and cross-app promotion below the fold is a retention feature; checking off one habit takes 3–5 screens.")
ext("C207", " Report 24: retained users ask for a 'just my routine' mode — coaching, community, discovery and cross-app promotion below the fold or hidden.")
ext("C145", " Report 24: pop-ups and unskippable steps (182, mean 2.082) and unskippable completion celebrations; make animations skippable.")
ext("C042", " Report 24: ADHD/autism/executive-dysfunction users are 933 (2.15%) and grew 30× across eras to 6.01% of 2024–26 reviews — but they are the angriest segment (mean 2.747, 54.2% 1–2★) because the interface overstimulates and the cancel flow exploits executive function; depression/anxiety/PTSD/grief context is 1,256 (2.89%, mean 3.938); clinicians review it and recommend it (24 + 9).")
ext("C103", " Report 24: a product marketed to people with executive dysfunction and low income priced as a premium wellness subscription; diet-culture / eating-disorder trigger complaints (61, mean 2.918); depression/anxiety users are 2.89% of the corpus.")
ext("C095", " Report 24: childish / condescending tone 304 (0.70%, mean 2.701); what paying users value includes that missing a day is not punished.")
ext("C216", " Report 24: paying users name 'missing a day is not punished' among the things they value most.")
ext("C056", " Report 24: an AI chat/coach bubble added ~2025 is an unwanted addition for long-tenure users, and AI-generated art/copy is the worst-rated non-billing theme (64, mean 1.156, 90.6% 1★) — the theme did not exist before 2024.")
ext("C155", " Report 24: the 'Make Me Fabulous' activity launcher was removed or hidden after a redesign and background music was removed — both named by long-tenure payers as renewal reasons.")
ext("C002", " Report 24: the cleanest statement of the rule in the set — 43,469 reviews where those that mention money average 2.006 and those that do not average 4.356 (a 2.35-star gap); the 1★ and 5★ populations are talking about different things (billing vs product); the annual mean fell 2.09 stars below its 2021 peak while product-praise themes barely moved, and an earlier 2018–19 billing crisis was fixed in one month and the mean snapped back for four years.")
ext("C065", " Report 24: reviewers who discuss the transaction average 2.006 against 4.356 for the rest.")
ext("C029", " Report 24: charged after cancelling 1,620 (3.73%, mean 1.085), duplicate charges 584, charge without consent 338 (mean 1.047), not visible in Apple Subscriptions 125 — all consequences of billing outside Apple IAP; 1,412 edited reviews are mostly downgrades after a later charge.")
ext("C112", " Report 24: cannot find or complete cancellation 1,146 (2.64%, mean 1.115, 0.3% 5★) because the subscription lives on the developer's website; move billing into IAP or surface the web subscription in-app with one-tap cancel.")
ext("C036", " Report 24: 947 (2.18%, mean 1.528) automated-only support; the refund path works when reached — several 1★ → 4★ edits after a refund — so the failure is reaching it.")
ext("C110", " Report 24: a real free tier (~3–4 habits, coaching locked) exists behind a small 'X' or 'skip' on the trial splash and is hard to find; 77 reviews (mean 4.442) call it generous once found.")
ext("C133", " Report 24: the free tier gates coaching content (the product's value) at ~3–4 habits; the constraint that makes the product work is pacing, not a paywall.")
ext("C116", " Report 24: three narrated coaching pieces a day, multi-week Journeys, meditations, a deep-work ritual, music and soundscapes are what paying users value (coaching praised 6,095, 14.02%, mean 4.483; life-changing 4,468, mean 4.799); repetitive content 103 (mean 2.660); the content must be saveable and replayable.")
ext("C118", " Report 24: multi-week guided programmes ('Journeys' as a mountain map) and the deep-work ritual are the paid layer and the stated renewal reasons.")
ext("C195", " Report 24: Duke University / Dan Ariely / behavioural-science framing (736, mean 3.865; 1.77% of 5★) is thrown back the moment trust breaks — 'they use behavioural science to help you make positive change, but also to get you to subscribe'; 'discredited for falsifying results… I no longer trust this app'; a credibility asset raises the expected standard of conduct.")
ext("C134", " Report 24: reviews invoking Apple or Editor's Choice average 1.085 (95.7% 1★) — 'Apple should not feature this'.")
ext("C005", " Report 24: competitors are named rarely (102, 0.23%) and almost always as a switching destination in anger — Finch 19 (mean 1.579) for business-model trust ('Finch is much less greedy'), Noom and Duolingo as comparisons of mechanic (click-through lessons; streak freezes), Notion 13, Stoic 11, Way of Life 6, Habitica 4.")
ext("C062", " Report 24 (counter-evidence): the rich English-language storefronts were the worst — US/UK/CA/AU/NZ/IE (62.87% of the corpus) all above the corpus billing rate and all collapsing to 2.1–2.6 in 2024–26, while Latin America and the Gulf held 4.12–4.59; what varies by country is the funnel, not the product.")
ext("C027", " Report 24: the praise vocabulary (small steps, coaching, art, 'life-changing') appears in every language and the forced-water complaint in six; language requests concentrate in Vietnam, Uzbekistan, Russia, Brazil and Italy; Germany praises the app's craft at 19.61% (3× the corpus); China (1,250 reviews, mean 3.431, 28.6% 1★) is unreadable by an English-anchored classifier.")
ext("C094", " Report 24: an in-app review prompt on day 1–3 makes the 5★ band (57.89%, median 105 characters) a first-impression measure — 'they asked me to review it now which I find kind of ridiculous'; the highest-voted reviews are all pre-2024 5★s.")
ext("C058", " Report 24: acquisition runs through Instagram / Facebook / X ads into a web questionnaire; credibility signals (Duke/Stanford framing, Atomic Habits adjacency) and 'the trial produced a result in days' are the conversion stories.")
ext("C070", " Report 24: Atomic Habits adjacency is a named purchase trigger.")
ext("C039", " Report 24: notification volume/control 744 (1.71%, mean 2.437) — users turn all notifications off, which disables the product; give per-notification-type control.")
ext("C123", " Report 24: all-or-nothing notification settings make users disable everything (744, 1.71%); per-type control is the fix.")
ext("C080", " Report 24: dark mode requested by 43, 58.1% of them 4–5★ — cheap and asked for by advocates.")
ext("C043", " Report 24: per-weekday / shift-work scheduling requested by 31, 51.6% of them 4–5★.")
ext("C010", " Report 24: cannot undo a tick or backfill a missed day (70, mean 2.700) — the emotional cost is disproportionate because it breaks streaks the product made meaningful.")
ext("C141", " Report 24: no iPad app / lost progress on device change 257 (0.59%, mean 2.693) — progress loss on device change is the most-cited reason a multi-year user stops.")
ext("C034", " Report 24: progress lost on device change with no restore (257, mean 2.693) is the most-cited reason a multi-year user stops.")
ext("C031", " Report 24: crash / freeze / won't load 944 (2.17%, mean 2.367) — the recurring shape is freezing on the 'first mountain' / Journeys screen on day one.")
ext("C139", " Report 24: cannot log in / paid but no premium access 96 (mean 1.375, 78.1% 1★).")
ext("C024", " Report 24: streak counters with 'freeze' passes and certificates; Duolingo is named for its streak freezes.")
ext("C049", " Report 24: a daily mood check-in exists inside the routine app.")
ext("C015", " Report 24: in-app community ('Circles', 370, mean 3.897) and time-boxed group challenges exist; the word 'God' being blocked in Circles drew 14 complaints.")
ext("C202", " Report 24: Circles — an in-app feed with comments and writing prompts — runs at mean 3.897 (0.85%), neither a driver nor a grievance.")
ext("C022", " Report 24: in a 43,469-review coaching corpus the Watch (69, 0.16%) and widget (53, 0.12%) are marginal — the surface matters where the product is a checklist, not where it is content.")
ext("C171", " Report 24: accessibility (vision, font, VoiceOver) 129 (0.30%, mean 3.101).")
ext("C085", " Report 24: privacy / personal data complaints 138 (mean 1.225, 87.7% 1★) — a long questionnaire and web billing that collects card data before install.")
ext("C064", " Report 24: price objection 791 (1.82%, mean 2.248) is about magnitude relative to category ($40/quarter, $80–100/month with bundles vs $5–20/yr rivals), opacity and targeting (premium wellness pricing for people with executive dysfunction and low income) — not the existence of a price; a distinct group calls $20/yr worth every penny.")
ext("C066", " Report 24: a deep-work ramp-up ritual and per-habit timers are named by long-tenure users as the reason they renew.")
ext("C196", " Report 24: repetitive coaching content (103, mean 2.660) in a content subscription.")
ext("C162", " Report 24: diet-culture / eating-disorder trigger complaints (61, mean 2.918) in a wellness routine app.")
ext("C059", " Report 24: a 2018–19 billing crisis was fixed in one month and the mean snapped back from 2.884 to 4.206 for four years; refunds that land turn 1★ into 4★ edits.")
ext("C148", " Report 24: acquisition ads and a web questionnaire promise personalisation the plan does not deliver — 'the app asked very few questions and made very many assumptions before designing a plan for me'.")

M = {
 "R24-003":["C210","C029"], "R24-004":["C210","C002"], "R24-005":["C116","C222"], "R24-006":["C002","C159"], "R24-007":["C213","C042"], "R24-008":["C159","C042"],
 "R24-009":["C127","C211","C060"], "R24-010":["C203","C160"], "R24-011":["C231","C062"], "R24-012":["C210","C211","C212","C127","C203","C159","C043","C010"],
 "R24-013":["C221","C029"], "R24-015":["C027"], "R24-016":["C094"], "R24-018":["C002"], "R24-019":["C002"],
 "R24-022":["C161","C111"], "R24-023":["C118"], "R24-024":["C203","C160"], "R24-025":["C118","C116"], "R24-026":["C116"], "R24-027":["C015","C202"], "R24-028":["C155","C066"],
 "R24-029":["C116","C049","C024"], "R24-030":["C022"], "R24-031":["C056"], "R24-032":["C060","C211"], "R24-033":["C110","C133"], "R24-034":["C109"], "R24-035":["C210","C112"],
 "R24-036":["C210"], "R24-037":["C064","C211"], "R24-038":["C113","C029"], "R24-039":["C211"],
 "R24-041":["C116"], "R24-043":["C118"], "R24-044":["C210"], "R24-045":["C134"], "R24-046":["C222"], "R24-047":["C212"], "R24-048":["C029","C210"], "R24-049":["C159"], "R24-050":["C159"],
 "R24-051":["C042","C103"], "R24-052":["C112"], "R24-053":["C212"], "R24-054":["C036","C215"], "R24-055":["C031"], "R24-056":["C042"], "R24-057":["C064"], "R24-058":["C039","C123"],
 "R24-059":["C195"], "R24-060":["C232","C029"], "R24-061":["C109"], "R24-062":["C015","C202"], "R24-063":["C211","C029"], "R24-064":["C211"], "R24-065":["C127"], "R24-066":["C095"],
 "R24-067":["C116"], "R24-068":["C141","C034"], "R24-070":["C210"], "R24-071":["C221"], "R24-072":["C015"], "R24-073":["C145","C160"], "R24-074":["C085"], "R24-075":["C093"],
 "R24-076":["C171"], "R24-077":["C027"], "R24-078":["C196"], "R24-079":["C139"], "R24-080":["C010"], "R24-081":["C103","C162"], "R24-083":["C134"], "R24-084":["C111"],
 "R24-085":["C080","C043"], "R24-086":["C042","C058"], "R24-087":["C002"], "R24-088":["C002","C065"], "R24-089":["C210"], "R24-090":["C127","C145","C160","C159"],
 "R24-092":["C222"], "R24-093":["C222","C203"], "R24-094":["C031","C139","C034"], "R24-096":["C159","C207"], "R24-097":["C039","C123"], "R24-098":["C043"], "R24-099":["C080"], "R24-100":["C141","C034"],
 "R24-101":["C080","C043","C159"], "R24-102":["C005"], "R24-103":["C005","C210"],
 "R24-104":["C222"], "R24-105":["C160","C203"], "R24-106":["C203","C222"], "R24-107":["C159"], "R24-108":["C159","C042"], "R24-109":["C159","C127"], "R24-110":["C127","C211","C060"], "R24-111":["C210"],
 "R24-113":["C094","C159"], "R24-114":["C159"], "R24-116":["C159"], "R24-117":["C210"], "R24-119":["C134"],
 "R24-120":["C210"], "R24-121":["C111","C058"], "R24-122":["C109"], "R24-123":["C211","C029"], "R24-124":["C210","C112"], "R24-125":["C212","C029"], "R24-126":["C232"], "R24-127":["C215","C036","C212"],
 "R24-128":["C210"], "R24-129":["C210"], "R24-130":["C210","C002"], "R24-131":["C002","C059"], "R24-132":["C231","C062"], "R24-133":["C231"], "R24-134":["C195"],
 "R24-135":["C002","C065"], "R24-136":["C058"], "R24-137":["C222"], "R24-138":["C058","C070","C195"], "R24-139":["C180","C113"], "R24-140":["C116","C216","C066"], "R24-141":["C233","C155"],
 "R24-142":["C064","C103"], "R24-143":["C110","C064"], "R24-144":["C212"], "R24-145":["C036","C059"],
 "R24-147":["C231","C062"], "R24-148":["C231","C062"], "R24-149":["C231"], "R24-150":["C027"], "R24-151":["C027"], "R24-153":["C027"],
 "R24-155":["C002","C210"], "R24-156":["C059","C002"], "R24-157":["C159"], "R24-158":["C127","C211","C056"], "R24-159":["C213","C042"], "R24-160":["C002"], "R24-161":["C094"],
 "R24-163":["C116"], "R24-164":["C222","C007"], "R24-165":["C210"], "R24-166":["C042","C213"], "R24-167":["C127"], "R24-168":["C080","C043","C010","C233","C141","C203"], "R24-169":["C027","C231"], "R24-170":["C195"],
 "R24-171":["C210","C112"], "R24-172":["C212","C029"], "R24-173":["C211"], "R24-174":["C232"], "R24-175":["C215","C036"], "R24-176":["C221"], "R24-177":["C159","C207"], "R24-178":["C127"],
 "R24-179":["C145"], "R24-180":["C123","C039"], "R24-181":["C203","C160"], "R24-182":["C043"], "R24-183":["C010"], "R24-184":["C080"], "R24-185":["C233"], "R24-186":["C141","C034"],
 "R24-187":["C031","C139"], "R24-188":["C213","C218"], "R24-189":["C113"], "R24-190":["C231"],
 "R24-193":["C180","C113"], "R24-194":["C094"], "R24-195":["C109"],
}
# unattached (nuance register): 001-002 header/method, 014 scam-tail note, 017 ratings table, 020 votes, 021 inventory table, 040 theme table,
# 042 life-changing, 069 weak rows, 082 audio through silent switch, 091 positives table, 095 unbuilt table, 112 review length, 115 3★ band,
# 118 cross-band table, 146 country table, 152 small-market tail, 154 method, 162 non-claims, 191-192 experiments and questions
cards = [json.loads(l) for l in open("Tools/prd_ledger/24/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/24/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
