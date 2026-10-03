// Mockups for "Arranging and Filtering Today" (3 Oct 2026). Renders each screen at iPhone 16 size (393 x 852 pt, @3x).
import { createRequire } from 'node:module';
const { chromium } = createRequire(process.env.PW_ROOT + '/')('playwright');
import fs from 'node:fs';

const OUT = process.argv[2];
fs.mkdirSync(OUT, { recursive: true });

const css = `
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
*{box-sizing:border-box;margin:0;padding:0}
body{width:393px;height:852px;font-family:Inter,-apple-system,"Liberation Sans",sans-serif;background:#F2F2F7;color:#000;overflow:hidden;position:relative;-webkit-font-smoothing:antialiased}
.status{height:54px;display:flex;align-items:flex-end;justify-content:space-between;padding:0 30px 8px 36px;font-weight:600;font-size:16px}
.nav{height:44px;display:flex;align-items:center;justify-content:space-between;padding:0 16px}
.nav .left,.nav .right{display:flex;align-items:center;gap:18px;color:#007AFF;font-size:17px}
.title{padding:4px 16px 2px;font-size:34px;font-weight:700;letter-spacing:-0.5px}
.sub{padding:0 16px 10px;color:#6C6C70;font-size:15px}
.chip{display:inline-flex;align-items:center;gap:6px;margin:0 16px 8px;background:#fff;border-radius:16px;padding:6px 12px;font-size:15px;font-weight:500}
.dot{width:10px;height:10px;border-radius:5px;display:inline-block}
.sec{margin:14px 16px 6px;display:flex;align-items:baseline;gap:8px}
.sec .n{font-size:20px;font-weight:700}
.sec .t{color:#6C6C70;font-size:14px}
.card{background:#fff;border-radius:12px;margin:0 16px}
.row{display:flex;align-items:center;gap:12px;padding:10px 14px;min-height:58px;border-bottom:0.5px solid #E5E5EA}
.row:last-child{border-bottom:none}
.ic{width:34px;height:34px;border-radius:9px;display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:15px;flex:none}
.tx{flex:1;min-width:0}.tx .a{font-size:16px;font-weight:500}.tx .b{font-size:13px;color:#6C6C70;margin-top:2px}
.tick{width:30px;height:30px;border-radius:15px;border:2px solid #C7C7CC;flex:none}
.tick.done{background:#34C759;border-color:#34C759}
.handle{width:22px;flex:none;display:flex;flex-direction:column;gap:4px;align-items:center}
.handle i{display:block;width:18px;height:2px;background:#C7C7CC;border-radius:1px}
.minus{width:22px;height:22px;border-radius:11px;background:#FF3B30;color:#fff;display:flex;align-items:center;justify-content:center;font-weight:700;flex:none}
.dim{position:absolute;inset:0;background:rgba(0,0,0,0.18)}
.menu{position:absolute;background:rgba(249,249,249,0.97);border-radius:14px;box-shadow:0 10px 40px rgba(0,0,0,0.25);width:250px;overflow:hidden;font-size:17px}
.menu .h{padding:9px 16px 5px;color:#6C6C70;font-size:13px}
.menu .i{padding:11px 16px;display:flex;justify-content:space-between;align-items:center;border-top:0.5px solid #D8D8DC}
.menu .gap{height:8px;background:#E3E3E8}
.blue{color:#007AFF}.red{color:#FF3B30}.grey{color:#6C6C70}
.tip{position:absolute;background:#fff;border-radius:14px;box-shadow:0 8px 30px rgba(0,0,0,0.18);padding:12px 14px;font-size:15px;width:260px}
.tip b{display:block;margin-bottom:3px}
.addrow{display:flex;align-items:center;gap:10px;color:#007AFF;font-size:16px;font-weight:500;padding:14px;background:#fff;border-radius:12px;margin:14px 16px 0}
.secedit{margin:14px 16px 6px;display:flex;align-items:center;justify-content:space-between}
.secbtn{display:flex;align-items:baseline;gap:8px;color:#007AFF}
.secbtn .n{font-size:20px;font-weight:700}.secbtn .t{font-size:14px}
.foot{margin:10px 22px;color:#6C6C70;font-size:13px;line-height:1.35}
.lifted{box-shadow:0 12px 30px rgba(0,0,0,0.22);transform:scale(1.03);border-radius:12px;background:#fff;position:relative;z-index:2}
.bottomnote{position:absolute;left:0;right:0;bottom:30px;display:flex;justify-content:center}
.sheet{position:absolute;left:0;right:0;bottom:0;top:120px;background:#F2F2F7;border-radius:12px 12px 0 0;box-shadow:0 -6px 30px rgba(0,0,0,0.15)}
.sheet .bar{display:flex;justify-content:space-between;align-items:center;padding:16px;font-size:17px}
.form{background:#fff;border-radius:12px;margin:0 16px 22px}
.form .r{display:flex;justify-content:space-between;padding:12px 14px;border-bottom:0.5px solid #E5E5EA;font-size:17px}
.form .r:last-child{border-bottom:none}
.fh{margin:0 32px 6px;color:#6C6C70;font-size:13px}
.ff{margin:-14px 32px 22px;color:#6C6C70;font-size:13px;line-height:1.35}
`;

