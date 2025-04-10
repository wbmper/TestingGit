#include <iostream>
#include "module1/add.h"
#include "module2/sub.h"

int main() {
    std::cout << "2 + 3 = " << add(2, 3) << std::endl;
    std::cout << "5 - 2 = " << sub(5, 2) << std::endl;
    return 0;
}
