# oftenenough.com

The website: static HTML on Cloudflare Pages, project `oftenenough` (`oftenenough.pages.dev`), Direct Upload, not Git integration. No frameworks; one small inline script on the homepage. What it must say and how it's built: [Website Build Notes](<Website Build Notes.md>). What's done: [Website Reset Checklist](<Website Reset Checklist.md>). Figma: [Design-System](https://www.figma.com/design/DCLa48e0M68Y2miWj8OoiN/Design-System), pages `website` and `archive`.

## Build and check

```sh
python3 website/build.py                      # website/src → website/public (public is wiped each time)
npx wrangler pages dev website/public --port 8788 --ip 127.0.0.1     # restart it after a script change: it reads _headers only at start
export PLAYWRIGHT_PATH=<a folder with playwright-core>
node website/tests/responsive-check.mjs http://127.0.0.1:8788 / /privacy /support /terms /404   # 14 widths: errors, sideways scroll, clipped text, tap targets
node website/tests/device-check.mjs http://127.0.0.1:8788        # the store button per device, no script, the live count, reduced motion
```

`src/pages/` holds each page, `src/parts/` shared mock-ups, `src/site.css` the one stylesheet, `src/static/` files copied as they are (`_headers`, `_redirects`, `robots.txt`, `llms.txt`, icons, fonts, `og.png`), and `src/icons.json` the Material Symbols the site draws (add more with `fetch_icons.py`). `build.py` writes `sitemap.xml` and fills in the script's hash in `_headers`.

**Store links:** set `STORES` at the top of `build.py` when a listing is public; the buttons change from "Coming soon to…" to real links.

**A new page:** add it to `PAGES` in `build.py`. The footer and closing links appear by themselves once their page exists.

## Publish (only when the user says)

From the repository root, signed in to Wrangler:

```sh
npx wrangler pages deploy website/public --project-name oftenenough --branch main --commit-dirty=true
```

Not `wrangler deploy`: that's for Workers. The old development Worker (`oftenenough-site`, site-dev.oftenenough.com) was deleted on 4 November 2026; its `wrangler.jsonc` is in git history.

## History

The 15 October verification release is in [Verification Deployment.md](<Verification Deployment.md>), and its build and check scripts and the older account-based website are in git history before 4 November 2026. `Design Assets/`, `Design Previews/`, `Design Handoff.md` and `Design Manifest.json` are from the earlier design: reference only.
