FROM ubuntu:latest

RUN apt update -y && apt upgrade -y && apt install -y fpga-icestorm nextpnr-ice40 && apt clean

RUN mkdir workspace
WORKDIR workspace

COPY ./compile-and-flash.sh ./
