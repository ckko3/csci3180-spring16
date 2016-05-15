#ifndef CANTEEN_H
#define CANTEEN_H

#include <string>
#include "Person.h"
using namespace std;

class Canteen {
public:
   Canteen(string name);
   string to_s() const;
   void sellNoodle(Person *person);
private:
   string ctnName;
};
#endif // CANTEEN_H
