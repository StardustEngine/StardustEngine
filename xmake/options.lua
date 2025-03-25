option("c_ver")
    set_default("c11")
    set_values("c11")
    set_description("The c standard version.")
option_end()

option("cxx_ver")
    set_default("cxx17")
    set_values("cxx17")
    set_description("The c++ standard version.")
option_end()

option("xcpp_templates")
    set_default("$(projectdir)/engine/templates")
    set_description("The xcpp templates directory.")
    set_showmenu(false)
