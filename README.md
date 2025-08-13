

# head to the directory where built repo is made (generally done on own)
```
cd /home/motherfunder/open-p4studio/build/p4-build/my_program

```

# after compilation done, running the model
```
$SDE/run_tofino_model.sh [--arch tofino] -p simple_ipv4
```

# in new terminal, running switchd
(ensure to do source ~/setup-open-p4studio.bash)
```
$SDE/run_switchd.sh  --arch tofino -p simple_ipv4
```

play with open p4 studio in bfshell>
```
bfrt_python
```
