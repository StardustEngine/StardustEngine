set_project("stardust")

-- global config
set_warnings("all")
set_languages(get_config("cxx_version"), get_config("c_version"))
add_rules("mode.debug", "mode.release")
add_values("c++.headerkinds", ".h", ".hpp")

-- setup xmake extensions
add_moduledirs("xmake/modules")
add_repositories("sdust-repo xmake/repos")
includes("xmake/options.lua")
includes("xmake/rules.lua")
add_values("xcpp.tmpldirs", "$(projectdir)/engine/templates")

-- all targets
includes("engine/xmake.lua")
