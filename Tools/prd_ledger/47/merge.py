"""Stage 3 merge for report 47."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C262", "product-rule", "Never gate a recovery action — back-dating a missed day, undoing a wrong entry and restoring history stay free forever",
    "Report 47: back-dating is a trust feature (it makes the streak honest) and charging for it reads as charging to undo the app's own penalty — the backfill-demand union is 52 reviews (8.83%: check off a past day 22, a start date before creation 21, the 2024 gate 9), named in the very first review in the corpus (Feb 2019); it shipped 29 March 2020 (the most-voted review, 23 votes: '日付を遡ってチェックインできるようになってました！！！') and the request fell from 7.1% of 2019–21 reviews to 0.7%; then in April–June 2024 it was put behind a video ad and produced 9 reviews at mean 1.67 ('¥200 a month to log past days is too much') alongside the 2024 exits. The rule the report draws: every purchase trigger reviewers name is additive (AI coach, photos, stats, sync) and none asks to pay to restore something that used to be free — recovery actions are the one surface where a gate is read as extortion. Related: [[C010]] (backfill is a free feature), [[C176]], [[C204]].")
add("C263", "research", "An AI encouragement reply on each check-in as the premium hook — the first paid feature reviewers praise unprompted; its state must be visible",
    "Report 47: an AI coach that comments on each check-in (from September 2025) is praised by 13 (2.21%, mean 4.69) — 'そんなわけないだろ、AIだろ、って感じると思うけど意外に嬉しい' ('you'd think come on, it's just AI — but it's surprisingly nice'); 'AIに褒められてる感じがしなくて、承認欲求も満たされて' ('it satisfies the need for approval') — an AI-coach union of 18 (12.3% of 2025–26 reviews) with friction 9: 5 say comments stopped without explanation after about a week ('1週間くらいでAIのコメントが来なくなっちゃった'), 3 did not want it, 1 hit a surprise paywall, and a payer's on/off toggle would not turn back on. The report's E3 is the coach as the premium hook with a clearly labelled free taste; its fix #4 is a visible state ('trial ended', 'off', 'error') so a silent stop is never mistaken for a bug. Counter-evidence to [[C056]]: here the AI feature monetises by adding value, which the 2024 gating did not.")

ext("C001", " Report 47: the case study — in May 2024 a free, unlimited tracker with banners added a video ad per check-in, put back-dating behind a video and capped new habits; the following eight months (63 reviews) averaged 2.38 with 61.9% at 1–2★ against 14.9–17.8% in every other era, four themes exist only after the update (ad overload 24 at mean 1.46, 改悪 / free became paid 23 at 1.39, backfill gated 9, habit cap 7), 20 reviewers said they were leaving and 11 of the corpus's 23 self-described two-year-plus users wrote in that window ('改悪前は☆4-5くらいの日常使いでしたが、改悪後は☆1です'; '4年くらい使ってましたが、製作者の方が金儲け主義に走り'; 'ERA DE GRAÇA AGORA É PAGO'). Rolling the videos back to banners by December 2024 ended the complaint completely (0 ad complaints in 146 reviews Jan 2025 – Aug 2026; mean back to 4.02).")
ext("C002", " Report 47: a 3.818★ corpus whose low ratings are a sequence of distinct causes — crashes (2019–21), monetisation (2024), data loss (2026) — not a slow decline; without the eight-month shock window the mean is 3.99 (n = 526); stated churn 27 (mean 1.48), 20 of them May–Dec 2024 — before 2024 churn was a reaction to one defect, in 2024 to the business model.")
ext("C003", " Report 47: one-time purchase wanted 4 (2022–25: 'opção de comprar vitalícia, sem ser por assinatura'; '買い切り版が出たら検討しますが、とりあえず乗り換えます'), ad-removal-for-a-one-time-fee asked 2019–23 ('一度払い切りで広告を消すことができたら嬉しい'), and a 2026 lifetime price called 'so expensive it's funny' against ¥600 → ¥14,800 listing items; the report's E1 is an ad-free lifetime in Japan priced against the annual plan.")
ext("C004", " Report 47: price is rarely the objection but the shape is — 'このシンプルなアプリに月額320円は高い' ('¥320 a month is too much for an app this simple'); a Korean reviewer would pay about ₩9,000 once for stats, sync and iPad (2020); ¥200/month to log past days (Apr 2024) was refused.")
ext("C005", " Report 47: 'best of the many I tried' 33 (5.60%, mean 4.88), strongest in Korea (13% of KR reviews — '진심 다 써봤는데 이게 제일 좋음'); competitors rarely named — Dots ('そちらの方が操作性が良い', better to operate), RecStyle as the CSV-export model, Duolingo as the widget benchmark; departures to 'その辺のシンプルな野良アプリ' ('any random simple app').")
ext("C006", " Report 47: simplicity 126 (21.39%, mean 4.61), the largest theme in every era including the shock; a 5★ who wanted weekly habits concluded '多機能を追加すると、今のシンプルさは壊れてしまう' ('adding features would break the simplicity'); '機能をつけまくった結果UXがボロボロです' ('they bolted on so many features that the UX is in tatters', 1★ 2024, quit) — the report's rule: do not enlarge the feature surface.")
ext("C007", " Report 47: the changed case — habit count unlimited 2019–2024 ('完全無料!!… タスクの登録数が無制限') then capped at 6 for free users from December 2024 (7 complaints, mean 2.29: 'Agora eu não posso mexer nos meus hábitos se não irei perder todos'); tracking multiple goals is praised by 17 (mean 4.76).")
ext("C008", " Report 47: reminders free throughout and praised by 10 (all 5★ — multiple times per habit, editable text).")
ext("C009", " Report 47: a widget was requested by 20 (3.40%) in every era 2019–2026 — the most-requested capability — and shipped in 2025 as a free surface; 'please make a widget that makes me want to continue', Duolingo the benchmark.")
ext("C010", " Report 47: back-dating shipped 29 March 2020 after being 16% of 2019 reviews and is praised as available by 7 (all JP); the start-date-before-creation option exists but is hidden — 21 requests (3.57%), last July 2026, two reviewers could not find it after reading it existed; see [[C262]] for the 2024 video gate.")
ext("C012", " Report 47: a dot grid that fills — and keeps what was filled — is the retention mechanic: 67 (11.38%, mean 4.70), rising to 17.1% of 2025–26 reviews ('マスが埋まっていくのを見るのが、地味に達成感を感じてとても良い'); calendar / month view praised 9; a combined all-habit overview calendar requested 6 (mean 4.50); the month view showing only a week is a payer's bug.")
ext("C013", " Report 47: account-based e-mail backup and sync (beta 2020, free in 'version 2.0', Feb 2024) spans iPhone, Android and iPad ('애플이랑 삼성 연동'); cross-platform sync unreliable in 2022; sync / backup failures 16 (mean 2.25, 7 in 10–18 Dec 2019 — '同期中ですとの表示が一向におわらず'); a platform bundle is a stated purchase condition ('Macのリリース、ウィジェット導入、iPadとの同期を求めます。そしたら課金します', 2026).")
ext("C014", " Report 47: multiple reminders per habit with editable text are free here and praised by 10 (all 5★).")
ext("C020", " Report 47: sharing / export requested by 3, RecStyle named as the CSV model.")
ext("C022", " Report 47: Apple Watch requested by 6, all 2020–22; the listing shows iPhone, Mac and Vision only.")
ext("C024", " Report 47: the streak resets to zero on a miss — praised as motivating by 3 (5.00) and non-punitive framing praised by 4 ('scoring points, not losing them') vs empty squares demotivating 1; a cumulative total was added by 2025 after 2020–21 requests.")
ext("C027", " Report 47: machine-translated UI costs installs in every non-Japanese market — '적절한 한글화가 절실'; notification options rendered as '汽車' and '手冊' ('car' and 'handbook', TW); 'une traduction française faite de façon automatique et de très mauvaise qualité' — installed and deleted; mainland-Chinese terms shown to Taiwan (5 reviews, none Japanese); Korea's share fell from 32 (2020) to 1 (2025).")
ext("C029", " Report 47: 8 billing failures (1.36%) in a 13-payer corpus — premium reverting to free with ads back (3 in January 2021), '400円を2回も騙し取られた' (charged ¥400 twice), 'アプリを開くと毎回「購入に失敗しました。」' (a purchase-failed loop, Jul 2026), an unintended half-year subscription, a crash the moment a trial payment went through.")
ext("C030", " Report 47: December 2019 sync hanging at 0% (7 reviews in 9 days); a crash loop after logging in to the free backup 6 (Feb 2024 – May 2025, log-out the workaround); registration / login failures 8, six of them from mainland China ('好像需要vpn').")
ext("C031", " Report 47: crashes arrive as dated incidents — 19 crash reviews in January 2021 (10 of them attaching a photo, 9–24 Jan), a white screen when typing a custom habit name Oct 2020 → Jan 2024 (13, all JP, mean 1.54), 4 in January 2026 — 64 crash / cannot-open (10.87%, mean 2.84), 13 of 51 crash reviews still 5★.")
ext("C033", " Report 47: premium status reverted to free with ads reappearing (3 payers, January 2021); a 'purchase failed' loop on every open (Jul 2026); the report's fix #3 is entitlement recognition.")
ext("C034", " Report 47: data loss 16 (2.72%, mean 1.94), all Japanese, 8 of them in 3–20 August 2026 after an update — '7年間使った結果がこれ… アプリ更新したら勝手にデータ上書きされて今までの記録消えた' (seven years overwritten); '2022年から毎日つけていたトピックが消えていました'; '登録していたメアドに復旧のための確認メールは来ない' (no recovery mail); one user stopped writing memos because losing them hurts too much; the data-integrity union rose from 1.1% of reviews (2019–21) to 13.0% (2025–26) while crashes fell 13.8% → 4.8% — 'more stable to open and less trustworthy to rely on'; the report's fix #1: run it as an incident, restore server-side, guard sync against overwrite, ship a visible restore path.")
ext("C036", " Report 47: no findable support route — unresponsive 7 (mean 2.57): '問い合わせ先もわからない'; 'サポートサイトにも窓口がない'; a feedback form that crashes; account-deletion messages unanswered — while 12 reviews (mean 4.42) acknowledge a fix: the gap is the channel, not responsiveness.")
ext("C038", " Report 47: calendar weekdays off by one day for reviewers outside the Japan / Korea time zone — 14 (2.38%), 13 from China, Italy, France, Spain and Australia, 2019 → April 2021 ('4 January 2021 is a Monday and it says Tuesday'; 'it lost 29 February'); habit order scrambling (5, 2022), counts displayed wrong (5, 2025–26), late-night check-ins leaving a gap (fixed); a Sunday week start added on request.")
ext("C039", " Report 47: reminder time-setting buggy Jan–Feb 2021; non-scheduled weekdays notified until fixed by June 2026 — notification bugs 11 (1.87%).")
ext("C040", " Report 47: the 2025 widget gets stuck at 0 or goes blank (5, all 2025–26: 'ある日突然ウィジェットがずっと0表示になってしまいました'); the report's fix #2 pairs it with wrong month-view counts.")
ext("C042", " Report 47: study / learning users 9 (mean 4.78; 'ピアノ練習100日目'), neuro / focus 2; fitness / diet 24 (4.08; a high-schooler's diet log with 14 votes).")
ext("C043", " Report 47: X-per-week and monthly habits requested by 8 (mean 4.12) — absent, and a 5★ requester withdrew the request to protect simplicity.")
ext("C047", " Report 47: totals and statistics requested by 11 (mean 4.55); cumulative total shipped by 2025; a payer wants average and total study time.")
ext("C051", " Report 47: an Android version exists; Apple ↔ Samsung sync is why some users chose it and why 2022 sync failures hurt.")
ext("C056", " Report 47 (counter-evidence): an AI coach replying to each check-in is the first premium feature reviewers praise unprompted (13, mean 4.69) — see [[C263]]; the objections are silent stops and a toggle bug, not the feature.")
ext("C059", " Report 47: 12 reviews (mean 4.42), 10 since 2024, acknowledge a fix — photo multi-select within a week of the request ('まさか本当に意見を取り入れてくださるとは'), late-night gap, Sunday week start, hiding non-scheduled days; stagnant-development complaints 3 ('1年以上更新がないのも残念', 2023).")
ext("C061", " Report 47: gratitude that the app is free 25 (4.24%, mean 4.68 — 'この手のアプリはタスク増やすと課金が必要だけど…'); willing to pay 14 (mean 4.57), 9 before 2022, mostly to remove banners — the 'I'd pay to remove ads' user of 2019–23 became either a subscriber or a leaver after 2024 (ad-removal requests 2.6% → 0%).")
ext("C062", " Report 47: Japan 369 (62.65%, mean 3.54 — where the full arc plays out) and Korea 92 (15.62%, 4.33 — a requesting market: crash 14%, widget and back-dating over-indexed, praise 4.33) are the only eligible storefronts; the high-spend group is 86.93% of the corpus; Korean reviews fell from 32 (2020) to 1 (2025) — the report's E5 is a Korea re-engagement around the widget and back-dating.")
ext("C063", " Report 47: 5-day and one-week trials reported; 'trial not disclosed' 2 (both 1★: '試用期間5日、最初から有償アプリと書け、時間を無駄にした'); a six-year user's app crashed the moment the trial payment went through.")
ext("C065", " Report 47: 13 identifiable payers (2.21%, 12 JP) average 3.23 vs 3.83; nine of thirteen report a billing, entitlement or reliability problem (ads reappearing, charged twice, crash after paying, the month view showing a week, the AI toggle stuck off, the rating prompt shown to payers); 4★ holds most of the payers — 'one fix from five'.")
ext("C066", " Report 47: timers / time tracking requested by a payer for study logging (average and total study time).")
ext("C067", " Report 47: fitness / diet users 24 (4.07%, mean 4.08) are the largest named audience.")
ext("C071", " Report 47: stagnant development 3 ('作者好像不更新了', 2020; '評価が高いアプリなのに1年以上更新がないのも残念', 2023).")
ext("C073", " Report 47: reorder / sort habits requested by 6 (all JP, mean 4.33); habit order scrambled by an update in 2022 (5).")
ext("C075", " Report 47: onboarding confusion 9 (mean 2.44) — two could not find back-dating after reading it existed in the update notes, a third the hidden start-date options; today's done / not-done status unclear 5.")
ext("C080", " Report 47: dark mode must keep every control legible — time-picker digits were unreadable in dark mode (2); more colours requested 3 (2019–20), later unlocked by watching a video.")
ext("C082", " Report 47: the corpus is its own before-and-after on ad format — top-and-bottom banners were a mild theme (11, 1.87%, mean 3.55, 2019 – Apr 2024) whose reviewers mostly asked to pay to remove them; a video ad per check-in (May–Dec 2024) averaged 1.46 and generated exits ('1アクションに1回結構な長さのゲーム広告'; '元々入力するのに1分もかからないのに広告も1分じゃ'; 'an ad after every single entry is excessive… worse option than the notes app'); rewarded video for cosmetic colours (2022) was reported neutrally in a 14-vote 5★ — placement on the completion action, not ads as such, is what reviewers punish.")
ext("C093", " Report 47: upsell nag 4 (mean 1.25, Jul–Nov 2025) — 'タスクを完了するたびに毎回有料版の導入を進めるページに移るのがうっとうしいから消した' (a paid-version page after every completed task; deleted); the 2024 lesson did not carry over to 2025's upsell screens.")
ext("C094", " Report 47: rating prompt nag 3 (2023–26, mean 2.33) — a paying user asks it to stop 'せめて課金してる人に対してくらいは' ('at least for people who pay').")
ext("C095", " Report 47: non-punitive framing praised — 'やったところが色が塗られるので加点方式な感じがして好き' ('what you did gets coloured in, so it feels like scoring points, not losing them'); the report: keep filled colour when a streak breaks, any missed-day marker optional.")
ext("C104", " Report 47: the May 2024 changes arrived unannounced and the word reviewers use is 改悪 ('made worse', 23 reviews at mean 1.39); the listing still says 'unlimited task registration' while reviewers report a cap of 6 — the report cannot resolve which is current.")
ext("C109", " Report 47: no refund requests, but one user cancelled after discovering a half-year plan they did not remember agreeing to ('契約した覚えがないので、もしかしたら無料期間を忘れたのかもしれない。気をつけた方がいいです', 1★, Jan 2026); the fix: a clear notice before a trial converts.")
ext("C132", " Report 47: registration and login fail from mainland China — 6 of 8 login failures are Chinese ('好像需要vpn'), consistent with a blocked backend; China 32 reviews at mean 4.28 otherwise.")
ext("C133", " Report 47: every purchase trigger reviewers name is additive — accumulated value ('プレミアに入ったくらい重宝してます'), study stats, motivation photos, the AI coach, a platform bundle — and none asks to pay to restore something that used to be free; the report's rule: grow premium only through additive value.")
ext("C134", " Report 47: why people give 5★ — simplicity 31.8% of the band, the filling grid 18.4%, behaviour change 13.7% ('三日坊主' no longer), design 12.6%, best-of-many 10.5%.")
ext("C141", " Report 47: iPad not supported — the app runs at phone size (11, 1.87%, 2019–2026: 'iPadサイズに対応しておらず、画面が小さくて見づらい'); requested in every era; an iPad layout is a stated purchase condition.")
ext("C142", " Report 47: the start date before creation exists but is hidden behind blank picker options — the second-largest request in the corpus (21) is a discoverability fix.")
ext("C153", " Report 47: a free backup exists since Feb 2024 but the 2026 loss shows sync overwriting local history on update and recovery e-mails not arriving — backup is only as good as its restore path.")
ext("C157", " Report 47: the streak resets to zero on a miss and is praised by 3 as motivating, while the grid's kept colour is the non-punitive part reviewers love; a missed-day marker (4 requests, 3 KR) should be optional.")
ext("C159", " Report 47: check-in takes 2–4 taps (long-press → record screen → done; a reviewer counts '記録したい項目を選択→＋→完了→＜') and one-tap logging has been requested since 2019 — too many taps 14 (2.38%, mean 2.86: '気軽にチェック入れたいのに何タップもアクションが多くて億劫になる'); the report's E4 is an optional one-tap mode with the memo screen skipped unless long-pressed.")
ext("C167", " Report 47: more colours unlocked by watching a video (2022) — the one rewarded-ad surface reviewers accepted.")
ext("C171", " Report 47: time-picker digits unreadable in dark mode (2); the skip key hidden by the keyboard (Jul 2025); the settings button hidden by long tab names (a payer).")
ext("C172", " Report 47: a per-day memo attached to each check-in is the diary feature Korean and Japanese reviewers name as the differentiator (memo + photo 32, 5.43%, mean 4.75); a note-length limit is asked by 3; one user stopped writing memos after the 2026 data loss.")
ext("C175", " Report 47: an update in August 2026 overwrote years of history (8 reviews in 3–20 Aug); an update in 2022 scrambled habit order (5); the back button vanished in Nov 2020; 'アプリ更新したら勝手にデータ上書きされて'.")
ext("C188", " Report 47: a crash loop after logging in to the free backup (6, Feb 2024 – May 2025) with log-out as the only workaround; a white screen when typing a habit name (13, 2020–24).")
ext("C208", " Report 47: a photo attached to each check-in ('motivation photos' per habit) is a purchase trigger and part of the named differentiator; attaching a photo crashed the app in January 2021 (10 reviews in 16 days); photo multi-select shipped within a week of the request.")
ext("C218", " Report 47: the Japanese listing (12 Sep 2026) says the free version offers 'unlimited task registration' while reviewers from Dec 2024 to Mar 2026 report a free cap of 6 ('6 habitudes gratuites'); two say the paid nature was not disclosed — state the cap and trial length on the listing and at the paywall.")
ext("C222", " Report 47: a user proposes buying slots — 'タブ数だけ買わせてください' ('let me buy just the number of tabs I need', 4★, 2025); the report's E2 is a per-slot purchase for free users at the cap.")
ext("C229", " Report 47 (counter-evidence): a long-press that opens a record screen before 'done' is counted as too many taps by 14 (mean 2.86) — a deliberate gesture must complete the check-in, not open a form.")
ext("C231", " Report 47: Japan (mean 3.54) carries almost all the monetisation shock and the payers; Korea (4.33) requests and forgives (6 of 13 KR crash reviews still 5★); the same product rates 3.70 in JP + KR and 4.25 elsewhere.")
ext("C238", " Report 47: rewarded video for cosmetics was accepted ('動画を見れば使える色が増えます', 14-vote 5★, 2022) where rewarded video for logging yesterday produced 1★ — a rewarded unlock is safe on decoration, never on the record.")
ext("C240", " Report 47: the clearest evidence in the ledger — a video ad on each check-in (May–Dec 2024) produced 24 reviews at mean 1.46 and 20 exits in eight months, banners before and after were tolerated, and the 2025 upsell page after each completed task (4, mean 1.25) and the rating prompt shown to payers repeat the same mistake; the report's rule: nothing between 'tap' and 'done' — monetise elsewhere.")
ext("C246", " Report 47: banners in a free tier are tolerated (11 mild complaints over five years, most offering to pay) but a per-action video is not — ad overload 24 at mean 1.46 and 0 ad complaints in 146 reviews after the rollback.")
ext("C249", " Report 47: the account is optional (backup only) but cannot be deleted in-app, nor the e-mail — 5 reviews (mean 1.60): '退会したいと何度かメッセージ送ってますがもちろん反応はないです'; Guideline 5.1.1(v) has required in-app deletion since June 2022.")
ext("C254", " Report 47: a combined all-habit overview calendar requested by 6 (mean 4.50); a 'today / not yet done' list by 3 (4.67); today's status unclear 5 — the home surface must show every habit's state at once.")
ext("C255", " Report 47: notification options rendered as '汽車' and '手冊' in Traditional Chinese, mainland terms shown to Taiwan, a French machine translation that caused an immediate delete — translation quality 5, none Japanese.")
ext("C256", " Report 47: a note on a missed day that does not count as done requested by 4 (mean 4.50, 3 KR); show missed days 2 — the missed state needs its own visible, optional marker.")
ext("C261", " Report 47: more colours requested 3 (2019–20), later unlocked by watching a video.")

M = {
 "R47-003":["C062"], "R47-004":["C001","C002"], "R47-005":["C031"],
 "R47-006":["C001","C240","C104","C007"], "R47-007":["C001","C240","C082","C246"], "R47-008":["C262","C010"], "R47-009":["C006","C012","C159"],
 "R47-010":["C031","C034","C030"], "R47-011":["C034","C175","C153"], "R47-012":["C263","C056"], "R47-013":["C065","C029","C033"],
 "R47-014":["C093","C240","C094","C248"], "R47-015":["C062","C231"], "R47-016":["C009","C040","C141","C022"], "R47-017":["C059","C036","C249"],
 "R47-018":["C034","C040","C033","C249","C142"], "R47-019":["C002"],
 "R47-021":["C159","C229"], "R47-022":["C172","C208","C024","C047"], "R47-023":["C238","C167","C082"], "R47-024":["C080","C171"], "R47-025":["C013","C051","C030"],
 "R47-026":["C039","C038","C059"], "R47-027":["C141","C022","C043","C044"], "R47-028":["C001","C007","C082","C262"], "R47-029":["C007","C104"],
 "R47-030":["C249"], "R47-031":["C063","C109"], "R47-032":["C004","C003"], "R47-033":["C218","C104"],
 "R47-036":["C031","C171"], "R47-037":["C002","C001"], "R47-038":["C061","C246"], "R47-039":["C067","C042"], "R47-040":["C001","C002"],
 "R47-041":["C007"], "R47-042":["C030","C013"], "R47-043":["C061"], "R47-044":["C038"], "R47-045":["C013","C051"], "R47-046":["C047"], "R47-047":["C082","C246"],
 "R47-048":["C039"], "R47-049":["C014","C008"], "R47-050":["C006"], "R47-051":["C012","C254"], "R47-052":["C075","C254"], "R47-053":["C043"], "R47-054":["C030","C132","C188"],
 "R47-055":["C010"], "R47-056":["C022"], "R47-057":["C073"], "R47-058":["C038","C073","C040"], "R47-059":["C027","C255"], "R47-060":["C095","C157","C024"],
 "R47-061":["C009","C040"], "R47-062":["C208","C172"], "R47-063":["C256"], "R47-064":["C003","C004"], "R47-065":["C031","C082"], "R47-066":["C254","C261","C020","C066"],
 "R47-067":["C071","C005"], "R47-068":["C094","C248"], "R47-070":["C002"],
 "R47-071":["C006"], "R47-072":["C012"], "R47-073":["C134","C070"], "R47-074":["C185"], "R47-075":["C172","C208"], "R47-076":["C005"], "R47-077":["C061","C246"],
 "R47-078":["C001","C240","C262","C007","C104"], "R47-079":["C082","C246","C240"], "R47-080":["C031","C034","C030","C038","C040"], "R47-081":["C132","C188"],
 "R47-083":["C159","C075","C141","C142"], "R47-084":["C027","C255"], "R47-085":["C036"], "R47-086":["C002","C071","C005"],
 "R47-087":["C010","C142","C009","C141","C047","C043"], "R47-089":["C134","C006","C012"], "R47-090":["C065"], "R47-091":["C010","C142"], "R47-092":["C001","C031"], "R47-093":["C002","C034"],
 "R47-095":["C065"], "R47-096":["C133","C013","C263"], "R47-097":["C222"], "R47-098":["C065","C029","C033","C248"], "R47-099":["C181","C109","C063"], "R47-100":["C240","C004","C003"], "R47-101":["C005"],
 "R47-102":["C062"], "R47-103":["C062","C231"], "R47-104":["C062","C231"], "R47-105":["C062"], "R47-106":["C231"], "R47-107":["C231"], "R47-108":["C132","C027"], "R47-109":["C038"],
 "R47-111":["C001","C240"], "R47-112":["C010","C262"], "R47-113":["C034","C031"], "R47-114":["C263","C056"], "R47-115":["C012","C134"], "R47-116":["C061","C246"], "R47-117":["C038","C031","C059"],
 "R47-118":["C062","C027"], "R47-119":["C001","C034","C002"], "R47-120":["C006","C012"],
 "R47-121":["C034","C153","C230"], "R47-122":["C040","C038"], "R47-123":["C033","C029","C109","C152"], "R47-124":["C263","C236"], "R47-125":["C249","C036"], "R47-126":["C142","C010"],
 "R47-127":["C240","C093","C094"], "R47-128":["C262","C010","C204"], "R47-129":["C133","C263"], "R47-130":["C218","C110","C007"], "R47-131":["C141"], "R47-132":["C012"], "R47-133":["C006"],
 "R47-134":["C172","C208"], "R47-135":["C095","C157"], "R47-136":["C003"], "R47-137":["C222"], "R47-138":["C263"], "R47-139":["C159"], "R47-140":["C062","C231"],
 "R47-141":["C034"], "R47-142":["C262"], "R47-143":["C001"], "R47-144":["C062"], "R47-145":["C218"], "R47-146":["C263"],
}
# unattached (nuance register): 001 positioning, 002 method, 020 inventory table, 034 master table, 035 generic, 069 weak rows, 082 forgiving-raters caveat, 088 distribution, 094 cross-tab, 110 trend method
cards = [json.loads(l) for l in open("Tools/prd_ledger/47/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/47/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
