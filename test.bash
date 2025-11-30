#!/bin/bash
# SPDX-FileCopyrightText: 2025 Takashi Iwasaki
# SPDX-License-Identifier: BSD-3-Clause

ng () {
    echo "NG: ${1}line wrong"
    res=1
}

res=0
COMMAND="./stats"

OUT=$(seq 5 | "$COMMAND" | tr '\n' ' ')
EXPECTED_1="count: 5 sum: 15.0 avg: 3.00 max: 5.0 min: 1.0 "
[[ "${OUT}" == "${EXPECTED_1}" ]] || ng "$LINENO"

OUT=$(printf "1\n2\n3.5\n" | "$COMMAND" | tr '\n' ' ')
EXPECTED_2="count: 3 sum: 6.5 avg: 2.17 max: 3.5 min: 1.0 "
[[ "${OUT}" == "${EXPECTED_2}" ]] || ng "$LINENO"


OUT=$(echo a | "$COMMAND" 2> /dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${OUT}" = "" ] || ng "$LINENO"

OUT=$(echo "" | "$COMMAND" 2> /dev/null)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${OUT}" = "" ] || ng "$LINENO"

OUT=$(seq 1000 | "$COMMAND" | tr '\n' ' ')
EXPECTED_5="count: 1000 sum: 500500.0 avg: 500.50 max: 1000.0 min: 1.0 "
[[ "${OUT}" == "${EXPECTED_5}" ]] || ng "$LINENO"


[ "${res}" = 0 ] && echo "--- All Tests Passed: OK ---"
exit $res

