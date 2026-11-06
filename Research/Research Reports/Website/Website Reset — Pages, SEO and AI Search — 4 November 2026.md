# Website Reset — Pages, SEO and AI Search

Written by Claude (Claude Code), 4 November 2026, at the user's request: research what the website needs before any design, with SEO and AI search as its main purpose. Design comes first; development waits for the user's approval.

**What this rests on.** The official pages of Google Play, Apple, Google Search, Cloudflare, OpenAI and llms.txt, read on 4 Nov 2026; live checks of oftenenough.com the same day; the Android code on `main`. Apple's 5.1.1 and 3.1.1 wording and the App Store Connect field table came through a summary of the page, so check them on Apple's site before submission. Most writing about "AI search" is by vendors selling it; where only vendors say something, this report says so.

**What it doesn't have.** No keyword volumes: no tool here gives them. The keyword list below is reasoned from what people ask, not measured. Search Console or Google's Keyword Planner has to confirm it.

## 1. The short answer

- **The website's job is to be found and to be quoted correctly.** Few people will browse it. Search engines and AI tools will read it, then send people to the stores.
- **Our real advantage is plain facts that few rivals can say:** pay once, no subscription, no account, no server of ours, habits stay on the phone and in the person's own Google Drive or iCloud. Reviews show "simple" and "no subscription" lead what people look for; privacy is rarely what they search for, so it supports the message rather than leading it ([Hero Copy](<Hero Copy — What People Look For First — 4 November 2026.md>)).
- **There is no special AI trick.** Google says plainly that nothing extra is needed for AI Overviews or AI Mode. Good crawlable pages win in both.
- **The biggest problem today isn't content. Cloudflare is turning away some AI crawlers** (§4).

## 2. What the rejection message actually says

The message asks for two things:

1. **"Current Address Proof is incomplete/missing details/pages."** The word *pages* here means pages of the address document, not website pages. No website page fixes this one.
2. **"Mobile Application(s) is not live/does not exist/not accessible."** The app has to be live on the store.

The message doesn't say who sent it. `Android/Docs/Google Play — Setup and Declarations.md` records a **BillDesk PA-CB KYC** submitted on 15 Oct 2026 with "Website given: www.oftenenough.com; app: the Play store link", so it's most likely that one. That's an inference. If it is, the reviewer will open the website, so it should show clear contact details, what is sold, the price and a refund policy. We build those anyway.

## 3. The pages we need

### Required by the stores

| Page | Who needs it | What it must do |
|---|---|---|
| **Privacy** `/privacy` | Google Play, Apple, Google sign-in screen | Public, not a PDF, not geofenced. Names the developer and the app. Gives a privacy contact. Lists what data is touched and who receives it, how it's kept safe, how long it's kept and how it's deleted. Must be linked in the store field and inside the app. An app that collects nothing still needs one. **The Android app already links to this exact address, so it must never move.** |
| **Support** `/support` | Apple (Support URL is required, and guideline 1.5 wants an easy way to contact you) | Real contact details, not only a form. |
| **Home** `/` | Google sign-in screen, Apple's optional Marketing URL | Must describe what the app does, identify it, and link to Privacy from the same domain. |

### Not required, but we should have

| Page | Why |
|---|---|
| **Terms** `/terms` | Already given on the Google consent screen. Covers the one-time purchase. |
| **Refunds** `/refunds` | Refunds belong to Google Play and Apple. Says so plainly, with the links. Payment reviewers look for this. |
| **Delete your data** `/delete-your-data` | **Replaces Delete account.** See below. |
| **Plus** `/plus` | What's free, what's Plus, one payment. |
| **Download** `/download` | Both stores from one link. |
| **About** `/about` | Who makes it. Google asks "who made this?" and warns against invented authors. Needs the user's name, if the user agrees. |

### Delete account: the user is right

**Update, 4 Nov 2026: the user dropped both Delete your data and Refunds.** Neither is required: there are no accounts, and both stores handle billing. Support answers both, and the old addresses redirect there. The rest of this section is kept as what was thought at the time.

Google requires an account-deletion link **only when the app lets people create an account**. Ours doesn't, so no deletion page is required. Apple's rule is the same.

We should still keep a short **Delete your data** page. Google's Data safety form still asks every developer about data deletion, and people do search for this. It explains three things: deleting from the phone, deleting the backup from their own Google Drive or iCloud, and that we hold nothing to delete. `/delete-account` should redirect there, because Play Console may still hold that link.

### What the Play Console still gets wrong

These were answered when the app had accounts, and they're out of date (from `Google Play — Setup and Declarations.md`). They aren't website work, but they must be fixed before production:

