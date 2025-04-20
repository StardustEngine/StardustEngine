#ifndef __SDUST_BASE_STL_FUNCTIONAL_HPP__
#define __SDUST_BASE_STL_FUNCTIONAL_HPP__

#include <EASTL/functional.h>

namespace sdust {
namespace stl {

template <typename T>
using less          = eastl::less<T>;

template <typename T>
using greater       = eastl::greater<T>;

template <typename T>
using hash          = eastl::hash<T>;

template <typename T>
using equal_to      = eastl::equal_to<T>;

template <typename T>
using not_equal_to  = eastl::not_equal_to<T>;

template <typename T>
using less_equal    = eastl::less_equal<T>;

template <typename T>
using greater_equal = eastl::greater_equal<T>;

template <typename T>
using identity      = eastl::identity<T>;

template <typename T>
using negate        = eastl::negate<T>;

template <typename T>
using plus          = eastl::plus<T>;

template <typename T>
using minus         = eastl::minus<T>;

template <typename T>
using multiplies    = eastl::multiplies<T>;

template <typename T>
using divides       = eastl::divides<T>;

template <typename T>
using modulus       = eastl::modulus<T>;

template <typename R, typename... Args>
using function      = eastl::function<R(Args...)>;

} // namespace stl
} // namespace sdust

#endif // __SDUST_BASE_STL_FUNCTIONAL_HPP__