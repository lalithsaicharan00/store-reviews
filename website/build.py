#!/usr/bin/env python3
"""Builds website/public from website/src: python3 website/build.py

Every page shares one top bar, footer and head, and the email lives in one place. The footer and top bar link only to
pages that exist, so a page that isn't built yet never leaves a dead link (website/Website Build Notes.md).
"""
import base64
import datetime
import hashlib
import html
import json
import re
import shlex
import shutil
from pathlib import Path

HERE = Path(__file__).parent
SRC = HERE / "src"
OUT = HERE / "public"
SITE = "https://oftenenough.com"
EMAIL = "support@oftenenough.com"

# None until the store's listing is public: "A store not live yet gets an honest coming soon, never a dead link."
STORES = {"Google Play": None, "App Store": None}

PAGES = [
    {
        "path": "/",
        "file": "home.html",
        "name": "Often Enough",
        "title": "Often Enough: the simple habit tracker with no subscription",
        "description": "A simple habit tracker for Android and iPhone. Log your habits in a tap. Start free, and pay once if you ever want more. No account, no ads.",
        "home": True,
    },
    {
        "path": "/privacy",
        "file": "privacy.html",
        "name": "Privacy policy",
        "title": "Privacy policy · Often Enough",
        "description": "Often Enough has no account and no server. Your habits stay on your phone and in your own cloud, and we never see them.",
    },
    {
        "path": "/support",
        "file": "support.html",
        "name": "Support",
        "title": "Support · Often Enough",
        "description": "Help with Often Enough: late reminders, widgets, backup, a new phone, Plus and refunds, with a real person to write to.",
    },
    {
        "path": "/terms",
        "file": "terms.html",
        "name": "Terms of use",
        "title": "Terms of use · Often Enough",
        "description": "Plain terms for Often Enough: one payment with no subscription, no account, and your habits stay yours.",
    },
    {
        "path": "/404",
        "file": "not-found.html",
        "name": "Page not found",
        "title": "Page not found · Often Enough",
        "description": "We can't find that page.",
        "noindex": True,
    },
]

NAV = [("Features", "/#every-kind"), ("Plus", "/#free-and-plus"), ("Support", "/support")]
FOOTER = [
    ("App", [("Plus", "/plus"), ("About", "/about")]),
    ("Help", [("Support", "/support"), ("Often Enough facts", "/facts")]),
    ("Explore", [
        ("Habit tracker with no subscription", "/habit-tracker-no-subscription"),
        ("Private habit tracker", "/private-habit-tracker"),
        ("Habit tracker widgets", "/habit-tracker-widgets"),
        ("Quit and cut-down tracker", "/quit-and-cut-down-tracker"),
    ]),
    ("Legal", [("Privacy", "/privacy"), ("Terms", "/terms")]),
]


# One inline script, on the homepage, allowed by its own hash and nothing else, so it's worked out at every build.
HOME_SCRIPT = (SRC / "home.js").read_text(encoding="utf-8")


def built(path):
    return "#" in path or path in {page["path"] for page in PAGES}


def link(label, path, current):
    mark = ' aria-current="page"' if path == current else ""
    return f'<a href="{path}"{mark}>{html.escape(label)}</a>'


def nav(current):
    links = "".join(link(label, path, current) for label, path in NAV if built(path))
    return f"""<nav class="nav" aria-label="Main">
  <a class="brand" href="/"><img src="/logo.svg" width="40" height="40" alt="">Often Enough</a>
  <div class="nav-links">{links}</div>
  <a class="button" href="/#download">Download</a>
</nav>"""


def store_pills():
    live = [f'<a class="pill" href="{url}">{name}</a>' for name, url in STORES.items() if url]
    soon = [f'<span class="pill">{name}</span>' for name, url in STORES.items() if not url]
    note = '<p class="small">Coming soon to</p>' if soon else ""
    return f'{note}<div class="stores">{"".join(live + soon)}</div>'


