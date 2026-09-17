"""Cards for report 36 — Part 3 (global findings) and Part 4 (clusters)."""
import sys; sys.path.insert(0, "Tools/prd_ledger/36")
from _lib import c, table, save

c(55, "§3.1 Complete ranked theme table (verbatim), 102 codes", "data-caveat", "Master theme table, denominator 540, with 5/4/3/2/1 split", "n/a", "mixed", table("## 3.1 Complete ranked theme table"), "none", "corpus-level fact", "app-specific", [])
T = [
 (56,"SIMPLE","insight","Simplicity as restraint 80 (14.81%, mean 4.75, zero 1★) — 'Other habit trackers have too much other gunk like blogs or media that don't actually add any value'","80 (14.81%), 4.75; 66/9/4/1/0","product-rule","praise",["8868694307"]),
 (57,"GEN+ / GEN- / JUNK","data-caveat","Generic positive 75 (13.89%, 4.93); generic negative 5 (0.93%, 1.20); junk 12 (2.22%, 4.83)","GEN+ 75; GEN- 5; JUNK 12","none","mixed",[]),
 (58,"MOTIV","insight","Motivating 47 (8.70%, mean 4.83)","47 (8.70%), 4.83","none","praise",[]),
 (59,"BEST","positioning","'Best' claims 34 (6.30%, mean 4.65)","34 (6.30%), 4.65","none","praise",[]),
 (60,"USEFUL","insight","Useful 21 (3.89%, mean 4.90)","21 (3.89%), 4.90","none","praise",[]),
 (61,"VALUE-","monetization","'Not worth the money' 21 (3.89%, mean 2.24, zero 5★, 12 of 21 1–2★) — often tied to SUITE-: paying for four apps to get one good one","21 (3.89%), 2.24; 0/3/6/5/7","research","complaint",[]),
 (62,"CHURN","insight","Explicit churn — deleted / switched / will not renew — 20 (3.70%, mean 2.05, 11 1★)","20 (3.70%), 2.05","none","churn",[]),
 (63,"PRICE+","monetization","Price praised / worth it 20 (3.70%, mean 4.80) — satisfied buyers","20 (3.70%), 4.80","none","praise",[]),
 (64,"BUYIF","monetization","Conditional purchase intent 10 (1.85%, mean 4.70)","10 (1.85%), 4.70","research","blocked-conversion",[]),
 (65,"MISRATE","data-caveat","Rating contradicts text 9 (1.67%, mean 4.44) — e.g. a 5★ calling the app 'Unusable' because of the launch pop-up; 'I didn't understand how to play??' at 5★","9 (1.67%), 4.44","none","mixed",["11870684099","8606455193"]),
 (66,"BUG","must-never-break","Other bugs 8 (1.48%, mean 2.88)","8 (1.48%), 2.88","must-never-break","complaint",[]),
 (67,"VIZ+","feature","Visualisation / history views praised 8 (1.48%, mean 4.62)","8 (1.48%), 4.62","build-free","praise",[]),
 (68,"SCIENCE+ / SCIENCE-","positioning","'Science-backed' framing praised 7 (1.30%, mean 4.86); doubted 2 (0.37%, mean 1.50)","SCIENCE+ 7, 4.86; SCIENCE- 2, 1.50","none","mixed",[]),
 (69,"WIDGET+","feature","Widgets praised 7 (1.30%, mean 4.29)","7 (1.30%), 4.29","build-free","praise",[]),
 (70,"NOADS / PRIVACY+","insight","No ads 6 (1.11%, mean 4.33); privacy praised 2 (0.37%) — 'Does what it's meant to do while respecting your privacy and not harvesting your data'; 'There's no ads and the developers don't collect your data'","NOADS 6, 4.33; PRIVACY+ 2","product-rule","praise",["9206039207","13670415847"]),
 (71,"KIDS","audience","Kids / family use 3 (0.56%, mean 4.67)","3 (0.56%), 4.67","none","praise",[]),
 (72,"weak rows","data-caveat","Weak rows (n ≤ 2): ADHD 2 (5.00); ENT 2 (3.50); FLEX+ 2 (5.00); MOTIV- 2 (3.00); NOTIF- 2 (1.50); ONBOARD+ 2 (5.00); PRIVACY+ 2 (4.00); REGIONAL 2 (2.00); R_ORG 2 (4.00); SCIENCE- 2 (1.50); SOUND- 2 (2.50); SUPPORT- 2 (2.00); UPDATE+ 2 (5.00); WIDGET- 2 (4.00); ACCESS- 1; CRASH 1 (1.00); LOCKIN 1 (1.00); MISPLACED 1; REVIEWDOUBT 1 (2.00); R_ADVICE 1; R_MUSIC 1; R_QUIT 1; R_THEME 1; R_TODO 1; SUPPORT+ 1","≤2 each (≤0.37%)","none","mixed",[]),
]
for seq, w, kind, claim, mag, d, react, ids in T:
    c(seq, f"§3.1 theme table {w}", kind, claim, "see §3.1", react, mag, d, "theme-table signal", "yes", ids)
