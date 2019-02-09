$tests = [ordered]@{
    mutmul = {./fsharp.exe mutmul};
    eig = {./fsharp.exe eig};
    svd = {./fsharp.exe svd};
    inv = {./fsharp.exe inv};
     det = {./fsharp.exe det};
}

Push-Location fsharp/bin/Release/netcoreapp2.2/win-x64/publish

foreach ($key in $tests.Keys) {
    $t = 1..10 | ForEach-Object {
        Measure-Command -Expression $tests[$key]
    } | Measure-Object -Property TotalMilliseconds -Average
    $key + " " + $t.Average
}
Pop-Location
