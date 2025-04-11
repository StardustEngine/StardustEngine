task("xcpp.tmpl.test")
    on_run(function (target)
        import("core.base.json")
        import("xcpp.mstch")
        import("xcpp.utils")

        local metadir = target:values("metadir")

        local target_generatedir = path.join(target:values("generatedir"), target:values("ownername"))
        os.mkdir(target_generatedir)

        local module_metadata = {
            module_name = utils.convert_to_camelcase(target:values("ownername"), "_-"),
            generated_files = {}
        }

        local partial_tmpl_name = path.join(os.scriptdir(), "refl.hpp.mustache")
        for _, metafile in ipairs(os.files(path.join(metadir, "**"))) do

            local partial_metadata = json.loadfile(metafile)

            local camelcase_filename = utils.convert_to_camelcase(partial_metadata.path, "/.")
            partial_metadata["sourcefile_name"] = camelcase_filename

            local output_filepath
            local output_relative_path = path.relative(path.directory(metafile), metadir)
            local output_filename = path.basename(metafile) .. "-" .. path.basename(partial_tmpl_name)
            if output_relative_path == "." then
                output_filepath = path.join("partials", output_filename)
            else
                output_filepath = path.join("partials", output_relative_path, output_filename)
            end

            mstch.render_to_file(
                partial_tmpl_name, partial_metadata,
                path.join(target_generatedir, output_filepath)
            )

            table.insert(module_metadata.generated_files, {
                file_name = camelcase_filename,
                file_path = output_filepath
            })
        end

        local all_tmpl_name = path.join(os.scriptdir(), "all_refl.hpp.mustache")
        mstch.render_to_file(
            all_tmpl_name, module_metadata,
            path.join(target_generatedir, path.basename(all_tmpl_name))
        )

        target:add("includedirs", target:values("generatedir"), { public = true })
    end)
