set_project("StardustEngine")
set_xmakever("2.9.2")

set_languages("cxx17")
add_rules("mode.debug", "mode.release")
add_rules("plugin.compile_commands.autoupdate", { outputdir = ".vscode" })

add_moduledirs("xmake/modules")
add_repositories("sdust_repo xmake/repos", { rootdir = os.scriptdir() })

includes("xmake/rules.lua")
includes("xmake/options.lua")

-- include all modules
includes("source/**/xmake.lua")
