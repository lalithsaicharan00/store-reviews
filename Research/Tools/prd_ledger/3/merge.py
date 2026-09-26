"""Stage 3 merge for report 3."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def add(cid, section, title, statement):
    assert cid not in C
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C090","must-never-break","Destructive actions on widgets and quick surfaces need confirmation or undo","An un-undoable reset button on a Home Screen widget destroyed streaks by mis-tap and read as 'a visual cue to break the streak' — a safety issue in a recovery app.")
add("C092","do","Regional pricing","IN, TR, UA, BR, MX, SA reviewers name price as the only blocker; India likes the product and has not yet been asked a price it can accept.")
add("C093","dont","No upsell nagging without a 'never ask again' option","Full-screen interstitials, permanent banners and upsells before first value draw complaints even from 5★ users; a subscription launch with nagging cost ~3 points of 1–2★.")
add("C094","do","Ask for reviews well — tone converts; cadence and ignoring the OS opt-out backfire","A charming review request produced dozens of reviews; frequent prompts that ignore the iOS opt-out, especially to payers, read as 'scammy'.")
add("C095","must-have","Neutral, non-judgemental tone on failure","Reset without shame, no motivational pop-ups, keep history — the differentiation against apps that 'talk'.")
add("C096","must-have","Privacy and discretion stack","Face ID / passcode lock, no account, discreet app name, alternate icons — zero negative reviews in report 3 and category-critical for recovery users on family phones.")
add("C097","do","A tip / donate option","People asking to give money with no mechanism to do so.")
add("C098","free","Time-unit flexibility for counters (hours → years)","What makes day 1 survivable for a quit-habit user; zero 1–2★.")
add("C099","research","Countdown / 'days until' mode","Users want one app for count-up and count-down.")
add("C100","research","Money-saved counter","Standard in quit-smoking apps; named as the one thing missing.")
add("C101","research","Milestones, achievements, celebration","The largest positive-intent request in report 3 (2.21%, six years); shipped Aug 2026.")
add("C102","research","Inverse / 'good habit' mode for a counter","Recovery users want the number up; chore/ADHD users want it low — one counter, two mental models.")
add("C103","do","Recovery and harm-reduction users are a vulnerable surface","Alcohol, nicotine, self-harm (incl. minors), drugs, EDs, no-contact; monetisation moves land as 'preying on the vulnerable'; age rating is load-bearing.")
add("C104","dont","Never ship a paywall or feature-removal change silently","Undisclosed changes and 'it was a bug' replies that don't match what users see destroy trust for a year.")
add("C107","paid","Widget variants and customisation as the paid layer","Base single-counter widget free forever; multi-counter widgets, custom art, progress rings, reset-from-widget can be paid — and were report 3's #1 purchase trigger.")
add("C108","paid","Goals / targets","Tolerated behind the paywall (mean 4.05) and a stated purchase reason.")
# widen existing titles
C["C016"]["title"] = "Skip / holiday / pause mode (pause a habit or counter without losing history)"
C["C016"]["statement"] += " In report 3, pause/stop/archive is the highest-leverage missing feature (44 requests at mean 4.02, 'the only thing between me and 5★')."
C["C009"]["title"] = "Basic widgets, icons and colours are free"
C["C010"]["title"] = "Backfill missed days / edit start date"
C["C033"]["title"] = "Restore purchase and entitlements must work immediately"
C["C033"]["statement"] += " Lifetime buyers told to subscribe, subscribers who cannot find their tier, premium members still upsold."

M = {
 "R03-003":["C001"], "R03-004":["C006","C007","C009"], "R03-006":["C001"], "R03-008":["C009","C001"], "R03-009":["C001"],
 "R03-010":["C104"], "R03-011":["C103"], "R03-012":["C006","C082"], "R03-013":["C064","C003"], "R03-014":["C064","C033"],
 "R03-016":["C009","C001"], "R03-017":["C108"], "R03-018":["C008","C014"], "R03-019":["C009","C018"], "R03-020":["C020","C034"],
 "R03-021":["C046"], "R03-022":["C022"], "R03-023":["C007","C009","C017","C080","C096"], "R03-024":["C065"], "R03-025":["C107","C108"],
 "R03-026":["C029"], "R03-027":["C061","C004","C059"], "R03-028":["C065"], "R03-029":["C065","C001"], "R03-030":["C065","C033","C029"],
 "R03-031":["C033"], "R03-032":["C097"], "R03-033":["C003"], "R03-034":["C092"], "R03-035":["C093"],
 "R03-036":["C094","C088"], "R03-037":["C094"], "R03-038":["C001","C009"], "R03-039":["C033"], "R03-040":["C029"],
 "R03-041":["C093"], "R03-042":["C003","C097"], "R03-043":["C092"], "R03-045":["C007","C005"], "R03-046":["C098"],
 "R03-048":["C002"], "R03-049":["C006"], "R03-051":["C016"], "R03-052":["C006"], "R03-053":["C009"],
 "R03-054":["C007","C005"], "R03-055":["C096","C017"], "R03-056":["C095"], "R03-057":["C059"], "R03-059":["C064"],
 "R03-060":["C064"], "R03-061":["C008","C014"], "R03-062":["C022"], "R03-063":["C011"], "R03-064":["C045"],
 "R03-065":["C079","C080"], "R03-066":["C044"], "R03-067":["C099"], "R03-068":["C020"], "R03-069":["C015"],
 "R03-070":["C031"], "R03-071":["C010"], "R03-072":["C100"], "R03-073":["C027"], "R03-074":["C016"],
 "R03-075":["C090","C023"], "R03-076":["C034","C013"], "R03-077":["C101"], "R03-078":["C049"], "R03-079":["C103"],
 "R03-080":["C103"], "R03-081":["C042"], "R03-082":["C102","C019"], "R03-084":["C062"], "R03-085":["C062"],
 "R03-086":["C062"], "R03-087":["C064"], "R03-088":["C104","C001"], "R03-089":["C062"], "R03-090":["C092"],
 "R03-091":["C027"], "R03-095":["C003","C093"], "R03-096":["C001"], "R03-097":["C001","C093"], "R03-098":["C006","C007"],
 "R03-099":["C010"], "R03-100":["C031"], "R03-101":["C009","C107","C001"], "R03-102":["C034"], "R03-103":["C090"],
 "R03-104":["C033"], "R03-105":["C003","C097"], "R03-106":["C092"], "R03-107":["C093"], "R03-108":["C094"],
 "R03-109":["C016"], "R03-110":["C101"], "R03-111":["C049"], "R03-112":["C011"], "R03-113":["C099"],
 "R03-114":["C045"], "R03-115":["C102"], "R03-116":["C100"], "R03-117":["C007","C096","C005"], "R03-118":["C096"],
 "R03-119":["C095"], "R03-120":["C001"], "R03-121":["C103"], "R03-122":["C104"], "R03-124":["C013","C034"],
}
# unattached: 001 002 005 007 015 044 047 050 058 083 092 093 094 123
cards = [json.loads(l) for l in open("Tools/prd_ledger/3/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C, (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/3/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
from collections import Counter
print("points by report count:", Counter(len(x["reports"]) for x in C.values()))
