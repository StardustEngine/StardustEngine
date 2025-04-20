#ifndef __SDUST_MODULE_MODULE_HPP__
#define __SDUST_MODULE_MODULE_HPP__

#include <sdust/base/stl/string.hpp>
#include <sdust/base/stl/vector.hpp>

namespace sdust {

class IModule {
public:
    IModule()                           = default;
    virtual ~IModule()                  = default;
    IModule(const IModule&)             = delete;
    IModule& operator=(const IModule&)  = delete;
    IModule(IModule&&)                  = delete;
    IModule& operator=(IModule&&)       = delete;

    virtual void    load() = 0;
    virtual void    unload() = 0;
    virtual int     exec(int /*argc*/, char** /*argv*/) { return 0; }

    stl::string                 getName() const { return m_name; }
    stl::vector<stl::string>&   getDependencies() { return m_dependencies; }

protected:
    stl::string                 m_name;
    stl::vector<stl::string>    m_dependencies;
};

} // namespace sdust

#endif // __SDUST_MODULE_MODULE_HPP__
