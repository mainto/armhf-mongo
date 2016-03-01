FROM vicamo/ubuntu-debootstrap:14.04-armhf

RUN apt-get -qq update && apt-get install -qq -y software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y && apt-get -qq update && apt-get -qq -y install libstdc++6
RUN apt-get install -qq -y curl
RUN curl https://github.com/mainto/armhf-mongo/releases/download/3.0.9/core_mongodb.tar.gz \
		--silent -L | tar -xzC /bin
RUN chown root:root /bin/mongo* && chmod 755 /bin/mongo*
RUN mkdir -p /data/db
ADD mongodb.conf /etc/mongodb.conf

EXPOSE 27017 27018 27019 28017

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh","mongod"]
