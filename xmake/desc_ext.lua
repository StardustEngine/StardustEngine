function target_scoped(name, scope)
    target(scope .. "." .. name)
        set_group(scope)
        set_values("rawname", name)
end

function target_component(owner, name)
    local component_name = owner .. "." .. name
    target(owner)
        add_deps(component_name)
        add_values("components", component_name)
    target_end()

    target(component_name)
        set_default(false)
        set_policy("build.fence", true)
        set_values("ownername", owner)
        set_values("component", name)
end

function target_component_autogen(owner)
    target_component(owner, "autogen")
        set_kind("headeronly")
end
