import("core.project.project")

function __get_autogendir()
    return path.join(os.projectdir(), get_config("buildir"), ".xcpp")
end

function setup(target)
    local owner = project.target(target:values("ownername"))
    local autogendir = path.join(__get_autogendir(), owner:get("group"), owner:values("rawname"))
    target:set("values", "autogendir", autogendir)
    os.mkdir(autogendir)
end

function clean(target)
    os.tryrm(target:values("autogendir"))

    -- if no files in autogendir, remove the directory
    local project_autogendir = __get_autogendir()
    if #os.files(path.join(project_autogendir, "**")) == 0 then
        os.tryrm(project_autogendir)
    end
end