def footer(current):
    columns = ""
    for name, links in FOOTER:
        items = "".join(f"<li>{link(label, path, current)}</li>" for label, path in links if built(path))
        if items:
            columns += f"<div><h2>{name}</h2><ul>{items}</ul></div>"
    return f"""<footer class="footer wrap">
  <div class="footer-top">
    <div class="footer-brand">
      <a class="brand" href="/"><img src="/logo.svg" width="40" height="40" alt="">Often Enough</a>
      <p>A simple habit tracker for Android and iPhone. No subscription, no account and no ads.</p>
      {store_pills()}
    </div>
    <nav class="footer-links" aria-label="Footer">{columns}</nav>
  </div>
  <div class="footer-bottom small">© 2026 Often Enough</div>
</footer>"""


def store_buttons():
    """Both stores are always in the HTML, so Google and AI tools see both; CSS hides the other one on a known device."""
    words = {"Google Play": ("play", "Get it on Google Play", "Coming soon to Google Play"),
             "App Store": ("app", "Download on the App Store", "Coming soon to the App Store")}
    buttons = ""
    for name, url in STORES.items():
        store, get, soon = words[name]
        if url:
            buttons += f'<a class="button button-large" data-store="{store}" href="{url}">{get}</a>'
        else:
            buttons += f'<span class="button button-large" data-store="{store}">{soon}</span>'
    return f'<div class="store-buttons">{buttons}</div>'


def icon(name):
    return f'<svg class="i" aria-hidden="true"><use href="#i-{name.replace(".", "-")}"/></svg>'


def row(args):
    """One Today row, the app's own (HabitRow.kt): {{row colour icon name detail streak= fill= action=}}."""
    colour, symbol, name, detail, *rest = args
    extra = dict(item.split("=", 1) for item in rest)
    fill = f'<i class="row-fill fill-{extra["fill"]}"></i>' if "fill" in extra else ""
    streak = f'<span class="streak"><span class="fire">🔥</span>{extra["streak"]}</span>' if "streak" in extra else ""
    action = extra.get("action", "")
    action = icon(action) if action and not action.startswith("+") else html.escape(action)
    done = " round-done" if "done" in extra else ""
    return (f'<div class="row h-{colour}">{fill}<span class="row-icon">{icon(symbol)}</span>'
            f'<span class="row-words"><span class="row-name">{html.escape(name)}</span><span class="row-detail">{html.escape(detail)}</span></span>'
            f'{streak}<span class="round{done}">{action}</span></div>')


def quit_row():
    """A quit habit's row, its count running from one start moment everywhere on the page (home.js)."""
    return (f'<div class="row h-red"><span class="row-icon">{icon("smoke_free")}</span>'
            '<span class="row-words"><span class="row-name">Smoking</span><span class="row-detail run-since">Since 2 Aug</span></span>'
            '<span class="row-clock run-clock">94d 7:42:18</span></div>')


def head(args):
    """One time of day's header on Today: {{head name starts left= start=now|later icons=colour:icon,+1}}."""
    name, starts, *rest = args
    extra = dict(item.split("=", 1) for item in rest)
    words = f'<span class="row-name">{name}</span>' + (f'<span class="head-starts">{starts}</span>' if starts else "")
    start = extra.get("start")
    parts = f'<span class="head-left{" head-left-open" if start else ""}">{extra["left"]}</span>'
    if start:
        parts += f'<span class="head-start head-start-{start}">{icon("play_arrow.fill")}Start</span>'
        chevron = "expand_less"
    else:
        for item in extra["icons"].split(","):
            if item.startswith("+"):
                parts += f'<span class="head-dot head-more">{item}</span>'
            else:
                colour, symbol = item.split(":")
                parts += f'<span class="head-dot h-{colour}">{icon(symbol)}</span>'
        chevron = "expand_more"
    shape = "head-open" if start else "head-closed"
    return f'<div class="head {shape}"><span class="head-words">{words}</span>{parts}<span class="head-chevron">{icon(chevron)}</span></div>'


