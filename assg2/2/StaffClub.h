#ifndef STAFFCLUB_H
#define STAFFCLUB_H

#include <string>
#include "Person.h"
using namespace std;

class StaffClub {
public:
   StaffClub(string name);
   string to_s() const;
   void holdParty(Person *person);
private:
   string clubName;
};
#endif // STAFFCLUB_H
