# Q46 codebook — how many habits people track
Every value is the number the reviewer wrote. A range ("5-6") counts as its midpoint.

OWN=n        how many habits the reviewer tracks (or tracked recently) in the app. This is the main measure.
CAP          (flag on OWN) that count is where a free-plan limit stopped them, so it is cut short. Left out of the main distribution.
START=n      how many they started with
PAST=n       how many they had before cutting back
WANT=n       how many they want or need to track
GT=n         says n is not enough (usually the app's limit)
ENOUGH=n     says n is enough or the right amount (usually the app's limit)
FREEWANT=n   the size they think a free plan should allow
ADVICE=n     how many they advise others to start with ("MULTI" means start several at once)
DUP          the same text posted twice; counted once

Screened: every App Store and Play Store habit-app review (1,487,223 in the whole corpus; native apps were left out). A review matched if it had a number within two words of "habit(s)". That gave 6,084 matches.
Left out without reading: 525 reviews where the only match was "N habit trackers/apps" ("I tried 10 habit apps").
Read by hand: 5,559. Coded: 1,231 statements. Every quote was checked against its review by script (0 mismatches).
