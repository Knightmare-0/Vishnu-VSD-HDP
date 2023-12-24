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
flop ratio = 9645 / 1596 = 6.04
```
> [!NOTE]
> Cell information found in runs/reports/synthesis/1-synthesis.AREA_0.stat.rpt </br>

### Floorplan

*Configuration priority System defaults in configuration folder floorplan.tcl < config.tcl < pdk_config.tcl* </br>
### In config.tcl
*Set metal layers [typically it is 1 more than what is specified]*</br>
*Vertical metal in layer 4 and horizontal metal in layer 3* <br>
*Set core utilisation factor* </br>
*Set core utilisation in dk_config.tcl which has the highest priority
