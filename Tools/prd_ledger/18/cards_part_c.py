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

# ---- PART 3 ----
c(53, "§3.1 All themes, ranked — Negative and mixed themes (verbatim table)", "data-caveat",
  "Negative/mixed themes ranked (denominator 2,048): free-tier restriction 139 (6.79%, 2.32★, 65 1★); trial/billing/refund 144 (7.03%, 2.90★); UI complexity/can't find things 149 (7.28%, 3.65★); order/reorder/future-date edit restriction 130 (6.35%, 4.07★); data loss 123 (6.01%, 3.27★); crash 111 (5.42%, 3.15★); lag/slow 76 (3.71%); sign-up/login required or broken 70 (3.42%, 3.13★); price objection 56 (2.73%, 3.30★); cross-device/web/Mac sync 55 (2.69%); ads 46 (2.25%, 2.70★); upgrade-nag/promo bar/countdown 40 (1.95%, 2.40★); onboarding 34 (1.66%, 2.03★); support unreachable 32 (1.56%, 2.72★); entitlement failure 25 (1.22%, 2.44★); notification not firing/can't silence 21 (1.03%); localisation defects 19 (0.93%); timezone/overseas date wrong 11 (0.54%)",
  "n/a", "complaint", table("### Negative and mixed themes"), "none", "theme table", "app-specific", [])
c(54, "§3.1 UI complexity / can't find things — the largest negative theme by count", "feature",
  "UI complexity / can't find things is the largest negative theme by count (149, 7.28%, high-priority) though at 3.65★ it is friction among loyal users rather than churn; Notion is the benchmark for 'too complex'",
  "feature-dense UI; discoverability problems", "complaint", "149 (7.28%, HIGH, mean 3.65★, 24 1★); 4★ band 30 (9.3%), 3★ band 24 (11.1%)", "product-rule", "high-priority", "yes",
  ["9514694714","10851299280","9744682977"])
c(55, "§3.1 Order / reorder / future-date edit restriction", "feature",
  "Order/reorder/future-date edit restriction is the #1 unmet need — free reordering / drag-and-drop and editing future dates; 73 five-star reviews describe this friction; a JP ADHD user docked a star purely for reorder discoverability",
  "restricted reordering and future-date editing", "complaint", "130 (6.35%, HIGH, mean 4.07★, 14 1★); 5★ band 73 (6.8%); payer rate 8.70%", "must-have", "high-priority", "yes",
  ["8790036022","10405411434","10547226293","11570091772","13830429548","10925388863","9744682977"])
c(56, "§3.1 Data loss / records reset / won't save", "must-never-break",
  "Data loss / records reset / won't save is high-priority and splits by tenure — long-time users report and stay (37 in 5★), new users report and leave (31 in 1★); 12.42% of payers",
  "data loss on update/reset", "churn", "123 (6.01%, HIGH, mean 3.27★, 31 1★); payer rate 12.42% (20/161)", "must-never-break", "high-priority", "yes",
  ["11442003118","13972678934","14238803827"])
c(57, "§3.1 Crash / won't launch", "must-never-break",
  "Crash / won't launch is high-priority; a 1-year member: 'not a single day without a crash'",
  "crashes", "churn", "111 (5.42%, HIGH, mean 3.15★, 29 1★); 5★ band 31; 3★ band 20 (9.3%)", "must-never-break", "high-priority", "yes",
  ["10673432472","13926457593"])
c(58, "§3.1 Lag / slow / loading", "must-never-break",
  "Lag / slow / loading is a very strong signal", "slow/laggy", "complaint", "76 (3.71%, very strong, mean 3.32★, 15 1★)", "must-never-break", "very strong", "yes", [])
c(59, "§3.1 Sign-up / login required or broken", "must-have",
  "Sign-up / login required or broken is a very strong signal at 3.13★", "mandatory account; login failures", "complaint", "70 (3.42%, very strong, mean 3.13★, 18 1★)", "must-have", "very strong", "yes", [])
c(60, "§3.1 Price objection", "monetization",
  "Price objection is a meaningful theme distinct from billing disputes", "price seen as too high", "complaint", "56 (2.73%, meaningful, mean 3.30★, 16 1★)", "research", "meaningful", "yes", [])
