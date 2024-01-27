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
run_cts
gen_pdn
run_routing
run_parasitics_sta
run_irdrop_report
run_magic
run_magic_spice_export
run_lvs
run_magic_drc
run_antenna_check
run_erc
```

#### Open PDKs
```
 git clone git://opencircuitdesign.com/open_pdks
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

#### Step 2
Extract spice files from tkcon window
```
% extract all
% ext2spice cthresh 0 rthresh 0
% ext2spice
```
#### Step 3
Modify the spice file to run the simulation
```
* SPICE3 file created from sky130_inv.ext - technology: sky130A

.option scale=0.01u
.include ./libs/pshort.lib
.include ./libs/nshort.lib

//.subckt sky130_inv A Y VPWR VGND
M1000 Y A VGND VGND nshort_model.0 w=35 l=23
+  ad=1.435n pd=0.152m as=1.365n ps=0.148m
M1001 Y A VPWR VPWR pshort_model.0 w=37 l=23
+  ad=1.443n pd=0.152m as=1.517n ps=0.156m

VDD VPWR 0 3.3V
VSS VGND 0 0V
Va A VGND PULSE(0V 3.3V 0 0.1ns 0.1ns 2ns 4ns)

C0 VPWR Y 0.11654f
C1 VPWR A 0.077431f
C2 Y A 0.075353f
C3 Y VGND 0.2f
C4 A VGND 0.45021f
C5 VPWR VGND 0.781009f
//.ends

.tran 1n 20n

.control
run
.endc
.end
```
plot in NgSpice 
```
plot y vs time a
```

Inverter Transient Waveform
![layout spice sim](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/e7b39bc8-e181-43d9-b250-10b365e552f6)

Cell Characterization
| Raise Time | Fall Time | Cell Raise Delay | Cell Fall Delay | 
|------------|-----------|------------|-----------------------|
|0.044 ns    |0.02ns     |   0.027ns  |  0.003ns              |

> [!NOTE]
> Input and output ports must lie on the intersection of the horizontal and vertical tracks </br>
> The width of the standard cell must be in the odd multiple of the track's horizontal pitch </br>
> The height of the standard cell must be in the odd multiple of the track's vertical pitch </br>
#### Step 4
Generate LEF file from magic tkcon window
```
write lef sky130_inverter.lef
```
<p>
Copy 4 Files generated to the picorv32a src folder  </br>
1. sky130_inverter.lef </br>
2. sky130_fd_sc_hd__fast.lib</br>
3. sky130_fd_sc_hd__slow.lib</br>
4. sky130_fd_sc_hd__typical.lib</br>
</p>
<p>
  Use the following command to map the 4 files in the config.json </br>
  config.json Location :  /home/knightmare/OpenLane/designs/picorv32a</br>
</p>

```
"LIB_SYNTH": "/home/knightmare/OpenLane/designs/picorv32a/src/sky130_fd_sc_hd__typical.lib",
"LIB_SLOWEST": "/home/knightmare/OpenLane/designs/picorv32a/src/sky130_fd_sc_hd__slow.lib",
"LIB_FASTEST": "/home/knightmare/OpenLane/designs/picorv32a/src/sky130_fd_sc_hd__fast.lib",
"LIB_TYPICAL": "/home/knightmare/OpenLane/designs/picorv32a/src/sky130_fd_sc_hd__typical.lib",
"EXTRA_LEFS": "/home/knightmare/OpenLane/designs/picorv32a/src/sky130_inverter.lef",
```

#### Step 5
> Invoke openlane and load the design </br>
> set the new lef file to the design </br>
> add the new lef file to the source </br>

```
prep -design picorv32a
set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
add_lefs -src $lefs
run_synthesis
run_floorplan
run_placement
```
#### Step 6 

> Check the logs if synthesis abc has mapped the new inverter </br>
> Check the def generated in results/placements for the new cell using magic </br>
> Run magic in the placement folder
```
magic read -T /home/knightmare/.volare/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.max.lef def read picorv32.def &

```
|Placement Result | Inverter Placement |
|-----------------|-------------------|
|![image](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/c60cbde3-af14-46dd-b38c-a42b43ce13b7)|![image](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/d116fc3e-cba6-4178-bc34-6c99c67bda8c)|

<p>
 In case of any Slack violations </br>
 Modify the environment variable to solve the issue </br>
 1. SYNTH_STRATEGY : Increasing this synthesises the design to a bigger area </br>
 2. SYNTH_BUFFERING : Enable buffering for cells with high fanout </br>
 3. SYNTH_SIZING : Enabes upsizing or downsizing the buffers </br>
 4. SYNTH_DRIVING_CELL : Cell that drives the input port (sky130_fd_sc_hd__inv_2 -> sky130_fd_sc_hd__inv_8) </br>
</p>
```
% echo $::env(SYNTH_STRATEGY)
AREA 0
% set ::env(SYNTH_STRATEGY) 1
1
% echo $::env(SYNTH_BUFFERING)  
1
% echo $::env(SYNTH_SIZING)
0
% set ::env(SYNTH_SIZING) 1
1
% echo $::env(SYNTH_DRIVING_CELL)
sky130_fd_sc_hd__inv_2
% set ::env(SYNTH_DRIVING_CELL) sky130_fd_sc_hd__inv_8
sky130_fd_sc_hd__inv_8
```