def more(args):
    """A section's closing link, only once its page exists."""
    path, words = args
    return f'<a class="more" href="{path}">{html.escape(words)}{icon("arrow_forward")}</a>' if built(path) else ""


def round_button(action, done):
    action = icon(action) if action and not action.startswith("+") else html.escape(action)
    return f'<span class="round{" round-done" if done else ""}">{action}</span>'


def widget_small(args):
    """A One habit 2×2 widget: {{w2 colour icon name detail action= fill= pill= done=1 clock=1 more=1}}."""
    colour, symbol, name, detail, *rest = args
    extra = dict(item.split("=", 1) for item in rest)
    words = f'<span class="w-detail{" run-clock-widget" if "clock" in extra else ""}">{html.escape(detail)}</span>'
    if "pill" in extra:
        end = f'<span class="w-pill-wide">{html.escape(extra["pill"])}</span>'
    else:
        end = f'<span class="w-bar"><i class="w-bar-on fill-{extra["fill"]}"></i></span>'
    more = " wid-more" if "more" in extra else ""
    return (f'<div class="wid w2 h-{colour}{more}" role="img" aria-label="{html.escape(name)} widget: {html.escape(detail)}">'
            f'<span class="w-top"><span class="row-icon">{icon(symbol)}</span>{round_button(extra["action"], "done" in extra)}</span>'
            f'<span class="w-words"><span class="w-name">{html.escape(name)}</span>{words}</span>{end}</div>')


def widget_row(args):
    """One row of a list widget: {{wrow colour icon name detail fill= streak= action= done=1 clock=1}}."""
    colour, symbol, name, detail, *rest = args
    extra = dict(item.split("=", 1) for item in rest)
    fill = f'<i class="row-fill fill-{extra["fill"]}"></i>' if "fill" in extra else ""
    streak = f'<span class="w-streak"><span class="fire">🔥</span>{extra["streak"]}</span>' if "streak" in extra else ""
    clock = " run-clock-widget" if "clock" in extra else ""
    return (f'<div class="wrow h-{colour}">{fill}<span class="row-icon">{icon(symbol)}</span>'
            f'<span class="wrow-words"><span class="wrow-name">{html.escape(name)}</span><span class="wrow-detail{clock}">{html.escape(detail)}</span></span>'
            f'{streak}{round_button(extra["action"], "done" in extra)}</div>')


def widget_list(args, body):
    """A list widget: {{wlist size name state label pages=1 classes=}} … rows … {{/wlist}}."""
    size, name, state, label, *rest = args
    extra = dict(item.split("=", 1) for item in rest)
    pages = f'<span class="w-pages">{icon("chevron_left")}<span>1/2</span>{icon("chevron_right")}</span>' if "pages" in extra else ""
    if size == "44":
        top = f'<span class="w-head-words"><span class="w-big">{html.escape(name)}</span><span class="w-small">{html.escape(state)}</span></span>'
    else:
        pill = f'<span class="w-pill">{html.escape(state)}</span>' if state else ""
        top = f'<span class="w-head-name">{html.escape(name)}</span>{pill}'
    classes = extra.get("classes", "").replace(",", " ")
    return (f'<div class="wid wlist wlist-{size} {classes}" role="img" aria-label="{html.escape(label)}">'
            f'<div class="w-head">{top}{pages}</div>{body}</div>')


