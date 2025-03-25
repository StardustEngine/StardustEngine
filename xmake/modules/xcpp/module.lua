import("core.base.json")
import("core.language.language")
import("core.tool.compiler")
import("lib.detect.find_program")

function _check_sourcekind(filepath, lang_type)
    local sourcekinds = language.sourcekinds()[lang_type]
    for _, sourcekind in ipairs(sourcekinds) do
        if path.extension(filepath) == sourcekind then
            return true
        end
    end
    return false
end

function _recreate_dir(dir)
    os.tryrm(dir)
    os.mkdir(dir)
end

-- NOTICE:
-- this function will mainly process the target's rootdir.
-- when the rootdir isn't exists, it will raise an error.
function setup(target)
    local full_rootdir = path.join(target:scriptdir(), target:extraconf("rules", "c++.codegen", "root"))
    if not os.isdir(full_rootdir) then
        raise("rootdir \"%s\" not exists.", full_rootdir)
    end
    target:set("values", "rootdir", full_rootdir)

    -- rootdir should be added to includedirs,
    -- then the directory containing the generated files will be added to the include path in "codegen_process"
    target:add("includedirs", full_rootdir, { public = true })
    for _, header_path in ipairs(os.files(path.join(full_rootdir, "**"))) do
        if (not _check_sourcekind(header_path, "cc")) and (not _check_sourcekind(header_path, "cxx")) then
            target:add("headerfiles", header_path)
        end
    end
end

function codegen_process(target)
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
    for _, tmpl in ipairs(target:extraconf("rules", "c++.codegen", "tmpls")) do
        for _, metafile in ipairs(os.files(path.join(meta_dir, "**"))) do
            local raw_metadata = json.loadfile(metafile)
            local data, use_tmpls = {}, {}
            try {
                function ()
                    data, use_tmpls = import(tmpl, { rootdir = get_config("xcpp_templates") })(raw_metadata)
                end,
                catch {
                    function (errors)
                        cprint("${bright yellow}warning:${clear} failed to use template \"%s\", %s", tmpl, errors)
                    end
                }
            }

            for _, use_tmpl in ipairs(use_tmpls) do
                local use_tmpl_path = path.join(get_config("xcpp_templates"), use_tmpl)
                if not os.isfile(use_tmpl_path) then
                    cprint("${bright yellow}warning:${clear} template \"%s\" not exists.", use_tmpl)
                else
                    local tmpl_content = io.readfile(use_tmpl_path)
                    local rendered_content = import("xcpp.tmpl").render(tmpl_content, data)

                    local output_filename = path.basename(metafile) .. "." .. path.basename(use_tmpl)
                    local output_path = path.translate(path.join(generate_dir, path.relative(path.directory(metafile), meta_dir)))

                    os.mkdir(output_path)
                    io.writefile(path.join(output_path, output_filename), rendered_content)

                    cprint("${bright green}generated:${clear} %s", path.join(output_path, output_filename))
                end
            end
        end
    end
end
