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
run_floorplan
run_placement
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
#### In config.tcl
*Set metal layers [typically it is 1 more than what is specified]*</br>
*Vertical metal in layer 4 and horizontal metal in layer 3* <br>
*Set core utilisation factor* </br>
*Set core utilisation in dk_config.tcl which has the highest priority*


#### Command To Launch Magic
```
magic -T /home/knightmare/lib/sky130A/libs.tech/magic/sky130A.tech lef read cd ../../tmp/merged.min.lef def read picorv32.def 
```

### Placement
*Overflow decreases implies design converges, which is good* </br>

# Day 2
### Custom Standard Cell Layout and Spice Extraction

#### Step 1
Launch the mag file and tech file on magic
```
magic -T libs/sky130A.tech sky130_inv.mag 
```
![Inverter Layout](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/691e3a07-46a1-41c9-9c83-d1502286d6e6)

Extract spice files from tkcon window
```
% extract all
% ext2spice cthresh 0 rthresh 0
% ext2spice
```



