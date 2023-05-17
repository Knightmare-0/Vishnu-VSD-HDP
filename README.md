# Vishnu-VSD-HDP
# VSD-HDP Status

## Day_0
*Before installing run the command below*
```
$ sudo apt update && upgrade
```
Tools needed:
- [x] Yosys
- [x] OpenSTA
- [x] ngspice
- [x] iverilog
- [x] gtkwave
- [x] magic

### Yosys
```
$ mkdir yosys
$ git clone https://github.com/YosysHQ/yosys.git
$ cd yosys
$ sudo apt-get install build-essential clang bison flex \
    libreadline-dev gawk tcl-dev libffi-dev git \
    graphviz xdot pkg-config python3 libboost-system-dev \
    libboost-python-dev libboost-filesystem-dev zlib1g-dev
$ make 
$ sudo make install
```

![yosys](https://user-images.githubusercontent.com/112769624/236633099-02d75838-aa08-46c7-b303-7905add62979.png)



### OpenSTA
*To install cmake for 18.04 (if not present)*
```
$ wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | sudo apt-key add -
$ sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'
$ sudo apt-get update
$ sudo apt-get upgrade
```
*Dependency*
```
$ sudo apt install swig
```
*For OpenSTA*
```
$ git clone https://github.com/The-OpenROAD-Project/OpenSTA.git
$ cd OpenSTA
$ mkdir build
$ cd build
$ cmake ..
$ make
```
![sta](https://user-images.githubusercontent.com/112769624/236634039-9f27788e-8a0f-4f94-94f3-f5ba59ed7f3a.png)


### ngspice
* Download ngspice-37.tar.gz from old releases parent folder from
(https://sourceforge.net/projects/ngspice/files/)
```
$ tar -zxvf ngspice-40.tar.gz
$ cd ngspice-40
$ mkdir release
$ cd release
$ ../configure  --with-x --with-readline=yes --disable-debug
$ make
$ sudo make install
```
![ngspice](https://user-images.githubusercontent.com/112769624/236634603-e17ae7a4-9e6a-4ec5-bd67-8898ae467085.png)


### iverilog
```
$ sudo apt-get install iverilog
```
### gtkwave
```
$ sudo apt install gtkwave
```
### magic
```
$   sudo apt-get install m4
$   sudo apt-get install tcsh
$   sudo apt-get install csh
$   sudo apt-get install libx11-dev
$   sudo apt-get install tcl-dev tk-dev
$   sudo apt-get install libcairo2-dev
$   sudo apt-get install mesa-common-dev libglu1-mesa-dev
$   sudo apt-get install libncurses-dev
```
##Day_1

### Good MUX design and testbench

![iverilog sim](https://user-images.githubusercontent.com/112769624/236661360-f3b70813-89fc-41de-87fb-a54129a675ae.png)

*Presequisites*
```
$ sudo apt install vim-gtk3
```
*commands*
```
$ gvim good_mux.v tb_good_mux.v
$ gedit good_mux.v tb_good_mux.v
$ iverilog good_mux.v tb_good_mux.v
$ ls
$ ./a.out
$ gtkwave tb_good_mux.v

```
*MUX design*

```
module good_mux (input i0 , input i1 , input sel , output reg y);
always @ (*)
begin
	if(sel)
		y <= i1;
	else 
		y <= i0;
end
endmodule
```

*MUX testbench*

```
`timescale 1ns / 1ps
module tb_good_mux;
	// Inputs
	reg i0,i1,sel;
	// Outputs
	wire y;

        // Instantiate the Unit Under Test (UUT)
	good_mux uut (
		.sel(sel),
		.i0(i0),
		.i1(i1),
		.y(y)
	);

	initial begin
	$dumpfile("tb_good_mux.vcd");
	$dumpvars(0,tb_good_mux);
	// Initialize Inputs
	sel = 0;
	i0 = 0;
	i1 = 0;
	#300 $finish;
	end

always #75 sel = ~sel;
always #10 i0 = ~i0;
always #55 i1 = ~i1;
endmodule
```
*gtkwave output*
![day1-1](https://user-images.githubusercontent.com/112769624/236661094-f39ac58d-214e-4938-9e4c-ff875f46e0d8.png)

### MUX synthesis to gatelevel netlist

*yosys flow*
![yosys_flow](https://user-images.githubusercontent.com/112769624/236665087-54638e48-cd2e-4f09-bc2e-1b81182186b0.png)


*commands for synthesis*

```
yosys> read_liberty -lib /home/knightmare/vlsi/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
yosys> read_verilog /home/knightmare/vlsi/sky130RTLDesignAndSynthesisWorkshop//verilog_files/good_mux.v
yosys> synth -top good_mux 
yosys> abc -liberty /home/knightmare/vlsi/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
yosys> show
```
![procedure](https://user-images.githubusercontent.com/112769624/236665583-82ad8f8b-6bf1-4468-8e57-00c9cddfe41a.png)

*ABC results*

![yosys mux res](https://user-images.githubusercontent.com/112769624/236665606-99faab73-96f4-405d-a504-7410652ffbd6.png)

*MUX Netlist*

![mux_netlist](https://user-images.githubusercontent.com/112769624/236665640-d33d6f90-632a-4419-a930-d3d16a1b85b2.png)

*Netlist code using the commands*
```
$ write_verilog -noattr good_mux_netlist.v
$ gedit good_mux_netlist.v
```
*Netlist Code*
```
/* Generated by Yosys 0.28+12 (git sha1 4251d37f4, clang 10.0.0-4ubuntu1 -fPIC -Os) */

module good_mux(i0, i1, sel, y);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input i0;
  wire i0;
  input i1;
  wire i1;
  input sel;
  wire sel;
  output y;
  wire y;
  sky130_fd_sc_hd__mux2_1 _4_ (
    .A0(_0_),
    .A1(_1_),
    .S(_2_),
    .X(_3_)
  );
  assign _0_ = i0;
  assign _1_ = i1;
  assign _2_ = sel;
  assign y = _3_;
endmodule
```
## Day_2
### Hirarchical synthesis and Flattened synthesis

*Commands for hirarchical synthesis*
```
yosys> read_liberty -lib /home/knightmare/vlsi/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
yosys> read_verilog /home/knightmare/vlsi/sky130RTLDesignAndSynthesisWorkshop//verilog_files/good_mux.v
yosys> synth -top multiple_modules 
yosys> abc -liberty /home/knightmare/vlsi/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
yosys> show
yosys> write_verilog -noattr multiple_modules_hirar.v
yosys> !gedit multiple_modules_hirar.v
```
*Output netlist and module*

![hirar_syn](https://user-images.githubusercontent.com/112769624/236819016-d610881c-1166-4e52-863b-47217f667920.png)

```
/* Generated by Yosys 0.28+12 (git sha1 4251d37f4, clang 10.0.0-4ubuntu1 -fPIC -Os) */

module multiple_modules(a, b, c, y);
  input a;
  wire a;
  input b;
  wire b;
  input c;
  wire c;
  wire net1;
  output y;
  wire y;
  sub_module1 u1 (
    .a(a),
    .b(b),
    .y(net1)
  );
  sub_module2 u2 (
    .a(net1),
    .b(c),
    .y(y)
  );
endmodule

module sub_module1(a, b, y);
  wire _0_;
  wire _1_;
  wire _2_;
  input a;
  wire a;
  input b;
  wire b;
  output y;
  wire y;
  sky130_fd_sc_hd__and2_0 _3_ (
    .A(_1_),
    .B(_0_),
    .X(_2_)
  );
  assign _1_ = b;
  assign _0_ = a;
  assign y = _2_;
endmodule

module sub_module2(a, b, y);
  wire _0_;
  wire _1_;
  wire _2_;
  input a;
  wire a;
  input b;
  wire b;
  output y;
  wire y;
  sky130_fd_sc_hd__or2_0 _3_ (
    .A(_1_),
    .B(_0_),
    .X(_2_)
  );
  assign _1_ = b;
  assign _0_ = a;
  assign y = _2_;
endmodule

```
*Commands for flattend synthesis*

*insert following command after synthesis*
```
yosys> flatten
yosys> write_verilog -noattr multiple_modules_flat.v
yosys> !gedit multiple_modules_flat.v
```
*Output netlist and module*

![flattened_synth](https://user-images.githubusercontent.com/112769624/236819091-f60ab187-0700-499b-ac07-ad9bb7060b06.png)

```
module multiple_modules(a, b, c, y);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  wire _4_;
  wire _5_;
  input a;
  wire a;
  input b;
  wire b;
  input c;
  wire c;
  wire net1;
  wire \u1.a ;
  wire \u1.b ;
  wire \u1.y ;
  wire \u2.a ;
  wire \u2.b ;
  wire \u2.y ;
  output y;
  wire y;
  sky130_fd_sc_hd__and2_0 _6_ (
    .A(_1_),
    .B(_0_),
    .X(_2_)
  );
  sky130_fd_sc_hd__or2_0 _7_ (
    .A(_4_),
    .B(_3_),
    .X(_5_)
  );
  assign _4_ = \u2.b ;
  assign _3_ = \u2.a ;
  assign \u2.y  = _5_;
  assign \u2.a  = net1;
  assign \u2.b  = c;
  assign y = \u2.y ;
  assign _1_ = \u1.b ;
  assign _0_ = \u1.a ;
  assign \u1.y  = _2_;
  assign \u1.a  = a;
  assign \u1.b  = b;
  assign net1 = \u1.y ;
endmodule
```
## Flops 

*synchronous reset and asynchronous reset in flops*

*1> asynchronous reset*
```
module dff_asyncres(input d,input clk,input asyncres,output reg q)
  always @(posedge clk , posedge asyncres)
    begin
    if(asyncres)
      q <= 1'b0;
  	else
      q <= d;
    end
endmodule
```
*2> synchronous reset*
```
module dff_asyncres(input d,input clk,input syncres,output reg q)
  always @(posedge clk)
    begin
    if(syncres)
      q <= 1'b0;
  	else
      q <= d;
    end
endmodule
```
*3> both synchronous and asynchronous reset*
```
module dff_asyncres(input d,input clk,input syncres,input ayncres,output reg q)
  always @(posedge clk, posedge asyncres)
    begin
    if(asyncres)
      q <= 1'b0;
    else if(syncres)
      q <= 1'b0;
    else
      q <= d;
    end
endmodule
```
*command for synthesis of 1 and 2 in yosys*
```
yosys> read_liberty -lib /home/knightmare/vlsi/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
yosys> read_verilog /home/knightmare/vlsi/sky130RTLDesignAndSynthesisWorkshop/verilog_files/dff_asyncres.v
yosys> synth -top dff_asyncres 
yosys> dfflibmap -liberty /home/knightmare/vlsi/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
yosys> abc -liberty /home/knightmare/vlsi/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
yosys> show
yosys> read_verilog /home/knightmare/vlsi/sky130RTLDesignAndSynthesisWorkshop/verilog_files/dff_syncres.v 
yosys> synth -top dff_syncres 
yosys> dfflibmap -liberty /home/knightmare/vlsi/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
yosys> abc -liberty /home/knightmare/vlsi/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
yosys> show
```
![asyncres_dff](https://user-images.githubusercontent.com/112769624/236834419-d00e964f-7ae3-45d8-9041-ca7cd9c54856.png)
![asyncres_gtkwave](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/e1ccf3f2-169b-4263-bc44-58621c0fcdb7)

![dff_syncres](https://user-images.githubusercontent.com/112769624/236834488-db937766-d0e4-42b8-b04e-1910e0f1a14f.png)
![syncress_dff_gtkwave](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/930e3537-ee69-4393-908d-c4ace1a704c1)

*Note : synchronous logic is realized using a nor logic*
	*dfflibmap maps to all dff's*
## interesting optimization 
*Special cases where there is wired logic used instead of multipliers*

*1> Code 1*
```
module mul2 (input [2:0] a, output [3:0] y);
	assign y = a * 2;
endmodule
```
*synthesis output*

![a*2](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/6cbcf6c6-472e-4d30-8edc-e4fecebc84fb)

*2> Code 2*
```
module mult8 (input [2:0] a , output [5:0] y);
	assign y = a * 9;
endmodule
```

*synthesis output*

![a*9](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/9651e292-4801-4d09-84d0-8b8bc31e6d86)

### DAY 3
## combinational logic optimization
*following commands are used for optimization after synthesis*
```
yosys> opt_clean -purge
```
*NOTE : use flatten for multiple modules*


*code opt_check*
```
module opt_check (input a , input b , output y);
	assign y = a?b:0;
endmodule
```
*synthesis reduced to AND gate*

![opt_check](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/861099b2-5e07-49e8-9672-18b8d78d2a66)

*code opt_check2*
```
module opt_check2 (input a , input b , output y);
	assign y = a?1:b;
endmodule
```
*synthesis reduced to OR gate*
![opt_check2](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/05ef6e22-77b0-425a-970e-8dadd0c5f7da)

*code opt_check3*
```
module opt_check3 (input a , input b, input c , output y);
	assign y = a?(c?b:0):0;
endmodule
```
*synthesis reduced to 3 input AND gate*
![opt_check3](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/a72ba48a-95e1-4828-92d5-86582c876583)

*code opt_check4*
```
module opt_check4 (input a , input b , input c , output y);
assign y = a?(b?(a & c ):c):(!c);
endmodule
```
*synthesis reduced to XOR gate*

![opt_check4](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/c53d9d91-f9d9-4220-9b6b-c0a8d442315a)

*code multiple_module_opt*
```
module sub_module1(input a , input b , output y);
 assign y = a & b;
endmodule


module sub_module2(input a , input b , output y);
 assign y = a^b;
endmodule


module multiple_module_opt(input a , input b , input c , input d , output y);
wire n1,n2,n3;

sub_module1 U1 (.a(a) , .b(1'b1) , .y(n1));
sub_module2 U2 (.a(n1), .b(1'b0) , .y(n2));
sub_module2 U3 (.a(b), .b(d) , .y(n3));

assign y = c | (b & n1); 


endmodule
```
*synthesis optimized using distributive boolean law*
![multiple_module_opt](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/7caa938d-616e-4514-a294-f40765f5b8ac)

*code multiple_module_opt2*
```

module sub_module(input a , input b , output y);
 assign y = a & b;
endmodule



module multiple_module_opt2(input a , input b , input c , input d , output y);
wire n1,n2,n3;

sub_module U1 (.a(a) , .b(1'b0) , .y(n1));
sub_module U2 (.a(b), .b(c) , .y(n2));
sub_module U3 (.a(n2), .b(d) , .y(n3));
sub_module U4 (.a(n3), .b(n1) , .y(y));


endmodule
```
*synthesis optimized for output 0*

![multiple_modules_opt2](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/59aeed7e-64c9-4672-93a2-6183a2dc6376)

## Sequential Optimization
*use command*
```
yosys> dfflibmap -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
```
*for sequential circuits*

*dff_const1 code*
```
module dff_const1(input clk, input reset, output reg q);
always @(posedge clk, posedge reset)
begin
	if(reset)
		q <= 1'b0;
	else
		q <= 1'b1;
end

endmodule
```

*dff_const1 waveform analysis*

![dff_const1_wave](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/733aaedc-cd84-4596-b604-3d09373a017a)

*dff_const1 synthesis analysis*

![dff_const1_synth](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/02cd3a26-fed4-4514-a559-34bfe65c66ac)

*dff_const2 code*
```
module dff_const2(input clk, input reset, output reg q);
always @(posedge clk, posedge reset)
begin
	if(reset)
		q <= 1'b1;
	else
		q <= 1'b1;
end

endmodule
```
*dff_const2 waveform analysis*

![dff_const2_wave](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/a81218ef-4443-4a27-80af-d31edf92f80d)

*dff_const2 synthesis analysis*

![dff_const2_synth](https://github.com/Knightmare-0/Vishnu-VSD-HDP/assets/112769624/8746ef53-9fc9-4fa9-9c01-e36862ad9453)






































































