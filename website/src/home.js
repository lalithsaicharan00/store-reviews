var n = navigator, u = n.userAgent, d = document.documentElement;
if (/Android/.test(u)) d.dataset.os = 'android';
else if (/iPhone|iPad|iPod/.test(u) || (/Macintosh/.test(u) && n.maxTouchPoints > 1)) d.dataset.os = 'ios';
else if (/Macintosh/.test(u)) d.dataset.os = 'mac';
else if (/Windows/.test(u)) d.dataset.os = 'windows';
document.addEventListener('DOMContentLoaded', function () {
  var clocks = document.querySelectorAll('.run-clock'), widgets = document.querySelectorAll('.run-clock-widget'), since = document.querySelectorAll('.run-since'), i;
  var now = Date.now(), start = now - (94 * 86400 + 7 * 3600 + 42 * 60 + 18) * 1000, widgetStart = now - (19 * 86400 + 12 * 3600 + 32 * 60 + 45) * 1000;
  var two = function (x) { return (x < 10 ? '0' : '') + x; };
  var count = function (from) {
    var s = Math.floor((Date.now() - from) / 1000);
    return Math.floor(s / 86400) + 'd ' + Math.floor(s / 3600) % 24 + ':' + two(Math.floor(s / 60) % 60) + ':' + two(s % 60);
  };
  var tick = function () {
    for (i = 0; i < clocks.length; i++) clocks[i].textContent = count(start);
    for (i = 0; i < widgets.length; i++) widgets[i].textContent = count(widgetStart);
  };
  var day = new Date(start);
  var words = 'Since ' + day.getDate() + ' ' + 'Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec'.split(' ')[day.getMonth()];
  for (i = 0; i < since.length; i++) since[i].textContent = words;
  if (!matchMedia('(prefers-reduced-motion: reduce)').matches) setInterval(tick, 1000);
});
