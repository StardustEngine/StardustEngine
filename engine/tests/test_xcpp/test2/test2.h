#pragma once

namespace TestXcpp {

enum class
[[clang::annotate("__reflect__")]]
TestEnum {
    kConstant1,
    kConstant2,
    kConstant3
};

} // namespace TestXcpp