function split(str)
    local processed_str =
        str:gsub("([%_%-%/%.%s]+)", " ")    -- uniformly use ' ' as separators
        :gsub("(%l)(%u)", "%1 %2")          -- insert a space between lowercase and uppercase letters
        :gsub("(%u)(%u%l)", "%1 %2")        -- process str like "JSONParser"

    local words = {}
    for word in processed_str:lower():gmatch("%S+") do
        table.insert(words, word)
    end
    return words
end

function to_snake(input)
    local words =
        (type(input) == "string" and split(input)) or
        (type(input) == "table" and input) or
        raise("param isn't a string or table!")

    return table.concat(words, "_")
end

function to_lowercamel(input)
    local words =
        (type(input) == "string" and split(input)) or
        (type(input) == "table" and input) or
        raise("param isn't a string or table!")

    if #words == 0 then return "" end
    local result = words[1]
    for i = 2, #words do
        local word = words[i]
        result = result .. word:sub(1, 1):upper() .. word:sub(2)
    end
    return result
end

function to_uppercamel(input)
    local words =
        (type(input) == "string" and split(input)) or
        (type(input) == "table" and input) or
        raise("param isn't a string or table!")

    if #words == 0 then return "" end
    local result = ""
    for i = 1, #words do
        local word = words[i]
        result = result .. word:sub(1, 1):upper() .. word:sub(2)
    end
    return result
end
