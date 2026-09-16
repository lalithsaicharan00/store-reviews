import json, re
R = 18
rep = open("App Store Reports/18. MyRoutine - Organize your day - Built around your real life (REPORT).md").read().split("\n")
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

# ---- PART 5 ----
c(92, "§5.1 The confirmed-payer cohort — 161 reviewers (7.86%); metric table (verbatim)", "monetization",
  "Confirmed payers: 161 (7.86%), mean 3.528 vs 3.824 corpus — payers rate 0.30 stars lower; distribution 5★ 75 · 4★ 16 · 3★ 24 · 2★ 11 · 1★ 35 (21.7% vs 16.2% corpus-wide); kr 143 · jp 14 · us 3 · tw 1; by year 2020:1 · 2021:4 · 2022:13 · 2023:22 · 2024:38 · 2025:37 · 2026:46 — more numerous in the review stream than ever; lifetime buyers specifically 34 reviews (1.66%), mean 4.12★; definition undercounts payers (explicit first-person statements only, precision ≈92%)",
  "payers are more polarised and lower-rated than the corpus", "mixed", table("## 5.1 The confirmed-payer cohort"), "must-never-break", "high-priority cohort", "yes", [])
c(93, "§5.1 Lifetime buyers specifically — 34 reviews, mean 4.12★", "monetization",
  "Lifetime buyers (34 reviews, 1.66%) average 4.12★ — well above the payer cohort's 3.53 and the corpus 3.82", "lifetime tier exists (₩69,000–89,000 / $79.99 / ¥6,890–8,890)", "praise", "34 (1.66%), mean 4.12★ vs payers 3.528", "build-paid", "cohort", "yes",
  ["11815241341","13637970269","14238803827","12777592140","11427388698"])
c(94, "§5.2 #1 Hitting the habit/completion cap while already engaged — converts and embitters", "insight",
  "The most common purchase path is hitting the habit/completion cap while already engaged — it converts and embitters at the same time", "cap-triggered conversion", "purchase-driver", "4 named IDs; most common named trigger", "product-rule", "ranked #1 by naming frequency", "yes",
  ["11213284399","12822094053","10995640730","9092043014"])
c(95, "§5.2 #2 A specific feature seen in advance", "insight",
  "Named purchase triggers seen in advance: the timer; routine modes for shift work (incl. a returning churned JP user); Challenge; the merged routine+to-do view; desktop/web; iPad landscape; statistics — three of these seven were later removed",
  "feature-led conversion", "purchase-driver", "14 named IDs across 7 features", "build-paid", "ranked #2", "yes",
  ["12353891566","13119628268","14331337303","13795524849","14454264522","11752441594","11727453236","11714930552","12862607759","9513306665","8107694384","8633124826"],
  "three of the seven named triggers (Challenge, merged view, desktop) were subsequently removed")
c(96, "§5.2 #3 Trying it for days and being convinced by the outcome", "insight",
  "Conversion after a month, a week, two weeks, or the trial → Pro path — outcome-led conversion requires being allowed to use the product", "trial-to-conviction", "purchase-driver", "5 named IDs", "product-rule", "ranked #3", "yes",
  ["8363704388","8961449067","10995640730","10961939818","12822094053"])
c(97, "§5.2 #4 A creator or book", "tactic",
  "Acquisition through the founder's book and a Millie's Library / Draw Andrew interview, YouTubers (kr, jp), Instagram/Twitter ads (kr, us), and an App Store Editor's Choice feature in 2020", "founder book, interviews, YouTubers, social ads, Editor's Choice", "purchase-driver", "10 named IDs", "do", "ranked #4", "app-specific",
  ["9522758316","9663347068","12461265321","13583464496","12917751855","14406881138","8549757135","11802252737","6225061945","6526765963"])
c(98, "§5.2 #5 Wanting to fund the developer", "insight",
  "Some pay to fund the developer — a GB app developer defends the price; 'just skip a couple of fried chickens'", "goodwill conversion", "purchase-driver", "3 named IDs", "do", "ranked #5", "yes",
  ["9256280526","14031166609","14364890014"])
