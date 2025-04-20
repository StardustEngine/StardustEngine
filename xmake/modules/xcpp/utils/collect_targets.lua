import("core.project.project")

function __collect_targets(_target, filter, result, visited)
    if not _target or visited[_target:name()] then
        return
    end
    for _, dep in ipairs(_target:get("deps")) do
        __collect_targets(project.target(dep), filter, result, visited)
    end

    if filter and not filter(_target) then
        return
    end
    table.insert(result, _target)
end

function main(_target, filter)
    local result, visited = {}, {}
    __collect_targets(_target, filter, result, visited)
    return result
end
