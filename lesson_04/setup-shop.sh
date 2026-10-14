#!/bin/bash
# setup-shop.sh — настройка каталога проекта shop
# Запуск: sudo bash setup-shop.sh

set -e

echo ">>> 1. Группа и пользователи"

groupadd -f shop-dev

for u in alex bella chris; do
    if ! id "$u" >/dev/null 2>&1; then
        useradd -m -s /bin/bash "$u"
        echo "  создан: $u"
    else
        echo "  уже есть: $u"
    fi
done

for u in alex bella chris; do
    echo "  >>> задайте пароль для $u"
    passwd "$u"
done

usermod -aG shop-dev alex
usermod -aG shop-dev bella
# chris — только личная группа

echo ">>> 2. Каталоги проекта"
mkdir -p /srv/shop/{src,releases,uploads}
chgrp shop-dev /srv/shop/{src,releases,uploads}

echo ">>> 3. Права по таблице"
chmod 2770 /srv/shop/src
chmod 2775 /srv/shop/releases
chmod 3770 /srv/shop/uploads

echo
echo ">>> Проверка"
id alex; id bella; id chris
ls -l /srv/shop

echo
echo "Готово. Каталоги:"
echo "  /srv/shop/src      2770  (drwxrws---)"
echo "  /srv/shop/releases 2775  (drwxrwsr-x)"
echo "  /srv/shop/uploads  3770  (drwxrws--T)"