c(99, "§5.3 What stops people from paying — every barrier, ranked (verbatim table)", "monetization",
  "Barriers ranked: 1 cannot evaluate before paying; 2 price feels high for value delivered (56, 2.73%) — sharpest JP compares to a rival at ¥380/yr or ¥1,400 lifetime and leaves; 3 subscription itself rejected, users want one-time purchase; 4 bugs make the paid version look unsafe to buy (JP couldn't verify terms — English only — so quit); 5 loss of trust from the price ladder/mischarges; 6 students, teens and children cannot pay; 7 sign-up wall before any trial",
  "barriers", "blocked-conversion", table("## 5.3 What stops people from paying"), "product-rule", "ranked", "yes",
  ["14517754076","11187045021","7841937957","13926457593","11974551441","8258577524"])
c(100, "§5.3 #3 Subscription itself is rejected; users want a one-time purchase", "monetization",
  "Subscription itself is rejected by a recurring set of reviewers who want a one-time purchase (kr, jp, hk)", "subscription-first with a lifetime option", "blocked-conversion", "9 named IDs", "build-paid", "ranked #3", "yes",
  ["7841937957","8174800592","8454428069","8785421572","10296452732","10787703382","12783996460","14233269481","13650576656"])
c(101, "§5.3 #4 Bugs make the paid version look unsafe to buy", "insight",
  "Bugs make the paid version look unsafe to buy — 'too buggy at the moment'; a JP user couldn't verify the terms (English only) so quit", "bugs block conversion", "blocked-conversion", "3 named IDs", "must-never-break", "ranked #4", "yes",
  ["13926457593","13487846506","12024690867"])
c(102, "§5.3 #6 Students, teens and children cannot pay — a recurring, sympathetic segment", "audience",
  "Students, teens and children cannot pay: a primary-school student, an AU teen (notes the age gate's lowest bracket is '18 and under' though the store rates it 'all ages'), a GB child, 'wish they had a student plan', a teacher whose class lost the to-do list", "no student plan; age gate mismatch", "blocked-conversion", "8 named IDs", "do", "ranked #6", "yes",
  ["11974551441","13005084273","12857404582","13758846200","11132278368","13247035053","12122589601","10598930656"])
c(103, "§5.3 #7 Sign-up wall before any trial", "must-have",
  "A sign-up wall before any trial — JP required email + phone + real name", "mandatory sign-up first", "blocked-conversion", "5 named IDs (kr, us, jp, gb); theme 70 (3.42%)", "must-have", "ranked #7", "yes",
  ["8258577524","10178633937","9088458031","12549047166","14379439679"])
c(104, "§5.4 #2 Data loss among payers — one resolved by restoring data, review upgraded", "must-never-break",
  "Data loss hits 20 of 161 payers (12.42%); in one case the developer restored the data and the review was upgraded", "data loss; one successful restore", "churn", "20/161 (12.42%); 7 named IDs incl. tw", "must-never-break", "payer cohort", "yes",
  ["14238803827","11442003118","10985703210","13450548328","10983549558","11103012143","14374791999"])
c(105, "§5.4 #3 Feature removal after purchase", "product-rule",
  "Feature removal after purchase — desktop, Challenge, merged view — and one told mid-term to buy a new plan after a July 2026 update", "removes purchased features; forces new plan mid-term", "churn", "5 named IDs", "product-rule", "ordered by trust breach", "yes",
  ["9513306665","11752441594","11727453236","11714930552","14312836653"])
c(106, "§5.4 #4 The paid tier adds nothing, it only removes limits", "insight",
  "'Not so much amazing paid service as feeling forced to pay because the basics were cut'; 'even paid, there's nothing to use beyond the to-do list' — the paid tier only removes limits", "Pro = removal of caps", "churn", "3 named IDs", "product-rule", "ordered by trust breach", "yes",
  ["11116355780","10904269033","14504465163"])
c(107, "§5.4 #5 Being marketed to after paying", "dont",
  "'A pro member should be a pro member regardless of whether they are paying monthly or yearly' — a monthly user nagged daily to go annual; a JP 'buy the next term' screen blocks the app entirely", "upsells paying members", "complaint", "4 named IDs", "dont", "ordered by trust breach", "yes",
  ["13492813619","12862293051","13785665369","14179422656"])
