#!/bin/bash

# Create the "report" directory if it doesn't exist
mkdir -p "sta_report"
mkdir -p "gls_report"

iverilog bidcounter_ff_1v95.v ../../bidcounter_tb.v ../../verilog_model/primitives.v ../../verilog_model/sky130_fd_sc_hd.v
./a.out
mv a.out gls_report
mv wave.vcd gls_report

# Run OpenSTA (assuming it opens and generates files in "report")
sta sta.tcl &

# Wait for a few seconds to allow OpenSTA to complete its tasks (you may need to adjust the sleep time)
sleep 0.5

# Change to the "report" directory
cd "sta_report" || exit 1

# Use a for loop to collect all files in "report"
files=()
for file in *; do
  files+=("$file")
done

# Open all files in "report" with gedit in a single tab
gedit "${files[@]}"

# Exit the script
exit