# §3.2
c(73, "§3.2 The findings with the worst rating profile (verbatim table) and the mirror image", "data-caveat",
  "Worst rating profile (n ≥ 5): GRAPHICS- 1.17 (6/6 1–2★), DISCLOSE 1.67, ONBOARD- 1.81, REGRESS 1.95, CHURN 2.05, UX- 2.21, VALUE- 2.24, CAP 2.30, PRICE- 2.31, AFFORD 2.20, BORING- 2.50, SUB- 2.60, WIDGETGATE 2.64, POPUP 2.67; mirror — QUOTES+ 13 mean 5.00 every one 5★; OUTCOME 58 4.95 zero below 4★; USEFUL 21 4.90; FREE+ 24 4.88; MOTIV 47 4.83; DEV+ 27 4.81; PRICE+ 20 4.80; SIMPLE 80 4.75 zero 1★; GAME+ 74 4.69",
  "n/a", "mixed", table("## 3.2 The findings with the worst rating profile"), "none", "corpus-level fact", "app-specific", ["11064158160","13689787553","13971171093","14197628877","8777347712","8252766990"])
c(74, "§3.2 GRAPHICS- 6, mean 1.17, 6 of 6 1–2★ — the style itself is the objection: 'loaded with useless graphics and an annoying piano soundtrack' (a payer); 'Leider viel zu verspielt und nicht alltagstauglich'", "contradiction",
  "The same 3D, musical style that wins most users repels a minority completely: GRAPHICS- 6 reviews, mean 1.17, all 1–2★ — 'loaded with useless graphics and an annoying piano soundtrack' (a payer); 'Leider viel zu verspielt und nicht alltagstauglich' ('far too playful and not suitable for everyday use')",
  "heavy visual/sound style", "churn", "6, mean 1.17, 6/6 1–2★", "undecided", "meaningful", "yes", ["11064158160","13689787553"],
  cond="taste split: design praise 151 vs style rejection 6")
c(75, "§3.2 DISCLOSE 6, mean 1.67, 5 of 6 1–2★ — 'It's not free. You can't do more than 1 habit without paying'; 'Si c'est payant mettez le là c'est caché après avoir téléchargé'", "do",
  "Disclose the paywall on the store page: DISCLOSE 6 reviews, mean 1.67, 5 of 6 1–2★ — 'It's not free. You can't do more than 1 habit without paying'; 'Si c'est payant mettez le là c'est caché après avoir téléchargé' ('if it's paid put it there, it's hidden until after downloading')",
  "cap not disclosed before download", "1★-burst", "6 (1.11%), mean 1.67", "do", "meaningful", "yes", ["13971171093","14197628877"])
c(76, "§3.2 ONBOARD- 16, mean 1.81, 12 of 16 1–2★ — 'Is there no manual?'; 'I've wasted enough time trying to figure out how to use this silly app'", "must-have",
  "An unconventional interface needs onboarding: ONBOARD- 16 (2.96%, mean 1.81, 12 of 16 1–2★, 7.9% of E1 → 1.9% of E5) — 'Is there no manual?'; 'I've wasted enough time trying to figure out how to use this silly app'; 'I didn't understand how to play??'; 'Is it a game or some kind of something else?'",
  "no onboarding at launch; improved", "complaint", "16 (2.96%), mean 1.81", "must-have", "meaningful", "yes", ["8777347712","8252766990","8606455193","8676576820","9724439104"])
# §3.3
c(77, "§3.3 Reading the monetisation objection correctly (verbatim table)", "insight",
  "U_MON_FRICTION (121) split by what people want: 'give me a one-time price' ONETIME 24 (3.42) — to buy, only 1 of 24 1★, 10 are 4★, the most salvageable; 'don't take away what I had' REGRESS 19 (1.95) — grandfathering, anger at the change not the price; 'the cap is too tight to evaluate or use' CAP 30 (2.30) — 3+ free habits (three name three, one 3–4); 'don't gate function, gate cosmetics' WIDGETGATE 14 + PAYWALL 31 (2.64 / 2.77); 'stop asking me every launch' POPUP 24 (2.67) — frequency capping; 'I can't judge it before paying' TRIAL 7 (2.43); 'the price doesn't match the substance' VALUE- 21 (2.24), often SUITE-; 'I genuinely cannot pay' AFFORD 5 (2.20); 'price isn't localised' REGIONAL 2 (2.00); 'it's worth it' PRICE+ 20 (4.80)",
  "n/a", "mixed", table("## 3.3 Reading the monetisation objection correctly"), "product-rule", "qualitative split", "yes",
  ["14109551956","14236390341","12556296093","13825736968","11870684099","13670415847","10658186053","14179888590","11803536707","14174554457","10847370901","12524757331"])
c(78, "§3.3 Interpretation — roughly half of the monetisation friction is willingness to pay that the current model cannot accept; a packaging problem, not a price problem", "insight",
  "Roughly half of the monetisation friction is willingness to pay the model cannot accept — one-time buyers, people who would pay if the gate were cosmetic, people who would pay after a fair evaluation: a packaging problem, not a price problem",
  "subscription-only, functional gates", "blocked-conversion", "~half of 121", "product-rule", "interpretation", "yes", [])