c(61, "§3.1 Cross-device / web / Mac sync", "feature",
  "Cross-device / web / Mac sync complaints are meaningful and worse among payers (6.21%)", "sync problems across iPhone/iPad/Mac/web", "complaint", "55 (2.69%, meaningful, mean 3.73★); payers 10 (6.21%)", "must-never-break", "meaningful", "yes",
  ["13972678934"])
c(62, "§3.1 In-app ads / promo interstitials; Upgrade-nag / promo bar / countdown", "anti-pattern",
  "In-app ads/promo interstitials (46, 2.25%, 2.70★) and upgrade-nag/promo bar/countdown (40, 1.95%, 2.40★) are both meaningful and among the lowest-rated themes; promo-nag is 5.42% of 1★ and ads 4.82% of 1★",
  "ads + promo bar + countdown", "1★-burst", "46 (2.25%, 2.70★, 16 1★) + 40 (1.95%, 2.40★, 18 1★)", "dont", "meaningful", "yes",
  ["14164985475","14117739778"])
c(63, "§3.1 Support unreachable / unanswered", "must-have",
  "Support unreachable / unanswered is meaningful at 2.72★; the worst case waited over a week with no acknowledgement", "support silent", "churn", "32 (1.56%, meaningful, mean 2.72★, 15 1★)", "must-have", "meaningful", "yes",
  ["14238803827","14248568509"])
c(64, "§3.1 Notification not firing / can't silence", "must-never-break",
  "Notifications not firing or impossible to silence is a meaningful theme", "notification defects", "complaint", "21 (1.03%, meaningful, mean 3.57★)", "must-never-break", "meaningful", "yes", [])
c(65, "§3.1 Localisation defects; Timezone / overseas date wrong", "market",
  "Localisation defects (19, 0.93%, emerging) and timezone / overseas-date errors (11, 0.54%, emerging) are emerging themes", "localisation and timezone defects", "complaint", "19 (0.93%) + 11 (0.54%)", "must-never-break", "emerging", "yes", [])
c(66, "§3.1 Positive themes (verbatim table)", "insight",
  "Positive themes: design/cute/clean/intuitive 164 (8.01%, 4.46★, HIGH); habit formed/life changed 131 (6.40%, 4.54★, HIGH); traffic light/streak/badge 92 (4.49%, 4.24★); social layer 66 (3.22%, 4.45★); Apple Watch 48 (2.34%, 4.46★, mostly positive, asks for parity); routine timer 46 (2.25%, 4.37★); ADHD/neurodivergent/low-mood fit 36 (1.76%, 4.53★); explicit praise for partial-completion design 10 (0.49%, 4.80★ — conservative classifier, qualitatively much larger)",
  "n/a", "praise", table("### Positive themes"), "none", "theme table", "app-specific", [])
c(67, "§3.1 Design / cute / clean / intuitive — the top positive theme", "feature",
  "Design / cute / clean / intuitive is the top positive theme; 116 of the 5★ reviews (10.9%) praise design", "cute, clean design with custom emoji stamps", "praise", "164 (8.01%, HIGH, mean 4.46★)", "must-have", "high-priority", "yes", [])
c(68, "§3.1 Habit formed / life changed", "insight",
  "Habit formed / life changed is the second positive theme — 'my life changed completely' (jp)", "product works for those who get through", "praise", "131 (6.40%, HIGH, mean 4.54★)", "none", "high-priority", "yes",
  ["10313873532","12614380013","12292226361","12243537252","13331816001"])
c(69, "§3.1 Apple Watch (mostly positive; asks for parity)", "feature",
  "Apple Watch is mostly positive but asks for parity — timer, bundles, standalone use", "watch app lacks timer/bundles/standalone", "mixed", "48 (2.34%, meaningful, mean 4.46★)", "paid", "meaningful", "yes",
  ["13431240197","13435011015","12102004351","12181512959","12736883056"])
