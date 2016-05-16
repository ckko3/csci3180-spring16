#ifndef PERSON_H
#define PERSON_H

#include <string>
using namespace std;

class Person {
public:
  Person();
  virtual string to_s() const = 0;
  virtual void pay(int amount) = 0;
  void buyFood(string foodName, int payment);
  virtual ~Person();
};
#endif // PERSON_H