def widget_week():
    """The This week 4×2: Water, as Progress and Today show it (Website Build Notes)."""
    marks = "".join(f'<span class="wk-day"><i class="wk-done">{icon("check")}</i>{day}</span>' for day in "SMTWT")
    return ('<div class="wid wk h-blue" role="img" aria-label="This week widget for Water: 3 of 8 glasses today, a 23 day streak, Sunday to Thursday done.">'
            f'<div class="wk-habit"><span class="row-icon">{icon("water_drop.fill")}</span><span class="wrow-name">Water</span><span class="w-streak"><span class="fire">🔥</span>23</span></div>'
            '<span class="wk-amount"><b>3</b>of 8 glasses</span><span class="round wk-round">+1</span>'
            '<span class="w-bar wk-bar"><i class="w-bar-on fill-38"></i></span>'
            f'<div class="wk-days">{marks}<span class="wk-day"><i class="wk-part"></i>F</span><span class="wk-day"><i class="wk-still"></i>S</span></div></div>')


def home_screen(body):
    """A phone's home screen with widgets on it, always the same around them."""
    apps = "".join(f'<span class="home-app home-app-{i}">{icon(name)}</span>' for i, name in enumerate(("call.fill", "chat.fill", "photo_camera.fill", "public")))
    return ('<i class="wall"></i><span class="wall-date">Fri, 23 Oct</span><span class="wall-weather">18°C · Partly cloudy</span>'
            f'<div class="home-wids">{body}</div>{apps}'
            f'<span class="home-search"><b>G</b>{icon("mic.fill")}{icon("photo_camera.fill")}</span>')


def phone(label):
    """An Android phone holding one of the app's 360 × 800 screens. The status bar and handle are always the same."""
    return (f'<div class="phone" role="img" aria-label="{html.escape(label)}"><i class="phone-side phone-side-a"></i><i class="phone-side phone-side-b"></i>'
            '<div class="bezel"><div class="screen app"><span class="status-time">9:41</span><i class="status-camera"></i>'
            '<span class="status-icons">{{i:wifi}}{{i:signal_cellular_alt}}{{i:battery_horiz_075}}</span>')


# Read's sample year, as approved in Figma (Website Build Notes, Year in Pixels). 249 of 276 days, today is 23 October.
YEAR = """aaababcaaadd abaeaaaaaadd acaaaaaaaadd aaaaaaacaadd acaaaaeaaadd aefaaafaaedd aaaaeaaaaadd aaaaaaacabdd
baaaaeaaeedd aaaeabagaadd eeaaaeagaadd bfeaafegeadd baaaaaagaadd aaaaaaagaadd aaeaaacgeadd aceaeeagaadd aaaaaaaaaadd
aaafbaaaeadd faaaaaeaaadd abafaaaaaadd faaabaaaaadd cafbaaaaaedd abaafabaahdd acbaeaaaaddd""".split()


def year_grid():
    """One inline SVG, not hundreds of elements: each colour's squares are one path, and only their marks are repeated."""
    step, cell, top = 22.667, 20, 17
    colours = {"a": "#fa7b17", "b": "#e8e8e8", "c": "#fcbd8b", "d": "#e8e8e8", "e": "#b85600", "f": "#e8e8e8", "g": "#e8e8e8", "h": "#fcbd8b"}
    marks = {"a": ("check", 13.3), "e": ("check", 13.3), "b": ("close", 10), "f": ("redo", 10), "g": ("pause-fill", 10)}
    paths, uses, ring = {}, [], ""
    for y, days in enumerate(YEAR):
        for x, kind in enumerate(days):
            left, down = round(18.67 + x * step, 2), round(top + y * step, 2)
            paths.setdefault(colours[kind], []).append(f"M{left + 5} {down}h10a5 5 0 0 1 5 5v10a5 5 0 0 1-5 5h-10a5 5 0 0 1-5-5v-10a5 5 0 0 1 5-5")
            if kind in marks:
                name, size = marks[kind]
                pad = round((cell - size) / 2, 2)
                tone = "w" if kind in "ae" else "g"
                uses.append(f'<use class="{tone}" href="#i-{name}" x="{round(left + pad, 2)}" y="{round(down + pad, 2)}" width="{size}" height="{size}"/>')
            if kind == "h":
                ring = f'<rect class="today-ring" x="{round(left - 2, 2)}" y="{round(down - 2, 2)}" width="24" height="24" rx="7"/>'
    months = "".join(f'<text class="{"now" if i == 9 else ""}" x="{round(28.67 + i * step, 2)}" y="11" text-anchor="middle">{m}</text>' for i, m in enumerate("JFMAMJJASOND"))
    labels = "".join(f'<text x="8" y="{round(top + (d - 1) * step + 14, 2)}" text-anchor="middle">{d}</text>' for d in (1, 6, 11, 16, 21))
    squares = "".join(f'<path fill="{colour}" d="{"".join(parts)}"/>' for colour, parts in paths.items())
    return f'<svg class="year-grid" viewBox="0 0 288 562" aria-hidden="true">{months}{labels}{squares}{"".join(uses)}{ring}</svg>'


