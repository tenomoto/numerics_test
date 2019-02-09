# https://cyber-defense.sans.org/blog/2015/06/27/powershell-for-math-net-numerics/
Add-Type -Path "$env:USERPROFILE/.nuget/packages/mathnet.numerics/4.7.0/lib/netstandard2.0/MathNet.Numerics.dll"
Add-Type -Path "$env:USERPROFILE/.nuget/packages/mathnet.numerics.data.text/4.0.0/lib/netstandard2.0/MathNet.Numerics.Data.Text.dll"
[psobject].Assembly.GetType("System.Management.Automation.TypeAccelerators")::Add('M', 'MathNet.Numerics.LinearAlgebra.Matrix[Double]')
[psobject].Assembly.GetType("System.Management.Automation.TypeAccelerators")::Add('V','MathNet.Numerics.LinearAlgebra.Vector[Double]')
[psobject].Assembly.GetType("System.Management.Automation.TypeAccelerators")::Add('STAT','MathNet.Numerics.Statistics.Statistics')
[psobject].Assembly.GetType("System.Management.Automation.TypeAccelerators")::Add('FUNC','MathNet.Numerics.SpecialFunctions')

#$MATRIX = [MathNet.Numerics.LinearAlgebra.Matrix[Double]]
#$VECTOR = [MathNet.Numerics.LinearAlgebra.Vector[Double]]
#$STAT = [MathNet.Numerics.Statistics.Statistics]
#$FUNC = [MathNet.Numerics.SpecialFunctions]

#[MathNet.Numerics.Control]::UseNativeMKL("Auto")
[MathNet.Numerics.Control]::LinearAlgebraProvider
#[MathNet.Numerics.Control]::UseManaged()

# Measure-Command -Expression must be ScriptBlock
# [ordered] keep the order of hash
$tests = [ordered]@{
    mutmul = {[M]::Build.Random(2000,2000) * [M]::Build.Random(2000,2000)};
    eig = {([M]::Build.Random(1000,1000)).Evd()};
    svd = {([M]::Build.Random(1000,1000)).Svd()};
    inv = {([M]::Build.Random(1000,1000)).Inverse()};
    det = {([M]::Build.Random(1000,1000)).Determinant()};
}

foreach ($key in $tests.Keys) {
    $t = 1..10 | ForEach-Object {
        Measure-Command -Expression $tests[$key]
    } | Measure-Object -Property TotalMilliseconds -Average
    $key + " " + $t.Average
}

