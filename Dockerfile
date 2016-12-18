FROM frolvlad/alpine-oraclejdk8:slim
MAINTAINER Vincent Dubois <dubois.vct@free.fr>

VOLUME /tmp
COPY module.jar /usr/local/bin/app.jar
RUN sh -c 'touch /usr/local/bin/app.jar'
EXPOSE 8080 5701/udp
COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh
#CMD /usr/local/bin/run.sh 30
