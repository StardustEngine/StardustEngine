import("core.language.language")

function setup(_target, conf)
    local full_rootdir = path.join(_target:scriptdir(), conf.root)
    if not os.isdir(full_rootdir) then
        print("[warning] rootdir not found: " .. full_rootdir)
        return
    end
    _target:set("values", "rootdir", full_rootdir)

    local cx_sourcekinds = table.join(language.sourcekinds()["cc"], language.sourcekinds()["cxx"])

    -- rootdir is also includedirs
    _target:add("includedirs", full_rootdir, { public = true })
    for _, header_path in ipairs(os.files(path.join(full_rootdir, "**"))) do
        local is_sourcefile = false
        for _, sourcekind in ipairs(cx_sourcekinds) do
            if path.extension(header_path) == sourcekind then
                is_sourcefile = true
                break
            end
        end
        if not is_sourcefile then
            _target:add("headerfiles", header_path)
        end
    end

    _target:set("values", "gendir", path.join(os.projectdir(), _target:autogendir()))
end
