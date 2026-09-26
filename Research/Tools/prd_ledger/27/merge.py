"""Stage 3 merge for report 27."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C239","do","A personal origin story in the listing builds trust — and turns any later gate into a betrayal","Report 27: a solo developer's story in the listing produced 10 reviews (7.25%, every one 5★) thanking her by name — 'Thanks Emily'; 'It's clear that someone made this with joy, not for money'; 'built/maintained by an individual female developer — THANK YOU'; 'you are a hero'. The origin story does measurable acquisition work, and it is a constraint: a trust-based relationship is what makes a paywall feel like a betrayal rather than a transaction. Report 25: 'I can't believe one developer made this' and 'after interacting with the developer I decided to pay without any hesitation'.")

ext("C001", " Report 27 (an entirely free app): 'free with no in-app purchases' is the largest theme (47, 34.06%, mean 4.89) and the stated reason users arrived — 13 fled competitors' paywalls, 4 plead 'keep it free', 3 praise unlimited habits, and one is watching ('No ads (yet, but I don't think there are any)'); the report ranks a retroactive gate on existing functionality as the highest-risk action available, and says any future paid capability must attach only to something that does not exist today.")
ext("C003", " Report 27 (the limiting case): a tracker with no price at all — 47 reviews (34.06%) name 'free / no IAP / no subscription' in a register of relief and disbelief ('How is this free?'; 'In a world where literally every service is locked behind a pay wall, this is like a breath of fresh air'); the free position is the acquisition channel, and the only monetisation the corpus endorses is a voluntary tip jar.")
ext("C097", " Report 27: exactly two reviewers volunteer money unprompted — 'Keep the free app, consider adding a tip jar for users who are thankful'; 'it would be nice to donate to the dev since it's a free app' — both 5★, both framing payment as gratitude, both pairing it with staying free; with 10 developer-gratitude reviews (all 5★) a tip jar is the only monetisation the corpus positively endorses, and Canada is where the evidence says to start.")
ext("C007", " Report 27: unlimited habits on a free app is praised by name ('unlimited habit tracking without ads'; 'has no limitations'; 'i didn't need to pay to use a certain amount of habits') and 13 reviewers arrived after fleeing competitors' caps — a habit cap on the free tier 'directly attacks the stated reason users are here'.")
ext("C214", " Report 27 (the other side): a free, minimal, account-less tracker wins the category comparison outright — 13 reviewers explicitly rejected rivals over price ('Don't get streaks for $6. 👎 Get this!'; 'way better than those paid apps'), and switched-from-competitor rose 0% → 16.7% across eras without the app changing; as the category monetises harder, the free position sharpens by market drift.")
ext("C005", " Report 27: 13 (9.42%, mean 4.85) arrived from other trackers ('I have tried like 20+ apps including notion, atoms'; 'replaced Streaks'; 'I've tried dozens upon dozens of apps and this is literally unmatched'), and 13 name the competitive paywall — a net receiver of category churn whose position is defined by rivals' monetisation, not its own features.")
ext("C006", " Report 27: simplicity is the largest theme (52, 37.68%, mean 4.90; 'cuts straight to the point, no fluff'; 'No other shinannigans'), 12 praise the absence of ads (8.70%), and the report's 'what not to do' list is: no gamification, no ads (even one interstitial), no required account, no feature removals without an opt-out, no over-building — 'does everything you need it to do with very little drama' is the product spec; one thing to watch: as refugees from feature-rich paid apps arrive, 'pleasantly minimal' starts shading into 'missing things'.")
ext("C178", " Report 27: two reviewers name the absence of gamification as the reason they chose the app — 'There's not pets to take care of, there's no flashy graphics or anything, and that is just perfect for me'; 'it removes a direct emphasis on urgency and/or self-competition' — and 52 praise minimalism; in a category converging on pets, gardens and streak anxiety, deliberate plainness is a defensible position that any future monetisation must not contradict.")
ext("C082", " Report 27: 12 reviews (8.70%, mean 4.83) praise the absence of ads by name; an ad tier is 'contradicted by evidence'.")
ext("C209", " Report 27: 'no account required' is praised as a feature (4, mean 5.00 — 'so many habit apps are expensive and require an account'; 'All this without asking for my personal details') and the listing's no-data-collection label is part of the positioning; a required account 'rules out ad-funded or data-funded models'.")
ext("C085", " Report 27: a no-data-collection privacy label and no account are praised as features (4, mean 5.00); data monetisation is contradicted by the evidence and the listing.")
ext("C035", " Report 27 (counter-evidence on the signup side, not the durability side): no account is praised — but iCloud sync exists and is invisible, so three reviewers fear data loss and one churned after an update lost progress; the account layer's job here is legible backup, not signup.")
ext("C153", " Report 27: iCloud sync exists ('seamless iCloud syncing'; the listing confirms) but is not legible — 'if my device gets reset all the data will be gone or I can recover it?'; a user will not reorder habits for fear of losing data; one churned after an update lost all progress; fix: a Settings line 'Backed up to iCloud · last synced <time>' plus an explicit restore path — a communication fix, not an engineering one.")
ext("C030", " Report 27: sync that works but cannot be seen produces data-loss anxiety (4) and sync requests (3 — iPad; 'wish my goals were synced across my devices') in a corpus where the listing says iCloud sync already exists.")
ext("C034", " Report 27: the one observed churn — 'It doesnt open with the update, ive lost all my progress, guess its time for a new app' — is reliability plus data loss, not price.")
ext("C031", " Report 27: a September–November 2025 update-and-iOS-26 launch crash ('Ever since I updated to iOS 26 the app immediately crashes when I try to open') accounts for almost every bad rating the app ever received — all 4 1★, the only 2★ and 4 of 6 3★ fall in a five-week window (window mean 4.162 vs 4.822 elsewhere); fixed by Feb 2026 (mean 4.829, zero 1★); a solo-developer app with no support channel pays for an OS-transition break entirely in public rating.")
ext("C175", " Report 27: the 2025 update broke launch on iOS 26 and removed the one-tap note export, the day-tap record popup, the single-screen annual overview and backfill from the annual grid — the same update that shipped multi-check-ins and flexible frequency; 'feature removals in this app are more expensive than feature absences'.")
ext("C155", " Report 27: the year-at-a-glance grid — the signature view the bundle ID is still named after (goalStreakCalendar) — was demoted behind a per-habit tap in 2025; its praise fell 16.7% → 0% and by late 2025 it appears only as a loss, even from a reviewer who still gave 5★ ('I loved it before the previous update'); the removed one-tap note export produced the corpus's only 2★ — 'one reviewer represents a workflow, not a preference'.")
ext("C119", " Report 27: do not remove features in updates without an opt-out — restore the full-year grid as a selectable view and the 365-dot view as a choice.")
ext("C040", " Report 27: the widget is the most consistently under-delivering surface and the only one to produce a 1★ on its own ('Widget does and shows absolutely nothing… Just says 0% ALL the time'); 9 gap/defect reviews (6.52%, high-priority) across every one of five years vs 5 praising it.")
ext("C023", " Report 27: reviewers wrote the widget spec — 'a small widget that just showed the current streak count for a single goal'; 'a streak counter on the widget like duolingo'; 'a grayed out version if it's still to do and a coloured version if it's done'; tappable to check off — requested in 2022, 2023, 2024, 2025 and 2026; in a streak app the widget is the retention surface.")
ext("C012", " Report 27: daily, weekly and yearly views exist and a monthly view is the missing rung — requested five times over four years, the only feature request that repeatedly costs stars (2 of 6 3★); the year grid is the app's signature and its de-emphasis was noticed.")
ext("C073", " Report 27: habit reordering shipped (between Sept 2024 and Aug 2025) and the order does not stick ('they keep getting jumbled up and going back to the wrong spots'); one user avoids reordering for fear of data loss; another wants grouping by the time a habit is set for.")
ext("C045", " Report 27: tags exist but existing tags cannot be selected and duplicates don't group — two storefronts, two months apart, same bug, both cost stars.")
ext("C039", " Report 27: the reminder fires for a goal already marked complete today — 'a notification that contradicts app state actively trains users to ignore notifications'.")
ext("C075", " Report 27: a real first-run comprehension cost — four of five confused reviewers got past it and stayed ('a lil hard to figure out at first but now super easy'), the fifth gave 1★; a 30-second skippable explainer is a low-risk fix that does not compromise minimalism.")
ext("C043", " Report 27: flexible weekly frequency shipped ~2025 and is praised ('tasks that can be completed a few times a week rather than everyday'); per-weekday scheduling ('run 1 mile per day during the week, and skip Saturday + Sunday') remains a request; a Monday week-start setting was asked twice in early 2024 and never again.")
ext("C143", " Report 27: multiple completions per day shipped ~Aug 2025 and is praised ('the multiple check-ins per day feature is very handy').")
ext("C010", " Report 27: backfill by tapping past dates is praised (and broke for the annual grid in 2025); two reviewers want to import an existing streak by start date ('the streak being automatically completed from that date, moving to a new phone was a bit tedious').")
ext("C016", " Report 27: a goal end date so a completed goal stops repeating but stays visible, and habit archiving, were asked for by a 3★ reviewer — both appear on the listing and were not findable.")
ext("C142", " Report 27: streak length is not readable from the day list (a full interaction spec given); a goal end date and archiving are on the listing and a reviewer could not find them; a streak freeze is listed and zero reviewers mention it; the website link in Settings points at a dead domain — the only support path.")
ext("C036", " Report 27: not one review in four years mentions contacting support or a developer reply; the website link in Settings leads to an inactive domain, so the support path is broken — and a solo-developer app with no support channel absorbs an OS-transition break entirely through its public rating.")
ext("C059", " Report 27: requested features ship on a 6–18 month lag — per-weekday flexibility (Jul 2025 → Mar 2026), reordering (Sept 2024 → Aug 2025), goal end date and archiving (Dec 2025 → on the listing by Sep 2026); the crash was fixed within about four months and the mean recovered to 4.829.")
ext("C020", " Report 27: data export is praised ('export data for nerdy kind') and the one-tap note export was removed in 2025, producing the only 2★.")
ext("C172", " Report 27: daily memo prompts exist and their value is disputed ('simply yet engaging daily memo questions' vs 'the note taking doesn't really have a point to it'); a fuller daily log is wanted.")
ext("C024", " Report 27: streaks are the core praised mechanic in a deliberately non-gamified app — no pets, no flashy graphics, no urgency; behaviour-change outcomes ('I'm on a 9 day vacuuming streak!') rose 0% → 11.9% across eras.")
ext("C022", " Report 27: Apple Watch, Apple Health and macOS are each requested once (4★ 'Would be perfect with watch support'); the report says a paid tier, if ever, should attach only to such not-yet-existing capability.")
ext("C021", " Report 27: Apple Health integration (exercise, water, steps, sleep) requested once, 4★.")
ext("C044", " Report 27: a macOS app requested once, 5★.")
ext("C094", " Report 27: exactly one reviewer discloses a prompt ('Saw the message and had to rate'), no reward-for-review, and only 12 of 138 reviews are ≤25 characters — the substantive mean (4.594) equals the headline (4.645); a corpus of people who wrote something.")
ext("C002", " Report 27 (the free limiting case): with no offer at all, the app has no structural sources of 1★ — every 1★ ever is a reliability failure in one five-week window, and the 4★ band is a fully specified backlog from people who like the app (17 of 18 would plausibly become 5★ on one shipped item); 5★ here means 'I am grateful', not 'I have no needs'.")
ext("C062", " Report 27: high-spend markets (92, mean 4.641) and the rest (46, 4.652) are indistinguishable; free-praise appears in 12 of 23 storefronts with no income split — the anti-paywall stance is category-wide.")
ext("C027", " Report 27: localisation is not an issue — zero complaints across seven non-English reviews; the two Monday-week-start requests (DE, AU) are the only regional-convention issue.")
ext("C134", " Report 27: the origin story in the listing produces 10 all-5★ developer-gratitude reviews; 'From one developer to another — nice piece of work'.")
ext("C170", " Report 27: a Monday week-start setting asked twice in early 2024 (DE/AU) and never again.")

M = {
 "R27-003":["C001","C003","C214"], "R27-004":["C005","C214"], "R27-005":["C006","C178"], "R27-006":["C031","C175"], "R27-007":["C031","C059"], "R27-008":["C155","C175","C119"],
 "R27-009":["C040","C023"], "R27-010":["C012"], "R27-011":["C153","C030","C034","C035"], "R27-012":["C097","C001"], "R27-013":["C239","C134"],
 "R27-014":["C023","C012","C153","C155","C073","C043","C039","C045","C170","C036","C097"],
 "R27-017":["C009"], "R27-018":["C012","C155"], "R27-019":["C010","C143","C043"], "R27-020":["C024","C020","C142"], "R27-021":["C172"], "R27-022":["C039","C040","C073","C045"],
 "R27-023":["C153","C142","C016","C022","C021","C044","C170"], "R27-024":["C209","C085","C082","C036"], "R27-025":["C007","C001","C003"], "R27-026":["C003","C097","C082","C209"],
 "R27-027":["C002"], "R27-028":["C006","C057","C009"], "R27-029":["C075"], "R27-030":["C024"], "R27-031":["C003","C006"], "R27-032":["C002"], "R27-033":["C073"], "R27-034":["C045"],
 "R27-036":["C010"], "R27-038":["C016","C142"],
 "R27-039":["C094"], "R27-040":["C002","C031"], "R27-041":["C155","C020"], "R27-042":["C012"], "R27-043":["C002"], "R27-044":["C002","C006"], "R27-045":["C006","C040","C172"], "R27-046":["C075"],
 "R27-047":["C003"], "R27-048":["C097"], "R27-049":["C001","C007","C082","C209"], "R27-050":["C097","C001","C022"], "R27-051":["C034","C031"],
 "R27-054":["C062"], "R27-056":["C062","C027"], "R27-059":["C031","C036"], "R27-060":["C175","C155","C143","C043"], "R27-061":["C059"], "R27-062":["C155","C012"], "R27-063":["C214","C005"],
 "R27-064":["C024"], "R27-065":["C012","C023"], "R27-066":["C006"],
 "R27-067":["C023","C040"], "R27-068":["C073"], "R27-069":["C045"], "R27-070":["C039"], "R27-071":["C009"], "R27-072":["C036","C142"], "R27-073":["C155","C119","C012"], "R27-074":["C155","C020"],
 "R27-075":["C012"], "R27-076":["C153","C030"], "R27-077":["C043","C010"], "R27-078":["C075"], "R27-079":["C142","C170"], "R27-080":["C097","C239"], "R27-081":["C001","C007","C082","C209"], "R27-082":["C001","C022","C021","C044"],
 "R27-084":["C178","C006","C082","C209","C155"],
}
# unattached (nuance register): 001-002 header/method, 015 error-risk table, 016 inventory table, 035 unmet-needs table, 037 singleton table,
# 052-053 storefront tables, 055 China hypothesis, 057-058 era tables, 083 research questions
cards = [json.loads(l) for l in open("Tools/prd_ledger/27/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/27/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
