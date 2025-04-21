function normalize(str, cfg)
    str = str:gsub(cfg.separator or "([%_])", " ")  -- uniformly use ' ' as separators, default to underscore
    if cfg.case then
        str = str:gsub("(%l)(%u)", "%1 %2"):gsub("(%u)(%u%l)", "%1 %2")
    end
    str = str:gsub("([%s]+)", " ")                  -- remove extra spaces

    local words = {}
    for word in str:lower():gmatch("%S+") do
        table.insert(words, word)
    end
    return words
end

function to_snake(input)
    if type(input) ~= "table" then
        raise("input isn't a table!")
    end
    return table.concat(input, "_")
end

function to_lowercamel(input)
    if type(input) ~= "table" then
        raise("input isn't a table!")
    end

    if #input == 0 then return "" end
    local result = input[1]
    for i = 2, #input do
        local word = input[i]
        result = result .. word:sub(1, 1):upper() .. word:sub(2)
    end
    return result
end

function to_uppercamel(input)
    if type(input) ~= "table" then
        raise("input isn't a table!")
    end

    if #input == 0 then return "" end
    local result = ""
    for i = 1, #input do
        local word = input[i]
        result = result .. word:sub(1, 1):upper() .. word:sub(2)
    end
    return result
end
