#include <iostream>
#include <string>
#include "Pharmacy.h"
#include "HospitalMember.h"

using namespace std;

// constuctor
Pharmacy::Pharmacy(string name) : pharmName(name) {
}

string Pharmacy::to_s() const {
  return pharmName + " Pharmacy";
}

void Pharmacy::dispenseDrugs(Person *person, int numOfDrugs) {
  // dynamic cast to HospitalMember pointer
  HospitalMember *hmPtr = dynamic_cast<HospitalMember *>(person);
  if (hmPtr != NULL) {
    // HospitalMember object
    hmPtr->getDrugDispensed(numOfDrugs);
  } else {
    cout << person->to_s() << " is not a pharmacy user!" << endl;
  }
}
