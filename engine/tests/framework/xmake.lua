target("test_framework")
    set_kind("headeronly")
    add_includedirs("include", { public = true })
    add_headerfiles("include/*.h")
