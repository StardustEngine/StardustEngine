rule("c++.codegen")
    on_config(function (target)
        import("xcpp.module").setup(target, target:extraconf("rules", "c++.codegen"))
    end)

    before_build(function (target)
        import("core.base.json")
        import("core.tool.compiler")
        import("lib.detect.find_program")

        local xparse_tool = find_program("xparse", { paths = { "$(projectdir)/tools" } })

        -- collect all header files and generate "collection.hpp"
        local collection = "#pragma once\n"
        for _, headerfile in ipairs(target:headerfiles()) do
            local relative_path = path.relative(headerfile, target:autogendir())
            collection = collection .. "#include \"" .. relative_path .. "\"\n"
        end
        local collection_path = path.join(target:autogendir(), "collection.hpp")
        io.writefile(collection_path, collection)

        -- collect xparse's arguments and run it
        local metadir = path.join(target:values("gendir"), "meta")

        local args = {
            collection_path,
            "--root=" .. target:values("rootdir"),
            "--output=" .. metadir,
        }

        local compilations = compiler.compflags(".cpp", { target = target })
        if target:toolchain("msvc") or target:toolchain("clang-cl") then
            table.insert(compilations, "--driver-mode=cl")
        end
        table.join2(args, "--", compilations)

        if not os.isdir(metadir) then
            os.mkdir(metadir)
        else
            os.tryrm(path.join(metadir, "*"))
        end
        local out, err = os.iorunv(xparse_tool, args)
        if out and #out > 0 then
            print("┏━━━━━━━━━━━━━━━━━━[" .. target:name() .. " meta out]━━━━━━━━━━━━━━━━━━━")
            printf(out)
            print("┗━━━━━━━━━━━━━━━━━━[" .. target:name() .. " meta out]━━━━━━━━━━━━━━━━━━━")
        end
        if err and #err > 0 then
            print("┏━━━━━━━━━━━━━━━━━━[" .. target:name() .. " meta err]━━━━━━━━━━━━━━━━━━━")
            printf(err)
            print("┗━━━━━━━━━━━━━━━━━━[" .. target:name() .. " meta err]━━━━━━━━━━━━━━━━━━━")
        end


    end)
