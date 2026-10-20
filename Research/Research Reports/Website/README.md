# Often Enough Website — Research and Design Brief

Written by Codex, 12 October 2026. Current Work 93; proposal for review, not a settled product decision or implemented website.

## What visitors need

“Will this help me keep the habits I want, without making my day harder?” Then: “Does it work on my device, what is free, and can I trust it with my history?” Lead with **Habit tracker for your real life**. Show flexible goals, simple logging, routines and progress; then explain privacy, backup and cost. Download is the goal; unavailable platforms get honest release states.

This synthesizes earlier research, primary guidance and design hypotheses. No fresh corpus audit, experiment, new review totals or conversion forecast. [Feature Ledger](<../Feature Ledger.md>) C002 (offer/trust), C040 (widget reliability) and C188 (offline launch) support clarity and reliable convenience; their attributed earlier evidence stays distinct (W2).

[NN/g homepage principles](https://www.nngroup.com/articles/homepage-design-principles/) supports clear purpose/content/action. Applied here: descriptive hero, product proof, one download journey. [Homepage Design: 4 Common Mistakes](https://www.nngroup.com/videos/homepage-design-mistakes/) identifies false floors, unclear scroll cues, unfamiliar conventions and weak hierarchy; accessible summary reviewed, not video stream. [Google mobile-speed study](https://web.dev/case-studies/milliseconds-make-millions) relates speed to retail/travel behavior; no percentage uplift is transferred to this app.

## References and access limits

| Reference | Inspection |
|---|---|
| Store Inspiration 1 `1182:9409` / `1182:9420` | Render inspected: pale gray, black/gray massive type, sticker detail and layered phone. Follow visual language without copying artwork (D11). |
| Store screenshots `1206:2` | First render, editable headings and native-image metadata inspected: SF Pro Heavy, neutral field, colors inside habits. |
| Website `1268:11391` / `1268:11395` | Both renders inspected: Payr dimensional phone/cards; Pathio clear central promise. Exclude cyan/blue and invented social proof. |
| [Payr Dribbble](https://dribbble.com/shots/27168202-Payr-Rent-Payment-Website) | HTTP 405; supplied Figma still inspected. Animation unavailable. |
| [YouTube 1](https://youtu.be/DJMsXSr1jec) | Open/exact-ID searches attempted; challenge redirect, no title/video/transcript. |
| [YouTube 2](https://youtu.be/G-F5Qvy-7KM) | Title accessible: How I Build Insane Three.js Websites With Claude Opus 5. Video/transcript unavailable. |
| [YouTube 3](https://youtu.be/mhIAd5lVMag) | Title accessible: Everyone Builds 3D Websites with Claude Code. I Sell Them for $10K. Video/transcript unavailable. |

No techniques invented from titles. Accessible expert text: [Google animations](https://web.dev/articles/animations-guide), [MDN WebGL practices](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/WebGL_best_practices), [reduced motion](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-reduced-motion). Unavailable playback is an explicit research limitation.

## Messages and factual boundaries

Code/spec anchors: `HabitStore.swift` (5 free active habits), `PlusScreens.swift` (unlimited, other devices, one-time purchase), D1/D4/D5/D15/D16/U3/U14/U30/U35 and [Android plans](<../../../Android/Docs/README.md>). Code presence is not store release.

- Flexible frequency: “Call family · 3 times a week”; no perfection/shame/outcome guarantee (U3).
- Checks, amounts, timers, steps, quit/cut-down and tasks: demo values, no treatment claims.
- Routine, widgets, reminders: show action meaning, no automatic completion claim.
- Week/month progress, history and notes: no fabricated customer success.
- Records on device and in own iCloud/Drive: we never receive habit records (D16). Hosting/support/purchase metadata separate; no “no servers anywhere” claim.
- Free 5 active habits, Plus unlimited, one-time purchase and Apple Family. No fixed regional price, discount, countdown or surprise subscription.
- Apple phone/tablet/watch; Android phone then Wear OS/tablet; desktop planned. No dates or Windows/Linux promise. Apple starter currently says coming soon; keep prelaunch until live URLs verified.

No live iCloud-to-Drive sync claim: export/import bridges platforms (D15/D16). Successful Drive prototype does not establish completed Android app. Watch/other-device Plus scope belongs on Download/Plus.

## Sitemap and conversion proposal

| Route | Job/content |
|---|---|
| Home `/` | Promise → flexible goals → logging → routines/widgets → privacy → devices → Free/Plus → FAQ → download. |
| Download `/download` | Apple/Android/Desktop selector, status, phone/tablet/watch relationship; prelaunch and future live-store states. |
| Plus `/plus` | Free/Plus/Plus Family, in-app buying, restore and localized price guidance. |
| Privacy `/privacy` | Device/cloud flow, export/delete, diagnostics/web logs separately; final text matches shipped implementation. |
| Help `/help`, preserve `/support` | Goals/logging, reminders/widgets, backup/restore, purchases, availability and support. |
| Terms `/terms` | Readable policy layout and section outline; final legal text/review pending. |
| Existing `/delete-account` | Preserve account action/confirmation; reconcile old server-habit wording. |
| Existing 404 | Home/Help recovery. |

Features stay on Home, About in footer, release notes after releases, no empty blog. Header: Features, Devices, Plus, Help, Get the app. Footer: Privacy/Terms/delete account. Mobile: logo, CTA, 44px Menu. Include menu/FAQ states. No fake ratings/counts/testimonials/awards or email gate before a download. Release-update form is a design specimen until opt-in/storage/unsubscribe exists. No email collected/sent now.

## Device assets

[MDN UA guidance](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Browser_detection_using_the_user_agent) warns browser strings are unreliable: Safari is not proof of iPhone, Chrome not proof of Android. Reasoned proposal: neutral initial HTML, visible Apple/Android/Desktop choice, optional OS hint for CTA only, manual override always wins. Fetch only chosen asset URLs. Unknown desktop shows all; Android gets coming-soon rather than App Store dead end. OS choice never decides graphics safety.

Phone dominates hero; iPad/Watch appear lower. Mobile stacks smaller cards instead of loading huge multi-device art. Watch is Plus; Wear OS planned. Replace labeled illustrative Android artwork with native output when built.

## Visual and performance proposal

Grayscale chrome, off-white, near-black ink, muted headline phrases, rounded real-life sticker. Exact approved tonal logo with preserved seams/tilt, no thick 3D edges (U29). Figma SF Pro matches store; web native system font avoids redistribution/blocking fonts. Habit colors remain inside product (U2).

The first pass's simplified product illustrations were rejected by the user as wireframe-like. [Hero Round 02](<Hero Revision — Native Product and Neutral Design.md>) replaces the four Apple Home heroes with existing native Today/WidgetKit captures and the store seedling. Website text/actions remain editable; native app screenshots are intentional content explicitly authorized by the user. Other product illustrations and sections remain draft work to revise. Capture provenance is simulator output, not physical-device photography; current-build/real-device checks remain distinct.

[Hero Round 03](<Hero Round 03 — What Visitors Need First.md>) supersedes that hero composition: Today/progress benefit, truthful five-habit/one-time offer, one unobstructed native app in sourced hardware, and no widget/caption/backing panel or release announcement. The current hardware stays upright and static; the earlier tilt/hover storyboard is historical and does not apply to this sourced bezel. Visitor priorities are reasoned from app reviews and homepage guidance, not measured arrival data.

Recommend **static dimensional artwork plus bounded CSS motion**. Slim device edge, layered cards, soft light/shadow create depth. Baseline remains complete without JS/graphics, with reduced motion/Save-Data. [MDN WebGL guidance](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/WebGL_best_practices) documents resource limits/context loss; avoid dense phone canvas. [Google animation guide](https://web.dev/articles/animations-guide) favors transform/opacity over layout/paint work.

Touch/coarse-pointer, reduced-motion and Save-Data static. Fine-pointer desktop may reveal decoration once (180–240ms), tilt ≤3° only while hovered, stop on leave/offscreen/hidden. Content immediate. No perpetual floating, inertia, animated blur, autoplay, scroll hijack or page canvas. If later requested, live 3D is opt-in desktop, lazy engine, bounded canvas/DPR/resources, demand rendering and context-loss fallback; compare to static and remove if slower/unstable. Current design requires none.

[Google Web Vitals](https://web.dev/articles/vitals) targets: field LCP ≤2.5s, INP ≤200ms, CLS ≤0.1 at mobile/desktop 75th percentile. Not Figma measurements. Our proposed budgets: mobile initial ≤400KB compressed, selected hero ≤100KB, CSS ≤15KB, JS ≤20KB, no font/3D engine critical-path. Responsive images/fixed dimensions, lazy below-fold, one chosen asset set, HTML links/disclosures without JS, CDN cache; no animated large shadows/filters.

After implementation: 320/360/390 phones, 768/1024 tablet, 1440/1920 desktop; real old low-memory Android/iPhone SE/current devices; cold/warm/slow network, scrolling, repeated taps, rotation, background, reduced motion, Save-Data, no JS. ≥5 same-device cold sessions, latency/frame/memory/crash/reload/black-screen records. CPU throttling supplements real GPU/memory tests. Figma/device/runtime validation are separate (S2/U9).

## Existing site and approval gate

User confirmed **oftenenough.com**. Existing `website/public/` static starter includes policies/support/deletion/404; preserve routes (U5). README/privacy predates D16 and requires reconciliation before publication. No runtime/DNS/Cloudflare account changes in this phase. Design approval precedes development, store/support/policy verification, real-device testing and publication. [Handoff](<../../../website/Design Handoff.md>) records design links and validation.

## Current widget and Morning review

[Section 05](<Section 05 — Interactive Widgets.md>) adds the clean interactive widget catalogue and confirmed Free/Plus split, with a 22-record source-verified qualitative audit. All Home/Lock families are shown; source designs are editable, not new installed widget captures. Morning routine replaces Anytime using a faithful SwiftUI/Apple-component reconstruction, clearly documented as such. Current layouts/previews/provenance and release checks are in [the handoff](<../../../website/Design Handoff.md>). Design approval still precedes implementation.
