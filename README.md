# Prerequisite 1
```
source ~/setup-open-p4studio.bash 
```

# Prerequisite 2
```
sudo ${SDE_INSTALL}/bin/veth_setup.sh 128
```


# Location of my p4 code 

go to the directory, where p4 is located
(given below example dir)
```
cd /home/motherfunder/IamWorking/tofinoCase/simpleforwarding/tofinoipv4Forwarding
```

# clean any unwanted or previous builds

(in my case simple_ipv4, since my p4 file name is simple_ipv4.p4)
```
rm –rf $SDE/build/p4-build/p4-build/simple_ipv4
```

# compiling code
```
mkdir $SDE/build/p4-build/my_program
cd       $SDE/build/p4-build/my_program
cmake $SDE/p4studio                                         \
     -DCMAKE_MODULE_PATH="$SDE/cmake"                       \
     -DCMAKE_INSTALL_PREFIX="$SDE_INSTALL"                  \
     -DP4C=/home/motherfunder/open-p4studio/build/pkgsrc/p4-compilers/p4c/bf-p4c   \
     -DP4_PATH=$HOME/IamWorking/tofinoCase/simpleforwarding/simple_ipv4.p4   \
     -DP4_NAME=simple_ipv4                                   \
     -DP4_LANG=p4_16                                        \
     -DTOFINO={ON} –DTOFINO2={OFF}
```
# imp cmd 
```
make [VERBOSE=1] -j install
```
all the built directory will be uploaded in main-2 branch
