#!/bin/bash -x

docker stop nginx-cont
docker rm nginx-cont

docker build -t devops/nginx-server ./nginx

docker run -d --name nginx-cont -p 54321:80 -p 54443:443 -v $(pwd)/ssl:/etc/ssl:ro \
    --restart unless-stopped \
    devops/nginx-server

docker ps -a
sleep 5
curl 127.0.0.1:54321
sleep 5
curl -k https://127.0.0.1:54443
docker logs -n 10 nginx-cont