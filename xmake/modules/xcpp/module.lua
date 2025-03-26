import("core.base.json")
import("core.language.language")
import("core.tool.compiler")
import("lib.detect.find_program")

function _recreate_dir(dir)
    os.tryrm(dir)
    os.mkdir(dir)
end

function _is_headerfile(target, filepath)
    for _, headerkind in ipairs(target:values("c++.headerkinds")) do
        if path.extension(filepath) == headerkind then
            return true
        end
    end
    return false
end

function _add_headerfiles(target, includedir)
    target:add("includedirs", includedir, { public = true })
    for _, headerfile_path in ipairs(os.files(path.join(includedir, "**"))) do
        if _is_headerfile(target, headerfile_path) then
            target:add("headerfiles", headerfile_path)
        end
    end
end

-- NOTICE:
-- this function will mainly process the target's rootdir.
-- when the rootdir isn't exists, it will raise an error.
function setup(target)
    local full_rootdir = path.join(target:scriptdir(), target:extraconf("rules", "sdust.codegen", "rootdir"))
    if not os.isdir(full_rootdir) then
        raise("rootdir \"%s\" not exists.", full_rootdir)
    end
    target:set("values", "rootdir", full_rootdir)

    -- rootdir should be added to includedirs,
    -- then the directory containing the generated files will be added to the include path in "codegen_process"
    _add_headerfiles(target, full_rootdir)
end

function codegen_process(target)

    print("processing codegen for \"%s\".", target:name())

    local autogendir = path.join(os.projectdir(), target:autogendir())

    local meta_dir = path.join(autogendir, "meta")
    _recreate_dir(meta_dir)
    local generate_dir = path.join(autogendir, "generated")
    _recreate_dir(generate_dir)

    -- collect all header files and generate "collection.hpp"
    local collection = "#pragma once\n"
    for _, headerfile in ipairs(target:headerfiles()) do
        local relative_path = path.relative(headerfile, autogendir)
        collection = collection .. "#include \"" .. relative_path .. "\"\n"
    end
    local collection_path = path.join(autogendir, "collection.hpp")
    io.writefile(collection_path, collection)

    cprint("${bright green}generated:${clear} %s", collection_path)

    -- collect xparse's arguments and run it
    local args = {
        collection_path,
        "--root=" .. target:values("rootdir"),
        "--output=" .. meta_dir,
    }

    local compilations = compiler.compflags(".cpp", { target = target })
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
    local tmpls = target:extraconf("rules", "sdust.codegen", "tmpls")
    if not tmpls or #tmpls == 0 then
        cprint("${bright yellow}warning:${clear} no templates specified for %s, processing ended.", target:name())
        return
    end

    for _, tmpl in ipairs(tmpls) do
        for _, metafile in ipairs(os.files(path.join(meta_dir, "**"))) do

            print("using template \"%s\" to generate code for \"%s\".", tmpl, path.filename(metafile))

            local raw_metadata = json.loadfile(metafile)
            local data, use_tmpls = {}, {}
            try {
                function ()
                    local tmpl_func
                    for _, tmpldir in ipairs(target:values("xcpp.tmpldirs")) do
                        tmpl_func = import(tmpl, { rootdir = tmpldir, try = true, anonymous = true })
                        if type(tmpl_func) == "function" then
                            break
                        end
                    end
                    if tmpl_func then
                        data, use_tmpls = tmpl_func(raw_metadata)
                    else
                        raise("can't find template named %s.", tmpl)
                    end
                end,
                catch {
                    function (errors)
                        cprint("${bright yellow}warning:${clear} failed to use template \"%s\", %s", tmpl, errors)
                    end
                }
            }

            for _, use_tmpl in ipairs(use_tmpls) do
                local use_tmpl_path
                for _, tmpldir in ipairs(target:values("xcpp.tmpldirs")) do
                    use_tmpl_path = path.join(tmpldir, use_tmpl)
                end
                if os.isfile(use_tmpl_path) then
                    local tmpl_content = io.readfile(use_tmpl_path)
                    local rendered_content = import("xcpp.tmpl").render(tmpl_content, data)

                    local output_filename = path.basename(metafile) .. "." .. path.basename(use_tmpl)
                    local output_dir_path = path.join(generate_dir, path.relative(path.directory(metafile), meta_dir))
                    os.mkdir(output_dir_path)

                    local output_file_path = path.join(output_dir_path, output_filename)
                    io.writefile(output_file_path, rendered_content)

                    cprint("${bright green}generated:${clear} %s", output_file_path)
                else
                    cprint("${bright yellow}warning:${clear} template \"%s\" not exists.", use_tmpl)
                end
            end
        end
    end

    _add_headerfiles(target, generate_dir)

    cprint("codegen process for \"%s\" finished.", target:name())
end
