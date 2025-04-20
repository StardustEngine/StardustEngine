#include <doctest.h>

#include <test_autogen_lib1/registrar.hpp>
#include <test_autogen_lib2/registrar.hpp>

TEST_CASE("test the codegen function")
{
    std::unordered_map<std::string, unsigned> metadata;

    TestXcpp::MetaRegistrar::registerModule_TestAutogenLib1(metadata);
    TestXcpp::MetaRegistrar::registerModule_TestAutogenLib2(metadata);

    CHECK(metadata.find("Vector3") != metadata.end());
    CHECK(metadata.find("TestEnum") != metadata.end());
    CHECK(metadata.find("globalTestFunction1") != metadata.end());
    CHECK(metadata.find("globalTestFunction2") != metadata.end());
}