const icon = {
  menu: `<svg width="22" height="18" viewBox="0 0 22 18"><rect y="1" width="22" height="2.4" rx="1.2" fill="#007AFF"/><rect y="8" width="22" height="2.4" rx="1.2" fill="#007AFF"/><rect y="15" width="22" height="2.4" rx="1.2" fill="#007AFF"/></svg>`,
  plus: `<svg width="20" height="20" viewBox="0 0 20 20"><rect x="8.8" y="1" width="2.4" height="18" rx="1.2" fill="#007AFF"/><rect x="1" y="8.8" width="18" height="2.4" rx="1.2" fill="#007AFF"/></svg>`,
  filter: (on) => on
    ? `<svg width="24" height="24" viewBox="0 0 24 24"><circle cx="12" cy="12" r="11.5" fill="#007AFF"/><path d="M6 8h12M8.5 12h7M11 16h2" stroke="#fff" stroke-width="2" stroke-linecap="round"/></svg>`
    : `<svg width="24" height="24" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10.6" fill="none" stroke="#007AFF" stroke-width="1.8"/><path d="M6.5 8.5h11M8.5 12h7M10.8 15.5h2.4" stroke="#007AFF" stroke-width="1.8" stroke-linecap="round"/></svg>`,
};

const status = `<div class="status"><span>9:41</span><span>●●● ▮</span></div>`;
const nav = ({ filterOn = false, editing = false } = {}) => editing
  ? `<div class="nav"><div class="left"></div><div class="right" style="font-weight:600">Done</div></div>`
  : `<div class="nav"><div class="left">${icon.menu}</div><div class="right"><span id="edit">Edit</span><span id="filter">${icon.filter(filterOn)}</span>${icon.plus}</div></div>`;

const H = (sym, color) => `<div class="ic" style="background:${color}">${sym}</div>`;
const habits = {
  vit: { n: 'Take vitamins', s: 'Every day', i: H('V', '#FFCC00'), g: 'Health' },
  tea: { n: 'Drink tea', s: '1 of 2 cups', i: H('T', '#A2845E'), g: 'Home' },
  push: { n: 'Push-ups', s: '20 · 3 times a week', i: H('P', '#FF3B30'), g: 'Health' },
  read: { n: 'Read pages', s: '10 pages', i: H('R', '#5856D6'), g: 'Reading' },
  guitar: { n: 'Practice guitar', s: '20 min', i: H('G', '#FF9500'), g: 'Mind' },
  tidy: { n: 'Tidy desk', s: '0 of 3 steps', i: H('D', '#30B0C7'), g: 'Home' },
  yoga: { n: 'Yoga', s: '15 min · 7:00 PM', i: H('Y', '#AF52DE'), g: 'Health' },
  run: { n: 'Run', s: '5 km', i: H('R', '#007AFF'), g: 'Health' },
};
const row = (h, { done = false, edit = false, lifted = false } = {}) =>
  `<div class="row${lifted ? ' lifted' : ''}">${h.i}<div class="tx"><div class="a">${h.n}</div><div class="b">${h.s}</div></div>${edit ? '<div class="handle"><i></i><i></i><i></i></div>' : `<div class="tick${done ? ' done' : ''}"></div>`}</div>`;
const sec = (name, time) => `<div class="sec"><span class="n">${name}</span><span class="t">${time}</span></div>`;
const secEdit = (name, time) => `<div class="secedit"><div class="secbtn"><span class="n">${name}</span><span class="t">${time} ›</span></div><span class="grey" style="font-size:22px;letter-spacing:1px">···</span></div>`;

const today = (opts = {}) => `${status}${nav(opts)}<div class="title">Today</div><div class="sub">Friday 3 October</div>`;

