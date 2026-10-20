# Hero Revision — Native Product and Neutral Design

Written by Codex, 12 October 2026. Current Work 93. Research and design proposal; approval pending.

The visitor's question is “Will this fit my actual habits, and what will using it feel like?” The hero should answer with a recognizable habit tracker, flexible everyday examples and authentic product output. This is reasoned from first principles and the earlier website brief, not a new conversion experiment.

## Feedback and acceptance

The first website direction was rejected as wireframe-like and visibly generic. Work now covers the hero only: neutral gray style, store typography and selective emoji color, native iPhone product output, clear action and responsive layouts. Later sections require their own revisions. Development waits for approval.

## Reference audit

Research included targeted Dribbble and Pinterest searches, indexed galleries and direct visual inspection. Dribbble live shot pages returned HTTP 500 in the browser. Its image CDN remained accessible. Counts below come from the indexed [app landing page gallery](https://dribbble.com/tags/app-landingpage), cached approximately one month before inspection, not live measurements. Likes/views show design-community interest, not downloads or conversion. No claim that these are globally the most liked designs.

| Reference | Signal available | Inspection and use |
|---|---|---|
| [Panels — Eduard Bodak](https://dribbble.com/shots/25286623-Panels-Hero-Section-Concept) | 62 likes / 18.9k views in indexed gallery | Image inspected. Calm neutral field, one strong product focal point, restrained navigation. Its serif font and wallpaper illustration do not suit our source style. |
| [BLVRD — Eduard Bodak](https://dribbble.com/shots/18190032-BLVRD-Rebranding-Concept-Fashion-App-Hero-Header) | 51 / 9.3k | Image inspected. Large confident type with a small pictorial interruption and single primary action. Exclude neon palette and fashion imagery. |
| [Planta — Eduard Bodak](https://dribbble.com/shots/20505892-Planta-Hero-Header-Responsive-Concept-Plant-App) | 41 / 8.7k | Desktop/mobile image inspected. Short headline with a meaningful plant symbol survives stacking. Product proof is too weak for our hero; exclude serif/green chrome. |
| [Mobile App Landing Page — Sifat Hasan](https://dribbble.com/shots/26619402-Mobile-App-Landing-Page) | 146 / 25.1k | Indexed text/palette inspected; image not visually verified. Higher engagement, but dark purple finance direction conflicts with neutral store style. |
| [Fitness hero — Clarivy Creations](https://dribbble.com/shots/23158764-Fitness-app-landing-page-hero-design) | No verified count | Image inspected. Grayscale confidence, but empty phone placeholder and decorative circles reproduce the problem we are fixing. Reject those patterns. |
| [Pinterest — Minimal Hero Section](https://in.pinterest.com/pin/minimal-hero-section--1039416789003868443/) | 1 visible reaction | Pin visually inspected. A centered SaaS headline, proof strip and dashboard composition. Low visible engagement; not selected as a popular exemplar. Purple gradients and generic dashboard cards do not fit. |
| [Pinterest — Minimal App Landing Page](https://in.pinterest.com/pin/minimal-app-landing-page--857513585276074429/) | No verified likes/saves | Pin inspected before sign-in overlay. An older colored template with many repeated features and phones; reject density, palette and generic credibility strips. |
| [Pinterest gray app search](https://in.pinterest.com/search/pins/?q=minimal%20gray%20app%20landing%20page) | No verified popularity ranking | Visible results included gray multi-phone and monochrome layouts, but a sign-in modal prevented reliable detail review. Do not infer saves or rankings. |
| User's Store Inspiration 1, Figma 1182:9420 | User-selected; no engagement claim | Previously rendered and inspected. Huge SF-style headline, soft gray/white, small emoji color, native UI as focal point. Strongest aesthetic authority. |
| User's Payr reference, Figma 1268:11391 | User-selected; no engagement claim | Previously inspected still. Device depth and overlapping useful UI inspire static staging, not a live 3D engine. |

Pinterest could not establish a high-like gray shortlist without authenticated access. This limitation does not justify inventing popularity or stalling the authorized design. The strongest verified visual fit is the user's existing store material; the community references supply composition principles rather than copied artwork (D11/W2).

## Proposed hero

Desktop uses a spacious two-column composition. The left side repeats the store's large black “Habit tracker”, gray “for your” and white seedling/“real life” sticker. Copy explains flexible habits without perfection pressure. A primary Get the app action leads to the existing release-status view; a quieter Explore features link leads below the hero.

The right side stages one native iPhone screen over a soft gray backing plane, plus a native Water widget. These images carry authentic type, SF Symbols, Liquid Glass controls, habit colors and flame accents. Color comes from the seedling and product content rather than brand chrome (U2). There are no ratings, customer counts or invented social proof.

Tablet uses a compact side-by-side composition so native product proof appears in its first screen. Mobile places the action before the image, scales the phone carefully and retains only one widget. At 320px, shorten layout spacing instead of squeezing the headline into unreadable type. The image is a product showcase; website headings, navigation, copy and actions remain editable and use auto-layout. Native app screenshots are intentionally retained as content because the user explicitly requested real iOS output.

## Asset provenance

Figma native Today screen 1206:11 uses image hash b10c1f5225e5f17f398fa7ac0a59f88bcca12d7b. Store capture preparation/upload records label this an iPhone simulator capture, including today-v2.png. It is actual app output; no physical-iPhone capture was taken in this session. Water widget 1210:3 is native WidgetKit output, hash f9da137ceae517fd7bf6c37e9a224b3cb773748f. Seedling 1221:2 uses the same store emoji asset, hash c1f6faa47c49a1ae8065fd8e56eee59e85c79bf0. The exact approved tonal logo is reused (U29).

The former Brand/Store Screenshots/Default iPhone source path is absent from this checkout. Existing Figma image fills remain accessible and are reused directly. No missing local source is represented as newly captured or restored.

## Delivered design and checks

Hero Round 02 review frames: desktop 1335:2366 (1440×880), tablet 1335:2419 (768×792), mobile 1335:2462 (390×1131.83) and narrow phone 1335:2509 (320×1038.48). The four original Apple Home designs also contain the revised hero. Other sections and the illustrative Android Home retain the first draft and require later revision.

Visual inspection repaired caption/phone collisions, excess mobile action spacing and tablet sizing after changing the layout direction. Final structural audit: SF Pro throughout, shared styles on all review text, no text outside frame width, three intentional content-image fills per hero, editable website copy/actions and reusable native product components. Product screenshot use is explicit; it is not an editable reconstruction of the app. Main Home Explore links scroll to the first feature section; standalone review links open the corresponding Home design. Get the app goes to the existing prelaunch Download design. Connections were inspected structurally, not run as browser interactions.

The phone casing is a stylized static presentation frame with slim edges, not a photograph of physical hardware. No native screen pixels were repainted. Four PNG reviews are saved in website/Design Previews/Hero Round 02; these are Figma review exports, not website payloads.

## Feasibility and release boundaries

The complete static composition requires only responsive product images, ordinary text and CSS. Phone tilt and shadow are static. Any optional hover must be bounded, fine-pointer only, with reduced-motion/static support. No continuous floating, WebGL, animated blur or scroll-controlled scene. This proposal follows S19; Figma cannot prove no hangs/black screens.

Apple apps are preparing for release. Android and desktop are planned. Native Apple output is identified as Apple output, never passed off as Android UI. After approval, responsive image conversion, sizing and asset budgets must be measured; quality may require relaxing the provisional 100KB hero budget only with actual visual/network evidence. Real low-memory mobile testing remains necessary.
