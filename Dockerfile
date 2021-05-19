#
# Build stage
#

FROM maven:3.6.0-jdk-11-slim AS build
RUN mkdir -p /opt/codestar
COPY . /opt/codestar
RUN mvn -f /opt/codestar/pom.xml clean package -Dmaven.test.skip=true

#
# Package stage
#
# Linux with OpenJDK JRE
FROM openjdk:11.0.8-jre-slim-buster
WORKDIR /opt/codestar
COPY --from=build /opt/codestar/target/codestar-0.0.1.jar target/codestar-0.0.1.jar
CMD java -Dserver.port=8080 -jar target/codestar-0.0.1.jar
