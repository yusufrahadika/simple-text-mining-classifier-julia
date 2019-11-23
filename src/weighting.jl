#=
weighting:
- Julia version: 
- Author: yusufrahadika
- Date: 2019-11-16
=#

using DataStructures, LinearAlgebra

mutable struct Weighting
    documents::Array{Array{String, 1}, 1}
    features::Array{String, 1}
    tf::Matrix{Int64}
    idf::Array{Float64, 1}
    tf_idf::Matrix{Float64}
end

Weighting()::Weighting = Weighting([[]], [], zeros(Int64, (0, 0)), zeros(Float64, 0), zeros(Int64, (0, 0)))

function setText(weighting::Weighting, documents::Array{Array{String, 1}})
    weighting.documents = documents
    weighting.features = [key for key in keys(OrderedDict{}(word => Nothing for document in documents for word in document))]
    weighting.tf = [count(word -> word == feature, document) for feature in weighting.features, document in documents]

    documents_length = length(documents)
    weighting.idf = [log10(documents_length / count(weight -> weight > 0, row)) for row in eachrow(weighting.tf)]

    (tf_row_count, tf_column_count) = size(weighting.tf)

    weighting.tf_idf = [
        (if weighting.tf[row_index, column_index] > 0 ((1 + log10(weighting.tf[row_index, column_index])) * term_idf) else 0 end)
        for (row_index, term_idf) in enumerate(weighting.idf), column_index = 1:tf_column_count
    ]
end
