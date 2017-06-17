FROM openjdk:jre-alpine

RUN mkdir /hygieia
COPY build/sonar-codequality-collector*.jar /hygieia/
COPY assets/collectors/sonarqube/sonar-codequality-properties-builder.sh /hygieia/

WORKDIR /hygieia

CMD ./sonar-codequality-properties-builder.sh && \
  java -jar sonar-codequality-collector*.jar --spring.config.location=/hygieia/hygieia-sonar-codequality-collector.properties