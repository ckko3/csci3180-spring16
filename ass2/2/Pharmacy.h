#ifndef PHARMACY_H
#define PHARMACY_H

#include <string>
#include "Person.h"
using namespace std;

class Pharmacy {
public:
   Pharmacy(string name);
   string to_s() const;
   void dispenseDrugs(Person *person, int numOfDrugs);
private:
   string pharmName;
};
#endif // PHARMACY_H
