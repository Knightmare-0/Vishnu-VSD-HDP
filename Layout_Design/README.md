# Tool Used: OpenLane
#### OpenLane Start up
```
make mount
./flow.tcl -interactive
package require openlane 0.9
prep -design picorv32a
```
#### OpenLane Commands
```
run_synthesis    
```

# Day 1
### Design Used: Picorv32a
#### Calculate Flop Ratio
```
flop ratio = Total number of cells / Number of D Flipflops
```
> [!NOTE]
>  Cell information found in runs/reports/synthesis/1-synthesis.AREA_0.stat.rpt
