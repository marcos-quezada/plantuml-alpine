FROM maven:3-jdk-8-alpine

RUN apk update && apk add --no-cache graphviz ttf-droid ttf-droid-nonlatin

COPY pom.xml /app/
COPY src /app/src/

ENV MAVEN_CONFIG=/app/.m2
WORKDIR /app
RUN mvn package

# chmod required to ensure any user can run the app
RUN mkdir /app/.m2 && chmod -R a+w /app
EXPOSE 1980
ENV HOME /app

CMD java -Djetty.contextpath=/ -jar target/dependency/jetty-runner.jar --port 1980 target/plantuml.war

# To run with debugging enabled instead
#CMD java -Dorg.eclipse.jetty.util.log.class=org.eclipse.jetty.util.log.StdErrLog -Dorg.eclipse.jetty.LEVEL=DEBUG -Djetty.contextpath=/ -jar target/dependency/jetty-runner.jar target/plantuml.war
