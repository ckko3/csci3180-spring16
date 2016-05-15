#ifndef PATIENT_H
#define PATIENT_H

#include <string>
#include "HospitalMember.h"
using namespace std;

class Patient : public HospitalMember {
public:
   Patient(string patientID, string name);
   virtual string to_s() const;
   virtual void seeDoctor(int num);
   virtual void pay(int amount);
private:
   string patientID;
   int money;
};
#endif // PATIENT_H
