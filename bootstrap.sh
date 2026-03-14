#!/bin/bash

# 1. Оновлення пакетів та встановлення Apache2
apt-get update
apt-get install -y apache2

# 2. Налаштування кастомного порту в ports.conf
# Замінюємо стандартний "Listen 80" на твій порт (8081)
sed -i "s/Listen 80/Listen ${web_port}/" /etc/apache2/ports.conf

# 3. Створення DocumentRoot
mkdir -p ${doc_root}

# 4. Створення тестової сторінки index.html
cat <<EOF > ${doc_root}/index.html
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <title>Lab 3 </title>
    <style>
        body { font-family: sans-serif; text-align: center; padding-top: 50px; }
        h1 { color: #4285F4; }
    </style>
</head>
<body>
    <h1>Вітаємо! Apache налаштовано через Terraform</h1>
    <p><b>Server Name:</b> ${server_name}</p>
    <p><b>Port:</b> ${web_port}</p>
    <p><b>DocRoot:</b> ${doc_root}</p>
    <hr>
    <p>Виконав: Циганок</p>
</body>
</html>
EOF

# 5. Надання прав доступу користувачу apache (www-data)
chown -R www-data:www-data ${doc_root}
chmod -R 755 ${doc_root}

# 6. Створення конфігурації VirtualHost
# Додаємо блок <Directory> з "Require all granted", щоб уникнути 403 Forbidden
cat <<EOF > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:${web_port}>
    ServerName ${server_name}
    DocumentRoot ${doc_root}

    AddDefaultCharset UTF-8

    <Directory ${doc_root}>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>

    ErrorLog \$${APACHE_LOG_DIR}/error.log
    CustomLog \$${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# 7. Активація змін та перезапуск Apache
systemctl restart apache2