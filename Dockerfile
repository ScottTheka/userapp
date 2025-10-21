# Stage 1: Build the WAR inside a Maven container
FROM maven:3.9.4-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy pom.xml first to cache dependencies
COPY pom.xml .

# Download dependencies (offline mode)
RUN mvn dependency:go-offline

# Copy source code
COPY src ./src

# Build WAR
RUN mvn clean package -DskipTests

# Stage 2: Deploy on Tomcat
FROM tomcat:10.1.48-jdk17

# Remove default ROOT app
RUN rm -rf /usr/local/tomcat/webapps/ROOT*

# Copy WAR from build stage
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
