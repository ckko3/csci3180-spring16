#ifndef VISITOR_H
#define VISITOR_H

#include <string>
#include "Person.h"
using namespace std;

class Visitor : public Person {
public:
   Visitor(string visitorID);
   virtual string to_s() const;
   virtual void pay(int amount);
private:
   string visitorID;
   int money;
};
#endif // VISITOR_H
