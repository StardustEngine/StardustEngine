#pragma once

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

} // namespace TestXcpp
