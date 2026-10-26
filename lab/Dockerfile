# Debian 12 с systemd, чтобы внутри работал systemctl
FROM jrei/systemd-debian:12
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      sudo procps iproute2 iputils-ping openssh-client ca-certificates less
RUN useradd -m -s /bin/bash student \
 && echo 'student:student' | chpasswd \
 && echo 'student ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/student \
 && chmod 440 /etc/sudoers.d/student
COPY prompt.sh /tmp/prompt.sh
RUN cat /tmp/prompt.sh >> /home/student/.bashrc && rm /tmp/prompt.sh
# иначе при выходе из ssh debian чистит экран и вывод пропадает
RUN rm -f /home/student/.bash_logout
