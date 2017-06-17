FROM jenkins

USER jenkins
COPY assets/jenkins/hudson.tasks.Maven.xml /var/jenkins_home/
COPY assets/jenkins/jenkins.mvn.GlobalMavenConfig.xml /var/jenkins_home/
#RUN mkdir -p /var/jenkins_home/jobs/hygieia
#COPY assets/jenkins/job-hygieia.xml /var/jenkins_home/jobs/hygieia/config.xml
COPY assets/jenkins/plugins.txt /usr/share/jenkins/ref/
RUN plugins.sh /usr/share/jenkins/ref/plugins.txt

VOLUME /var/jenkins_home

EXPOSE 8080 5000

ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]