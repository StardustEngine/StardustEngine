rule("sdust.tmpl.registrar")

    add_deps("sdust.tmpl.base", { order = true })

    on_config(function (target)
        import("core.project.project")
        import("xcpp.utils")

        local owner = project.target(target:values("ownername"))
        local all_targets = utils.collect_targets(owner, function (_target)
            return _target:values("component") == "autogen" and target ~= _target
        end)

        for _, _target in ipairs(all_targets) do
            target:add("deps", _target:name())
        end
    end)

    on_build(function (target)

    end)
