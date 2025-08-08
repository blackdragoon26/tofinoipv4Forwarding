for compiling tofino p4 with intended output
```
venv) motherfunder@motherfunder-VivoBook-ASUSLaptop-X515DA:~/IamWorking/tofinoCase/simpleforwarding$ cd ~/IamWorking/tofinoCase/simpleforwarding/

sudo bash -c "
export SDE=/home/motherfunder/open-p4studio
export SDE_INSTALL=/home/motherfunder/open-p4studio/install
export LD_LIBRARY_PATH=\$SDE_INSTALL/lib:\$LD_LIBRARY_PATH
\$SDE/run_tofino_model.sh -p simple_ipv4 -c simple_ipv4.json/pipe/context.json
"
Using SDE /home/motherfunder/open-p4studio
Using SDE_INSTALL /home/motherfunder/open-p4studio/install
Model using test directory: 
Model using port info file: None
Using SDE_DEPENDENCIES /home/motherfunder/open-p4studio/install
Using PATH /home/motherfunder/open-p4studio/install/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
Using LD_LIBRARY_PATH /home/motherfunder/open-p4studio/install/lib:/home/motherfunder/open-p4studio/install/lib:/home/motherfunder/open-p4studio/install/lib::/usr/local/lib
 PRIVS: Eff=0x00000000 Perm=0x00002006 Inh=0x00000000
Performing preliminary checks on config file
Opening p4 target config file 'simple_ipv4.json/pipe/context.json' ...
Loaded p4 target config file
 Package size 1
 No of Chips is 1
Chip part revision number is 1
 No of Packages is 1
Chip 0 SKU: defaulting to BFN77110
Chip 0 SKU setting: sku 0 pipe mode 0
Chip 0 Physical pipes enabled bitmap 0xf 
Adding interface veth0 as port 0
bmi_port_interface_add failed for port 0.
Adding interface veth2 as port 1
bmi_port_interface_add failed for port 1.
Adding interface veth4 as port 2
bmi_port_interface_add failed for port 2.
Adding interface veth6 as port 3
bmi_port_interface_add failed for port 3.
Adding interface veth8 as port 4
bmi_port_interface_add failed for port 4.
Adding interface veth10 as port 5
bmi_port_interface_add failed for port 5.
Adding interface veth12 as port 6
bmi_port_interface_add failed for port 6.
Adding interface veth14 as port 7
bmi_port_interface_add failed for port 7.
Adding interface veth16 as port 8
bmi_port_interface_add failed for port 8.
Adding interface veth18 as port 9
bmi_port_interface_add failed for port 9.
Adding interface veth20 as port 10
bmi_port_interface_add failed for port 10.
Adding interface veth22 as port 11
bmi_port_interface_add failed for port 11.
Adding interface veth24 as port 12
bmi_port_interface_add failed for port 12.
Adding interface veth26 as port 13
bmi_port_interface_add failed for port 13.
Adding interface veth28 as port 14
bmi_port_interface_add failed for port 14.
Adding interface veth30 as port 15
bmi_port_interface_add failed for port 15.
Adding interface veth32 as port 16
bmi_port_interface_add failed for port 16.
Adding interface veth250 as port 64
bmi_port_interface_add failed for port 64.
Simulation target: Asic Model
Using TCP port range: 8001-8004
Listen socket created
bind done on port 8001. Listening..
Waiting for incoming connections...
CLI listening on port 8000



```

for running switchd with intended output
```
motherfunder@motherfunder-VivoBook-ASUSLaptop-X515DA:~/IamWorking/tofinoCase/simpleforwarding$ # Try running switchd with explicit config file path
sudo bash -c "
export SDE=/home/motherfunder/open-p4studio
export SDE_INSTALL=/home/motherfunder/open-p4studio/install
export LD_LIBRARY_PATH=\$SDE_INSTALL/lib:\$LD_LIBRARY_PATH
\$SDE/run_switchd.sh -p simple_ipv4 -c simple_ipv4.json/pipe/context.json
"
Using SDE /home/motherfunder/open-p4studio
Using SDE_INSTALL /home/motherfunder/open-p4studio/install
Setting up DMA Memory Pool
Using TARGET_CONFIG_FILE simple_ipv4.json/pipe/context.json
Using SDE_DEPENDENCIES /home/motherfunder/open-p4studio/install
Using PATH /home/motherfunder/open-p4studio/install/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
Using LD_LIBRARY_PATH /home/motherfunder/open-p4studio/install/lib:/home/motherfunder/open-p4studio/install/lib:/home/motherfunder/open-p4studio/install/lib::/usr/local/lib
2025-08-08 13:27:39.736653 BF_SWITCHD DEBUG - bf_switchd: system services initialized
2025-08-08 13:27:39.736719 BF_SWITCHD DEBUG - bf_switchd: loading conf_file simple_ipv4.json/pipe/context.json...
2025-08-08 13:27:39.736763 BF_SWITCHD DEBUG - bf_switchd: processing device configuration...
2025-08-08 13:27:39.742224 BF_SWITCHD DEBUG - Cannot find chip_list in conf file
2025-08-08 13:27:39.742364 BF_SWITCHD DEBUG - bf_switchd: processing P4 configuration...
2025-08-08 13:27:39.762317 BF_SWITCHD DEBUG - Initialized the device types using PAL handler registration
Starting PD-API RPC server on port 9090
2025-08-08 13:27:39.782406 BF_SWITCHD DEBUG - bf_switchd: drivers initialized
2025-08-08 13:27:39.782552 BF_SWITCHD DEBUG - bf_switchd: initialized 0 devices
2025-08-08 13:27:39.782610 BF_SWITCHD DEBUG - bf_switchd: spawning cli server thread
2025-08-08 13:27:39.782949 BF_SWITCHD DEBUG - bf_switchd: spawning driver shell
2025-08-08 13:27:39.783069 BF_SWITCHD DEBUG - bf_switchd: server started - listening on port 9999

        ******************************bfruntime gRPC server started on 0.0.0.0:50052
**************
        *      WARNING: Authorised Access Only     *
        ********************************************
    

bfshell> sudo

```
