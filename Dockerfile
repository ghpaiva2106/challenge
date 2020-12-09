
FROM gradle:4.10 as builder

COPY build.gradle .
COPY src ./src

RUN gradle clean build --no-daemon

FROM openjdk:8-jre-alpine

COPY --from=builder /home/gradle/build/libs/gradle.jar /helloworld.jar

CMD [ "java", "-jar", "-Djava.security.egd=file:/dev/./urandom", "/helloworld.jar" ]