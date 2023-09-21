yosys "-p synth_ice40 -top top -json top.json" top.v \
  && nextpnr-ice40 --hx8k --package cb132 --pcf cu.pcf --json top.json --asc top.asc \
  && icepack top.asc top.bin \
  && iceprog -d i:0x0403:0x6010:0 top.bin \
  && echo "Flash successful"
