# Таблица тестов доступа · команда mobile-app

ФИО: Гаврилов Владислав Михайлович
Группа: РПО/1
Дата: 14.10.2026

| № | Пользователь | Команда | Ожидается | Получено |
|---|---|---|---|---|
| 1 | lead | `sudo -u lead touch /srv/mobile/src/lead.txt` | разрешено | разрешено |
| 2 | lead | `sudo -u lead ls /srv/mobile/reports` | разрешено | разрешено |
| 3 | dev | `sudo -u dev touch /srv/mobile/src/main.kt` | разрешено | разрешено |
| 4 | dev | `sudo -u dev ls /srv/mobile/reports` | отказ: `Permission denied` | `Permission denied` |
| 5 | qa | `sudo -u qa touch /srv/mobile/reports/test-1.md` | разрешено | разрешено |
| 6 | qa | `sudo -u qa ls /srv/mobile/src` | отказ: `Permission denied` | `Permission denied` |
| 7 | guest | `sudo -u guest ls /srv/mobile/src` | отказ: `Permission denied` | `Permission denied` |
| 8 | guest | `sudo -u guest ls /srv/mobile/reports` | отказ: `Permission denied` | `Permission denied` |

## Схема ролей

| Роль | Учётная запись | Группы | Каталоги | Может | Не может |
|---|---|---|---|---|---|
| руководитель | lead | mobile-dev, mobile-qa, sudo | src, reports | всё в проекте + sudo | — |
| разработчик | dev | mobile-dev | src | работать в `src` | `reports`, sudo |
| тестировщик | qa | mobile-qa | reports | работать в `reports` | `src`, sudo |
| внешний сотрудник | guest | — | — | только свою домашнюю папку | `src`, `reports`, sudo |

## Почему постоянная работа под root опасна

1. Одна ошибка под root необратима.
2. Компрометация root = полный контроль над машиной.
3. Действия root не отследить и не разграничить по людям.