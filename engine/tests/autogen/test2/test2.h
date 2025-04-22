#pragma once

#include <meta.hpp>
#include <cstdint>

namespace TestXcpp {

XENUM_CLASS()
TestEnum : std::uint8_t {
    kConstant1,
    kConstant2,
    kConstant3
};

XMARK()
void globalTestFunction2();

} // namespace TestXcpp
