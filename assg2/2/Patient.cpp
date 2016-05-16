#include <iostream>
#include <string>
#include "Patient.h"
using namespace std;

// constuctor
Patient::Patient(string patientID, string name) : HospitalMember(name), patientID(patientID) {
  money = 10000;
}

string Patient::to_s() const {
  return "Patient " + getName() + " ("+ patientID + ")";
}

void Patient::seeDoctor(int num) {
  HospitalMember::seeDoctor(num);
  int max = 15;
  if (num < max - getNbDrugsDispensed()) {
    setNbDrugsDispensed(getNbDrugsDispensed() + num);
  } else {
    setNbDrugsDispensed(max);
  }
  cout << "Totally " << getNbDrugsDispensed() << " drug items administered." << endl;
}

void Patient::pay(int amount) {
  money -= amount;
  cout << to_s() << " has got HK$" << money << " left in the wallet." << endl;
}
