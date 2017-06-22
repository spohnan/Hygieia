FROM openjdk:jre-alpine

RUN mkdir /hygieia

COPY build/gitlab-feature-collector*.jar /hygieia/
COPY assets/collectors/gitlab-features/gitlab-properties-builder.sh /hygieia/

WORKDIR /hygieia

VOLUME ["/hygieia/logs"]

CMD ./gitlab-properties-builder.sh && \
  java -jar gitlab-feature-collector*.jar --spring.config.location=/hygieia/hygieia-gitlab-feature-collector.properties