c(79, "§3.3 TRIAL 7, mean 2.43 — 'these issues aren't readily apparent from the free version when you only have two habits to look at'", "monetization",
  "A tiny free tier hides the paid product's real problems until after purchase: TRIAL 7 (1.30%, mean 2.43) — 'these issues aren't readily apparent from the free version when you only have two habits to look at'",
  "no real trial; 1–2 free habits", "blocked-conversion", "7 (1.30%), mean 2.43", "build-paid", "meaningful", "yes", ["13670415847"])
c(80, "§3.3 AFFORD 5, mean 2.20 — two on disability, one a student, 'there is no way I can afford it without being part of the demographic which can drop 60$ on a reminder app'", "audience",
  "People who cannot pay are shut out as the price rises: AFFORD 5 (0.93%, mean 2.20) — two on disability, one student, and 'there is no way I can afford it without being part of the demographic which can drop 60$ on a reminder app'",
  "$59–70 price", "blocked-conversion", "5 (0.93%), mean 2.20", "research", "emerging", "yes", ["10658186053","14179888590","11803536707","14174554457"])
c(81, "§3.3 REGIONAL 2, mean 2.00 — regional pricing (TR) and a China-specific billing failure", "market",
  "Price not localised: regional pricing complaint from Turkey and a China-specific billing failure (REGIONAL 2, mean 2.00)",
  "one global price", "complaint", "2 (0.37%), mean 2.00", "do", "weak", "yes", ["10847370901","12524757331"])
# §3.4
c(82, "§3.4 #1 Sensory feedback as the reward — the most specific praise and the hardest for a competitor to copy; 'a small dose of dopamine every time you check something off' (a 3★ critic); a 2★ reviewer 'I love the sounds'", "insight",
  "Sensory feedback is the reward and the hardest thing to copy: haptic / sound praise is the most specific in the corpus (57, mean 4.61) — reviewers describe the physical act, not the feature — 'a small dose of dopamine every time you check something off' (from a 3★ critic); '手机也会给你不错的震动回饋'; even a 2★ reviewer says 'I love the sounds'",
  "hold-to-complete haptics and sound", "praise", "57 (10.56%), mean 4.61", "build-free", "high-priority", "yes", ["8139278712","13670415847","14045271461","14334631638"])
c(83, "§3.4 #2 Curiosity as the retention loop — the monument is a reason to return tomorrow; 'I almost want to keep my habits just for the app'", "insight",
  "Curiosity about tomorrow's reward is a retention loop: the monument is a reason to return — 'I almost want to keep my habits just for the app'; 'I can't stop because I'm curious about what the next reward is the next day'",
  "daily unveiled piece", "praise", "GAME+ 74 (13.70%), mean 4.69", "build-free", "high-priority", "yes", ["10492156673","12219094304","13127746442"])
c(84, "§3.4 #4 Kindness after a missed day — NOSHAME 11 + FLEX+ 2; 'I never know if I should start over or quit. So I put my tail between my legs and delete it'", "insight",
  "Streak shame is why perfectionists delete habit apps: 'As an easily discouraged perfectionist … if you miss a day (or a week) … it doesn't become the app of shame. I never know if I should start over or quit. So I put my tail between my legs and delete it' (20 helpful votes) — the corpus's clearest competitive wedge (NOSHAME 11 + FLEX+ 2)",
  "no punishment for missed days", "praise", "NOSHAME 11 (2.04%), 4.55; FLEX+ 2; 20 votes", "product-rule", "small count, disproportionate weight", "yes",
  ["9122428340","9261590460","11943524242","12937403561","11085313395"])
c(85, "§3.4 #5 Notification restraint NOTIF+ 12 (2.22%), mean 4.67 — fine-tuned control over notifications; 'spammed me with a billion distracting notifications'", "do",
  "Give fine-tuned control over notifications and send few: NOTIF+ 12 (2.22%, mean 4.67) framed as why they left other apps — 'fine-tuned control over the notifications you receive — probably the #1 reason I've deleted other habit apps was that they spammed me with a billion distracting notifications'",
  "restrained, configurable notifications", "praise", "12 (2.22%), mean 4.67", "do", "meaningful", "yes", ["13967987039"])
c(86, "§3.4 #6 Writing quality — QUOTES+ 13 (2.41%), mean 5.00, every one 5★ — 'The motivational phrases are encouraging but never guilt inducing'", "feature",
  "Well-written, never guilt-inducing motivational text: QUOTES+ 13 (2.41%), mean 5.00, every single one 5★ — 'It's easy to overlook how well written the text is in this app. The motivational phrases are encouraging but never guilt inducing'",
  "daily motivational line", "praise", "13 (2.41%), mean 5.00", "build-free", "meaningful", "yes", ["9464371564"])
