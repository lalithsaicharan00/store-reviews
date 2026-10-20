# Habit App Inventory — 13 October 2026

Written by Codex, 13 October 2026.

The inventory contains **106 primary habit/routine apps on Google Play with a verified 10K+ download band**, plus **7 adjacent apps with habit or routine features**. Apple has **143 prioritized listings**: **7 have qualifying download evidence from estimates or a founder report**, while **136 still have unverified download qualification**. Apple ratings are supporting evidence only. The download cutoff stays at **10,000 worldwide downloads on each platform**, exactly as the user confirmed.

This is a search-based discovery inventory, not a certified exhaustive census. Local listings absent from the searches, delisted apps and apps whose download figures are private may be missing. The additional **1,575 Apple discovery candidates** are preserved in the discovery queue, including small apps; category review and download verification are incomplete there. Do not describe all of them as qualifying habit trackers.

## Files to use

- [Complete prioritized inventory, CSV](<Habit App Inventory Data/inventory.csv>): both platforms, developer, stable store ID, store/source links, ratings, dates, qualification and evidence scope.
- [Download threshold supported, CSV](<Habit App Inventory Data/download_threshold_supported.csv>): verified Google Play bands and separately labeled Apple estimates/founder inference. Apple estimates and founder inference are evidence types distinct from official download counts.
- [Apple discovery queue, CSV](<Habit App Inventory Data/apple_discovery_queue.csv>): all 1,575 name-matching discoveries, with review status; its search-only rating column is a partial observed total, not a global total.
- [Play discovery audit, CSV](<Habit App Inventory Data/play_discovery_audit.csv>): all 275 packages checked, including unrelated matches, small bands and unreadable pages.
- [Apple ratings by country, JSON](<Habit App Inventory Data/apple_rating_evidence.json>): recomputable totals and failed-country coverage.
- [Download estimate observations](<Habit App Inventory Data/apple_download_estimates.json>) and [additional attributed evidence](<Habit App Inventory Data/additional_download_evidence.json>).

## Scope and collection

Included as primary: configurable habits, recurring routine completion, gamified habit tracking, and configurable bad-habit tracking. Broader task/mood apps with habit features are adjacent. Single-purpose smoking, fasting, fitness, reading and finance trackers, calendars, generic task managers and keyword collisions are outside the primary category. Dedicated habit features are why TickTick and Daylio remain in the adjacent list. This category boundary is an explicit research choice; it is not a product decision.

Started from the repository's attributed curation/ranking files (90 Apple and 146 Play entries); did not apply their search-position, market-reach or rating cutoffs. Added fresh discovery with 24 keyword/market cells per store (Play China skipped), covering English, Japanese, Korean, Chinese, German, French, Portuguese, Spanish, Russian, Indonesian, Turkish and Vietnamese. Apple requests use the maximum 200 results; a finite result limit still misses the long tail. Existing scans cover eight terms across 53 markets. Public search ordering establishes discovery only, not eligibility.

For Apple, existing curated listings, explicit named leads, and newly discovered name-matching apps with at least 500 ratings in the last returned search storefront were prioritized for description review and all-country lookup. That 500 figure is a **work-priority heuristic**, not the inclusion/download cutoff: lower-rating apps remain in the full discovery queue with unresolved status. No low-rating app is asserted to have fewer than 10,000 downloads. This prioritization limits completeness.

