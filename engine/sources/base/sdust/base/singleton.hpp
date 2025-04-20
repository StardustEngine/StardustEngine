#ifndef __SDUST_BASE_SINGLETON_HPP__
#define __SDUST_BASE_SINGLETON_HPP__

namespace sdust {

template <typename T>
class Singleton {
public:
    Singleton(const Singleton&)             = delete;
    Singleton& operator=(const Singleton&)  = delete;
    Singleton(Singleton&&)                  = delete;
    Singleton& operator=(Singleton&&)       = delete;

    static T& Instance()
    {
        static T instance;
        return instance;
    }

protected:
    Singleton() = default;
    virtual ~Singleton() = default;
};

} // namespace sdust

#endif // __SDUST_BASE_SINGLETON_HPP__
