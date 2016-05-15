#include <iostream>
#include <string>
#include "Canteen.h"
using namespace std;

// constuctor
Canteen::Canteen(string name) : ctnName(name) {
}

string Canteen::to_s() const {
  return ctnName + " Canteen";
}

void Canteen::sellNoodle(Person *person) {
	int price = 40;
	person->buyFood("Noodle", price);
}

