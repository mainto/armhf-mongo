FROM vicamo/ubuntu-debootstrap:14.04-armhf

RUN apt-get -qq update && apt-get install -qq -y software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y && apt-get -qq update && apt-get -qq -y install libstdc++6
RUN apt-get install -qq -y curl
RUN curl https://github.com/mainto/armfh-mongo/releases/download/3.0.9/core_mongodb.tar.gz \
		--silent -L | tar -xzC /bin
RUN chown root:root /bin/mongo* && chmod 755 /bin/mongo*
RUN mkdir /var/log/mongodb && mkdir /var/lib/mongodb
ADD mongodb.conf /etc/mongodb.conf

EXPOSE 27017

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh","mongod"]
