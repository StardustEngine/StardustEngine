set_project("Stardust")
add_rules("mode.debug", "mode.release")

target("project")
    set_kind("binary")
    add_files("src/*.cpp")