c(70, "§3.1 Explicit praise for partial-completion design", "insight",
  "Explicit praise for partial-completion design is the highest-rated theme at 4.80★ — conservative classifier, qualitatively much larger", "green day below 100%", "praise", "10 (0.49%, weak by count, mean 4.80★)", "must-have", "weak count / exceptional magnitude", "yes",
  ["9744682977","11978551289"])
c(71, "§3.1 Feature-request themes (verbatim table) — all skew positive, engaged users", "feature",
  "Feature-request themes all skew positive (engaged users): statistics/graphs/trend 57 (2.78%, 4.12★); theme colours/dark mode/fonts 60 (2.93%, 4.53★); merged routine+to-do view 46 (2.25%, 4.22★, mostly post-Sept-2024); shift-work/variable-schedule 31 (1.51%, 4.03★); diary/memo aggregation view 22 (1.07%, 4.68★); export/backup 18 (0.88%, 4.44★)",
  "requests from engaged users", "praise", table("### Feature-request themes"), "none", "theme table", "app-specific", [])
c(72, "§3.2 The rating distribution is bimodal, and 2026 hollowed out the top", "timeline",
  "52.20% 5★ and 16.21% 1★ with only 5.32% 2★ — people either found their app or hit a wall; in 2026 the 5★ share falls to 38.7% (139/359) and 1★ rises to 27.6% (99/359), the worst mix in the corpus",
  "bimodal, worsening", "mixed", "2026: 5★ 38.7% (139/359), 1★ 27.6% (99/359)", "none", "corpus-level fact", "app-specific", [])
c(73, "§3.3 Unmet needs (verbatim table) — every substantial request ranked by count", "feature",
  "Unmet needs ranked: 1 free reordering/drag-and-drop and editing future dates 130; 2 real statistics (% achieved, trend, annual view, per-habit graphs) 57; 3 theme colours/dark mode/font size 60; 4 restore merged routine+to-do 46; 5 shift-work/variable-day routine profiles 31; 6 diary/memo aggregation, calendar of entries, search 22+; 7 export/backup 18 ('add export and I'll subscribe for life'); 8 photo/media/URL attached to a habit/memo/diary ~25; 9 to-do parity (carry-over, subtasks, tags, priority, undated, recurring) ~30; 10 configurable day-end time ~15; 11 widget: check without opening, choose routine, 2-column, calendar (214 mentions); 12 Apple Watch parity 48; 13 Mac/Windows/web ~20 ('PC access please I'm desperate!'); 14 hide unused tabs ~8; 15 turn streak/light/shield on and off ~12",
  "requests", "mixed", table("## 3.3 Unmet needs"), "none", "request table", "app-specific",
  ["8790036022","10444375042","10134189547","12245337065","9774376446","13587898854","8650285763","9624805038","11911176952","8173262340","13431240197","14232062718","13842532454"])
c(74, "§3.3 #2 Real statistics: % achieved, trend, annual view, per-habit graphs", "feature",
  "Real statistics — % achieved, trend, annual view, per-habit graphs — is the #2 request; a paying user notes statistics have no charts; a lifetime buyer left for TodoMate over statistics, export and diary aggregation",
  "statistics behind Pro but shallow (no charts)", "complaint", "57 (2.78%, meaningful, 4.12★)", "paid", "meaningful", "yes",
  ["10444375042","11058573700","13064048672","13815455991","14102776480","10851299280","11427388698"])
c(75, "§3.3 #3 Theme colours / dark mode / font size", "feature",
  "Theme colours, dark mode and font size are the #3 request at 4.53★ — engaged users", "limited theming", "praise", "60 (2.93%, meaningful, 4.53★)", "free", "meaningful", "yes",
  ["10134189547","11208317901","13199584756","12955157658","14107861406"])
c(76, "§3.3 #5 Shift-work / variable-day routine profiles", "feature",
  "Shift-work / variable-day routine profiles is a meaningful request (KR 3-shift, JP); routine modes shipped ~Dec 2025 as Pro", "later shipped as Pro 'routine modes'", "complaint", "31 (1.51%, meaningful, 4.03★)", "undecided", "meaningful", "yes",
  ["12245337065","11794115305","12580123414","12478377114","13618217151"])
