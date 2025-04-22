rule("sdust.scoped")
    on_config(function (target)
        local scope = target:values("scope")
        local rawname = target:values("rawname")
        local group = scope:gsub(".", "/")

        target:set("rawname", rawname)
        target:set("group", group)

        target:set("targetdir", path.join(target:targetdir(), scope))
        target:set("basename", rawname)
    end)
