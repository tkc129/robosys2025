#!/bin/bash
# SPDX-FileCopyrightText: 2025 Takashi Iwasaki
# SPDX-License-Identifier: BSD-3-Clause

ng () {
    echo "NG: ${1} line wrong"
    res=1
}

res=0
COMMAND="./calcwage"

# テスト1: 正常な入力
OUT=$(echo "1000 8 20" | "$COMMAND")
EXPECTED="Input: 1000円/h, 8.0h/日, 20.0日/月 -> 日給: 8000円, 月給: 160,000円, 年収: 1,920,000円"
[ "${OUT}" = "${EXPECTED}" ] || ng "$LINENO"

# テスト2: 値が足りない場合 (エラー終了すべき)
echo "1000 8" | "$COMMAND" 2> /dev/null
[ "$?" = 1 ] || ng "$LINENO"

# テスト3: 数値以外が含まれる場合
echo "1000 8 abc" | "$COMMAND" 2> /dev/null
[ "$?" = 1 ] || ng "$LINENO"

# テスト4: 空入力
echo -n "" | "$COMMAND" 2> /dev/null
[ "$?" = 1 ] || ng "$LINENO"

[ "${res}" = 0 ] && echo "--- All Tests Passed: OK ---"
exit $res
