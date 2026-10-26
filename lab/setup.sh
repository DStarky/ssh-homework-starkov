#!/bin/bash
# два контейнера в одной сети: client 172.30.0.10 и server 172.30.0.20
# openssh-server на server специально не стоит, ставится руками в кейсе 1
set -e
cd "$(dirname "$0")"

docker build -q -t ssh-lab .
docker network create --subnet 172.30.0.0/24 lab-net >/dev/null

for host in client:10 server:20; do
    name=${host%:*}
    docker run -d --name "$name" --hostname "$name" --privileged --cgroupns=host \
        -v /sys/fs/cgroup:/sys/fs/cgroup:rw --network lab-net --ip "172.30.0.${host#*:}" ssh-lab >/dev/null
done

sleep 5
# без этого sshd пускает только root: висит /run/nologin
for c in client server; do docker exec "$c" systemctl start systemd-user-sessions.service; done
docker ps --format 'table {{.Names}}\t{{.Status}}'
