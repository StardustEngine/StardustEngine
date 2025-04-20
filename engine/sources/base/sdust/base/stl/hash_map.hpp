#ifndef __SDUST_BASE_STL_HASH_MAP_HPP__
#define __SDUST_BASE_STL_HASH_MAP_HPP__

#include <EASTL/hash_map.h>
#include <sdust/base/stl/functional.hpp>

namespace sdust {
namespace stl {

template <typename Key, typename Value, typename Hash = hash<Key>, typename Equal = equal_to<Key>>
using hash_map      = eastl::hash_map<Key, Value, Hash, Equal>;

template <typename Key, typename Value, typename Hash = hash<Key>, typename Equal = equal_to<Key>>
using hash_multimap = eastl::hash_multimap<Key, Value, Hash, Equal>;

} // namespace stl
} // namespace sdust

#endif  // __SDUST_BASE_STL_HASH_MAP_HPP__