target("test_xcpp_lib1")
    set_kind("static")
    add_rules("c++.codegen", { root = "test_lib1", tmpls = { "refl" } })
    add_files("**.cpp")
