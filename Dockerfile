# Stage 1: Build the Maven project
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy the pom.xml and source code to the container
COPY pom.xml .
COPY src ./src

# Build the WAR file (skip tests to speed up deployment)
RUN mvn clean package -DskipTests

# Stage 2: Set up the Tomcat server
FROM tomcat:10.1-jdk17

# Remove default Tomcat webapps (optional but recommended for a cleaner environment)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR file from the build stage into Tomcat's webapps folder.
# Naming it ROOT.war deploys it to the root context path (/) instead of /courseProject-1.0
COPY --from=build /app/target/courseProject-1.0.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]