c(87, "§3.4 #8 A credible competitive position — BEST 34, COMP 40 (7.41%, 4.05); competitors Streaks, Atoms / James Clear, Me+, Onrise, Dayrise, Habitica, Things, Fantastical, Notion, Habit Grid, Apple Reminders, a generic 'Habit' app with lifetime pricing; wins on feel, loses on price model", "positioning",
  "Wins on feel, loses on price model: competitors named (COMP 40, 7.41%, mean 4.05) — Streaks, Atoms / James Clear, Me+, Onrise, Dayrise, Habitica, Things, Fantastical, Notion, Habit Grid, Apple Reminders, and a generic 'Habit' app with lifetime pricing; one review names both the win on feel and the loss on price model",
  "subscription vs one-time rivals", "mixed", "COMP 40 (7.41%), 4.05; BEST 34 (6.30%)", "none", "high-priority", "yes",
  ["9647917670","11697727372","11803536707","11125368439","10917221776","13689787553","13902720788","10203658744","12830821232","9461859645"])
# §3.5
c(88, "§3.5 Unmet needs table (verbatim) — U_UNMET 104 (19.26%, high-priority), mean 3.90", "data-caveat", "Requests for things that did not exist for that reviewer at that time", "n/a", "complaint", table("## 3.5 Unmet needs"), "none", "corpus-level fact", "app-specific",
  ["8272945413","8748825608","8792588653","9978275210","10002968610","10674087870","11301370583","11928826699","12931845361","9551247141","9567517609","12155806021","12367187835","13608349245","13945742048"])
R = [
 (89,"R_STATS","feature","Statistics / counts / charts requested 10 (1.85%, mean 3.90)","10 (1.85%), 3.90","build-free",["9551247141","9567517609","10832733374","12155806021","12367187835","13608349245","13902720788","13945742048","13948551648"]),
 (90,"R_WATCH","feature","Apple Watch app requested 9 (1.67%, mean 4.11)","9 (1.67%), 4.11","research",["9102170206","11311247837","11499453960","12118518558","12339917492","12438446023","12912075467","13556614835","13624027434"]),
 (91,"R_FLEX","feature","Flexible schedules — every N days, N×/week or month — 7 (1.30%, mean 4.00); habits shown on days they are not scheduled SCHEDDAY- 3 (all 4–5★)","R_FLEX 7, 4.00; SCHEDDAY- 3","build-free",["8383787890","8774281298","8840784226","9898093006","10793530840","11280034510","12065767176","10945684076","11815224356","12152046240"]),
 (92,"R_NOTIF","feature","More / repeated / snoozable reminders 7 (1.30%, mean 3.86); reminders not firing NOTIF- 2 (1.50)","R_NOTIF 7, 3.86; NOTIF- 2","build-free",["9091830635","10358584157","12102232868","12759861353","13279758046","13348454083","13401743740","8845345016","12392171682"]),
 (93,"R_STREAK","contradiction","Some ask for streaks, reps or loss-on-break 7 (1.30%, mean 3.71) — including the 45-vote review — while NOSHAME praises the absence of streak punishment","7 (1.30%), 3.71 vs NOSHAME 11","undecided",["9750074711","10358584157","10662024022","12097852488","12544966110","13162761819","13967987039"]),
 (94,"R_WIDGET","feature","Widget improvements — titles, colours, streak display — 6 (1.11%, mean 3.67)","6 (1.11%), 3.67","build-free",["9098509320","11694919799","12544966110","13162761819","13462331422","13902720788"]),
 (95,"R_ACCOUNT","feature","Account / login requested 5 (0.93%, mean 3.00) — mostly Chinese-market; '希望可以登陆' (17 votes, third most-voted)","5 (0.93%), 3.00","must-have",["8664069478","9076528710","11067586008","11301370583","13624027434"]),
 (96,"R_LANDSCAPE / R_IPAD","feature","Landscape / rotation 5 (0.93%, mean 4.40) and a real iPad layout 4 (0.74%, mean 4.00), early era","5 + 4","must-have",["8622721501","8632947214","8757837312","8759804137","8782357563","8727604239"]),
 (97,"R_MULTI","feature","Multiple completions per day / quantity 5 (0.93%, mean 3.60)","5 (0.93%), 3.60","build-free",["11486217313","11523323203","12065767176","12367187835","13162761819"]),
 (98,"R_IWIDGET","feature","Interactive / tappable widget 4 (0.74%, mean 3.75) — 'instead of taking advantage of the iOS 17 update with interactive widgets, they preferred to make that option paid'","4 (0.74%), 3.75","build-free",["10777840197","11523323203","11694919799","12326839720"]),
 (99,"R_TIMER","feature","Timer / pomodoro / duration 4 (0.74%, mean 2.50) — one expected a timer because a screenshot showed a habit named 'Run 15 minutes'","4 (0.74%), 2.50","research",["9898093006","10358584157","11388263305","12167197066"]),
 (100,"R_HEALTH / R_NOTES / R_ORG","feature","Apple Health 3 (3.00); notes on a habit 3 (4.00); grouping habits 2 (4.00)","3 / 3 / 2","research",["10793530840","10964238644","13902720788","9567517609","11980712489","9898093006","12090899566","13061585954"]),
 (101,"R_THEME / R_TODO / R_ADVICE / R_MUSIC / R_QUIT","feature","Weak single requests: individually buyable / more free themes; a to-do list; habit-stacking method guidance; the music as a soundscape / on Spotify; a quit-a-habit inverse mode","1 each","none",["9567517609","8769392731","12097852488","12323195954","14510762767"]),
]
for seq, w, kind, claim, mag, d, ids in R:
    c(seq, f"§3.5 {w}", kind, claim, "absent", "complaint", mag, d, "request signal", "yes", ids)
