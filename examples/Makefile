#
# Usage: If starting from a fresh checkout then run make containers
#
API_IMAGE_NAME                        := demo-hygieia-api
UI_IMAGE_NAME                         := demo-hygieia-ui
MONGO_IMAGE_NAME                      := demo-mongo
JENKINS_IMAGE_NAME                    := demo-jenkins
JENKINS_IMAGE_COLLECTOR_NAME          := demo-jenkins-collector
SONAR_IMAGE_COLLECTOR_NAME            := demo-sonar-collector
GITLAB_SCM_IMAGE_COLLECTOR_NAME       := demo-gitlab-scm-collector
GITLAB_FEATURES_IMAGE_COLLECTOR_NAME  := demo-gitlab-features-collector

ROOT_DIR  := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
BUILD_DIR := ${ROOT_DIR}/build

all: start
PHONY: binaries clean containers containers-only logs start stop

.init.lock:
	@echo "Lockfile prevents reinitialization" > .init.lock
	@docker-compose up -d
	@docker exec -it $$(docker ps -qf ancestor=mongo) sh -c 'mongo < /tmp/mongo-init.js'
	@docker exec -it -u root $$(docker ps -qf ancestor=jenkins) sh -c \
		"chown -R jenkins.jenkins /var/jenkins_home"
	@docker-compose restart jenkins

clean: stop
	@docker system prune
	@rm -f .init.lock

start: .init.lock
	@docker-compose up -d

stop:
	@docker-compose down

binaries:
	@rm -rf ${BUILD_DIR} && mkdir -p ${BUILD_DIR}
	@docker run \
		--rm \
		-v ~/.m2:/root/.m2 \
		-v ${ROOT_DIR}/..:/tmp/src \
		-v ${BUILD_DIR}:/tmp/build \
		maven:latest \
		/bin/bash -c \
			"cd /tmp/src && \
			mvn package -DskipTests=true && \
			cp -r UI/dist /tmp/build/html && \
			cp api/target/api.jar /tmp/build && \
			cp collectors/scm/gitlab/target/gitlab-scm-collector*.jar /tmp/build && \
			cp collectors/feature/gitlab/target/gitlab-feature-collector*.jar /tmp/build && \
			cp collectors/build/jenkins/target/jenkins-build-collector*.jar /tmp/build && \
			cp collectors/build/sonar/target/sonar-codequality-collector*.jar /tmp/build"

containers: binaries containers-only

containers-only:
	@docker build . --rm -t ${API_IMAGE_NAME} -f assets/api/Dockerfile
	@docker build . --rm -t ${UI_IMAGE_NAME} -f assets/ui/Dockerfile
	@docker build . --rm -t ${MONGO_IMAGE_NAME} -f assets/mongo/Dockerfile
	@docker build . --rm -t ${JENKINS_IMAGE_NAME} -f assets/jenkins/Dockerfile
	@docker build . --rm -t ${JENKINS_IMAGE_COLLECTOR_NAME} -f assets/collectors/jenkins/Dockerfile
	@docker build . --rm -t ${SONAR_IMAGE_COLLECTOR_NAME} -f assets/collectors/sonarqube/Dockerfile
	@docker build . --rm -t ${GITLAB_SCM_IMAGE_COLLECTOR_NAME} -f assets/collectors/gitlab-scm/Dockerfile
	@docker build . --rm -t ${GITLAB_FEATURES_IMAGE_COLLECTOR_NAME} -f assets/collectors/gitlab-features/Dockerfile

logs:
	docker-compose logs --follow --tail="all"