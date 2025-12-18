#!/bin/bash
# SPDX-FileCopyrightText: 2025 Takashi Iwasaki
# SPDX-License-Identifier: BSD-3-Clause

res=0
COMMAND="./calcwage"

# 正常系テスト（時給1000円, 8時間, 20日の場合、年収192万で所得税5%）
OUT=$(echo "1000 8 20" | "$COMMAND" | grep "推定手取り年収")
EXPECTED="推定手取り年収: 1,632,000円"

if [[ "$OUT" == *"$EXPECTED"* ]]; then
    echo "Test: OK"
else
    echo "Test: NG"
    echo "Output: $OUT"
    res=1
fi

exit $res