c(102, "§3.5 Broken existing capabilities U_RELIABILITY 23 (4.26%), mean 2.74 — WIDGETBUG 3; UIBUG 6 (4 of 6 in E5); NOTIF- 2; DATALOSS 3; CRASH 1; BUG 8", "must-never-break",
  "Broken capabilities: reliability union 23 (4.26%, mean 2.74) — widget stopped working / shows 'unlock' (3); layout overflow, clipping or wrong zoom (6, 4 of them in E5, incl. a pop-up blocking an iPhone 13 mini); reminders not firing (2); data lost with no backup (3); a crash (1); other bugs (8)",
  "various", "complaint", "23 (4.26%), 2.74; UIBUG 6 (4 in E5)", "must-never-break", "very strong", "yes",
  ["10610214785","11178506784","13140722107","9567517609","11870684099","13631929530","13652246359","13701793930","14160954678","8845345016","12392171682","9978275210","10674087870","13624027434","8159941067"])
c(103, "§3.5 Misunderstandings — a store-listing clarity problem: expected a built-in timer because a screenshot showed a habit named 'Run 15 minutes'", "do",
  "Screenshots set feature expectations: a reviewer expected a built-in timer because a store screenshot showed a habit named 'Run 15 minutes' — a store-listing clarity problem, not a missing feature",
  "example habit name in screenshot", "complaint", "n=1", "do", "anecdotal", "yes", ["12167197066"])
c(104, "§3.5 Taste disagreements — MSG- 4 dislike the text QUOTES+ 13 love: 'strangely negative — talking about destruction or a kind of wasteland' (5★, considering leaving); 'Wish I could disable those' — make the messages switchable, don't rewrite them", "product-rule",
  "Make polarising content switchable rather than rewriting it: MSG- 4 reviews dislike the very text 13 others rate 5★ — 'the daily messaging puzzling, as it is strangely negative — talking about destruction or a kind of wasteland' (5★, considering leaving); 'I don't care for the cryptic messages you get with every check. Wish I could disable those'",
  "daily messages not switchable", "mixed", "MSG- 4 (4.00) vs QUOTES+ 13 (5.00)", "product-rule", "emerging", "yes", ["11737716154","13670415847"])
# §3.6
c(105, "§3.6 The one structural criticism — BORING- 8 (1.48%, 2.50) + R_BEYOND60 6 (1.11%) + GAME- 4 (0.74%): the monument is the same journey for every habit and ends at 60 days", "feature",
  "A reward journey that is identical for every habit and ends at 60 days runs out: BORING- 8 (2.50) + R_BEYOND60 6 + GAME- 4 (1.75) = 17 distinct reviews (mean 2.76) — 'the story is repeated for all habits … if you have one habit that's ahead, you know the story … pretty boring' (3★, 8 votes, the most analytically precise negative review); 'the haptics is quite fun at first but it's the same for every habit … the novelty decreases'; 'please add different journeys'; 'it's a shame that it lasts only 60 days … I could have built something infinitely'; 'the art only goes up to 60 … wouldn't hurt to add more especially when you're paying money'",
  "same 60-day journey per habit", "churn", "17 distinct, mean 2.76", "build-paid", "meaningful", "yes",
  ["9098509320","13594356619","14471085224","13572306369","10043311417"])
c(106, "§3.6 Questioning the mechanic outright — 'focusing the entire app experience on building a 3D model (how does this help?)'; 'more about playing with random shapes then actually figuring out your habits!!'", "contradiction",
  "Some question the game mechanic itself: 'focusing the entire app experience on building a 3D model (how does this help?)'; 'The UI is more about playing with random shapes then actually figuring out your habits!!'",
  "3D monument central", "complaint", "2 quotes (GAME- 4, mean 1.75)", "undecided", "anecdotal", "yes", ["8182905997","9128391997"])
c(107, "§3.6 Interpretation — what makes people return on day 3 makes them leave around day 60–120; the clearest retention finding, independent of price", "insight",
  "A finite novelty reward retains early and churns later: the thing that brings people back on day 3 is what makes them leave around day 60–120 — the clearest retention finding, independent of price; the least price-sensitive improvement and the one most likely to extend lifetime value",
  "60-day ceiling", "churn", "17 distinct (mean 2.76)", "research", "interpretation", "yes", [])
