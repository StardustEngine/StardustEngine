target("test_xcpp_lib2")
    set_kind("static")
    add_rules("c++.codegen", { root = "test_lib2" })
    add_files("**.cpp")
