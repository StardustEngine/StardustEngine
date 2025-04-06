#include <doctest.h>

#include <test_xcpp_lib1/all_refl.hpp>
#include <test_xcpp_lib2/all_refl.hpp>

TEST_CASE("test the codegen function")
{
    std::unordered_map<std::string, unsigned> metadata;

    TestXcpp::MetaRegistrar::registerModule_TestXcppLib1(metadata);
    TestXcpp::MetaRegistrar::registerModule_TestXcppLib2(metadata);

    CHECK(metadata.find("Vector3") != metadata.end());
    CHECK(metadata.find("TestEnum") != metadata.end());
    CHECK(metadata.find("globalTestFunction1") != metadata.end());
    CHECK(metadata.find("globalTestFunction2") != metadata.end());
}
