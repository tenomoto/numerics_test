program det
    implicit none

    integer, parameter :: n = 1000
    integer :: i, j, info
    integer, dimension(n) :: ipiv
    real * 8, dimension(n, n) :: a

    real * 8 :: d = 1.0d0
    
    do j=1, n
        do i=1, n
            call random_number(a(i, j))
        end do
    end do

    call dgetrf(n, n, a, n, ipiv, info)
    ! determinant is the product of diagonal elements of A = PLU
    ! the sign of d is reversed if pivoted
    do i=1, n
        if (ipiv(i) /= i) then
            d = -d * a(i, i)
        else
            d = d * a(i, i)
        end if
    end do

end program det