MEDAL = "M16.7458 1.33997C17.9942 .525622 19.6058 .525622 20.8542 1.33997L23.596 3.1284C24.0787 3.44328 24.6274 3.64298 25.1996 3.71205L28.4495 4.1044C29.9293 4.28305 31.1638 5.31897 31.5967 6.74528L32.5475 9.87766C32.7148 10.4292 33.0068 10.9348 33.4007 11.3555L35.6381 13.7451C36.6568 14.8331 36.9367 16.4202 36.3515 17.7911L35.0663 20.8018C34.8401 21.3319 34.7387 21.9069 34.77 22.4823L34.9479 25.751C35.029 27.2393 34.2232 28.635 32.8937 29.309L29.974 30.7892C29.4599 31.0499 29.0127 31.4252 28.6668 31.8862L26.702 34.5045C25.8074 35.6967 24.293 36.2479 22.8413 35.9096L19.6532 35.1668C19.0919 35.036 18.5081 35.036 17.9468 35.1668L14.7587 35.9096C13.307 36.2479 11.7926 35.6967 10.898 34.5045L8.93324 31.8862C8.58732 31.4252 8.14005 31.0499 7.62599 30.7892L4.70629 29.309C3.37683 28.635 2.57102 27.2393 2.65205 25.751L2.83 22.4823C2.86133 21.9069 2.75995 21.3319 2.53367 20.8018L1.24851 17.7911C.663324 16.4202 .943177 14.8331 1.96194 13.7451L4.1993 11.3555C4.59323 10.9348 4.88516 10.4292 5.05255 9.87766L6.00327 6.74528C6.43617 5.31897 7.67074 4.28305 9.15054 4.1044L12.4004 3.71205C12.9726 3.64298 13.5213 3.44328 14.004 3.1284Z"


COOKIE = "M38.7249 1.49723C41.7849-.498778 45.7351-.498777 48.795 1.49723L55.5153 5.8808C56.6985 6.65259 58.0433 7.14206 59.4457 7.31137L67.4114 8.27304C71.0385 8.71093 74.0645 11.25 75.1256 14.746L77.4559 22.4237C77.8661 23.7754 78.5817 25.0148 79.5472 26.046L85.0312 31.9029C87.5282 34.5698 88.2141 38.46 86.7798 41.8201L83.6298 49.1994C83.0752 50.4986 82.8267 51.908 82.9035 53.3186L83.3396 61.3302C83.5383 64.9783 81.5632 68.3992 78.3046 70.0512L71.1482 73.6793C69.8882 74.3181 68.7919 75.238 67.9441 76.3679L63.1284 82.7856C60.9356 85.7078 57.2237 87.0588 53.6656 86.2297L45.8513 84.409C44.4755 84.0884 43.0444 84.0884 41.6686 84.409L33.8544 86.2297C30.2963 87.0588 26.5844 85.7078 24.3916 82.7856L19.5759 76.3679C18.7281 75.238 17.6318 74.3181 16.3718 73.6793L9.21539 70.0512C5.95681 68.3992 3.98173 64.9782 4.18034 61.3302L4.61651 53.3186C4.6933 51.908 4.4448 50.4986 3.89019 49.1994L.74017 41.8201C-.694157 38.46-.00821996 34.5698 2.48883 31.9029L7.97275 26.046C8.93828 25.0148 9.65383 23.7754 10.0641 22.4237L12.3944 14.746C13.4555 11.25 16.4815 8.71093 20.1086 8.27304L28.0742 7.31137C29.4767 7.14206 30.8215 6.65259 32.0047 5.8808Z"


