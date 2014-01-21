#!/bin/csh -f

# [MeV]
mass=1052.3 # reduced mass
omega=700.0

# [MeV]
E_min=-70.0
E_max=-60.0
E_step=0.1

# [fm]
r_min=0.0
r_max=1000.0
#set r_step = 0.0005

N_step=10000
L=0
Conf_in=0
Conf_fi=0

./Prog/numerov_bound.x $mass $omega $E_min $E_max $E_step $r_min $r_max $N_step $L $Conf_in $Conf_fi
