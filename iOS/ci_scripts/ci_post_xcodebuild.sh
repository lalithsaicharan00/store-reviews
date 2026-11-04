#!/bin/sh
# Xcode Cloud runs this after every xcodebuild action, whether it passed or failed. It pushes the action's errors and
# test results to the ios-build-results branch, because a cloud session has no Xcode and can only read git:
#   git fetch origin ios-build-results && git show origin/ios-build-results:latest.txt
# Each build's folder says which commit it built, so a session can match a result to its own push.
# RESULTS_GITHUB_TOKEN is a secret in the Xcode Cloud workflow. This script never fails the build: the action's own
# result stands. Never turn on tracing here (`set -x`): it would print the token's header.

REPOSITORY=https://github.com/lalithsaicharan00/store-reviews.git
RESULTS_BRANCH=ios-build-results

if [ -z "$RESULTS_GITHUB_TOKEN" ]; then
  echo "ci_post_xcodebuild: RESULTS_GITHUB_TOKEN isn't set, so no results were pushed"
  exit 0
fi

BUILD_FOLDER="builds/${CI_BUILD_NUMBER:-unknown}-${CI_XCODEBUILD_ACTION:-unknown}"
WORK=$(mktemp -d)
OUT="$WORK/out"
mkdir -p "$OUT"

{
  echo "build=${CI_BUILD_NUMBER:-unknown}"
  echo "action=${CI_XCODEBUILD_ACTION:-unknown}"
  echo "exit_code=${CI_XCODEBUILD_EXIT_CODE:-unknown}"
  echo "branch=${CI_BRANCH:-unknown}"
  echo "commit=${CI_COMMIT:-unknown}"
  echo "workflow=${CI_WORKFLOW:-unknown}"
  echo "xcode=$(xcodebuild -version | tr '\n' ' ')"
  echo "finished_utc=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
} > "$OUT/status.txt"

if [ -n "$CI_RESULT_BUNDLE_PATH" ] && [ -d "$CI_RESULT_BUNDLE_PATH" ]; then
  xcrun xcresulttool get build-results --path "$CI_RESULT_BUNDLE_PATH" > "$OUT/build-results.json" 2> "$OUT/build-results.err"
  case "$CI_XCODEBUILD_ACTION" in
    *test*)
      xcrun xcresulttool get test-results summary --path "$CI_RESULT_BUNDLE_PATH" > "$OUT/test-summary.json" 2> "$OUT/test-summary.err"
      xcrun xcresulttool get test-results tests --path "$CI_RESULT_BUNDLE_PATH" > "$OUT/test-details.json" 2> "$OUT/test-details.err"
      ;;
  esac
else
  echo "result_bundle=missing" >> "$OUT/status.txt"
fi
find "$OUT" -type f -empty -delete

AUTHORIZATION="AUTHORIZATION: basic $(printf 'x-access-token:%s' "$RESULTS_GITHUB_TOKEN" | base64 | tr -d '\n')"

push_results() {
  CHECKOUT="$WORK/checkout"
  rm -rf "$CHECKOUT"
  git init -q "$CHECKOUT"
  cd "$CHECKOUT" || return 1
  git remote add origin "$REPOSITORY"
  git config user.name "Xcode Cloud"
  git config user.email "noreply@oftenenough.com"
  git config "http.https://github.com/.extraheader" "$AUTHORIZATION"
  if git fetch -q --depth 1 origin "$RESULTS_BRANCH" 2> /dev/null; then
    git checkout -q -B "$RESULTS_BRANCH" FETCH_HEAD
  else
    git checkout -q --orphan "$RESULTS_BRANCH"
  fi
  mkdir -p "$BUILD_FOLDER"
  cp -R "$OUT"/. "$BUILD_FOLDER"/
  echo "$BUILD_FOLDER" > latest.txt
  git add -A
  git commit -q -m "Build ${CI_BUILD_NUMBER:-unknown} ${CI_XCODEBUILD_ACTION:-unknown}: exit ${CI_XCODEBUILD_EXIT_CODE:-unknown} [skip ci]"
  git push -q origin "HEAD:refs/heads/$RESULTS_BRANCH"
}

for attempt in 1 2 3; do
  if push_results; then
    echo "ci_post_xcodebuild: pushed $BUILD_FOLDER to $RESULTS_BRANCH"
    exit 0
  fi
  echo "ci_post_xcodebuild: push attempt $attempt failed"
  sleep 5
done
echo "ci_post_xcodebuild: results were not pushed"
exit 0
