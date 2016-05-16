#ifndef DOCTOR_H
#define DOCTOR_H

#include <string>
#include "HospitalMember.h"
using namespace std;

class Doctor : public HospitalMember {
public:
   Doctor(string staffID, string name);
   virtual string to_s() const;
   virtual void seeDoctor(int num);
   void getSalary(int amount);
   virtual void pay(int amount);
   void attendClub() const;
private:
   string staffID;
   int salary;
};
#endif // DOCTOR_H
