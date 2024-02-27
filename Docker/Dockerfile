# Stage 1: Build
# Use a Maven or Gradle image to build the Java application, depending on your project's build tool.
# This example assumes a Maven project.
FROM maven:3.6.3-openjdk-8-slim AS build

# Copy the project files to the container
COPY src /home/app/src
COPY pom.xml /home/app

# Build the application
RUN mvn -f /home/app/pom.xml clean package

# Stage 2: Runtime
# Use the slim version of an Alpine Linux image that comes pre-installed with OpenJDK 8 for the runtime
FROM adoptopenjdk/openjdk8:alpine-slim

# Expose port 8080 for the application
EXPOSE 8080

# Declare the user and group for running the application
RUN addgroup -S pipeline && adduser -S k8s-pipeline -G pipeline

# Copy the JAR file from the build stage to the runtime stage
COPY --from=build /home/app/target/*.jar /home/k8s-pipeline/app.jar

# Switch to the non-root user for running the application
USER k8s-pipeline

# Set the entrypoint to run the application
ENTRYPOINT ["java","-jar","/home/k8s-pipeline/app.jar"]