# §4.1
c(108, "§4.1 Cluster 1 — The free habit cap (verbatim evidence table)", "timeline",
  "Cap cluster evidence: before Dec 2025 unlimited free habits repeatedly praised ('you get unlimited habits and all non-cosmetic features other than the widgets. Fenomenal value', Jul 2024; 'not restricted to a amount of habits', Sep 2024); first 2-habit reports from 31 Dec 2025 (4★ edited; 4 Jan 1★; 4 Jan gb 2★; 7 Jan 1★; 12 Jan in 1★; 14 Jan id 4★; 4 Feb 4★ 9 votes); tightened to 1 habit from ~Mar 2026 (21 Mar ae; 18 Apr; 6 May fr; 17 May; 26 May; 10 Jun; 14 Jun; 28 Jun de ×2; 14 Jul at; 9 Aug; 16 Aug gb)",
  "unlimited → 2 → 1", "1★-burst", table("## 4.1 Cluster 1"), "product-rule", "high-priority in E5", "yes",
  ["10135990177","11499453960","11704920604","13577681414","13594173870","13594356619","13604432669","13624027434","13632154898","13710833763","13871290077","13971171093","14034266336","14073702229","14109551956","14164387323","14183623397","14235507906","14236390341","14302616144","14405082563","14433892949"])
c(109, "§4.1 Archived habits count against the cap — 'when I went to archive one of my completed habits and tried to make a new one it wouldn't let me … seems like kind of a ripoff'", "monetization",
  "Archived / completed habits must not count against a free cap: 'when I went to archive one of my completed habits and tried to make a new one it wouldn't let me … seems like kind of a ripoff'",
  "archived habits count", "complaint", "n=1 (4★, edited)", "product-rule", "anecdotal", "yes", ["13577681414"])
c(110, "§4.1 It destroys evaluability — 'you can't really test the app without paying'; one uninstalled and went to an AI chatbot instead", "insight",
  "A 1-habit free tier destroys evaluability: 'you can't really test the app without paying'; 'these issues aren't readily apparent from the free version when you only have two habits'; one German reviewer uninstalled and went to an AI chatbot instead",
  "1–2 habit cap", "churn", "3 reviews", "product-rule", "qualitative", "yes", ["14405082563","13670415847","14236390341"],
  side="a general AI chatbot is named as the substitute")
c(111, "§4.1 It reads as punishing loyalty — 'Just another company cashing out on the loyalty of longtime users'; 'I've used this app for years … I was hit with a paywall. And the prices are higher than what I remember'", "product-rule",
  "A new cap on existing users reads as punishing loyalty — grandfather them: 'Just another company cashing out on the loyalty of longtime users' (qa, 1★); 'I've used this app for years … I was hit with a paywall. And the prices are higher than what I remember'",
  "cap applied to existing users", "1★-burst", "2 quotes (REGRESS 19, mean 1.95)", "product-rule", "qualitative", "yes", ["13780647190","13625458345"])
c(112, "§4.1 Reviewers volunteer the acceptable number: three — 'Three would be reasonable for a paywall but only one??'; 'Ein Cap bei 3 Gewohnheiten hätte ich in Ordnung gefunden'; 'it was actually good when we could 3-4 habits'", "monetization",
  "Reviewers volunteer the acceptable free cap: three — 'Three would be reasonable for a paywall but only one??'; 'Ein Cap bei 3 Gewohnheiten hätte ich in Ordnung gefunden'; 'it was actually good when we could 3-4 habits'",
  "cap 1", "blocked-conversion", "3 reviews name 3; one 3–4", "product-rule", "qualitative", "yes", ["14109551956","14236390341","13825736968","12556296093"])
c(113, "§4.1 One 2026 reviewer mistakes the cap for a bug — 'App is extremely bugged. I cannot add a second habit'", "dont",
  "An unexplained cap is reported as a bug: 'App is extremely bugged. I cannot add a second habit' (de, 1★, 2026)",
  "silent cap", "1★-burst", "n=1 (1★)", "dont", "anecdotal", "yes", ["14235507906"])
c(114, "§4.1 Rating consequence — 2026 H1 mean 3.56, 29.1% 1–2★, CAP in 30.4% of all reviews; core praise falls to 45.6%, its lowest", "timeline",
  "Cap rating consequence: 2026 H1 mean 3.56, 29.1% 1–2★, CAP present in 30.4% of all reviews in the half-year, and core praise at 45.6% — its lowest in the corpus — in the same window",
  "cap", "1★-burst", "2026 H1 3.56; 29.1%; CAP 30.4%; core praise 45.6%", "product-rule", "high-priority", "yes", [])
# §4.2
c(115, "§4.2 Cluster 2 — the October 2023 widget retraction: aftershocks 'for the last 2 months the widget app has not been working properly … says that I have to unlock it'; 'the widgets stopped working at the same time'", "timeline",
  "Widget retraction aftershocks: users read the gate as a bug for months — 'for the last 2 months the widget app has not been working properly … says that I have to unlock it' (21 Nov 2023, 4★); 'widgets used to be free, now they cost' (CN, 9 Dec); 'the widgets stopped working at the same time' (Apr 2024); REGRESS contributes 6 in E3",
  "widget gate", "complaint", "WIDGETGATE 14; REGRESS 6 in E3", "product-rule", "very strong in E3", "yes", ["10610214785","10672228882","11178506784"])
