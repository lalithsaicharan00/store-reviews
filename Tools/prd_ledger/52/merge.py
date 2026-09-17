"""Stage 3 merge for report 52."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C269", "dont", "If the free tier carries ads, never use hijacking ad mechanics — no auto-jump into other apps, no shake or tilt triggers, a close control that closes, and no ad on the check-in",
    "Report 52 (ShineDay / 小日常): the June 2025 in-flow ad rollout is the largest negative event in nine years — AD_NEG 546 of 1,562 reviews (35.0%) in Jun–Nov 2025 against 0.6% in Jan–May, July 2025 the lowest month in the corpus (3.35), 885 total (4.29%, mean 2.46). Reviewers did not object to ads as such; they named the mechanics: ads that open another app automatically (Taobao, Pinduoduo, Meituan, Quark) 107, a close / skip button hidden, tiny or ineffective 88, shaking or tilting the phone triggers the ad 33, and ads after the check-in itself — 'the skip and close buttons get more hidden… move the phone slightly… it jumps into the ad page'; a close button that opens 'a full-screen Taobao ad that also can't be closed'. The report's reading: 'not a pricing decision that users rejected… an interaction-design decision'; an ad dismissal also bypassed the passcode lock. The 2019–21 splash and undismissable follow-us pop-ups produced a smaller wave (206). Related: [[C246]] (no ads at all), [[C127]] (never to payers), [[C240]] (never on the completion moment), [[C082]] (ads in the free tier).")
add("C270", "free", "Free habit capacity that grows with continued check-ins — an earned cap reads as generosity, not as a wall",
    "Report 52 (ShineDay / 小日常): from 2025 the free habit quota grows as the user keeps checking in — 'keep checking in and it gives you more habit slots' (5★); 'I thought it was capped at 8, then found it grows with use' (4★); the design called 'very kind' (5★). The free-quota complaint PAY_CAP5 fell from 8.2% of reviews (2018) and 7.1% (2020) to 0.6% in 2026 — the only monetisation theme with a sustained, monotonic decline — though it was already falling 5.3% → 3.3% in 2021–24, so the mechanic is consistent with the decline, not proven to cause it. Report's M2: keep it and explain it on the paywall, because only reviewers who notice it praise it. Related: [[C007]] (fixed generous cap), [[C222]] (opt-in pressure valve on a hard cap), [[C219]] (concurrent, never lifetime).")
add("C271", "product-rule", "One membership at one price across every platform the app ships on — never sell the same entitlement twice or price it differently by store",
    "Report 52 (ShineDay / 小日常): the membership is sold separately on Android and iOS, at different prices and with different logins (QQ on Android, WeChat on iOS) — 49 reviews combine an Android mention with a tier or restore failure (mean 2.80); 'only after buying did I find Android membership must be bought separately'; 'iOS lifetime 88, Android 48? Where's the justice' (Feb 2026); the iOS free quota was also tighter than Android's ('on Android I could add a dozen, why treat us differently?'). PAY_TIERS carries the highest payer lift in the corpus (×5.11). Report's M5: price parity or a single cross-platform membership (platform-fee constraints noted). Related: [[C251]] (platform parity), [[C033]] (restore), [[C035]] (account).")

ext("C001", " Report 52: year statistics moved from free to VIP at year-end December 2025 (PAY_WALL 12 and PAY_REGRESS in one month, 15 reviews since Nov 2025); the monetisation history is 'a sequence of re-scopings of what was already owned' (one-time → tiers → subscription 2020; free themes → paid → free; free year stats → VIP; ad-free for all → ¥8) and each re-scoping produced its own complaint wave; the money-grab theme (183, mean 1.36, 86.3% 1★) is triggered 'almost always [by] a re-scoping or an unexpected charge, rarely the price level itself'.")
ext("C002", " Report 52: a 4.25★ written corpus (4.78 public, 562,951 ratings) whose reviews turn negative almost entirely over how it makes money — monetisation friction 2,496 (12.10%, 2.98) and ads 885 (2.46) — while aesthetic praise is 3,537 (4.80) and requests come from satisfied users (4,160 at 4.38).")
ext("C003", " Report 52: a lifetime option drives the strongest payer segment (PAY_LIFETIME lift ×7.39, 199 lifetime buyers at 4.36; 'one time purchase instead of a subscription'); lifetime was withdrawn for subscriptions in 2020 and re-offered at ¥88; honoured lifetime memberships produce the highest-mean theme above 100 reviews (DEV_TRUST 213, 4.93 — 'it said: you are a lifetime member. I nearly cried').")
ext("C004", " Report 52: payers find the price fair (PAY_PRICE_OK 256 at 4.86, payer lift ×4.58; 'less than a Starbucks for a good mood every day', 54 votes) about as often as non-payers call it too high (254 at 3.28); outside mainland China price is praised, not resisted (US PAY_PRICE_OK 23 outnumbers every price complaint combined).")
ext("C006", " Report 52: 'product manager, please don't add features blindly — restraint, restraint' (Aug 2026); to-dos, focus timer and AI titles are accepted but ranked below check-in speed; a crowded home screen (DES_DENSE 427, 1.4–3.9% every year) is the persistent fear.")
ext("C007", " Report 52: the free quota (most often 5; 3, 4, 6, 8 and 10 also reported across cohorts) is the first wall and the persistent friction — PAY_CAP5 888 (4.30%, 2.96), 199 of them 5★ ('the quota is fine, the app is lovely'); a February 2020 install surge produced 51 quota complaints and 57 one-stars in one month.")
ext("C009", " Report 52: premium icons, themes and some colours are paid and are both a purchase reason (161 payers at 4.50; DES_THEME lift ×3.65) and the top payer request (DES_ICON_WANT 561, lift ×2.83) — icons removed in 2024 and 2026 are asked back.")
ext("C011", " Report 52: year statistics moved behind VIP in Dec 2025 and drew a one-month complaint window; the report's M3 test is a free basic year summary with a paid detailed report, a split one reviewer asked for verbatim.")
ext("C019", " Report 52: bad habits that deduct reward points (78, weak, mean 4.8).")
ext("C022", " Report 52: Apple Watch check-in requested every year since 2019 (PLAT_WATCH 256, 1.24%, 4.52) — 'one reviewer bought a Watch for this app'.")
ext("C023", " Report 52: 'Maybe the most important features of ShineDay are its widgets. Being able to check off completed habits without opening the app' — when iOS 14 replaced tap-to-check with a ring that opens the app (Oct 2020) 55 widget-bug reviews arrived in one month; check-in was removed from the widget again in 2026.")
ext("C025", " Report 52: students without money are a named barrier ('forty-plus yuan, any conscience?', Grade 7; '¥30 when I was a student, ¥80 now').")
ext("C026", " Report 52: 2018 purchase flow broken — 112 billing reviews that year, including no Alipay or WeChat Pay.")
ext("C027", " Report 52: incomplete English — notifications, pop-ups and ads still in Chinese on English devices — is the single largest theme in every eligible non-Chinese storefront (us 22.30%, ca 22.95%, au 20.75%; English-primary 22.1% at mean 3.00) and Traditional Chinese is missing in Taiwan (22.89%); unfixed since a 2020 peak; the ADHD / Focus store subtitle reaches a population that cannot read the app.")
ext("C029", " Report 52: 2018–2020 billing defects (261, 83.5% in those years: purchases that spin forever, double charges, ¥12 shown but ¥31 charged); a gb 'lifetime' purchase billed as £12.99/month (2023); a tw buyer of the NT$390 lifetime unlock charged NT$220 when the concurrent trial converted (Aug 2026); an SMS login that subscribed a user to ¥55/month of carrier services (single report, legal exposure).")
ext("C030", " Report 52: sync is iCloud-only and fails across iPhone and iPad (147 reviews, 0.71%); reviewers ask for account-based sync (132).")
ext("C031", " Report 52: crashes arrive in release waves — 175 of 412 crash reviews (42.5%) in six of 110 months (Jul 2018, Oct 2019, May 2023, Sep 2024, Apr 2025, Sep 2025), roughly every 12–18 months, three of them destroying data; a launch crash on iOS 14.x for 20+ days despite a stated iOS 14 floor.")
ext("C033", " Report 52: PAY_RESTORE 190 (0.92%, 2.61; payer lift ×3.21) — an iPhone membership not recognised on iPad, memberships lost after reinstall, and a reinstall path where restoring one's own data asks for a membership that does not restore.")
ext("C034", " Report 52: DATA_LOSS 229 (1.11%, 2.73; 37.1% 1★) persistent every year; 56 tie loss to an update or crash — 'four years of to-do records all gone… I bought lifetime membership for this'; payers with data loss average 1.73.")
ext("C035", " Report 52: WeChat login cannot be bound on the Mac build for five years (12 reviews, among the most-upvoted) and QQ vs WeChat logins split Android and iOS memberships.")
ext("C036", " Report 52: support silence rises with each crash wave (SUP_BAD 184, 2.33; payers ×4.53 at 1.92) across e-mail, WeChat, Weibo and Xiaohongshu; a support address that bounces; fast fixes are among the strongest praise (SUP_GOOD 148 at 4.93: a purchase crash fixed the next day, a request shipped within days).")
ext("C039", " Report 52: reminders were why people installed (and in 2017 what they reviewed to unlock), so REM_FAIL carries a 3.62× payer lift — silent mode kills the sound, reminders keep firing after the habit is done (23 votes), archived habits still remind, changed sounds revert.")
ext("C040", " Report 52: widget defects 454 (2.20%), 62.8% in 2020–21; a widget renders blank on iOS 26 Clear / Tinted home screens.")
ext("C042", " Report 52: medication and chronic-illness logging named in reminder praise (an IVF medication schedule; a chronic-illness patient agitated by ads); the ADHD subtitle has only 6 supporting reviews (0.03%) in a 20,634-review Chinese corpus.")
ext("C043", " Report 52: monthly, every-other-day and N-per-week rules (299); weekly-N habits spoil a '100% day'.")
ext("C044", " Report 52: a Mac build exists but cannot bind the WeChat account the membership lives on.")
ext("C050", " Report 52: to-dos (小事) shipped ~2024 and rose to 3.0% of that year's reviews — welcomed, then sorting and hiding regressions.")
ext("C051", " Report 52: Android build exists but membership, price and login differ (PLAT_ANDROID 195, 3.53).")
ext("C052", " Report 52: 光芒值 'sunshine points' earned per check-in and exchanged for self-set wishes — 312 (1.51%, 4.65), rising from under 1% before 2021 to 1.9–3.1% after; praised as a way to delay spending and curb impulse buying; requests for separate point currencies and for multi-check habits to earn points.")
ext("C054", " Report 52: a 2017 review-to-unlock gate (reminders unlocked by writing a review, with a length check) produced 462 unlock reviews, 427 in 2017, all 15 busiest days of nine years, keyboard-mash filler and 5★ reviews reading 'please stop forcing people to write reviews' — the launch year is unusable as a baseline.")
ext("C060", " Report 52: a studio family (布谷布谷, 须臾, 青子记账, 千结) with common cross-purchasers (USER_CROSSAPP 230, 4.57, payer lift ×3.49).")
ext("C061", " Report 52: supporting an indie developer is a named purchase trigger (DEV_TRUST ∩ paid 52 at 4.98; bought 'so the app can keep running').")
ext("C064", " Report 52: a nine-year price ladder ¥6 → ¥12/¥18 → ¥88 lifetime → ¥98, with a Nov 2019 tier rise (¥8→¥12, ¥12→¥18) and price rise complaints 42 (3.19).")
ext("C065", " Report 52: payers are the most satisfied segment (306 value-reporting payers at 4.92) until something breaks — entitlement broke 80 at 2.62, data loss 33 at 1.73, support silence 52 at 1.92, reliability 286 at 3.04.")
ext("C066", " Report 52: a pomodoro / count-up focus timer linked to habits (FOCUS 390, rising to 5.5% of 2026) — accepted but ranked below check-in speed; the app-block list works backwards; a solid-red focus page redesign (Aug 2026) clashed with the calm style.")
ext("C075", " Report 52: time-of-day scenes are loved and confusing ('two + buttons').")
ext("C080", " Report 52: dark mode requested (70, weak).")
ext("C082", " Report 52: the counter-case at scale — a nine-year Chinese tracker ran splash ads (2019–21, AD_NEG 3.4% / 2.8%) and in-flow ads from June 2025 (35.0% of reviews in six months, the lowest month in nine years); a ¥8 one-time ad-free SKU is accepted by those who find it ('but 8 yuan removes ads forever', 5★) and read as the motive for hostile ads by others; recovered to 5.8% in 2026 with complainants possibly churned. See [[C269]].")
ext("C085", " Report 52: untranslated Chinese UI plus a precise-location request led a US reviewer to title the review 'Malware?? DO NOT INSTALL'; 'still using location after uninstall'; a dead privacy-policy link.")
ext("C094", " Report 52: from 2020 a review prompt on the Nth launch ('第500次打开', '第3000次打开') — 40 mentions at 4.50; complaints when it fires before use and when it still insists after the user paid ¥8 to remove ads.")
ext("C096", " Report 52: a passcode lock that an ad dismissal bypasses (2025) — security-relevant despite being a single report.")
ext("C099", " Report 52: countdown / anniversaries among 'everything else' requests (395).")
ext("C110", " Report 52: 2026 onboarding requires picking 5 habits and choosing a 3-day trial; reviewers ask to skip both and for a visible back control on every paywall screen (M6).")
ext("C113", " Report 52: price seen as unstable — ¥18 / ¥28 / ¥88 reported in the same months, a ¥12 buyer finding lifetime at ¥98.")
ext("C119", " Report 52: redesign complaints arrive in release bursts — Oct 2020 widgets (26), Jun 2021 a Success / Pending / Fail sheet on every check-in (29), Sep–Dec 2024 compressed layout (31), Feb–Apr 2026 AI note titles (20), Aug 2026 red focus page (12) — each about losing speed or calm, not a feature; a 5★ reviewer proposes decoupling front-end style from feature iteration; the report's R1: redesigns behind a setting for at least one release.")
ext("C127", " Report 52: 40 paying reviewers (including legacy lifetime and ¥8 ad-free buyers) still saw ads — 'I bought lifetime membership before… an ugly ad pops up at every check-in'; F2: verify the entitlement before rendering the first ad.")
ext("C141", " Report 52: iPad HD version, landscape and split view requested (380, 63.7% in 2018–20).")
ext("C143", " Report 52: multiple check-ins per day (237 — water × 8, meds morning and evening) and multi-check habits that force a detail sheet even with one-tap enabled.")
ext("C155", " Report 52: a ¥68 buyer asked for a refund after a Dec 2024 redesign removed to-do sorting.")
ext("C156", " Report 52: release waves recur on old OS versions (v2.41 on iOS 13 biometric unlock; iOS 14.x launch crash for 20+ days) — F5: a release gate for old iOS and data migrations, staged rollout, crash-safe local store before schema changes; target no month with ≥20 crash reviews.")
ext("C167", " Report 52: themes sold separately (~¥6 each, 2018) then made free for members — a buyer was refunded.")
ext("C170", " Report 52: night owls' check-ins after midnight land on the next day — 50 text mentions ask to end the day at 2–4 am.")
ext("C172", " Report 52: check-in notes are the largest unmet need (JRNL_WANT 668, 3.24%, very strong) and a praised micro-diary with 'on this day in past years' (234, 4.85).")
ext("C175", " Report 52: an update that could not be downloaded or reinstalled produced 12 reviews on one day (31 Jul 2023); BUG_UPDATE 524 (2.54%, 3.26).")
ext("C177", " Report 52: two one-time tiers (小太阳 / 大太阳) with no upgrade credit between them; tier confusion carries a ×5.11 payer lift.")
ext("C178", " Report 52: SOC_NOSOCIAL 120 (4.85, payer lift ×4.55; 100% mainland) — 'please never add social features, I just want to check in quietly by myself' (48 votes); 'no ads, no noise' praise rose in 2024–26 as reviewers compared the new ad experience.")
ext("C185", " Report 52: the look converts within days — 'Downloaded, five minutes later bought premium'; 'within 24 hrs of the trial I bought lifetime' — while cuteness praise fell 18.5% (2017) → 2.9% (2026) and calm / clean held.")
ext("C186", " Report 52: in 2020 buyers were told their lifetime purchase is now annual; PAY_REGRESS 75 at 2.15; M1: grandfather every past entitlement explicitly ('you bought X in 2019; you keep X') — 'Honouring old purchases costs almost nothing and is the single strongest trust signal in these reviews'.")
ext("C199", " Report 52: calendar integration requested (41, weak).")
ext("C173", " Report 52: sub-tasks requested (62, weak).")
ext("C020", " Report 52: data export requested (59, weak).")
ext("C202", " Report 52: a minority asks for accountability buddies (74, weak) against a larger 'never add social' group (120).")
ext("C207", " Report 52: the 2026 'habit ball' collection could not be hidden.")
ext("C208", " Report 52: photos in check-in logs and notes are 'the most repeated single ask' within the largest request theme — 'please add photos to check-ins!! I really want photos!!!' (2017 → 2025).")
ext("C223", " Report 52: 'tap again to undo' was removed (2021) and a mistaken tap can only be marked 'failed'.")
ext("C240", " Report 52: an ad after every check-in (2025) and a status sheet added to the check-in tap (2021) are both named as the moment the app broke.")
ext("C246", " Report 52: see [[C269]] — the 2025 in-flow ad wave drove 35.0% of six months' reviews at mean 3.70.")
ext("C255", " Report 52: Chinese-reading users on English systems ask for an in-app language setting independent of iOS; the Traditional setting in Taiwan still shows mostly Simplified.")
ext("C258", " Report 52: 'repeat until done' and a silent-mode 'strong reminder' alarm among reminder requests (588).")
ext("C262", " Report 52: 32 reviews say restoring their own data after a crash-reinstall required buying membership — 'after reinstalling I bought lifetime membership to restore my data, and restoring crashed the app'; F3: never gate restoring a user's own backup.")
ext("C264", " Report 52: 'a check-in used to be one tap… now it's at least two' (Jun 2021 status sheet, 29 reviews in a month); every added step on the check-in was reviewed negatively within days; R2: protect one-tap check-in and one-tap undo.")
ext("C267", " Report 52: AI-generated note titles (Feb–Apr 2026) that could not be switched off — every review mentioning them negative.")
ext("C268", " Report 52: autosave so an interrupted note isn't lost, and no forced or AI titles.")

M = {
 "R52-006":["C054"], "R52-007":["C094"], "R52-010":["C218"], "R52-012":["C269","C246","C082"], "R52-014":["C269","C240"], "R52-015":["C127"],
 "R52-016":["C082"], "R52-017":["C246","C103"], "R52-018":["C082","C269"], "R52-019":["C007","C002"], "R52-021":["C270"], "R52-022":["C271","C007"],
 "R52-023":["C065","C003","C004"], "R52-024":["C065"], "R52-025":["C262","C034","C033"], "R52-026":["C033","C271","C030"], "R52-027":["C271","C051"],
 "R52-028":["C030","C033","C141"], "R52-029":["C044","C035"], "R52-030":["C031","C156","C175"], "R52-031":["C175"], "R52-032":["C034","C175"],
 "R52-033":["C006","C119"], "R52-034":["C119","C264"], "R52-035":["C119"], "R52-036":["C178","C131"], "R52-037":["C027"], "R52-038":["C027","C085"],
 "R52-041":["C186","C003"], "R52-042":["C052"], "R52-043":["C269","C127","C262","C271","C156","C119","C027"],
 "R52-045":["C060"], "R52-047":["C177","C064"], "R52-048":["C186"], "R52-049":["C029","C177"], "R52-050":["C113","C064"], "R52-051":["C001","C011","C234"],
 "R52-052":["C110","C063"], "R52-054":["C167","C009"], "R52-055":["C262","C020"], "R52-056":["C082"], "R52-057":["C066"], "R52-058":["C022","C044","C051"],
 "R52-059":["C186","C001"], "R52-060":["C042"], "R52-064":["C269","C145"], "R52-065":["C007"], "R52-066":["C001"], "R52-067":["C031","C175"],
 "R52-068":["C040"], "R52-069":["C039","C065"], "R52-070":["C029"], "R52-071":["C029"], "R52-072":["C119","C006"], "R52-073":["C001","C186"],
 "R52-074":["C036"], "R52-075":["C027"], "R52-076":["C085","C096"], "R52-077":["C006"], "R52-078":["C185"], "R52-080":["C059"],
 "R52-081":["C052","C069"], "R52-082":["C178","C127"], "R52-083":["C039","C042"], "R52-085":["C003"], "R52-086":["C075"], "R52-087":["C024","C038"],
 "R52-088":["C050"], "R52-091":["C172","C208"], "R52-092":["C258","C074"], "R52-093":["C009","C167"], "R52-094":["C011","C012"], "R52-095":["C141"],
 "R52-096":["C066"], "R52-097":["C023"], "R52-098":["C143"], "R52-099":["C010","C170","C223"], "R52-100":["C043"], "R52-101":["C030","C035"],
 "R52-102":["C019","C052"], "R52-103":["C099"], "R52-106":["C123"], "R52-107":["C035"], "R52-108":["C004","C064"], "R52-109":["C073","C227"],
 "R52-110":["C264"], "R52-111":["C223","C262"], "R52-112":["C207","C006"], "R52-113":["C052"], "R52-115":["C043","C143","C170"], "R52-116":["C043"],
 "R52-117":["C170"], "R52-118":["C039"], "R52-119":["C039"], "R52-120":["C172","C208","C268"], "R52-121":["C267","C006"], "R52-122":["C268"],
 "R52-124":["C023","C040"], "R52-125":["C040"], "R52-126":["C006","C050","C066"], "R52-127":["C066"], "R52-128":["C042"],
 "R52-138":["C065","C034","C186"], "R52-144":["C185"], "R52-145":["C007"], "R52-146":["C167"], "R52-147":["C061"], "R52-148":["C003"], "R52-149":["C082"],
 "R52-151":["C026"], "R52-152":["C025"], "R52-153":["C186"], "R52-154":["C065"], "R52-155":["C029","C109","C036"], "R52-156":["C155","C212"],
 "R52-157":["C271","C127","C264","C036","C009","C208","C022"], "R52-159":["C062","C027"], "R52-160":["C027"], "R52-163":["C178"],
 "R52-165":["C027","C004"], "R52-167":["C027"], "R52-169":["C027"], "R52-173":["C027","C255"],
 "R52-180":["C270","C082"], "R52-182":["C175","C031"], "R52-183":["C007"], "R52-184":["C155","C119"],
 "R52-188":["C269","C240"], "R52-189":["C127"], "R52-190":["C262"], "R52-191":["C033","C035","C271"], "R52-192":["C156","C175"], "R52-193":["C096"],
 "R52-194":["C027"], "R52-196":["C186"], "R52-197":["C270"], "R52-198":["C011"], "R52-199":["C082","C269"], "R52-200":["C271"], "R52-201":["C110","C203"],
 "R52-203":["C119"], "R52-210":["C080","C199","C202","C173","C020"], "R52-204":["C264","C223"], "R52-205":["C022","C023"], "R52-206":["C036"], "R52-209":["C110","C203","C063"],
}
# unattached (nuance register): 001 identity, 002–005/008/009/011 method and caveats, 013 window table, 020 cap-number drift, 039/040 outcomes and tenure,
# 044/046/053 inventory and price-ladder tables, 061–063 theme tables, 079 outcome types, 084 mixed table, 089 switchers, 090 request table, 104/105 minor themes,
# 114 daily card, 123 platform table, 129–137/139–143 rating and payer tables, 150 barrier table, 158/161/162/164/166/168/170/171 country tables,
# 174–179/181/185–187 trend tables and caveats, 195/202 recommendation tables, 207 research questions, 208 priority order
cards = [json.loads(l) for l in open("Tools/prd_ledger/52/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/52/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
