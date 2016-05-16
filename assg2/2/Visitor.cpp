#include <iostream>
#include <string>
#include "Visitor.h"
using namespace std;

// constuctor
Visitor::Visitor(string visitorID) : visitorID(visitorID) {
  money = 1000;
}

string Visitor::to_s() const {
  return "Visitor " + visitorID;
}

void Visitor::pay(int amount) {
  money -= amount;
  cout << to_s() << " has got HK$" << money << " left in the wallet." << endl;
}