c(116, "§4.2 Why it matters — widgets are load-bearing for the habit itself: '62 days in a row … wouldn't be possible without this app and it's widgets'; 'add the widgets … you will never miss a day'; 'Ojalá los widget fueras gratuitos eso mejoraría el apego'", "product-rule",
  "Widgets are load-bearing for the habit itself, so gating them removes the reason to pay: 'Just hit 62 days in a row of my morning routine. It wouldn't be possible without this app and it's widgets' (5★ payer); 'just add the widgets to your Home Screen and you will never miss a day'; 'Ojalá los widget fueran gratuitos eso mejoraría el apego' ('I wish the widgets were free, it would improve adherence') — gating the widget removes the mechanism that keeps the streak alive, which then removes the reason to pay",
  "widgets paid", "complaint", "WIDGETGATE 14 (2.64); WIDGET+ 7 (4.29)", "build-free", "interpretation", "yes", ["13462331422","11562816267","14445365483"])
c(117, "§4.2 An interactive widget was asked for instead and not delivered — 'instead of taking advantage of the iOS 17 update with interactive widgets, they preferred to make that option paid'", "anti-pattern",
  "Monetising a surface instead of improving it: 'instead of taking advantage of the iOS 17 update with interactive widgets, they preferred to make that option paid' (cl, 2★, Feb 2025)",
  "widgets paywalled, not made interactive", "complaint", "n=1 (2★); R_IWIDGET 4", "dont", "anecdotal", "yes", ["12326839720"])
# §4.3
c(118, "§4.3 Cluster 3 — U_SYNC_DEMAND (R_SYNC + R_ACCOUNT + ENT) 34 (6.30%), mean 3.59; the ask is polite from fans (11 at 4★, 10 at 5★) — 'Almost perfect! … It's just missing one thing - sync between devices'; 'iCloud sync would seal the deal for me'", "feature",
  "Sync is the polite ask of fans: sync demand union 34 (6.30%, mean 3.59), 11 at 4★ and 10 at 5★ — 'Almost perfect! … It's just missing one thing - sync between devices'; 'Only thing missing is the sync between devices'; 'iCloud sync would seal the deal for me'",
  "no sync", "blocked-conversion", "34 (6.30%), 3.59", "must-have", "high-priority", "yes", ["8272945413","8748825608","11318709831"])
c(119, "§4.3 It is a stated reason not to buy or not to renew — 'I won't end up using it or purchasing a membership unless it has the ability to sync'; 'If iCloud sync is ever supported I will be back'", "monetization",
  "No sync is a stated reason not to buy and not to renew: 'I won't end up using it or purchasing a membership unless it has the ability to sync' (au); 'I did end up buying the 1 year subscription, but the app was largely unused … I'd be renewing, but I do not plan to. If iCloud sync is ever supported I will be back'",
  "no sync", "churn", "2 non-renewal / non-purchase", "must-have", "qualitative", "yes", ["9745264915","10771936163"])
c(120, "§4.3 For payers it becomes indignation — 'As a paid subscription, sync across devices must be made available as basic'; 'habits not syncing between devices in 25 is a quite not-so-good-looking bummer'", "insight",
  "For payers missing sync becomes indignation: 'As a paid subscription, sync across devices must be made available as basic'; 'habits not syncing between devices in 25 is a quite not-so-good-looking bummer'; '¥398 — why is there no multi-device sync?'",
  "paid without sync", "complaint", "9/34 payers (26.5%)", "must-have", "segment", "yes", ["10498701164","12800428077","14450598724"])
c(121, "§4.3 Entitlements don't travel either (ENT 2) — 'access skins this way as well instead of unlocking them on each device'; paid and still does not know whether the subscription is one device only", "must-never-break",
  "Entitlements must travel across the buyer's devices and say so: 'it would be great to access skins this way as well instead of unlocking them on each device'; a payer still did not know whether the subscription covered one device only",
  "per-device unlock", "complaint", "ENT 2 (3.50)", "must-never-break", "weak", "yes", ["8757837312","9506691039"])
c(122, "§4.3 There is no account at all, and Chinese-market reviewers ask for login specifically — '希望可以登陆 / 登陆' (17 helpful votes, third most-voted)", "market",
  "Chinese-market users ask for an account / login specifically: '希望可以登陆 / 登陆' ('hope we can log in') has 17 helpful votes, the third most-voted review in the corpus",
  "no account", "complaint", "R_ACCOUNT 5; 17 votes", "research", "limited evidence (CN)", "yes", ["8664069478","9076528710","11067586008","11301370583","13624027434"])
c(123, "§4.3 Consequence when a device is lost — 'everything you save and track is reset when the app is deleted … I do not recommend'; 'I lost all my progress because of that'; 'No history remains once deleted'", "must-never-break",
  "Local-only data vanishes with the device or on delete: 'everything you save and track is reset when the app is deleted … I do not recommend' (tr, 1★); 'I lost all my progress because of that'; 'No history remains once deleted' — DATALOSS 3 (mean 1.67)",
  "local-only, no backup", "1★-burst", "DATALOSS 3 (1.67)", "must-never-break", "emerging", "yes", ["9978275210","10674087870","13624027434"])
