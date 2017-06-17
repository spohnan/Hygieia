FROM mongo

COPY assets/mongo/mongo-init.js /tmp

VOLUME /data/db /data/configdb

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 27017

CMD ["mongod"]