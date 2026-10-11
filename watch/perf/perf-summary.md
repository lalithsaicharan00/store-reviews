| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms |
|---|---|---|---|
| Today: +1 (tap to filled button) | 11.6 | 90 ms | 0 |
| Today: ✓ and Undo | 8.6 | 47 ms | 0 |
| Today: scrolling 30 habits | 3.7 | 42 ms | 0 |
| Day details: +1 | 33.3 | 80 ms | 0 |
| Routine: paging with the Crown | 4.7 | 38 ms | 0 |
| Today: a 5,000-change batch from the iPhone arrives | 11.5 | 139 ms | 1 |
| Writing the complication snapshot (10 times) | 0.0 | 0 ms | 0 |

Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word.

Openings (longest stall in the 1.5 s after the command) and launches:

- Launch to a usable Today (round 1 , cold): 4249 ms
- Launch to a usable Today (round 2, warm): 7912 ms
- Day details (first): longest stall 200 ms
- Day details (again): longest stall 86 ms
- Routine (open): longest stall 368 ms

Notes (storage and the first fill):

- first fill on the Watch simulator: 375000 logs (15 years) in 76 parts, biggest 209 KB, 15.3 MB sent; 759.3 s (Today right after 27.0 s; the stand-in iPhone made it in 348.1 s); Watch database 225 MB; reading it all for Today 26.98 s (375000 logs); peak memory 202 MB