# The logo as Android draws a notification's small icon: white tiles at three strengths, only in these mock-ups.
MARK = ('<path fill="#fff" fill-opacity=".55" d="M15.0661 17.6256C14.9854 17.9775 14.9003 18.3774 14.8029 18.8356L14.7787 18.9493C14.3954 20.7527 14.2038 21.6544 14.4083 22.4178C14.5882 23.0893 14.9761 23.6866 15.5164 24.1241C16.1306 24.6214 17.0323 24.8131 18.8357 25.1964L18.9494 25.2206C19.4076 25.318 19.8076 25.403 20.1619 25.4723C20.0249 25.9699 19.8812 26.3115 19.6621 26.5822C19.3182 27.0069 18.8487 27.3118 18.3208 27.4533C17.7207 27.6141 17.0119 27.4634 15.5942 27.162L14.654 26.9622C13.2364 26.6609 12.5276 26.5102 12.0448 26.1192C11.6201 25.7753 11.3151 25.3058 11.1737 24.7779C11.0129 24.1778 11.1636 23.469 11.4649 22.0513L11.6647 21.1112C11.966 19.6935 12.1167 18.9847 12.5077 18.5019C12.8516 18.0772 13.3212 17.7722 13.849 17.6308C14.1854 17.5407 14.5559 17.5484 15.0661 17.6256Z"/>'
        '<path fill="#fff" fill-opacity=".78" d="M18.9814 15.0836C18.9006 15.4355 18.8156 15.8354 18.7182 16.2936L18.6941 16.4073C18.3107 18.2107 18.1191 19.1124 18.3236 19.8758C18.5035 20.5473 18.8914 21.1446 19.4317 21.5821C20.0459 22.0794 20.9476 22.2711 22.751 22.6544L22.8647 22.6786C23.3229 22.776 23.7229 22.861 24.0772 22.9303C23.9402 23.4279 23.7966 23.7695 23.5774 24.0402C23.2335 24.4649 22.7639 24.7698 22.2361 24.9112C21.636 25.072 20.9272 24.9214 19.5095 24.62L18.5693 24.4202C17.1517 24.1189 16.4429 23.9682 15.96 23.5772C15.5353 23.2333 15.2304 22.7638 15.089 22.2359C14.9282 21.6358 15.0788 20.9269 15.3802 19.5093L15.58 18.5691C15.8813 17.1515 16.032 16.4427 16.423 15.9599C16.7669 15.5351 17.2365 15.2302 17.7643 15.0888C18.1007 14.9987 18.4712 15.0064 18.9814 15.0836Z"/>'
        '<path fill="#fff" d="M26.8644 13.3601L22.8867 12.5146C21.4888 12.2174 20.1146 13.1098 19.8174 14.5078L18.9719 18.4855C18.6748 19.8835 19.5672 21.2577 20.9652 21.5548L24.9429 22.4003C26.3408 22.6975 27.715 21.8051 28.0122 20.4071L28.8577 16.4294C29.1548 15.0314 28.2624 13.6572 26.8644 13.3601Z"/>')


