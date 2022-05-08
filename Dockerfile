#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
ENV MARIADB_ROOT_PASSWORD=root_password \
    MARIADB_USER=db_user \
    MARIADB_PASSWORD=db_password \
    MARIADB_DATABASE=demo 
COPY ./src /home/app/src
COPY ./pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/ums-1.0.jar /usr/local/lib/ums-1.0.jar
# EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/ums-1.0.jar"]