$tests = [ordered]@{
    mutmul = {.\f90\mutmul_mkl.exe};
    eig = {.\f90\eig_mkl.exe};
    svd = {.\f90\svd_mkl.exe};
    inv = {.\f90\inv_mkl.exe};
    det = {.\f90\det_mkl.exe};
}

foreach ($key in $tests.Keys) {
    $t = 1..10 | ForEach-Object {
        Measure-Command -Expression $tests[$key]
    } | Measure-Object -Property TotalMilliseconds -Average
    $key + " " + $t.Average
}

