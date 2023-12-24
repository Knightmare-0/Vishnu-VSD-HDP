# Tool Used : OpenLane
# Design Used : Picorv32a

### OpenLane Start up
```
make mount
./flow.tcl -interactive
package require openlane 0.9
prep -design picorv32a
```


# Day 1
### Calculate Flop Ratio
```
flop ratio = Total number of cells / Number of D Flipflops
```
