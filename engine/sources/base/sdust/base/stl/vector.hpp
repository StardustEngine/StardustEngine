#ifndef __SDUST_BASE_STL_VECTOR_HPP__
#define __SDUST_BASE_STL_VECTOR_HPP__

#include <EASTL/vector.h>

namespace sdust {
namespace stl {

template <typename T>
using vector = eastl::vector<T>;

} // namespace stl
} // namespace sdust

#endif // __SDUST_BASE_STL_VECTOR_HPP__
