#=
testpreprocessing:
- Julia version: 
- Author: yusufrahadika
- Date: 2019-11-14
=#

include("preprocessing.jl")
using StringEncodings

print("Masukkan path file untuk diprocess: ")
path = readline()
println(Preprocessing.preprocess(read(path, String, enc"ISO8859-1")))