program inv
    implicit none

    integer, parameter :: n = 1000

    integer :: i, j, info
    integer, dimension(n) :: ipiv
    real * 8, dimension(n, n) :: a
    real * 8, dimension(n) :: work

    
    do j=1, n
        do i=1, n
            call random_number(a(i, j))
        end do
    end do

    call dgetrf(n, n, a, n, ipiv, info)
    call dgetri(n, a, n, ipiv, work, n, info)


end program inv