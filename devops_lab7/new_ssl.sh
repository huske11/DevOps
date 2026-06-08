#!/bin/bash

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout ssl/nginx.key \
    -out ssl/nginx.crt \
    -subj "/CN=nginx-server"

docker exec nginx-cont nginx -s reload

echo "Время выпуска сертификата"
curl -ksv https://127.0.0.1:54443 2>&1 | grep "start date"

echo "Сертификат обновлен"