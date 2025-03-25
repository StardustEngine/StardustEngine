rule("c++.codegen")
    on_config(function (target)
        import("xcpp.module").setup(target)
    end)

    before_build(function (target)
        import("xcpp.module").codegen_process(target)
    end)
