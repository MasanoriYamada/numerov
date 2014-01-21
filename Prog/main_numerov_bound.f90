!----------------------------------------------------------
!----------------------------------------------------------
program numerov

  use params
  use potentials
  implicit none

  character*1200 arg
!----------------------------------------------------------
!----------------------------------------------------------
  real*8, allocatable:: wf(:)
  real*8  E, E_min, E_max, E_step
  real*8     r_min, r_max, r_step
  integer N_step,Max
  integer L, conf_in, conf_fi, iconf, it_in, it_fi, it
  character*128 in_fname, out_fname, out_fname1
!----------------------------------------------------------
  integer iflg
  integer i
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


   Max = conf_fi + 1
   !Max = 700
    
    do it = it_in, it_fi
       write(*,*) 'T = ' , it
       do iconf = conf_in, conf_fi
!for each bin
          write (in_fname, "('/home/sinyamada/results/set1/ts32/spin00.bin1/fitPot/bin/1g1y1D.',i6.6,&
               '-',i6.6,'.RC16x32_B1830Kud013760Ks013710C1761.it',i2.2,'')")&
               Max, iconf, it
          write(out_fname, "('/home/sinyamada/results/set1/ts32/spin00.bin1/phase/bin/1g1y1D_energy.',i6.6,&
               '-',i6.6,'.RC16x32_B1830Kud013760Ks013710C1761.it',i2.2,'')")&
               Max, iconf, it
!for ave
         ! write (in_fname, "('/data1/yamada/OmgOmg/results/set1/ts32/ave/fitPot/ave_1g1yy3D.',i6.6,&
         !      '-',i6.6,'.RC16x32_B1830Kud013760Ks013710C1761.it',i2.2,'')")&
         !      Max, iconf, it
         ! write(*,*) in_fname
         ! 
         ! write(out_fname, "('/data1/yamada/OmgOmg/results/set1/ts32/ave/phase/ave_1g1yy3D_energy.',i6.6,&
         !      '-',i6.6,'.RC16x32_B1830Kud013760Ks013710C1761.it',i2.2,'')")&
         !      Max, iconf, it
          
          allocate(wf(0:N_step))

         ! write(*,*) in_fname
         ! write(*,*) out_fname

          open (1,file=in_fname, status='old')
          open (2,file=out_fname, status='replace')
          call set_pot(iconf,it)
  call numerov_bound( E, wf, r_min/hbarc, r_max/hbarc, N_step, L, E_min, E_max, E_step, iflg )
  
  if ( iflg .eq. 0 ) then
     write(*,*) 'No bound state found.'
!     write(2,*) 0.D0
  else
          write(*,*) E
     write(2,*) E
     r_step = (r_max - r_min) / N_step
     do i = 0, N_step
        ! convert the dimension of wf from [MeV^(1/2)] ==> [fm^(-1/2)]
        !write(*,'(2(E15.5))') i * r_step, wf(i)/sqrt(hbarc)
     enddo
     close(2)
     close(1)
  endif
  deallocate(wf)
enddo
enddo


  stop
end program numerov
!----------------------------------------------------------
!----------------------------------------------------------
