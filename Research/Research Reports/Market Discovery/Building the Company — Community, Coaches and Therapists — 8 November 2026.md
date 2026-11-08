# Building the Company: Community, Coaches and Therapists, Without Ads or Selling Data

Written by Claude (Claude Code), 8 November 2026, at the user's request: "how can we make this like a big company? In the
long run, and have a massive profits … consider today's reviews … do some thorough research."

**The ask, in the user's words (condensed):** the habit app stays free apart from one-time Plus (sync), and may only break
even. A large community of ADHD and productivity people should form around it. Later, coaches and therapists become the
paying customers: they find clients and manage them on a separate, paid platform. Users pay nothing more. Companies may
buy it later. No ads, no selling data, ever, and nothing that's legal but wrong: "once if we break some trust, it's gone."
Plan it from day one so the later steps are easy.

---

## 1. The short answer

1. **Don't start with a marketplace. Start with the tool professionals already need, and let them bring their clients.**
   Therapists, psychologists, counsellors and coaches already recommend habit and self-care apps to their clients and use
   them themselves (users show: 233 reviews in our corpus, most of them about Finch; §3.1). What they lack is a way to
   *see* how a client is doing between sessions, and clients struggle to *show* them (§3.2). A coach's view of a
   client's habits, shared only with the client's consent, is the first thing to sell.
2. **Each professional who uses it brings clients into the free app; those clients make the community; the community
   then attracts more professionals.** That's the flywheel. Finding clients (the directory) comes after the tool, once
   there are enough people on both sides; coaches' own numbers say growth comes from more clients, not higher fees (§4).
3. **The free community lives on what professionals and companies pay**, not on users. A text community costs about
   2 cents per active person a year on Cloudflare (from the earlier server costing), so the free side can stay open to
   everyone. Video stays its own product with its own subscription.
4. **What makes a community work here (users show):** people like them (ADHD, no shame), doing things together (live
   sessions, body doubling, shared routines), support that's optional. **What kills it:** being pushed to add friends,
   public by default, sharing nags, notifications from boards, and any privacy leak (§3.5).
5. **Revenue that never touches ads or data:** the professional platform (monthly), the directory (a flat listing fee,
   never ranking for money), programmes made by professionals (they earn, we share), the video co-working subscription,
   the toolkit bundle, and later company plans (§6).
6. **Three hard limits to plan for now:** health-data law the moment a therapist sees a client's data (§5.3); Apple bans
   "random or anonymous chat", so strangers meet only in scheduled, accountable sessions (§4); and moderation is a job,
   not a feature (§5.4).

---

## 2. Who the customer is, phase by phase

| Phase | Who pays | What they pay for | What users get, free |
|---|---|---|---|
| **0. Launch** | Users, once | Plus: sync across devices | The whole habit app on one phone |
| **1. Community** | Nobody new | — | Templates, guided habits, live sessions, a buddy by invite |
| **2. Professionals' tool** | Coaches first, then therapists | Seeing clients' shared progress, assigning routines, check-ins | "Share with my coach" |
| **3. Finding clients** | Professionals | A listing in the directory | Finding a coach or therapist who fits |
| **4. Companies** | Employers, schools, clinics | Seats for staff or students; packages with coaches | The same app through their employer |

The order matters: each phase is built on people the phase before brought in.

---

## 3. What the reviews show

**Method.** A machine census over every review we hold: **2,437,401 reviews** in 341 corpora (App Store, Play, and the
ADHD set collected 7 Nov 2026), English patterns only, so non-English reviews are under-counted. Then about **380
matching reviews read by hand**, a random sample per theme. The census counts and the hand reading are kept apart below;
the counts are small shares of a huge corpus, so the hand-read examples carry the meaning. Script and samples:
`Research/Temp/community-coach-scan.py`, `community-coach-scan.json`, `community-coach-samples-2.txt` (not in git).

