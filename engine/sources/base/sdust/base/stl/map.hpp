#ifndef __SDUST_BASE_STL_MAP_HPP__
#define __SDUST_BASE_STL_MAP_HPP__

#include "sdust_core/stl/functional.hpp"

#include <EASTL/map.h>

namespace sdust {
namespace stl {

template <typename Key, typename Value, typename Compare = less<Key>>
using map       = eastl::map<Key, Value, Compare>;

template <typename Key, typename Value, typename Compare = less<Key>>
using multimap  = eastl::multimap<Key, Value, Compare>;

} // namespace stl
} // namespace sdust

#endif // __SDUST_BASE_STL_MAP_HPP__
