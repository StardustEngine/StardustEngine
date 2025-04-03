
target("sdust.global")
    set_kind("phony")
    set_policy("build.fence", true)

    before_build(function (target)
        -- build tools bofore other targets
        import("xcpp.__internal.shared_mstch", { always_build = true, anonymous = true })
    end)
target_end()
