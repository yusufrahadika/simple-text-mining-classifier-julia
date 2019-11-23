#=
testweighting:
- Julia version: 
- Author: yusufrahadika
- Date: 2019-11-16
=#

include("preprocessing.jl")
include("weighting.jl")

source_array = ["aku memakan bebek bebek", "bebek makanan teman aku"]

arr = [Preprocessing.preprocess(source) for source in source_array]
weighting = Weighting()
setText(weighting, arr)
println(weighting.tf)
println(weighting.idf)
println(weighting.tf_idf)
