rule("sdust.tmpl.test")
    on_config(function (target)
        import("xcpp.autogen")

        autogen.setup(target)

        local gendir = path.join(target:values("autogendir"), "gen")
        os.mkdir(gendir)
        target:set("values", "gendir", gendir)

        target:add("includedirs", gendir, { public = true })
    end)

    before_build(function (target)
        import("core.base.json")
        import("xcpp.utils")
        import("xcpp.autogen")

        local autogendir = target:values("autogendir")

        local metadata_str = utils.parse(target)
        io.writefile(path.join(autogendir, "meta.json"), metadata_str)

        local module_metadata = json.decode(metadata_str)
        local processed_module_metadata = {
            module = { name = utils.naming.to_uppercamel(target:values("ownername")) },
            database = { records = {}, functions = {}, enums = {} }
        }

        for _, file_metadata in ipairs(module_metadata) do
            table.join2(processed_module_metadata.database.records, file_metadata.database.records)
            table.join2(processed_module_metadata.database.functions, file_metadata.database.functions)
            table.join2(processed_module_metadata.database.enums, file_metadata.database.enums)
        end

        local target_gendir = path.join(target:values("gendir"), target:values("ownername"))
        os.mkdir(target_gendir)

        local registrar_tmpl = path.join(os.scriptdir(), "registrar.hpp.mustache")
        utils.mstch.render_to_file(
            registrar_tmpl, processed_module_metadata,
            path.join(target_gendir, path.basename(registrar_tmpl))
        )
    end)

    on_clean(function (target)
        import("xcpp.autogen").clean(target)
    end)
