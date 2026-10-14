# Журнал команд · практическая работа №3

ФИО: Гаврилов Владислав Михайлович
Группа: РПО/1
Дата: 14.10.2026

В журнал записывается каждая команда, которая изменила файлы или помогла найти ответ.
Безопасный пример — вариант команды, который сначала показывает результат и ничего не удаляет.

| № | Команда | Что сделала | Безопасный пример |
|---|---|---|---|
| 1 | `mkdir -p ~/files-lab/sorted/{docs,images,logs,data}` | Создаёт каталог `sorted` с 4 подкаталогами одной командой | `ls ~/files-lab` (проверить, что создалось) |
| 2 | `mv "my report.txt" my-report.txt` | Переименовывает файл с пробелом в имени | `ls -l "my report.txt" my-report.txt` |
| 3 | `mv report-*.txt my-report.txt ~/files-lab/sorted/docs/` | Переносит все отчёты в `sorted/docs` | `ls report-*.txt my-report.txt` |
| 4 | `mv *.{jpg,png} ~/files-lab/sorted/images/` | Переносит изображения обоих форматов | `ls *.{jpg,png}` |
| 5 | `mv app.log app.log.1 app.log.2 error.log ~/files-lab/sorted/logs/` | Переносит журналы в `sorted/logs` | `ls app.log* error.log` |
| 6 | `cp *.csv ~/files-lab/sorted/data/` | Копирует CSV, оригиналы остаются | `ls *.csv` |
| 7 | `rm *.bak` | Удаляет резервные копии | `ls *.bak` (перед `rm`) |
| 8 | `find ~/files-lab -size +1M -exec ls -lh {} \; -delete` | Находит файл >1 МБ, показывает размер и удаляет | `find ~/files-lab -size +1M -exec ls -lh {} \;` |
| 9 | `find inbox -mtime +30 > ~/files-lab/answers.txt` | Файлы старше 30 дней → в `answers.txt` | `find inbox -mtime +30` |
| 10 | `ls -A inbox` и `cat .hidden >> ~/files-lab/answers.txt` | Находит скрытый файл и дописывает его содержимое | `ls -A inbox` |
| 11 | `man ls` → `/sort by size` → `ls -lS ~/files-lab/sorted/images >> ~/files-lab/answers.txt` | Ищет в man ключ сортировки по размеру | `man ls` (просмотр) |
| 12 | `locate os-release \| head -1 >> ~/files-lab/answers.txt` | Ищет путь к `os-release`, дописывает первый | `locate os-release` |