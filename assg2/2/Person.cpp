#include <iostream>
#include "Person.h"

using namespace std;

Person::Person(){
}

Person::~Person(){
}

void Person::buyFood(string foodName, int payment) {
	cout << "Buy " << foodName << " and pay $" << payment << "." << endl;
	pay(payment);
}