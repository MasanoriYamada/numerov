#!/bin/csh -f

# [MeV]
mass=1052.3 # reduced mass
omega=70.0

# [MeV]
#E_min=-4.0
#E_max=4.0
#E_step=0.2

E_min=-20.0
E_max=0.0
E_step=0.2

# [fm]
r_min=0.0
r_max=20.0
#r_max=100.0
#set r_step = 0.0005

N_step=10000
L=0
Conf_in=0
Conf_fi=699
it_in=7
it_fi=9
./Prog/numerov_bound.x $mass $omega $E_min $E_max $E_step $r_min $r_max $N_step $L $Conf_in $Conf_fi $it_in $it_fi