c(77, "§3.3 #6 Diary/memo aggregation, calendar of entries, search", "feature",
  "Diary/memo aggregation, a calendar of entries and search — the highest-rated request theme at 4.68★", "memos exist but cannot be browsed together or searched", "praise", "22+ (1.07%, meaningful, 4.68★)", "undecided", "meaningful", "yes",
  ["9774376446","12024794472","13309723170","11802252737"])
c(78, "§3.3 #7 Export / backup (Excel, CSV, PDF, Notion)", "feature",
  "Export/backup to Excel, CSV, PDF or Notion — 'add export and I'll subscribe for life'", "no export", "blocked-conversion", "18 (0.88%, emerging, 4.44★)", "free", "emerging", "yes",
  ["13587898854","12730801342","13843048940","9925440139","12983375244"])
c(79, "§3.3 #8 Photo / media / URL attached to a habit, memo or diary", "feature",
  "Attach a photo, media or URL to a habit, memo or diary entry", "absent", "complaint", "~25 (reading)", "undecided", "reading", "yes",
  ["8650285763","9091145019","10607803565","12024794472","12478377114"])
c(80, "§3.3 #9 To-do parity: carry-over, subtasks, tags/categories, priority, undated, recurring", "feature",
  "To-do parity — carry-over, subtasks, tags/categories, priority, undated and recurring to-dos; a JP 4★ will keep Pro if a cross-date to-do list ships", "to-do is Pro yet shallow", "complaint", "~30 (reading)", "undecided", "reading", "yes",
  ["9624805038","10935748594","12687026543","13147214076","14171150075","13662101102","14479635630"])
c(81, "§3.3 #10 Configurable day-end time (not midnight)", "feature",
  "A configurable day-end time (not midnight)", "day ends at midnight", "complaint", "~15 (reading; kr, jp, us)", "must-have", "reading", "yes",
  ["11911176952","13531683889","13705144684","11617268315","12403094681"])
c(82, "§3.3 #11 Widget: check without opening the app; choose which routine; 2-column; calendar", "feature",
  "Widget requests — check off without opening the app, choose which routine shows, 2-column layout, calendar widget; the widget has 214 mentions and is simultaneously the most-loved and most-broken surface; one user runs both MyRoutine and Routinery solely for Routinery's timer widget",
  "widget exists; not interactive; limited configuration", "mixed", "214 widget mentions total; 5★ 121 (11.3%) vs 1★ 19", "undecided", "reading", "yes",
  ["8173262340","9660942025","10861517833","11798381598","14127953337","9556123553"])
c(83, "§3.3 #13 Mac / Windows / web client", "feature",
  "Mac / Windows / web client — 'PC access please I'm desperate!' (kr, in English); web returned as beta 2025", "web beta only", "complaint", "~20 (reading)", "paid", "reading", "yes",
  ["14232062718","14264012710","13932466192","13411029434","9829175246"])
c(84, "§3.3 #14 Hide unused tabs / reduce visual load", "feature",
  "Hide unused tabs / reduce visual load — requested by the ADHD reviewer who also wants the streak hideable", "cannot hide tabs", "complaint", "~8 (reading)", "must-have", "reading", "yes",
  ["13842532454","13821412218","11064706172"])
c(85, "§3.4 Competitors reviewers name (verbatim table)", "positioning",
  "Named competitors: TodoMate 6 (the main alternative — a lifetime buyer left for it over statistics, export and diary aggregation; one switched to MyRoutine from it); Notion 7 (benchmark for 'too complex' and the thing MyRoutine failed to replace); Routinery 4 (better routine-timer widget — one runs both apps; recommends copying Routinery and Structured); Apple Reminders 7 (the fallback when the paywall or complexity wins); Apple Notes 2 (ADHD user returned after the Sept-2024 split); TimeTree, Structured, Daystamp, 플래닛, 1day스케줄, 아시스트가이드, Blocos, 심스페이스 1–2 each as models for calendars, widgets and timers",
  "compared against TodoMate, Notion, Routinery, Apple Reminders/Notes", "mixed", table("## 3.4 Competitors reviewers name"), "do", "named counts", "app-specific",
  ["11427388698","11646296464","12122589601","13563271747","9912306722","8761641540","9514694714","9878312095","11442188567","12629011104","14127953337","12023625379","13719591657","13771499654","9775832874","11703079091"])

