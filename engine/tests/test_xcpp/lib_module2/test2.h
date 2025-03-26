#pragma once

namespace Test {

enum class
[[clang::annotate("__reflect__")]]
TestEnum {
    kConstant1,
    kConstant2,
    kConstant3
};

[[clang::annotate("__reflect__")]]
void globalTestFunction2();

} // namespace Test