FROM frolvlad/alpine-oraclejdk8:slim
MAINTAINER Vincent Dubois <dubois.vct@free.fr>

VOLUME /tmp
COPY module.jar /usr/local/bin/app.jar
COPY waitforit-linux_amd64 /usr/local/bin/waitforit
RUN chmod +x /usr/local/bin/waitforit
RUN sh -c 'touch /usr/local/bin/app.jar'
EXPOSE 8080
CMD waitforit -host=config -port=8888 -timeout=30 ; \
    waitforit -host=eureka -port=8761 -timeout=30 ; \
    waitforit -host=rabbitmq -port=5672 -timeout=30 ; \
    java -Djava.security.egd=file:/dev/./urandom -jar /usr/local/bin/app.jar