c(124, "§4.3 But local-only is also praised (PRIVACY+ 2, NOADS 6); the tension is real and a private end-to-end sync would resolve it without giving up the privacy claim", "product-rule",
  "Resolve the privacy-vs-sync tension with private end-to-end sync: local-only is praised ('respecting your privacy and not harvesting your data'; 'the developers don't collect your data') while sync is the top request — a private end-to-end sync keeps the privacy claim",
  "local-only", "mixed", "PRIVACY+ 2, NOADS 6 vs R_SYNC 34", "build-free", "interpretation", "yes", ["9206039207","13670415847"])
# §4.4
c(125, "§4.4 Cluster 4 — habit navigation 27 distinct (5.00%), mean 3.56; asked continuously from Dec 2021 to Apr 2026 (a 45-vote review); the centre check button swallows horizontal swipes; worse with more habits — precisely for the paying user", "must-have",
  "A gesture-driven one-habit screen breaks down exactly for power users: habit navigation (27 distinct, 5.00%, mean 3.56, mostly 4–5★) asked for continuously from Dec 2021 to Apr 2026 (one review 45 votes; one entire body '.'); the centre check button swallows horizontal swipes ('most anywhere on the screen that we touch presses the center checkmark button'); names sit in a small strip at the top ('quite a reach to get to the top of the phone'); and it gets worse with more habits — i.e. for the paying user ('I have to swipe through 16 habits. That alone is enough for me to not want to use this app anymore'; 'switching between habits and having a lot of them is painful')",
  "one habit per screen; small top strip", "churn", "27 distinct (5.00%), 3.56; SWITCH- 20 (3.90); REACH- 6 (4.17)", "must-have", "very strong", "yes",
  ["8185571470","8253563602","8258517590","8562867284","9189055798","9750074711","10016530116","10622250811","10662024022","10713355484","10738443241","10968040090","11276612751","12079206553","12102232868","12153499058","12294811087","13670415847","13948551648"])
c(126, "§4.4 The missing view is an all-habits overview (NOLIST 12, mean 3.17) — 'no consolidated list / calendar view of all of your habits'; 'A multi-habit view mode would go a long way'; 'view all the habits in a single page to check or uncheck'", "feature",
  "Provide an all-habits overview to check off in one place: NOLIST 12 (2.22%, mean 3.17) — 'no consolidated list / calendar view of all of your habits'; 'a way to see your habits on a list that you can check off one by one'; 'A multi-habit view mode would go a long way'; 'an aggregate view with all my progressions across all habits'; 'view all the habits in a single page to check or uncheck'",
  "absent", "complaint", "12 (2.22%), 3.17", "build-free", "meaningful", "yes", ["8182905997","11659987897","12153499058","13948551648","14510762767"])
c(127, "§4.4 Partially shipped Dec 2025 — 'literally that same week they rolled out an update with those exact features'; 'The recent upgrades only made it even more useful!'; still complaints Jan and Apr 2026", "timeline",
  "Navigation partially fixed in Dec 2025 — a payer saw requested switching and deeper tracking ship 'literally that same week'; 'The recent upgrades only made it even more useful!' — but Jan and Apr 2026 complaints show the fix is incomplete, and it shipped in the same window as the habit cap",
  "navigation update Dec 2025", "mixed", "UPDATE+ 2; complaints continue", "do", "qualitative", "yes", ["13572606322","13681211961","13670415847","13948551648"])
c(128, "§4.4 Adjacent — cannot delete/rename a habit DELETE- 10 (3.00); habit-name character limit NAMELEN 3; habits shown on unscheduled days SCHEDDAY- 3 (all 4–5★)", "feature",
  "Basic habit management gaps: cannot delete or rename a habit (DELETE- 10, 1.85%, mean 3.00); habit-name character limit (NAMELEN 3); habits shown on days they are not scheduled (SCHEDDAY- 3, all 4–5★)",
  "delete/rename hard; name length; schedule display", "complaint", "DELETE- 10 (3.00); NAMELEN 3 (3.33); SCHEDDAY- 3 (4.33)", "must-have", "meaningful", "yes",
  ["8757312048","8964135829","9021270886","9098509320","10738443241","10945684076","11224445709","11245244275","11280034510","12339917492","8774281298","13010314496","13670415847","11815224356","12152046240"])
# §4.5
c(129, "§4.5 Cluster 5 — The 60-day ceiling: BORING- 8 + R_BEYOND60 6 + GAME- 4 = 17 distinct, mean 2.76; least price-sensitive improvement and most likely to extend lifetime value", "product-rule",
  "Extend the reward beyond the first run: 17 distinct reviews (mean 2.76) name the identical journey per habit and the hard stop at 60 days, from 5★ fans and the most analytical critic alike — the least price-sensitive improvement and the one most likely to extend lifetime value",
  "60-day ceiling", "churn", "17 distinct, mean 2.76", "build-paid", "meaningful", "yes", ["14471085224","13572306369","9098509320"])
save("a")
