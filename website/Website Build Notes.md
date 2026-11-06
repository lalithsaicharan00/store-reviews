# Website Build Notes

Written by Claude (Claude Code), 4 November 2026: what development needs from the approved designs, so nothing is lost between Figma and the code. The reasons are in [Store Buttons — One or Two](<../Research/Research Reports/Website/Store Buttons — One or Two — 4 November 2026.md>).

**Figma:** [Design-System](https://www.figma.com/design/DCLa48e0M68Y2miWj8OoiN/Design-System), page `website` for the latest, page `archive` for everything discarded.

## Store buttons by device

| Device | What shows |
|---|---|
| Android phone | Get it on Google Play |
| Windows | Get it on Google Play |
| iPhone, iPad, Mac | Download on the App Store |
| Anything else, or no script | Both buttons |
| Google and AI tools | Both buttons, as real links |

One button, centred, on every known device (the user, 4 Nov 2026). The other store's link is hidden with CSS, never removed.

**Rules:**

- **Both store links are always in the HTML** as real `<a href>` links. The default page, before any script, shows both buttons. Never a button that picks its store in `onclick`: Google can't follow it.
- **The footer always has both stores,** on every device.
- **The top bar's Download** goes straight to the store on a phone or iPad, and to `/download` on a computer.
- **`/download` shows both stores on a computer, always.** It's how an iPhone owner on Windows, or an Android owner on a Mac, finds their store. On a phone or iPad it shows that device's store first.
- **The words "Android and iPhone" are in the page's visible text** and its structured data, so people and AI tools can read that we're on both.
- **The buttons stay plain words with no store logos.** If logos are ever wanted, use Apple's and Google's official badges unchanged.
- **A store not live yet** gets an honest "coming soon", never a dead link.

**The script,** inline in `<head>` so nothing flickers:

```js
var n = navigator, u = n.userAgent, d = document.documentElement;
if (/Android/.test(u)) d.dataset.os = 'android';
else if (/iPhone|iPad|iPod/.test(u) || (/Macintosh/.test(u) && n.maxTouchPoints > 1)) d.dataset.os = 'ios';
else if (/Macintosh/.test(u)) d.dataset.os = 'mac';
else if (/Windows/.test(u)) d.dataset.os = 'windows';
```

An iPad says it's a Mac, so a touch screen tells them apart. CSS hides the other store's button for each `data-os`: the App Store on `android` and `windows`, Google Play on `ios` and `mac`.

**Security header:** `script-src 'none'` becomes `script-src 'sha256-…'` with the script's own hash, so nothing else can run. The hash covers every character, so work it out again after any change. `website/build.py` does this at every build; restart a local `wrangler pages dev` afterwards, because it reads `_headers` only when it starts.

**Check before publishing:** Android, iPhone, iPad, Windows and Mac; JavaScript off; and the raw HTML with `curl`, which must carry both links.

## Floating cards

The phone in the hero already shows positive habits, so the cards show what's different: quitting and cutting down.

| Where | Cards |
|---|---|
| Computer | Call family, Social media, Coffee, Smoking |
| Phone | Smoking on the phone's top-right corner, Social media on its bottom-left corner |

They match the app's Today rows:

- **Quit row** (Smoking): "Since 2 Aug" under the name and the live count where other rows have their button. No fill, no streak, no round button.
- **Cut-down row** (Coffee "1 of 2 cups", +1; Social media "12 of 30 minutes max", ▶): no fill, 🔥 streak kept (Android A41). Never "1 left" beside it (A105).
- **Social media says "max" on the website only** (the user, 4 Nov 2026), so it reads as a limit and not as quitting. The app's row says "12 of 30 min".

## Smoking's live count

- **It counts up every second,** in the app's format: `94d 7:42:18` (days, then hours:minutes:seconds; `Format.elapsed`).
- **The count and "Since 2 Aug" come from one start moment,** so they always agree: the script sets it to 94 days, 7 hours and 42 minutes before the visit, and writes both.
- **The HTML holds a fixed value** for crawlers and for no script.
- **Digits don't shift:** `font-variant-numeric: tabular-nums`.
- **Screen readers aren't read every tick:** hide the ticking text from them and give the card one plain label.
- **Reduced motion:** with `prefers-reduced-motion`, the count stays still.
- **It runs in the same inline script,** so the header still allows one hash.

## Every kind of habit (the second section)

Why this section comes next: [After the Hero](<../Research/Research Reports/Website/After the Hero — What People Want to Know Next — 4 November 2026.md>).

- **Real text for search and AI tools:** one `<h2>` ("A tracker for every kind of habit."), an `<h3>` and a line for each kind, an `<h3>` for the band that holds both "Flexible schedules" (the label, in a `<span>`) and "Often enough doesn't mean every day.", so the plain words are in the heading for search and AI tools (the user, 4 Nov 2026: it must say clearly that schedules are flexible). Every row and every "how often" pill is real text too, never an image.
- **Links:** "See every feature" goes to `/features`. Cut down and Quit should link to the quit and cut down search page once it exists.
- **Layout:** three cards in a row on a computer, one on a phone, with no sideways scrolling: everything stays on the page for crawlers. The band sits beside its pills on a computer and above them on a phone.
- **Rows match the app:** same row as the hero, tilted 2.5° each way. Each card's glow is its habit's colour.
- **A row's progress** is a tint up to its share: Water 5/8, Meditate 6/10, Workout 2/4, Make your bed full. Figma draws this as a hard-stop gradient because an instance's fill width can't be changed; in CSS, use a width or a gradient.
- **Smoking's count here is the same live count as the hero's,** from the same start moment, under the same rules (see Smoking's live count).
- **Checklist keeps its Plus tag,** because a new checklist is Plus (Android A73). Check it again if the plans change.
- **The pills use the app's own words** (How often page). "3 times a week" is white only to draw the eye. They aren't buttons, so they get no link or hover.
- **No claim that the app reads screen time or blocks apps.** "Screen time" under Cut down means the person logs it.

## Free and Plus (the third section)

Why this section comes next, and why its copy reads this way: [Free and Plus](<../Research/Research Reports/Website/Free and Plus — What People Need to Know — 4 November 2026.md>).

- **Real text for search and AI tools:** one `<h2>`, an `<h3>` for Free and for Plus, each list a real `<ul>`, and the three promises as text. "One-time purchase" stays in the text: it's how people write it.
- **The heading's two sentences** sit on one line on a computer and one line each on a phone (a `<span>` each, shown as a block only on small screens). "Pay once for unlimited." must stay on one line, so on phones the size follows the screen: `font-size: min(36px, 8.7vw)`, which is 34 px at 390 and 31 px at 360.
- **The price isn't printed yet.** When it's settled it goes on the Plus card, under "Plus", and into the structured data as an `Offer`. Until then the structured data says only that the app is free to download. The Plus page and this card must agree with the app's Plus screen.
- **The Plus card is the Light colour set** inside the dark page, so its text uses the same tokens.
- **The Plus picture** runs off the card's right edge and fades out, to show there's no limit. The icons are decoration: hide them from screen readers, because the list says it all.
- **Link:** "See what's in Plus" goes to `/plus`.
- **Keep the lists in step with the app:** they come from Android A73 and A110. Only Year in Pixels on a habit's page is Plus; month and year views are free. If what's free changes, this section changes the same day.
- **"Nothing free today will ever move into Plus"** is a public promise, from the rule in [Up Next](<../Implementation — Up Next.md>).
- **Words to keep out:** unlock, upgrade now, premium, best value, limited time.

## Progress and streaks (the fourth section)

Why this section comes next, and why its copy reads this way: [Progress and Streaks](<../Research/Research Reports/Website/Progress and Streaks — What Keeps People Going — 4 November 2026.md>).

- **Real text for search and AI tools:** one `<h2>`, an `<h3>` for each card and for the band. "Skip a day and your streak stays." stays a heading, so it can be quoted.
- **The mock-ups are real HTML, never images** (the phones follow the note under "For all four" in the next block): names, numbers and the words in each card are text. The day squares are a list or table with a plain label ("Reached on 21 of 22 days so far"), and each square is hidden from screen readers, so they aren't read out one by one.
- **Layout:** the calendar card beside Milestones on a computer, then Year in Pixels, then Streaks, then the band, so Streaks sits right above "Skip a day". The same order in one column on a phone. No sideways scrolling. The cards and band sit 18 apart on a computer and 12 on a phone.
- **Streaks, milestones and Year in Pixels are phone screens** (the user, 4 Nov 2026): Figma's `Phone / On dark` holding `App / Today · Streaks`, `App / Streaks`, `App / All milestones` and `App / Year in Pixels`, each the app's own 360 × 800 screen. Draw the screen at full size and scale the whole phone. **Streaks** is two half phones at 0.86, side by side beside the words: Today with its three streaks, and Water's history. **All milestones** is 0.94. **Year in Pixels** is a whole phone at 1.0, as large as the card allows. On a phone all are 0.82.
- **Streaks live inside the phone, on Today's rows, in the app's own words** (the user, 4 Nov 2026: the long cards went): 🔥 23, 🔥 6 wk and 🔥 4 mo (`StreakUnit.short`), with 3/8 glasses, 2/3 this week and 1/2 this month beside them. Never write "6 weeks" inside the row: the app doesn't.
- **The fire and its number are always centred on each other, everywhere on the site** (the user, 4 Nov 2026). One flex row: `align-items: center`, 2 px gap, emoji 12/16 beside the number 14/20 (the app's Body Small and Label Large), the same in every row, widget and floating card. A row's streak is right-aligned and ends 20 from the round button, so the number never drifts towards it (`HabitRow.kt`). Measured: with both boxes centred the glyphs sit within a quarter of a pixel, so never nudge the emoji by hand. On the larger streak beside a week (🔥 23 days) the number and unit share a baseline in their own span, and the fire centres on that span.
- **A cut phone is always cut in a gap, never through words** (the user, 4 Nov 2026: "it is cutting in between"). The card's bottom edge crops the phone below something whole: screen height 474 on Today · Streaks and App / Streaks (below Afternoon, and below the note about runs), 681 on All milestones on a computer (below Glasses in total), 484 on a phone (below In a row). Keep the card's height tied to the phone's scale: top of the phone + (18 + that height) × scale. If a scale or a row changes, work it out again. These two cards have no glow.
- **A phone shows less than a computer** (the user, 4 Nov 2026: "really only keep in the mobile what's really necessary"). Here: no streak history phone, and no note under the squares ("Nothing here counts against you…"). Year in Pixels stays large.
- **Words inside a phone screen use fixed colours, never the page's Ink and Muted:** those turn white in a dark section, and the ring's numbers and the "O" month label vanished until this was fixed. Set the app's own colours in the mock-up's CSS.
- **Squares match the app's "What the squares mean"** (`DayCell.kt`, Android Figma's key). Done is the habit's colour with a white ✓. More than the goal is its Strong shade with the ✓. Part is the colour at 50 %. Not done is grey `#E8E8E8` with ✕. Skipped is the same grey with `redo`, and Paused with a **filled** `pause`, both in `#777777`. Still to come is the grey alone. Today is a 2 px ring, 1 px clear of the square, its corners 3 rounder. Sizes keep the app's ratios: at 36, corners 8, ✓ 22, ✕ 18, redo and pause 16; at 28, 7, 17, 14, 12; at 24, 6, 16, 12, 12. Material Symbols Rounded, weight 400. October 2026 starts on a Thursday, and today is the 23rd.
- **The numbers agree across the section:** Water's streak is 23 days everywhere, its milestone is 14 days (reached 13 Oct), and the next is 30 days (7 to go). Stretch's 21 of 22 counts one day not done. If one changes, check the others.
- **The ring's share is the real one:** 23 of 30.
- **Link:** "See how progress works" goes to the progress part of `/features`.
- **Never say a missed day keeps the streak.** Skipping or pausing does (Core ST-2); a missed day ends the current streak, and the best streak and history stay. If the streak rules change, this section changes the same day.
- **Year in Pixels is the one Plus thing here,** so it keeps its Plus tag and its "See what's in Plus" link to `/plus`. Everything else in the section is free and has no tag.
- **Year in Pixels shows one habit** (Read, orange), on a computer and a phone, in the app's layout: months across, days down (the user, 4 Nov 2026: one is enough). Orange is the one warm colour in the section, and its Strong shade is clear to see, where purple's almost matches its Done. The card crops the grid after day 24 at its bottom edge, with today still on show. Draw the grid as one inline SVG with a plain text label, not as about 370 HTML elements, so the page stays light. Hide the squares from screen readers; the "Reached on…" line says it in words.
- **"What the squares mean" beside the year** uses the app's own words and is real text. On the dark card, Part is drawn solid (`#FCBD8B`), the colour it has on white. It lists only the squares this grid shows, so no "No goal that day", "Before the habit started", "Still to come" or "Today".
- **The year is sample data and it adds up:** Read is 249 of 276, and "83 h this year" is those 249 days at its 20 minutes. Skipped and paused days are left out of the count, and today isn't counted yet. If you change a square, work the number out again. Stretch's month has one More than the goal day (the 6th), which is why it's 3 h 40 min and not 3 h 30 min, and Water's week skips Thu 8 Oct, which fits its streak: not done on 28 Sep, then 23 days to 22 Oct.
- **Words to keep out:** insights, analytics, momentum, journey, crush your goals, failed, broken. No "66 days" or other science claims.

## Routines, Reminders and alarms, Tasks, Widgets (sections five to eight)

Four sections of their own (the user, 4 Nov 2026: "they are important, and core thing of our application"). One combined section came first; it's on Figma's archive page. Why these sections and why their copy reads this way: [Fits Your Day](<../Research/Research Reports/Website/Fits Your Day — Routines, Reminders and Widgets — 4 November 2026.md>).

**For all four**

- **Real text for search and AI tools:** one `<h2>` per section, an `<h3>` per card. Each `<h2>` carries the section's search words, so keep them word for word.
- **Phones:** Figma's `Phone / On dark` holding the app's own 360 × 800 screen. Draw the screen at full size and scale the whole phone, so it keeps the app's proportions. The words on the screens are real HTML and decoration: hide them from screen readers, because the headings and captions beside them say the same thing. There are 17 phones in these sections and Progress and streaks on a computer and 15 on a phone, so check this on the cheap-phone speed run. **`content-visibility: auto` was tried and left out** (4 Nov 2026): side by side in one run, three rounds, scrolling was the same (17 ms a frame) and first paint within noise (0.84–0.91 s with, 0.87–1.09 s without), while full-page captures, which search and AI tools can use, showed the phones blank. If the page is ever too heavy, phone screens may become WebP with real `alt` text; the headings carry the search words either way.
- **What a phone leaves out is only ever an extra example** (the user, 4 Nov 2026): each section's heading and sentences stay and still say everything. Hide the extras with CSS at phone width, in the same HTML. Google reads the phone layout, so never let a search word live only in something hidden there.
- **Leads** use `text-wrap: balance`, so no line ends on one word.
- **No sideways scrolling** on a phone. Where side phones peek in, the section clips them.
- **Stacks of phones (Routines, Reminders, Widgets, on a phone only).** The user, 4 Nov 2026: one phone in front with two behind, exactly the same in all three. Frame 328 × 540. Front phone 0.62 (246 × 518) at 41, 10. Back phones 0.5 (198 × 418) at −72, 60 and 202, 60. The back phones sit behind the front one. Never change one stack without the others.
- **Any motion on these stacks is built on the website only, never drawn in Figma** (the user, 4 Nov 2026). Figma shows the resting stack. Keep it to CSS with no script, and leave it out under `prefers-reduced-motion`. All three phones stay in the HTML, so search and AI tools read the same page.
- **Samples agree across the page:** today is Fri 23 Oct 2026. Water's streak is 23 and today is part done (3 of 8), so This week shows Sunday to Thursday done, Friday as Part with today's ring, Saturday still to come. Stretch's streak is 7, from the month card in Progress and streaks. Meds is 🔥57 before it's ticked and 🔥58 once it's done. A row on Today only shows what's due today: Water plants is next on the 25th, so it isn't in the Today list.
- **Stretch keeps the website's mint colour and icon** from Progress and streaks, on Today and in the player. The app's demo has it Teal, with its own figure icon.
- **Words to keep out:** nag, smart, AI, seamless, boost your productivity, supercharge.

**Routines (5.1, 5.2)**

- **`<h2>`: "Morning and evening routines."** The words "routine", "morning", "evening" and "times of day" stay in visible text.
- **Four phones show a routine from start to end:** Today with its Start button, a timer, a checklist, and Morning is done. 0.64 on a computer, in a row, each with a caption. On a phone, a stack (see "Stacks of phones"): the timer in front, Today and the checklist behind; the captions' four titles as chips under it, and no Done phone.
- **The times of day band:** Morning, Afternoon, After work, Evening, in clock order (a time of day the person added sits in its place by time). The rows are real HTML. After work is a sample of adding your own. On a phone only Morning and After work.
- **Link:** "See how routines work" goes to the routines part of `/features`.

**Reminders and alarms (6.1, 6.2)**

- **`<h2>`: "Reminders and full-screen alarms."** Two lines on a phone: "Reminders and" and "full-screen alarms." (a `<span>` each, a block only on small screens), so it never breaks inside "full-screen".
- **Full-screen alarms are shown at the user's request** (4 Nov 2026). The screens are Android's. The iPhone rings full screen too, through AlarmKit on iOS 26, so the claim holds on both; don't name an iOS version on the page. On Android, a phone that hasn't allowed the full screen gets a held heads-up instead, so say "fills the screen" of the alarm, never "on every phone".
- **Three alarm phones:** Take vitamins (Done), Water (+1 glass), Read (Start, Log time). 0.6 on a computer. On a phone, a stack (see "Stacks of phones") in the Full-screen alarms card: Take vitamins in front, Water and Read behind.
- **Notifications are real HTML:** a check, a typed number, a timer, a checklist and a task, each with the app's own buttons, beside a lock screen phone. A logged reminder works from the lock screen without unlocking, on both platforms (D13). On a phone only the first three, then the lock screen at 0.6, cut by the card just below its notification (screen height 470). The three facts sit in one card there.
- **A notification's mark is white tiles** at three strengths on the habit's colour, because that's how Android draws its small icon. Only inside this mock-up: the logo everywhere else stays the approved tonal set.
- **Remind me again has the Plus tag.** The app offers every 15 or 30 minutes or every hour, at most three times. Never write "15, 30 or 60 minutes". Quit habits have no reminders.
- **Never promise a reminder's timing:** no "never forget", "never miss", "always on time" or "guaranteed". A phone maker can hold a reminder back. "Quiet once it's done" is true (the app's own words: "Not sent on a day it's already done").
- **Link:** "See how reminders work" goes to the reminders part of `/features`.

**Tasks (7.1, 7.2)**

- **`<h2>`: "Unlimited tasks, one-time or repeating."** The lead says it's free: tasks don't count towards the five free habits (`activeHabitCount`). If that ever changes, change this section the same day.
- **Two cards, One-time and Repeating,** each with its schedules as chips and a phone at 0.8 (0.74 on a phone), cut off by the card's bottom edge. On a phone the cut is under a whole row: screen height 401 on One-time, 408 on Repeating.
- **Every chip is a real schedule from the app:** Today, Tomorrow, a date, No date; Every day, Tuesdays, Every 3 days, Every month, Every year, 2 weeks after it's done. The chips aren't links or buttons.
- **A task with No date stays on Tasks and never shows on Today.** The band says so.
- **Link:** "See how tasks work" goes to the tasks part of `/features`.

**Widgets (8.1, 8.2)**

- **`<h2>`: "Interactive widgets. Tick off from anywhere."** The user, 4 Nov 2026: "that word interactive, that you can tick off from anywhere". Never reword it to plain "widgets". On a phone it's three lines ("Tick off from anywhere." doesn't fit on one at this size).
- **Three home screen phones** at 0.74 with a caption each. On a phone, a stack (see "Stacks of phones"): Today in front, Habits and Week and tasks behind, with no captions.
- **Everything Free is in one panel, everything Plus in the other** (the user, 4 Nov 2026). Free: One habit 2×2 for a check, an amount, a typed amount, a timer, quit and cut down; Tasks 4×2 and 4×4. Plus: Today 4×4 and 4×2, the Quit or cut down list, This week 4×2. **On a phone, one example of each:** Free keeps Take vitamins, Water, Focus, Smoking and Tasks 4×2; Plus keeps Today 4×4 and This week 4×2. The labels still name both sizes, and the Plus sentence still names checklists.
- **A checklist 2×2 sits under Plus,** because a new checklist habit is Plus, even though the widget itself is free. The panel's sentence says so. If the plans change, change the panels and the sentence the same day (Android A73, A110).
- **The grid is three columns of 328 with gaps of 16** (1016 wide, 92 from the card's edge), widgets at the app's own sizes: 156 × 176, 328 × 176 and 328 × 368. On a phone it's one column, with 2×2s in pairs.
- **Smoking's number is a live count,** the same as the hero's. Its seconds tick with the hero's script: don't add a second one.
- **Squares follow "What the squares mean"** (see the Progress and streaks notes). The widget's are 20 with corners of 5 and a ✓ of 14.
- **Link:** "See every widget" goes to the widgets part of `/features`, or the widgets search page once it exists.

## Private and backed up (the ninth section)

Why this section exists, and why there's no Questions section: [Private and Backed Up](<../Research/Research Reports/Website/Private and Backed Up — What the Homepage Still Missed — 4 November 2026.md>). The same rules as "For all four" above.

- **Search words:** the `<h2>` is "Private, offline and backed up." Keep it word for word. An `<h3>` per card, and "New phone? Your habits come back." stays a question.
- **Link:** "Read our privacy policy" goes to `/privacy`.
- **Computer:** two cards with a phone at .8, cut at the same place (screen y 674, the gap under Export), then three short cards, then Take your data with you.
- **Phone:** phones at .74, Backup cut at screen y 476 and Restore at 532, both in a gap. The three short cards become one card with three rows, by CSS in the same HTML, to keep the page short.
- **Screens:** `App / Backup` and `App / Restore`, rebuilt from the Android design. Both leave out the sample Gmail address, so a real person's address never reaches a public page: Restore says "in your Google Drive", which is what the app says when it doesn't know the address (`RestoreFlow.kt`).
- **Google Drive's logo isn't drawn** on the Restore screen: a plain cloud icon stands in, behind the dimmed page. The title Backup & Sync is the app's own page name, so it stays, though the page's words never say "sync".
- **Never add:** that the app syncs on Android, or that a backup is on before someone connects it.

## Download and footer (the end of the page)

The last section of Home. The footer is on every page of the site; the closing above it is Home's.

- **Search words:** the `<h2>` is "The habit tracker for Android and iPhone." Keep it word for word: it's the page's plain statement that we're on both.
- **The button** follows "Store buttons by device" above, like the hero: Figma shows Windows and an Android phone, and a Mac, iPhone or iPad shows Download on the App Store. It's full width on a phone, as in the hero.
- **No phone here:** the page has shown plenty. The logo, the heading and the button are enough to end on.
- **The footer's Google Play and App Store are always both, on every device, never hidden by the script.** They're how an iPhone owner on Windows finds their store. They're plain words, no store logos.
- **Links:** real `<a href>` to App (Features, Plus, Download, About), Explore (the four search pages), Help (Support, Often Enough facts) and Legal (Privacy, Terms). Google finds pages through these, so all fifteen pages are one link from every page. **Build a link only once its page exists:** no dead links at launch.
- **Tap room:** on a phone give each link at least 44 px of height with padding, keeping the 12 px look.
- **Markup:** `<footer>` with a `<nav aria-label="Footer">`; each column's name is a heading for screen readers.
- **Name in the copyright:** "© 2026 Often Enough" until the user decides whether their name appears on About. Privacy has to name the developer either way.

## Privacy

Why it reads this way: [Privacy Page](<../Research/Research Reports/Website/Privacy Page — What It Must Say — 4 November 2026.md>).

- **The address is `/privacy` and it never moves.** The Android app links to it.
- **Developer:** Koyalakonda Lalith Sai Charan, the user's legal name, written exactly so, here and wherever the site names the developer.
- **Real HTML, one page, no PDF.** `<h1>` Privacy policy, an `<h2>` per policy section, an `<h3>` per question card. Each section has an `id`, so the contents link to it and people can link to one part.
- **On this page** stays in view while scrolling on a computer (`position: sticky`, no script). It's left out on a phone, by CSS.
- **Tables** are real `<table>` or `<dl>` markup. On a phone each row stacks: the label, then its text.
- **Links:** how to delete your data goes to Support's answer, `/support#delete-my-data`; the Google policy to its page; the address is a `mailto:`. Add `email_off` so Cloudflare doesn't hide it (see the Rulebook's W2 note on edge-transformed HTML).
- **Date:** "Updated" changes whenever the words do, and the `<time>` tag with it.
- **Keep it true:** when the app changes what it touches, this page changes in the same piece of work.

## Support

Why it reads this way: [Support Page](<../Research/Research Reports/Website/Support Page — What People Need Help With — 4 November 2026.md>).

- **The email is `support@oftenenough.com`** (Cloudflare Email Routing, set up by the user on 4 Nov 2026), on Support, Privacy and Terms, as a `mailto:` with `email_off`. Keep it in one place in the build, so one change moves every page when a new address works.
- **Real text, never collapsed:** each answer sits in the HTML, open, so people and AI tools can read it. An `<h2>` per group and an `<h3>` per question, with an `id` on each so one answer can be linked.
- **Structured data:** no `FAQPage` needed for rich results, which Google has ended; plain headings do the work.
- **On this page** works as on Privacy: sticky on a computer, left out on a phone.
- **The white button** is the email link, full width on a phone.
- **Links:** in the refund answer, Google Play goes to `https://support.google.com/googleplay/answer/2479637` and Apple to `https://support.apple.com/en-us/118223`. The answers keep the ids `delete-my-data` and `get-a-refund`, because other pages link to them.
- **Keep it true:** the steps use the app's own names, so a renamed page or setting changes here in the same piece of work.

## Terms

Why it reads this way: [Terms Page](<../Research/Research Reports/Website/Terms Page — What It Must Say — 4 November 2026.md>).

- **The address is `/terms` and it never moves.** Google's consent screen links to it, and `/terms-and-conditions` redirects there.
- **Built like Privacy:** real HTML, `<h1>` Terms of use, an `<h3>` per question card, an `<h2>` per section with an `id`, and On this page sticky on a computer and left out on a phone.
- **Links:** Plus page to `/plus`, both Support page links to `/support#get-a-refund` and `/support#delete-my-data`, Privacy policy to `/privacy`, Apple's standard licence to `https://www.apple.com/legal/internet-services/itunes/dev/stdeula/`, and the address as a `mailto:` with `email_off`.
- **Date:** "Updated" changes whenever the words do, and the `<time>` tag with it.
- **Keep it true:** the free limit, what Plus includes and the promises here change only with the user's say-so, and in the same piece of work as Plus and Support.

## Pages we dropped

The user, 4 Nov 2026: no Delete your data page and no Refunds page. There are no accounts, and both stores handle billing, so neither is required; Support answers both.

- **Redirects:** `/delete-account`, `/delete-your-data` to `/support#delete-my-data`, and `/refunds` to `/support#get-a-refund`. The old `/delete-account` may still be listed in Play Console.
- **Remove the old `/support /help 301`** in `_redirects`; `/help` now redirects to `/support`.
