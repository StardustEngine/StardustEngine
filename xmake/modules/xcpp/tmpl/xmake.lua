add_rules("mode.debug", "mode.release")
add_requires("mustache")

target("tmpl")
    add_rules("module.shared")
    add_packages("mustache")
    add_files("src/**.cpp")
