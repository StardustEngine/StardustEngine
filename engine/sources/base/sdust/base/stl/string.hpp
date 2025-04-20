#ifndef __SDUST_BASE_STL_STRING_HPP__
#define __SDUST_BASE_STL_STRING_HPP__

#include <EASTL/string.h>

namespace sdust {
namespace stl {

using string    = eastl::string;
using wstring   = eastl::wstring;

using u8string  = eastl::u8string;
using u16string = eastl::u16string;
using u32string = eastl::u32string;

} // namespace stl
} // namespace sdust

#endif // __SDUST_BASE_STL_STRING_HPP__