- **Data safety** still declares email, user IDs and purchase history, and "Account creation: OAuth", with the delete URL.
- **Sign in details** still mentions Google sign-in, QR codes, App Lock and Plus & Account.
- The **consent screen** note says "only basic scopes", but the app now asks for Google Drive's `drive.appdata` (`GoogleDriveLink.kt`, `build.gradle.kts`). Check the scope is listed, and that Privacy explains it. Google requires the policy to say how Google user data is accessed, used, stored and shared.

### The live site is wrong today

It still mentions iPad and Apple Watch features, Plus Family, supported free sync and an optional account. All of these are gone (Rulebook D16). It also shows a "Work in progress" banner on every page. It describes an app that no longer exists, so all of it gets rewritten, not patched.

## 4. What crawlers can do today

Measured on 4 Nov 2026 by asking oftenenough.com for its home page with each crawler's name. This shows how Cloudflare answers that name, not how a real crawler is treated in every case.

| Crawler | What it does | Today |
|---|---|---|
| Googlebot, bingbot, Applebot | Search | Allowed |
| OAI-SearchBot, ChatGPT-User | ChatGPT search, and pages a person asks for | Allowed |
| PerplexityBot, Perplexity-User | Perplexity | Allowed |
| Claude-SearchBot, Claude-User | Claude search | Allowed |
| **GPTBot** | OpenAI training | **Blocked (403)** and disallowed |
| **ClaudeBot** | Anthropic training | **Blocked (403)** and disallowed |
| **CCBot, Amazonbot, Bytespider** | Common Crawl, Alexa, ByteDance | **Blocked (403)** and disallowed |
| **Google-Extended** | Gemini training and grounding | **Disallowed** in robots.txt |
| Applebot-Extended, meta-externalagent | Apple and Meta training | Disallowed in robots.txt |

Cloudflare is adding these rules itself, in front of our own `robots.txt`, which only says allow everything. It also adds `Content-Signal: search=yes,ai-train=no,use=reference`.

**Recommendation: allow everything on this site.** It holds nothing private, and the whole aim is for AI tools to know the app. Training crawlers matter here: a model that has read the site can name the app with no search at all. Google also lists Google-Extended as the control for grounding, so blocking it may cost Gemini answers, not only training.

This is a Cloudflare setting (Security › AI Crawl Control and Bot Preference Sync). The Wrangler login can only read zones, so it needs the dashboard or the Cloudflare plugin through `/mcp`.

## 5. How to be found

### What is established

- **Google:** "no additional requirements" for AI Overviews or AI Mode, no special files and no special schema. Do normal SEO: allow crawling, link pages to each other, keep text visible, keep structured data matching the page.
- **Helpful content:** Google rewards original information and depth. It warns against mass-producing pages for search, summarising others and changing dates to look fresh.
- **OpenAI:** OAI-SearchBot decides whether a site appears in ChatGPT search.
- **Princeton's GEO study (KDD 2024):** page changes lifted visibility in generative answers by up to 40%, and results vary by subject. The abstract doesn't list the methods. Secondary summaries say statistics, quotations and cited sources did best; check the paper before relying on that.
- **Bing:** Webmaster Tools has reported AI citations since February 2026, in Copilot and partners. This is the only first-party AI citation report found.

### What is uncertain

- **llms.txt** is an informal 2024 proposal. Google says such files aren't needed, and no independent measurement shows it raises citations. It costs ten minutes, so we'll add one, and expect nothing from it.
- **FAQ markup:** Google ended FAQ rich results on 7 May 2026 (reported by secondary sources). FAQ text on a page still answers real questions. The markup is harmless but gives no special display.
- **Rich result for the app:** Google's SoftwareApplication result needs a rating or review. We have none yet, and **we must never invent one**. We add the markup without a rating, and add the real store rating once one exists.
- **Vendor figures** (citation rates, freshness percentages) aren't used here.

### What we'll do

**Technical**

- Static HTML, no JavaScript needed to read anything. Very fast on a cheap phone. Already how the site works.
- One address per page. Today `www.oftenenough.com` and `oftenenough.pages.dev` both serve full copies with no canonical tag, and the home page has no meta description. Add canonicals, send `www` to the bare domain and mark `pages.dev` noindex.
- Add `sitemap.xml` (404 today), `robots.txt`, `llms.txt` (404 today), a real 404, Open Graph images, an icon set.
- Structured data matching the visible page: Organization, WebSite, MobileApplication, BreadcrumbList, Article with a real author.
- `lastmod` and visible "Updated" dates only when a page truly changed.
- Search Console, Bing Webmaster Tools and IndexNow at launch.
- Keep the strict security headers. JSON-LD isn't executed, so `script-src 'none'` can stay.

**Content an AI can quote**

- Each page opens with a direct answer in one or two sentences.
- Headings are the questions people ask.
- **A plain "Often Enough facts" page:** price, platforms, what's free, what's in Plus, where data lives. One true source that AI tools can cite, and that stops them guessing.
- Facts come from the app's code, never memory (§6).

