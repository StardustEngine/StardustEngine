import("core.tool.compiler")
import("core.project.project")
import("lib.detect.find_program")

function main(target)
    local ownername = target:values("ownername")

    print("parsing and generating meta for \"%s\".", ownername)

    local collection_files = target:sourcebatches()["sdust.tmpl"].sourcefiles
    if not collection_files or #collection_files == 0 then
        raise("no file specified for %s, parsing ended.", ownername)
    end

    -- collect all header files and generate "collection.hpp"
    local collection = "#pragma once\n"
    for _, collection_file in ipairs(collection_files) do
        local relative_path = path.relative(collection_file, target:values("autogendir"))
        collection = collection .. "#include \"" .. relative_path .. "\"\n"
    end
    local collection_path = path.join(target:values("autogendir"), "collection.hpp")
    io.writefile(collection_path, collection)

    cprint("${bright green}generated meta:${clear} %s", collection_path)

    -- input xparse's arguments and run it
    local args = { collection_path }

    -- input owner's compile flags
    local compilations = compiler.compflags(".cpp", { target = project.target(ownername) })
    if target:toolchain("msvc") or target:toolchain("clang-cl") then
        table.insert(compilations, "--driver-mode=cl")
    end
    table.join2(args, "--", compilations)

    local out, err = os.iorunv(find_program("xparse", { paths = { "$(projectdir)/tools" } }), args)
    if err and #err > 0 then
        print("┏━━━━━━━━━━━━━━━━━━[" .. ownername .. " meta log]━━━━━━━━━━━━━━━━━━━")
        printf(err)
        print("┗━━━━━━━━━━━━━━━━━━[" .. ownername .. " meta log]━━━━━━━━━━━━━━━━━━━")
    end

    return out
end
