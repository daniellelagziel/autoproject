FROM tomcat
MAINTAINER xyz

ADD ./web/target/time-tracker-web-0.3.1.war /usr/local/tomcat/webapps/

CMD ["catalina.sh", "run"]
