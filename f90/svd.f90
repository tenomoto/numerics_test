program svd
    implicit none

    integer, parameter :: n = 1000, lwork = 5 * n
    character, parameter :: &
        jobu = 'n', jobvt = 'n'

    integer :: i, j, info
    real * 8, dimension(n, n) :: a, u, vt
    real * 8, dimension(n) :: s
    real * 8, dimension(lwork) :: work
    
    do j=1, n
        do i=1, n
            call random_number(a(i, j))
        end do
    end do

    call dgesvd(jobu, jobvt, n, n, a, n, s, u, n, vt, n, work, lwork, info)

end program svd