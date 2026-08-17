FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY build/libs/app-gradle-1.0.0-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
