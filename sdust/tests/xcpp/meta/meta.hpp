#pragma once

#ifndef __META__
    #define XCPP_MARK()
    #define XCPP_ATTR(...)
#else
    #define XCPP_MARK() [[clang::annotate("__reflect__")]]
    #define XCPP_ATTR(...) [[clang::annotate(#__VA_ARGS__)]]
#endif // !__META__
