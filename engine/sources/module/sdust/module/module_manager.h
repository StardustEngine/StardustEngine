#ifndef __SDUST_MODULE_MODULE_MANAGER_H__
#define __SDUST_MODULE_MODULE_MANAGER_H__

#include <sdust/base/singleton.hpp>
#include <sdust/base/stl/hash_map.hpp>
#include <sdust/base/stl/string.hpp>
#include <sdust/module/module.hpp>

namespace sdust {

class ModuleManager : public Singleton<ModuleManager> {
public:
    void    loadAll();
    void    unloadAll();
    int     run(int argc, char** argv);

private:
    stl::string                             m_entry;
    stl::hash_map<stl::string, IModule*>    m_modules;
};

} // namespace sdust

#endif // __SDUST_MODULE_MODULE_MANAGER_H__
