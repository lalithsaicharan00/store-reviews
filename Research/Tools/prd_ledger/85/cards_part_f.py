# -*- coding: utf-8 -*-
import sys; sys.path.insert(0, "Tools/prd_ledger/85")
from _lib import c, table, save

c(54, "§0.3 (web fallback); §8.10 (web as fallback); §3.3 (workarounds)", "must-have", "A stable fallback surface while the app lags: the web version is recommended as the workaround by reviewers across the whole span ('I strongly recommend use web version on iPad'; 'you can try the web version for a more stable experience' — the corpus's last review, 5★) and by §8.10 'as a stable fallback until the app matches it'; REV_TIP 33 trade reinstall / log-out / use-the-website; a multi-platform service should treat one surface as the reference implementation and say so.", "web app as fallback", "mixed", "website mentions 199 (5.78%); REV_TIP 33", "must-have", "Very strong", "generalisable", ["1833698218", "14516534730"], "", "")

c(55, "§0.2 (2018-02-26 feature day); §7.4 E2; §6.10", "dont", "Do not accept a store feature you cannot serve: the App Store feature on 2018-02-26 brought new users who could not reach the servers to register — 22 reviews that day, 67 in the month (13 sign-up, 13 server failures, 2.91★), 'Downloaded the app this morning because of the App Store recommendation' at 1★; 2018 is the corpus's lowest-rated year (3.32★, sign-up 69, server 53).", "featured while sign-up servers failed", "1★-burst", "2018-02-26: 22 reviews; 2018-02: 67 / 2.91★; 2018 3.32★", "dont", "Meaningful", "generalisable", ["2250058640", "2238771865"], "", "")

save("a")
