"""
# module preprocessing

- Julia version:
- Author: yusufrahadika
- Date: 2019-11-14

# Examples

```jldoctest
julia>
```
"""

module Preprocessing
export cleaning, case_folding, tokenisasi, filtering, stemming, preprocess
    using PyCall
    StemmerFactory = pyimport("Sastrawi.Stemmer.StemmerFactory").StemmerFactory
    factory = StemmerFactory()
    stemmer = factory.create_stemmer()
    stopwords = split(read(open("../data/stopword-list.txt", "r"), String), "\n")

    function cleaning(source::String)
        stripped_source::String = strip(source)
        stripped_source = replace(stripped_source, r"[\S]+\.(net|com|org|info|edu|gov|uk|de|ca|jp|fr|au|us|ru|ch|it|nel|se|no|es|mil)[\S]*\s?" => s" ")

        result::String = ""

        source_last_char_index::Int64 = length(stripped_source)
        for (charindex, char) in enumerate(stripped_source)
            if (ispunct(char) || isdigit(char))
                if (charindex != source_last_char_index)
                    next_char::Char = stripped_source[charindex + 1]
                    if (!ispunct(next_char) && !isdigit(next_char) && next_char != " ")
                        result = string(result, " ")
                    end
                end
            else
                result = string(result, char)
            end
        end

        return result
    end

    function case_folding(source::String)
        return lowercase(source)
    end

    function tokenisasi(source::String)
        return split(source)
    end

    function filtering(source::Array)
       return [word for word in source if !(word in stopwords)]
    end

    function stemming(source::Array)
        return [stemmer.stem(word) for word in source if isascii(word)]
    end

    function preprocess(source::String)
        return stemming(filtering(tokenisasi(case_folding(cleaning(source)))))
    end
end