# -*- coding: utf-8 -*-
import sys; sys.path.insert(0, "Tools/prd_ledger/77")
from _lib import c, table, save

c(82, "§0.4; §8.1.2; §2.2 SKU table", "anti-pattern", "SKU sprawl with no periods: 10 in-app purchases from $2.99 to $29.99 under three product names ('Momentumly Plus', 'Premium Habit Tracking', 'Premium'), none showing a billing term, beside a description whose only money paragraph is auto-renewal boilerplate — cost: three reviews over 12 months hold three different beliefs about whether a lifetime purchase exists, one of them a 2★ whose entire text is that question, and reviewers name the paid tier five different ways.", "10 SKUs / 3 names / no periods", "blocked-conversion", "10 SKUs; 3 names; lifetime contradiction across 3 reviews; 1 2★", "dont", "High-priority", "generalisable", ["12552768633", "12652787691", "13941527190"], "", "")

c(83, "§8.2.2; §0.9; §2.3 widgets row", "anti-pattern", "Gating the retention surface and the core loop at the same time: the free tier is one habit and the widget (reported paid, single-source) shows one habit — 'a widget is the cheapest daily-retention surface a habit tracker has, and this one is gated and limited to a single habit at the same time as the free tier is limited to a single habit'; cost: a 1★ whose whole text is 'You have to pay for widgets' and two otherwise 4–5★ users who must open the app to see what is left.", "widgets paid + 1-habit cap", "complaint", "widget_gap 5 / 3.80★; 1 1★", "dont", "High-priority", "generalisable", ["13277885578", "13429536002", "13839542276"], "", "")

save("a")
