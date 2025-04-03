function _contains_ch(ch, separators)
    for i = 1, #separators do
        if ch == separators:sub(i, i) then
            return true
        end
    end
    return false
end

function autogendir()
    return path.join(os.projectdir(), get_config("buildir"), ".xcpp")
end

function convert_to_camelcase(name, separators)
    local lower_name = string.lower(name)
    local result = ""
    local should_upper = true
    for i = 1, #lower_name do
        local ch = lower_name:sub(i, i)
        if _contains_ch(ch, separators) then
            should_upper = true
        else
            if should_upper then
                result = result .. ch:upper()
                should_upper = false
            else
                result = result .. ch
            end
        end
    end
    return result
end
