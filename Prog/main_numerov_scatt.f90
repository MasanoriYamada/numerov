!----------------------------------------------------------
!----------------------------------------------------------
Program numerov

  use params
  use potentials
  implicit none

  character*1200 arg
!----------------------------------------------------------
!----------------------------------------------------------
  real*8  phase
  real*8  E, E_min, E_max, E_step
  real*8     r_min, r_max
  integer N_step, Max
  integer L, conf_in, conf_fi, iconf, it_in, it_fi, it
  character*128 in_fname, out_fname, out_fname1
!----------------------------------------------------------
!----------------------------------------------------------
!----------------------------------------------------------

  call getarg(1, arg)
  read (arg, *) mass
  
  call getarg(2, arg)
  read (arg, *) omega

  call getarg(3, arg)
  read (arg, *) E_min

  call getarg(4, arg)
  read (arg, *) E_max

  call getarg(5, arg)
  read (arg, *) E_step

  call getarg(6, arg)
  read (arg, *) r_min

  call getarg(7, arg)
  read (arg, *) r_max

  call getarg(8, arg)
  read (arg, *) N_step

  call getarg(9, arg)
  read (arg, *) L
  
  call getarg(10, arg)
  read (arg, *) conf_in
  
  call getarg(11, arg)
  read (arg, *) conf_fi

  call getarg(12, arg)
  read (arg, *) it_in

  call getarg(13, arg)
  read (arg, *) it_fi
  
  
  Max = 700
  
    do it = it_in, it_fi
       do iconf = conf_in, conf_fi
          write(*,*), iconf ,it
          write (in_fname, "('/home/sinyamada/results/set1/ts22/spin00.bin1/Potential/fitPot/1g1yy3D.'&
          ,i6.6,'-', i6.6,'.RC16x32_B1830Kud013760Ks013710C1761.it',i2.2,'')") Max, iconf, it

          write(out_fname, "('/home/sinyamada/results/set1/ts22/spin00.bin1/phase/bin/1g1yy3D_phase.',i6.6,&
               '-',i6.6,'.RC16x32_B1830Kud013760Ks013710C1761.it',i2.2,'')")&
               Max, iconf, it
          write(out_fname1, "('/home/sinyamada/results/set1/ts22/spin00.bin1/phase/bin/1g1yy3D_kcotdy.',i6.6,&
               '-',i6.6,'.RC16x32_B1830Kud013760Ks013710C1761.it',i2.2,'')")&
               Max, iconf, it

          
          write(*,*), in_fname, out_fname, out_fname1
          open (1,file=in_fname, status='old')
          open (2,file=out_fname, status='replace')
          open (3,file=out_fname1, status='replace')
          do E = E_min, E_max, E_step
             !write(*,*),E,'   ',N_step
             call set_pot(iconf,it)
             call numerov_scatt( phase, r_min/hbarc, r_max/hbarc, N_step, L, E )
             if (phase < 0) then
                phase = Pi +phase
             end if
             !             write(*,*) E, phase * 180.D0/Pi
             write(2,*) E, phase * 180.D0/Pi
          enddo
          close(3)
          close(2)
          close(1)
       enddo
    enddo
    
    stop
end program numerov
!----------------------------------------------------------
!----------------------------------------------------------