# ---- PART 4 ----
c(86, "§4.1 5★ — n = 1,069 (52.20%); most 5★ reviews contain a complaint or a request", "data-caveat",
  "The defining characteristic of MyRoutine's 5★ reviews is that most contain a complaint or request — 73 reorder friction, 52 billing disputes, 37 data loss, 31 crashes; reviewers say explicitly they rate high so the developer will read it ('giving 5 so the developer sees this'); top 5★ themes: widget 121 (11.3%), design 116 (10.9%), life-change 96 (9.0%), confirmed payer 75 (7.0%), order/edit 73 (6.8%), traffic light 57 (5.3%), social 48 (4.5%); unconditional praise clusters on life change, the traffic light's compulsion loop (got out of bed at 2:30am because of a red light), design and social",
  "5★ used as a channel to the developer", "mixed", "1,069 5★ (52.20%); 73/52/37/31 complaint sub-counts", "none", "rating band", "yes",
  ["13977781381","12141615363","11894471289","10313873532","9091145019"])
c(87, "§4.1 4★ — the 'one thing away from perfect' band", "insight",
  "4★ is the 'one thing away from perfect' band and the one thing is usually reordering, the widget or a missing statistic — 'If I could give it 4 and a half I would' (journaling not prominent enough); JP will keep Pro if a cross-date to-do ships; top 4★ themes widget 45 (14.0%), complexity 30 (9.3%), data loss 29 (9.0%), order/edit 29 (9.0%)",
  "n/a", "mixed", "322 4★ (15.72%)", "none", "rating band", "yes",
  ["9744682977","12077348883","14479635630"])
c(88, "§4.1 3★ — the paying-but-disappointed band", "insight",
  "3★ is the paying-but-disappointed band: paid, no modularity, noisy defaults, statistics with no charts; a US medical student 'really wanted to purchase the lifetime membership, but it's too buggy'; one cancelled because paying only removes limits, adds nothing; top themes complexity 24 (11.1%), payer 24 (11.1%), widget 22, paywall 21, crash 20",
  "paying disappointed users", "churn", "216 3★ (10.55%)", "product-rule", "rating band", "yes",
  ["10851299280","13487846506","13926457593","11116355780"])
c(89, "§4.1 2★ — the smallest band and the most concentrated on money", "insight",
  "2★ is the smallest band (109, 5.32%) and the most concentrated on money: paywall 18 (16.5%), billing 13 (11.9%), payer 11 (10.1%)", "n/a", "complaint", "109 2★ (5.32%)", "none", "rating band", "app-specific", [])
c(90, "§4.1 1★ — n = 332 (16.21%); theme table (verbatim); more than a third of 1★ are about money", "insight",
  "More than a third of 1★ reviews (122/332, 36.7%) are about money — the paywall (65, 19.58%) or the bill (57, 17.17%) — and one in ten (35, 10.54%) was written by someone who had paid; reliability is the second engine (data loss 31, crash 29); feature gaps barely appear — 1★ reviewers are not people who wanted more, they are people who could not use, could not trust, or could not get their money back",
  "1★ driven by money and reliability, not feature gaps", "1★-burst", table("### 1★ — n = 332"), "product-rule", "rating band", "yes", [])
c(91, "§4.2 Themes that appear on both sides of the line (verbatim table)", "contradiction",
  "Themes on both sides: widget 121 5★ vs 19 1★ (most-loved and most-broken surface simultaneously); order/reorder 73 vs 14 (loyal friction, not churn); streak/traffic light 57 vs 5 (beloved but the shield and streak can both demotivate); data loss 37 vs 31 (long-time users report and stay, new users report and leave); confirmed payer 75 vs 35 (the payer cohort is itself bimodal); billing dispute 52 vs 57 (the 52 five-star billing reviews are almost all 'great app, please refund me')",
  "n/a", "mixed", table("## 4.2 Themes that appear on both sides"), "none", "rating band", "yes", [])

with open("Tools/prd_ledger/18/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
