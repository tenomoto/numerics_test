$tests = [ordered]@{
    mutmul = {.\f90\mutmul.exe};
    eig = {.\f90\eig.exe};
    svd = {.\f90\svd.exe};
    inv = {.\f90\inv.exe};
    det = {.\f90\det.exe};
}

foreach ($key in $tests.Keys) {
    $t = 1..10 | ForEach-Object {
        Measure-Command -Expression $tests[$key]
    } | Measure-Object -Property TotalMilliseconds -Average
    $key + " " + $t.Average
}

