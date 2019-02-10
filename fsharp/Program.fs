// Learn more about F# at http://fsharp.org
open MathNet.Numerics
open MathNet.Numerics.LinearAlgebra

[<EntryPoint>]
let main argv =
//    Control.UseNativeMKL()
//    Control.UseManaged()
    let a = 
        match argv.[0] with
        | "mutmul" -> 
            let x = Matrix<float>.Build.Random(2000, 2000) *
                    Matrix<float>.Build.Random(2000, 2000)
            0
        | "eig" -> 
            let x = Matrix<float>.Build.Random(1000, 1000).Evd()
            0
        | "svd" ->
            let x = Matrix<float>.Build.Random(1000, 1000).Svd()
            0
        | "inv" ->
            let x = Matrix<float>.Build.Random(1000, 1000).Inverse()
            0
        | "det" ->
            let x = Matrix<float>.Build.Random(1000, 1000).Determinant()
            0
        | _ -> 0
        
    0 // return an integer exit code