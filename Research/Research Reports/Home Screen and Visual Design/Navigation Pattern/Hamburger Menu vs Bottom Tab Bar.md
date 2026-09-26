# Hamburger Menu vs Bottom Tab Bar

> **Written by Claude (Claude Code)**, 24 September 2026. Authorship of every report is listed in the [Research Reports index](<../../README.md>).

**Status: exploratory research, not a decision.** Decisions live in Notion.

**The question.** Gmail, Google Calendar, ChatGPT and Claude all use a hamburger (side drawer) on mobile. Google Drive and most habit trackers use a bottom tab bar. For a simple-looking habit tracker, which one should we use: the hamburger, the bottom tab bar, or both?

**The short answer.** Use a **small bottom tab bar with three tabs** (Today · Progress · Me). Don't use a hamburger. Don't use both.

- Hamburger apps work when there is **one main screen plus a long list of things of the same kind**: labels in Gmail, calendars in Google Calendar, past chats in ChatGPT and Claude. Our app has neither. Home is the main screen, and the few other places (stats, themes, settings) need to be *seen*, not tucked away.
- Our own reviews show the main drawer failures: it **hides things**, it **adds a tap every time you switch**, and it is **hard to reach** one-handed.
- The main tab-bar failure is **tabs spent on things users never use** (Explore, Friends, PRO, Feedback). That is why the bar should have only three tabs.

*Prepared 24 September 2026. Reviews span 2011 to September 2026. External sources were fetched on 24 September 2026.*

---

## How to read this

- **Scope.** Every review in the repository was screened: **1,487,223 reviews** (App Store 337,331, Google Play 901,453, native-app corpora 248,439).
- **Screen.** Keyword families in 12 languages for: hamburger / drawer / side menu; tab bar / bottom bar / tabs; findability ("buried in the menu", "too many taps", "hard to navigate"). **6,428 reviews matched.**
- **What was read by hand:**

| Tier | What it is | Reviews | How it was read |
|---|---|---|---|
| S | Names a hamburger, drawer, side menu, tab bar or bottom bar | 869 | **Every review read and coded** |
| F-core | "Buried in a menu", "too many taps/screens/menus", "hard to navigate" | 922 | **Every review read and coded** |
| F-rest | Generic "can't find…" or "the menu" | 1,539 | Random sample of 200 (seed 20260924) |
| G | Generic "easy/hard to navigate" only | 3,098 | Random sample of 200 (seed 20260924) |

- **1,791 reviews were read in full.** 1,048 of them say something about app navigation. The rest were about spreadsheet sheet-tabs, food ("hamburger"), kitchen drawers, notification shades and so on.
- **Citations.** `A23#5141` means line 5,141 (counting from 0) of `App Store Reviews/23. …/reviews.jsonl`. `P` is Google Play and `N` is the native-app corpus. This is the same form as the [Home Screen Cards and Widgets](<../Home Screen Cards and Widgets/Home Screen Cards and Widgets.md>) report.
- **Stars (★)** are the mean rating of the reviews in a group. They show context, not cause.
- Evidence files are in [Navigation Evidence](<Navigation Evidence/>). Section 7 lists them.

---

## 1. What reviewers actually complain about

**Almost nobody reviews the navigation pattern itself.** Reviewers talk about navigation when it gets in their way.

