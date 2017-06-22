FROM openjdk:jre-alpine

RUN mkdir /hygieia

COPY build/gitlab-scm-collector*.jar /hygieia/
COPY assets/collectors/gitlab-scm/gitlab-properties-builder.sh /hygieia/

WORKDIR /hygieia

CMD ./gitlab-properties-builder.sh && \
  java -jar gitlab-scm-collector*.jar --spring.config.location=/hygieia/hygieia-gitlab-scm-collector.properties