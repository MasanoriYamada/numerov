!----------------------------------------------------------
!----------------------------------------------------------
module bessels

  implicit none

contains

!----------------------------------------------------------
  real*8 function S_Bessel_J( L, x )
    implicit none
    integer,     intent(in)  :: L ! angular momentum
    real*8,      intent(in)  :: x

    if ( L .eq. 0 ) then
       S_Bessel_J = sin(x) / x
    else if ( L .eq. 1 ) then
       S_Bessel_J = sin(x) / x**2 - cos(x) / x
    else if ( L .eq. 2 ) then
       S_Bessel_J = (3.D0/x**3 - 1.D0/x) * sin(x) - 3.D0/x**2 * cos(x)
    else if ( L .eq. 3 ) then
       S_Bessel_J = ( (15.D0 - 6.D0 * x**2) * sin(x) - x*(15.D0 - x**2) * cos(x) ) / x**4
    else if ( L .eq. 4 ) then
       S_Bessel_J = ( (105.D0 - 45.D0 * x**2 + x**4) * sin(x) - x*(105.D0 - 10.D0 * x**2) * cos(x) ) / x**5
    else if ( L .eq. 5 ) then
       S_Bessel_J = ( (945.D0 - 420.D0 * x**2 + 15.D0 * x**4) * sin(x) - x*(945.D0 - 105.D0 * x**2 + x**4) * cos(x) ) / x**6
    else
       write(*,*) 'S_Bessel_J: L = ', L, 'is not supported.'
       call exit(1)
    endif

  end function S_Bessel_J

!----------------------------------------------------------
  real*8 function S_Bessel_Y( L, x )
    implicit none
    integer,     intent(in)  :: L ! angular momentum
    real*8,      intent(in)  :: x

    if ( L .eq. 0 ) then
       S_Bessel_Y = -cos(x) / x
    else if ( L .eq. 1 ) then
       S_Bessel_Y = -cos(x) / x**2 - sin(x) / x
    else if ( L .eq. 2 ) then
       S_Bessel_Y = -(3.D0/x**3 - 1.D0/x) * cos(x) - 3.D0/x**2 * sin(x)
    else if ( L .eq. 3 ) then
       S_Bessel_Y = - ( (15.D0 - 6.D0 * x**2) * cos(x) + x*(15.D0 - x**2) * sin(x) ) / x**4
    else if ( L .eq. 4 ) then
       S_Bessel_Y = - ( (105.D0 - 45.D0 * x**2 + x**4) * cos(x) + x*(105.D0 - 10.D0 * x**2) * sin(x) ) / x**5
    else if ( L .eq. 5 ) then
       S_Bessel_Y = - ( (945.D0 - 420.D0 * x**2 + 15.D0 * x**4) * cos(x) + x*(945.D0 - 105.D0 * x**2 + x**4) * sin(x) ) / x**6
    else
       write(*,*) 'S_Bessel_Y: L = ', L, 'is not supported.'
       call exit(1)
    endif

  end function S_Bessel_Y
!----------------------------------------------------------

end module bessels
!----------------------------------------------------------
!----------------------------------------------------------
