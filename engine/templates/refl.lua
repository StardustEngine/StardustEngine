function _add_prefixed_attrs(attrs, prefix)
    attrs[prefix .. "_" .. "name"] = attrs["name"]
    attrs[prefix .. "_" .. "full_name"] = attrs["full_name"]
    attrs[prefix .. "_" .. "attrs"] = attrs["attrs"]
    attrs[prefix .. "_" .. "access"] = attrs["access"]
    attrs[prefix .. "_" .. "comment"] = attrs["comment"]
end

function main(raw_metadata)

    local processed_data = raw_metadata

    -- process data to prevent name conflicts
    for _, record in ipairs(processed_data.records) do
        _add_prefixed_attrs(record, "record")
        for _, field in ipairs(record.fields) do
            _add_prefixed_attrs(field, "field")
        end
        for _, method in ipairs(record.methods) do
            _add_prefixed_attrs(method, "method")
            for _, param in ipairs(method.params) do
                _add_prefixed_attrs(param, "param")
            end
        end
    end

    for _, func in ipairs(processed_data.functions) do
        _add_prefixed_attrs(func, "func")
        for _, param in ipairs(func.params) do
            _add_prefixed_attrs(param, "param")
        end
    end

    for _, enum in ipairs(processed_data.enums) do
        _add_prefixed_attrs(enum, "enum")
        for _, constant in ipairs(enum.constants) do
            _add_prefixed_attrs(constant, "constant")
        end
    end

    return processed_data, { "refl.hpp.mustache" }
end
