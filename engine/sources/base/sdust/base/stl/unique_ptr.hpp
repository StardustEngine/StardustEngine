#ifndef __SDUST_BASE_STL_UNIQUE_PTR_HPP__
#define __SDUST_BASE_STL_UNIQUE_PTR_HPP__

#include <EASTL/unique_ptr.h>

namespace sdust {
namespace stl {

template <typename T>
using unique_ptr = eastl::unique_ptr<T>;

using eastl::make_unique;

} // namespace stl
} // namespace sdust

#endif // __SDUST_BASE_STL_UNIQUE_PTR_HPP__
