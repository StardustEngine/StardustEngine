#include <sdust/base/stl/vector.hpp>
#include <sdust/module/module_manager.h>

namespace sdust {

namespace {

    stl::vector<IModule*> internalTopologicalSortModules(const stl::hash_map<stl::string, IModule*>& modules_map)
    {
        stl::vector<IModule*> sorted_modules;

        return sorted_modules;
    }

} // namespace

int ModuleManager::run(int argc, char** argv)
{
    return 0;
}

} // namespace sdust
