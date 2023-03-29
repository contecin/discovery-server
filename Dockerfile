FROM gradle:jdk17-alpine AS discovery_server

COPY . /home/gradle/source

WORKDIR /home/gradle/source

RUN gradle clean build

# actual container
FROM openjdk:17-alpine

COPY --from=discovery_server /home/gradle/source/build/libs/*-SNAPSHOT.jar /app/discovery_server.jar

WORKDIR /app

EXPOSE 8761

# ENTRYPOINT ["java","-jar","discovery_server.jar"]

ENTRYPOINT ["sh", "-c", "java ${JAVA_OPTS} -jar discovery_server.jar"]