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

