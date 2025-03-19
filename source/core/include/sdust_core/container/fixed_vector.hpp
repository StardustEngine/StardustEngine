#ifndef __SDUST_CORE_CONTAINER_FIXED_VECTOR_HPP__
#define __SDUST_CORE_CONTAINER_FIXED_VECTOR_HPP__

#include <EASTL/fixed_vector.h>

namespace stardust {

template <typename T, size_t Capacity>
using FixedVector = eastl::fixed_vector<T, Capacity>;

} // namespace stardust

#endif // !__SDUST_CORE_CONTAINER_FIXED_VECTOR_HPP__
