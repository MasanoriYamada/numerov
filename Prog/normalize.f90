!----------------------------------------------------------
!----------------------------------------------------------
! output : radial wf in [MeV^(1/2)]
subroutine normalize( wf, r_step, N_step )
  use params
  implicit none
!----------------------------------------------------------
  real*8,     intent(in) :: r_step ! [1/MeV]
  integer,    intent(in) :: N_step
  real*8,     intent(inout) :: wf(0:N_step)
!----------------------------------------------------------
  integer i
  real*8  norm
!----------------------------------------------------------
  
  norm = 0.D0

  do i = 0, N_step
     norm = norm + abs(wf(i)**2)
  enddo

  norm = norm - 0.5D0 * ( abs(wf(0)**2) + abs(wf(N_step)**2) )

  norm = 1.D0 / sqrt(norm * r_step)

  do i = 0, N_step
     wf(i) = wf(i) * norm
  enddo

  return
end subroutine normalize
!----------------------------------------------------------
!----------------------------------------------------------
