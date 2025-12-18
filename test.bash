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
# 出力全体の中に「推定手取り年収: 1,632,000円」という文字列があるか確認します
OUT=$(echo "1000 8 20" | "$COMMAND")
echo "${OUT}" | grep -q "推定手取り年収: 1,632,000円" || ng "$LINENO"

# テスト2: 異常系（引数不足）
echo "1000 8" | "$COMMAND" 2> /dev/null
[ "$?" = 1 ] || ng "$LINENO"

# テスト3: 異常系（空入力）
echo -n "" | "$COMMAND" 2> /dev/null
[ "$?" = 1 ] || ng "$LINENO"

[ "${res}" = 0 ] && echo "--- All Tests Passed: OK ---"
exit $res
