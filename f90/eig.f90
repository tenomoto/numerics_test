program eig
    implicit none

    integer, parameter :: n = 1000, lwork = 4 * n
    character, parameter :: &
        jobvl = 'n', jobvr = 'n'

    integer :: i, j, info
    real * 8, dimension(n, n) :: a, vl, vr
    real * 8, dimension(n) :: wr, wi
    real * 8, dimension(lwork) :: work
    
    do j=1, n
        do i=1, n
            call random_number(a(i, j))
        end do
    end do

    call dgeev(jobvl, jobvr, n, a, n, wr, wi, vl, n, vr, n, work, lwork, info)

end program eig