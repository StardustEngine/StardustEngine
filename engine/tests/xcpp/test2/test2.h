#pragma once

#include <cstdint>

namespace TestXcpp {

enum class
[[clang::annotate("__reflect__")]]
TestEnum : std::uint8_t {
    kConstant1,
    kConstant2,
    kConstant3
};

[[clang::annotate("__reflect__")]]
void globalTestFunction2();

} // namespace TestXcpp