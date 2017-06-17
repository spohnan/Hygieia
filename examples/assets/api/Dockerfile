
FROM openjdk:jre-alpine

ENV SPRING_DATA_MONGODB_DATABASE=dashboard
ENV SPRING_DATA_MONGODB_HOST=10.0.1.1
ENV SPRING_DATA_MONGODB_PORT=9999
ENV SPRING_DATA_MONGODB_USERNAME=db
ENV SPRING_DATA_MONGODB_PASSWORD=ENC(aSPTk36yA/ZklUg75CrZ8w==)

RUN mkdir /hygieia
COPY assets/api/api-properties-builder.sh /hygieia/
COPY build/api.jar /hygieia

WORKDIR /hygieia

EXPOSE 8080

CMD ./api-properties-builder.sh &&\
    java -Djava.security.egd=file:/dev/./urandom -jar api.jar --spring.config.location=/hygieia/dashboard.properties