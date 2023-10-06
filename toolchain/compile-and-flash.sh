indir=$1
outdir=$indir-out

yosys "-p synth_ice40 -top top -json $outdir/top.json" $indir/top.v \
  && nextpnr-ice40 --hx8k --package cb132 --pcf cu.pcf --json $outdir/top.json --asc $outdir/top.asc \
  && icepack $outdir/top.asc $outdir/top.bin \
  && iceprog -d i:0x0403:0x6010:0 $outdir/top.bin \
  && echo "Flash successful"
