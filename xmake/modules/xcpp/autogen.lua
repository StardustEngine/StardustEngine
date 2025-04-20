function __get_autogendir()
    return path.join(os.projectdir(), get_config("buildir"), ".xcpp")
end

function setup(target)
    local autogendir = path.join(__get_autogendir(), target:values("ownername"))
    target:set("values", "autogendir", autogendir)
    os.mkdir(autogendir)
end

function clean(target)
    os.tryrm(target:values("autogendir"))

    -- if autogendir is empty, then try to remove it.
    local project_autogendir = __get_autogendir()
    if #os.filedirs(path.join(project_autogendir, "*")) == 0 then
        os.tryrm(project_autogendir)
    end
end
