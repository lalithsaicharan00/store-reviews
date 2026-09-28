Hand codes for habit_candidates.jsonl (k = line number). Only kept statements are listed; every other k was read and judged
not a habit description (app use, measurement complaint, one-off event, generic list).
CODE = [prefix][frequency][amount][:suffix]
 prefix: L = limit (at most / no more than / cut to)   Q = quit / never / zero   N = count with no target (just track)
 frequency: D every day | Dn N times a day | W N times or days a week (any days) | W1 once a week / weekly
            M1/Mn monthly / N times a month | Y1/Yn yearly / N times a year | I every N days/weeks/months, every other day
            S specific weekdays, weekdays, weekends | H every N hours | T time of day only | 0 no frequency stated
 amount:    A = an amount with a unit. After D/W/M/Y/S/I/0 it is the total for that period (read 10 pages a day = DA;
            100 pages a week = WA; 5-minute walk each day = DA). After Dn/Wn/Mn/Yn it is per time (run 5K 3x a week = WnA)
 suffix: :t time of day or clock time given   :r range ("3-5 cups", "5 to 7 times")   :x something else (end date,
            exception, split sessions, progression, sub-steps, every N hours within a window)
 *  = quotable (clear literal wording worth showing in the document)
Several habits in one sentence: codes separated by commas.
