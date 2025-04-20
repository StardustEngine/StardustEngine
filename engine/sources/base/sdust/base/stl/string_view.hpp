#ifndef __SDUST_BASE_STL_STRING_VIEW_HPP__
#define __SDUST_BASE_STL_STRING_VIEW_HPP__

#include <EASTL/string.h>

namespace sdust {
namespace stl {

using string_view       = eastl::string_view;
using wstring_view      = eastl::wstring_view;

using u8string_view     = eastl::u8string_view;
using u16string_view    = eastl::u16string_view;
using u32string_view    = eastl::u32string_view;

} // namespace stl
} // namespace sdust

#endif // __SDUST_BASE_STL_STRING_VIEW_HPP__
