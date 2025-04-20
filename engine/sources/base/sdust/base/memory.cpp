#include <mimalloc-new-delete.h>

void* operator new[](size_t size, const char* /*pName*/, int /*flags*/, unsigned /*debugFlags*/, const char* /*file*/, int /*line*/)
{
    return mi_malloc(size);
}

void* operator new[](size_t size, size_t alignment, size_t /*alignmentOffset*/, const char* /*pName*/, int /*flags*/, unsigned /*debugFlags*/, const char* /*file*/, int /*line*/)
{
    return mi_malloc_aligned(size, alignment);
}

void operator delete[](void* ptr, const char* /*pName*/, int /*flags*/, unsigned /*debugFlags*/, const char* /*file*/, int /*line*/)
{
    mi_free(ptr);
}

void operator delete[](void* ptr, size_t /*alignment*/, size_t /*alignmentOffset*/, const char* /*pName*/, int /*flags*/, unsigned /*debugFlags*/, const char* /*file*/, int /*line*/)
{
    mi_free(ptr);
}
