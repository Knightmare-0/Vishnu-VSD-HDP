+ RTL_Synthesis - Contains Synthesis of Verilog RTL Designs using YOSYS
+ STA - Contains Advance Synthesis and STA with OpenSTA
+ Circuit_Design - Contains ngspice CMOS Simulations
+ Physical_Design - Physical synthesis using openlane
+ RTL2GDS - RTL to GDS for a Serial Adder Design
  
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
### Dockers
```
sudo apt-get update
sudo apt-get upgrade
sudo apt install -y build-essential python3 python3-venv python3-pip make git
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
sudo groupadd docker
sudo usermod -aG docker $USER
sudo reboot
```
