#!/bin/bash
# team-lab-check.sh — проверка лабораторной "Роли и схема доступа"
# Запуск: sudo bash team-lab-check.sh

PASS=0
FAIL=0
TOTAL=21

ok()   { echo "[ OK ]  $1"; PASS=$((PASS+1)); }
fail() { echo "[FAIL]  $1"; FAIL=$((FAIL+1)); }

check_group() {
    getent group "$1" >/dev/null && ok "группа $1 существует" || fail "группа $1 отсутствует"
}
check_user() {
    id "$1" >/dev/null 2>&1 && ok "пользователь $1 существует" || fail "пользователь $1 отсутствует"
}
check_in_group() {
    id -nG "$1" 2>/dev/null | tr ' ' '\n' | grep -qx "$2" \
        && ok "$1 в группе $2" || fail "$1 НЕ в группе $2"
}
check_not_in_group() {
    id -nG "$1" 2>/dev/null | tr ' ' '\n' | grep -qx "$2" \
        && fail "$1 НЕ должен быть в $2" || ok "$1 не в группе $2"
}
check_dir() {
    [ -d "$1" ] && ok "каталог $1 существует" || fail "каталог $1 отсутствует"
}
check_perm() {
    local p
    p=$(stat -c '%a %G' "$1" 2>/dev/null)
    [ "$p" = "$2 $3" ] && ok "$1: права $2, группа $3" \
                       || fail "$1: ожидалось '$2 $3', получено '$p'"
}

# --- группы ---
check_group mobile-dev
check_group mobile-qa

# --- пользователи ---
check_user lead
check_user dev
check_user qa
check_user guest

# --- членство ---
check_in_group lead mobile-dev
check_in_group lead mobile-qa
check_in_group lead sudo
check_in_group dev  mobile-dev
check_not_in_group dev mobile-qa
check_in_group qa   mobile-qa
check_not_in_group qa mobile-dev
check_not_in_group guest mobile-dev
check_not_in_group guest mobile-qa
check_not_in_group guest sudo

# --- каталоги и права ---
check_dir  /srv/mobile/src
check_dir  /srv/mobile/reports
check_perm /srv/mobile/src    2770 mobile-dev
check_perm /srv/mobile/reports 2770 mobile-qa

echo
echo "Итог: $PASS из $TOTAL"
[ "$PASS" -eq "$TOTAL" ] && exit 0 || exit 1