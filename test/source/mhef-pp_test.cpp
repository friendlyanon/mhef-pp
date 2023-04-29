#include <string>

#include "mhef-pp/mhef-pp.hpp"

#include <catch2/catch_test_macros.hpp>

TEST_CASE("mhef can add", "[mhef]")
{
  REQUIRE(mhef::add(1, 1) == 2);
}
