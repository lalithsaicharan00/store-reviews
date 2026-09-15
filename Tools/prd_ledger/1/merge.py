"""Stage 3 merge for report 1. Creates the first canonical points and attaches cards.
A card may attach to more than one canonical point; cards attached to none form the nuance register."""
import json

C = {}  # id -> (section, title, statement)
def add(cid, section, title, statement):
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C001","product-rule","Never move a free feature behind the paywall","Every paywall regression produced a lasting rating drop; pick the free tier once and hold it.")
add("C002","product-rule","Ratings follow the offer, not the feature set","Trust (pricing, billing, support, delivering what was paid for) moves ratings more than features do.")
add("C003","product-rule","Lead with a one-time lifetime purchase","People buy because it is not a subscription; lifetime is the strongest pricing signal.")
add("C004","product-rule","Price low and fair, anchored against subscription competitors","'Cheaper than a coffee' framing produces near-perfect ratings; know the price anchors users cite.")
add("C005","do","Know which competitors buyers compare against","Buyers shop around before paying; competitor names and price anchors appear in reviews.")
add("C006","product-rule","Stay minimal and ad-free","Simple/clean is table stakes and the most praised trait; 'no ads' is the best-rated topic; every feature request comes with 'don't make it complicated'.")
add("C007","free","Generous fixed habit cap (or unlimited) — never change it","A low or drifting free cap is the #1 monetization complaint; 'unlimited' also sells, so the level is a decision but the stability is not.")
add("C008","free","Daily check-in and one basic reminder per habit are free","Core loop must be free; it draws no complaints when it is.")
add("C009","free","Icons, colours and basic widgets are free","Loved, drives 5★, and re-paywalling widgets backfired.")
add("C010","free","Backfill missed days — a free window (7 days) with paid beyond","Users accept a bounded free backfill window.")
add("C011","paid","Weekly / monthly / yearly reports","The #1 stated reason people pay; under-counted by keywords, dominant in the qualitative read.")
add("C012","must-have","Week / month / year grid views","'Filling the squares' is the retention mechanic and emotional payoff.")
add("C013","paid","Cloud sync / multi-device as the paid differentiator","Strongest true differentiator among buyers (lift ×9.8).")
add("C014","paid","Multiple reminders per habit","Moderate purchase reason; first reminder stays free.")
add("C015","research","Shared / group habits","Strong purchase driver where it exists, but the worst-executed feature — demand is proven, execution is the risk.")
add("C016","undecided","Skip / holiday mode","Minor purchase factor; free or paid open.")
add("C017","research","Passcode lock","Minor; decide whether needed at all.")
add("C018","undecided","App-icon themes","Minor purchase factor.")
add("C019","research","Quit-habit / bad-habit mode","Well received where shipped; see Quit Habit Decision research doc.")
add("C020","free","Data export / backup / CSV","Requested a lot from happy users, rarely a purchase trigger — charging for it generates requests, not revenue.")
add("C021","paid","Apple Health integration","Small volume, very high purchase intent.")
add("C022","paid","Apple Watch app (done properly: timer, two-way sync)","Small volume, very high purchase intent; a half-built Watch app draws 2–3★.")
add("C023","undecided","Interactive widget check-off","Mark done without opening the app; small volume, very high intent.")
add("C024","undecided","Streaks / gamification","High-priority praise, moderate purchase factor.")
add("C025","do","Scholarship / hardship / discount program","The cleanest 5★ generator in report 1 (91 of 101 mentions 5★); also works around broken payment rails; never switch it off.")
add("C026","do","Handle markets where card payment fails (RU, AR, TR, DZ, PK)","Users who want to pay cannot; a discount/hardship path doubles as the workaround.")
add("C027","do","Localise early — it unlocks revenue","Missing localisation is the biggest market-specific complaint and a stated purchase blocker; shipping a language visibly converts (Japan).")
add("C028","do","Culturally complete icon set and calendars","Islamic icons, disability icons, Hijri and lunar calendars, bigger fonts — cheap, and in markets already blocked by localisation.")
add("C029","must-never-break","Billing must be exactly right","Wrong amount, double charge, surprise renewal are the fastest route to 1★ (×21 lift); single price shown, no trial-to-charge traps, refunds honoured, receipts clear.")
add("C030","must-never-break","Sync must work — and prove it","The paid feature that breaks most; sync failure is ×12.8 over-represented among buyers.")
add("C031","must-never-break","Crashes / launch failures","Largest complaint by volume; a two-day launch crash produced more 1★ than years of minor bugs.")
add("C032","must-never-break","Year-end / peak-season robustness","The year-end report crashed five New Years in six; never ship risk or lock features in late December.")
add("C033","must-never-break","Restore purchase must work","Charging and not delivering is the second-fastest route to 1★ (×13.9).")
add("C034","must-never-break","Data must never be lost on update, reinstall or phone change","Data loss is ×10.6 over-represented among buyers; local-only storage is the cause.")
add("C035","must-have","Account system from day one","Root cause of lost purchases, lost data and failed sync; requests rise as users change phones.")
add("C036","must-have","A support channel that exists and answers","'No support channel' is ×34.7 over-represented among buyers and the second-worst-rated complaint.")
add("C037","research","Family plan","Demand exists (people bought it); report 1's failed only through discoverability (Apple Family Sharing with no in-app affordance).")
add("C038","must-never-break","Streak and statistic counts must be correct (incl. DST / timezone)","Miscounts are ×10.2 over-represented among buyers.")
add("C039","must-never-break","Reminders fire reliably, once","Reminders that work are a top praise item; not firing or spamming is a 1★ driver.")
add("C040","must-never-break","Widgets must not go blank, stale or disagree with the app","Broken widget is ×7.8 on 2★.")
add("C041","must-never-break","Editing a habit never wipes its history","Multi-year bug; fixing it brought reviewers back to raise their rating.")
add("C042","do","Aim at ADHD / neurodivergent users, students, medication & chronic-illness trackers","Highest-fit, highest-satisfaction audiences (ADHD 7% of US at 4.79; students 4.87).")
add("C043","must-have","Flexible / custom frequency","Every X days, specific weekdays, bi-weekly, quarterly, yearly, total-over-a-window — the #1 unmet functional need and highest 4★ lift.")
add("C044","paid","Mac / desktop / web app","Strongest 3★ driver; users volunteer to pay extra for it.")
add("C045","undecided","Grouping / folders / tags / multiple profiles","#2 feature request: me, kids, pet, work.")
add("C046","undecided","Shortcuts / Siri / URL scheme / API","Power users who evangelise.")
add("C047","undecided","Cumulative totals and total-days counter","'47 hours read this year'; total days instead of consecutive to reduce streak anxiety.")
add("C048","undecided","Flexible units / partial progress","Drag to 60% instead of a binary tick — a named reason for choosing over competitors.")
add("C049","research","Mood tracker / journal","Meaningful praise where shipped; mentions rose after launch.")
add("C050","research","One-off to-dos alongside habits","Emerging request.")
add("C051","research","Android version","Requested; cross-platform continuity matters to switchers.")
add("C052","research","Points / rewards / wish list","Weak request; one proposes a cash-stake mode.")
add("C053","undecided","Custom time-of-day segments","Beyond morning/afternoon/evening — shift workers.")
add("C054","dont","Never run incentivised / review-for-premium campaigns","Bought rank and a fake average, 0.86% purchase signal, reputational backlash, unreadable data.")
add("C055","dont","Never gate or delete reviews","Users catch it and call it a ToS violation.")
add("C056","dont","Don't build AI features on demand grounds","0.011% demand; users ask for the opposite.")
add("C057","do","Offer a non-pastel / premium design option","Recurring critique from men and users wanting a premium look.")
add("C058","do","Discovery runs through social video, Reddit, therapists (US) and Xiaohongshu / Bilibili (CN)","Plan marketing around where users say they found the app.")
add("C059","do","Be visibly responsive; fixes bring reviewers back","Users who see their bug fixed return to raise their rating.")
add("C060","do","Cross-sell an app family on brand trust","Under-used monetization asset.")
add("C061","do","'Support the devs' goodwill converts","Small, pure-margin, mean 4.69.")
add("C062","do","Weight English-speaking rich markets; volume ≠ revenue","Purchase-signal density is 8.5× higher in the US than China; BR/MX/ES/FR volume is localisation-blocked.")
add("C063","research","Free trial before purchase","Weak but present complaint.")
add("C064","research","Price level — where 'fair' turns into 'too expensive'","Both coexist for one price; split follows market, payment rails and year.")
add("C065","must-never-break","Paying customers are the highest 1★ risk — every paid feature must work","Paid cohort rates a full point lower; 28% of payers leave 1–2★; confirmed buyers ×6.7 on 1★.")
add("C066","undecided","Focus timer","Meaningful in the US, emerging globally.")
add("C067","do","Fitness / health tracking use case","Very strong US use case.")
add("C068","research","Parents tracking kids","Distinct use case; ties to profiles.")
add("C069","free","Check-off sound and haptic","Named as a reason to keep coming back.")
add("C070","do","Use the language users use: Atomic Habits, 75 Hard","Framing seen in US reviews.")

