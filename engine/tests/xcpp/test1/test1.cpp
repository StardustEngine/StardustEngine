#include "test1.h"

#include <iostream>

namespace TestXcpp {

const Vector3 Vector3::Zero = Vector3 { 0.0, 0.0, 0.0 };
const Vector3 Vector3::One = Vector3 { 1.0, 1.0, 1.0 };

void globalTestFunction1()
{
    std::cout << "Hello, Test1!\n";
}

} // namespace TestXcpp