add_requires("eabase 2.09.05")
add_requires("eastl 3.21.12")
add_requires("rtm 2.3.1")
add_requires("mimalloc 2.1.7")

sdust_shared_module("core")
    add_packages("eastl")
    add_packages("rtm")
    add_packages("mimalloc")
