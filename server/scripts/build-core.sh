#!/bin/sh
# Rebuilds the shared Kotlin sync rules (Core/sync) for JavaScript and copies them into server/core/.
# The output is committed, so deploying the server never needs Java; `npm run check:core` makes sure it's current.
set -e
cd "$(dirname "$0")/../../Core"
./gradlew -q :sync:jsNodeProductionLibraryDistribution
out=../server/core
rm -rf "$out" && mkdir -p "$out"
cp sync/build/dist/js/productionLibrary/*.mjs sync/build/dist/js/productionLibrary/*.d.mts "$out"/
# The source maps are large and only point at Kotlin sources; drop the references to them.
for f in "$out"/*.mjs; do sed -i.bak '/^\/\/# sourceMappingURL=/d' "$f" && rm "$f.bak"; done
echo "Copied the sync rules to server/core/"
