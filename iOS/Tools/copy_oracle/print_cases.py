from copy_oracle import *
cases = [[1],[15],[1,15],[1,10,20],[31],[30],[29,30,31],[1,2,3,4,5],[1,2,3,15],[1,2,3,10,11,12],[1,2],[5,6,20,21],
         [1,5,9,13,17,21,25],[1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31],[2,4,6,8,10,12,14,16,18,20,22,24,26,28,30],
         list(range(1,32)),list(range(1,31)),[1,15,28,31],[28,29,30,31],[1,2,4,5,7,8]]
for c in cases:
    print(f"{str(c)[:40]:42s} {month_dates_text(c)} | every 2: {month_dates_text(c, interval=2)} | no last: {month_dates_text(c, use_last_day=False)}")
for o in (1,2,3,4,5,-1):
    print(month_weekday_text(o, 7), "|", month_weekday_text(o, 2, 3))
for m, d, n in ((10,1,1),(2,29,1),(12,25,2),(1,1,5)): print(year_text(m,d,n))
for n in (1,2,3,14): print(every_n(n,"day"))
for n,days in ((2,{2,4}),(3,{3}),(2,{1,2,3,4,5}),(2,{2,3,4,5,6}),(2,set(range(1,8))),(2,{2,3,4,5,6,7}),(4,{6,7})): print(with_week_interval(n,days,2))
