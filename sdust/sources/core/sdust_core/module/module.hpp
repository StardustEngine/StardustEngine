#ifndef __SDUST_CORE_MODULE_MODULE_HPP__
#define __SDUST_CORE_MODULE_MODULE_HPP__

namespace sdust {

class IModule {
public:
    IModule()                           = default;
    virtual ~IModule()                  = default;
    IModule(const IModule&)             = delete;
    IModule& operator=(const IModule&)  = delete;
    IModule(IModule&&)                  = delete;
    IModule& operator=(IModule&&)       = delete;

    virtual void onLoad() = 0;
    virtual void onUnload() = 0;
};

class IStaticModule : public IModule {
};

// class IDynamicModule : public IModule {
// };

} // namespace sdust

#endif // __SDUST_CORE_MODULE_MODULE_HPP__
