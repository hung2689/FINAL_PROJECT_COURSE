FROM tomcat:10.1-jdk17

COPY target/courseProject-1.0.war /usr/local/tomcat/webapps/ROOT.war