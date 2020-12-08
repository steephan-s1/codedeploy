FROM ubuntu:latest
  
RUN apt update && apt install  openssh-server sudo -y && \
    mkdir -p  /home/ubuntu/.ssh
COPY remote-key.pub /home/ubuntu/.ssh/authorized_keys
RUN useradd -rm -d /home/ubuntu/.ssh -s /bin/bash -g root -G sudo -u 1000 remote_user

RUN echo remote_user:1234 |/usr/sbin/chpasswd && \
    chmod 700 /home/ubuntu/.ssh/authorized_keys
RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]                       
