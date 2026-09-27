#!/bin/bash
#
# Build the application in src/ and compare its output against the
# reference outputs in tests/.

set -u

SRC_DIR="$(dirname "$0")/src"
TESTS_DIR="$(dirname "$0")/tests"
APP="$SRC_DIR/stats"

passed=0
failed=0

echo "=== Building the application ==="
if ! make -C "$SRC_DIR"; then
    echo "FAILED: the application does not build." 1>&2
    exit 1
fi

echo
echo "=== Running tests ==="
for input in "$TESTS_DIR"/*.in; do
    name=$(basename "$input" .in)
    ref="$TESTS_DIR/$name.ref"

    if ! test -f "$ref"; then
        echo "SKIP $name: no reference output ($ref)"
        continue
    fi

    got=$("$APP" < "$input")
    if test "$got" = "$(cat "$ref")"; then
        echo "PASS $name"
        passed=$((passed + 1))
    else
        echo "FAIL $name"
        echo "  expected: $(cat "$ref" | tr '\n' '|')"
        echo "  got:      $(echo "$got" | tr '\n' '|')"
        failed=$((failed + 1))
    fi
done

echo
echo "=== $passed passed, $failed failed ==="
test "$failed" -eq 0
