/*
CSCI3180 Principles of Programming Languages
--- Declaration ---
I declare that the assignment here submitted is original except for source material explicitly acknowledged.
I also acknowledge that I am aware of University policy and regulations on honesty in academic work,
and of the disciplinary guidelines and procedures applicable to breaches of such policy and regulations,
as contained in the http://www.cuhk.edu.hk/policy/academichonesty/
Assignment 2
Name: KO Chi Keung
Student ID: 1155033234
Email Addr: ckko3@se.cuhk.edu.hk
*/

// Hospital Administration System

#include <iostream>
#include <vector>
#include "Person.h"
#include "HospitalMember.h"
#include "Doctor.h"
#include "Patient.h"
#include "Visitor.h"
#include "Pharmacy.h"
#include "Canteen.h"
#include "Department.h"
#include "StaffClub.h"
using namespace std;

int main() {
  // run the system
  cout << "Hospital Administration System:" << endl;

  // roles
  Person *alice = new Patient("p001", "Alice");
  Person *bob = new Doctor("d001", "Bob");
  Person *visitor = new Visitor("v001");
  Pharmacy mainPharm("Main");
  Canteen bigCtn("Big Big");
  Department ane("A&E");
  StaffClub teaClub("Happy");

  // roles in different activities
  vector<Person*> person_list;
  person_list.push_back(alice);
  person_list.push_back(bob);
  person_list.push_back(visitor);
  for (vector<Person*>::iterator it = person_list.begin(); it != person_list.end(); it++) {
    cout << endl;
    cout << (*it)->to_s() << " enters CU Hospital ..." << endl;
    //A&E
    cout << (*it)->to_s() << " enters " << ane.to_s() + "." << endl;
    ane.callPatient(*it, 20);
    //pharmacy
    cout << (*it)->to_s() << " enters " << mainPharm.to_s() << "." << endl;
    mainPharm.dispenseDrugs(*it, 10);
    mainPharm.dispenseDrugs(*it, 25);
    //canteen
    cout << (*it)->to_s() << " enters " << bigCtn.to_s() << "." << endl;
    bigCtn.sellNoodle(*it);
    //A&E again
    cout << (*it)->to_s() << " enters " << ane.to_s() << " again." << endl;
    ane.paySalary(*it, 10000);
    //club
    cout << (*it)->to_s() << " enters " << teaClub.to_s() << "." << endl;
    teaClub.holdParty(*it);

    //deallocate memory
    delete *it;
  }

  // clear vector
  person_list.clear();

  return 0;
}
