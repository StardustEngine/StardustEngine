#ifndef __SDUST_CORE_CONTAINER_FIXED_STRING_HPP__
#define __SDUST_CORE_CONTAINER_FIXED_STRING_HPP__

#include <EASTL/fixed_string.h>

namespace stardust {

template <size_t Capacity>
using FixedString = eastl::fixed_string<char, Capacity>;

template <size_t Capacity>
using FixedWString = eastl::fixed_string<wchar_t, Capacity>;

template <size_t Capacity>
using FixedU8String = eastl::fixed_string<char8_t, Capacity>;

template <size_t Capacity>
using FixedU16String = eastl::fixed_string<char16_t, Capacity>;

template <size_t Capacity>
using FixedU32String = eastl::fixed_string<char32_t, Capacity>;

} // namespace stardust

#endif // !__SDUST_CORE_CONTAINER_FIXED_STRING_HPP__
