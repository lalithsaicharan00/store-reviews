# Store Buttons — One or Two

Written by Claude (Claude Code), 4 November 2026, at the user's request: do we need both store buttons, or one button that knows where to send someone?

## The answer

**One centred button on every known device, with the other store's link kept in the HTML.** This is the third version, decided by the user the same day: the first showed both buttons on every computer and on an iPad, and the second added a small "Also on iPhone" link on computers.

| Who is looking | What they see |
|---|---|
| Android phone, Windows | **Get it on Google Play** |
| iPhone, iPad, Mac | **Download on the App Store** |
| Anything else, or no script | Both buttons |
| A search crawler or AI tool reading the raw page | Both, as real links |

The user's point: show what can actually work on the device in front of us, and let the page look clean.

- **iPad:** it can only use the App Store, and it can be told from a Mac (it says it's a Mac, but has a touch screen). Our iPhone app can open on an iPad from the App Store even though we don't make an iPad app.
- **Windows:** Google Play's website can send an install to a signed-in Android phone from a computer (older guides; no current Google help page was found). Apple's web App Store is reported as browse only.
- **Mac:** no Android app runs there, and Mac owners are the likeliest to have an iPhone (reasoned, not measured).

**The cost, and how it's covered.** A computer tells us the computer, not the phone: StatCounter puts iOS at about 58% of US phones (June 2026), so many Windows owners carry an iPhone and won't see their store in the hero. They still reach it three ways: the top bar's Download goes to `/download`, which shows both stores on a computer; the footer has both; and the page's text says Android and iPhone. If Search Console or store numbers later show iPhone owners getting lost, bring back the small link (it's on Figma's archive page).

This is reasoned from first principles and official documents, not from reviews: no review talks about website buttons. **No test of one button against two was found.** Most advice on this is from vendors selling smart links.

## How it works

Both links stay in the page's HTML. A very small script in the page's `<head>` reads the device and marks the page; CSS then hides what doesn't apply, before anything is drawn, so nothing flickers. The code is in [Website Build Notes](<../../../website/Website Build Notes.md>).

**Anything that goes wrong shows both buttons.** No script or an unusual browser gets the same page crawlers get. That matters, because MDN warns that reading the browser's user agent is unreliable and a common cause of bugs. Here a wrong guess costs one extra button, never a dead end.

- **Nothing is sent or stored.** The check happens in the browser. No cookie, no analytics, no outside service.
- **The site's strict security header stays strict.** Today it says `script-src 'none'`. It changes to allow this one script only, by its hash (`script-src 'sha256-…'`), so no other script can run.
- **The footer always carries both stores.** A person on an Android phone buying for someone with an iPhone, or a wrong guess, still has a way out.
- **No server code.** Cloudflare's `_redirects` file has no way to redirect by device, so a redirect would need a Pages Function. The hero doesn't need one.

## Why not the other ways

| Option | Why not |
|---|---|
| **One "Download" button everywhere, redirecting by device** | On a computer it has nowhere right to go, so it needs a second page and a second click. It also hides that we're on both platforms, and the words no longer say where a tap leads. |
| **The server picks the page by device** | Google calls this dynamic serving and recommends responsive design instead. Crawlers read as a smartphone, so the raw HTML would lose one store's link. A static page also stops being one static page. |
| **Keep two buttons on phones** | Simplest, and fine for search. It only costs clarity: one button can't be wrong on a phone, and it shortens the hero by 68 px. |

## Search and AI tools

- **Not cloaking.** Google's policy is about different content meant to mislead people or search engines. Here a crawler sees what any phone of that kind sees, with nothing misleading. That's my reading: the policy doesn't mention buttons.
- **Links must be real.** Google only follows `<a href>`. A button that decides in a script (`onclick`) is a link Google can't crawl, which is the main reason not to build a single redirecting button.
- **A tool that reads the raw HTML without running scripts gets both links.** That's the point of the default being both.

## What other sites do

Checked on 4 Nov 2026: the raw HTML each site sends to Windows, Android and iPhone (18 sites), and what a real browser shows at Android phone size (6 sites). Ten of the 18 had no store link in their raw HTML, so the browser check matters more. This shows the pattern exists. It's no proof that it works.

| Site | On an Android phone |
|---|---|
| Strava | Google Play only (the server decides; a Windows browser gets both) |
| Finch | Google Play only (both are in the HTML; a script removes one) |
| Spotify | One "Download" button (a smart link) on an Android page |
| Duolingo | "Install" banner through a smart link, yet an App Store link still showed: the mistake the user describes |
| HabitKit | Both stores |
| Headspace | No store link; sends people to a web checkout |

## Store rules that affect the design

- **Our white buttons are plain words with no store logos, so they aren't badges.** That's how they stay in our style. If we ever want the logos, we must use the official badges unchanged: Apple says only its artwork, not modified; Google says no changing the colour or rearranging anything. **Never draw our own version with a logo.**
- If official badges are used side by side, Google asks for its badge to be the same size or larger than the others. Google's artwork sits behind a usage agreement on its Partner Marketing Hub.

## What else follows

- **The Download page uses the same script,** so a phone sees one button there too. If we ever print a QR code for computers, it can point at `/download`: one extra tap, and still no server code.
- **The top bar's Download** goes to the right store on a phone and to `/download` on a computer.
- **Apple's Smart App Banner** could be added after launch. Apple's page didn't load for this report, so check it first.
- **At build time:** see [Website Build Notes](<../../../website/Website Build Notes.md>).
- **Macs with Apple's own chips can run iPhone apps** unless the developer turns that off in App Store Connect (2020 reports; check the current setting). We're phones only (D16), so decide this when the iPhone app is submitted.
- **If one store goes live first,** the other phone's visitors need an honest "coming soon" in place of a dead link.

## Sources

- [Google: spam policies](https://developers.google.com/search/docs/essentials/spam-policies) · [Mobile-first indexing](https://developers.google.com/search/docs/crawling-indexing/mobile/mobile-sites-mobile-first-indexing) · [Crawlable links](https://developers.google.com/search/docs/crawling-indexing/links-crawlable)
- [MDN: browser detection using the user agent](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Browser_detection_using_the_user_agent) · [CSP script-src](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Content-Security-Policy/script-src)
- [StatCounter: US mobile operating systems](https://gs.statcounter.com/os-market-share/mobile/united-states-of-america) · [MacStories: Apple's web App Store](https://www.macstories.net/news/apple-recreated-the-app-store-on-the-web-with-no-way-to-download-or-buy-apps/) · [Make Tech Easier: installing Android apps from a PC](https://maketecheasier.com/install-android-apps-from-pc) · [iMore: iPhone apps on Mac unless developers opt out](https://www.imore.com/all-compatible-new-and-existing-iphone-and-ipad-apps-be-made-available-mac-unless-developers-opt-out)
- [Cloudflare: Pages redirects](https://developers.cloudflare.com/pages/configuration/redirects/) · [Functions routing](https://developers.cloudflare.com/pages/functions/routing/) · [Functions pricing](https://developers.cloudflare.com/pages/functions/pricing/)
- [Apple: marketing guidelines](https://developer.apple.com/app-store/marketing/guidelines/) · [Google Play: badges](https://partnermarketinghub.withgoogle.com/brands/google-play/google-play/lockups-icons-badges/#badges)
- Vendor guides, treated with care: [u2l.ai on app download QR codes](https://u2l.ai/blog/app-download-qr-code) · [1link on store redirects](https://1link.io/blog/app-store-redirects-one-link-for-ios-android-and-web/)
- Site check: `Research/Temp/website-store-buttons/ua.sh` (not in git)
- Earlier: [Hero Copy](<Hero Copy — What People Look For First — 4 November 2026.md>)