def mockups(body):
    body = body.replace("{{today_screen}}", (SRC / "parts" / "today.html").read_text())
    """Expands the mock-ups' shorthand, then adds one copy of each icon the page used."""
    body = re.sub(r"\{\{row (.*?)\}\}", lambda m: row(shlex.split(m.group(1))), body)
    body = body.replace("{{quit}}", quit_row()).replace("{{year_grid}}", year_grid())
    body = re.sub(r"\{\{wrow (.*?)\}\}", lambda m: widget_row(shlex.split(m.group(1))), body)
    body = re.sub(r"\{\{wlist (.*?)\}\}(.*?)\{\{/wlist\}\}", lambda m: widget_list(shlex.split(m.group(1)), m.group(2)), body, flags=re.S)
    body = re.sub(r"\{\{w2 (.*?)\}\}", lambda m: widget_small(shlex.split(m.group(1))), body)
    body = body.replace("{{wweek}}", widget_week())
    body = re.sub(r"\{\{home\}\}(.*?)\{\{/home\}\}", lambda m: home_screen(m.group(1)), body, flags=re.S)
    body = re.sub(r'\{\{phone "(.*?)"\}\}', lambda m: phone(m.group(1)), body)
    body = body.replace("{{/phone}}", '<i class="home-handle"></i></div></div></div>')
    body = re.sub(r"\{\{more (.*?)\}\}", lambda m: more(shlex.split(m.group(1))), body)
    body = re.sub(r"\{\{head (.*?)\}\}", lambda m: head(shlex.split(m.group(1))), body)
    body = re.sub(r"\{\{i:([\w.]+)\}\}", lambda m: icon(m.group(1)), body)
    used = sorted(set(re.findall(r'href="#i-([\w-]+)"', body)))
    if not used:
        return body
    paths = {name.replace(".", "-"): path for name, path in json.loads((SRC / "icons.json").read_text()).items()}
    symbols = "".join(f'<symbol id="i-{name}" viewBox="0 -960 960 960"><path d="{paths[name]}"/></symbol>' for name in used)
    if 'href="#medal"' in body:
        symbols += (f'<linearGradient id="medal-fill" x1="0" y1="0" x2="0" y2="1"><stop stop-color="#97b8ff"/><stop offset="1" stop-color="#226fdc"/></linearGradient>'
                    f'<symbol id="medal" viewBox="0 0 37.6 37.6"><path fill="url(#medal-fill)" d="{MEDAL}"/>'
                    f'<path fill="none" stroke="#fff" stroke-opacity=".6" stroke-width="1.15" transform="translate(3.4 3.4) scale(.82)" d="{MEDAL}"/></symbol>')
    if 'href="#mark"' in body:
        symbols += f'<symbol id="mark" viewBox="0 0 40 40">{MARK}</symbol>'
    if 'href="#cookie"' in body:
        symbols += f'<symbol id="cookie" viewBox="0 0 88 87"><path d="{COOKIE}"/></symbol>'
    return f'<svg class="sprite" aria-hidden="true">{symbols}</svg>\n{body}'


def contents(body):
    items = re.findall(r'<section id="([^"]+)">\s*<h2[^>]*>(.*?)</h2>', body)
    links = "".join(f'<li><a class="small" href="#{id_}">{title}</a></li>' for id_, title in items)
    return f'<nav class="contents" aria-labelledby="on-this-page"><p class="label" id="on-this-page">On this page</p><ul>{links}</ul></nav>'


def structured_data(page):
    if page.get("home"):
        return json.dumps({
            "@context": "https://schema.org",
            "@graph": [
                {"@type": "WebSite", "@id": f"{SITE}/#website", "url": f"{SITE}/", "name": "Often Enough"},
                {"@type": "Organization", "@id": f"{SITE}/#organization", "name": "Often Enough", "url": f"{SITE}/",
                 "logo": f"{SITE}/logo.svg", "email": EMAIL},
                {"@type": "MobileApplication", "name": "Often Enough", "url": f"{SITE}/",
                 "operatingSystem": "Android, iOS", "applicationCategory": "HealthApplication",
                 "description": page["description"], "publisher": {"@id": f"{SITE}/#organization"},
                 "offers": {"@type": "Offer", "price": "0", "priceCurrency": "USD"}},
            ],
        }, ensure_ascii=False)
    return json.dumps({
        "@context": "https://schema.org",
        "@type": "BreadcrumbList",
        "itemListElement": [
            {"@type": "ListItem", "position": 1, "name": "Often Enough", "item": f"{SITE}/"},
            {"@type": "ListItem", "position": 2, "name": page["name"], "item": f'{SITE}{page["path"]}'},
        ],
    }, ensure_ascii=False)


