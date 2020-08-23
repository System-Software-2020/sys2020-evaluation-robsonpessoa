#include <unistd.h>

ssize_t write (int fd, const void *s, size_t n);

int main ()
{
    write(1, "Hello\n", 6);
    return 0;
}