| What reviewers say | n (of 1,791 read in full) | ★ | Apps | Notes |
|---|---|---|---|---|
| Hard or confusing to navigate | 572 | 2.39 | 52 | **333 are Fabulous** (both stores). Mostly "too much going on". |
| Clutter: too many screens, menus, pop-ups or buttons | 171 | 2.19 | 26 | 127 are Fabulous |
| Too many taps to do something | 124 | 2.41 | 32 | Includes logging a habit: five taps to check one habit `A24#23852`; "waaaaaay too many taps to mark a task" `A48#4228` |
| A feature or setting is hidden or hard to find | 108 | 2.68 | 32 | |
| **Hamburger / drawer complaints** | **87** | 3.37 | 20 | 52 are native apps (Google Calendar, Microsoft To Do, Google Keep, Notes) |
| Hard at first, fine after a few days | 75 | 4.31 | 14 | Learnability, not a lasting problem |
| A redesign moved things and made them worse | 70 | 2.30 | 27 | Both directions were punished (section 4) |
| **Bottom tab bar / tab complaints** | **69** | 3.10 | 25 | 11 are about list tabs inside a to-do app, not app navigation |
| Wants everything on one screen | 46 | 3.52 | 22 | Matches the Home Screen report's top finding |
| **Tab bar / tab praise** | **41** | 4.88 | 16 | 13 about app-level bottom bars; 23 about list tabs in to-do apps |
| **Tab bar requests** | **24** | 4.00 | 17 | |
| Swipe gestures (wanted, or missing) | 23 | 3.39 | 12 | |
| **Drawer requests** | **18** | 3.33 | 9 | 14 are native apps, mostly iPad sidebars |
| Hard to reach with one hand | 9 | 3.33 | 7 | |
| **Hamburger / drawer praise** | **9** | 3.89 | 6 | 5 are to-do apps with many lists |

**The generic remainder.** In the 200-review sample of generic "navigate" mentions:

- 47% (±6.9) praise easy navigation. That is about 1,460 of 3,098. The praise is almost always about *simplicity*, not about a pattern: "super simple interface, easy to navigate" `P24#14242`.
- 13.5% (±4.7) complain. That is about 420, again led by Fabulous.

In the 200-review sample of "can't find…":

- 27.5% (±6.2) are about a feature being hard to find, about 420 of 1,539. Examples: delete a habit, light mode, how to add a habit, the "first aid" screen in Finch.
- 10% are about finding the cancel button. That is a billing problem, not a navigation pattern.

**What this means.** The fight is not "hamburger vs tab bar". It is:

1. **Clutter.** Too much on the screen, too many places.
2. **Taps.** How many taps it takes to do the thing I came for.
3. **Visibility.** Whether I can see where things are.

The pattern matters only as far as it helps or hurts these three.

---

## 2. When the hamburger fails (87 complaints, 9 praise)

| Failure | n | What reviewers say | Examples |
|---|---|---|---|
| **It hides things** | 17 | Lists and features are out of sight, so people forget them or want a visible overview instead. Eight reviews of the to-do app *Tasks* ask for a home page listing their lists, instead of the side bar. | "The sidebar menu is not good to remind users that other things are avaliable. I forget often that I have skills, party quests, items" `P8#2094`; "a home screen that shows all the main lists that isn't on the side menu" `P84#24202`; "the folders don’t appear in the main folder unless you open it in the side panel" `N3#25296` |
| **An extra step every time you switch** | 13 | Google Calendar put the month view behind the hamburger. Reviewers must "keep going back to the burger menu to select month view". | `N8#8804`, `N8#12986`, `N8#24838`; a Japanese Google Tasks user finds opening the sidebar every time to switch lists tedious and asks for a swipe at the bottom instead `N6#2977` |
| **Hard to reach, and no gesture** | 8 | The hamburger sits in the top-left corner, the hardest spot for a thumb. On iOS it often has no edge-swipe gesture. | "reaching that hamburger menu with one hand is quite cumbersome" `P84#32890`; "there is no swipe gestures in the app, only buttons… hamburger menu is also uncomfortable thing" `N7#6167` |
| **Redesign to a full-screen sidebar** | 6 | Microsoft To Do's 2019 full-screen sidebar was called "a huge step back". | `N10#2597`, `N10#5490` |
| **Messy, long or outdated drawer** | 11 | Mostly Habitica. | "The nav drawer is way too long… I just dont know where to click" `P8#12154`; "the hamburger menu looks a little outdated" `P8#3301` |
| Bugs, looks, tablet sidebar behaviour | 32 | Mostly Google Calendar's side panel not opening, plus iPad sidebars overlaying content. | `N8#21763`, `N2#9089` |