c(108, "§5.4 #6 Support silence — lands hardest on payers; the Japanese in-app feedback form is itself broken", "must-have",
  "Support silence lands hardest on payers (a week of silence on a lifetime account; TW refund flow is a dead end; HK 'can't find contact details'); the Japanese in-app feedback form is itself broken — dark-mode text invisible and every valid email rejected as malformed, so Japanese users can only file a bug through the App Store", "support unreachable; JP feedback form broken", "churn", "32 (1.56%, mean 2.72★); 3 IDs for the broken JP form", "must-have", "meaningful", "yes",
  ["14238803827","14248568509","14338132758","13837162309","14007691344","12955157658","14258618311","14429093675","13757721182","13576075338","13712167027"])
c(109, "§5.5 Conditional-purchase promises (verbatim table) — a priced feature backlog", "feature",
  "Conditional-purchase promises — treat as a priced backlog, not forecasts: data export ('add export and I'll subscribe for life'; jp 'I'd pay more'); a widget (2021: '1000% willing to pay for a widget'); iPad landscape; Apple Watch ('even if paid I'd buy right away'); a cross-date all-to-dos list (existing Pro renewal condition); annual statistics ('I'd pay lifetime immediately'); a black theme ('add it only for paid subscribers'); a working timer with time tracking; a timezone fix ('I'll come back'); a time-table/time-block view; fewer bugs; just being allowed to try it",
  "backlog of stated purchase conditions", "purchase-driver", table("## 5.5 Conditional-purchase promises"), "build-paid", "stated conditions", "yes",
  ["13587898854","14102776480","8039445612","8107694384","8300726420","14479635630","13064048672","11208317901","14504465163","8592955634","12348149297","13926457593","13031399325","14517754076","13848157788","12433476315"])
c(110, "§5.5 A time-table / time-block view", "feature",
  "A time-table / time-block view is a stated purchase condition", "absent", "blocked-conversion", "n=1", "research", "single", "yes", ["12348149297"])
c(111, "§5.5 Timezone fix — 'I'll come back when it's fixed'", "must-never-break",
  "A CA user will return when the timezone bug is fixed; timezone/overseas date theme 11 (0.54%)", "wrong date when travelling", "churn", "n=1 stated + 11 theme", "must-never-break", "single", "yes", ["8592955634"])

# ---- PART 6 ----
c(112, "Part 6 Why people stay: the retention mechanism", "insight",
  "The retention mechanism is consistent and unusual: (1) partial credit removes the failure state; (2) the traffic light creates a visible daily debt — got out of bed at 2:30am to clear a red light; 'if I don't succeed or the light isn't green something feels off so I just do it'; (3) cheer messages and rest options prevent the shame spiral; (4) seeing others' routines supplies templates and company without becoming a social network; (5) the timer defeats activation energy — this is the asset the monetisation is spending down",
  "partial credit + daily light + rest + light social + timer", "praise", "131 reviews (6.40%, high-priority, mean 4.54★) describe a behaviour change", "must-have", "high-priority", "yes",
  ["9091145019","8404425930","12363679942","10629245924","14406960899","13132341344"])
c(113, "Part 6 Tenure evidence and life contexts", "audience",
  "Tenure: 3–4 year users, 500+ day streaks, 1,000 routine completions, 199 and 700 days; life contexts: exam candidates and re-taking students, a stay-at-home parent, a parent-entrepreneur scripting the day minute by minute, pregnancy, post-illness recovery, a disability and return-to-work plan (jp), depression and 무기력, primary-school children",
  "n/a", "praise", "8 tenure IDs; 11 context IDs", "do", "close reading", "yes",
  ["12780156991","13356295904","14401843895","14345482795","13399863062","11340256601","14108167464","13769975479","8749041575","11871621227","11513425197","14493849853","10365634719","14460799436","11857498349","11905634612","14409378886","14411303132"])

with open("Tools/prd_ledger/18/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
