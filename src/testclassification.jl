#=
testclassification:
- Julia version: 
- Author: yusufrahadika
- Date: 2019-11-21
=#

include("classification.jl")
using Dates

function get_file_names_and_classes_from_path(path::String)::Tuple{Array{String, 1}, Array{String, 1}}
    data_classes = readdir(path)

    file_names = []
    file_classes = []

    for data_class in data_classes
        if !startswith(data_class, "._")
            class_path = path * "/" * data_class
            file_names_in_class = readdir(class_path)
            for file_name_in_class in file_names_in_class
                if !startswith(file_name_in_class, "._")
                    push!(file_names, class_path * "/" * file_name_in_class)
                    push!(file_classes, data_class)
                end
            end
        end
    end
    return file_names, file_classes
end

print("Masukkan direktori data: ")
path = readline()
folders = readdir(path)
if "Data latih" in folders && "Data uji" in folders
    classification = Classification()
    println(now())
    (train_file_names, train_file_classes) = get_file_names_and_classes_from_path(path * "/Data latih")
    println(now())
    train(classification, train_file_names, train_file_classes)
    println(now())
    (test_file_names, test_file_classes) = get_file_names_and_classes_from_path(path * "/Data uji")
    test_results = test(classification, test_file_names)
    println(test_results)
    println(now())
    println(hitungAkurasi(test_results, test_file_classes))
    println(now())
else
    println("Direktori tidak valid")
end
