#!/bin/bash
# SPDX-FileCopyrightText: 2025 Takashi Iwasaki
# SPDX-License-Identifier: BSD-3-Clause

ng () {
    echo "NG: ${1} line wrong"
    res=1
}

res=0
COMMAND="./calcwage"

# 1
OUT=$(echo "1000 8 20" | "$COMMAND")
echo "${OUT}" | grep -q "推定手取り年収: 1,632,000円" || ng "$LINENO"

# 2
echo "1000 8" | "$COMMAND" 2> /dev/null
[ "$?" = 1 ] || ng "$LINENO"

# 3
echo -n "" | "$COMMAND" 2> /dev/null
[ "$?" = 1 ] || ng "$LINENO"

# 4
echo "1000 a 20" | "$COMMAND" 2> /dev/null
[ "$?" = 1 ] || ng "$LINENO"

# 5
echo "1000 8 20 5" | "$COMMAND" 2> /dev/null
[ "$?" = 1 ] || ng "$LINENO"

# 6
echo "1000" | "$COMMAND" 2> /dev/null
[ "$?" = 1 ] || ng "$LINENO"

# 7
echo "   " | "$COMMAND" 2> /dev/null
[ "$?" = 1 ] || ng "$LINENO"

# 8
OUT=$(printf "1000 8 20\n1000 a 20\n" | "$COMMAND" 2> /dev/null)
[ "$?" = 1 ] || ng "$LINENO"

# 9
OUT=$(echo "1000.5 8 20" | "$COMMAND")
echo "${OUT}" | grep -q "額面給与:" || ng "$LINENO"


[ "${res}" = 0 ] && echo "--- All Tests Passed: OK ---"
exit $res