Apple's existing `fetch_meta.py`/`habit_rank.py` pattern was reused: batch iTunes lookup by country, then sum `userRatingCount` once per app/country. Requested **176 distinct storefront codes**, successfully read **174**, and received HTTP 400 for **bi, er**. These codes come from the repository's `markets.py`; this does not prove every code is a currently supported Apple storefront. A successful lookup without a listing is recorded as absence, while a failed request is never counted as zero. The totals below are observed across the successfully read storefronts, with two country-code gaps. They are ratings (including star-only ratings), not written reviews or downloads. See [Apple's ratings guidance](https://developer.apple.com/app-store/ratings-and-reviews/) and [view ratings by country](https://developer.apple.com/help/app-store-connect/monitor-ratings-and-reviews/view-ratings-and-reviews/).

Google Play bands were read from live English/US detail pages on 13 October 2026. The displayed band is a worldwide cumulative lower bound; availability was checked only through that storefront. The complete audit contains 275 packages. Observations were cached in `Research/Temp` and the original review corpora/scan caches were not overwritten.

Apple download evidence uses public provider estimates separately from ratings. A month's estimate of 10,000 or more supports passing a 10,000 lifetime threshold **on an estimated basis**. A monthly estimate below 10,000 cannot prove lifetime downloads below 10,000. Provider estimates are rounded and may be stale; preserve the stated period. Some Sensor Tower HTML exposes only the estimate metadata, while its standard overview labels those badges Worldwide/Last Month; the geographic inference is explicit in the CSV. Numerous provider requests were rejected; collection stopped and unresolved statuses were retained. No authentication or paid dashboard was bypassed.

HabitKit's founder reports over 300,000 combined downloads and roughly twice as many on Google Play as App Store on 10 March 2024. Approximately 100,000 iOS downloads follows from that self-report; it is an inference, not an exact Apple count. [Founder's post](https://www.linkedin.com/pulse/weekly-indie-log-22-sebastian-r%C3%B6hl-sjgne). Cross-platform totals on their own, such as [Timecap's 500,000+ claim](https://timecap.app/), were not assigned to Apple.

## Google Play: primary habit and routine tracking, verified 10K+ band

Names and store IDs are separate: apps with identical titles are not merged. The rows are alphabetized; this is not a popularity ranking.

| App / store link | Developer | Downloads | Package ID |
| --- | --- | --- | --- |
| [21 Days Challenge](https://play.google.com/store/apps/details?id=com.limatech.dayschallenge.dayschallenge&gl=US&hl=en) | Kati & Lima | 10M+ | com.limatech.dayschallenge.dayschallenge |
| [Avocation Goal & Habit Tracker](https://play.google.com/store/apps/details?id=app.avocation.avocation&gl=US&hl=en) | Mindvoll | 1M+ | app.avocation.avocation |
| [Bad Habit Break: Quit Tracker](https://play.google.com/store/apps/details?id=com.shpavda.bad_habit_break&gl=US&hl=en) | SHPAVDA, TOO | 1M+ | com.shpavda.bad_habit_break |
| [Chally: Quit Habit](https://play.google.com/store/apps/details?id=com.yjy.challengetogether&gl=US&hl=en) | semdu | 10K+ | com.yjy.challengetogether |
| [Check Calendar - Habit Tracker](https://play.google.com/store/apps/details?id=com.checkcalendarapp&gl=US&hl=en) | Naoki Otsu | 500K+ | com.checkcalendarapp |
| [Dailies: Habit Tracker](https://play.google.com/store/apps/details?id=app.gainaura.habits&gl=US&hl=en) | Must Have Apps. | 10K+ | app.gainaura.habits |
| [Daily Habits: AI Habit Tracker](https://play.google.com/store/apps/details?id=com.free_simple_apps.habits&gl=US&hl=en) | FSA - Simple Apps, Am | 500K+ | com.free_simple_apps.habits |
| [Dear Me: Daily Routine Tracker](https://play.google.com/store/apps/details?id=com.kompanion.habit.android&gl=US&hl=en) | Fitself | 1M+ | com.kompanion.habit.android |
| [Disciplined - Habit Tracker](https://play.google.com/store/apps/details?id=app.disciplined.productive.structured.habit.tracker&gl=US&hl=en) | Tip Tap Apps | 500K+ | app.disciplined.productive.structured.habit.tracker |
| [Do It Now: RPG To Do List](https://play.google.com/store/apps/details?id=com.levor.liferpgtasks&gl=US&hl=en) | Taras Lozovyi | 1M+ | com.levor.liferpgtasks |
| [everyday Habit Tracker](https://play.google.com/store/apps/details?id=com.everydaycheckmobile&gl=US&hl=en) | Everyday Growth SL | 100K+ | com.everydaycheckmobile |
| [EZ Habit: simple habit tracker](https://play.google.com/store/apps/details?id=com.aweydev.ezhabit&gl=US&hl=en) | AWey Dev | 50K+ | com.aweydev.ezhabit |
| [Fabulous Daily Routine Planner](https://play.google.com/store/apps/details?id=co.thefabulous.app&gl=US&hl=en) | TheFabulous | 10M+ | co.thefabulous.app |
| [Finch: Self-Care Pet](https://play.google.com/store/apps/details?id=com.finch.finch&gl=US&hl=en) | Finch Care Public Benefit Corporation | 10M+ | com.finch.finch |
| [Fun Habit - Habit Tracker](https://play.google.com/store/apps/details?id=com.habits.todolist.plan.wish&gl=US&hl=en) | Diary App & Habit Tracker | 100K+ | com.habits.todolist.plan.wish |
| [Glowin - Lifestyle Routines](https://play.google.com/store/apps/details?id=com.kompanion.glowin.android&gl=US&hl=en) | Ornitorenk Dijital Hizmetler Anonim Sirketi | 100K+ | com.kompanion.glowin.android |
| [Goal & Habit Tracker Calendar](https://play.google.com/store/apps/details?id=info.intrasoft.habitgoaltracker&gl=US&hl=en) | Intrasoft | 5M+ | info.intrasoft.habitgoaltracker |
| [Goal Tracker: Challenges](https://play.google.com/store/apps/details?id=com.teadoku.hs&gl=US&hl=en) | Shun Lyu | 10K+ | com.teadoku.hs |
| [Goals: Habit & Goal Tracker](https://play.google.com/store/apps/details?id=com.mindfulsuite.goals&gl=US&hl=en) | Mindful Suite | 100K+ | com.mindfulsuite.goals |
| [haatch. - Goal & Habit Tracker](https://play.google.com/store/apps/details?id=com.haatchapp.mobile&gl=US&hl=en) | Hatch a Plan SRL | 50K+ | com.haatchapp.mobile |
| [Habicat: RPG Habit Tracker](https://play.google.com/store/apps/details?id=studio.fountainhead.habicat&gl=US&hl=en) | Fountainhead Studio | 10K+ | studio.fountainhead.habicat |
| [Habit - habit tracker and goal](https://play.google.com/store/apps/details?id=com.habit.application&gl=US&hl=en) | Roman K. | 100K+ | com.habit.application |
| [Habit Builder](https://play.google.com/store/apps/details?id=com.ofalvai.habittracker&gl=US&hl=en) | Olivér Falvai | 10K+ | com.ofalvai.habittracker |
| [Habit Builder - Flame](https://play.google.com/store/apps/details?id=com.aura.streaktracker&gl=US&hl=en) | Aura App Studio | 50K+ | com.aura.streaktracker |
| [Habit Check Calendar](https://play.google.com/store/apps/details?id=com.weeklychecklist&gl=US&hl=en) | Naoki Otsu | 100K+ | com.weeklychecklist |
| [Habit Eazy - Habit & To Do Pal](https://play.google.com/store/apps/details?id=com.progresspal&gl=US&hl=en) | Trackzio | 100K+ | com.progresspal |
| [Habit Fantasy: ToDo&Habit RPG](https://play.google.com/store/apps/details?id=pro.habitfantasy.app&gl=US&hl=en) | 2CM LABS | 10K+ | pro.habitfantasy.app |
| [Habit Hunter: Gamified Routine](https://play.google.com/store/apps/details?id=co.au.goalhero&gl=US&hl=en) | Active User Studio | 100K+ | co.au.goalhero |
| [Habit Pixel: Streak Tracker](https://play.google.com/store/apps/details?id=com.habitpixel.app&gl=US&hl=en) | Hirvesh Munogee | 50K+ | com.habitpixel.app |
| [Habit Rabbit: Habit Tracker](https://play.google.com/store/apps/details?id=com.superbyte.habitrabbit&gl=US&hl=en) | SuperByte | 500K+ | com.superbyte.habitrabbit |
| [Habit Share - HabitRix](https://play.google.com/store/apps/details?id=com.itdeveapps.habitrix.tracker&gl=US&hl=en) | ItDeveApps | 10K+ | com.itdeveapps.habitrix.tracker |
| [Habit Streak Tracker: DotHabit](https://play.google.com/store/apps/details?id=com.supernora.DotHabit&gl=US&hl=en) | Mono, Inc. | 100K+ | com.supernora.DotHabit |
| [Habit Tracker](https://play.google.com/store/apps/details?id=com.oristats.habitbull&gl=US&hl=en) | App Holdings | 1M+ | com.oristats.habitbull |
| [Habit Tracker & ToDo: HabitJar](https://play.google.com/store/apps/details?id=com.junhwank.habitjar&gl=US&hl=en) | SmallQuest Studio | 10K+ | com.junhwank.habitjar |
| [Habit Tracker - Daily Habits](https://play.google.com/store/apps/details?id=com.habit.tracker.daily.goal.reminder&gl=US&hl=en) | EclixTech | 50K+ | com.habit.tracker.daily.goal.reminder |
| [Habit Tracker - Goalify](https://play.google.com/store/apps/details?id=com.onebytezero.Goalify&gl=US&hl=en) | onebytezero GmbH | 100K+ | com.onebytezero.Goalify |
| [Habit Tracker - Habit Diary](https://play.google.com/store/apps/details?id=habittracker.todolist.tickit.daily.planner&gl=US&hl=en) | Leap Fitness Group | 10M+ | habittracker.todolist.tickit.daily.planner |
| [Habit Tracker - Habit Radar](https://play.google.com/store/apps/details?id=com.gohary.habitradar&gl=US&hl=en) | Goal Tracker | 100K+ | com.gohary.habitradar |
| [Habit Tracker - Habit Streak](https://play.google.com/store/apps/details?id=com.adrienblc.habitstracker&gl=US&hl=en) | BLANC DAHAMNI CAPITAL | 100K+ | com.adrienblc.habitstracker |
| [Habit Tracker - HabitGenius](https://play.google.com/store/apps/details?id=com.habitgenius.habit.tracker&gl=US&hl=en) | Ashish Mangukiya | 500K+ | com.habitgenius.habit.tracker |
| [Habit Tracker - HabitGrid](https://play.google.com/store/apps/details?id=edvarderos.habitgrid&gl=US&hl=en) | Edvard Eros | 10K+ | edvarderos.habitgrid |
| [Habit Tracker - HabitKit](https://play.google.com/store/apps/details?id=com.roehl.habitkit&gl=US&hl=en) | Sebastian Röhl | 500K+ | com.roehl.habitkit |
| [Habit Tracker - Hably](https://play.google.com/store/apps/details?id=com.lebenskompass.habittracker&gl=US&hl=en) | Lebenskompass | 10K+ | com.lebenskompass.habittracker |
| [Habit Tracker - Habstick](https://play.google.com/store/apps/details?id=com.habit.habstick&gl=US&hl=en) | rishad n | 50K+ | com.habit.habstick |
| [Habit Tracker - Strik](https://play.google.com/store/apps/details?id=com.hugocodes.strik&gl=US&hl=en) | HugoCodes | 10K+ | com.hugocodes.strik |
| [Habit Tracker - TickOff](https://play.google.com/store/apps/details?id=app.vinztech.tickit&gl=US&hl=en) | vinztech.app | 100K+ | app.vinztech.tickit |
| [Habit Tracker Kit - HabitDone](https://play.google.com/store/apps/details?id=com.dison.HabitDone&gl=US&hl=en) | JQTech | 10K+ | com.dison.HabitDone |
| [Habit Tracker n Pets: HabitYou](https://play.google.com/store/apps/details?id=com.habityou.planner.goals.journal.habittracker&gl=US&hl=en) | SupYup Habit Tracker Day Planner and Calendar | 100K+ | com.habityou.planner.goals.journal.habittracker |
| [Habit Tracker Unlimited](https://play.google.com/store/apps/details?id=com.panagola.app.tictactoecalendar&gl=US&hl=en) | Panagola Private Limited | 1M+ | com.panagola.app.tictactoecalendar |
| [Habit Tracker, Goals & Lessons](https://play.google.com/store/apps/details?id=com.nurturehabit&gl=US&hl=en) | Tarsher | 10K+ | com.nurturehabit |
| [Habit Tracker: Daily Routine](https://play.google.com/store/apps/details?id=com.ksp.habittracker&gl=US&hl=en) | OpenWave Technologies | 10K+ | com.ksp.habittracker |
| [Habit Tracker: Habit It](https://play.google.com/store/apps/details?id=ro.thinkoutside.habitit&gl=US&hl=en) | ThinkOutside | 50K+ | ro.thinkoutside.habitit |
| [Habit Tracker: IsleGrow](https://play.google.com/store/apps/details?id=com.stonecutters.islegrow&gl=US&hl=en) | Stonecutters | 10K+ | com.stonecutters.islegrow |
| [Habit Tracker: Routine & Goals](https://play.google.com/store/apps/details?id=com.maapps.habittracker&gl=US&hl=en) | Habit360 FZE | 100K+ | com.maapps.habittracker |
| [Habit: Goal & Streak Tracker](https://play.google.com/store/apps/details?id=jp.bondavi.consistency&gl=US&hl=en) | bondavi Inc. | 100K+ | jp.bondavi.consistency |
| [Habitica: Gamify Your Tasks](https://play.google.com/store/apps/details?id=com.habitrpg.android.habitica&gl=US&hl=en) | HabitRPG, Inc. | 5M+ | com.habitrpg.android.habitica |
| [Habitify: Habit Tracker](https://play.google.com/store/apps/details?id=co.unstatic.habitify&gl=US&hl=en) | Unstatic Ltd Co | 500K+ | co.unstatic.habitify |
| [Habitive - Your Habit Tracker](https://play.google.com/store/apps/details?id=com.habitive&gl=US&hl=en) | FiveDotTwelve sp. z o.o. | 10K+ | com.habitive |
| [HabitMinder • Habit Tracker](https://play.google.com/store/apps/details?id=com.funnmedia.habitminder&gl=US&hl=en) | Kodeon, Inc. | 100K+ | com.funnmedia.habitminder |
| [HabitNow Daily Routine Planner](https://play.google.com/store/apps/details?id=com.habitnow&gl=US&hl=en) | HabitNow Apps | 5M+ | com.habitnow |
| [HabitShare - Habit Tracker](https://play.google.com/store/apps/details?id=com.habitshareapp&gl=US&hl=en) | Luke Bickston | 100K+ | com.habitshareapp |
| [HabitTick-Habit Tracker & Todo](https://play.google.com/store/apps/details?id=com.executionhelper.habittick&gl=US&hl=en) | AbhishekSaini98 | 100K+ | com.executionhelper.habittick |
| [Habitude Daily Routine Planner](https://play.google.com/store/apps/details?id=com.savemytime&gl=US&hl=en) | Bumpti Inc | 100K+ | com.savemytime |
| [Happeet - Habit Tracker](https://play.google.com/store/apps/details?id=com.agily.happeet&gl=US&hl=en) | AGILY | 10K+ | com.agily.happeet |
| [HelloHabit - Habit Tracker](https://play.google.com/store/apps/details?id=com.studio.hellohabit&gl=US&hl=en) | RightLife, Inc. | 500K+ | com.studio.hellohabit |
| [HeyBit: Habit Tracker, Journal](https://play.google.com/store/apps/details?id=com.app.heybit&gl=US&hl=en) | HeyBit | 10K+ | com.app.heybit |
| [Hizo: Habit Tracker & Todo](https://play.google.com/store/apps/details?id=dev.voksu.hizo&gl=US&hl=en) | Hizo | 1M+ | dev.voksu.hizo |
| [Idle Habits RPG](https://play.google.com/store/apps/details?id=com.pascualino.idlehabits&gl=US&hl=en) | Pascualino | 10K+ | com.pascualino.idlehabits |
| [Intelligent Change Habits](https://play.google.com/store/apps/details?id=com.intelligenthabits&gl=US&hl=en) | Intelligent Change LLC | 10K+ | com.intelligenthabits |
| [Levla: Habit Tracker RPG](https://play.google.com/store/apps/details?id=com.lifeborne.app&gl=US&hl=en) | Turbo Labs SE | 10K+ | com.lifeborne.app |
| [Life Reset: 66 Day Habit](https://play.google.com/store/apps/details?id=build.designand.riselife&gl=US&hl=en) | Design and Build | 500K+ | build.designand.riselife |
| [LifeUp: Gamify Tasks & Habits](https://play.google.com/store/apps/details?id=net.sarasarasa.lifeup&gl=US&hl=en) | LifeUp Apps | 100K+ | net.sarasarasa.lifeup |
| [Loop Habit Tracker](https://play.google.com/store/apps/details?id=org.isoron.uhabits&gl=US&hl=en) | Álinson S Xavier | 5M+ | org.isoron.uhabits |
| [Me+ Lifestyle Routine](https://play.google.com/store/apps/details?id=daily.planner.routine.habits&gl=US&hl=en) | ENERJOY PTE. LTD. | 10M+ | daily.planner.routine.habits |
| [Micro Habits: Self-Improvement](https://play.google.com/store/apps/details?id=com.infielight.microhabits&gl=US&hl=en) | Infielight | 100K+ | com.infielight.microhabits |
| [Miracle Morning Routine](https://play.google.com/store/apps/details?id=org.miracle.morning&gl=US&hl=en) | Miracle Morning | 100K+ | org.miracle.morning |
| [Morning Habits - Daily Routine](https://play.google.com/store/apps/details?id=com.starttech.habitosmatinais&gl=US&hl=en) | Hábitos Matinais | 500K+ | com.starttech.habitosmatinais |
| [Motivated: Habit Tracker](https://play.google.com/store/apps/details?id=com.motivated.app&gl=US&hl=en) | Hazel Apps SIA | 100K+ | com.motivated.app |
| [My Habit Tracker & Planner](https://play.google.com/store/apps/details?id=de.app4life.htracker&gl=US&hl=en) | Michael R. Stagge | 100K+ | de.app4life.htracker |
| [MyRoutine: Routine Habit Goal](https://play.google.com/store/apps/details?id=com.minding.myroutine&gl=US&hl=en) | Minding Co., Ltd. | 1M+ | com.minding.myroutine |
| [Pixelio - Habit tracker RPG](https://play.google.com/store/apps/details?id=com.luxstudio.pixelioapp&gl=US&hl=en) | Lux Studio Hello | 50K+ | com.luxstudio.pixelioapp |
| [PlanMe: Daily Routine Planner](https://play.google.com/store/apps/details?id=com.planmecorp.planme&gl=US&hl=en) | PlanMe | 50K+ | com.planmecorp.planme |
| [Productive - Habit tracker](https://play.google.com/store/apps/details?id=com.apalon.to.do.list&gl=US&hl=en) | Mosaic Srl | 1M+ | com.apalon.to.do.list |
| [Qhabit: Daily habit tracker](https://play.google.com/store/apps/details?id=com.skillfoxapps.qhabit&gl=US&hl=en) | Skillfox apps | 10K+ | com.skillfoxapps.qhabit |
| [Quitzilla: Quit Habit Tracker](https://play.google.com/store/apps/details?id=com.despdev.quitzilla&gl=US&hl=en) | despDev | 1M+ | com.despdev.quitzilla |
| [Rabit: Habit Tracker & Planner](https://play.google.com/store/apps/details?id=com.blu.rabito&gl=US&hl=en) | blu studios | 1M+ | com.blu.rabito |
| [Reach it: Goals, Habit Tracker](https://play.google.com/store/apps/details?id=com.reachApp.reach_it&gl=US&hl=en) | Reach it Apps | 100K+ | com.reachApp.reach_it |
| [Respawn - Routines & Habits](https://play.google.com/store/apps/details?id=com.nek12.respawn&gl=US&hl=en) | Respawn Team | 10K+ | com.nek12.respawn |
| [Rise: Habit List](https://play.google.com/store/apps/details?id=com.habittracker.routine.habits.dailyplanner&gl=US&hl=en) | One Music Player | 100K+ | com.habittracker.routine.habits.dailyplanner |
| [Roubit:Daily Life Routine Care](https://play.google.com/store/apps/details?id=com.roubit&gl=US&hl=en) | Roubit Inc. | 1M+ | com.roubit |
| [Routine Planner, Habit Tracker](https://play.google.com/store/apps/details?id=com.alt.goodmorning&gl=US&hl=en) | Routinery | 1M+ | com.alt.goodmorning |
| [Routineday Daily Habit Tracker](https://play.google.com/store/apps/details?id=cc.underthehood.lutin.app&gl=US&hl=en) | Hood Co. | 100K+ | cc.underthehood.lutin.app |
| [RoutineFlow: Routine for ADHD](https://play.google.com/store/apps/details?id=app.routineflow.routineflow&gl=US&hl=en) | System Two GmbH | 500K+ | app.routineflow.routineflow |
| [RoutineWin: Routine Planner](https://play.google.com/store/apps/details?id=app.kiteki&gl=US&hl=en) | TimeTune Studio | 10K+ | app.kiteki |
| [ShineDay: Habit Tracker& Goals](https://play.google.com/store/apps/details?id=com.dandelion.international.shineday&gl=US&hl=en) | ShineDay Team | 10K+ | com.dandelion.international.shineday |
| [Simple Habit Tracker - Habits](https://play.google.com/store/apps/details?id=com.jlabs.habittracker&gl=US&hl=en) | JLabs Tech | 10K+ | com.jlabs.habittracker |
| [Skillion: Gamify your life](https://play.google.com/store/apps/details?id=app.skillion&gl=US&hl=en) | Skillion Studios. | 50K+ | app.skillion |
| [Stacked: Routine, Stack Habits](https://play.google.com/store/apps/details?id=app.stacked.routines.habits.stacking.productivity.goals&gl=US&hl=en) | Tip Tap Apps | 10K+ | app.stacked.routines.habits.stacking.productivity.goals |
| [Streaks](https://play.google.com/store/apps/details?id=com.arihant.streaks&gl=US&hl=en) | Arihant Tripathy | 10K+ | com.arihant.streaks |
| [TaskHero: Task & Habit RPG](https://play.google.com/store/apps/details?id=com.whetware.taskhero&gl=US&hl=en) | Whetware Inc | 10K+ | com.whetware.taskhero |
| [TeddyCare: Daily Routine Plan](https://play.google.com/store/apps/details?id=com.kappa.teddybear.android&gl=US&hl=en) | Kappa Yazilim Anonim Sirketi | 1M+ | com.kappa.teddybear.android |
| [TheFor: Habit Tracker](https://play.google.com/store/apps/details?id=xyz.thefor.habits.habits&gl=US&hl=en) | TheFor | 500K+ | xyz.thefor.habits.habits |
| [Timecap care: ADHD Habit Timer](https://play.google.com/store/apps/details?id=com.ziggycrane.time&gl=US&hl=en) | Product Growth LLC | 100K+ | com.ziggycrane.time |
| [Ultimate Streak: Habit Tracker](https://play.google.com/store/apps/details?id=com.plthatfunkymusic.ultimatechallenge&gl=US&hl=en) | Stronger Mobile Apps | 10K+ | com.plthatfunkymusic.ultimatechallenge |
| [Way of Life: habit tracker](https://play.google.com/store/apps/details?id=com.wayoflife.app&gl=US&hl=en) | Way of Life ApS | 500K+ | com.wayoflife.app |
| [Wipepp - Habit Tracking](https://play.google.com/store/apps/details?id=com.bybazsoft.challenge&gl=US&hl=en) | ByBaz | 1M+ | com.bybazsoft.challenge |

## Google Play: adjacent apps, verified 10K+ band

| App / store link | Downloads | Why separate |
| --- | --- | --- |
| [Daily Planner: Habits & Tasks](https://play.google.com/store/apps/details?id=com.youdailyplan&gl=US&hl=en) | 10K+ | Broader planner covering habits and daily life |
| [Daylio Journal - Mood Tracker](https://play.google.com/store/apps/details?id=net.daylio&gl=US&hl=en) | 10M+ | Mood journal with activity, habit and goal tracking |
| [iTask - To Do List & Planner](https://play.google.com/store/apps/details?id=planner.task.todolist.habit&gl=US&hl=en) | 50K+ | Broader task manager with explicit habit tracking |
| [Mood Tracker: Self-Care Habits](https://play.google.com/store/apps/details?id=moodtracker.selfcare.habittracker.mentalhealth&gl=US&hl=en) | 1M+ | Mood and self-care tracking with habits |
| [TickTick:To Do List & Calendar](https://play.google.com/store/apps/details?id=com.ticktick.task&gl=US&hl=en) | 10M+ | Task and calendar app with dedicated habit tracking |
| [Tiimo: Daily To Do List](https://play.google.com/store/apps/details?id=com.tiimo.androidappreactnative&gl=US&hl=en) | 100K+ | Visual routine/day planner; adjacent rather than primary |
| [Time Planner: Schedule & Tasks](https://play.google.com/store/apps/details?id=com.albul.timeplanner&gl=US&hl=en) | 5M+ | Broader schedule and task planner with habit tracking |

## Apple: download threshold supported by estimate or founder inference

These rows have download evidence independent of their rating totals. Evidence quality and time/geography are stated in the CSV. An estimate is not an official Apple measurement.

| App / store link | Download evidence / source | Evidence type | Period | Observed global ratings |
| --- | --- | --- | --- | --- |
| [Fabulous: Daily Habit Tracker](https://apps.apple.com/us/app/fabulous-daily-habit-tracker/id1203637303?uo=4) | [10k](https://app.sensortower.com/overview/1203637303?page=1&page_size=25) | provider_estimate | last month (provider label) | 229,161 |
| [Finch: Self-Care Pet](https://apps.apple.com/us/app/finch-self-care-pet/id1528595748?uo=4) | [300,000](https://app.sensortower.com/overview/1528595748?country=us) | provider_estimate | Last Month (provider label; exact month not independently fixed) | 1,030,877 |
| [Habit Tracker](https://apps.apple.com/us/app/habit-tracker/id1438388363?uo=4) | [200,000](https://app.sensortower.com/overview/1438388363?page=1&page_size=25) | provider_estimate | Last Month (provider label; exact month not independently fixed) | 535,378 |
| [Habit Tracker - HabitKit](https://apps.apple.com/us/app/habit-tracker-habitkit/id6443918070?uo=4) | [100,000](https://www.linkedin.com/pulse/weekly-indie-log-22-sebastian-r%C3%B6hl-sjgne) | founder_report_with_inference | Cumulative to 10 March 2024 | 9,474 |
| [Habit: Goal & Streak Tracker](https://apps.apple.com/us/app/habit-goal-streak-tracker/id1120239484?uo=4) | [10k](https://app.sensortower.com/overview/1120239484?page=1&page_size=25) | provider_estimate | last month (provider label) | 53,671 |
| [Me+ Lifestyle Routine](https://apps.apple.com/us/app/me-lifestyle-routine/id1596403446?uo=4) | [50,000](https://app.sensortower.com/overview/1596403446?ad_monetization_measure=adsPerMau&ad_monetization_metric=adImpressions&breakdown_attribute=appId&category=6013&chart_plotting_type=line&chart_type=free&country=US&device=iphone&edit=1&end_date=2025-12-22&granularity=daily&impression_share_metric_option=all&install_base_measure=installBase&measure=revenue&metricType=absolute&os=ios&platform_type=networks&retention_chart_type=curve&retention_measure=retentionD1&retention_period=day&rolling_days=0&selected_tab=0&session_count=sessionCount&start_date=2025-11-23&time_period=day&time_spent=timeSpent) | provider_estimate | Last Month (provider label; exact month not independently fixed) | 573,290 |
| [Streaks](https://apps.apple.com/us/app/streaks/id963034692?uo=4) | [20,000](https://socialpeta.com/en/app-store/963034692) | provider_estimate | September 2026 | 67,639 |

## Apple: prioritized listings with download qualification unverified

These remain candidates for the user's requested list; their download threshold is not asserted. They are retained even when ratings are low. Each observed total is independently recomputable from the country JSON.

| App / store link | Developer | Observed global ratings | App ID |
| --- | --- | --- | --- |
| [(Not Boring) Habits](https://apps.apple.com/us/app/not-boring-habits/id1593891243?uo=4) | Not Boring Software LLC | 13,920 | 1593891243 |
| [ADHD Habit Tracker, To Do List](https://apps.apple.com/us/app/adhd-habit-tracker-to-do-list/id1494584871?uo=4) | NOTA SYSTEMS, LLC | 2,695 | 1494584871 |
| [Atoms - from Atomic Habits](https://apps.apple.com/us/app/atoms-from-atomic-habits/id6474421906?uo=4) | Atomic Development Inc. | 21,003 | 6474421906 |
| [Avocation - Habit Tracker](https://apps.apple.com/us/app/avocation-habit-tracker/id1479581895?uo=4) | David Joech | 3,523 | 1479581895 |
| [Awesome Habits: Habit Tracker](https://apps.apple.com/us/app/awesome-habits-habit-tracker/id1514915737?uo=4) | Michal Tuma | 3,955 | 1514915737 |
| [Being Me: Journal/Goals/Habits](https://apps.apple.com/us/app/being-me-journal-goals-habits/id1462605314?uo=4) | Make Your Meaning, LLC | 5,695 | 1462605314 |
| [Better Habits of Health](https://apps.apple.com/us/app/better-habits-of-health/id954911327?uo=4) | Wired Betterment | 1,228 | 954911327 |
| [Blossom Daily Habit Tracker](https://apps.apple.com/us/app/blossom-daily-habit-tracker/id6770147415?uo=4) | Frances Ling | 399 | 6770147415 |
| [Check Calendar - Habit Tracker](https://apps.apple.com/us/app/check-calendar-habit-tracker/id1563837295?uo=4) | Naoki Otsu | 7,881 | 1563837295 |
| [Consistency: AI Habit Tracker](https://apps.apple.com/us/app/consistency-ai-habit-tracker/id6757651086?uo=4) | Matheus fernandes | 5 | 6757651086 |
| [Critique AI: Habit Tracker](https://apps.apple.com/us/app/critique-ai-habit-tracker/id6743095634?uo=4) | With Bytes LLC | 18,972 | 6743095634 |
| [Daily Habit & Routine Tracker](https://apps.apple.com/us/app/daily-habit-routine-tracker/id1477345602?uo=4) | CREATIVE TECHNOLOGIES LLC | 17,530 | 1477345602 |
| [Daily Habits - Habit Tracker](https://apps.apple.com/us/app/daily-habits-habit-tracker/id1133119692?uo=4) | Olha Ievenko | 1,594 | 1133119692 |
| [Daily Habits: Lifetime Premium](https://apps.apple.com/us/app/daily-habits-lifetime-premium/id1550003470?uo=4) | Sergey Belychev | 2 | 1550003470 |
| [Daily Habits: Streak Tracker](https://apps.apple.com/us/app/daily-habits-streak-tracker/id1523643868?uo=4) | Sergey Belychev | 835 | 1523643868 |
| [Daily Routine](https://apps.apple.com/us/app/daily-routine/id1580007457?uo=4) | Daily Routine Pty Ltd | 111 | 1580007457 |
| [Daily Routine - Plan Your Life](https://apps.apple.com/us/app/daily-routine-plan-your-life/id1566698810?uo=4) | Le Nhung | 70 | 1566698810 |
| [Daily Routine Planner - DayMap](https://apps.apple.com/us/app/daily-routine-planner-daymap/id6740321886?uo=4) | Jayeshbhai Kavathiya | 683 | 6740321886 |
| [Daily Routines & Planner App](https://apps.apple.com/us/app/daily-routines-planner-app/id6523413981?uo=4) | East Frisia LLC | 49 | 6523413981 |
| [DailyHabits: Build Good Habits](https://apps.apple.com/us/app/dailyhabits-build-good-habits/id1660929974?uo=4) | Capable Koala LLC | 27 | 1660929974 |
| [Days Since: Quit Habit Tracker](https://apps.apple.com/us/app/days-since-quit-habit-tracker/id1445348921?uo=4) | A Couple of Friends OOD | 37,843 | 1445348921 |
| [DayStamp - Habit Tracker](https://apps.apple.com/us/app/daystamp-habit-tracker/id1456241316?uo=4) | 동현 hwang | 6,642 | 1456241316 |
| [Dear Me: Daily Routine Tracker](https://apps.apple.com/us/app/dear-me-daily-routine-tracker/id6475956795?uo=4) | Fitself Dijital Hizmetler Anonim Sirketi | 66,358 | 6475956795 |
| [Do Habits: Get It Done](https://apps.apple.com/us/app/do-habits-get-it-done/id1103961876?uo=4) | Kodeon, Inc. | 30,244 | 1103961876 |
| [Done Calendar - Habit Tracker](https://apps.apple.com/us/app/done-calendar-habit-tracker/id6444584489?uo=4) | NAKASHIN, K.K. | 574 | 6444584489 |
| [Dots: Habit Tracker Widget](https://apps.apple.com/us/app/dots-habit-tracker-widget/id6758730376?uo=4) | Juyong Bak | 589 | 6758730376 |
| [Eden: Daily Routine Planner](https://apps.apple.com/us/app/eden-daily-routine-planner/id1589243137?uo=4) | Millefeuille Agency | 18,417 | 1589243137 |
| [everyday - Habit Tracker](https://apps.apple.com/us/app/everyday-habit-tracker/id1394150432?uo=4) | Everyday Growth S.L. | 16,925 | 1394150432 |
| [Forest - Focus Timer](https://apps.apple.com/us/app/forest-focus-timer/id1500856145?uo=4) | 青青 陈 | 1,019 | 1500856145 |
| [FrogCount - Habit Tracker](https://apps.apple.com/us/app/frogcount-habit-tracker/id6739162457?uo=4) | 帆 邱 | 2,648 | 6739162457 |
| [GetHabit - Easy Habit Tracker](https://apps.apple.com/us/app/gethabit-easy-habit-tracker/id1541469491?uo=4) | Fire Arc Technologies Ltd | 22,181 | 1541469491 |
| [Goal Streak: Habit Tracker](https://apps.apple.com/us/app/goal-streak-habit-tracker/id1630626343?uo=4) | Swifty Bits LLC | 885 | 1630626343 |
| [GoalMap: Goal Planner & To-Do](https://apps.apple.com/us/app/goalmap-goal-planner-to-do/id1555022550?uo=4) | Hangzhou North Gate Co., Ltd. | 13,206 | 1555022550 |
| [Greatness: Daily Habit Tracker](https://apps.apple.com/us/app/greatness-daily-habit-tracker/id1641012703?uo=4) | Greatness UAB | 1,502 | 1641012703 |
| [Grit: Daily Habit Tracker](https://apps.apple.com/us/app/grit-daily-habit-tracker/id6446997766?uo=4) | GrittyApps | 93,010 | 6446997766 |
| [Habicat - RPG Habit Tracker](https://apps.apple.com/us/app/habicat-rpg-habit-tracker/id6444766871?uo=4) | 今朝 王 | 1,502 | 6444766871 |
| [Habio - Daily Habit Tracker](https://apps.apple.com/us/app/habio-daily-habit-tracker/id1517360968?uo=4) | Gototop LTD | 11,244 | 1517360968 |
| [Habit Builder - Brick by Brick](https://apps.apple.com/us/app/habit-builder-brick-by-brick/id6475047132?uo=4) | Adam Feher | 13 | 6475047132 |
| [Habit Builder - Flame](https://apps.apple.com/us/app/habit-builder-flame/id6749051240?uo=4) | Explora SAS | 520 | 6749051240 |
| [Habit Builder: Daily Tracker](https://apps.apple.com/us/app/habit-builder-daily-tracker/id1614197639?uo=4) | Alexander Thompson | 58 | 1614197639 |
| [Habit Builder: Don't Break The Chain](https://apps.apple.com/us/app/habit-builder-dont-break-the-chain/id1260902519?uo=4) | Xilva Multimedia | 11 | 1260902519 |
| [Habit Builder: Track & Streak](https://apps.apple.com/us/app/habit-builder-track-streak/id6789635670?uo=4) | Neural Fusion Technologies Private Limited | 2 | 6789635670 |
| [Habit Builder・Atomic Habits AI](https://apps.apple.com/us/app/habit-builder-atomic-habits-ai/id6443798772?uo=4) | Maryna Aliakseichyk | 120 | 6443798772 |
| [Habit Check Calendar](https://apps.apple.com/us/app/habit-check-calendar/id1629764198?uo=4) | Naoki Otsu | 4,225 | 1629764198 |
| [Habit Hearts - Habit Tracker](https://apps.apple.com/us/app/habit-hearts-habit-tracker/id6737323367?uo=4) | Akash Jain | 1,293 | 6737323367 |
| [Habit Hub: Routine Tracker](https://apps.apple.com/us/app/habit-hub-routine-tracker/id1149192857?uo=4) | Sabana Patel | 12,073 | 1149192857 |
| [Habit Nest: Fitness & Routines](https://apps.apple.com/us/app/habit-nest-fitness-routines/id1539986642?uo=4) | Every Damn Day, LLC | 1,922 | 1539986642 |
| [Habit Rabbit: Habit Tracker](https://apps.apple.com/us/app/habit-rabbit-habit-tracker/id1522121879?uo=4) | Justin Patrick Silang | 20,632 | 1522121879 |
| [Habit Streak Tracker: DotHabit](https://apps.apple.com/us/app/habit-streak-tracker-dothabit/id1439938837?uo=4) | Mono Incorporated | 21,398 | 1439938837 |
| [Habit Streak \| Daily Tracker](https://apps.apple.com/us/app/habit-streak-daily-tracker/id6504493690?uo=4) | Adrien Blanc | 699 | 6504493690 |
| [Habit Tracker - Daily Goals](https://apps.apple.com/us/app/habit-tracker-daily-goals/id6480042457?uo=4) | Uniqo Lab FZC | 6,768 | 6480042457 |
| [Habit Tracker - Evoday](https://apps.apple.com/us/app/habit-tracker-evoday/id1403517519?uo=4) | Cosmic Taps SL | 4,341 | 1403517519 |
| [Habit Tracker - HabitGrid](https://apps.apple.com/us/app/habit-tracker-habitgrid/id6746483721?uo=4) | Edvard Adam Eros | 391 | 6746483721 |
| [Habit Tracker - Habitica](https://apps.apple.com/us/app/habit-tracker-habitica/id6480409654?uo=4) | Anton Churakov | 44 | 6480409654 |
| [Habit Tracker - Habitly](https://apps.apple.com/us/app/habit-tracker-habitly/id6448960901?uo=4) | yusuf kildan | 578 | 6448960901 |
| [Habit Tracker - Habitty](https://apps.apple.com/us/app/habit-tracker-habitty/id1228128916?uo=4) | Yury Paliashchuk | 4,217 | 1228128916 |
| [Habit Tracker by Goalify](https://apps.apple.com/us/app/habit-tracker-by-goalify/id950247830?uo=4) | onebytezero GmbH | 2,225 | 950247830 |
| [Habit Tracker: Loop](https://apps.apple.com/us/app/habit-tracker-loop/id6478388488?uo=4) | Artem Shyshko | 1,449 | 6478388488 |
| [Habit Tracker: Streak-Free](https://apps.apple.com/us/app/habit-tracker-streak-free/id6737206675?uo=4) | Beaucode Ventures UG (haftungsbeschraenkt) | 458 | 6737206675 |
| [Habit Tracker: TheFor](https://apps.apple.com/us/app/habit-tracker-thefor/id1671322093?uo=4) | Siraj Hasanov | 316 | 1671322093 |
| [Habit — Daily Tracker](https://apps.apple.com/us/app/habit-daily-tracker/id1445651730?uo=4) | Kodeon, Inc. | 11,144 | 1445651730 |
| [Habit-Bull: Daily Goal Planner](https://apps.apple.com/us/app/habit-bull-daily-goal-planner/id1041482672?uo=4) | AppForge Inc. | 20,966 | 1041482672 |
| [Habit: Streak Tracker & Goals](https://apps.apple.com/us/app/habit-streak-tracker-goals/id1523273937?uo=4) | Thanh Ha | 120 | 1523273937 |
| [HabitDay](https://apps.apple.com/us/app/habitday/id1387758233?uo=4) | Shenzhen Brown Bear Technology Co., LTD | 1,050 | 1387758233 |
| [Habitica: Gamified Taskmanager](https://apps.apple.com/us/app/habitica-gamified-taskmanager/id994882113?uo=4) | HabitRPG, Inc. | 8,912 | 994882113 |
| [Habitify: Habit Tracker](https://apps.apple.com/us/app/habitify-habit-tracker/id1111447047?uo=4) | Unstatic Ltd Co | 69,901 | 1111447047 |
| [HabitMinder • Habit Tracker](https://apps.apple.com/us/app/habitminder-habit-tracker/id1253577148?uo=4) | Kodeon, Inc. | 26,589 | 1253577148 |
| [Habits: Daily Goals](https://apps.apple.com/us/app/habits-daily-goals/id1449410447?uo=4) | 朋 潘 | 1,756 | 1449410447 |
| [HabitShare - Habit Tracker](https://apps.apple.com/us/app/habitshare-habit-tracker/id1048191045?uo=4) | Lucas Bickston | 1,295 | 1048191045 |
| [HabitStar: Bad Habit Tracker](https://apps.apple.com/us/app/habitstar-bad-habit-tracker/id6736508319?uo=4) | 旷 张 | 1,743 | 6736508319 |
| [HelloHabit - Habit Tracker](https://apps.apple.com/us/app/hellohabit-habit-tracker/id6476824223?uo=4) | RightLife, Inc. | 5,600 | 6476824223 |
| [iBetter · Habit Tracker](https://apps.apple.com/us/app/ibetter-habit-tracker/id1262378864?uo=4) | iDaily Corp. | 50,254 | 1262378864 |
| [iHabit: Habit Tracker & Goals](https://apps.apple.com/us/app/ihabit-habit-tracker-goals/id1046787451?uo=4) | Yan Deng | 1,536 | 1046787451 |
| [Kubbo: Goal Tracker](https://apps.apple.com/us/app/kubbo-goal-tracker/id6749530918?uo=4) | SPLURB | 849 | 6749530918 |
| [Lasting Change: Habit Builder](https://apps.apple.com/us/app/lasting-change-habit-builder/id6456888481?uo=4) | MEDICAL SCORE UAB | 939 | 6456888481 |
| [Life Reset: 66 Day Habit](https://apps.apple.com/us/app/life-reset-66-day-habit/id6478942469?uo=4) | Savvy Tech Limited | 29,837 | 6478942469 |
| [LifeWheel Goal Habit Tracker](https://apps.apple.com/us/app/lifewheel-goal-habit-tracker/id988402523?uo=4) | Oleksandr Stepanov | 6,949 | 988402523 |
| [List Habits](https://apps.apple.com/us/app/list-habits/id1641084877?uo=4) | 文华 肖 | 1,294 | 1641084877 |
| [Loop Habit Tracker: Streaks](https://apps.apple.com/us/app/loop-habit-tracker-streaks/id6754244909?uo=4) | Tech Atlas LLC | 78 | 6754244909 |
| [MarkTimes](https://apps.apple.com/us/app/marktimes/id6475532850?uo=4) | Ji Mo | 3,448 | 6475532850 |
| [Mindway: Daily Routine Planner](https://apps.apple.com/us/app/mindway-daily-routine-planner/id6502995200?uo=4) | DEEP FLOW SOFTWARE SERVICES - FZCO | 4,091 | 6502995200 |
| [Miracle Morning Routine](https://apps.apple.com/us/app/miracle-morning-routine/id1581511740?uo=4) | Hal Elrod | 8,836 | 1581511740 |
| [MoHabit - habit tracking](https://apps.apple.com/us/app/mohabit-habit-tracking/id1398210569?uo=4) | 振华 莫 | 1,092 | 1398210569 |
| [Monke - Habit Game](https://apps.apple.com/us/app/monke-habit-game/id6755640836?uo=4) | MYLES NICHOLAS ROOT | 4,777 | 6755640836 |
| [My Habits: Daily Habit Builder](https://apps.apple.com/us/app/my-habits-daily-habit-builder/id814998643?uo=4) | Siarhei Marozau | 34 | 814998643 |
| [my nicca - 目標達成のためのシンプル習慣化アプリ](https://apps.apple.com/jp/app/my-nicca-%E7%9B%AE%E6%A8%99%E9%81%94%E6%88%90%E3%81%AE%E3%81%9F%E3%82%81%E3%81%AE%E3%82%B7%E3%83%B3%E3%83%97%E3%83%AB%E7%BF%92%E6%85%A3%E5%8C%96%E3%82%A2%E3%83%97%E3%83%AA/id1623780682?uo=4) | FURYU Corporation | 6,178 | 1623780682 |
| [MyRoutine: Organize your day](https://apps.apple.com/us/app/myroutine-organize-your-day/id1518956326?uo=4) | Minding. co., Ltd. | 37,777 | 1518956326 |
| [MyStreaks - Streak Tracker](https://apps.apple.com/us/app/mystreaks-streak-tracker/id1519067736?uo=4) | Streaking LLC | 75 | 1519067736 |
| [North Star: Goals & Habits](https://apps.apple.com/us/app/north-star-goals-habits/id1480448999?uo=4) | Krisper AB | 1,210 | 1480448999 |
| [O.Habits —  Трекер привычек](https://apps.apple.com/us/app/o-habits-%D1%82%D1%80%D0%B5%D0%BA%D0%B5%D1%80-%D0%BF%D1%80%D0%B8%D0%B2%D1%8B%D1%87%D0%B5%D0%BA/id1483283121?uo=4) | Sergey Romanovich | 2,524 | 1483283121 |
| [Onrise: Habit Tracker & Focus](https://apps.apple.com/us/app/onrise-habit-tracker-focus/id1547137474?uo=4) | Maximilian Munker | 9,314 | 1547137474 |
| [Productive - Habit Tracker](https://apps.apple.com/us/app/productive-habit-tracker/id983826477?uo=4) | Mosaic S.r.l. | 278,678 | 983826477 |
| [Quit Bad Habits & Addiction](https://apps.apple.com/us/app/quit-bad-habits-addiction/id1658588991?uo=4) | SHPAVDA, TOO | 15,930 | 1658588991 |
| [Rabit - Daily Routine Planner](https://apps.apple.com/us/app/rabit-daily-routine-planner/id1512605216?uo=4) | GARJ APLICATIVOS LTDA | 5,370 | 1512605216 |
| [Ripples: Habit Tracker](https://apps.apple.com/us/app/ripples-habit-tracker/id6502667826?uo=4) | Mykola Harmash | 1,136 | 6502667826 |
| [Roubit : Fun Routine Planner](https://apps.apple.com/us/app/roubit-fun-routine-planner/id1527382961?uo=4) | Roubit Inc. | 3,530 | 1527382961 |
| [Routick: Habit Tracker & To-Do](https://apps.apple.com/us/app/routick-habit-tracker-to-do/id1463321963?uo=4) | Yoshinobu Kanetaka | 1,092 | 1463321963 |
| [Routine Planner, Habit Tracker](https://apps.apple.com/us/app/routine-planner-habit-tracker/id1450486923?uo=4) | Routinery Corp. | 43,247 | 1450486923 |
| [Routine Tracker App](https://apps.apple.com/us/app/routine-tracker-app/id6758340216?uo=4) | Alexander Jacobsen | 0 | 6758340216 |
| [RoutineFlow: Routine for ADHD](https://apps.apple.com/us/app/routineflow-routine-for-adhd/id1639800794?uo=4) | System Two GmbH | 4,989 | 1639800794 |
| [Routinery, Daily Habit Planner](https://apps.apple.com/us/app/routinery-daily-habit-planner/id1549845424?uo=4) | Evrim Demir | 1,197 | 1549845424 |
| [ShineDay: Habit Tracker](https://apps.apple.com/us/app/shineday-habit-tracker/id1263789061?uo=4) | Guangzhou Xiaorichang Technology Co., Ltd. | 564,230 | 1263789061 |
| [Simple Streak: Habit Tracker](https://apps.apple.com/us/app/simple-streak-habit-tracker/id6742739243?uo=4) | Kim Walker | 105 | 6742739243 |
| [SkillSculpt](https://apps.apple.com/us/app/skillsculpt/id6768613786?uo=4) | AGREIN TRAFIK, TOV | 1,061 | 6768613786 |
| [Smile Todo - Time Management](https://apps.apple.com/us/app/smile-todo-time-management/id1551532207?uo=4) | EMMO Corp. | 179,445 | 1551532207 |
| [STICK: Routine Accountability](https://apps.apple.com/us/app/stick-routine-accountability/id6754049782?uo=4) | Ahdiverse Inc. | 3 | 6754049782 |
| [Streak Tracker: Habitug](https://apps.apple.com/us/app/streak-tracker-habitug/id6760905736?uo=4) | Fline LLC | 2 | 6760905736 |
| [Streak: Habit Tracker](https://apps.apple.com/us/app/streak-habit-tracker/id6692634213?uo=4) | Ilya Golubev | 12 | 6692634213 |
| [Streakster - Habit Tracker](https://apps.apple.com/us/app/streakster-habit-tracker/id1588435564?uo=4) | Bickster LLC | 614 | 1588435564 |
| [Strides: Habit Tracker + Goals](https://apps.apple.com/us/app/strides-habit-tracker-goals/id672401817?uo=4) | Goals LLC | 37,207 | 672401817 |
| [Tappsk: ToDo & Habit Tracker](https://apps.apple.com/us/app/tappsk-todo-habit-tracker/id1385049326?uo=4) | MATVEY KONDAKOV | 48,560 | 1385049326 |
| [Temfy - Habit Tracker](https://apps.apple.com/us/app/temfy-habit-tracker/id6745508692?uo=4) | GAL APP LTD | 352 | 6745508692 |
| [That Girl: Routine Planner](https://apps.apple.com/us/app/that-girl-routine-planner/id1597753705?uo=4) | Solowei Group LTD | 20,351 | 1597753705 |
| [Tiny Habits Tracker](https://apps.apple.com/us/app/tiny-habits-tracker/id1455083310?uo=4) | xiaorichang Technology Co., Ltd. | 25,969 | 1455083310 |
| [To Do List・Habit Tracker](https://apps.apple.com/us/app/to-do-list-habit-tracker/id1564649372?uo=4) | Julia Rabchanova | 1,173 | 1564649372 |
| [Today Habit tracker](https://apps.apple.com/us/app/today-habit-tracker/id1055295863?uo=4) | Neybox Digital Ltd. | 11,745 | 1055295863 |
| [Ultiself \| Self-Improvement](https://apps.apple.com/us/app/ultiself-self-improvement/id1476563238?uo=4) | Ultiself Corporation | 14,296 | 1476563238 |
| [ViceBreakr - Bad Habit Break](https://apps.apple.com/us/app/vicebreakr-bad-habit-break/id6758634959?uo=4) | Stylelens ai llc | 784 | 6758634959 |
| [Way of Life - Habit Tracker](https://apps.apple.com/us/app/way-of-life-habit-tracker/id393159800?uo=4) | Way of Life ApS | 16,215 | 393159800 |
| [Wisey: Habit Builder](https://apps.apple.com/us/app/wisey-habit-builder/id6742659386?uo=4) | KOFLIMIN LIMITED | 353 | 6742659386 |
| [Yomento Habit Builder](https://apps.apple.com/us/app/yomento-habit-builder/id6471958524?uo=4) | Yomento Management AB | 3 | 6471958524 |
| [YoYo日常-习惯养成打卡软件](https://apps.apple.com/us/app/yoyo%E6%97%A5%E5%B8%B8-%E4%B9%A0%E6%83%AF%E5%85%BB%E6%88%90%E6%89%93%E5%8D%A1%E8%BD%AF%E4%BB%B6/id1562071067?uo=4) | Chongqing Luxifa Technology Co., Ltd | 38,923 | 1562071067 |
| [みんチャレ-習慣化で目標達成～ダイエットや禁酒・禁煙を継続](https://apps.apple.com/jp/app/%E3%81%BF%E3%82%93%E3%83%81%E3%83%A3%E3%83%AC-%E7%BF%92%E6%85%A3%E5%8C%96%E3%81%A7%E7%9B%AE%E6%A8%99%E9%81%94%E6%88%90-%E3%83%80%E3%82%A4%E3%82%A8%E3%83%83%E3%83%88%E3%82%84%E7%A6%81%E9%85%92-%E7%A6%81%E7%85%99%E3%82%92%E7%B6%99%E7%B6%9A/id1047462806?uo=4) | A10 Lab Inc. | 34,844 | 1047462806 |
| [习惯岛](https://apps.apple.com/us/app/%E4%B9%A0%E6%83%AF%E5%B2%9B/id1673628986?uo=4) | 广博 郝 | 557 | 1673628986 |
| [习惯打卡 - 自律计划与时间管理日历](https://apps.apple.com/us/app/%E4%B9%A0%E6%83%AF%E6%89%93%E5%8D%A1-%E8%87%AA%E5%BE%8B%E8%AE%A1%E5%88%92%E4%B8%8E%E6%97%B6%E9%97%B4%E7%AE%A1%E7%90%86%E6%97%A5%E5%8E%86/id1327237799?uo=4) | Shanghai Yoobingo Information Technology Co. Ltd. | 20,309 | 1327237799 |
| [习惯点点-打卡养成好习惯](https://apps.apple.com/us/app/%E4%B9%A0%E6%83%AF%E7%82%B9%E7%82%B9-%E6%89%93%E5%8D%A1%E5%85%BB%E6%88%90%E5%A5%BD%E4%B9%A0%E6%83%AF/id6473467524?uo=4) | Shanghai Xiandi Network Technology Co., Ltd | 551 | 6473467524 |
| [元气习惯打卡](https://apps.apple.com/us/app/%E5%85%83%E6%B0%94%E4%B9%A0%E6%83%AF%E6%89%93%E5%8D%A1/id1504686642?uo=4) | 波 杨 | 736 | 1504686642 |
| [大女主打卡-自律打卡,游戏化角色扮演自动生成每日计划](https://apps.apple.com/us/app/%E5%A4%A7%E5%A5%B3%E4%B8%BB%E6%89%93%E5%8D%A1-%E8%87%AA%E5%BE%8B%E6%89%93%E5%8D%A1-%E6%B8%B8%E6%88%8F%E5%8C%96%E8%A7%92%E8%89%B2%E6%89%AE%E6%BC%94%E8%87%AA%E5%8A%A8%E7%94%9F%E6%88%90%E6%AF%8F%E6%97%A5%E8%AE%A1%E5%88%92/id6470770922?uo=4) | Shanghai Duimi Internet & Technology Co. Ltd. | 1,050 | 6470770922 |
| [小习惯打卡-日常习惯养成与时间管理](https://apps.apple.com/us/app/%E5%B0%8F%E4%B9%A0%E6%83%AF%E6%89%93%E5%8D%A1-%E6%97%A5%E5%B8%B8%E4%B9%A0%E6%83%AF%E5%85%BB%E6%88%90%E4%B8%8E%E6%97%B6%E9%97%B4%E7%AE%A1%E7%90%86/id1439928374?uo=4) | xiaorichang Technology Co., Ltd. | 11,411 | 1439928374 |
| [小光芒-自律打卡 专注计时器](https://apps.apple.com/us/app/%E5%B0%8F%E5%85%89%E8%8A%92-%E8%87%AA%E5%BE%8B%E6%89%93%E5%8D%A1-%E4%B8%93%E6%B3%A8%E8%AE%A1%E6%97%B6%E5%99%A8/id1580848041?uo=4) | Wuhan nine point mutual Entertainment Technology Co., Ltd. | 2,334 | 1580848041 |
| [心晴计划-日常计划、Project50自律健身打卡、习惯养成](https://apps.apple.com/us/app/%E5%BF%83%E6%99%B4%E8%AE%A1%E5%88%92-%E6%97%A5%E5%B8%B8%E8%AE%A1%E5%88%92-project50%E8%87%AA%E5%BE%8B%E5%81%A5%E8%BA%AB%E6%89%93%E5%8D%A1-%E4%B9%A0%E6%83%AF%E5%85%BB%E6%88%90/id6738903392?uo=4) | Xian Guosheng Likang Information Technology Co., LTD | 4,717 | 6738903392 |
| [日常打卡 - 减肥打卡等计划提醒](https://apps.apple.com/us/app/%E6%97%A5%E5%B8%B8%E6%89%93%E5%8D%A1-%E5%87%8F%E8%82%A5%E6%89%93%E5%8D%A1%E7%AD%89%E8%AE%A1%E5%88%92%E6%8F%90%E9%86%92/id1420337677?uo=4) | 振秋 吴 | 6,736 | 1420337677 |
| [柠檬点点-自律打卡软件](https://apps.apple.com/us/app/%E6%9F%A0%E6%AA%AC%E7%82%B9%E7%82%B9-%E8%87%AA%E5%BE%8B%E6%89%93%E5%8D%A1%E8%BD%AF%E4%BB%B6/id1458927807?uo=4) | Chengdu Ningmengyoumeng Science & Technology Co., Ltd | 2,744 | 1458927807 |
| [点点时光-习惯养成打卡软件](https://apps.apple.com/us/app/%E7%82%B9%E7%82%B9%E6%97%B6%E5%85%89-%E4%B9%A0%E6%83%AF%E5%85%BB%E6%88%90%E6%89%93%E5%8D%A1%E8%BD%AF%E4%BB%B6/id1625287412?uo=4) | Shanghai Rui Qi Man Technology Co., LTD | 1,098 | 1625287412 |
| [达目标 - 番茄todo与喝水提醒](https://apps.apple.com/us/app/%E8%BE%BE%E7%9B%AE%E6%A0%87-%E7%95%AA%E8%8C%84todo%E4%B8%8E%E5%96%9D%E6%B0%B4%E6%8F%90%E9%86%92/id1235379622?uo=4) | Shanghai Yoobingo Information Technology Co. Ltd. | 55,169 | 1235379622 |
| [오늘의목표 - 목표 습관 루틴 챌린지 관리](https://apps.apple.com/us/app/%EC%98%A4%EB%8A%98%EC%9D%98%EB%AA%A9%ED%91%9C-%EB%AA%A9%ED%91%9C-%EC%8A%B5%EA%B4%80-%EB%A3%A8%ED%8B%B4-%EC%B1%8C%EB%A6%B0%EC%A7%80-%EA%B4%80%EB%A6%AC/id1542510906?uo=4) | Sangyun Cho | 5,474 | 1542510906 |

## Historical listing and the user's identity lead

**HabitHub — Habit & Goal Tracker**, package `com.rstudioz.habits`: its current US Play detail page did not return a listing. [AndroidRank's historical record](https://www.androidrank.org/application/habithub_habit_goal_trackr/com.rstudioz.habits) attributes 1,000,000+ installs to Google Play. This is historical secondary evidence, separate from the current verified-band list; current availability and the removal date are not independently established. A different current app named Habit Hub is not automatically the same product.

The user corrected the example's name to **“App Stick.”** Possible names encountered are **STICK: Routine Accountability**, Apple ID `6754049782`, and **Habit Tracker - Habstick**, Play package `com.habit.habstick` (50K+ band). Their resemblance to the spoken name does not establish identity. HabitKit is also retained as its own product. The Reddit post and multilingual-page explanation are unverified user-supplied leads; they are not research findings here. The user will direct growth-year, download-surge and founder-story investigation after reviewing the list.

## Validation and remaining gaps

Validated unique platform/store-ID keys, qualifying download figures at least 10,000, exact agreement between Apple sums and per-country evidence, and distinct statuses for official store bands, estimates, founder inference and unknown downloads. All local deliverable links resolve. `git diff --check` and `iOS/Tools/perf/check_rules.sh` passed. No app code changed and no CI was dispatched (Rulebook T7/W2/W4).

Remaining: establish lifetime download qualification for the 136 prioritized Apple candidates; review the unprioritized discovery queue; broaden historical/delisted coverage; verify the identity of App Stick. The list is ready for review with these gaps visible. Exhaustive coverage and download qualification for the remaining candidates are not established.
