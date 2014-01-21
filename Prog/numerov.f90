!----------------------------------------------------------
!----------------------------------------------------------
! find only the most deeply bound state
subroutine numerov_bound &
     ( E, wf, r_min, r_max, N_step, L, E_min, E_max, E_step, iflg )

  use params
  use bessels
  use potentials
  implicit none

  real*8, parameter:: eps    = 1.D-4
!----------------------------------------------------------
  real*8,     intent(in) :: r_min, r_max ! [1/MeV]
  integer,    intent(in) :: N_step
  integer,    intent(in) :: L
  real*8,     intent(in) :: E_min, E_max, E_step ! [MeV]
  real*8,     intent(out):: E                    ! [MeV]
  real*8,     intent(out):: wf(0:N_step)
  integer,    intent(out):: iflg ! whether bound state is found or not
!----------------------------------------------------------
  real*8, allocatable::  u(:) ! radial wave func
  real*8, allocatable::  w(:) ! w = (1 - h^2/12 sub_F) u

  real*8  u_edge_init
  real*8  E_delta, E_eps
  real*8  r_step ,r_max_c
  real*8  k_freq, lambda
  character*128 out_fname !debug
  integer i            !debug

!----------------------------------------------------------

  E       = E_min
  E_delta = E_step
  E_eps   = E_step * eps

  ! wave freq & wave length
call calc_r_max(E, mass, r_max, r_min, N_step, r_max_c, lambda, k_freq, r_step)
!  write(*,*) 'lambda [fm] =', lambda * hbarc
  if ( r_step > lambda / 5. ) then ! 5 is tentative number
     write(*,'(A,E12.5,A,E12.5,A)') 'r_step = ', r_step, &
          ' should be smaller than 1/5 * wave length(= ', lambda, ')'
     call exit(1)
  endif


  allocate( u(0:N_step) )
  allocate( w(0:N_step) )
  if ( r_min .ne. 0.D0 ) then
          write(*,*) 'r_min = ', r_min, 'while r_min = 0 is assumed.'
     call exit(1)
  endif


  !!! initial condition
  call numerov_init( u, w, r_step, L, E )

  !!! 1st solve
  call numerov_integral( u, w, r_min, r_max_c, N_step, L, E )

  u_edge_init = u(N_step)
  iflg = 0
  !write(*,*) 'first value =  ',u_edge_init
  ! find the binding energy by the shooting method
  do while ( (E_delta .gt. E_eps) .and. (E .le. E_max) )
     E = E + E_delta

     call calc_r_max(E, mass, r_max, r_min, N_step, r_max_c, lambda, k_freq, r_step)

!write (*,*) lambda , r_max_c
     
     call numerov_init( u, w, r_step, L, E )
     call numerov_integral( u, w, r_min, r_max_c, N_step, L, E )

!debug part
!    write(out_fname, "('./wave/wave',SP,f7.4,'.RC16x32_B1830Kud013760Ks013710C17610.it07')") E
!    write(out_fname, "('./wave/wave',SP,f7.4,'.RC16x32_B1830Kud013760Ks013710C17610.it07')") E
!    write(out_fname, "('./wave.bin100/wave',SP,f7.4,'.RC16x32_B1830Kud013760Ks013710C17610.it07')") E
!    write(out_fname, "('./waveWell/wave',SP,f8.4,'.well.dat')") E
!  open (5,file=out_fname, status='replace')
!     do i = 0, N_step
!     write(5,*) i*r_step*hbarc,' ',u(i)
!     enddo
!  close(5)
!write(*,*) E

!debug part end
     if ( u_edge_init * u(N_step) .lt. 0.D0 ) then
        iflg = 1 ! found
        E = E - E_delta
        E_delta = E_delta / 2.D0
     endif

  enddo


  if ( iflg .eq. 1 ) then
     wf(0:N_step) = u(0:N_step)
     call normalize( wf, r_step, N_step )
  else
     wf(0:N_step) = 0.D0
     E = 0.D0 ! junk number
  endif


  deallocate(u)
  deallocate(w)

  return
end subroutine numerov_bound
!----------------------------------------------------------
!----------------------------------------------------------
subroutine numerov_scatt &
     ( phase, r_min, r_max, N_step, L, E )

  use params
  use bessels
  use potentials
  implicit none
!----------------------------------------------------------
  real*8,     intent(out):: phase        ! [rad]
  real*8,     intent(in) :: r_min, r_max ! [1/MeV]
  integer,    intent(in) :: N_step
  integer,    intent(in) :: L
  real*8,     intent(in) :: E            ! [MeV]
!----------------------------------------------------------
  real*8, allocatable::  u(:) ! radial wave func
  real*8, allocatable::  w(:) ! w = (1 - h^2/12 sub_F) u

  integer N_tmp1, N_tmp2, N_step2

  real*8  r1, r2, r_step
  real*8  k_freq, lambda
  real*8  K
  real*8  tan_delta
