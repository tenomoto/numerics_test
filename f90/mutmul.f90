program mutmul
    implicit none

    integer, parameter :: n = 2000
    character, parameter :: &
        transa = 'n', transb = 'n'
    real * 8, parameter :: alpha = 1.0d0, beta = 1.0d0

    integer :: i, j
    real * 8, dimension(n, n) :: a, b, c
    
    do j=1, n
        do i=1, n
            call random_number(a(i, j))
            call random_number(b(i, j))
            c(i, j) = 0.0d0
        end do
    end do

    call dgemm(transa, transb, n, n, n, alpha, a, n, b, n, beta, c, n)

end program mutmul