def render(page):
    body = (SRC / "pages" / page["file"]).read_text(encoding="utf-8")
    body = mockups(body.replace("{{store_buttons}}", store_buttons()))
    body = body.replace("{{contents}}", contents(body))
    body = body.replace("{{plus}}", "/plus" if built("/plus") else "/#free-and-plus")
    body = body.replace("{{email_button}}", f'<!--email_off--><a class="button button-large" href="mailto:{EMAIL}">{EMAIL}</a><!--/email_off-->')
    body = body.replace("{{email}}", f'<!--email_off--><a href="mailto:{EMAIL}">{EMAIL}</a><!--/email_off-->')
    url = f'{SITE}{page["path"]}'
    title, description = html.escape(page["title"]), html.escape(page["description"])
    script = f"<script>{HOME_SCRIPT}</script>\n" if page.get("home") else ""
    wrapper = 'class="home"' if page.get("home") else 'class="page wrap"'
    where = '<meta name="robots" content="noindex">' if page.get("noindex") else f'<link rel="canonical" href="{url}">\n<meta property="og:url" content="{url}">'
    return f"""<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{title}</title>
<meta name="description" content="{description}">
{where}
<meta name="theme-color" content="#0d0d0d">
<meta property="og:type" content="website">
<meta property="og:site_name" content="Often Enough">
<meta property="og:title" content="{title}">
<meta property="og:description" content="{description}">
<meta property="og:image" content="{SITE}/og.png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta property="og:image:alt" content="Often Enough, the simple habit tracker with no subscription, for Android and iPhone.">
<meta name="twitter:card" content="summary_large_image">
<link rel="icon" href="/favicon.svg" type="image/svg+xml">
<link rel="icon" href="/favicon-48.png" sizes="48x48" type="image/png">
<link rel="apple-touch-icon" href="/apple-touch-icon.png">
<link rel="preload" href="/fonts/GoogleSansFlex.woff2" as="font" type="font/woff2" crossorigin>
<link rel="stylesheet" href="/site.css">
{"" if page.get("noindex") else f'<script type="application/ld+json">{structured_data(page)}</script>'}
{script}</head>
<body>
<a class="skip" href="#main">Skip to content</a>
{nav(page["path"])}
<main {wrapper} id="main">
{body}</main>
{footer(page["path"])}
</body>
</html>
"""


def sitemap():
    """Each page's date is the day its source last changed, so it only moves when the page does."""
    urls = ""
    for page in PAGES:
        if not page.get("noindex"):
            changed = datetime.date.fromtimestamp((SRC / "pages" / page["file"]).stat().st_mtime).isoformat()
            urls += f'  <url><loc>{SITE}{page["path"]}</loc><lastmod>{changed}</lastmod></url>\n'
    return f'<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n{urls}</urlset>\n'


def main():
    shutil.rmtree(OUT, ignore_errors=True)
    shutil.copytree(SRC / "static", OUT)
    shutil.copy(SRC / "site.css", OUT / "site.css")
    script_hash = base64.b64encode(hashlib.sha256(HOME_SCRIPT.encode()).digest()).decode()
    headers = OUT / "_headers"
    headers.write_text(headers.read_text().replace("script-src 'none'", f"script-src 'sha256-{script_hash}'"))
    for page in PAGES:
        name = page["path"].strip("/") or "index"
        (OUT / f"{name}.html").write_text(render(page), encoding="utf-8")
    (OUT / "sitemap.xml").write_text(sitemap(), encoding="utf-8")
    print(f"Built {len(PAGES)} pages in {OUT}")


if __name__ == "__main__":
    main()