**Off the site, where AI tools mostly learn**

- A store listing that says the same things as the website.
- Being in "best habit tracker" lists, and honest posts in the places people ask. Search results for that query are dominated by dated roundups.

## 6. What the app does today (from the Android code)

Read from `Android/app/src/main`, 4 Nov 2026.

| Area | Fact | Source |
|---|---|---|
| Kinds | Check it off, Track an amount, Time it, Checklist, Cut down, Quit, Task | `ui/newhabit/Choices.kt` |
| Goals | By day, week, month or year | `data/Model.kt` |
| Your day | Morning, Afternoon, Evening, Anytime, with a guided routine player | `data/Model.kt`, `ui/player` |
| Widgets | One habit, Today (2 sizes), This week, Tasks (2 sizes) | `app/widgets/Widgets.kt` |
| Free | 5 habits, tasks, reminders, routine player, timer, quit and cut down, one-habit and Tasks widgets, backup, export, dark mode | `PlusScreen.kt`, Implementation — Up Next |
| Plus | Unlimited habits, Today and This week widgets, month and year views with Year in Pixels, checklist habits, Remind me again | `PlusScreen.kt` |
| Price | One payment, no subscription, no account. $29.99 today, **still open before launch**, so don't print it yet | `PlusScreen.kt`, Implementation — Up Next |
| Backup | The person's own Google Drive, plus backup files. iCloud on iPhone | `app/backup`, Rulebook D16 |
| Privacy | No ads (`AD_ID` removed). No analytics, crash or tracking SDK found in the dependencies. Network use is Google Drive and Play | `AndroidManifest.xml`, `build.gradle.kts` |

**Not to claim:** iPad, Apple Watch, Wear OS, tablets, desktop, Plus Family, accounts, moving by code, App Lock, How was today, Reports, other languages.

## 7. The site map

**At launch** (about 15 pages, each with a real reason to exist):

| Group | Pages |
|---|---|
| Core | Home, Features, Plus, Download, About |
| Trust | Privacy, Terms, Refunds, Delete your data, Support, Often Enough facts |
| What people search | Habit tracker with no subscription · Private habit tracker with no account · Habit tracker widgets · Quit and cut-down tracker |

**After launch**, led by what Search Console shows:

- **Android and iPhone pages**, once store links are live.
- **Guides**, one question each: weekly goals, skipping a day, how long a habit takes to form.
- **Our own research.** This is the strongest idea here: we hold a study of about 1.5 million habit-app reviews that nobody else has. "What makes people quit habit apps" and "How people lose their habit data" are original facts that writers and AI tools can cite. Every number must be checked against its report first (W2).
- **Honest comparisons and alternatives**, only when true and dated.

**Keywords to test** (not measured): habit tracker · habit tracker app · habit tracker no subscription · habit tracker one time purchase · habit tracker without account · private habit tracker · offline habit tracker · habit tracker widget · quit habit tracker · routine app with timer · weekly habit goals.

## 8. What the user has to do

- **Cloudflare:** allow AI crawlers (§4).
- **About:** decide whether the user's real name appears.
- **Support:** confirm `support@oftenenough.com` receives mail.
- **Launch:** Search Console and Bing Webmaster Tools need the user's Google and Microsoft sign-ins.
- **Play Console:** correct the answers in §3.

## Sources

- [Google Play: account deletion](https://support.google.com/googleplay/android-developer/answer/13327111)
- [Google Play: User Data policy](https://support.google.com/googleplay/android-developer/answer/10144311)
- [Apple: App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [Apple: platform version information](https://developer.apple.com/help/app-store-connect/reference/app-information/platform-version-information)
- [Google: OAuth app branding](https://support.google.com/cloud/answer/15549049)
- [Google Search: AI features](https://developers.google.com/search/docs/appearance/ai-features)
- [Google Search: software app structured data](https://developers.google.com/search/docs/appearance/structured-data/software-app)
- [Google Search: helpful content](https://developers.google.com/search/docs/fundamentals/creating-helpful-content)
- [Cloudflare: AI Crawl Control](https://developers.cloudflare.com/ai-crawl-control/)
- [Cloudflare: managed robots.txt](https://developers.cloudflare.com/bots/additional-configurations/managed-robots-txt/)
- [OpenAI: crawlers](https://developers.openai.com/api/docs/bots)
- [llms.txt proposal](https://llmstxt.org/)
- [GEO: Generative Engine Optimization](https://arxiv.org/abs/2311.09735)
- [Google ends FAQ rich results (Search Engine Roundtable)](https://www.seroundtable.com/google-drops-faq-rich-results-41298.html)
- [Bing's AI Performance report (Practical Ecommerce)](https://www.practicalecommerce.com/bings-improved-ai-performance-section)
