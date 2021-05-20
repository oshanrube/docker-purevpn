FROM ubuntu:18.04
MAINTAINER Alexey Baikov <sysboss[@]mail.ru>

RUN apt-get update \
 && apt-get install -y wget iproute2 net-tools iputils-ping expect curl openvpn openssh-server unzip \
 && apt-get install -y --no-install-recommends expect

RUN cd /etc/openvpn && wget https://s3-us-west-1.amazonaws.com/heartbleed/windows/New+OVPN+Files.zip -O purevpn.zip && unzip purevpn.zip && mv New\ OVPN\ Files purevpn && rm -f purevpn.zip

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
