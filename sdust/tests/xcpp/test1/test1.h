#pragma once

#include <meta.hpp>
#include <string>

namespace TestXcpp {

struct
XCPP_MARK()
Vector3 {

    float x = 0.0;
    float y = 0.0;
    float z = 0.0;

    static const Vector3 Zero;
    static const Vector3 One;
};

XCPP_MARK()
void globalTestFunction1(const std::string& str, int num);

} // namespace TestXcpp
