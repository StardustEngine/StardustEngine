target("test_autogen_meta")
    set_default(false)
    set_kind("headeronly")
    add_includedirs("meta", { public = true })
    add_headerfiles("meta/**.hpp")

target("test_autogen_lib1")
    set_default(false)
    set_kind("static")
    add_includedirs("test1", { public = true })
    add_files("test1/**.cpp")
    add_deps("test_autogen_meta")

target_component_autogen("test_autogen_lib1")
    add_headerfiles("test1/**.h")
    add_rules("sdust.tmpl.test")

target("test_autogen_lib2")
    set_default(false)
    set_kind("static")
    add_includedirs("test2", { public = true })
    add_files("test2/**.cpp")
    add_deps("test_autogen_meta")

target_component_autogen("test_autogen_lib2", "autogen")
    add_headerfiles("test2/**.h")
    add_rules("sdust.tmpl.test")

target("test_autogen")
    add_rules("sdust.test")
    add_deps("test_autogen_lib1", "test_autogen_lib2")
    add_files("main.cpp")

-- target_component_autogen("test_autogen")
--     add_values("tmpls", "sdust.tmpl.registrar")
--     on_config(function (target)
--         import("core.project.project")
--         import("xcpp.utils")

--         local owner = project.target(target:values("ownername"))
--         local all_targets = utils.collect_targets(owner, function (_target)
--             return _target:values("component") == "autogen" and target ~= _target
--         end)

--         for _, _target in ipairs(all_targets) do
--             target:add("deps", _target:name())
--         end
--     end)
