local sdust_extension = {
    headerfile = { ".h", ".hpp" },
    sourcefile = { ".c", ".cc", ".cpp" }
}

local sdust_language = {
    c_ver = "c11",
    cxx_ver = "cxx17"
}

local sdust_module_dirs = {
    include = "include",
    src = "src",
    meta = "meta"
}

function _sdust_setup_dirs(include_dir, src_dir, meta_dir)
    if include_dir then
        add_includedirs(include_dir)
        for _, extension in ipairs(sdust_extension.headerfile) do
            local header_filepath = path.join(include_dir, "**" .. extension)
            for _, file in ipairs(os.files(header_filepath)) do
                add_headerfiles(file)
            end
        end
    end
    if src_dir then
        for _, extension in ipairs(sdust_extension.sourcefile) do
            local source_filepath = path.join(src_dir, "**" .. extension)
            for _, file in ipairs(os.files(source_filepath)) do
                add_files(file)
            end
        end
    end
end

function _sdust_setup_defaultdirs()
    _sdust_setup_dirs(
        sdust_module_dirs.include,
        sdust_module_dirs.src,
        sdust_module_dirs.meta
    )
end

function sdust_shared_module(name, opt)
    target(name)
        set_kind("static")
        set_languages(sdust_language.c_ver, sdust_language.cxx_ver)

        local opt = opt or {}
        if not opt.customizable then
            _sdust_setup_defaultdirs()
        end
end

function sdust_executable_module(name, opt)
    target(name)
        set_kind("binary")
        set_languages(sdust_language.c_ver, sdust_language.cxx_ver)

        local opt = opt or {}
        if not opt.customizable then
            _sdust_setup_defaultdirs()
        end
end
