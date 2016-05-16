#include <iostream>
#include <string>
#include "StaffClub.h"
#include "Doctor.h"
using namespace std;

// constuctor
StaffClub::StaffClub(string name) : clubName(name) {
}

string StaffClub::to_s() const {
  return clubName + " Club";
}

void StaffClub::holdParty(Person *person) {
  // dynamic cast to Doctor pointer
  Doctor *dPtr = dynamic_cast<Doctor *>(person);
  if (dPtr != NULL) {
    // Doctor object
    dPtr->attendClub();
  }
  else {
    cout << person->to_s() << " has no rights to use facilities in the Club!" << endl;
  }
}
