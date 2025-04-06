#include "test1.h"

#include <iostream>

namespace TestXcpp {

const Vector3 Vector3::Zero = Vector3 { 0.0, 0.0, 0.0 };
const Vector3 Vector3::One = Vector3 { 1.0, 1.0, 1.0 };

void globalTestFunction1(const std::string& str, int num)
{
    std::cout << "Hello, Test1!\n";
    std::cout << "String: " << str << "\n";
    std::cout << "Number: " << num << "\n";
}

} // namespace TestXcpp