FROM openjdk:11.0.16-jdk-oraclelinux7 as builder

WORKDIR /photon

COPY . .

RUN ./gradlew assemble --no-daemon

RUN ls -la build/libs/photon-*.jar

FROM openjdk:11.0.16-jdk-oraclelinux7 as photon

WORKDIR /photon

COPY --from=builder /photon/build/libs/photon-*.jar /photon/photon.jar
COPY entrypoint.sh /photon/entrypoint.sh

RUN chmod +x /photon/entrypoint.sh

EXPOSE 2322


ENTRYPOINT /photon/entrypoint.sh
