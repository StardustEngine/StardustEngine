#pragma once

#include <meta.hpp>
#include <cstdint>

namespace TestXcpp {

enum class
XCPP_MARK()
TestEnum : std::uint8_t {
    kConstant1,
    kConstant2,
    kConstant3
};

XCPP_MARK()
void globalTestFunction2();

} // namespace TestXcpp
