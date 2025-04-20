#ifndef __SDUST_BASE_STL_INTRUSIVE_PTR_HPP__
#define __SDUST_BASE_STL_INTRUSIVE_PTR_HPP__

#include <EASTL/intrusive_ptr.h>

namespace sdust {
namespace stl {

template <typename T>
using intrusive_ptr = eastl::intrusive_ptr<T>;

} // namespace stl
} // namespace sdust

#endif // __SDUST_BASE_STL_INTRUSIVE_PTR_HPP__
