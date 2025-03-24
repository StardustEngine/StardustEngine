set_project("stardust")

-- global config
set_warnings("all")
set_languages(get_config("cxx_version"), get_config("c_version"))
add_rules("mode.debug", "mode.release")

-- setup xmake extensions
add_moduledirs("xmake/modules")
-- add_plugindirs("xmake/plugins")
add_repositories("sdust-repo xmake/repos")
includes("xmake/rules.lua")
includes("xmake/options.lua")

-- all targets
includes("engine/xmake.lua")
includes("tests/xmake.lua")