**Where the drawer is liked (9 praise, 18 requests).** Two situations:

- **Many items of the same kind.** When Google Tasks replaced its hamburger list-picker with a row of horizontal tabs, users with many lists pushed back: "Please bring back the side menu/list selector… horizontal tabs at the top, which requires repeatedly swiping left and right to find a specific list" `N6#4541`; "I absolutely despise that the little hamburger menu was taken away" `N6#4827`.
- **Big screens.** 14 of the 18 drawer requests are for a permanent sidebar on iPad or Mac (`N10#2622`, `N6#2947`, `N6#3168`).

This is exactly the Gmail, Google Calendar, ChatGPT and Claude situation (section 5). Our app does not have an unbounded list of things like that. Groups are a filter chip row on Home, per the Day Structure research.

---

## 3. When the bottom tab bar fails (58 app-level complaints, 13 praise)

| Failure | n | What reviewers say | Examples |
|---|---|---|---|
| **A tab spent on something I don't use** | 17 | Explore, Discover, Friends, Group, PRO, Feedback, or an ad for a paid service. Users ask to remove, hide or replace it. | "the main app navigation (bottom bar) is wasted for this. 3 buttons, \"Today , Weekly , Overall\" would fit here instead" `P19#339`; "Don’t like the “friend” icon on the bottom because I don’t use it… waste of real estate" `A1#52498`; "useless ads taking up ONE whole tab" `N5#16892`; "There are tabs at the bottom that are not useful and still we cannot remove them" `A43#135` |
| **Too many tabs** | 17 | Mostly Fabulous: "each icon at the bottom leads almost into 5 separate apps". | `A24#15634`, `P12#116130`, `N5#11748` |
| **Pages instead of scrolling** | 5 | Streaks splits habits over pages and switches them with a bottom icon. Reviewers want one scrolling list. | `A23#5141`, `A23#5406` |
| **Unlabelled or unclear icons** | 4 | Plus two more inside other rows. | "icons at the bottom… too small and non explanatory, no labels" `A23#7255` |
| Other: visuals, overlap with the home indicator, moved items | 15 | ShineDay moved stats out of the bar, and users had to go through "Me" `A52#3890`. Finch added a tap to the Shop tab `A10#32506`. | |

**What tab bars are praised for (13 app-level praise, 24 requests):**

- **Easy to get around:** "Easy to navigate UI with the bottom tabs" `P31#556`.
- **Views at the bottom:** "daily/weekly/monthly/ yearly view with tabs at the bottom of the app" `A55#1777`.
- **Reach:** "5 stars for one single reason… the menu bar located at the BOTTOM of the screen. Forgot reaching to the top of the screen to access the hamburger" `N6#6933`.
- **Fewer tabs is better:** not overloaded with features and tabs like Finch (Russian, paraphrased) `A28#361`.

**Requests** include:

- "a bottom bar tab so you can easily access the statistics" `A1#2450`;
- "changing from Hamburger menu to bottom navigation bar" `P111#2283`;
- move the menu bar to the bottom so bigger phones are easier to use (German, paraphrased) `P126#15636`.

**What this means.**

- The tab bar's failure is fixable by keeping it **short, labelled, and made only of things everyone uses daily or weekly**.
- The drawer's failures (hiding, the extra tap, reach) are built into the pattern.

---

## 4. Moving things later is the most expensive mistake

- 70 reviews complain that a redesign moved navigation (**★2.30**, 27 apps). It happened in both directions:
  - **drawer → full-screen sidebar:** Microsoft To Do, `N10#2597`;
  - **drawer → tabs:** Google Tasks, `N6#4541`;
  - **view switch → behind the drawer:** Google Calendar month view, `N8#18557`;
  - **item removed from the tab bar:** ShineDay stats, `A52#3890`;
  - **front-page item → buried in a menu:** Finch first aid, `A10#20221`.
