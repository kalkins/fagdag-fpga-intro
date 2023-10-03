#!/bin/bash

if [[ $# -ge 1 && -d $1 ]]; then
    devices=$(lsusb | awk '{ if ($6 == "0403:6010") { printf "--device=/dev/bus/usb/%s/%s ", $2, substr($4, 1, length($4)-1) } }')

    docker build -t fpga-toolchain ./toolchain && docker run --rm -t -i $devices -v ./$1:/workspace/src -v ./cu.pcf:/workspace/cu.pcf fpga-toolchain
else
    echo "Compile and flash verilog to FPGA"
    echo "Usage: run.sh DIR"
fi
