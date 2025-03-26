rule("sdust.test")
    on_config(function (target)
        target:set("default", false)
        target:set("kind", "binary")
        target:add("packages", "doctest")
        target:add("defines", "DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN")
        target:add("tests", "default", { runargs = { "-nv", "-ni" } })
    end)
