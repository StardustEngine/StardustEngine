#pragma once

#include <string>

namespace TestXcpp {

struct
[[clang::annotate("__reflect__")]]
Vector3 {

    float x = 0.0;
    float y = 0.0;
    float z = 0.0;

    static const Vector3 Zero;
    static const Vector3 One;
};

[[clang::annotate("__reflect__")]]
void globalTestFunction1(const std::string& str, int num);

} // namespace TestXcpp
