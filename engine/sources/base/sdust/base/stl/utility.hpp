#ifndef __SDUST_BASE_STL_UTILITY_HPP__
#define __SDUST_BASE_STL_UTILITY_HPP__

#include <EASTL/utility.h>

namespace sdust {
namespace stl {

template <typename T1, typename T2>
using pair = eastl::pair<T1, T2>;

} // namespace stl
} // namespace sdust

#endif // !__SDUST_BASE_STL_UTILITY_HPP__
