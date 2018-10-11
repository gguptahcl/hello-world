FROM openjdk:8-jdk-alpine
RUN apk update && apk add bash
RUN apk add --update \
    curl \
    && rm -rf /var/cache/apk/*
VOLUME /tmp
EXPOSE 8080
ARG JAR_FILE=target/hello-world-docker-0.1.0.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
