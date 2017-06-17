FROM openjdk:jre-alpine

RUN mkdir /hygieia
COPY build/jenkins-build-collector*.jar /hygieia/
COPY assets/collectors/jenkins/jenkins-build-properties-builder.sh /hygieia/

WORKDIR /hygieia

CMD ./jenkins-build-properties-builder.sh && \
  java -jar jenkins-build-collector*.jar --spring.config.location=/hygieia/hygieia-jenkins-build-collector.properties