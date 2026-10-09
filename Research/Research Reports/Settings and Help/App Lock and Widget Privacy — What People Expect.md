# App Lock and Widget Privacy — What People Expect

Written by Claude (Claude Code), 8 October 2026, for Current Work item 58 ("App Lock and widget privacy: decide how
they should work, then build"). The user asked what people expect from an app lock and from widget privacy on the
iPhone, from reviews and from the web, before anything is built. This report answers that. It builds on
[App Lock — Private Without Lock-outs](<App Lock — Private Without Lock-outs.md>) (30 Sep, a 229-review keyword
sample), which it replaces as the evidence base: this time every candidate review was read.

Evidence labels: **users show** (reviews), **iPhone does** (Apple's documentation and behaviour), **reasoned**
(first principles, no direct review evidence). Competitors are quoted only through their own users' reviews.

## The answer: how people expect it to work

1. **It's for a minority, and they care a lot.** People lock habit apps because of who else touches the phone
   (family, partners, kids, friends, thieves) and because some habits are private (sobriety, self-harm, mental
   health, diaries). Off by default, free, and easy to find.
2. **The iPhone's own Face ID or Touch ID, asked for automatically** the moment the app opens. Typing an app code
   every time is the friction people complain about.
3. **A way back in that can't be lost.** The iPhone passcode as the fallback. A separate code that can be
   forgotten is the single biggest source of anger in this whole study (406 lock-out reviews, 2.03★).
4. **It locks every time you leave**, and opening it any other way (a notification, a widget, a link, a pop-up, a
   restart) still asks. Coming back puts you exactly where you were, with anything you were typing still there.
5. **Nothing shows before or around the lock.** No flash of the list before Face ID, a cover in the app switcher,
   and nothing private in notifications, Siri, Spotlight or widgets while the lock is on.
6. **Widgets keep working, discreetly.** People who lock the app still want the widget (often a counter on the
   Lock Screen), just without the words that give them away. A widget that shows the names makes the lock pointless.
   A widget that shows nothing loses the reason they added it.
7. **It never breaks, loops or locks you out.** A lock that freezes the app on the Face ID screen, crashes at
   launch, or asks again and again is worse than no lock.
8. **Never charged for, never taken away**, and explained in plain words: your iPhone checks your face; the app
   never sees it.

The sections below give the evidence for each point. The open decisions for the user are at the end.

## 1. How the evidence was gathered

- **Corpus:** every review in the three local corpora, **1,487,223 reviews** (App Store habit and routine apps
  337,331; Play Store habit apps 901,453; Apple and Google built-in apps 248,439: Notes, Reminders, Calendar, Health,
  Fitness, Google Keep, Tasks, Calendar, Sheets, Microsoft To Do, Samsung Health). Dates **Nov 2010 – Sep 2026**.
  The built-in apps matter here: Apple Notes' locked notes and Google's app passcodes are what iPhone owners
  already know about locks.
- **Scan:** patterns for locks (Face ID, Touch ID, passcode, PIN, fingerprint, biometric, app lock, in 20+
  languages), widget privacy, other people seeing the phone, notification privacy and disguising the app
  ([`scan.py`](<App Lock and Widget Privacy Evidence/scan.py>)): **5,171 candidates**. A second pass dropped widget
  hits with no privacy angle and English "password" hits about account log-ins
  ([`refine.py`](<App Lock and Widget Privacy Evidence/refine.py>), [`refine2.py`](<App Lock and Widget Privacy Evidence/refine2.py>)),
  leaving **3,861**. A 60-review sample of the 1,310 dropped found 1 relevant review, so roughly 20 relevant
  reviews may be missing.
- **Reading:** all 3,861 read one by one, in their own language, and coded by hand into 32 themes
  ([codebook](<App Lock and Widget Privacy Evidence/CODEBOOK.md>), map in [`cls/`](<App Lock and Widget Privacy Evidence/cls>)).
  [`check_cls.py`](<App Lock and Widget Privacy Evidence/check_cls.py>) confirms each was coded exactly once and every
  quoted fragment appears in its review. **2,205 are on topic**: 753 from 56 habit apps, 630 Apple Notes, 601 Google
  Keep, 122 Google Sheets, 99 other built-in apps. Every review ID per theme is in the
  [Review Index](<App Lock and Widget Privacy Evidence/App Lock and Widget Privacy — Review Index.md>).
- **Web:** Apple's documentation and support pages, Apple developer forums, and press coverage of iOS 18's app
  lock (sources in §4).

## 2. What the reviews say

Counts are reviews; ★ is their average rating. "Habit apps" are the App Store and Play Store habit and routine apps.

| Theme | All | Habit apps | Built-in apps | Mean ★ |
|---|---|---|---|---|
| Asking for a lock | 903 (57 apps) | 205 (48 apps) | 698 (592 Google Keep) | 3.72 |
| Locked out (forgot a separate code, or Face ID stopped working) | 406 | 16 (6 apps) | 390 (Apple Notes) | 2.03 |
| Want to lock only some things (one note, list, diary) | 315 | 24 | 291 | 3.73 |
| Distrust: "why does an app want my fingerprint?" | 254 | 254 (3 apps' onboarding) | 0 | 1.22 |
| Praising the lock | 187 | 131 (63 one app, Days Since) | 56 | 4.87 |
| Reason given: other people and the phone | 107 | 43 | 64 | 3.74 |
| The lock is broken (freezes, crashes, loops) | 98 | 42 (10 apps) | 56 | 2.26 |
| Want Face ID / Touch ID instead of typing a code | 63 | 44 (11 apps) | 19 | 3.86 |
| A lock that was removed | 36 | 0 | 36 (Google Sheets, 1 To Do) | 2.17 |
| Lock to stop accidental edits | 34 | 5 | 29 | 3.82 |
| Reason given: sensitive habits | 33 | 23 | 10 | 4.30 |
| Want a code separate from the phone's | 29 | 14 (6 apps) | 15 | 3.76 |
| Lock is friction / asks too often | 24 | 15 | 9 | 3.21 |
| Value a discreet name or icon | 22 | 20 | 2 | 4.91 |
| Lock can be got round | 19 | 10 | 9 | 3.68 |
| Want content visible on the Lock Screen | 19 | 0 | 19 | 3.47 |
| Content shown before the lock / in the app switcher | 12 | 8 | 4 | 3.17 |
| Leak through Siri, search, titles or photos | 12 | 1 | 11 | 2.33 |
| Lock charged for or moved to paid | 11 | 11 (6 apps) | 0 | 3.00 |
| Want the phone's passcode as the way back in | 13 | 5 | 8 | 3.46 |
| Fallback when Face ID can't be used | 11 | 8 | 3 | 3.82 |
| iOS's own app lock mentioned | 10 | 3 | 7 | 2.20 |
| When it locks again (timing) | 9 | 3 | 6 | 3.56 |
| A widget that shows the numbers, not the names | 8 | 5 | 3 | 4.50 |
| Notifications reveal habits | 7 | 6 | 1 | 3.57 |
| Lock being free is praised | 7 | 7 | 0 | 5.00 |
| The widget leaks what the lock hides | 5 | 3 | 2 | 4.00 |
| The prompt should appear by itself | 4 | 3 | 1 | 3.25 |

**Scale, honestly:** in the habit apps this is a minority topic (753 on-topic reviews in a 1.24-million-review
habit corpus). It concentrates in quit and sobriety counters, journals and diaries. That supports "off by default,
free, easy to find", not a feature for everyone.

### Why people want it: other people, and private habits

Users show that the lock is about the people around the phone, more than about strangers:

- "i especially like the passcode feature so nobody can snoop into my habits" (Days Since, 5★, `7403257714`; tracks self-harm).
- "it means a lot to me to be able to allow people to do things on my phone" (Days Since, 5★, `8301210464`).
- "I also like how i have face ID on so when my mom would go through my phone she wouldn't know if i relapsed or not before i was ready to tell her" (Days Since, 5★, `14215526815`).
- "it's my sisters phone and since there's a diary" (Roubit, Play Store, 4★, `635f087a-3388-4b7d-90eb-2059d0848db5`).
- "супруга часто лазает в телефоне" [my wife often goes through my phone] (Tappsk, 5★, `5899028593`).
- "caso o celular seja roubado os bandidos não terão acesso às notas" [if the phone is stolen, thieves won't get the notes] (Google Keep, 1★, `7520970363`).

A lack of a lock stops people using private features: "비밀번호 설정 기능이 없어서 기록이나 회고 기능은 대부분 이용하지 않고 있어요" [without a password setting I mostly don't use the journal and reflection features] (MyRoutine, Play Store, 5★, `e3a7343a-fda9-4bb1-ab8f-b9410b856d40`).

The web agrees on the "people around you" part: in a 2019 Pew survey of US partnered adults, **52%** of those aged
18–29 said they had looked through their partner's phone without their knowledge (13% of those 65 and older)
([Statista summary of Pew](https://statista.com/statistics/1124855/adults-united-states-partner-cellphone-looked-through)).

### Face ID, asked for automatically

Users show they want biometrics, not a typed app code, and the prompt without an extra tap:

- "Now I need to type the password every time" (Productive, 5★, `1334674920`); "Reconhecer a digital ao invés de toda vez digitar o pin" [use the fingerprint instead of typing the PIN every time] (HabitNow, 2★, `4627e191-00c3-415a-bdc4-9a11ce7f677e`); "It takes too long to open if you have a lock on" (Habit Tracker, Play Store, 5★, `06c0deb0-8eec-4c46-84f7-91935dbd3b6c`).
- "just have the app go automatically into Face ID or Touch ID" (HabitMinder, 2★, `3236220997`); "currently you need to tap the icon “unlock” to enable Touch ID" (HabitMinder, 4★, `3399514212`).
- The friction is real: "잠금 해제가 좀 번거로워서 알림만 확인하고 체크를 깜빡 잊는" [unlocking is a bit of a hassle, so I just read the reminder and forget to tick] (HabitMinder, 3★, `4919677921`).
- Praised when it works: "it assures me every time i log on that my not so secrets are safe, by asking for a face ID to unlock the app upon launch" (Days Since, 5★, `11651021316`).

### The way back in must never be lost

This is the strongest signal in the study. Apple Notes lets people lock notes with a separate notes password and
Face ID. When Face ID stops being offered (after an update, a new phone, a broken sensor) people find they never
knew or have forgotten that password, and resetting it only applies to new notes. **390 Notes reviews** describe
being locked out of their own notes, average **2.03★** across all 406 lock-out reviews:

- "if you forget a password that you created years ago and weren't asked for since then, those notes are gone" (Notes, 1★, `8627894676`).
- "we lock notes to protect them but not to lose access to them forever" (Notes, 1★, `9474706355`).
- "At some point IOS will stop accepting face id only and you will need to confirm the password" (Notes, 1★, `14072583776`).
- What they ask for is the phone's own code: "durch eingeben des iPhone Codes oder Face- bzw. Touch ID" [by entering the iPhone code or Face/Touch ID] (Notes, 2★, `9664987785`).

Habit apps with their own codes show the same thing at smaller scale: "I am locked out of my app" (Way of Life, 1★,
`11882060257`); "clear app data to reset pin but it also resets our in app data" (HabitNow, Play Store, 5★,
`b9b6df7c-6a92-417e-91d2-92a25ae85b28`); "就再也进不去了……也没办法重置密码" [I can never get in again, and there's no way to reset the password] (ShineDay, 5★, `12272844150`).
Biometrics alone aren't enough either: "现在手机面容id功能损坏，因此无法解锁app" [my phone's Face ID is broken, so I can't unlock the app] (ShineDay, 1★, `6676646717`), and masks: "unlocking phone with face id is not possible while inside the stores where mask is mandatory" (Microsoft To Do, 3★, `6649710027`).

### The tension: a code separate from the phone's

A real minority (29 reviews) want the opposite, because the people they're hiding from know the phone's passcode:

- "anyone who knows the password on the phone can easily get into it without Face ID" (Days Since, 5★, `11745622072`).
- "some teen's families know their passcode" (Finch, 5★, `9016127564`).
- "This is to prevent people who know my phone code from snooping" (Notes, 5★, `14306518730`).
- "being a kid with strict parents … they just entered the password and read the whole thing" (Notes, 4★, `13224475328`).
- "more personal apps should have a second passcode beyond the phone's lock screen" (Google Sheets, 2★, `1962105438`).

Weighed against each other: 29 ask for a separate code; 406 were locked out by separate codes (and every one of
the habit-app lock-outs came from an app-specific code). §6 sets out the options.

### It locks every time, from every door, and keeps your place

Users show they expect it to ask every time they come back, however they come back:

- Praised: "I love how the app locks when you leave it open for privacy" (Days Since, 5★, `7830092557`).
- Complained about when it doesn't: "If the app keep opening on the background, no password is required" (Today, 3★, `2004605175`); "I would expect every time I open the app, it requires passcode" (Today, 4★, `3674778427`).
- Side doors: "click a reminder notification from the app, you'll be taken right in without being prompted" (Habit Tracker, Play Store, 3★, `61968b96-237c-47c1-93c7-d2b08a05fd29`); "一关闭广告发现可以不用输入密码直接进入APP" [after closing an ad, I could get in without the password] (ShineDay, 5★, `13404013818`); "if I turn off my phone and i have the lock on it still lets me in" (Finch, 4★, `8841869821`).
- Companion apps that skip the lock: "google sheets is a backdoor to all your sheets “protected” by the drive passcode" (Google Sheets, 2★, `988132343`).
- Keep the place and the draft: "the app locks which is fine, but what I have written before I leave the app is not saved" (Habit Tracker, Play Store, 3★, `94f4dc6f-954c-4747-8027-f6a89dd81534`); "The locked notes staying unlocked or at least staying where you were at when switching apps" (Notes, 4★, `10613163108`).
- One person wants a short grace period: "I often switch between apps and I have to constantly put in the passcode every single time I go back to the app. So maybe like, if you're gone for 5 minutes then you'll have to put the code in again. But not every time please!" (Google Sheets, 2★, `989435187`); others want the opposite: "I want the option to request for password when I have been idle and/or closed the application" (Google Sheets, 5★, `1012921241`); "Password or touch id every time i leave the app" (Google Sheets, 3★, `3401141982`).

### Nothing shows before or around it

- A flash of the list before the prompt: "when you open it next time it will momentarily peek inside" (Daily Habits, 2★, `3342902073`); "reopening the app briefly shows your goal screen" (Way of Life, 5★, `1001534631`); "会先显示我的习惯界面，再弹出指纹解锁" [it shows my habits first, then asks for the fingerprint] (ShineDay, 5★, `3645418981`).
- The app switcher: "in recent apps, i can clearly see the last viewed chart" (Habit Tracker, Play Store, 5★, `5557b8ff-6a24-48bb-8a28-45c7e0c8bfd5`); "whenever I preview my apps from home screen slider, I can vividly see and read my notes" (Google Keep, 3★, `10105325069`).
- Notifications: "I don't someone see my private habits on my lock screen" (Daily Habits, 5★, `1483822944`); "they might not want a notification popping up on their screen for people to potentially see" (Onrise, 4★, `8656067520`).
- Siri and search: "the app pushes hints to Siri" while it is locked with a passcode (Do Habits, 1★, `8662056943`); "werden alle Infos /Inhalte bei der Such- Funktion, sichtbar" [everything is visible through search] even for locked notes (Notes, 1★, `9972039641`); "没有输入密码却还可以看到笔记开头的19个字" [without the password you can still see the first 19 characters] (Notes, 1★, `9885397065`).

### Widgets: hide the words, keep the widget

Users show both sides, and they meet in the middle:

- **A widget that shows what the lock hides makes the lock pointless:** "My only concern is if you lock the app The data is still available through the widget" (Days Since, 5★, `8485606244`); "What is the point of protecting your goals with password / touchid / faceid if 3D Touch widget reveals all my habits" (Today, 4★, `5116388115`); "Si se agrega el pin, se pueden ver y editar las cosas a través del widget" [with the PIN on, you can still see and edit things through the widget] (HabitNow, 5★, `c0833267-88f0-416f-a70d-c333c256ac0d`); "ウィジェットでは丸見えになってしまう" [a locked note is in full view on the widget] (Notes, 4★, `10727489149`).
- **But they still want the widget, discreetly:** "a cool feature that lets u lock the app and/or create a widget of the time with out putting what the days are (like a caption of what u are counting)" (Days Since, 4★, `10027664593`); a self-harm tracker's Lock Screen widget that lost its number is "much less likely to be noticed and commented on" (Days Since, 5★, `11763045339`); another person tracking self-harm recovery calls "having the widget on my lock screen and watching the days increase" "a huge source of motivation" (Days Since, 2★, `13876121897`, found in the dropped set); "allow the user to select what they want viewable through the widget" (Google Calendar, 4★, `1592804176`); "limiting the type of info available to non-sensitive stats would be enough" (Apple Health, 4★, `9071785131`).
- **The Lock Screen is the most exposed place:** "other people could see your list when they open your phone" (To Do List, Play Store, 4★, `24099e47-cab9-4b52-9287-7640ab835df8`); "if you swipe left my notes are viewable to anybody" (Google Keep, 2★, `4061108899`).
- **And people want the Lock Screen to be useful** (19 built-in app reviews, plus the 695-review widget evidence in [Widgets — Tick Without Opening the App](<../Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets/Historical Research/Widgets — Tick Without Opening the App.md>)), sometimes asking for exactly what iOS can do: "at least the task list shown only when the lock screen is unlocked" (Google Tasks, 2★, `11190271668`).

### Breaking, looping, freezing

42 habit-app reviews (10 apps, 2.79★) describe a lock that stops the app working, and some lost data reinstalling
to escape it: "it shows face id symbol but doesn't actually do anything" (Habit Tracker, 2★, `8061806801`); "DO NOT TURN ON PASSCODE LOCK, it causes the app to crash at startup" (Productive, 1★, `5296739284`); "приложение при входе вылетает" [the app crashes when you open it], reinstalled, everything was reset (Daily Habits, 4★, `5747344195`); "continuously scanning tha face again and again" (Way of Life, 3★, `9616858460`).

### Free, kept, and explained

- Paid locks: "The latest update changes the option for TouchID in a paid feature … I really feel scammed now" (Do Habits, 1★, `3873301504`); "I'm not paying $5 a month just to use the passcode lock" (Strides, 1★, `1365915398`). Free is praised: "Something which is also paid in other apps" (Days Since, 5★, `8699794922`).
- Removed locks: when Google removed the passcode from Sheets and Drive and pointed people to the phone's lock, 35 reviews averaged 2.17★: "I don't want to be told to secure my device with Touch ID or a passcode, I want to secure the app" (Google Sheets, 1★, `2022574697`); "I have things in there I don't want my daughter to see" (Google Sheets, 4★, `1958348161`); one thought the "iOS security replaces passcode lock" message was phishing (Google Sheets, 1★, `2390701460`). A habit app did the same in 2025: "they removed the ability to have a passcode lock for the app. Developer claims they removed it as it's built into iOS now" (Habitify, 1★, `12506599929`).
- Distrust of biometrics: 254 reviews (1.22★) from three apps whose onboarding asks people to hold a finger on the screen to commit to a contract with themselves believe the app captures their fingerprint: "Why are my biometrics needed to help me organize my time?" (Me+, 1★, `9918861967`); "It's absolutely NOT clear it's for authentication purposes" (Fabulous, Play Store, 1★, `cea60372-4986-42c4-bd17-3dd31554958b`). Not about locks, but it shows people need to be told plainly that the phone checks the face and the app never sees it.

## 3. A discreet app helps too

Days Since is praised 17 times for a name and icon that don't give it away: "The name is very carefully chosen to
keep nosy people not getting the hint" (Days Since, 5★, `8670863468`); "more discreet than other apps with a similar
premise … so that I could download it without being questioned by my family" (Days Since, 5★, `14479485824`).
One person gets by without a lock by naming habits in code (Streaks, 4★, `1981404781`). This supports the
discreet app icon already parked under C096; it's a separate piece of work.

## 4. What the iPhone already does

**iPhone does: its own app lock (iOS 18 and later).** Anyone can touch and hold an app, choose Require Face ID, and
the app then needs Face ID, Touch ID or the passcode to open. Apple: "Information inside a locked app won't appear in
some locations on your iPhone—for example, in notification previews, search, Siri suggestions, or your call history",
and the lock "doesn't sync with iCloud" ([Apple Support](https://support.apple.com/guide/personal-safety/ipsd0be4c185/web)).
Siri can't be used with a locked app ([MacRumors](https://www.macrumors.com/how-to/ios-18-how-to-lock-and-hide-iphone-apps/)).
**A locked app's widgets are removed** from the Home Screen and must be re-added after unlocking (MacRumors; an
Apple Community user: "The issue is the « Require Face Id » function, to open the app. If that is turned on, the
widget goes away", [thread](https://discussions.apple.com/thread/255787795)). With Stolen Device Protection on and the
phone away from familiar places, locked apps need Face ID or Touch ID "with no option to use your passcode"
([Apple Support 125690](https://support.apple.com/en-us/125690)).

Users show this isn't well known or well liked: "I accidentally turned on Face ID to open Reminders app and there is no setting to undo this" (Reminders, 1★, `13062908865`); "若使用Face ID時！原本桌面上的小工具會消失" [if you use Face ID, the widget on the Home Screen disappears] (Reminders, 3★, `12414250217`); "并不是每次都打开需要面容😓有时候直接打开了" [it doesn't need Face ID every time; sometimes it just opens] (Notes, 3★, `12813881333`).

So the iPhone's lock is a real alternative, but it costs the widget entirely and its timing feels inconsistent.
That is a reason for the app to keep its own lock, not to drop it: the people who removed theirs were punished for it.

**iPhone does: Face ID with the passcode fallback.** The `deviceOwnerAuthentication` policy tries biometrics first;
"When these options aren't available, the system prompts the user for the device passcode", and it fails if no
device passcode is set ([LAPolicy](https://developer.apple.com/documentation/localauthentication/lapolicy/deviceownerauthentication)).
Whether Stolen Device Protection also removes the passcode fallback for third-party apps is **not documented**; a
developer asked and got no answer ([forum](https://developer.apple.com/forums/thread/745093)). To check on the iPhone.

**iPhone does: widget privacy, partly.** Views marked `privacySensitive` are redacted on the Lock Screen, in StandBy
and on the Always-On display only when the person has turned off **Settings → Face ID & Passcode → Allow Access When
Locked → Lock Screen Widgets** (on by default) ([Apple security guide](https://support.apple.com/guide/security/widgetkit-security-secbb0a1f9b4/web),
[Alexander Weiss](https://alexanderweiss.dev/blog/2022-11-19-redact-your-lockscreen-widgets-when-the-device-is-locked),
[forum](https://developer.apple.com/forums/thread/741465)). Home Screen widgets are never redacted (the phone is
unlocked). A widget extension with complete data protection shows placeholders until the phone is unlocked
([Apple security guide](https://support.apple.com/guide/security/widgetkit-security-secbb0a1f9b4/web)), which
would blank every Lock Screen widget for everyone. Live Activities have their own switch in the same list.

**iPhone does: Siri runs App Intents on a locked phone by default.** Apple: the default authentication policy
"allows the intent to run without authentication, including when the device is locked"
([authenticationPolicy](https://developer.apple.com/documentation/appintents/appintent/authenticationpolicy)).

**A convention people know:** WhatsApp's Screen Lock offers Immediately, After 1 minute, After 15 minutes or After
1 hour, and still shows notifications ([OSXDaily](https://osxdaily.com/2021/01/28/lock-whatsapp-iphone/)).

## 5. Where Often Enough is today

Audited from `AppLock.swift`, `PrivacyView.swift`, `HabitsApp.swift`, `WidgetsView.swift`, `HabitStore+Widgets.swift`,
`PhoneWidgets.swift`, `HabitIntents.swift`, `ReminderScheduler.swift`, 8 Oct 2026.

| Expectation | Today | Gap |
|---|---|---|
| Free, off by default, Face ID with iPhone passcode fallback | Yes (≡ → Privacy) | — |
| Can't be turned on in a state that locks you out | Yes: needs a device passcode and a successful Face ID | — |
| Asks by itself on return, once; a button after a cancel | Yes | — |
| Nothing shows before the lock; cover in the app switcher | Yes: setting read before the first frame; cover whenever not active | Check on the iPhone |
| Every door goes through the lock (notification, widget, link) | The cover sits over everything, so content stays hidden | Check each door on the iPhone |
| Keeps your place and drafts | The cover overlays the screen without resetting it | Check typed drafts survive |
| Notifications don't name private habits | Reminders name the habit | **Gap** |
| Siri, Spotlight and Shortcuts don't reveal habits | "What's left" reads names, also on a locked phone; per-habit phrases in Spotlight | **Gap** |
| Live Activity doesn't name the habit while locked | Names it | **Gap (reasoned)** |
| Widgets hide the words but keep working | Show "Content hidden", no logging, while the lock is on | **Too much: the widget stops working** |
| Lock Screen widgets respect the iPhone's privacy switch | `privacySensitive()` on all widget content | — |
| Explains Face ID plainly | "Lock with Face ID" and a footer | Add "your iPhone checks your face; Often Enough never sees it" |
| Never breaks | No UI test covers the lock (test launches turn it off) | **Needs a test path** |
| Stolen Device Protection | Unknown | Check on the iPhone |

## 6. Decisions for the user

**1. Widgets while App Lock is on.** Options:
- **A. Hide everything** (today): safest; the widget becomes a lock icon and stops logging.
- **B. Discreet (recommended):** no habit names, notes or task titles; icons, colours, progress fills, counts and
  the ✓ / + buttons stay. This is what the 30 Sep report recommended and what users ask for ("a widget of the time
  without the caption"). A list's rows are told apart by icon and position.
- **C. Let the person choose** in Privacy: "Widgets while locked: Discreet / Hidden", default Discreet.
Logging from a discreet widget lets someone holding the phone tick a habit; it's undoable and far less harmful than
reading it (reasoned), and one reviewer did object to editing through a widget (`c0833267-88f0-416f-a70d-c333c256ac0d`).
Any of these applies to Home Screen, Lock Screen and StandBy alike, and only while App Lock (or Hide widget content)
is on. Widgets can't know whether the app was unlocked, so "unlock the app to reveal" isn't possible (iPhone does).

**2. Separate code or the iPhone's own.** Options:
- **A. The iPhone's Face ID and passcode only (recommended, today).** No one is ever locked out; matches iOS's own app
  lock; weak against people who know your passcode.
- **B. Add an optional "Face ID only" mode** for people whose family knows the passcode. Needs a way back when Face
  ID fails (mask, broken sensor, new phone) that a snooper with the passcode can't use. None found that doesn't risk
  the Notes-style lock-outs (406 reviews). Park until a safe recovery is designed.

**3. When it locks.** Recommended: every time the app goes to the background (today), never for the iPhone's own
interruptions (Face ID sheet, Control Center, notifications pulled down, share sheets). Optional: a choice of
Immediately / After 1 minute / After 15 minutes, as people know from WhatsApp (only 1 review asks for it).

**4. Notifications, Siri and Live Activities while the lock is on.** Recommended, following what iOS does for its
own locked apps: reminders say "A reminder from Often Enough" without the habit name (Done and +1 still work);
Siri answers without names and per-habit Siri and Spotlight phrases are withdrawn; the Live Activity shows the icon
and clock without the name. Each could be a setting if the user prefers names.

**5. Lock some habits only.** Strong in notes apps (315 reviews want single notes locked), weak in habit apps
(24, mostly diary sections). Not recommended now; revisit if diaries or the Daily Reflection (item 12) arrive.

## 6a. Decision 1 in depth: widgets while App Lock is on (added 9 Oct 2026)

> **Decided by the user, 9 Oct 2026: Discreet.** While App Lock is on, widgets hide every word the person wrote and keep icons, fills, counts and working buttons, as defined in the table below. No "Hide everything" option for now. **And (9 Oct): the existing ≡ → Widgets switch "Hide widget content" becomes "Hide names on widgets"** with the same discreet look, for people who want private widgets without locking the app. Turning on App Lock turns it on and keeps it on (shown on and greyed, "On while App Lock is on"). Every widget kind follows it: Small, Today lists, This week, Tasks and the three Lock Screen widgets.

The user asked what a discreet widget is, what people expect, and which option users' own words point to. A second,
widget-only scan paired a widget or Lock Screen word with a privacy word within 140 characters
([`scan_widget.py`](<App Lock and Widget Privacy Evidence/scan_widget.py>)): 966 reviews, 917 not read before. The
first 200 were read in full; the other 717 were narrowed with stricter privacy words
([`strict_w.py`](<App Lock and Widget Privacy Evidence/strict_w.py>), which kept every relevant review of the first
200) and the 142 kept were read. Codes and review IDs: [`widget_pass2_codes.json`](<App Lock and Widget Privacy Evidence/widget_pass2_codes.json>).
Together with §2, users show four things, and none of them asks for a blank widget:

| What users show | Reviews | Examples |
|---|---|---|
| **The words are the problem:** a widget that shows habit names, notes or a list to whoever holds or glances at the phone | 8 | §2's five; "it displays the name of the habit, not something I might want anyone peeping by to see" (HabitKit, 4★, `12192022296`); "iPhone有桌面小组件后会曝露3条日常" [the Home Screen widget exposes three of my habits] (ShineDay, 5★, `6749919770`); a Lock Screen list "other people could see" (`24099e47-cab9-4b52-9287-7640ab835df8`) |
| **The numbers are the point**, even for the most private habits | 9 | "Seeing that widget counting up the days gives me power" (Days Since, 5★, `13586082674`); "I love seeing the tracker on my Lock Screen" (Days Since, 5★, `12083646427`); a self-harm tracker: "the widget has been soooo helpful on my homescreen" (Days Since, 5★, `11046052840`); "I personally just made it a widget so that I can check on how long I've been clean whenever I glance at it" (Days Since, 5★, `7820513357`); and `13876121897`, `14221259732`, `13668732705` |
| **So: the numbers without the words** | 6 | "a widget of the time with out putting what the days are (like a caption of what u are counting)" (Days Since, 4★, `10027664593`); "I want to be able to check what day of my cycle i am on at a glance without displaying all the personal information" (Apple Health, 3★, `10247684235`); "the checkbox widget appear without a name" (Loop, 4★, `ae0516c4-7df4-4564-ba29-f8cc89bd5724`); "hide app name from widget header" (To Do List, 5★, `fe889ac7-0013-4acd-bfde-8e31356fac74`); `11763045339`, `9071785131` |
| **Choosing what a widget shows** (some lists or habits stay off it) | 7 | "a choice for what list is shown on the widget to hide more personal/frivolous items" (To Do List, 5★, `b825fad9-d658-4d67-8a7c-4bb690fe9520`); "hiding the ones that I don't need to see so that they won't show on my Lock Screen or in widgets" (Streaks, 4★, `11818664634`); `8ee28621-fceb-4656-b059-5d4ae94e23ac`, `9f0008a3-238b-4291-9538-fa61e7556b14`, `13384692547`, `1592804176` |

Against that: one review objects to editing through the widget while the app is locked
(`c0833267-88f0-416f-a70d-c333c256ac0d`), one asks for a password on the widget itself, and **nobody asks for a
widget that shows nothing**. The nearest thing to a blank widget, iOS 18 removing a locked app's widgets, drew
confusion (§4). Accidental taps on widget rows are a separate, real complaint (`11189518410`, `10404306156`,
`12815659732`), already handled by Often Enough's locked rule that only the round button takes a touch (U28).

**So the users' answer is the discreet widget:** keep everything you read at a glance and the buttons, remove every
word the person wrote. Defined for each widget (reasoned from the evidence above; icons are the one judgement call):

| Widget | Shown while App Lock is on | Hidden |
|---|---|---|
| Small (one habit) | The habit's icon and colour, the fill, the count ("6/8", "45 days"), the ✓ / + / ▶ button | The habit's name |
| Today list (Medium, Large) | Each row's icon, fill, count and button; the header's "3 of 7 done"; paging | Habit names; a section's own name (shown as "Today") |
| This week (Medium) | Icon, the seven day squares, the count | The name |
| Tasks (Medium, Large) | "4 tasks left" and a way into the app | Task titles (a task without its title means nothing) |
| Lock Screen circle / rectangle / inline | Icon, ring, count; "3 of 7 done" | Names |
| Every widget | VoiceOver reads "Habit, 6 of 8" | Names in VoiceOver labels too |

Taps keep working: ✓ and + log as usual (the widget's whole point, 695 reviews in the widget study; the worst case,
someone ticking a habit, is undoable). Anything that opens the app (a timer, steps, a number to type) meets the lock
first. Icons stay because without names they're the only way to tell rows apart; the Privacy screen should say
"Names are hidden. Icons and progress stay, so pick a neutral icon for anything private." The 7 "let me choose what
shows" reviews point to a later per-habit "keep off widgets" switch; it isn't needed for the lock itself.

## 6b. For whoever builds this: what may change and what must not (the user, 9 Oct 2026)

**Any agent working on App Lock and widget privacy may change the widget code** (`iOS/Shared`,
`HabitStore+Widgets.swift`, the widget views and snapshot) to build the discreet widget. This is the user's say-so
for this change under Rulebook U28. **What must be preserved, exactly as it works today:**

1. **The near-instant logging experience.** A tap on ✓ or + changes the whole card at once (about 0.3 s on the
   iPhone), and quick repeated taps keep moving on. The visible change comes first; the real work happens after.
   Keep the locked design for this: the tap runs in the widget's process and hands over to the app (W1), the whole
   card is one switch (W2), the "after" card comes from the app (W3), no nested switches (W6), no
   `.invalidatableContent()` (W13), and the "N of M done" patch (W12).
2. **Data reliability.** Every tap counts and is saved once, in order (W4); `widget-taps.json` stays the safety net
   and taps leave it only after a successful save (W5); snapshot writes stay coordinated (W17); timers start and stop
   on the widget without opening the app (W7).
3. **Syncing without opening the app.** A widget tap reaches the server in the background through
   `SyncService.scheduleSoon` with its background task, batching and retry (W18, Rulebook D12); widgets keep
   publishing 0.5 s after a change and at once on leaving the app (W11).

What changes for discreet mode, and how to keep the above intact:

- **Strip the words in the app, not in the widget.** The app writes the discreet snapshot (names, task titles and
  section names left out, counts and "after" cards kept), so the widget never works anything out itself (U26) and
  the names never reach the shared file. The "after" cards must be discreet too, or a tap would flash the name.
- **Discreet is not today's `hidden` state.** `hidden` drops every item and makes `WidgetTaps` refuse taps; discreet
  keeps the items, the switches and the hand-over working.
- **VoiceOver drops the name** (W16 today says "Add 1 to Water"): "Add 1", "Mark done", with the state as its value.
- **Check it the locked way:** on the iPhone's Home Screen with `WidgetLatencyDeviceTests`, App Lock on and off,
  comparing tap-to-change times and confirming the taps reach the server (`-sync-verify`), then stop for the user
  (Widgets — Taps and Updates (Locked) §6). A discreet widget that responds slower or loses a tap isn't finished.

## 6c. Decision 2 in depth: a separate code, and how to make it safe (added 9 Oct 2026)

> **Decided by the user, 9 Oct 2026: offer the separate code as an option.** The default stays the iPhone's own Face ID
> and passcode. In Privacy, people can choose "Face ID and an Often Enough code", built as the seven points below, with a
> **24-hour** wait before the iPhone passcode can set a new code when Face ID can't help.

The user's starting point: people who ask for a separate code have a real reason, so keep that value if the lock-out
problem can be solved, perhaps by letting only a real person (Face ID, a fingerprint) recover or change the code.
Research for this section: a scan for "my family knows my passcode", "different/own/second code", "added a face or
fingerprint" across all 1,487,223 reviews ([`scan_sep.py`](<App Lock and Widget Privacy Evidence/scan_sep.py>);
290 hits, 164 new, all read: [`separate_pass_codes.json`](<App Lock and Widget Privacy Evidence/separate_pass_codes.json>));
the 448 lock-out reviews from both passes tagged for cause and for the way back in they ask for
([`recovery_tags.json`](<App Lock and Widget Privacy Evidence/recovery_tags.json>); keyword tags, with the
passcode, Apple ID and hint groups read one by one); and Apple's and two journaling apps' documentation.

### Why people want a separate code

38 reviews in all (29 in §2, 9 new). Users show one reason above all: **the people they're hiding from know the
phone's passcode** (a parent, partner, sibling, a friend who uses the phone, a thief who watched it typed):

- "creating a personal password instead of using your phone's! (cós if someone went into your phone with your password they'd be able to access this app 😅😰)" (Days Since, 4★, `8103285120`).
- "be able to create a different password, exclusive for this app" (Days Since, 5★, `8229153542`).
- "someone gained access into my phone … What this application is missing is a lock, most likely by way of another password" (Notes, 1★, `13517894671`).
- "I share my phone with others and I wish that I could make it with separate passwords" (Notes, 4★, `10432412489`).
- "anyone can just go in there and start reading your notes, we should be able to lock up notes with a different password" (Google Keep, 3★, `12170737214`).
- One likes it the other way round: "I like being able to creat a separate password for my notes, and not having to have a password on my phone to lock a note" (Notes, 5★, `11163066888`).

With §2's "teen's families know their passcode" (`9016127564`) and "they just entered the password and read the
whole thing" (`13224475328`), the value is specific: **a separate code protects only against someone who knows the
phone's passcode.** Against everyone else, the iPhone's own Face ID and passcode already do the job.

### How people end up locked out, and what they ask for

Of the **448 lock-out reviews** (406 in §2, 42 new; nearly all Apple Notes' separate password):

- **The usual route in is Face ID being dropped**, so the person is suddenly asked for a password they never needed:
  74 say Face ID or Touch ID stopped being offered or stopped working, 49 mention an iOS update, 12 a new phone, a
  repair or a restore (keyword counts; overlapping). "I use Face ID and suddenly it's making me manually type it in" (`8568587391`).
- **Hints don't save anyone, and can give the code away:** 30 lock-outs mention a hint that didn't help, and one
  person's friend guessed the password from the hint: "my friend figured out the password cause after 2 wrong tries it says hint the password is then my password" (Notes, 4★, `14412740926`).
- **The way back in they ask for:** Face ID or a fingerprint (about 100 ask for it in some form), their Apple ID
  (22), or the iPhone passcode (13): "Please make a “forgot password” feature where all you simply have to do is enter your phone password" (Notes, 3★, `9717305128`); "You should be able to use face/print ID at all times or enter your phone password to access your old notes password" (Notes, 1★, `8067167658`); "you could use apple id or somin to prove it's u" (Notes, 1★, `10241028490`).

### What the iPhone and other apps do

- **Apple Notes (iOS 16+)** offers both: lock with the iPhone passcode, or a password only for Notes. For the
  Notes-only password, "there is no way to access your locked notes if you forget the password"
  ([summary of Apple's guidance](https://allthings.how/how-to-lock-notes-with-passcode-on-iphone/)). That is the
  source of the 390 Notes lock-outs.
- **Day One** (journal): a separate app passcode plus Face ID; if the passcode is forgotten, **Face ID resets it**;
  without Face ID, reinstall and restore from Day One Sync; the passcode doesn't sync between devices
  ([Day One help](https://help.dayoneapp.com/en/articles/21602-resetting-the-app-locking-passcode-for-day-one)).
  **Daylio** (mood diary): a forgotten PIN is passed with the fingerprint; otherwise reinstall and restore a backup,
  and without a backup the data is gone ([Daylio FAQ](https://daylio.net/faq/docs/daylio-faq/issues/forgotten-pin-code/)).
  The user's idea is the established convention for private journals.
- **The weak spot in "only Face ID can recover":** anyone who knows the phone's passcode can add their own face
  (Settings → Face ID & Passcode → Set Up an Alternate Appearance) or their own fingerprint. Apple doesn't recommend
  adding another person ([iMore](https://www.imore.com/how-add-second-person-face-id),
  [WILX](https://www.wilx.com/2023/03/06/what-tech-alternate-face-id-dangers/)). The fix exists: an app can tell
  when the enrolled faces or fingers change (`LADomainState`, formerly `evaluatedPolicyDomainState`), and a Keychain
  item protected with `.biometryCurrentSet` stops opening when they do
  ([Apple forum](https://developer.apple.com/forums/thread/748134), [OWASP MASWE-0046](https://mas.owasp.org/MASWE/MASVS-AUTH/MASWE-0046/)).
  Banking apps rely on this; it's why "Face ID will be automatically disabled for security apps" after someone adds
  an appearance (WILX).
- **Apple's own answer to "someone who knows your passcode":** Stolen Device Protection's **security delay**: for
  sensitive changes, Face ID, wait an hour, Face ID again, so the owner has time to act
  ([USNH summary](https://td.usnh.edu/TDClient/60/Portal/KB/ArticleDet?ID=4982)).

### A separate code that can't lock people out (proposal, reasoned from the above)

Offered as a choice next to the default ("Unlock with: iPhone's Face ID and passcode / Face ID and an Often Enough
code"), never forced:

1. **Unlocking:** Face ID or Touch ID, or the Often Enough code. **The iPhone's passcode never opens it.**
2. **The code is kept in the Keychain, on this iPhone only.** Reinstalling the app doesn't remove the lock (closes
   "delete and reinstall to get in"), and it never syncs, so a new phone starts unlocked and gets its data from the
   account or backup as now (D14). A new phone is therefore never a lock-out.
3. **Forgot the code: Face ID resets it** (the user's idea, as Day One does), straight away.
4. **Someone added a face or fingerprint:** if the enrolled set changed since the code was set, Face ID stops
   opening the app and stops resetting the code until the code is typed once. A partner who knows the passcode and
   adds their face gets nothing. The owner sees why: "Face ID changed on this iPhone. Enter your code once."
   How (added 9 Oct, at the user's question): when the code is set, the app saves iOS's summary of the enrolled set
   (`LADomainState`) and stores a "Face ID key" in the Keychain with `.biometryCurrentSet`. On each open it compares
   the summary before offering Face ID; and even if that check were skipped, iOS's Secure Enclave won't release the
   key to a changed set. **Typing the code after a change must not silently trust the new set**, because the new set
   includes whoever was added and iOS can't say whose face it is. The owner is asked instead: "Face ID changed on this
   iPhone. A face or fingerprint was added or removed since you set your code. If you didn't do this, check Settings →
   Face ID & Passcode → Alternate Appearance." with **Use Face ID again** / **Keep Face ID off — use my code**. The
   owner's own changes (resetting Face ID, adding a finger) trigger this too: they type the code once. One developer
   report says an interrupted Face ID reset on iOS 18.3.1 also invalidated such keys
   ([forum](https://developer.apple.com/forums/thread/774790)); same result, the code once. Keychain items surviving
   an app's deletion is today's iOS behaviour, not a promise: check on the iPhone.
5. **Forgot the code and Face ID can't help** (changed set, broken sensor, a mask): a **delayed reset with the
   iPhone passcode.** Ask, wait (say 24 hours), then the passcode sets a new code. While it waits, the lock screen
   says "A code reset was asked for on Tue 10:14. It will be ready Wed 10:14. Cancel with Face ID or your code," so
   the owner sees it the next time they pick up the phone and can cancel it. Modelled on Apple's security delay;
   the people a separate code is for would need the phone for a day, unnoticed.
6. **No hints and no security questions** (users show they fail and leak).
7. **Nothing is ever deleted by any of this.** Data stays in the app and in its backups throughout.

Who it stops, and who it doesn't:

| Person | iPhone's own lock (default) | Separate code, as proposed |
|---|---|---|
| Picks up an unlocked phone | Stopped (needs Face ID or passcode) | Stopped |
| Knows the phone's passcode (family, partner) | **Gets in** | Stopped; a reset needs a day, in view of the owner |
| Adds their own face with the passcode | Gets in | Stopped (enrollment change detected) |
| The owner, Face ID working, forgot the code | — | Face ID resets it at once |
| The owner, Face ID broken, forgot the code | — | Waits a day, then the passcode sets a new code |
| The owner on a new phone | Fine | Fine (the lock and code don't move to the new phone) |
| Someone with the phone, the passcode and a day unnoticed | Gets in | Gets in (no lock can stop this and still never lock the owner out) |

The last row is the honest limit: once "never lose your own data" is a rule (D-section), someone who controls the
phone and its passcode for long enough can always get in. The delay makes that slow and visible.

Open choices for the user: whether to offer the separate code at all now or later; the delay (1 hour as Apple's,
24 hours, or longer); whether the default stays the iPhone's own lock (recommended: yes, it can never lock anyone out).

## 6d. Decision 3 in depth: when it locks again (added 9 Oct 2026)

> **Decided by the user, 9 Oct 2026: option B.** It asks again every time by default. Privacy offers **Ask again:
> Immediately / After 1 minute / After 15 minutes**. Locking the iPhone always locks the app at once, and no choice
> goes past 15 minutes. The five rules at the end of this section hold whatever is chosen.

**How this was checked.** The first read had already coded every review about lock timing. To be sure nothing was
missed, all four corpora were scanned again for a lock word within 120 characters of a timing or switching word
("every time", "background", "switch apps", "5 minutes", "idle", "每次", "毎回" and others; `scan_relock.py`): 928 hits,
774 not read before. A tighter pass on those 774 (a word for the app's own lock, not an account password, near a timing
word) left 7, and none of them is about when an app lock asks again. The other hits are account sign-ins (Microsoft To
Do alone has dozens: "it makes me sign in every time"), which is a different problem. **So the evidence is small, about
25 reviews, and it is all there is.** Codes and IDs: `App Lock and Widget Privacy Evidence/relock_codes.json`.

### What users show

| What they say | Reviews | |
|---|---|---|
| It should ask on **every** return (praise, requests, or a complaint that it didn't) | 12 | 2 praise, 3 ask, 7 complain it opened without asking |
| Give me a few minutes' grace | 1 | 2014, a typed code |
| It asked while I was using it | 2 | both 1 app, a bug |
| Keep my place and what I typed | 3 | |
| Ask by itself, without a tap first | 4 | |
| The list showed for an instant on return | 2 | |
| Unlocking is friction | 2 | |

- **Every time, and they notice when it doesn't.** Praised: "I love how the app locks when you leave it open for
  privacy" (Days Since, 5★, `7830092557`); "if i am reloading the app from recent apps it is again asking for the
  password. quit a nice feature" (Habit Tracker, Play Store, 5★, `5557b8ff-6a24-48bb-8a28-45c7e0c8bfd5`). Asked for:
  "Password or touch id every time i leave the app" (Google Sheets, 3★, `3401141982`); "退出之后自动锁定" [lock
  automatically after leaving] (Notes, 4★, `10785016178`). A lock that sometimes lets you in reads as broken: "sometimes
  it asks for passcode sometimes not" (Habit-Bull, 3★, `1326179122`); "If the app keep opening on the background, no
  password is required to launch the app" (Today, 3★, `2004605175`); "我进去一下他不给我锁着" [I go back in and it isn't
  locked] (Notes, 1★, `9267360102`); iOS's own lock gets the same complaint (`12813881333`, §4).
- **Only one person wants a grace period**, and they were typing a code each time: "if you're gone for 5 minutes then
  you'll have to put the code in again. But not every time please!" (Google Sheets, 2★, `989435187`). Others ask for
  the opposite, including when idle: "I want the option to request for password when I have been idle and/or closed
  the application" (Google Sheets, 5★, `1012921241`).
- **Never while you're using it.** "it goes back to the Face ID thing and then freezes" (Finch, 4★, `8611987056`);
  "It’s been making me to face ID randomly when in the app" (Finch, 5★, `8617159346`). Both were a bug, and both hated.
- **Come back to exactly where you were.** "the app locks which is fine, but what I have written before I leave the
  app is not saved" (Habit Tracker, Play Store, 3★, `94f4dc6f-954c-4747-8027-f6a89dd81534`); "Like in Photos the
  hidden section stays at exactly the same screen when leaving the app and opening it from recent apps - you only need
  to verify yourself with face or touch id and there you are you can continue from where you were" (Notes, 4★,
  `10613163108`). The sign-in complaints show the same thing from another side: "Every time you go out to read the OTP
  from Authenticator or mail and come back, you land on the enter your username screen again" (Microsoft To Do, 1★,
  `5892033795`; an account sign-in, not an app lock). And when the phone locks mid-sentence: "写日记写到一半的时候去接了杯水
  … 手机锁屏了 然后我再打开的时候之前写的日记没有了" [halfway through writing my diary I went to get water … the phone
  locked, and when I opened it again the diary was gone] (ShineDay, 4★, `5771848072`, found in the decision 4 read).
- **Locking the phone must lock the app,** with nothing showing on return: "if I turn off my phone and i have the lock
  on it still lets me in" (Finch, 4★, `8841869821`); "had the app open before locking the phone, when you open it next
  time it will momentarily peek inside" (Daily Habits, 2★, `3342902073`).
- **Friction is about typing, not about being asked.** The friction reviews (and the 1 grace request) come from typed
  codes; the asks in §2 are for Face ID instead ("Now I need to type the password every time", `1334674920`). The one
  that matters most for a habit app: "잠금 해제가 좀 번거로워서 알림만 확인하고 체크를 깜빡 잊는" [unlocking is a
  hassle, so I just read the reminder and forget to tick] (HabitMinder, 3★, `4919677921`). Its answer is not a looser
  lock but logging that doesn't need the app: discreet widgets (decision 1) and reminder buttons (decision 4).

### What the iPhone and other apps do

- **iOS's own app lock** asks again every time the app is opened after leaving it; there is no grace setting (§4).
- **Messaging apps offer a delay:** WhatsApp Immediately, 1 minute, 15 minutes or 1 hour (§4); Telegram's auto-lock
  from 1 minute to 5 hours; Signal a screen-lock timeout. These guard whole conversation histories that people open
  dozens of times a day, often to copy something into another app.
- **Day One** (a journal) has a "Require After" setting.

No review in the corpus praises or criticises any of these delays, so they show a convention people know, not one
users show works (reasoned, per Research/CLAUDE.md).

### Where Often Enough is today (audited 9 Oct 2026, `AppLock.swift`, `HabitsApp.swift`)

- Locks the moment the app goes to the **background**; asks by itself when it comes back, once; a cancel leaves an
  Unlock button. ✓ matches the 12.
- While the app is only **inactive** (the Face ID sheet itself, Control Center, Notification Center pulled down, a
  call banner, the app switcher) it shows the cover but doesn't lock, so there's no prompt to dismiss on return and the
  app switcher never shows habits. ✓
- The cover sits **over** the screen, so the place, an open sheet and typed text are all still there after unlocking. ✓
  (Not covered: if iOS ends the app while it's in the background, a draft is lost; that's a general gap, not the
  lock's.)
- Locking the iPhone sends the app to the background, so it locks. ✓
- There is no grace setting.

### Options

- **A. Every time, no setting (today).** What 12 of 13 timing reviews ask for; matches iOS's own lock; the simplest
  thing to explain ("Often Enough asks for Face ID whenever you come back"). With Face ID asked automatically, coming
  back costs a glance. Its cost falls on people who can't use Face ID at that moment (a mask, gloves, no biometrics):
  they type the iPhone passcode each time.
- **B. Every time by default, with a choice (recommended).** In Privacy, under the lock switch: **Ask again:
  Immediately / After 1 minute / After 15 minutes**, default Immediately. Two rules make the choice safe (reasoned from
  first principles):
  1. **Locking the iPhone always locks the app at once,** whatever the choice. The delay is for switching between apps
     while you're holding the phone; a phone that has been locked may be in someone else's hands next. (To build and
     check on the iPhone: the app hears the phone lock through `protectedDataWillBecomeUnavailable`, which needs the
     device passcode App Lock already requires.)
  2. **No delay longer than 15 minutes.** WhatsApp's 1 hour and Telegram's 5 hours protect much less in a habit app,
     where the people a lock is for are around the same phone all evening (§2). 15 minutes covers looking something up
     and coming back.
- **C. A 1-minute default.** Fewer prompts, but it goes against the only clear signal (people notice and dislike a lock
  that sometimes lets them in) and against iOS's own lock. Not recommended.

Whichever is chosen, these hold (all already true today; to keep, and to cover in the lock's tests):

1. Never ask while the app is in front; the lock comes only on leaving.
2. Never ask after the iPhone's own interruptions (the Face ID sheet, Control Center, Notification Center, a call
   banner, the app switcher), but cover the screen during them.
3. Ask by itself on return; a single Unlock button only after a cancel.
4. Unlock returns to exactly where the person was: the same screen, sheet and typed text.
5. Every way in waits for the unlock: a notification, a widget that opens the app, a link, a Shortcut. What it opened
   is shown once unlocked (the route happens under the cover).

## 6e. Decision 4 in depth: reminders, Siri, the timer and alarms while App Lock is on (added 9 Oct 2026)

> **Decided by the user, 9 Oct 2026: option A, with the own-words field in the same work.** "Hide names on widgets"
> becomes **Hide names outside the app**: widgets, reminders, alarms, the timer's Live Activity and Siri. App Lock turns
> it on and holds it on. Icons, numbers and the Done / + buttons stay. Each habit gets an optional **"Reminder says…"**
> field; while names are hidden, reminders and alarms use those words, or "Reminder · 8:00" when there are none.

**How this was checked.** All four corpora were scanned for a reminder, notification, Siri, Lock Screen, Live Activity
or alarm word near a privacy word, and for reviews about what a reminder's text says (`scan_notif.py`): 2,854 hits. A
tighter privacy pass left 265, all read by hand. Most are about other things (an embarrassing sound in a meeting,
"my personal secretary", time-sensitive alerts, billing). They were added to the first read's codes for notification,
Siri and Lock Screen leaks. Codes and IDs: `App Lock and Widget Privacy Evidence/notif_codes.json`.

### What users show: two needs that pull against each other

| What they say | Reviews |
|---|---|
| A reminder or Siri shouldn't reveal a private habit | 6 |
| Praise "discreet" reminders (often meaning unobtrusive, not private) | 7 |
| **A reminder that doesn't say what it's for gets ignored or is useless** | 10 |
| **Writing my own reminder words** (5 praise it, 5 ask for it) | 10 |
| Acting on a reminder without opening the app | 3 |
| Opening the app from a reminder skipped the lock | 3 (§2) |

- **Names on the screen are seen by others.** "I don't someone see my private habits on my lock screen" (Daily
  Habits, 5★, `1483822944`); "if someone wants to track a private habit, they might not want a notification popping up
  on their screen for people to potentially see" (Onrise, 4★, `8656067520`); "Hidden posts/notifications for sensitive
  goals or entries" (Finch, 5★, `9446216788`); Apple Notes sending notifications with a locked folder's passwords in
  them: "als iemand op m’n telefoon klikt om bijvoorbeeld de tijd te zien dan zien ze al m’n wachtwoorden" [if someone
  taps my phone to see the time, they see all my passwords] (Notes, 1★, `13409797330`).
- **And heard.** "Alcune attività private non è gradito vengano dette ad alta voce mentre si è al lavoro o in giro" [some
  private activities you don't want said out loud at work or out and about] (To Do List, Play Store, 5★,
  `8ef8e187-4cd3-44a3-a80c-ab94083db708`). iPhones read notifications aloud through AirPods and CarPlay (Announce
  Notifications) and mirror them to the Apple Watch.
- **Siri suggestions leak past a lock:** "The app itself can be locked with a passcode. However, it seems that the app
  pushes hints to Siri, so sometimes you will see "add one count to habit X" on your home screen" (Do Habits, 1★,
  `8662056943`).
- **But a reminder that hides what it's for fails at its one job.** "The generic notifications are easily overlooked and
  I typically dismiss them without noticing" (Habit Tracker, Play Store, 4★, `05be0300-8940-468f-82a3-696915ba940c`);
  "It behaves exactly like every other app with generic notifications throughout the day" (Productive, 1★,
  `7857752753`); "it just says “Notification from reminders” instead of the actual reminder" (Reminders, 5★,
  `12363981186`); "my notifications show up as “calendar”on my Lock Screen banner. Before that it would show up as the
  event/item listed for example “dentist” or “call eye doctor”. Now i have to open the app to see what reminders I set"
  (Calendar, 1★, `9872959281`). An Android user who turned on the system's "hide sensitive content" found the habit
  reminder no longer helped: "when pattern lock enabled with safe notification (do not display sensitive notification),
  it doesn't help" (Loop, Play Store, 2★, `486b801c-a159-43b5-ac50-1531798e9f25`).
- **What resolves it, in users' own words: their own reminder text.** Praised: "Getting to write my own notification
  message is also very pleasing and motivating!" (Habit, 4★, `3969524560`); "Like being able to customize the reminder
  messages, very helpful and positive way to reinforce the why behind each goal" (Strides, 4★, `2699028442`); "custom
  notification text(!)" (Loop, Play Store, 5★, `a3be8c44-a7e8-4b44-a935-154bc2064f7d`). Asked for: "Seeing like "It's
  time for your Laundry habit" is a bit silly lol" (HelloHabit, Play Store, 5★, `12a06708-c4e7-4934-abfd-1cf277bf7a0d`);
  a person using a counter to space out meals: "having it encourage me when I haven't eaten for 5+ hours is strange! …
  I just wish there was a way to edit the notifications to custom text" (Days Since, 4★, `9724041871`). Nobody in the
  corpus links custom text to privacy; that link is **reasoned**: words a person chose mean something to them and
  nothing to someone glancing at the phone ("Evening check-in", "The usual"), so the reminder stays useful and private.
- **Done from the reminder is valued:** "a series of reminders could quickly and easily be completed from the
  lockscreen" (Reminders, 1★, `7907840649`, complaining that it was taken away). The one Korean reviewer who skipped
  logging because unlocking was a hassle (`4919677921`, §6d) is the case for keeping Done and +1 on a discreet reminder.

### What the iPhone does

- **Show Previews** (Settings → Notifications): Always, When Unlocked or Never; iPhones with Face ID default to **When
  Unlocked**, which hides a notification's text on the Lock Screen until the owner's face is seen
  ([How-To Geek](https://www.howtogeek.com/392050/how-to-make-notifications-actually-display-on-iphone/),
  [Cult of Mac](https://www.cultofmac.com/how-to/iphone-x-keeps-notifications-secret)). It does **not** help while the
  phone is unlocked in someone else's hands (a banner shows in full), on the Apple Watch, or when read aloud.
- An app can set what shows when previews are hidden: `hiddenPreviewsBodyPlaceholder` ("The placeholder text to display
  when the system disables notification previews for the app",
  [Apple](https://developer.apple.com/documentation/usernotifications/unnotificationcategory/hiddenpreviewsbodyplaceholder)).
- **iOS's own app lock** still delivers a locked app's notifications but hides their previews, with a setting to show
  them ([Nerdschalk](https://nerdschalk.com/what-happens-when-you-lock-an-app-on-iphone/),
  [Galaxus](https://www.galaxus.de/en/page/ios-18-locking-and-hiding-apps-how-it-works-34417)); Siri can't be used with
  it (§4).
- **Apple Watch** has its own Notification Privacy switch (details only after a tap), off by default
  ([iDownloadBlog](https://www.idownloadblog.com/2018/10/15/apple-watch-notifications-privacy/)).
- **Live Activities** appear on the Lock Screen without unlocking; the person can turn Live Activities off under Allow
  Access When Locked, but there is no per-app redaction that keeps the clock and hides the name
  ([iPhoneLife](https://iphonelife.com/content/get-live-updates-your-lock-screen)).
- **Siri runs App Intents on a locked phone by default** (`authenticationPolicy`, §4), and App Shortcuts that name a
  habit are offered in Spotlight, Siri Suggestions and the Shortcuts app.

### Where Often Enough is today (audited 9 Oct 2026)

| Surface | What it shows now | File |
|---|---|---|
| Reminder | Title: the habit's name; body: its plan, "Time for …", the section name; a group: section name and up to 3 habit names; Done or "+1 glass" | `ReminderScheduler.swift` |
| Alarm | Full-screen alert titled with the habit's name ("… · not done yet" for a follow-up); Done | `AlarmScheduler.swift` |
| Live Activity (timer) | Habit name, icon, colour, goal ("20 min"), clock; on the Lock Screen and in the Dynamic Island | `HabitTimerAttributes.swift` |
| Siri "What's left" | Reads the names still to do, also on a locked phone | `HabitIntents.swift` |
| Siri "How's X going", "Log X" | Answers with the habit's progress and streak | `HabitIntents.swift` |
| Spotlight, Shortcuts, Siri Suggestions | A phrase per habit ("Log Water in Often Enough"), refreshed on every rename | `HabitIntents.swift` |

None of it changes when App Lock is on.

### Options

- **A. One switch for everything outside the app (recommended).** Decision 1's "Hide names on widgets" becomes **Hide
  names outside the app**, covering widgets, reminders, alarms, the timer on the Lock Screen and Siri. App Lock turns it
  on and holds it on, as decided for widgets. One idea, one switch, the same rule everywhere: the icon, colour, numbers
  and buttons stay; the words go. While it's on:
  1. **Reminders** say the person's **own reminder words** for that habit if they wrote some (a new optional field,
     "Reminder says…", next to the reminder time); otherwise a neutral line tied to the time, never to the habit:
     "Reminder · 8:00" (a group: "3 reminders · 8:00"; a follow-up: "Still open · 8:00", U3). **Done and + stay**,
     shown without a unit ("+1", as U16 already does on buttons). The habit's icon may go in as a small picture, as
     the discreet widgets keep icons (to try on the iPhone: attachments show as a thumbnail). Section names and notes
     never appear: the person typed them for themselves. `hiddenPreviewsBodyPlaceholder` is set to "Reminder", so a
     phone with previews off says the same.
  2. **Alarms** use the same words: the own reminder words, or "Often Enough · 8:00".
  3. **The timer's Live Activity** shows the icon, colour, clock and fill, no name and no goal text; VoiceOver says
     "Timer running, 12 minutes".
  4. **Siri** answers without names: "2 of 5 done. Open Often Enough to see which." "Log Water" keeps working (the
     person said the name) and replies "Logged". The per-habit phrases and suggestions are withdrawn
     (`updateAppShortcutParameters` with no names; `suggestedEntities` empty), so Spotlight and Siri Suggestions show
     only "Log a habit" and "What's left". The general phrases stay.
  5. **Every tap on any of these goes through the lock** (decision 3, rule 5).
- **B. Separate switches** for widgets, reminders, Siri and the timer. More control; four things to understand, and
  easy to leave one surface showing names by mistake. Users ask for privacy as a whole ("no one can access it without my
  permission", §3), never surface by surface.
- **C. Leave reminders named and rely on iOS's When Unlocked.** Nothing to build, but the name still shows on a banner
  while someone else holds the unlocked phone, on the Watch and aloud, which is when the people the lock is for see it.

The own-words field is worth having even without App Lock (10 reviews want it); while names are hidden it is what keeps
a reminder useful. Reasoned from first principles: it is the only text that can be both meaningful to the owner and
meaningless to anyone else.

## 7. Limits

- Built-in app reviews dominate some themes (Google Keep 592 of 903 requests; Apple Notes 390 of 406 lock-outs).
  They are counted separately throughout; they show what iPhone owners expect of locks generally, not habit apps.
- One app (Days Since) gives 63 of 131 habit-app praises; three apps give all 254 biometric-distrust reviews.
- The dropped set probably hides about 20 relevant reviews (1 in a 60-review sample).
- Theme counts overlap (a review can have several).
- Nothing here was tried on a device. iOS 18's widget removal for locked apps comes from press coverage and user
  reports, not an Apple page; Stolen Device Protection's effect on third-party apps is undocumented. Both to check
  on the user's iPhone.
- Non-English quotes are given with my translation in brackets.
