#include <iostream>
#include <string>
#include "Department.h"
#include "HospitalMember.h"
#include "Doctor.h"
using namespace std;

// constuctor
Department::Department(string name) : deptName(name) {
}

string Department::to_s() const {
  return deptName + " Department";
}

void Department::callPatient(Person *person, int amount) {
	// dynamic cast to HospitalMember pointer
	HospitalMember *hmPtr = dynamic_cast<HospitalMember *>(person);
	if (hmPtr != NULL) {
		// HospitalMember object
		hmPtr->seeDoctor(amount);
	}
	else {
		cout << person->to_s() << " has no rights to get see a doctor!" << endl;
	}
}

void Department::paySalary(Person *person, int amount) {
	// dynamic cast to Doctor pointer
	Doctor *dPtr = dynamic_cast<Doctor *>(person);
	if (dPtr != NULL) {
		// Doctor object
		cout << to_s() << " pays Salary $" << amount << " to " << dPtr->to_s() << "." << endl;
		dPtr->getSalary(amount);
	}
	else {
		cout << person->to_s() << " has no rights to get salary from " << to_s() << "!" << endl;
	}
}

