#!/bin/bash
cd "/Users/lalith/Desktop/App store reviews"
for t in "habit tracker" "routine tracker" "daily routine" "habit" "streak tracker" "habit builder" "daily habits" "routine planner"; do
  echo "### $t"
  python3 keyword_scan.py "$t" --markets t1+t2 --limit 50 --workers 2 --delay 2.2 2>&1 | tail -2
done
echo "ALL SCANS DONE"
