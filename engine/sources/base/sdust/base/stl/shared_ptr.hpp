#ifndef __SDUST_BASE_STL_SHARED_PTR_HPP__
#define __SDUST_BASE_STL_SHARED_PTR_HPP__

#include <EASTL/shared_ptr.h>

namespace sdust {
namespace stl {

template <typename T>
using shared_ptr    = eastl::shared_ptr<T>;

template <typename T>
using weak_ptr      = eastl::weak_ptr<T>;

using eastl::make_shared;

} // namespace stl
} // namespace sdust

#endif // __SDUST_BASE_STL_SHARED_PTR_HPP__
