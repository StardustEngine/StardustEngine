import("core.base.task")
import("core.language.language")
import("core.tool.compiler")
import("core.project.project")
import("lib.detect.find_program")
import("xcpp.utils", { alias = "xcpp_utils" })

-- NOTICE:
-- this function will mainly process the target's rootdir.
-- when the rootdir isn't exists, it will raise an error.
function autogen_setup(target)
    local full_rootdir = path.join(target:scriptdir(), target:values("rootdir"))
    if not os.isdir(full_rootdir) then
        raise("rootdir \"%s\" not exists.", full_rootdir)
    end
    target:set("values", "rootdir", full_rootdir)

    local autogendir = path.join(xcpp_utils.autogendir(), target:values("ownername"))
    target:set("values", "autogendir", autogendir)
    os.mkdir(autogendir)

    local metadir = path.join(autogendir, "meta")
    target:set("values", "metadir", metadir)
    os.mkdir(metadir)

    local generatedir = path.join(autogendir, "generated")
    target:set("values", "generatedir", generatedir)
    os.mkdir(generatedir)
end

function autogen_process(target)

    print("generating meta for \"%s\".", target:values("ownername"))

    -- collect all header files and generate "collection.hpp"
    local collection = "#pragma once\n"
    for _, headerfile in ipairs(target:sourcebatches()["xcpp.autogen"].sourcefiles) do
        local relative_path = path.relative(headerfile, target:values("autogendir"))
        collection = collection .. "#include \"" .. relative_path .. "\"\n"
    end
    local collection_path = path.join(target:values("autogendir"), "collection.hpp")
    io.writefile(collection_path, collection)

    cprint("${bright green}generated meta:${clear} %s", collection_path)

    -- input xparse's arguments and run it
    local args = {
        collection_path,
        "--root=" .. target:values("rootdir"),
        "--output=" .. target:values("metadir"),
    }

    -- input owner's compile flags
    local compilations = compiler.compflags(".cpp", { target = project.target(target:values("ownername")) })
    if target:toolchain("msvc") or target:toolchain("clang-cl") then
        table.insert(compilations, "--driver-mode=cl")
    end
    table.join2(args, "--", compilations)

    local out, err = os.iorunv(find_program("xparse", { paths = { "$(projectdir)/tools" } }), args)
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

    -- render the code (currently we use mustache)
    local tmpls = target:values("tmpls")
    if not tmpls or #tmpls == 0 then
        cprint("${bright yellow}warning:${clear} no templates specified for %s, processing ended.", target:name())
        return
    end

    for _, tmpl in ipairs(tmpls) do
        print("use template \"%s\" to process autogen.", tmpl)

        try {
            function ()
                task.run(tmpl, {}, target)
                print("autogen task \"%s\" has been finished.", tmpl)
            end,
            catch {
                function (errors)
                    cprint("${bright yellow}warning:${clear} Running autogen task \"%s\" failed, reason:\n\t%s", tmpl, errors)
                end
            }
        }
    end
    cprint("autogen process for \"%s\" finished.", target:name())
end

function autogen_clean(target)
    os.tryrm(target:values("autogendir"))

    -- if autogendir is empty, then try to remove it.
    if #os.filedirs(path.join(xcpp_utils.autogendir(), "*")) == 0 then
        os.tryrm(xcpp_utils.autogendir())
    end
end
