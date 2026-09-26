from pathlib import Path
import json, html

ROOT = Path(__file__).parent
rows = [
 dict(id='01-midnight-pastel', name='Midnight Pastel', title='CosyPOS – restaurant POS system', author='Dmitry Lauretsky / Ronas IT', shot='19061261-CosyPOS-restaurant-POS-system', likes=2114, saves=1570, views=465707, posted='2022-08-12', tier='First prototype', fit='High',
      look='Charcoal app background, lavender/mint/rose cards, dark text on coloured cards. Same design lo filled cards, dark cards with accent strips, compact rows anni kanipisthayi.',
      apply='Habit cards ki pastel fill; compact list lo colour strip; calendar lo ade accent; stats ki charcoal panels. Oka fixed card shape meeda depend avvadu.',
      sell='Mana card-based app ki strongest starting point. Night Lavender, Night Mint, Night Rose variants tho oka coherent pack cheyyachu. Basic dark mode free ga unchi, ee richer styling ni Plus lo pettali.',
      caution='Dense grid lo every card full colour ayithe hierarchy pothundi. Active/completed states ki fill + check mark rendu use cheyyali.'),
 dict(id='02-soft-pastel', name='Soft Pastel', title='Beauty & Face Care App', author='Ghani Pradita / Paperpillar', shot='15770373-Beauty-Face-Care-App', likes=1492, saves=793, views=288610, posted='2021-06-02', tier='First prototype', fit='High',
      look='Pale blue-white surface, peach and mint header panels, soft rounded cards, subtle line-art decoration.',
      apply='Whole app ki low-saturation base; habit cards ki tinted panels; header/card corners lo sparse doodles; charts and buttons ki matching accents.',
      sell='Peach, Mint, Lavender, Butter laanti variants ki useful reference. Calm/self-care positioning tho fit avutundi; popularity kooda strong.',
      caution='Shot lo text konchem faint ga undi. Mana version lo readable dark text, visible boundaries maintain cheyyali; source contrast ni blindly copy cheyyakudadhu.'),
 dict(id='03-playful', name='Playful Doodles', title='Habit Tracker Mobile IOS App', author='Purrweb; interface Olga Vorontsova, motion Alexey Luchin', shot='21367995-Habit-Tracker-Mobile-IOS-App', likes=1336, saves=959, views=224868, posted='2023-05-04', tier='First prototype', fit='Medium–high',
      look='Cream canvas, green character, simple habit rows, doodle marks and a celebratory completion screen.',
      apply='Normal rectangular cards/rows ni preserve chesi, corner sticker, custom completion mark and small celebration add cheyyali. Mascot ni every card lo pettalsina avasaram ledu.',
      sell='Flat palette kanna clear personality untundi. Garden Doodles, Little Stars, Tiny Creatures laanti original packs test cheyyachu.',
      caution='Existing character Mo ni mana asset ga use cheyyakudadhu. Illustration cost ekkuva; dense layouts lo decorative elements reduce cheyyali.'),
 dict(id='04-colour-notes', name='Gradient Cards', title='UI/UX Mobile App Design for a Notes AI App | Voice Journal App', author='Anna (asol_design)', shot='25578455-UI-UX-Mobile-App-Design-for-a-Notes-AI-App-Voice-Journal-App', likes=696, saves=69, views=59184, posted='2025-02-04', tier='Second prototype', fit='High',
      look='White workspace, pink-to-orange and blue gradient cards, matching pill controls, fine decorative line texture.',
      apply='Habit cards ki gradient fill; long rows ki narrow gradient stripe; progress bars ki solid coordinated accent. Background neutral ga undachu.',
      sell='Sunrise, Ocean, Lilac variants easy ga recognise cheyyagalige pack. Card skins ni whole-app redesign lekunda start cheyyadaniki useful.',
      caution='White text over light gradient readability test cheyyali. Likes strong, kaani saves 69 matrame; likes alone batti winner ani cheppalem.'),
 dict(id='05-honey', name='Honey & Sunshine', title='Habit Tracker Mobile App / Habithive', author='Ronas IT | UI/UX Team', shot='24147135-Habit-Tracker-Mobile-App', likes=627, saves=364, views=185795, posted='2024-05-13', tier='Explore', fit='Medium after adaptation',
      look='Honey-yellow gradients, cream/grey base, black labels, expressive bees and honeycomb habit tiles.',
      apply='Yellow palette, small bee/doodle, completion stamp teesukovali. Honeycomb ni fixed layout requirement ga teesukokunda normal cards meeda faint pattern ga adapt cheyyali.',
      sell='Named identity undi kabatti seasonal summer pack ga plausible. Plain yellow recolour kanna theme value clearer.',
      caution='Exact honeycomb layout user requirement ki suit kaadu. Our adaptation is a proposal; source itself is not layout-independent.'),
 dict(id='06-sage', name='Sage & Latte', title='freud v2: AI Mental Health Companion – Journal & Diary Overview', author='strangehelix', shot='25514838-freud-v2-AI-Mental-Health-Companion-Journal-Diary-Overview', likes=210, saves=120, views=24264, posted='2025-08-17', tier='Second prototype', fit='High',
      look='Warm off-white surfaces, brown typography, olive/sage accents, pill-shaped cards and soft shadows.',
      apply='Habit rows, calendar cells, charts and settings panels ki same cream/sage/brown system apply cheyyachu. Illustration optional.',
      sell='Calm, adult, less playful choice. Matcha, Oat, Terracotta laanti variants ki starting reference.',
      caution='Reference lo unna AI/health features ni recommend cheyyatledu; visual treatment matrame. Paper texture ee image lo strong ga ledu—texture add chesthe adi mana proposal.'),
 dict(id='07-journal', name='Illustrated Covers', title='#Exploration – Journal App', author='Paperpillar', shot='23854233--Exploration-Journal-App', likes=273, saves=113, views=79207, posted='2024-03-19', tier='Explore', fit='Medium',
      look='Plum/slate cards with large activity illustrations; card design detail screen header ki extend avutundi.',
      apply='Reading, walking, water laanti common habits ki original covers; user-created habits ki abstract fallback. Compact row lo same artwork thumbnail ga collapse avvali.',
      sell='Theme + habit cover bundle ga value visible ga untundi. Report lo photo-cover purchase evidence ki adjacent direction.',
      caution='Arbitrary habit names, long text, small widgets lo large artwork fit kaadu. Default minimal mode and hide-art option avasaram.'),
 dict(id='08-porcelain-teal', name='Porcelain & Teal', title='walden by oktavsoftware: Private Mood Tracking & Journal App UI', author='Samuel Oktavianus', shot='27467876-walden-by-oktavsoftware-Private-Mood-Tracking-Journal-App-UI', likes=186, saves=74, views=8961, posted='2026-06-23', tier='Explore', fit='High',
      look='Inspected image lo white rounded panels, fine grey borders, teal buttons and lavender highlights unnayi.',
      apply='Same surface/border/accent treatment lists, forms, cards, stats ki transfer avutundi. Selected states lavender, primary action teal.',
      sell='Clean premium option ga test cheyyachu; visual difference from a good free default takkuva undachu, so bundle lo supporting variant ga better.',
      caution='Source tags lo dark teal/gradient unnappatiki saved image light UI. Daanini dark-theme proof ga present cheyyatledu. Lower total reach; 186 likes cannot be equated to established demand.'),
 dict(id='09-luma', name='Dreamy Glass', title='Luma — Emotional Journal App Concept', author='Humbleteam', shot='27035792-Luma-Emotional-Journal-App-Concept', likes=103, saves=38, views=11902, posted='2026-01-30', tier='Explore', fit='Medium',
      look='Blurry pink/lilac photo backgrounds, milky cards, translucent floating controls.',
      apply='Background atmosphere + mostly opaque habit cards. List/grid/calendar same safe text surface use cheyyali. Optional blur/photo layer.',
      sell='Screenshot lo distinctive ga untundi. Dreamy Rose, Cloud Blue, Lavender Mist variants possible.',
      caution='Blurred headings and low-contrast body text ni copy cheyyakudadhu. Busy backgrounds and transparency valla dense stats readability taggochu; first release priority kaadu.'),
 dict(id='10-field-notes', name='Paper / Field Notes', title='Nautilus — Naturalist Journal App', author='Yana', shot='27157920--Nautilus-Naturalist-Journal-App', likes=29, saves=20, views=4879, posted='2026-03-07', tier='Low-evidence experiment', fit='High after simplification',
      look='Warm textured paper, fine ink outlines, serif headings, specimen cards and Polaroid-like photos.',
      apply='Paper material ni full canvas + cards ki use chesi, lists lo fine rules, calendar lo stamped completion marks pettachu. Cards size maarina material panichestundi.',
      sell='Paper pack ki actual visual reference. Classic Notebook, Field Notes, Sepia variants original ga design cheyyachu.',
      caution='Only 29 likes / 20 saves. Visually promising, kaani popularity-backed launch winner kaadu. Handwritten body text ni avoid chesi regular readable font retain cheyyali.'),
]

