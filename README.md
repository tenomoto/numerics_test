# PowerShellで行列計算

[PowerShell for MathNet.Numerics](https://cyber-defense.sans.org/blog/2015/06/27/powershell-for-math-net-numerics/)でPowerShellから.NET用の数値計算ライブラリを呼び出せることを知り，Python, Fortran, F#と比較してみることにした。
 
## マシン

* Intel Core i5-6500 @ 3.2 GHz 16GB RAM（自作）
* Windows 10 1803

## Python

* Official Python 3.7.1 + pipでインストールしたnumpy
* MKLはcondaに作ったIntel Pythonの仮想環境。Python 3.6.5, Numpy 1.15.4, MKL 2019.2
* Pythonのみtimeitモジュールで計測

* [インテル® Distribution for Python* と Anaconda* を使用する](https://www.isus.jp/products/python-distribution/using-intel-distribution-for-python-with-anaconda/)

## Fortran

* PGI Community Editon 1810
* [Intel Math Kernel Library 2019](https://software.intel.com/en-us/mkl) update 2

MKLはネットワークインストーラを使用。インストール時に64ビット版のみ，pgiサポートありにカスタマイズ。

```
pgfortran -mp -Minfo -fast svd -lblas -llapack -o svd
pgfortran -mp -Minfo -fast -o svd_mkl svd.f90 -L"$MKLPATH" mkl_intel_lp64.lib mkl_pgi_thread.lib mkl_core.lib
```

## F#

* Visual Studio 2017でインストール。
* .NET Core 2.2 Windows

### プロジェクトの作成

プロジェクトを作成し，必要なパッケージを追加します。
パッケージは`%USERPROFILE%\.nuget\packages`にインストールされます。

```
> dotnet new console -lang F# -o fsharp
> cd fsharp
> dotnet add package MathNet.Numerics
> dotnet add package MathNet.Numerics.MKL.Win-x64
```

### コンパイル

`dotnet run`では遅かったので，`publish`で`exe`を作成。

```
> dotnet publish -c Release -r win-x64
```

### 結果
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