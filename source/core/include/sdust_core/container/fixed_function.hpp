#ifndef __SDUST_CORE_CONTAINER_FIXED_FUNCTION_HPP__
#define __SDUST_CORE_CONTAINER_FIXED_FUNCTION_HPP__

#include <EASTL/fixed_function.h>

namespace stardust {

template <size_t Size, typename R, typename... Args>
using FixedFunction = eastl::fixed_function<Size, R(Args...)>;

} // namespace stardust

#endif // !__SDUST_CORE_CONTAINER_FIXED_FUNCTION_HPP__
