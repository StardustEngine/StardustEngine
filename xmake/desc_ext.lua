function target_component(owner, name)
    target(owner)
        add_deps(owner .. "." .. name)
    target_end()

    target(owner .. "." .. name)
        set_default(false)
        set_policy("build.fence", true)
        set_values("ownername", owner)
end
