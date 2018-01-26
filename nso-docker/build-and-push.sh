#!/bin/sh

VER="4.5.2"

docker rmi containers.cisco.com/frjansso/nso-base:$VER
docker rmi containers.cisco.com/frjansso/nso-base:latest
docker build --build-arg NSOVER=$VER -t containers.cisco.com/frjansso/nso-base:latest .
docker tag containers.cisco.com/frjansso/nso-base:latest containers.cisco.com/frjansso/nso-base:$VER
docker push containers.cisco.com/frjansso/nso-base:$VER
docker push containers.cisco.com/frjansso/nso-base:latest