for r in rows:
    r['url'] = 'https://dribbble.com/shots/' + r['shot']
    r['image'] = 'images/' + r['id'] + '.webp'
    r['checked_on'] = '2026-09-23'
    r['evidence'] = 'Exact public counts read from Dribbble Shot details in browser; image inspected locally.'
(ROOT/'sources.json').write_text(json.dumps(rows,ensure_ascii=False,indent=2))

intro = '''# Theme Pack Design References

*Researched 23 September 2026. 10 actual Dribbble design references + 1 official WhatsApp example. Images saved locally; these are source designs, not generated mockups.*

**First prototypes ki Midnight Pastel, Soft Pastel, Playful Doodles ni recommend chesthunnaanu.** Ee three directions ki visible popularity undi, distinct personality undi, mana cards/rows/calendar meeda adapt cheyyadaniki clear path undi. Paper/Field Notes attractive ga unna, current engagement low—experiment ga treat cheyyali.

[Plus and Subscription Deep Dive](../../Business%20Model%20and%20Monetization/Plus%20and%20Subscription%20Deep%20Dive/Plus%20and%20Subscription%20Deep%20Dive.md) lo section 2.1 chadivaanu. Report cosmetics ni strongest monetisation evidence group ga rank chesthundi. Adi theme packs category-wide #1 purchase cause ani prove cheyyadu; report itself exploratory. Free light/dark, richer Plus packs, live preview, Plus meeda second theme charge avoid cheyyadam ane recommendations tho ee shortlist align avutundi.

**Ee names mana proposed pack names.** Source pages mostly UI concepts; purchasable theme packs ani claim cheyyatledu. Commercial product lo original artwork/design adaptations build cheyyali. Exact source assets use cheyyalante creator permission/licence scope verify cheyyali; public visibility resale rights ivvadu.

## Popularity evidence

Counts Dribbble **Shot details** panel nunchi direct ga verify chesaanu. Saves, likes, views separate ga record chesaanu; comments count ni likes ga mix cheyyaledu. Counts change avuthayi. Pinterest search results dorikayi, kaani reliable comparable saves/likes verify cheyyalekapoyaanu; popularity ranking lo avi include cheyyaledu.

Likes = visual interest signal. Saves = reference ga keep chesukunna signal. Rendu mostly designer audience behaviour; mana habit-tracker users pay chestharu ani evidence kaadu. Older posts, creator reach and promotion valla totals affect avuthayi. Anduke publication date, views kooda ichaanu; raw likes ni conversion probability ga convert cheyyaledu.

| Proposed direction / source | Likes | Saves | Views | Posted | Layout fit | Priority |
|---|---:|---:|---:|---|---|---|
'''
table=''.join(f"| [{r['name']}]({r['url']}) | {r['likes']:,} | {r['saves']:,} | {r['views']:,} | {r['posted']} | {r['fit']} | {r['tier']} |\n" for r in rows)
body=''
for i,r in enumerate(rows,1):
    body += f"\n## {i}. {r['name']}\n\n![{r['title']}]({r['image']})\n\n[{r['title']}]({r['url']}) — {r['author']}. **{r['likes']:,} likes · {r['saves']:,} saves · {r['views']:,} views.**\n\n**Image lo em undi:** {r['look']}\n\n**Mana app ki adaptation:** {r['apply']}\n\n**Pack potential — judgement:** {r['sell']}\n\n**Limit:** {r['caution']}\n"
