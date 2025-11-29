#!/bin/bash
# SPDX-FileCopyrightText: 2025 Takashi Iwasaki
# SPDX-License-Identifier: BSD-3-Clause

ng () {
    echo "NG: ${1} line wrong"
    res=1
}

res=0
COMMAND="./plus"

# 1) 正常動作テスト：1〜5 の統計値 (整数のみ)
OUT=$(seq 5 | "$COMMAND" | tr '\n' ' ')
# 期待値: count: 5, sum: 15.0, avg: 3.00, max: 5.0, min: 1.0
EXPECTED_1="count: 5 sum: 15.0 avg: 3.00 max: 5.0 min: 1.0 " 
[ "${OUT}" = "${EXPECTED_1}" ] || ng "$LINENO"


# 2) 小数を含む入力 (1, 2, 3.5)
# 期待値: avg: 2.17 に丸められることに注意
OUT=$(printf "1\n2\n3.5\n" | "$COMMAND" | tr '\n' ' ')
EXPECTED_2="count: 3 sum: 6.5 avg: 2.17 max: 3.5 min: 1.0 "
[ "${OUT}" = "${EXPECTED_2}" ] || ng "$LINENO"


# 3) 数字以外が含まれる場合はエラー (標準エラーを捨てる)
OUT=$(echo a | "$COMMAND" 2> /dev/null)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${OUT}" = "" ] || ng "$LINENO"


# 4) 空入力はエラー (標準エラーを捨てる)
OUT=$(echo "" | "$COMMAND" 2> /dev/null)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${OUT}" = "" ] || ng "$LINENO"


# 5) 大量データでも動作 (1〜1000)
OUT=$(seq 1000 | "$COMMAND" | tr '\n' ' ')
EXPECTED_5="count: 1000 sum: 500500.0 avg: 500.50 max: 1000.0 min: 1.0 "
[ "${OUT}" = "${EXPECTED_5}" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo "--- All Tests Passed: OK ---"
exit $res
