FROM ubuntu:14.04
MAINTAINER aaron@9minutesnooze.com

ENV SICKBEARD_VERSION master

RUN apt-get -q update 
RUN apt-get -qy --force-yes install curl
RUN apt-get install -qy --force-yes python-cheetah && \
    curl -L https://github.com/midgetspy/Sick-Beard/tarball/$SICKBEARD_VERSION -o sickbeard.tgz && \
    tar -xvf sickbeard.tgz -C /  &&\
    mv /midgetspy-Sick-Beard-* /sickbeard/ &&\
    rm  /sickbeard.tgz && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

VOLUME ["/config","/data"]

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 8081

CMD ["/start.sh"]
