# Stage 1: Build WAR
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Deploy on Tomcat
FROM tomcat:10.1.48-jdk17

# Remove default ROOT
RUN rm -rf /usr/local/tomcat/webapps/ROOT*

# Copy WAR
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Create a folder for SQLite DB
RUN mkdir /data

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
