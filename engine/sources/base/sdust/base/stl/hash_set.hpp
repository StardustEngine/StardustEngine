#ifndef __SDUST_BASE_STL_HASH_SET_HPP__
#define __SDUST_BASE_STL_HASH_SET_HPP__

#include <EASTL/hash_set.h>
#include <sdust/base/stl/functional.hpp>


namespace sdust {
namespace stl {

template <typename Key, typename Hash = hash<Key>, typename Equal = equal_to<Key>>
using hash_set      = eastl::hash_set<Key, Hash, Equal>;

template <typename Key, typename Hash = hash<Key>, typename Equal = equal_to<Key>>
using hash_multiset = eastl::hash_multiset<Key, Hash, Equal>;

} // namespace stl
} // namespace sdust

#endif // __SDUST_BASE_STL_HASH_SET_HPP__