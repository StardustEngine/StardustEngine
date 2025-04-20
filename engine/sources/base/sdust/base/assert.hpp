#ifndef __SDUST_BASE_ASSERT_HPP__
#define __SDUST_BASE_ASSERT_HPP__

#include <cassert>

#define SDUST_ASSERT(expression) \
    do {                         \
        assert((expression));    \
    } while (0)

#endif // __SDUST_BASE_ASSERT_HPP__
