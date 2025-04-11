#pragma once

#ifndef __META__
    #define XATTR(...)
    #define XMARK(...)
    #define XSTRUCT(...) struct
    #define XCLASS(...) class
    #define XENUM(...) enum
    #define XENUM_CLASS(...) enum class
#else
    #define XATTR(...) [[clang::annotate(#__VA_ARGS__)]]
    #define XMARK(...) [[clang::annotate("__reflect__")]]
    #define XSTRUCT(...) struct [[clang::annotate("__reflect__")]]
    #define XCLASS(...) class [[clang::annotate("__reflect__")]]
    #define XENUM(...) enum [[clang::annotate("__reflect__")]]
    #define XENUM_CLASS(...) enum class [[clang::annotate("__reflect__")]]
#endif // !__META__
