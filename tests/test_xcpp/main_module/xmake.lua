target("test_xcpp_main")
    set_kind("binary")
    add_deps("test_xcpp_lib1", "test_xcpp_lib2")
    add_files("**.cpp")