M = {
 "R01-002":["C054"], "R01-004":["C002"], "R01-005":["C055"], "R01-006":["C003"], "R01-007":["C004","C064"],
 "R01-008":["C007"], "R01-009":["C007"], "R01-010":["C008"], "R01-011":["C009"], "R01-012":["C010"],
 "R01-013":["C011"], "R01-014":["C007"], "R01-015":["C013","C030"], "R01-016":["C014"], "R01-017":["C015"],
 "R01-018":["C016"], "R01-019":["C017"], "R01-020":["C018"], "R01-021":["C019"], "R01-022":["C020"],
 "R01-023":["C062"], "R01-024":["C006"], "R01-025":["C013"], "R01-026":["C005"], "R01-027":["C024"],
 "R01-028":["C021"], "R01-029":["C022"], "R01-030":["C023"], "R01-031":["C003"], "R01-032":["C004"],
 "R01-033":["C011"], "R01-034":["C061"], "R01-035":["C025"], "R01-036":["C026"], "R01-037":["C027"],
 "R01-038":["C065"], "R01-039":["C062"], "R01-040":["C065"], "R01-041":["C029"], "R01-042":["C031"],
 "R01-043":["C037"], "R01-044":["C033"], "R01-045":["C034"], "R01-046":["C036"], "R01-047":["C065","C030"],
 "R01-048":["C035"], "R01-049":["C038"], "R01-051":["C001"], "R01-052":["C001","C011","C013","C014","C016"],
 "R01-053":["C001","C007"], "R01-054":["C019"], "R01-055":["C049"], "R01-056":["C001","C009","C031"],
 "R01-057":["C001","C032"], "R01-058":["C007"], "R01-059":["C001"], "R01-060":["C006"], "R01-061":["C042"],
 "R01-062":["C006","C003","C025","C042"], "R01-063":["C029"], "R01-064":["C033","C037","C030","C065"],
 "R01-065":["C031"], "R01-066":["C039"], "R01-067":["C065"], "R01-068":["C040"], "R01-069":["C027"],
 "R01-070":["C007"], "R01-071":["C064"], "R01-072":["C043"], "R01-073":["C044"], "R01-074":["C045"],
 "R01-075":["C046"], "R01-076":["C027","C021","C022","C030"], "R01-077":["C006"], "R01-078":["C039"],
 "R01-079":["C009"], "R01-080":["C009"], "R01-081":["C024"], "R01-082":["C011"], "R01-083":["C048"],
 "R01-084":["C019"], "R01-085":["C049"], "R01-086":["C012"], "R01-087":["C069"], "R01-088":["C060"],
 "R01-089":["C005","C004"], "R01-090":["C031"], "R01-091":["C015"], "R01-092":["C041","C059"], "R01-093":["C038"],
 "R01-094":["C036"], "R01-095":["C032"], "R01-096":["C031"], "R01-097":["C040"], "R01-098":["C022"],
 "R01-099":["C044"], "R01-100":["C039"], "R01-101":["C020"], "R01-102":["C045","C068"], "R01-103":["C050"],
 "R01-104":["C023"], "R01-105":["C043"], "R01-106":["C051"], "R01-107":["C046"], "R01-108":["C044"],
 "R01-110":["C047"], "R01-111":["C052"], "R01-112":["C053"], "R01-113":["C047"], "R01-114":["C021"],
 "R01-115":["C028"], "R01-116":["C057"], "R01-117":["C062"], "R01-118":["C067"], "R01-119":["C066"],
 "R01-120":["C042"], "R01-121":["C058"], "R01-122":["C070"], "R01-123":["C003"], "R01-124":["C027"],
 "R01-125":["C062","C042"], "R01-126":["C062"], "R01-127":["C027"], "R01-128":["C027"], "R01-129":["C027"],
 "R01-130":["C027","C028"], "R01-132":["C027"], "R01-133":["C029"], "R01-134":["C037"], "R01-135":["C062"],
 "R01-136":["C054","C062"], "R01-137":["C054"], "R01-138":["C007"], "R01-139":["C054"], "R01-140":["C035","C034","C051"],
 "R01-141":["C058"], "R01-142":["C059"], "R01-143":["C058"], "R01-144":["C063"], "R01-145":["C068"],
 "R01-146":["C042"], "R01-147":["C067"], "R01-148":["C066"], "R01-150":["C003"], "R01-151":["C064"],
 "R01-152":["C029"], "R01-153":["C031"], "R01-154":["C042"], "R01-155":["C049","C021"], "R01-156":["C009"],
 "R01-157":["C035"], "R01-158":["C002"], "R01-159":["C027","C007","C059"], "R01-160":["C002"], "R01-161":["C056"],
 "R01-162":["C029"], "R01-163":["C035"], "R01-164":["C030"], "R01-165":["C032"], "R01-166":["C001"],
 "R01-167":["C003"], "R01-168":["C004"], "R01-169":["C025"], "R01-170":["C007"], "R01-171":["C037"],
 "R01-172":["C043"], "R01-173":["C023"], "R01-174":["C045"], "R01-175":["C047"], "R01-176":["C041"],
 "R01-177":["C021","C022"], "R01-178":["C044"], "R01-179":["C046"], "R01-180":["C042"], "R01-181":["C006"],
 "R01-182":["C057"], "R01-183":["C027"], "R01-184":["C056"], "R01-185":["C054"], "R01-186":["C055"],
 "R01-193":["C034"], "R01-194":["C038"], "R01-196":["C006"], "R01-197":["C007"], "R01-198":["C064"],
}
# deliberately unattached (nuance register / app-specific): 001 003 050 109 131 149 187 188-192 195

cards = [json.loads(l) for l in open("Tools/prd_ledger/1/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C, (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/1/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical points; {len(cards)-len(null)} cards attached; {len(null)} in nuance register: {null}")
empty = [k for k, v in C.items() if not v["cards"]]
print("canonical points with no cards:", empty)
