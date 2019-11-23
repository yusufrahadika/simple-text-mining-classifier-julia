#=
classification:
- Julia version: 
- Author: yusufrahadika
- Date: 2019-11-20
=#

using StringEncodings
include("preprocessing.jl")
include("weighting.jl")

mutable struct Classification
    weighting_instance::Weighting
    file_classes::Array{String, 1}
    unique_file_classes::Array{String, 1}
    naive_bayes_model::Matrix{Float64}
end

Classification() = Classification(Weighting(), [], [], zeros(Int64, (0,0)))

function train(classification::Classification, file_names::Array{String, 1}, file_classes::Array{String, 1})
    setText(classification.weighting_instance, [
        Preprocessing.preprocess(read(file_name, String, enc"ISO_8859-1"))
        for file_name in file_names
    ])
    classification.file_classes = file_classes
    classification.unique_file_classes = unique(file_classes)

    feature_count = length(classification.weighting_instance.features)
    class_count = length(classification.unique_file_classes)
    count_word_per_class = zeros(Int64, (feature_count, class_count))

    for (class, document) in zip(classification.file_classes, classification.weighting_instance.documents)
        column_index = findfirst(isequal(class), classification.unique_file_classes)
        for (row_index, feature) in enumerate(classification.weighting_instance.features)
            count_word_per_class[row_index, column_index] += count(word -> word == feature, document)
        end
    end

    classes_words_count = [sum(column_tf) for column_tf in eachcol(classification.weighting_instance.tf)]

    classification.naive_bayes_model = [
        ((count_word_per_class[feature_index, class_index] + 1) / (classes_words_count[class_index] + feature_count))
        for feature_index = 1:feature_count, class_index = 1:class_count
    ]
end

function test(classification::Classification, file_names)::Array{String, 1}
    result::Array{String, 1} = []

    initial_naive_bayes_probability = [
        (count(class_name -> class_name == unique_class, classification.file_classes) / length(classification.file_classes))
        for unique_class in classification.unique_file_classes
    ]

    for file_name in file_names
        naive_bayes_probability = copy(initial_naive_bayes_probability)

        for test_feature in unique(Preprocessing.preprocess(read(file_name, String, enc"ISO_8859-1")))
            feature_index = findfirst(train_feature -> train_feature == test_feature, classification.weighting_instance.features)
            if !isnothing(feature_index)
                for (column_index, unique_class) in enumerate(classification.unique_file_classes)
                    naive_bayes_probability[column_index] *= classification.naive_bayes_model[feature_index, column_index]
                end
            end
        end

        println(naive_bayes_probability)
        maximum_probability = maximum(naive_bayes_probability)
        push!(result, classification.unique_file_classes[findfirst(naive_prob -> naive_prob == maximum_probability, naive_bayes_probability)])
    end

    return result
end

function hitungAkurasi(actual_classes::Array{String, 1}, predicted_classes::Array{String, 1})::Float64
    return count(class -> class[1] == class[2], zip(actual_classes, predicted_classes)) / min(length(actual_classes), length(predicted_classes))
end
