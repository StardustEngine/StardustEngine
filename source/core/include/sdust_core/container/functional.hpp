#ifndef __SDUST_CORE_CONTAINER_FUNCTIONAL_HPP__
#define __SDUST_CORE_CONTAINER_FUNCTIONAL_HPP__

#include <EASTL/functional.h>

namespace stardust {

template <typename R, typename... Args>
using Function = eastl::function<R(Args...)>;

} // namespace stardust

#endif // __SDUST_CORE_CONTAINER_FUNCTIONAL_HPP__
