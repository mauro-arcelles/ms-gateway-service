FROM maven:3.8-openjdk-11 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM openjdk:11-jdk
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
COPY --from=builder /app/src/main/resources/ /app/resources/
ENTRYPOINT ["java","-jar","app.jar"]