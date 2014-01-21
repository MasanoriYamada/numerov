#!/bin/bash

# [MeV]
mass=1052.3 # reduced mass
#mass=800.0 # reduced mass
omega=70.0

# [MeV]
E_min=0.02
E_max=30.0
E_step=0.02
#E_min=0.01
#E_max=50.0
#E_step=0.2


# [fm]
r_min=0.0
r_max=20.0
#r_max=1000.0
#set r_step = 0.0005

#N_step=10000
N_step=100000

L=0
Conf_in=610
Conf_fi=699
it_in=8
it_fi=8

nohup ./Prog/numerov_scatt.x $mass $omega $E_min $E_max $E_step $r_min $r_max $N_step $L $Conf_in $Conf_fi $it_in $it_fi &
