#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/../../.."
mkdir -p Research/Temp/analytics
swiftc -swift-version 6 -O \
  iOS/Habits/Analytics/AnalyticsContract.swift \
  iOS/Habits/Analytics/AnalyticsLedger.swift \
  iOS/Habits/Analytics/AnalyticsTransport.swift \
  iOS/Tools/analytics/ProviderSmoke.swift \
  -o Research/Temp/analytics/provider_smoke
Research/Temp/analytics/provider_smoke