const screens = {
  // 1. Today as it would look, with Edit and the filter in the top bar, and the one-time tip.
  '1-today': `${today()}
    ${sec('Morning', 'from 6:00 AM')}<div class="card">${row(habits.vit, { done: true })}${row(habits.tea)}${row(habits.push)}</div>
    ${sec('Afternoon', 'from 12:00 PM')}<div class="card">${row(habits.read)}${row(habits.tidy)}</div>
    ${sec('Evening', 'from 6:00 PM')}<div class="card">${row(habits.guitar)}${row(habits.yoga)}</div>
    <div class="tip" style="top:104px;right:14px;width:230px"><b>Make Today yours</b>Put habits in your own order, and rename or add times of day.</div>
    <svg style="position:absolute;top:96px;right:116px" width="18" height="10"><path d="M0 10 L9 0 L18 10 Z" fill="#fff"/></svg>`,
  // 2. The filter: only "show less". Groups, Hide Completed, and Edit Groups where the groups are.
  '2-filter': `${today()}
    ${sec('Morning', 'from 6:00 AM')}<div class="card">${row(habits.vit, { done: true })}${row(habits.tea)}${row(habits.push)}</div>
    ${sec('Afternoon', 'from 12:00 PM')}<div class="card">${row(habits.read)}${row(habits.tidy)}</div>
    <div class="dim"></div>
    <div class="menu" style="top:100px;right:14px">
      <div class="h">Show</div>
      <div class="i">All Habits<span class="blue">✓</span></div>
      <div class="i"><span><span class="dot" style="background:#34C759"></span>&nbsp; Health</span><span class="grey">4</span></div>
      <div class="i"><span><span class="dot" style="background:#AF52DE"></span>&nbsp; Mind</span><span class="grey">1</span></div>
      <div class="i"><span><span class="dot" style="background:#FF9500"></span>&nbsp; Home</span><span class="grey">2</span></div>
      <div class="gap"></div>
      <div class="i">Hide Completed<span class="grey" style="font-size:15px">Off</span></div>
      <div class="gap"></div>
      <div class="i blue">Edit Groups…</div>
    </div>`,
  // 3. Filtered: the button fills and Today says so at the top, one tap back to all.
  '3-filtered': `${today({ filterOn: true })}
    <div class="chip"><span class="dot" style="background:#34C759"></span>Health &nbsp;<span class="grey">✕</span></div><span class="grey" style="font-size:14px">4 of 11 habits</span>
    ${sec('Morning', 'from 6:00 AM')}<div class="card">${row(habits.vit, { done: true })}${row(habits.push)}</div>
    ${sec('Evening', 'from 6:00 PM')}<div class="card">${row(habits.yoga)}${row(habits.run)}</div>`,
  // 4. Edit: the same Today, arranged in place. Rename / change times on the headers, drag habits, add a time of day.
  '4-edit': `${status}${nav({ editing: true })}<div class="title">Edit Today</div>
    <div class="foot" style="margin-top:2px">Drag habits into the order you do them, or into another time of day. Tap a time of day to rename it or change when it starts.</div>
    ${secEdit('Morning', '6:00 AM')}<div class="card">${row(habits.vit, { edit: true })}${row(habits.push, { edit: true, lifted: true })}${row(habits.tea, { edit: true })}</div>
    ${secEdit('Afternoon', '12:00 PM')}<div class="card">${row(habits.read, { edit: true })}${row(habits.tidy, { edit: true })}</div>
    ${secEdit('Evening', '6:00 PM')}<div class="card">${row(habits.guitar, { edit: true })}${row(habits.yoga, { edit: true })}</div>
    <div class="addrow">${icon.plus}&nbsp;Add Time of Day</div>`,
  // 5. The section header's own menu (in Edit, the ··· ; on Today, touch and hold the header: a shortcut).
  '5-section-menu': `${status}${nav({ editing: true })}<div class="title">Edit Today</div>
    <div class="foot" style="margin-top:2px">Drag habits into the order you do them, or into another time of day. Tap a time of day to rename it or change when it starts.</div>
    ${secEdit('Morning', '6:00 AM')}<div class="card">${row(habits.vit, { edit: true })}${row(habits.tea, { edit: true })}${row(habits.push, { edit: true })}</div>
    <div class="dim"></div>
    <div class="menu" style="top:236px;right:16px">
      <div class="i" style="border-top:none">Rename or Change Time…</div>
      <div class="i">Sort by Reminder Time</div>
      <div class="i">Sort A to Z</div>
      <div class="gap"></div>
      <div class="i red">Delete Morning…</div>
    </div>`,
  // 6. Editing one time of day.
  '6-time-of-day': `${today()}<div class="dim"></div>
    <div class="sheet"><div class="bar"><span class="blue">Cancel</span><b>Morning</b><span class="blue" style="font-weight:600">Save</span></div>
      <div class="fh">NAME</div><div class="form"><div class="r">Morning</div></div>
      <div class="form"><div class="r"><span>Starts at</span><span class="blue">6:00 AM</span></div></div>
      <div class="ff">Morning lasts until Afternoon starts, at 12:00 PM. Habits you put here show in this part of your day.</div>
      <div class="form"><div class="r red">Delete Morning</div></div>
      <div class="ff">Its 3 habits move to Anytime. Nothing is lost.</div>
    </div>`,
};

const browser = await chromium.launch({ executablePath: '/opt/pw-browsers/chromium-1194/chrome-linux/chrome' }).catch(() => chromium.launch());
const page = await browser.newPage({ viewport: { width: 393, height: 852 }, deviceScaleFactor: 3 });
for (const [name, body] of Object.entries(screens)) {
  await page.setContent(`<!doctype html><html><head><meta charset="utf-8"><style>${css}</style></head><body>${body}</body></html>`, { waitUntil: 'networkidle' });
  await page.screenshot({ path: `${OUT}/${name}.png` });
  console.log('wrote', name);
}
await browser.close();