!----------------------------------------------------------

  ! wave freq & wave length
  k_freq = sqrt(2.D0 * mass * abs(E))
  lambda = 2.D0 * Pi / k_freq
  r_step = (r_max - r_min) / dble(N_step)

!  write(*,*) 'lambda [fm] =', lambda * hbarc
  if ( r_step > lambda / 5. ) then ! 5 is tentative number
     write(*,'(A,E12.5,A,E12.5,A)') 'r_step = ', r_step, &
          ' should be smaller than 1/5 * wave length(= ', lambda, ')'
     call exit(1)
  endif

  r1 = r_max
  r2 = r_max + lambda / 2.D0

  N_tmp1 = (r2 - r1) / r_step
  N_tmp2 = (r2 - r1) / r_step + 1

  if ( abs(r1 + N_tmp1 * r_step - r2) <= abs(r1 + N_tmp2 * r_step - r2) ) then
     N_step2 = N_step + N_tmp1
  else
     N_step2 = N_step + N_tmp2
  endif

  r2 = r1 + (N_step2 - N_step) * r_step


  allocate( u(0:N_step2) )
  allocate( w(0:N_step2) )
  if ( r_min .ne. 0.D0 ) then
     write(*,*) 'r_min = ', r_min, 'while r_min = 0 is assumed.'
     call exit(1)
  endif


  !!! initial condition
  call numerov_init( u, w, r_step, L, E)

  !!! solve
  call numerov_integral( u, w, r_min, r2, N_step2, L, E )


  !!! phase shift
  K = (r1 * u(N_step2)) / (r2 * u(N_step))
  tan_delta = &
       ( K * S_Bessel_J(L, k_freq*r1) - S_Bessel_J(L, k_freq*r2) ) &
       / ( K * S_Bessel_Y(L, k_freq*r1) - S_Bessel_Y(L, k_freq*r2) )
  write(3,*) k_freq , k_freq/tan_delta
  !write(*,*) k_freq , k_freq/tan_delta
  phase = atan( tan_delta )


  deallocate(u)
  deallocate(w)

  return
end subroutine numerov_scatt
!----------------------------------------------------------
!----------------------------------------------------------
subroutine numerov_init &
     ( u, w, r_step, L, E )

  use potentials
  implicit none
!----------------------------------------------------------
  real*8,      intent(out) :: u(0:1)
  real*8,      intent(out) :: w(0:1)
  real*8,      intent(in)  :: r_step
  integer,     intent(in)  :: L ! angular momentum
  real*8,      intent(in)  :: E ! energy
!----------------------------------------------------------

  u(0) = 0.D0
  if ( L .ne. 1 ) then 
     w(0) = 0.D0
  else
     w(0) = - r_step**2/12.D0 * L*(L+1) ! normalization & dimensionality should be consistent with w(1)
  endif

  u(1) = r_step ** (L+1)
  w(1) = ( 1.D0 - r_step**2/12.D0 * sub_F(L, r_step, E) ) * u(1)

  return
end subroutine numerov_init
!----------------------------------------------------------
!----------------------------------------------------------
subroutine numerov_integral &
     ( u, w, r_min, r_max, N_step, L, E )

  use potentials
  implicit none
!----------------------------------------------------------
  integer,     intent(in)  :: N_step
  real*8,      intent(inout) :: u(0:N_step)
  real*8,      intent(inout) :: w(0:N_step)
  real*8,      intent(in)  :: r_min, r_max
  integer,     intent(in)  :: L ! angular momentum
  real*8,      intent(in)  :: E ! energy
!----------------------------------------------------------
  real*8 r, r_step, r_m
  integer i
!----------------------------------------------------------
!write(*,*),E,'   ',N_step
  r_step = abs( (r_max - r_min) ) / dble(N_step)

  do i = 2, N_step

     r = r_min + r_step * i
     r_m  = r - r_step

     w(i) = 2.D0 * w(i-1) - w(i-2) + r_step**2 * sub_F( L, r_m, E) * u(i-1)

     u(i) = w(i) / ( 1.D0 - r_step**2/12.D0 * sub_F(L, r, E) )
!write(*,*),i,"  ",r,'  ',potential(hbarc*r)
!!write(*,*),i*r_step,'  ',u(i)

  enddo

  return
end subroutine numerov_integral
!----------------------------------------------------------
!----------------------------------------------------------
subroutine calc_r_max &
     (E, mass, r_max, r_min, N_step,r_max_c, lambda, k_freq, r_step)

use params
implicit none
!----------------------------------------------------------
integer,      intent(in)   :: N_step
real*8 ,      intent(in)   :: r_max, r_min
real*8 ,      intent(in)   :: E, mass
real*8 ,      intent(out)  :: r_max_c, lambda, k_freq, r_step
!----------------------------------------------------------
  k_freq = sqrt(2.D0 * mass * abs(E))
  lambda = 2.D0 * Pi / k_freq
  r_max_c = lambda
!  r_max_c = r_max
  r_step = (r_max_c - r_min) / dble(N_step)

  return
end subroutine calc_r_max
!----------------------------------------------------------
