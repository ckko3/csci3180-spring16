#ifndef HOSPITALMEMBER_H
#define HOSPITALMEMBER_H

#include <string>
#include "Person.h"
using namespace std;

class HospitalMember : public Person {
public:
   HospitalMember(string name, int nbDrugsDispensed = 0);
   virtual string to_s() const = 0;
   virtual void seeDoctor(int num);
   void getDrugDispensed(int num);
   /* extra getters and setters for the sake of information hiding */
   string getName() const;
   int getNbDrugsDispensed() const;
   void setNbDrugsDispensed(int num);
private:
   string name;
   int nbDrugsDispensed;
};
#endif // HOSPITALMEMBER_H
