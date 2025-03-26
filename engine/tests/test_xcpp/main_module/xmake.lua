target("test_xcpp")
    add_rules("sdust.test")
    add_deps("test_xcpp_lib1", "test_xcpp_lib2")
    add_files("**.cpp")
