#ifndef DEPARTMENT_H
#define DEPARTMENT_H

#include <string>
#include "Person.h"
using namespace std;

class Department {
public:
   Department(string name);
   string to_s() const;
   void callPatient(Person *person, int amount);
   void paySalary(Person *person, int amount);
private:
   string deptName;
};
#endif // DEPARTMENT_H
