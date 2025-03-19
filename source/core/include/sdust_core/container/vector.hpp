#ifndef __SDUST_CORE_CONTAINER_VECTOR_HPP__
#define __SDUST_CORE_CONTAINER_VECTOR_HPP__

#include <EASTL/vector.h>

namespace stardust {

template <typename T>
using Vector = eastl::vector<T>;

} // namespace stardust

#endif // __SDUST_CORE_CONTAINER_VECTOR_HPP__
