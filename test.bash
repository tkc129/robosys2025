#!/bin/bash
# SPDX-FileCopyrightText: 2025 Takashi Iwasaki
# SPDX-License-Identifier: BSD-3-Clause

ng () {
	echo ${1}line wrong
	res=1
}

res=0

out=$(seq 5 | ./plus)

[ "${out}" = 15 ] || ng "$LINENO"


out=$(echo a | ./plus)

[ "$?" = 1 ]        || ng "$LINENO"
[ "${out}" = "" ]   || ng "$LINENO"

out=$(echo | ./plus)

[ "$?" = 1 ]        || ng "$LINENO"
[ "${out}" = "" ]   || ng "$LINENO"

[ "${res}" = 0 ]  && echo OK

exit $res
