set yl "phase[degree]"
set xl "energy[MeV]"
set title "phase dependent on bin"
set grid
set term aqua 1
plot "set1Bin100t7.dat" w e, "set1Bin70t7.dat" w e ,"set1Bin50t7.dat" w e , "set1Bin20t7.dat" w e ,"set1Bin1t7.dat" w e
set term aqua 2
plot "set1Bin70t7.dat" w e ,"set1Bin50t7.dat" w e , "set1Bin20t7.dat" w e ,"set1Bin1t7.dat" w e