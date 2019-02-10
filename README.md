# Matrix Computation with PowerShell

[PowerShell for MathNet.Numerics](https://cyber-defense.sans.org/blog/2015/06/27/powershell-for-math-net-numerics/) motivated me to test the performance of matrix computation of MathNet Numerics with PowerShell and F# against Numpy and Fortran.

[日本語](https://qiita.com/tenomoto/items/ee47c3b0361f5945a1ef)
 
## Machine

* Intel Core i5-6500 @ 3.2 GHz 16GB RAM (self-built)
* Windows 10 1803

## Python

* Official Python 3.7.1 at [Python.org](https://www.python.org) with [Numpy](https://www.numpy.org/) 1.16.1 installed with [pip](https://pip.pypa.io/en/stable/). `numpy.show_config()` shows that numpy is linked against OpenBLAS.
* Intel Python 3.6.5 with Numpy 1.15.4 and MKL 2019.2 installed as a Conda virtual environment.
* [Installing Intel® Distribution for Python* and Intel® Performance Libraries with Anaconda*](https://software.intel.com/en-us/articles/using-intel-distribution-for-python-with-anaconda)
* Measured with timeit module

## Fortran

* PGI Community Editon 1810
* [Intel Math Kernel Library 2019](https://software.intel.com/en-us/mkl) update 2

Installed MKL with the network installer. Choose to omit 32-bit libraries and to support the PGI compiler. Compile commands for the binaries with PGI BLAS/LAPACK and with MKL are as follows.

```
pgfortran -mp -Minfo -fast svd -lblas -llapack -o svd
pgfortran -mp -Minfo -fast -o svd_mkl svd.f90 -L"$MKLPATH" mkl_intel_lp64.lib mkl_pgi_thread.lib mkl_core.lib
```

## F#

* Installed with Visual Studio 2017.
* .NET Core 2.2 Windows

### Create a project

Create a new project and add necessary packages.
Packages are installed in `%USERPROFILE%\.nuget\packages`.

```
> dotnet new console -lang F# -o fsharp
> cd fsharp
> dotnet add package MathNet.Numerics
> dotnet add package MathNet.Numerics.MKL.Win-x64
```

### Compile

Running the project with `dotnet run` result in suboptimal performance.
The standalne binary (`exe`) created with `publish` is used.

```
> dotnet publish -c Release -r win-x64
```

### Results
|                | mutmul |  eig  |  svd  |  inv  | det |
|:---------------|-------:|------:|------:|------:|-----|
| PowerShell     |   3369 | 15602 | 11685 | 10723 | 627 |
| PowerShell MKL |    474 |   825 |   486 |    81 |  59 |
| Python         |   2167 | 12884 |  6609 |   593 | 324 |
| Python MKL     |   2146 |  7168 |  2814 |   544 | 254 |
| Fortran        |   1840 |  1468 |   718 |   309 | 126 |
| Fortran MKL    |    539 |   950 |   583 |   225 |  76 |
| F#             |   3259 | 14538 | 10810 | 10961 | 616 |
| F# MKL         |    582 |   960 |   580 |   172 | 142 |