| Theme (machine census) | Reviews | Mean ★ | Where most come from |
|---|---|---|---|
| A professional recommended the app | 233 | 4.75 | Finch 147, Goblin Tools 8, Fabulous 7 |
| Wants to show or share progress with a professional | 46 | 4.35 | Bearable 13, Finch 7, Hevy 6 |
| Likes the app's community | 547 | 4.80 | Finch 136, Habitica 72, Hevy 62, Fabulous 53 |
| Asks for a community, friends or a buddy | 187 | 4.22 | Finch 29, Hevy 12, Forest 12, Fabulous 11 |
| Doesn't want social, or found it toxic | 45 | 2.84 | Finch 6, Fabulous 6, Any.do 5, Hevy 4 |
| Body doubling or focusing together | 547 | 4.55 | Forest 93, dubbii 162 (both stores) |
| Human coaching | 404 | 4.33 | Fabulous 249, Shimmer 26, Inflow 22 |
| The price of coaching or therapy | 51 | 3.53 | Fabulous 20, Finch 8, Inflow 8 |
| Distrust: selling data, data mining | 204 | **2.14** | Alarmy 30, Focus Friend 15, Any.do 13 |

### 3.1 Professionals already hand these apps to their clients

Users show professionals acting as the distribution channel, and using the apps themselves:

- "I'm a counsellor and recommend this often!" (`12520713164`, 5★, Finch)
- "As a psychologist I regularly recommend this to clients and use it myself." (`14141252844`, 5★, Finch)
- "My therapist uses it now too and suggests it to their clients." (`13208079089`, 5★, Finch)
- A client told their psychiatrist about the app, "and she started recommending it to her other patients"
  (`8736352397`, 5★, Finch).
- "I'm a certified life coach and have tried many apps for me and my clients." (`11926468207`, 5★, Finch);
  "I am an online personal trainer and life coach and will be referring all my clients to this" (`6456477215`, 5★,
  Fabulous); "As a therapist … recommending it to the teens I work with" (`8254499016`, 5★, Finch).

The ledger already says so at scale: discovery runs through therapists in the US (C058; report 10 counted 381 Finch
reviews involving a clinician; report 23, therapists recommending Streaks to ADHD clients, 28 reviews, mean 4.50). And it
cuts both ways: two clinicians publicly withdrew their recommendation over data loss (C058).

**What it means:** professionals will promote a tool that helps their clients and makes them look good. Give them a
reason to send *every* client to our app, and the app grows through them.

### 3.2 Clients want to show a professional how they're doing, and it's clumsy

- "this app makes it super easy to show my therapist what I've been up to — or not — without feeling awkward or ashamed.
  I can just hand over my phone" (`12380466645`, 5★, Habit Tracker).
- Bearable's reports "are wonderful to show at monthly doctor visits" (`8749516172`); "I can also share this information
  with my therapist to look for patterns" (`12144181205`); a physical therapy patient shows Strides' record at sessions
  (`1790935993`); Loop tracks headaches "to accurately show my doctor" (`b79cc60b-17a7-4610-9681-5feda16792c3`).
- The gaps: "I just wish I could share my info easily with my health provider" (`9722341012`, Bearable); "a feature to
  share … with a therapist" (`8055706016`, Finch); "provide ability to share with a parent or coach"
  (`ae90c0f0-8eab-46f9-8a9c-eabfe2835b30`); "still can't share days workouts pdf with my coach"
  (`82010401-26cf-4515-a098-2f0d18d5801c`, Hevy, paid); "Doesn't print out so it's worthless to me" (`9103825889`).

**What it means:** sharing with a professional is wanted by the people who have one, and almost nobody does it well.
It's also the bridge to phase 2: the same share that a client sends today as a PDF becomes, later, a live view in the
coach's dashboard.

### 3.3 Human coaching is valued, but price and pushing destroy trust

- Valued: "I have a coach who checks in on me weekly and I can chat with them anytime" (`8709869013`, 5★, Inflow);
  "I was debating getting an ADHD coach but was put off by the cost … the lessons and coaching in this app have been
  extremely helpful" (`8717711961`, 5★, Inflow).
- Priced out: "$230 per month for weekly 30 minute sessions … I'm just not paying" (`ac91624e-0846-45a6-a5cd-91e3ff7aa03f`,
  Shimmer); "£40 a month?! … borderline exploitative of vulnerable" (`12337713818`, Inflow).
- Pushed: a coaching advertisement on the main page that "Can’t get rid of" (`13056549153`, 1★, Fabulous); charged
  "$104 AUD immediately for a coaching session I had no interest in" (`11963996531`, 1★); "offer everything except the
  1 on 1 coaching at a much lower cost and use the coaching as an opt in" (`d44f1983-06f5-4846-843d-2c8ed5833866`, 1★,
  Inflow).
