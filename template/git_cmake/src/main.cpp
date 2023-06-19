#include <iostream>

int test() { std::cout << "test" << std::endl; }

int main() {
#ifndef NDEBUG
  std::cout << "This is Debug Mode" << std::endl;
#endif
  std::cout << "Hello World" << std::endl;
  return 0;
}
