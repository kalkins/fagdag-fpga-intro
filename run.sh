#!/bin/bash

if [[ $# -eq 1 && "$1" == "server" ]]; then
    command="python3 main.py"
    args='-p 8760:8760'
elif [[ $# -ge 1 && -d $1 ]]; then
    command="sh compile-and-flash.sh ${1}"
    args="-v $(pwd)/$1:/workspace/$1"
else
    echo "Compile and flash verilog to FPGA"
    echo "Usage: run.sh DIR"
    exit 1
fi

devices=$(lsusb | awk '{ if ($6 == "0403:6010") { printf "--device=/dev/bus/usb/%s/%s ", $2, substr($4, 1, length($4)-1) } }')

dockerbuild="docker build -t fpga-toolchain ./toolchain"
dockerrun="docker run --rm -t -i $devices $args -v $(pwd)/cu.pcf:/workspace/cu.pcf fpga-toolchain $command"

echo $dockerbuild && $dockerbuild && echo $dockerrun && $dockerrun
