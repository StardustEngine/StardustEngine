add_rules("mode.debug", "mode.release")
add_requires("mustache")

target("shared_mstch")
    add_rules("module.shared")
    add_packages("mustache")
    add_files("src/main.cpp")
