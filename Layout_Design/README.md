# Tool Used: OpenLane
#### OpenLane Start up
```
make mount
./flow.tcl -interactive
package require openlane 0.9
prep -design picorv32a
```


# Day 1
### Design Used: Picorv32a
#### Calculate Flop Ratio
```
flop ratio = Total number of cells / Number of D Flipflops
```