outro='''
## 11. WhatsApp: background + foreground kalipi theme cheyyadam

![Official WhatsApp theme previews](images/11-whatsapp.webp)

[Official WhatsApp announcement, 13 February 2025](https://blog.whatsapp.com/chat-themes-to-reflect-your-style). Presets background tho paatu chat bubble colours kooda change chesthayi; mix-and-match and custom photos kooda describe chesaaru. Public likes/saves ee source lo levu; idi interaction reference, popularity proof kaadu.

Mana equivalent: **app background + habit card surface + accent + completion mark** kalisi change avvali. Wallpaper loud ga unna, text unna card surface opaque/readable ga undali. Theme chooser thumbnail lo bare wallpaper badulu oka actual habit card, mini-calendar, selected button chupinchali. App-wide default first; per-habit override later, if useful.

## Layout maarina theme work avvali ante

“Any layout” guarantee ee reference shots ivvavu. Layout-independent theme system ni build chesi actual app layouts meeda verify cheyyali. Geometry/nav/data structure separate; theme visual roles ni replace chesthundi.

| Surface | Midnight Pastel | Soft Pastel | Playful Doodles | Paper experiment |
|---|---|---|---|---|
| App background | Charcoal | Pale blue/cream | Warm cream | Low-intensity paper grain |
| Big card | Pastel fill, dark text | Tinted fill, small doodle | Neutral fill, corner sticker | Ink border, paper fill |
| Compact row | Accent strip + check | Tinted icon tile | Small sticker/check | Thin rule + stamp |
| Calendar / heatmap | Same accent ramp | Same accent ramp | Plain cells + playful check | Plain cells + ink check |
| Stats panel | Flat dark surface | Flat light surface | Decoration outside chart | Grain removed behind chart |
| Completion | Filled indicator + check | Darker accent + check | Small doodle celebration | Stamp + check |

Decoration must scale down with available space. A 320px-wide card and 44px-high row cannot carry the same large illustration. Keep borders, fills and patterns flexible; illustrations need corner/thumbnail/hidden variants. Dense heatmaps need plain cells. Long habit names, numbers, empty/skipped/completed states, enlarged text and both appearance modes need checking before a pack is accepted.

## What I would build and test first

**Three packs × three variants = nine prototypes**, not an immediate commitment to 30 production themes. Proposed variants: Midnight Lavender/Mint/Rose; Soft Peach/Mint/Lilac; original Garden Doodles/Stars/Tiny Creatures. Variants are our proposed work, not found downloadable products. Sage & Latte and Gradient Cards can follow; Paper deserves a small preference test despite its low likes.

Make previews using the **same habits and same layout**, so people choose appearance rather than a different feature set. Let target users apply a theme to their own list/grid/calendar, keep it for several days, and show the real Plus price. Compare preview → apply → still using → purchase by pack. Apply/keep signals are more informative than asking “looks good?”; actual purchase is stronger evidence than likes or stated willingness to pay. No reliable external sales/conversion data for these specific designs was found, so “easy to sell” remains a hypothesis.

The proposed Plus bundle can include these packs. This research does not establish a separate per-pack price or justify charging again on top of Plus. A polished free baseline is necessary; richer paid packs need a visibly different material/illustration identity, not just a different hex colour.

**Not shortlisted:** [Neubrutalism Mobile App Design Exploration](https://dribbble.com/shots/25960693-Neubrutalism-Mobile-App-Design-Exploration) had **0 likes, 1 save, 2,335 views** when checked (posted 29 April 2025). That particular reference fails the popularity criterion; it does not prove the entire style is unpopular.

All adaptation and launch recommendations above are design judgement, separate from the observed counts. Source images remain credited to their creators. Machine-readable metadata: [sources.json](sources.json).
'''
(ROOT/'Theme Pack Design References.md').write_text(intro+table+body+outro)

