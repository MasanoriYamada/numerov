########################

.SUFFIXES:
#.SUFFIXES: .f90 .mod
.SUFFIXES: .f90 .o

##########

calc_jackknife.o: calc_jackknife.f90
	$(FC2) -c -o $@ $<

##########

.c.o:
	$(CC) -c -o $@ $<

.f.o:
	$(FC77) -c -o $@ $<

.f90.o:
	$(FC) -c -o $@ $<

.f90.mod:
	$(FC) -c -o $@ $<

#################   EOF   #################
