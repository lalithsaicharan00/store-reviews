#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/../../.."
mkdir -p Research/Temp/analytics
swiftc -swift-version 6 -D DEBUG -O \
  iOS/Habits/Analytics/AnalyticsContract.swift \
  iOS/Habits/Analytics/AnalyticsLedger.swift \
  iOS/Habits/Analytics/AnalyticsTransport.swift \
  iOS/Habits/Analytics/Analytics.swift \
  iOS/Tools/analytics/ContractTests.swift \
  -o Research/Temp/analytics/contract_tests
Research/Temp/analytics/contract_tests