- Cheaper group formats land well: one reviewer who found 1:1 coaching poor value liked "the community aspect … the
  courses … and the zoom 'drop-ins'" (`9731428125`, 2★, Inflow).

**What it means:** never sell coaching inside the habit app by pushing it. A person finds a coach because they went
looking (the directory), or because their coach invited them. Never the other way round.

### 3.4 Therapy is out of reach for many, and they say they're still looking

- "it's hard to find therapist and having the money for it" (`9210739816`, Finch); "a great stopgap while I go try and
  find a therapist" (`9534613128`, Inflow); "until I found a Therapist, this gives me information" (`9974480611`, Numo);
  "I do therapy but don't have the resources to have as many sessions as I would like" (`8220436801`, Finch).
- One reviewer credits the app with finding the right therapist (`11296051077`, Me+).

**What it means:** people use our kind of app while they look for help. A trustworthy way to find a professional who
fits (ADHD-informed, in their country, in their price range) serves them and is what professionals will pay to be part
of.

### 3.5 Community: what people love and what drives them away

**Loved** (hand-read sample of 30 "community liked"; 29 of 30 at 5★):
- Supportive, no shame: "Motivating, but with grace. No shame. And the community is amazing." (`11704392329`, Finch)
- People who understand: Inflow's "community is so supportive" with "live events" to practise skills (`11394738899`).
- Doing things together, live: dubbii's "live Zoom calls are on another level in terms of connection, community, and
  validation" (`13249915082`); Habitica's "Great guilds to join" (`5c459860-1316-48fc-ab58-161ff0dc790f`).

**Asked for:**
- A buddy, even a stranger: "allows you to get paired up with someone random as accountability partners"
  (`9425481198`); "add friends at random and anonymously, vs just through my contacts" (`14191927107`).
- Communities for a situation: a sole caregiver for a spouse with terminal brain cancer, alone, left 1★ because there were
  "No In-App Communities" (`12678214054`).

**Drives people away** (all 45 "unwanted" read):
- Pushing: "Daily tasks won't stop asking me to add a friend … Clear cash grab" (`14230750728`, 1★); "back off the pushy
  'add a friend' quests … I am 50 years old" (`14127222200`); a parent who'd "prefer he not have spaces for social media
  type interactions yet at this age" (`13921510296`).
- Public by default: "my profile seems automatically added but this is not a social media app" (`11532068752`, Routine
  Planner); "I didn't know that it forced me to share my thoughts in a public feed. It doesn't matter that I am
  anonymous" (`107d8e20-6f9a-4667-9b9a-7eb9aa58aa27`, 21 Days Challenge).
- Nagging and noise: "constantly pesters me to share with friends" (`f8597664-4c89-4cc9-8fad-dc750d13b8a9`, Fabulous);
  discussion-board notifications that can't be turned off, so the person turned off all notifications and lost their
  routine reminders (`747cdb85-43ee-4457-bc37-f77d8631d591`).
- A privacy leak: people in anonymous fellowships shared Finch friend codes over Zoom, and Facebook then suggested them to
  each other by full name (`12992566522`, 1★). For a community of people with ADHD, depression or addiction, this is the
  worst thing that can happen.
- **Opting out is praised:** "I love that I don't need to use the social media part of it at all" (Hevy,
  `80f5339a-62a9-42a8-a30b-d4bdf867a4da`); "you DONT need to be friends with anybody"
  (`18fa37e2-c229-4334-a67e-0ebd22be9014`).

The ledger agrees: a light social layer that is "explicitly not a social network" (C202, 17 apps), no default-on feed in a
personal tool (C131), and let people hide social surfaces they don't use (C207, 9 apps).

### 3.6 Body doubling: doing it together works

547 reviews mention body doubling or focusing together, mean 4.55, most for dubbii and Forest. "Amazing little body
doubling buddy" (`26190905-2215-43ff-aab4-68dfafdfe6ad`, Focus Friend); one PhD student: "It effectively simulates body
doubling. I pay the yearly 15 dollars" (`5399a3d6-baa7-47e8-aa37-a7a707ec8608`). This is the video product's ground,
and the most natural shared activity for an ADHD community.

### 3.7 Distrust is fatal

