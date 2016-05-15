#include <iostream>
#include <string>
#include "HospitalMember.h"
using namespace std;

// constuctor
HospitalMember::HospitalMember(string name, int nbDrugsDispensed) : name(name), nbDrugsDispensed(nbDrugsDispensed) {
}

// This method will be overridden in the subclass!
void HospitalMember::seeDoctor(int num) {
  cout << to_s() << " is sick! S/he sees a doctor." << endl;
}

void HospitalMember::getDrugDispensed(int num) {
  int nbDrugsDispensed;
  if (getNbDrugsDispensed() < num) {
    nbDrugsDispensed = getNbDrugsDispensed();
    setNbDrugsDispensed(0);
  } else {
    nbDrugsDispensed = num;
    setNbDrugsDispensed(getNbDrugsDispensed() - num);
  }
  cout << "Dispensed " << nbDrugsDispensed << " drug items, " << getNbDrugsDispensed() << " items still to be dispensed." << endl;
}

/* extra getters and setters */
string HospitalMember::getName() const {
	return name;
}

int HospitalMember::getNbDrugsDispensed() const {
	return nbDrugsDispensed;
}

void HospitalMember::setNbDrugsDispensed(int num) {
	nbDrugsDispensed = num;
}