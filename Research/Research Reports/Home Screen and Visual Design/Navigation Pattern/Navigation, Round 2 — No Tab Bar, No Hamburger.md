# Navigation, Round 2 — No Tab Bar, No Hamburger

> **Written by Claude (Claude Code)**, 26 September 2026. Authorship of every report is listed in the [Research Reports index](<../../README.md>).

**Status: research, not a decision.** Decisions live in Notion. This revisits [Hamburger Menu vs Bottom Tab Bar](<Hamburger Menu vs Bottom Tab Bar.md>) (24 Sep), which recommended three tabs: Today · Progress · Me.

**What changed.**
- The day switcher now sits at the bottom: "‹ Today · 14 left ›" (Figma 182:19).
- With a tab bar under it, "Today" appears twice.
- The user expects the profile tab to be little used.
- A Library and guided habits are planned.

**The questions.**
1. Is a profile tab disliked?
2. Can the tab bar go? If it does, where do Progress and the profile live?
3. Is a hamburger right for future sections?
4. Do people need a list of all their habits?
5. Where does a Library go?

**Basis.**
- **Reused:** the 24 Sep navigation study (1,791 reviews read).
- **New scan** of the App Store and Play Store habit corpora:
  - profile and "Me" tab wording: 42 reviews;
  - "all my habits / habit list / manage habits" wording: 686 reviews;
  - library, template and guided-habit wording: 122 reviews.
- **All read:** the first two sets were read in full. The library set was read in part: the negative mentions in full, the rest skimmed.
- **Also checked:** the current Apple and Google guidance.

---

## The answer

1. **Remove the bottom tab bar, and use no hamburger either.**
   - **The screen:** Today becomes the whole home screen.
   - **The bottom:** a native bottom toolbar for the day, reading "‹ Today · 14 left ›":
     - iOS: toolbar items with `.bottomBar` placement;
     - Android: a Material floating toolbar.
2. **The profile moves to an avatar in the top bar.** Both platforms put account access there: Apple's App Store and Music, Google's Gmail, Photos and Drive.
3. **Progress becomes a visible icon in the top bar,** not an item inside a menu.
4. **Add an "All habits" list,** reached from the title menu: "Today ⌄" → Today · Week · Month · **All habits**.
5. **The Library lives inside Add.** "+" → Suggestions and Library, then "Create your own". It is not a tab or a menu item.
6. **Guided habits put their habits on Today.** They are not a separate place to visit.

```
┌──────────────────────────────────────────────┐
│ (●) Today ⌄                     📊  ≡⚲  +     │  avatar · title menu · Progress · filter · add
│                                              │
│  [ one card per part of the day … ]          │
│                                              │
│        ‹    ◔ Today · 14 left    ›           │  native bottom toolbar
└──────────────────────────────────────────────┘
```

---

## Key findings

**1. No review dislikes a profile tab. But profile tasks are rare, and stats hidden there get missed.**
- None of the 42 profile mentions calls the tab unwanted.
- 24 (mean 2.21★) are about rare account jobs: logging in, sync, subscriptions, cancelling. For example, one reviewer couldn't find the profile icon to cancel `A24#24999`.
- Two found stats only by luck: "I only stumbled on the charts in the profile section by accident" `A86#765`.
- **So:** the profile doesn't need a permanent tab, because it is a place people rarely visit. But nothing people look at often (stats, habits) should hide inside it. This corrects the premise slightly: the profile isn't *disliked*, it's *rarely needed*.

**2. With Me gone, a tab bar no longer fits.**
- Material's navigation bar is for **3–5** destinations. Today and Progress are only two.
- Apple: "A tab bar and a toolbar should never appear in the same view". A toolbar holds actions for the current screen, which is exactly what ‹ Today › is.
- The 24 Sep study found that the most-praised habit apps (Loop, HabitKit) have no tab bar: one home screen with a few top-bar icons.
- The most common tab-bar failure is **tabs spent on things people don't use** (17 reviews).

**3. A hamburger is the wrong answer on both platforms.**
- **Evidence:**
  - the 24 Sep study found 87 drawer complaints against 9 praises;
  - drawers hide things (17), add a tap on every switch (13) and are hard to reach one-handed (8).
