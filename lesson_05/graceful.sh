#!/bin/bash
# graceful.sh — аккуратное завершение по TERM
# Запуск: ./graceful.sh

TMP="/tmp/graceful-$$.tmp"
echo "temp file: $TMP" > "$TMP"

trap 'rm -f "$TMP"; echo "TERM получен, удаляю $TMP"; exit 0' TERM

while true; do
    sleep 1
done
Запуск и проверка TERM:

bash
chmod +x ~/lesson_05/graceful.sh
~/lesson_05/graceful.sh &
G=$!
sleep 1
ls -l /tmp/graceful-*.tmp
kill -TERM $G
wait $G
echo "код завершения: $?"
ls -l /tmp/graceful-*.tmp || echo "временного файла нет"
Ожидаемо: код 0, временный файл удалён.

Запуск и проверка KILL:

bash
~/lesson_05/graceful.sh &
G=$!
sleep 1
kill -9 $G
wait $G
echo "код завершения: $?"
ls -l /tmp/graceful-*.tmp
Ожидаемо: код 137, временный файл остался.

Разница: TERM перехватывается через trap, скрипт успевает удалить временный файл и выйти с кодом 0. 
KILL перехватить нельзя: ядро завершает процесс немедленно, trap не срабатывает, временный файл остается.