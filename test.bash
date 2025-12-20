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
OUT=$(echo "1000.5 8 20" | "$COMMAND")
echo "${OUT}" | grep -q "額面給与:" || ng "$LINENO"

# 3
OUT=$(echo "0 8 20" | "$COMMAND")
echo "${OUT}" | grep -q "0円" || ng "$LINENO"

# 4
OUT=$(echo "0 0 0" | "$COMMAND")
echo "${OUT}" | grep -q "0円" || ng "$LINENO"

# 5
OUT=$(echo "100000 24 31" | "$COMMAND")
echo "${OUT}" | grep -q "年収" || ng "$LINENO"

# 6
OUT=$(printf "1000\t8\t20\n" | "$COMMAND")
echo "${OUT}" | grep -q "額面給与:" || ng "$LINENO"

# 7
OUT=$(echo "  1000 8 20  " | "$COMMAND")
echo "${OUT}" | grep -q "額面給与:" || ng "$LINENO"

# 8
OUT=$(echo "1000 5 20" | "$COMMAND")
echo "${OUT}" | grep -q "適用税率: 所得税 0% + 住民税 0% (計 0%)" || ng "$LINENO"
echo "${OUT}" | grep -q "推定手取り年収: 1,200,000円" || ng "$LINENO"

# 9
OUT=$(echo "1100 5 20" | "$COMMAND")
echo "${OUT}" | grep -q "適用税率: 所得税 5% + 住民税 0% (計 5%)" || ng "$LINENO"

# 10
OUT=$(echo "1200 5 20" | "$COMMAND")
echo "${OUT}" | grep -q "適用税率: 所得税 5% + 住民税 10% (計 15%)" || ng "$LINENO"


# ====================
# 異常系（入力不正）
# ====================

# 11
echo "1000 8" | "$COMMAND" 2> /dev/null
[ "$?" = 1 ] || ng "$LINENO"

# 12
echo -n "" | "$COMMAND" 2> /dev/null
[ "$?" = 1 ] || ng "$LINENO"

# 13
echo "1000 a 20" | "$COMMAND" 2> /dev/null
[ "$?" = 1 ] || ng "$LINENO"

# 14
echo "1000 8 20 5" | "$COMMAND" 2> /dev/null
[ "$?" = 1 ] || ng "$LINENO"

# 15
echo "1000" | "$COMMAND" 2> /dev/null
[ "$?" = 1 ] || ng "$LINENO"

# 16
echo "   " | "$COMMAND" 2> /dev/null
[ "$?" = 1 ] || ng "$LINENO"

# 17
OUT=$(printf "1000 8 20\n1000 a 20\n" | "$COMMAND" 2> /dev/null)
[ "$?" = 1 ] || ng "$LINENO"


[ "${res}" = 0 ] && echo "--- All Tests Passed: OK ---"
exit $res

