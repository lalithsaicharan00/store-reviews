# Implementation — Up Next

*Written by Claude (Claude Code), 27 October 2026, at the user's request: "create a document like implementation up next … It should be a main document in the root folder … this is like future, how we will be releasing things." The order below is Claude's recommendation, and the user asked for exactly that: "I'm giving you the liberty to fix it, whichever is the most thoughtful one." Change it here, with the date and the reason, whenever the user decides differently.*

**How to use this file:**
- One step at a time, top to bottom.
- Each step goes research → design → build → test → release, under the [Rulebook](RULEBOOK.md).
- The iPhone and Android ship each step together (D16), with Android designed first.
- When a step ships, mark it done with the date and move on.

---

## Now: the first release

**What ships:**
- The iPhone and Android phone apps, released together, with the features designed and built so far.
- No accounts and no server (D16).
- Backup to the person's own iCloud or Google Drive (D4).

**Plus at launch**, decided 27 Oct 2026 and recorded as Android A73:

| In Plus | Always free |
|---|---|
| Unlimited habits (free has 5) | The Week view, and each habit's Progress, Streaks, Milestones and Month |
| The Today list and This week widgets | History of every log, and Day details for any date |
| **The year at a glance:** the Habits page's Month and Year views, and Year in Pixels | Backup, Google Drive, export and restore |
| **Checklist habits** (making a new one; existing ones always work) | Dark mode |
| **If not done, remind me again** | Reminders, including several per habit |
| Supporting the developer | Tasks, the routine player and the timer |
| | Quit and cut-down habits |
| | Ticking from a widget |

**Still open before launch:**
- The price of Plus. It's $29.99 today; HabitNow is about $6 and Inner Grow about $10. See the [Plus report](<Research/Research Reports/Business Model and Monetization/What Goes in Plus — Our App Against HabitNow, and the iPhone Equivalent — 27 October 2026.md>) §1.5.
- ~~The Plus screen.~~ Done 27 Oct 2026: the six rows and an "Always free" section (Figma component set `1204:175`, Default and End of the list).
- The locked states the three new Plus features need.

**A rule for every step after this one:** nothing that is free at launch ever moves into Plus. Every app that did this paid for it with a rating drop that never fully recovered (Feature Ledger C001). New Plus features have to be new.

---

## Step 1 — Settle the launch

**What:** the first weeks after release go to what people actually hit: crashes, lost or wrong data, reminders that don't arrive, widgets that go stale, and words that confuse.

**Why first (reasoned):** losing data is the failure people forgive least, and Rulebook D still holds. A second feature built on top of an unsteady first one costs twice. This step is also when the downloads by country come in, and Step 3 needs them.

---

## Step 2 — Reports (Plus)

**What:** a weekly, monthly and yearly report of every habit, like Habit Tracker by Inner Grow's, built on the Habits page's Week, Month and Year views. It can be **saved or shared as an image or a file**: "exporting that", in the user's words.

**Why before languages:**
- **It's what people pay for (users show).** On the iPhone's biggest generic tracker, the report is the first reason buyers give for paying ("reports were the reason I paid", App Store report 1 §1.3). HabitNow's reviewers ask for overall statistics and say they'd buy Premium for them.
- **It strengthens Plus for everyone who already has the app,** in every language.
- **Words written before translation get translated once** (reasoned). Building Reports first means each later language translates the app with Reports in it, instead of every language being reopened when Reports arrives.
- **It buys time for real download data,** so the first language is chosen from evidence rather than a guess.

**Free or Plus:** Plus. It's new, so nothing free is taken away. The Week view stays free (A73).

---

## Step 3 — The first languages, one at a time

**What:** the whole app in one more language. That includes its store listings, screenshots, the website's privacy and support pages, notifications and widgets. Then the next language.

