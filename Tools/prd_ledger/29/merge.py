"""Stage 3 merge for report 29."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C242","dont","Never monetise by routing the user's device or bandwidth for third parties — and never gate first launch behind any such opt-in","Report 29: a free tracker whose whole reputation was 'actually free' (46.99% of reviews) added a launch-screen prompt in May 2026 asking users to enable 'web indexing' — letting third parties use the phone's IP to download web data — in exchange for an ad-free experience. Every reviewer who described it gave 1★ ('This app now interrupts use unless you agree to run a malware proxy downloader'; 'Didn't get past the opening screen… No thanks'; 'You PAID for this free app'); two of three quit before using the product; a reviewer had already asked 'Am I trading off data privacy for this?'; the listing's privacy label ('analytics and diagnostics') does not obviously cover it. It turned the 1★ band from bugs into privacy in one half-year. If any consent-based monetisation is used, ask after first value, in plain language, reversible, never as a gate.")
add("C243","must-never-break","Date arithmetic must survive month boundaries and week-start conventions","Report 29: a month-rollover / weekday-offset bug was the dominant defect — 37 reviews (10.11%, mean 2.95 vs 4.73), 78.4% of them filed on days 28–3 against a 27.6% baseline ('On the last day of every month, the app has no idea what day it is… April 30 defaulted to Feb 28'; 'the 31st listed twice'; 'went backwards into April instead of forwards into July'; 'Monday thru Sunday… but the dates go Sunday thru Saturday'); it was 62.5% of all 3★ and 66.7% of 2★, peaked at 20.2% of 2025H1 and fell ~8× by 2026H1 with a residual weekday-offset tail; users taught each other to reinstall, which destroyed their local-only data. Test every date surface at month end, leap day and both week starts.")

ext("C001", " Report 29 (free limiting case, second corpus): 'it is actually free' is 46.99% of reviews (mean 4.83 vs 4.31), consistent at 42–69% across every top-five market and every income band; 'no subscription' is the highest-rated sub-theme in the report (44, mean 4.98); four 5★ reviewers publicly condition their loyalty on staying free ('as long as this continues I'm gonna use this app every day'; 'never change'); the report ranks never capping habit count and never adding a subscription among what not to change.")
ext("C003", " Report 29: the one explicit payment offer in a free app is 'please add widget support happy to pay for a lifetime subscription' — lifetime, attached to a new capability; the report's proposed test is a one-time Pro unlock for widget + dark mode + flexible frequency that touches nothing existing users have.")
ext("C007", " Report 29: 12 reviews (mean 4.92) praise the absence of a habit cap by naming competitors' caps — 'they all made me pay for more than 3 habits'; 'lets you have more than 6 habits'; 'up to 15 to 20 habits without getting charged' — the specific mechanism by which a free app wins comparison shoppers; 'do not cap habit count' is 'the single most protected property in the corpus'.")
ext("C214", " Report 29: 52 comparison shoppers (14.21%) arrived after rejecting paywalled trackers ('downloaded 20 habit tracking apps and none was satisfactory'; 'premium this, subscription that… here it's just free, like properly FREE') — the app 'wins a bake-off it never enters', so competitors' pricing drives its installs.")
ext("C005", " Report 29: 52 (14.21%, mean 4.83) tried or rejected other trackers — 65% of them name price or habit caps; one 2★ uses 'Check Me' instead because it has a widget and is waiting to switch.")
ext("C006", " Report 29: simplicity (119, 32.51%) is framed as the absence of quizzes, upsells and bloat ('doesn't bombard you with stupid questions and a billion pop ups') and outnumbers 'too basic' 40:1 — 'the clearest do-not-fix signal'; simplicity and zero cost are the same story: 'this app is not trying to extract something from me'.")
ext("C178", " Report 29: 'Everything that you need, nothing that you don't' — 119 praise simplicity against 3 wanting rewards or more features; do not add features to the main flow.")
ext("C040", " Report 29: no widget at all — 16 requests (4.37%), the only absent feature with demonstrated substitution (a user on 'Check Me' because it has one) and the one explicit payment offer ('add widget support happy to pay for a lifetime'); three withhold a star for it.")
ext("C023", " Report 29: a Home Screen widget showing today's list requested by 16 across 26 months, 7 of them in 2026.")
ext("C080", " Report 29: dark mode absent — 15 requests (4.10%, mean 4.67, the highest-satisfaction request group), India 8.77% (2.9× global), 'it's what's missing for 5 stars'.")
ext("C043", " Report 29: weekday checkboxes only — x times per week without naming days ('practice golf 3 times a week but it doesn't matter on which days'), every other week ('My off days Fri, Sat, Sun every other week… its frustrating' — the only feature-driven 1★), monthly and custom intervals (14, 3.83%) — the one structural gap persisting across all five half-years.")
ext("C143", " Report 29: 'As someone who takes medication twice a day it would be incredibly helpful to mark the same habit done twice a day'.")
ext("C034", " Report 29: 9 data-loss reports (mean 2.11, the lowest-rated theme) came from the calendar bug plus a workaround users taught each other — reinstall — which wiped local-only history ('just sad I lost my data from uninstalling it'); 'the bug fix alone does not close this loop — an export or backup path does'.")
ext("C020", " Report 29: add a local CSV/JSON export to Files, account-free, so a date bug can never again mean total loss — three independent export/backup requests.")
ext("C153", " Report 29: optional iCloud backup, off by default and account-free, proposed against 9 data-loss reports and 3 sync requests — while one reviewer names 'I didn't even have to list my email' as the deciding factor.")
ext("C035", " Report 29 (counter-evidence): no account, no email, no login is named as the reason to choose the app; the report's rule is backup yes, account no — local-first.")
ext("C209", " Report 29: 'the fact I didn't even have to list my email sold me' — do not require an account; adding one for billing has its own cost.")
ext("C039", " Report 29: reminders that never fire, deleted reminders that keep firing (surviving delete-and-reinstall), and changed times that don't take (6, mean 3.17) — one problem: the notification schedule is written once and never reconciled against the habit's state; cancel scheduled notifications on delete and stop the day's reminders on check-off.")
ext("C073", " Report 29: 'This could be my perfect habit tracker if I could only reorder the list of tasks… Without it the app is virtually useless' (2★); two of four ask to sort by reminder time, which needs no new data model.")
ext("C036", " Report 29: support effectively unreachable — 'I contacted the dev twice but got no response'; a support link that 'takes you to a super-sketch website, circumventing Apple's privacy settings'; with no account and no backup the review page is the only support channel, which is why bugs arrive as public 1★.")
ext("C094", " Report 29: a rating prompt fired on the first check-off ('Used the app for 2 minutes then a reminder popped up for me to rate the app. -1 star'; 'so here I am, on day 1') — 39 contentless reviews, all 5★, median 27 characters; the 4.552 mean is partly a prompt-timing artefact that also starves the developer of diagnostic feedback; delay it to day 7 or ~10 completions.")
ext("C150", " Report 29: 'It asks for you to review it the moment you check one thing off' — ratings from people who have not yet used the app.")
ext("C240", " Report 29: the rating prompt fires on the first habit check-off.")
ext("C059", " Report 29: the calendar bug fell ~8× between 2025H2 and 2026H1 and the mean rose 4.39 → 4.66; habit editing missing in 2024 was added by May 2025 — but 'a fix ships, and the reviews it caused remain on the store page forever'.")
ext("C031", " Report 29: one 2026 launch failure ('Lässt sich nichtmal öffnen'); overall bug reporting fell by two-thirds (22.3% → 6.5%).")
ext("C012", " Report 29: statistics (bar, pie, weekly analytics, completion rings) is the one advanced surface praised unprompted (10, mean 4.60) and asked to be extended — all-time records, a monthly/yearly grid, export — the safest place to add depth without violating simplicity.")
ext("C048", " Report 29: quantity/unit tracking (steps, litres, reps; one proposes a slider) requested by 4 — only as an optional habit type outside the default flow.")
ext("C027", " Report 29: the listing supports 8 languages and not Spanish or Russian, yet 8 Spanish-language reviews arrive from UZ/CL/MX/AR/ES/US and one is blocked ('No puedo cambiar la lengua, ayuden me por favor') — Spanish first is the cheapest defensible localisation case.")
ext("C062", " Report 29 (fourth corpus): high-spend markets rate 0.27 lower and report bugs 3.5× more while praising zero cost at the same rate (48.0% vs 44.0%) — the appeal of free is uniform across income bands; India (mean 4.895, zero bug reports) is not comparable as satisfaction because its reviews are shorter and post-fix, but its dark-mode rate is the strongest country-level feature signal.")
ext("C085", " Report 29: 'I also appreciate that there's no subscription fees or ads. Am I trading off data privacy for this?' — users of free apps look for the hidden price; the listing's privacy label did not obviously cover the bandwidth-sharing prompt that followed.")
ext("C218", " Report 29: a privacy label saying 'analytics and diagnostics' while the app asks to route third-party traffic through the user's IP — the store disclosure must cover what the app actually does.")
ext("C104", " Report 29: the bandwidth-sharing prompt arrived with no announcement; the report's first fix is 'decide and publicly disclose the web-indexing policy'.")
ext("C002", " Report 29: the 1★ band changed composition completely — all 11 one-stars in 2024–25 were functional; 3 of 5 in 2026 were the new monetisation prompt; 'the app fixed its way out of one 1★ driver and introduced another'.")
ext("C103", " Report 29: 'You're doing a great service to students who cannot afford to spend on applications' — free access matters to students; 4 student/budget reviews at mean 5.00.")
ext("C097", " Report 29: 'love to be able to contribute to use it' — a contribution offered in a free app, alongside a lifetime-purchase offer tied to a widget.")
ext("C016", " Report 29: an end-date / no-end-date control requested (4) — set a habit with no end and change it later.")
ext("C057", " Report 29: UI/visual design praised by 45 (12.30%, mean 4.64); a font complaint (1); more colours / custom colours requested (4).")
ext("C009", " Report 29: colour coding per habit is free; 4 ask for a wider palette and custom colours.")

M = {
 "R29-003":["C001","C003"], "R29-004":["C214","C005"], "R29-005":["C242","C085"], "R29-006":["C242"], "R29-007":["C243"], "R29-008":["C034","C020","C153"], "R29-009":["C040","C023","C080"],
 "R29-010":["C043","C143"], "R29-011":["C007","C001"], "R29-012":["C036"], "R29-013":["C094","C150","C240"], "R29-014":["C062","C080"],
 "R29-015":["C242","C040","C080","C043","C020","C243","C094","C039","C073","C036"], "R29-017":["C243","C059"],
 "R29-019":["C009","C012","C016","C209"], "R29-020":["C040","C080","C030","C020","C172","C048","C073"], "R29-021":["C001","C242"], "R29-022":["C027","C218","C242"],
 "R29-025":["C001"], "R29-026":["C001"], "R29-027":["C006"], "R29-028":["C001","C082"], "R29-030":["C214"], "R29-031":["C243"], "R29-032":["C057"], "R29-033":["C001","C003"], "R29-035":["C243"],
 "R29-037":["C040","C023"], "R29-038":["C080"], "R29-039":["C043"], "R29-040":["C007"], "R29-041":["C012"], "R29-042":["C034"], "R29-043":["C039"], "R29-044":["C036"], "R29-045":["C073","C059"],
 "R29-046":["C073"], "R29-047":["C009"], "R29-048":["C048"], "R29-049":["C016"], "R29-050":["C001"], "R29-051":["C103"], "R29-052":["C039"], "R29-053":["C094"], "R29-054":["C242"], "R29-055":["C006","C178"],
 "R29-056":["C153","C030"], "R29-057":["C012"], "R29-058":["C103"], "R29-059":["C042"], "R29-060":["C172","C097"],
 "R29-062":["C001"], "R29-063":["C006","C178"], "R29-065":["C012"], "R29-066":["C039"], "R29-067":["C073","C059"], "R29-068":["C073"], "R29-069":["C006","C178"], "R29-071":["C040","C005"],
 "R29-073":["C243"], "R29-074":["C243"], "R29-075":["C034","C020","C153"], "R29-076":["C243","C059"],
 "R29-078":["C094"], "R29-079":["C040","C080","C043"], "R29-080":["C243","C034"], "R29-081":["C243","C040","C073"], "R29-082":["C002","C242"],
 "R29-084":["C003","C097"], "R29-085":["C001"], "R29-086":["C242"], "R29-087":["C242"], "R29-088":["C001","C007","C209","C036"], "R29-089":["C003","C007","C242"],
 "R29-091":["C243"], "R29-092":["C062","C080"], "R29-093":["C062","C001"], "R29-094":["C001"], "R29-096":["C027"],
 "R29-099":["C243","C059"], "R29-100":["C059","C031"], "R29-101":["C073","C059"], "R29-102":["C242"], "R29-103":["C001"], "R29-104":["C080","C040","C043"], "R29-105":["C094"], "R29-106":["C001","C040","C080","C043"],
 "R29-107":["C242","C104","C218"], "R29-108":["C040","C023"], "R29-109":["C080"], "R29-110":["C043"], "R29-111":["C020","C153","C209"], "R29-112":["C243"], "R29-113":["C039"], "R29-114":["C094"], "R29-115":["C073"], "R29-116":["C036"],
 "R29-117":["C003"], "R29-118":["C153","C035"], "R29-119":["C027"], "R29-120":["C012"], "R29-121":["C048"], "R29-123":["C007","C006","C209","C001"],
 "R29-124":["C242"], "R29-125":["C034","C020"],
}
# unattached (nuance register): 001-002 header/method, 016 year table, 018 inventory table, 023 external SDK context, 024 master table, 029 any request,
# 034 behaviour change, 036 recommends, 061 single-record rows, 064 outcomes, 070 unmet-needs table, 072 counting rule, 077 ratings table, 083 no payer,
# 090 distribution, 095 BR/AU, 097 comparison summary, 098 half-year series, 122 research questions
cards = [json.loads(l) for l in open("Tools/prd_ledger/29/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/29/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
