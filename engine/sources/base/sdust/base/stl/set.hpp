#ifndef __SDUST_BASE_STL_SET_HPP__
#define __SDUST_BASE_STL_SET_HPP__

#include "sdust_core/stl/functional.hpp"

#include <EASTL/set.h>

namespace sdust {
namespace stl {

template <typename Key, typename Compare = less<Key>>
using set       = eastl::set<Key, Compare>;

template <typename Key, typename Compare = less<Key>>
using multiset  = eastl::multiset<Key, Compare>;

} // namespace stl
} // namespace sdust

#endif // __SDUST_BASE_STL_SET_HPP__