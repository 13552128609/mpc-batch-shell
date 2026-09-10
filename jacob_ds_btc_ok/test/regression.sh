#!/bin/bash

# 等待上一个 case 派生的所有 attach 控制台进程退出,
# 避免两个 case 的输出互相穿插。
# 采用"连续两次确认无 attach 进程"的稳定判空,避免最后一个 case
# 的后台 attach 还没开始写输出就被当作已结束(空文件)。
drain_attach() {
    local idle=0
    while [ "$idle" -lt 2 ]; do
        if pgrep -f "schnorrmpc attach" >/dev/null 2>&1; then
            idle=0
        else
            idle=$((idle + 1))
        fi
        sleep 0.4
    done
    # 进程退出后给文件落盘一点余量
    sleep 0.5
}

mkdir -p out
CASES=()

# 每个 case 的输出先收进独立文件(暂存),跑完统一打印,不留中间噪音。
run() {
    local name="$1"
    shift
    local out="out/$name.log"

    printf '[RUN] %s ...\n' "$name"
    drain_attach

    "$@" >"$out" 2>&1
    local ret=$?

    drain_attach
    CASES+=("$name:$ret")
}

run "00-mul" ./00/sign_mult.sh 1
run "01-mul" ./01/sign_mult.sh 1
run "02-mul" ./02/sign_mult.sh 1
run "11-mul" ./11/sign_mult.sh 1

run "00" ./00/sign.sh 1
run "01" ./01/sign.sh 1
run "02" ./02/sign.sh 1
run "11" ./11/sign.sh 1

# ===== 全部执行完毕后,统一打印每个 case 的结果 =====
printf '\n'
printf '============================================================\n'
printf '[RESULTS]\n'
printf '============================================================\n'

fail=0
for item in "${CASES[@]}"; do
    name="${item%%:*}"
    ret="${item##*:}"

    # 如果日志里出现 error（不区分大小写），将 ret 置为非 0
    if [ -f "out/$name.log" ] && grep -qi 'error' "out/$name.log"; then
        ret=1
    fi

    printf '\n---------------- %s (exit=%d) ----------------\n' "$name" "$ret"

    # 替代 cat：打印全部日志，并把 error 高亮为红色
    # 'error|$' 的作用是让每一行都匹配，从而输出完整日志
    GREP_COLORS='ms=01;31' grep --color=always -i -E 'error|$' "out/$name.log"

    rm -f "out/$name.log"

    if [ "$ret" -ne 0 ]; then
        fail=1
    fi
done

rmdir out 2>/dev/null

printf '\n============================================================\n'
if [ "$fail" -eq 0 ]; then
    printf '[PASS] all cases\n'
else
    printf '[FAIL] some cases failed\n'
fi
printf '============================================================\n'

exit "$fail"
