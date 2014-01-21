!----------------------------------------------------------
!----------------------------------------------------------
! Outputv: [MeV^2]
! m, E:   [MeV]
! r   : [1/MeV]
! L   : dim-less

module potentials

  use params
  implicit none

  ! parameters for the potential
  real*8 mass
  real*8 omega
real*8  pa
real*8  pb
real*8  pc
real*8  pd
real*8  pe
real*8  pf
real*8  pg
real*8  ph

contains

!----------------------------------------------------------

  real*8 function potential_well ( r )
    implicit none
    real*8,     intent(in) :: r

    real*8, parameter:: r_crit  = 10.D0 ! [fm]

    if ( r < r_crit  ) then
       potential_well = - omega
    else
       potential_well = 0.D0
    endif

  end function potential_well

!----------------------------------------------------------

  real*8 function potential_HO ( r )
    implicit none
    real*8,     intent(in) :: r

    potential_HO = 0.5D0 * mass * omega**2 * r**2

  end function potential_HO
!----------------------------------------------------------

real*8 function potential_free ( r )
implicit none
real*8,     intent(in) :: r

potential_free = 0.D0

end function potential_free

!----------------------------------------------------------
!for Omg Omg
real*8 function potential_4g ( r)
implicit none
real*8,     intent(in) :: r




!it 07
!real*8, parameter :: pa               = -533.934
!real*8, parameter :: pb               = 2.80389
!real*8, parameter :: pc               = 486.76
!real*8, parameter :: pd               = 3.91707
!real*8, parameter :: pe               = 2336.8
!real*8, parameter :: pf               = 59.5949
!real*8, parameter :: pg               = -1186.94
!real*8, parameter :: ph               = 58.7904

!it 08
!real*8, parameter :: pa               = -505.925
!real*8, parameter :: pb               = 3.68075
!real*8, parameter :: pc               = 515.608
!real*8, parameter :: pd               = 5.7681
!real*8, parameter :: pe               = 2322.14
!real*8, parameter :: pf               = 65.7699
!real*8, parameter :: pg               = -1201.59
!real*8, parameter :: ph               = 65.7296

!it 09

!real*8, parameter :: pa               = -538.812
!real*8, parameter :: pb               = 4.88676
!real*8, parameter :: pc               = 605.129
!real*8, parameter :: pd               = 8.47487
!real*8, parameter :: pe               = 2292.43
!real*8, parameter :: pf               = 69.9135
!real*8, parameter :: pg               = -1231.31
!real*8, parameter :: ph               = 69.8176

potential_4g = pa*exp(-pb*r**2.0)+pc*exp(-pd*r**2.0)+pe*exp(-pf*r**2.0)+pg*exp(-ph*r**2.0)

end function potential_4g
!----------------------------------------------------------

real*8 function potential_3g ( r)
  implicit none
  real*8,     intent(in) :: r
  
  
  
  
  potential_3g = pa*exp(-pb*r**2.0)+pc*exp(-pd*r**2.0)+pe*exp(-pf*r**2.0)
  
end function potential_3g
!----------------------------------------------------------

real*8 function potential_1g1yy ( r)
  implicit none
  real*8,     intent(in) :: r
  
  if (r == 0) then
     potential_1g1yy = pa
  else 
     potential_1g1yy = pa*exp(-pb*r*r)+ pc*(1 - exp(-pd*r*r))*(1 - exp(-pd*r*r))*(exp(-pe*r)/r)*(exp(-pe*r)/r)
  endif
end function potential_1g1yy
!----------------------------------------------------------

real*8 function potential_1g1y ( r)
  implicit none
  real*8,     intent(in) :: r
  
  if (r == 0) then
     potential_1g1y = pa
  else 
     potential_1g1y = pa*exp(-pb*r*r)+ pc*((1 - exp(-pd*r*r))/r)*exp(-pe*r);
  endif
end function potential_1g1y
!----------------------------------------------------------
real*8 function potential ( r )
  implicit none
  real*8,     intent(in) :: r
  
 ! potential = potential_well(r)
 ! potential = potential_HO(r)
 ! potential = potential_free(r)
 ! potential = potential_4g(r)
 ! potential = potential_3g(r)
 ! potential = potential_1g1yy(r)
  potential = potential_1g1y(r)
  
  !write(*,*),r,'  ',potential
  
end function potential

!----------------------------------------------------------

  real*8 function sub_F (L, r, E)
    implicit none
    integer,    intent(in) :: L
    real*8,     intent(in) :: r
    real*8,     intent(in) :: E
! hbarc act  r: [fm] => [1/MeV] 
    sub_F = &
         2.D0 * mass * ( potential(r*hbarc) - E ) &
         + L*(L+1) / r**2
!write(*,*),r*hbarc,'  ',potential(r*hbarc)

  end function sub_F

!----------------------------------------------------------
subroutine set_pot &
    ( iconf, it)
  implicit none
integer,    intent(in) :: iconf
integer,    intent(in) :: it
real*8  tmp

read (1,*) tmp, pa, tmp, pb, tmp,  pc, tmp,  pd, tmp, pe, tmp, pf!, pg, ph

backspace(1)
backspace(1)
backspace(1)
backspace(1)
backspace(1)
backspace(1)

!write (*,*) pa, pb, pc, pd, pe!, pf, pg, ph

end subroutine set_pot
!----------------------------------------------------------
end module potentials

!----------------------------------------------------------
!----------------------------------------------------------
