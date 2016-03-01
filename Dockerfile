FROM vicamo/ubuntu-debootstrap:14.04-armhf

RUN apt-get -qq update && apt-get install -qq -y software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y && apt-get -qq update && apt-get -qq -y install libstdc++6
ADD core/mongo* /tmp/*
RUN chown root:root /tmp/mongo* && chmod 755 /tmp/mongo*
RUN mkdir /var/log/mongodb && mkdir /var/lib/mongodb
ADD mongodb.conf /etc/mongodb.conf

EXPOSE 27017

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh","mongod"]
