#FC = g77 -Wall -Wimplicit -O0 # -g
#FC = g77 -Wall -Wimplicit -O4 -fbounds-check # -g
#FC = ifort -convert big_endian -assume byterecl -warn all -autodouble -fpconstant -fpe0 -arch pn4 -vec-report3
#FC = ifort -convert big_endian -assume byterecl -warn all -static -O3 -ipo -xT -vec-report3

#FC  = ifort -convert big_endian -assume byterecl -static -O3 -xW -vec-report3 -sox
#FC2 = ifort -convert big_endian -assume byterecl -static -O2 -xW -vec-report3 -sox
#CC  = icc                                        -static -O3 -xW -vec-report3 -sox

#FC  = ifort -convert big_endian -assume byterecl -i-dynamic -O3 -xW -vec-report3 -mcmodel=medium -sox
#FC2 = ifort -convert big_endian -assume byterecl -i-dynamic -O2 -xW -vec-report3 -mcmodel=medium -sox
#CC  = icc                                        -i-dynamic -O3 -xW -vec-report3 -mcmodel=medium -sox

#FC  = ifort -convert big_endian -assume byterecl -warn all -O0 -g -C -fpe0 -fp-stack-check -traceback -sox
#CC  = icc                                        -Wcheck   -O0 -g -C       -fp-stack-check -traceback -sox

FC  = gfortran
CC  = icc                             -Wcheck -diag-enable warn -check-uninit \
	-O0 -g -C       -fp-stack-check -fstack-security-check -traceback -sox

#FC   = xlf90 -qextname -q64 -O3 -qarch=auto -qcache=auto -qtune=auto -qstrict # -bmaxdata:XXX
#FC77 = xlf   -qextname -q64 -O3 -qarch=auto -qcache=auto -qtune=auto -qstrict # -bmaxdata:XXX
#CC   = xlc             -q64 -O3 -qarch=auto -qcache=auto -qtune=auto -qstrict # -bmaxdata:XXX


#FC = sxf90 -C vopt -Nw -R5 -EP -Wf"-pvctl fullmsg"
#FC = sxf90 -C vopt -Nw -R5 -EP -P stack -Wf"-init stack=nan" -Wf"-init heap=nan"
#FC = sxf90 -C vopt -Nw -R5 -EP -P stack -Wf"-init stack=0x00009" -Wf"-init heap=0x00003"

#FC = mpif77
#FC = mpif90 -f90=ifort

#FC = pathf90 -Ofast -convert big_endian -fullwarn
#FC = mpif90  -Ofast -convert big_endian -fullwarn

########################
# LAPACK lib

# MKL
#LAPACK_LIB = -Wl,--start-group -lmkl_intel      -lmkl_sequential -lmkl_core -Wl,--end-group
#LAPACK_LIB = -Wl,--start-group -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -Wl,--end-group
#LAPACK_LIB = -lmkl_em64t -lguide -lpthread


########################
ifndef FC77
  FC77 = $(FC)
endif
ifndef FC2
  FC2 = $(FC)
endif
export FC77
export FC2
export FC
export CC
export LAPACK_LIB

########################


#select:
#	@echo 'Choose the followings: make numerov'

all: numerov

numerov:
	make -f numerov.makefile

clean:
	make -f numerov.makefile clean

allclean:
	make -f numerov.makefile allclean


#################   EOF   #################
