add_requires("eastl")
add_requires("mimalloc")

target("sdust.module.base")
    set_kind("static")
    add_includedirs(".", { public = true })
    add_files("sdust/base/**.cpp")
    add_packages("eastl", { public = true })
    add_packages("mimalloc", { public = true })