The 204 reviews about selling data or data mining average **2.14★**. Even a paying Finch user asks: "Please don't sell my
data I pay for Finch Plus!!" (`11440482286`); another praises Finch because it "never sells your data" (`14136151685`).
Trust is a feature people notice and pay for.

---

## 4. What the wider market shows

| Fact | Source | What it means for us |
|---|---|---|
| **122,974 coach practitioners** worldwide (up 15% since 2023), **$5.34 billion** a year; **59% expect growth "driven more by increased clients and sessions rather than increasing their fees"** | [ICF 2025 Global Coaching Study](https://coachingfederation.org/blog/coaching-industry-continues-global-growth-with-5-34-billion-usd-revenue-new-research-reveals/) (read live) | Coaches grow by finding clients. That's what they'll pay for. |
| A Psychology Today therapist listing costs **$29.95 a month**, no contract | Reported by [Klarity](https://www.helloklarity.com/post/is-psychology-today-worth-it-for-prescribers/) and [Brex](https://www.brex.com/tools/charge-finder/psychology-today); the signup page refused our request | Professionals already pay a monthly fee just to be findable. |
| Practice software for therapists: **SimplePractice $49–99** a month; for coaches and wellness: **Practice Better $35–155** | [PricingSaaS](https://pricingsaas.com/companies/simplepractice), [Capterra](https://www.capterra.com/p/159263/Better/pricing/) (third-party; check before relying) | What a professional pays to manage clients. Ours would cover a narrower job (habits between sessions) and should cost less. |
| **Focusmate:** free 3 sessions a week; **$8 a month** billed yearly or $12 monthly; a **Business** plan for companies and learning communities | [focusmate.com/pricing](https://www.focusmate.com/pricing/) (read live) | The video product's model is proven, including selling to organisations. |
| **About 15.5 million US adults** had a current ADHD diagnosis in 2023 (6%); more than half diagnosed as adults; about a third getting no treatment | [CDC MMWR, Oct 2024, via HealthDay](https://www.healthday.com/healthpro-news/neurology/155-million-adults-had-current-adhd-diagnosis-in-2023) | A large audience, much of it untreated and looking. |
| **BetterHelp paid $7.8 million** after the FTC alleged it shared health questionnaire answers and emails with Facebook, Snapchat and others for ads | [ABC News / AP](https://abcnews.go.com/Business/wireStory/betterhelp-customers-begin-receiving-refund-notices-78m-data-110025191) | The trust line the user drew is also the legal line. |
| **Apple 1.2:** apps with user content must filter objectionable material, let people report it with timely responses, let them block abusive users, and publish contact details. Apps used for **"random or anonymous chat"** or "Chatroulette-style experiences" **don't belong on the App Store** | [App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/) (read live) | A random-stranger buddy or video match must be scheduled, accountable and reportable, never anonymous roulette. |
| **Strava**, a fitness tracker built around its community, made an estimated **$490M** recurring revenue in 2025, about 90% from subscriptions | [Sacra](https://sacra.com/research/strava) (an estimate, not filings) | A tracker plus community can be a large company without ads. |
| Online communities face **five design problems**: starting one, attracting members, building commitment, getting contribution, and handling misbehaviour | Kraut, Resnick et al., *Building Successful Online Communities* (MIT Press) | Used as the checklist in §5.2. |

---

## 5. The plan

### 5.1 The flywheel

```
 Professionals use the tool  ──►  invite their clients into the free app
          ▲                                   │
          │                                   ▼
 more professionals join      ◄──  clients + everyone else form the community
 (to be found by them)              (templates, live sessions, support)
```

Why this order, reasoned from first principles: a marketplace with no professionals has nothing for users; one with no
users has nothing for professionals. A tool each professional finds useful **alone, with clients they already have**
needs neither side to exist first. Every professional who adopts it brings people in.

### 5.2 Phase 1: a community that isn't a social network

Built against the five problems (Kraut and Resnick), with what users show:

| Problem | What we do | Evidence |
|---|---|---|
| **Starting it** | Begin with things that are useful with zero other people: a library of templates and guided habits shipped in the app. Then live sessions hosted by us. | C202, §3.5 (live sessions loved) |
| **Attracting members** | People arrive through the habit app, social video and their professionals. Never through invite quests. | §3.1, §3.5 (pushy invites drive people away), C058 |
| **Commitment** | Small groups around a shared situation (newly diagnosed, students with ADHD, parents, caregivers), not one big feed. A buddy by invite, or matched only into a scheduled, reportable session. | §3.5 (`12678214054`, `9425481198`); Apple 1.2 |
| **Contribution** | Let people share a routine or template that worked for them, credited, copyable. Later, professionals publish programmes. | Report 18's praised "copy someone's routine" (C202) |
| **Misbehaviour** | Report, block, filter, published contact, real moderators. No public profile by default; no use of contacts or other social networks to connect people. | Apple 1.2, `12992566522` |

Rules for this phase: everything social is **off until the person turns it on**, can be hidden completely, sends no
notifications unless chosen, and never touches their habit data unless they share a specific item (C131, C207).

### 5.3 Phase 2: the professionals' tool

**For coaches first.** Coaching isn't a licensed profession in most places, so it can start sooner and with less legal
work. Therapists follow once the privacy groundwork in this section is done.

What a coach gets (a separate web app, paid monthly):
- **Clients join by invitation.** The client sees exactly what the coach will see and chooses it habit by habit. They
  can stop sharing at any time, and the coach's view stops with it.
- **Progress between sessions:** streaks, missed days, notes the client chose to share, without the coach chasing them.
- **Assign a routine or template** to a client; it appears in their app as a suggestion they accept or ignore.
- **Check-ins and session notes**, kept private to the coach.

Price, reasoned from the market: practice software runs $35–155 a month and does far more (billing, scheduling,
telehealth). A narrower tool should start lower, around **$15–30 a month per professional**, with a free tier for a
couple of clients so a coach can try it with real people. Illustration, not a forecast: 1,000 coaches at $25 a month is
$300,000 a year; 10,000 is $3 million. The ICF counts 122,974 coaches worldwide.

**Therapists and anyone licensed: what changes.**
- In the US, a therapist who keeps client health information in our system makes us their "business associate" under
  HIPAA: a signed agreement, security safeguards and breach rules. Health apps outside HIPAA still fall under the FTC's
  rules on health data. Europe treats health data as a special category under GDPR, and India's data protection law
  covers it too. Take legal advice before the first therapist uses it.
- The design that keeps this manageable: share a client's data **only by their explicit choice**, encrypt it, keep a log
  of who saw what, delete it when sharing stops. The habit app itself stays local-first, so "your habits never reach us"
  remains true for everyone who doesn't share.

### 5.4 Phase 3: finding clients (the directory)

- A professional creates a profile: specialties (ADHD, students, burnout), languages, country, price range, whether they
  take new clients. Credentials checked where a licence is claimed; coaches show their training openly.
- People search when they choose to, from a quiet place in the app (never a banner, never a nag).
- **How we charge: a flat monthly listing fee** (Psychology Today's $29.95 is the benchmark), **not** a cut of each
  session, and **never paid placement** dressed up as a recommendation. A flat fee means we never gain by pushing someone
  towards a particular professional or towards more sessions.
- Optional later: booking and payments, with the professional's fee shown openly.

### 5.5 Phase 4: companies

Once professionals and the community exist, the same pieces sell to organisations: seats for staff or students, group
sessions, a coach package. Focusmate already sells a Business plan for "enterprises, small businesses, learning
communities". Employers must only ever see totals (how many people use it), never anyone's habits.

---

## 6. What we can sell, and what we never will

| Revenue | Who pays | Phase | Trust check |
|---|---|---|---|
| Plus: sync across devices | Users, once | 0 | Already decided |
| Professionals' tool | Coaches, then therapists, monthly | 2 | Client consents to every item |
| Directory listing | Professionals, flat monthly | 3 | No paid ranking; no cut that rewards pushing |
| Programmes by professionals (a 30-day ADHD morning plan, say) | Users who choose one; the professional earns, we share | 2–3 | Labelled clearly as paid, with the author's name; previews free |
| Live workshops and group sessions | Users who choose one, or included in a pro's package | 1–3 | Free sessions stay free |
| Video co-working | Users, monthly (separate app) | Any | Free sessions each week, as decided |
| Toolkit bundle (app blocker and others) | Users | Later | One honest price |
| Company and school plans | Organisations | 4 | Totals only, never individuals |

**Never:** ads; selling, renting or "sharing with partners" any data; using contacts or other networks to grow; pushing
coaching or therapy inside the habit app; paid placement presented as advice; dark patterns at checkout (C285, C212);
locking people's own data behind a payment (Rulebook D10).

---

## 7. What to build into the app from day one

None of this needs a server at launch; it keeps the later phases from needing a rebuild.

1. **A progress report a person can share** (a PDF or image of chosen habits over a period), free. Users ask for exactly
   this (§3.2), it works with no account, and every report a therapist or coach sees carries our name: the start of the
   professional channel.
2. **Sharing chosen item by item** as the model in the data, from the start: a habit can be marked "shared with" someone
   later without changing how it's stored.
3. **Templates and guided habits as data** (a versioned file format), so the same format holds our library, a user's
   shared routine and a coach's assigned routine.
4. **An optional account layer**, designed now and built when the community starts: none for the habit app, one identity
   across the toolkit when someone wants sync, community, video or a coach.
5. **Two kinds of people in the design:** a person, and a professional who can be invited by a person. Never the other way
   round.
6. **Settings that can hide every social and professional surface**, before any exist (C207).
7. **The trust rules written into the Rulebook** (§6's "never" list), so no later agent or hire ships them by accident.

---

## 8. Risks

| Risk | Why it matters | What reduces it |
|---|---|---|
| Nobody on either side at first | The classic marketplace trap | The tool works for a coach with their existing clients; the directory waits |
| Moderation | Apple requires it; a toxic moment can sink an ADHD community | Small groups, report and block, real moderators, community off by default |
| Health-data law | A therapist using it brings HIPAA (US) and equivalents | Coaches first; legal advice before therapists; consent and encryption by design |
| Professionals of poor quality | Coaching is unregulated; a bad coach hurts people and our name | Check licences where claimed, show training openly, act on reports |
| The habit app gets cluttered | 149 MyRoutine reviews (C207) complained as features piled up | Everything social or professional is off and hidden until chosen |
| A conflict of interest | Earning per session would reward pushing people | Flat fees; no paid ranking |

## 9. What we can't know yet

How many professionals will pay, and at what price; whether coaches will move clients onto a new app; how big the
community gets. Watch, in order: how many people share a report with a professional (phase 0), how many professionals
ask for more than a PDF, how many clients each professional invites, and how many of those clients stay.

---

## Sources

Reviews: `Research/App Store Reviews/`, `Research/Play Store Reviews/`, `Research/ADHD App Reviews/` (every review ID
above is in its corpus's `reviews.jsonl`). Ledger cards: C015, C058, C131, C202, C207, C212, C285 in
[Feature Ledger](<../Feature Ledger.md>). Server costs: [Server Cost and Capacity](<../../../Architecture/Server Cost and Capacity — Free Safety Copy vs Plus Sync.md>)
and this session's Cloudflare pricing check (8 Nov 2026).

Web, read 8 November 2026:
- [ICF 2025 Global Coaching Study release](https://coachingfederation.org/blog/coaching-industry-continues-global-growth-with-5-34-billion-usd-revenue-new-research-reveals/)
- [Apple App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [Focusmate pricing](https://www.focusmate.com/pricing/)
- [BetterHelp FTC refunds (AP via ABC News)](https://abcnews.go.com/Business/wireStory/betterhelp-customers-begin-receiving-refund-notices-78m-data-110025191)
- [15.5 million US adults with ADHD (HealthDay, on CDC MMWR)](https://www.healthday.com/healthpro-news/neurology/155-million-adults-had-current-adhd-diagnosis-in-2023)
- [Psychology Today listing price (Klarity)](https://www.helloklarity.com/post/is-psychology-today-worth-it-for-prescribers/), [Brex charge finder](https://www.brex.com/tools/charge-finder/psychology-today)
- [SimplePractice pricing (PricingSaaS)](https://pricingsaas.com/companies/simplepractice), [Practice Better pricing (Capterra)](https://www.capterra.com/p/159263/Better/pricing/)
- [Strava revenue estimate (Sacra)](https://sacra.com/research/strava)
- *Building Successful Online Communities*, Kraut, Resnick et al., MIT Press ([publisher listing](https://mitpressbookstore.mit.edu/book/9780262528917))
