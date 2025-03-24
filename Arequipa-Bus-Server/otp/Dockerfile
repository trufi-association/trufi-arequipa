FROM openjdk:8-jre

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y wget

WORKDIR /otp
COPY . .

RUN wget https://github.com/opentripplanner/OpenTripPlanner/releases/download/v1.5.0/otp-1.5.0-shaded.jar

EXPOSE 8080 8081

ENTRYPOINT [ "sh", "./run.sh" ]