- This matches the Home Screen report (widget redesigns, 302 reviews) and the Day Structure report (sections removed, ★2.55).

**Rule:** choose the structure once, before launch, and keep it.

---

## 5. External evidence

**Usability research**

- **Hidden navigation hurts discovery and speed.** NN/g tested 179 people on 6 sites. Hiding the main navigation behind a menu icon cut discoverability roughly in half, made mobile tasks about 15% slower, and raised perceived difficulty. Their follow-up recommends visible or combined navigation, with labels on icons. ([NN/g, Hamburger menus hurt UX metrics](https://www.nngroup.com/articles/hamburger-menus/); [NN/g, Beyond the hamburger, mobile](https://www.nngroup.com/articles/find-navigation-mobile-even-hamburger/))
- **Tab bars are for a few, equally important destinations.** They give one-tap access, show where you are, and sit in thumb reach. The cost is permanent space, about 7–10% of the screen, and a limit of about five items. ([NN/g, Basic patterns for mobile navigation](https://www.nngroup.com/articles/mobile-navigation-patterns/))
- **Thumbs do most of the work.** Hoober observed 1,333 people: 49% held the phone in one hand, and the top corners are the hardest to reach. That is where hamburgers live. ([UXmatters, How do users really hold mobile devices?](https://www.uxmatters.com/mt/archives/2013/02/how-do-users-really-hold-mobile-devices.php))

**Real product tests**

- **Spotify** tested hamburger vs tab bar in 2016. Users with the tab bar clicked about 30% more on navigation items and 9% more items overall, with no loss in retention. Spotify shipped the tab bar on iOS and Android. ([TechCrunch](https://techcrunch.com/2016/05/03/spotify-ditches-the-controversial-hamburger-menu-in-ios-app-redesign/))

**Platform guidance**

- **Material 3:** use a navigation bar for **3–5** destinations on phones, and never for fewer than three. Use a drawer for 5+ destinations or deeper hierarchies. **Avoid using a drawer together with a navigation bar.** ([Navigation bar](https://m3.material.io/components/navigation-bar/guidelines); [Navigation drawer](https://m3.material.io/components/navigation-drawer/guidelines))
- **Apple, iOS 26:** the tab bar floats above content and can **minimise on scroll**, collapsing to the active tab and expanding when you scroll back. That answers the "tab bars eat space" objection on iPhone. ([Apple HIG, Tab bars](https://developer.apple.com/design/human-interface-guidelines/tab-bars); WWDC25 session 284)

**The apps you named, and why they differ**

| App | Mobile navigation | Why it fits that app |
|---|---|---|
| Gmail | **Both:** bottom bar (Mail · Chat · Meet), which shrank and dropped labels in 2022, plus a drawer for labels and folders | Many labels, an unbounded list of the same kind of thing ([Android Police](https://www.androidpolice.com/gmail-navigation-bar-icon-labels/)) |
| Google Calendar | Drawer for views and calendars | Many calendars. But our corpus shows the cost: the month view behind the drawer drew repeated complaints (section 2). |
| ChatGPT, Claude | One main screen (the chat) plus a side drawer holding past conversations | An unbounded history list is the drawer's ideal content ([OpenAI release notes](https://help.openai.com/en/articles/6825453-chatgpt-release-notes)). A July 2026 blog reports Anthropic testing a bottom bar on iOS; this is **unconfirmed**. ([Progressive Robot](https://www.progressiverobot.com/2026/07/19/claude-ios-bottom-navigation-bar/)) |
| Google Drive | Bottom bar: Home · Starred · Shared · Files | A few equally important destinations ([Google Drive Help](https://support.google.com/drive/answer/2424384)) |
| Loop, HabitKit (most-praised habit layouts) | No drawer and no tab bar. One home screen, with a few icons in the top bar. | Home is almost the whole app |

**The pattern behind all of them:**

- A **drawer** holds *a long list of one kind of thing*.
- A **tab bar** holds *a few different places*.
- "Both" (Gmail) exists only because Gmail has both.

---

## 6. What this means for our app (candidate, not a decision)

**Our places.** Home ("Today") is used several times a day. Stats/history is the second most important surface: the Home Screen report found history-on-home and stats both strongly wanted. Themes are how we make money, so they must be seen to be sold. Settings is rare. There is no unbounded list of one kind of thing, because groups are a filter chip row on Home, not a navigation destination.

**Candidate structure:**

1. **A bottom tab bar with exactly three labelled tabs:** **Today**, **Progress**, **Me**. Me holds themes and icon packs, groups, sections, and settings.
   - Three is Material's minimum and avoids the "wasted tab" complaint.
   - No Explore, no Community, no PRO tab (section 3).
2. **Views live inside Today, not in the tab bar.** A segmented control at the top switches **List · Week · Month · Year** with one tap, as the Home Screen report recommends. View switching must never go behind a menu (Google Calendar, section 2).
3. **"+ Add habit" goes in the top bar of Today, not in the centre of the tab bar.**
   - Adding is infrequent. Productive users complained when the bar was centred on "add", which they called "one of the actions I've used the least" (`A13#12697`).
   - Adding must still be visible: "It's a little hard to find where to add a new habit, it would be nice if that was very front and center" (`P12#45808`).
4. **The tab bar is compact and minimises on scroll** (iOS 26 behaviour; the Material bar can hide on scroll). This protects the density that the Home Screen report ranks first.
5. **No hamburger anywhere.** The one drawer-like surface is a *bottom sheet* for section customisation, opened from a section header. It holds a task, not navigation.
6. **Swipe left and right on Today changes the day**, with a "Today" chip to jump back. This answers the 23 swipe reviews (e.g. `P2#10421`).
7. **iPad later.** A permanent sidebar (the 14 native iPad requests) is the right adaptive form on wide screens. It is the same three places in a different container.

**Why not "both".** Material advises against combining them. Every extra piece of chrome takes space from habits, and clutter is the largest home-screen complaint (707 reviews, ★2.60, Home Screen report). We have nothing that would fill a drawer.

**The honest counter-case for a hamburger.** It *looks* cleaner in a static screenshot, and ChatGPT and Claude make it feel modern. But the tab bar can minimise on scroll, which gives most of the clean look without hiding Progress and Themes. Hiding the themes shop would work directly against the business model.

---

## 7. Method and limitations

**Files.** Everything is in [Navigation Evidence](<Navigation Evidence/>):

- `review-classification-map.txt`: every one of the 1,791 fully read reviews, with codes and a short note;
- `findability-sample-codes.txt` and `generic-navigate-sample-codes.txt`: the two 200-review samples;
- `candidate-index.jsonl`: all 6,428 screened hits, with store, folder, line and review ID;
- `evidence.txt`: a per-code listing with citation IDs;
- `codebook.md`;
- `screen.py` and `aggregate.py`. The working copies, which run from `Temp/navigation/`, are there too.

**Validation.** `aggregate.py` checks that every candidate in each tier is coded exactly once. Result: 0 missing, 0 unknown indices, 0 unknown codes.

**Limitations.**

- **Keyword recall.** A review that describes navigation without any screened word is missed, so counts are floors.
- **Concentration.** Fabulous dominates the "hard to navigate" and clutter counts. Google Calendar, Microsoft To Do and the to-do app *Tasks* dominate the drawer counts. Each claim names its lead apps.
- **Reviewers mention navigation rarely.** Silence is not approval. The external studies carry more weight on the pure pattern question. The corpus carries more weight on *which failures matter to habit-tracker users*.
- **Long reviews** (over 700 characters) were read in windows around the matched terms.
- **Single coder.** Code definitions are fixed in `codebook.md`.
- **External sources are secondary summaries** in places (Spotify's numbers come from press coverage). The Claude bottom-bar report is unconfirmed.
