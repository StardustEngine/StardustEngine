rule("sdust.tmpl.test")

    add_deps("sdust.tmpl.base", { order = true })

    on_config(function (target)
        local gendir = path.join(target:values("autogendir"), "gen")
        os.mkdir(gendir)
        target:set("values", "gendir", gendir)

        target:add("includedirs", gendir, { public = true })
    end)

    on_build(function (target)
        import("core.base.json")
        import("xcpp.utils")
        import("xcpp.autogen")

        local autogendir = target:values("autogendir")

        local metadata_str = utils.parse(target)
        io.writefile(path.join(autogendir, "meta.json"), metadata_str)

        local prefixed_words = utils.naming.normalize(target:values("ownername"), { separator = "([%.])" })
        local name_without_prefix = prefixed_words[#prefixed_words]

        local normalized_words = utils.naming.normalize(name_without_prefix, { separator = "([%_])" })
        local processed_module_metadata = {
            module = { name = utils.naming.to_uppercamel(normalized_words) },
            database = { records = {}, functions = {}, enums = {} }
        }

        local module_metadata = json.decode(metadata_str)
        for _, file_metadata in ipairs(module_metadata) do
            table.join2(processed_module_metadata.database.records, file_metadata.database.records)
            table.join2(processed_module_metadata.database.functions, file_metadata.database.functions)
            table.join2(processed_module_metadata.database.enums, file_metadata.database.enums)
        end

        local target_gendir = path.join(target:values("gendir"), name_without_prefix)
        os.mkdir(target_gendir)

        local registrar_tmpl = path.join(os.scriptdir(), "registrar.hpp.mustache")
        utils.mstch.render_to_file(
            registrar_tmpl, processed_module_metadata,
            path.join(target_gendir, path.basename(registrar_tmpl))
        )
    end)
