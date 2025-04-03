set_project("stardust")

-- description scope extensions
includes("xmake/desc_ext.lua")

-- global config
set_policy("build.ccache", false)
set_policy("build.warning", true)
set_policy("check.auto_ignore_flags", false)
set_warnings("all")
set_languages(get_config("cxx_version"), get_config("c_version"))
add_rules("mode.debug", "mode.release")

-- setup xmake extensions
add_moduledirs("xmake/modules")
add_repositories("sdust-repo xmake/repos")
includes("xmake/options.lua")
includes("xmake/rules.lua")

-- global target
includes("xmake/global.lua")

-- engine's targets
includes("engine/xmake.lua")
