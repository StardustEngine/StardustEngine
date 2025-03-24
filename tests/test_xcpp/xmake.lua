target("test_xcpp")
    -- set_default(false)
    set_kind("static")
    add_rules("c++.codegen", {
        root = "test"
    })
    add_files("test/**.cpp")