# A local contact sheet keeps the original artwork uncropped and linked.
cards=''.join(f'''<article><a href="{html.escape(r['image'])}" target="_blank"><img src="{html.escape(r['image'])}" alt="{html.escape(r['title'])}"></a><div class="body"><small>{html.escape(r['tier'])} · Layout fit: {html.escape(r['fit'])}</small><h2>{html.escape(r['name'])}</h2><p class="metrics">♥ {r['likes']:,} likes &nbsp; ▣ {r['saves']:,} saves &nbsp; ◉ {r['views']:,} views</p><p>{html.escape(r['apply'])}</p><p class="muted">{html.escape(r['caution'])}</p><a href="{r['url']}" target="_blank" rel="noopener">{html.escape(r['author'])} ↗</a></div></article>''' for r in rows)
page='''<!doctype html><html lang="en"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Theme Pack Design References</title><style>*{box-sizing:border-box}body{margin:0;background:#f5f3ee;color:#252723;font:16px/1.6 system-ui,sans-serif}header,main,footer{max-width:1440px;margin:auto;padding:32px}header{padding-top:56px}h1{font-size:clamp(32px,5vw,64px);line-height:1.05;letter-spacing:-2px;margin:16px 0}header p{max-width:850px}small,.muted{color:#63665c}main{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:28px}article{background:white;border:1px solid #dedfd7;border-radius:18px;overflow:hidden}article img{display:block;width:100%;aspect-ratio:4/3;object-fit:contain;background:#eceee9}.body{padding:24px}h2{font-size:26px;margin:8px 0}p{margin:10px 0}.metrics{font-size:14px;font-weight:650}a{color:#245c4d}footer{padding-bottom:64px}.official{width:100%;max-width:1100px;display:block;margin:24px 0}@media(max-width:780px){main{grid-template-columns:1fr}header,main,footer{padding:22px}}</style><header><small>HABIT TRACKER · VISUAL RESEARCH · 23 SEPTEMBER 2026</small><h1>Theme packs worth testing.</h1><p>10 actual design references. Exact public likes, saves and views checked on Dribbble. First prototypes: <b>Midnight Pastel, Soft Pastel, Playful Doodles.</b></p><p>Images click chesthe full size lo choodachu. Proposed pack names manavi; source artwork creators di. Popularity is interest, not proof of paid demand.</p><a href="Theme%20Pack%20Design%20References.md">Full research notes and layout mapping ↗</a></header><main>'''+cards+'''</main><footer><h2>WhatsApp: theme the background and the cards together</h2><img class="official" src="images/11-whatsapp.webp" alt="Official WhatsApp theme examples"><p>Mana equivalent: app background + habit card surface + accent + completion mark. Public engagement unavailable; this is a mechanism reference.</p><a href="https://blog.whatsapp.com/chat-themes-to-reflect-your-style" target="_blank" rel="noopener">Official WhatsApp source ↗</a><p>Original designs should be created or appropriately licensed before commercial use. These references are not a resale asset bundle.</p></footer></html>'''
(ROOT/'gallery.html').write_text(page)
print(f'Created report, gallery and sources.json with {len(rows)} references.')