**Which first:** the countries our downloads actually come from after launch.
- If the data doesn't point anywhere clearly, start with **Spanish**, then **Portuguese (Brazil)**.
- They are the two most requested languages in Inner Grow's reviews (182 and 162 requests). Its reviewers say outright they'd buy if the app were in their language: "If it were in Spanish I would buy it".
- When Inner Grow added Japanese in 2026, the reviews that followed were glowing (report 1 §6.2).
- After those two: French (48), Russian (44), Turkish (43) and Japanese (22), reordered by our own data.
- Leave **Arabic** until the layout has been checked right to left.

**Before the first language** (reasoned): move every word in the app into the platforms' string files, and check every screen at the longer text a translation brings. German and Portuguese often run 30% longer than English. That makes each later language a translation job, not a rebuild.

---

## Step 4 — Lock with your phone (App Lock)

**What:** an optional lock that opens with the phone's own Face ID, fingerprint or passcode. It is free and off by default.

**Why here:**
- **It's asked for (users show):** 903 reviews want a lock ([App Lock report](<Research/Research Reports/Settings and Help/App Lock and Widget Privacy — What People Expect.md>)).
- **Done badly, it does real harm:** locked-out people rate 2.03★. So it gets its own step, after the app is steady.
- **The report's expectations hold:**
  - automatic unlock with the phone's own biometrics;
  - the phone's passcode as the way back in that can't be lost;
  - every way into the app goes through the lock;
  - widgets that are discreet, not blank.

**Free.** People's privacy isn't a Plus feature.

---

## Step 5 — Languages carry on, alongside everything else

From here on, a language is added between each of the steps below, one at a time, in the order the data shows. A language never waits for a big feature to finish.

**Smaller features that are already decided,** to be fitted in between steps when there's a gap:

- **How was today** — the built-in mood habit and its widget, designed and held for later (A18, A20, A22).
- **Moving between iPhone and Android with a code** — removed for launch (D15). Bring it back only if people ask for it.

---

## Later — once people are clearly using the app

**When to start:** the steps below begin only when it's clear people are downloading and keeping the app. That means steady downloads, people still using it weeks later, and Plus being bought. The user makes this call. Until then, everything above keeps going.

The order runs from cheapest and most wanted to largest:

| # | What | Why in this place |
|---|---|---|
| L1 | **Apple Watch** | It works through the iPhone, so it doesn't wait for anything else. It was built once and retired for launch (U30–U34; the code is in git history), so it's the cheapest to bring back. Watch buyers have very high intent (Inner Grow: 2.1% of buyers, 4.2 times the rate in all its reviews). |
| L2 | **Sync between devices, made better** | Every platform after this one needs it: a tablet or a computer is only useful with the phone's habits on it. The iPhone already syncs through iCloud. Android's sync through Google Drive was designed and tested (D16, [prototype results](<Android/Docs/Research/Google Drive Sync — Prototype Results.md>)) and waits for a second device to sync with. Sync was the strongest true reason to pay in Inner Grow's reviews (9.0% of buyers, 9.8 times the rate in all its reviews). |
| L3 | **Tablets: iPad and Android tablets** | Phone screens mostly carry over to a larger layout. Buyers expect Plus to include them: 58 reviews say "paid but not on my iPad" ([Plus Scope report](<Research/Research Reports/Business Model and Monetization/Plus Scope and Account at Purchase.md>)). The iPad app was built once too (U35, git history). |
| L4 | **Wear OS** | A smaller audience than the Apple Watch. It comes after Android sync, so the watch has the phone's habits. |
| L5 | **Desktop: the Mac, then Windows** | The Mac is designed from the iPad, using only the Mac's own parts: menu-bar item, shortcuts, menus, windows (A1). Windows follows the same way from the Android tablet. |
| L6 | **The web** | Last, because it's the hardest to do without a server of ours (D16: we run none). It would read and write the person's own Google Drive or iCloud data in the browser. Decide whether that's possible, or whether a server is worth its cost, before designing anything. |

---

## Done

*(Steps move here with the date they shipped.)*
