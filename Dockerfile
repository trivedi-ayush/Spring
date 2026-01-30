# FROM eclipse-temurin:17-jre
# COPY target/demo-1.0.jar app.jar
# ENTRYPOINT ["java","-jar","/app.jar"]

# Use Java 17 base image
FROM eclipse-temurin:21-jdk

# Set working directory
WORKDIR /app

# Copy jar file
COPY target/demo-1.0.jar app.jar

# Expose port
EXPOSE 8080

# Run the app
CMD ["java", "-jar", "app.jar"]