- **External:** NN/g found that hiding navigation behind a menu icon cut discoverability roughly in half.
- **Platforms:**
  - **iPhone:** there is no native hamburger; Apple's patterns are tab bars, toolbars, and sidebars on iPad.
  - **Android:** Material 3 Expressive has **deprecated the navigation drawer** in favour of the navigation rail, which is for tablets and foldables ([9to5Google](https://9to5google.com/2025/05/14/material-3-expressive-navigation/)).
- **So:** a hamburger would be non-native on both platforms and would hide Progress.

**4. People need a list of all their habits, but not on Today.**
- **30 reviews (mean 3.27★) want one place listing every habit,** including those not due today, to review, edit, delete or reorder:
  - "Once you set a routine there is no way to see a master list of all of your routines" `A4#15267` (1★);
  - "The list of habits is buried within settings and difficult to adjust" `A13#16207`;
  - "in profile I can see a list, but I can't do ANYTHING with it" `A4#2254`.
- **9 reviews want Today to show only what's due:**
  - "it should NOT show up on the list of habits every single day" `A36#412`;
  - one likes that "you can only see the routines you have set up for today on first opening" `P49#2115`.
- **Other groups in the 686-review set:**
  - the largest (about 107 by keyword) wants **combined stats for all habits**, which belongs in Progress;
  - about 120 want **a widget** listing all habits.
- **So:** All habits is its own view. It is reachable in one tap from the title menu, not from settings, and it's where you edit, reorder, archive and see habits that aren't due today.

**5. A Library is liked when you're adding a habit, and ignored as a destination.**
- The template and suggestion mentions are mostly positive (roughly 59 positive and 36 asking for more; keyword-sorted, not hand-coded).
- Failures come from making it a place of its own: "They spend way too much time on the Discover tab and other tabs that I have a hard time believing anyone is using" `A4#19548`.
- They also come from suggestions that can't be removed (`A1#51670`, `P12#57704`).
- **So:** put the Library inside the + flow, where the need arises.

**6. Decide now; moving navigation later costs the most.**
- 70 reviews (★2.30, 27 apps) punish redesigns that moved navigation.
- If guided programmes ever become a full product area of their own, bring back a tab bar **before launch**, not after.

---

## Options considered

| Option | Verdict |
|---|---|
| **A. No tab bar; avatar, Progress and title menu at the top; day toolbar at the bottom** | **Recommended.** Native on both platforms, one home screen, nothing hidden, no repeated "Today". |
| B. Keep the tab bar as Today · Habits · Progress, avatar at the top | Workable and native; meets Material's minimum of 3. But the bottom day bar then clashes: Apple says never use a tab bar and a toolbar together. The iOS 26 bottom accessory is the only exception, and "Today" appears twice. |
| C. Hamburger for Progress, All habits, Library and Settings | Rejected. It hides the two most-used secondary places. There is no native iOS hamburger, and Android's drawer is deprecated. |
| D. Tab bar and hamburger together | Rejected. Material advises against it, and it adds clutter. |

**Trade-off of A:** themes and icon packs, which is where the money is, sit one tap behind the avatar instead of on a visible tab. Surface them where people choose colours and icons, when creating or editing a habit, rather than relying on the profile.

---

**Limits.**
- **Language and wording:** only English was scanned, with keyword wording.
- **Library counts:** keyword-sorted, not hand-coded.
- **Reasoned, not reviewed:** how often people open Progress is inferred from the Home Screen report (stats are strongly wanted), not measured.

**Evidence:** [Navigation Evidence/Round 2](<Navigation Evidence/Round 2/>): `scan.py`, the read sets, and `nav2-classification.py` (0 unknown IDs, 0 duplicates).

---

## Addendum (26 Sep): All habits and Progress are one place

**The question.** Should the list of every habit live in Progress, and is "Progress" the right name?

**Finding.** People expect to reach every habit *from* the stats, and the stats *from* every habit. Examples:
- "Needs overall stats page… I want to see my stats for all tasks on a single page… Hunted around in the app" `A23#85`;
- "an overall progress page to check how am I doing in every Habit, instead of going through every single one" `P2#12756`;
- "being able to land on the 'All Habits' page which gives you a nice overview" `P24#14343`;
- "scroll or swipe through habits directly from the progress view (rather than returning to the habit list…)" `A52#20581`;
- "ability to open the habit from the progress tab" `A33#798`.

One user even found a missing habit "under the Statistics tab" `A1#54242`.

**Words people use** (habit-app reviews, keyword counts):
- **for the review place:**
  - "stats/statistics page, tab…": 76;
  - "progress tab, page, view…": 32;
  - "history": 21;
  - "overview": 21;
  - "report": 20;
  - "insights": 10;
  - "analytics": 10.
- **for the set of habits:**
  - "habit list / list of habits": 285;
  - "habit manager / manage habits": 77;
  - "all habits page, view…": 11.

No review is confused by the label "Progress". The complaints under it are about its content (bugs, missing graphs).

**Revised suggestion.**
1. **One screen, called Progress**, does both jobs:
   - at the top, the overall summary (this week, the month);
   - below it, **every habit**, including those not due today and quit habits. Each shows its schedule, streak and recent rate.
   - Tapping a habit opens it (history, then Edit). An **Edit** button reorders, archives and deletes.
2. **Two entry points, one screen:**
   - the chart icon in the top bar;
   - **All habits** in the bottom "Today ⌄" menu, which opens Progress scrolled to the list.
3. **Why "Progress" over "Stats":** it covers a list of habits as well as numbers. A list of habits under "Stats" reads oddly, and "Stats" can feel like a report card.
4. **Test it:** if people fail to find a habit that isn't due today, try the label **"Habits & progress"**.

Evidence: `Navigation Evidence/Round 2/naming_terms.py`.
