#include <iostream>
#include <string>
#include "Doctor.h"
using namespace std;

// constuctor
Doctor::Doctor(string staffID, string name) : HospitalMember(name), staffID(staffID) {
  salary = 100000;
}

string Doctor::to_s() const {
  return "Doctor " + getName() + " ("+ staffID + ")";
}

void Doctor::seeDoctor(int num) {
  HospitalMember::seeDoctor(num);
  setNbDrugsDispensed(getNbDrugsDispensed() + num);
  cout << "Totally " << getNbDrugsDispensed() << " drug items administered." << endl;
}

void Doctor::getSalary(int amount) {
  salary += amount;
  cout << to_s() << " has got HK$" << salary << " salary left." << endl;
}

void Doctor::pay(int amount) {
  salary -= amount;
  cout << to_s() << " has got HK$" << salary << " salary left." << endl;
}

void Doctor::attendClub() const {
  cout << "Eat and drink in the Club." << endl;
}
