#ifndef words
#define words

#include <EASTL/optional.h>

namespace sdust {
namespace stl {

template <typename T>
using optional = eastl::optional<T>;

using eastl::nullopt;
using eastl::nullopt_t;

using eastl::make_optional;

} // namespace stl
} // namespace sdust

#endif // words
