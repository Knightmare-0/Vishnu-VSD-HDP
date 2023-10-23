
# RTL to GDS For A Bidirectional Counter

## Code

```
module bidcounter(count,clk,ctrl,reset);
	input clk,reset,ctrl;
	output reg [3:0] count;
	always@(posedge clk)
		begin
		if(reset) count<=0;
		else if(ctrl) count<=count+1;
		else count<=count-1;
	end
endmodule
```

## RTL Simulation

![bidcounter_sim](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/1793cbec-b5c1-4348-a91f-4f5598f8c9d9)

## RTL Synthesis

![bidsynth](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/02343500-e74d-4b76-ad2d-8acf5516a8b4)

## DFFLIBMAP Results

![DFF_LIB_MAP_Result](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/296061ca-de93-4826-928f-904b2553afa5)

## ABC Results

![ABC_results](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/6c38ce7f-0338-4730-a2fb-dc9a7009b130)

## Netlist 

![bidcounter_synth](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/0079969b-3bbd-4d6c-a1be-025895f2ab48)

## Netlist Simulation

![bidcounter_GLS](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/c0c9f60e-8df7-4886-87e1-272ac8eba580)

**NOTE :** _RTL Simulation is the same as Netlist Simulation_

## STA Analysis

~~~
X Axis : ss/ff/tt libraries
Y Axis : Worst Slack
~~~
![STA](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/afe26354-b069-4323-830d-c186d316eced)



