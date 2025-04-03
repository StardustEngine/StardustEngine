function render(tmpl_filename, data)
    assert(os.isfile(tmpl_filename), "template doesn't exist")
    return import("__internal.shared_mstch", { anonymous = true }).render(io.readfile(tmpl_filename), data)
end

function render_to_file(tmpl_filename, data, output_filename)
    os.mkdir(path.directory(output_filename))
    io.writefile(output_filename, render(tmpl_filename, data))
end
