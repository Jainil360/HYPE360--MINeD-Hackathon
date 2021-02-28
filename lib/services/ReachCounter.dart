import 'package:flutter/material.dart';
import 'package:flutter_auth/services/sign_in.dart';

int charges, adspent, total;
int reachlower, reachupper;

int chargesCalc(exp) {

  if(exp <= 500)
  {
    return 300;
  }
  else if(exp > 501 && exp < 1500)
  {
    return 500;
  }
  else if(exp > 1500)
  {
    return (exp * 0.4).toInt();
  }
  
  
}

List counter(btype, budget, duration) {
  if (btype == "backer") {
    print(duration);

    adspent = duration * budget;
    reachlower = adspent * 10;
    reachupper = (adspent * 10) + 1000;
    charges = chargesCalc(adspent);
    total = charges + adspent;
  }
 if (btype == "accountant") {
    print(duration);

    adspent = duration * budget;
    reachlower = adspent * 10;
    reachupper = (adspent * 10) + 1000;
    charges = chargesCalc(adspent);
    total = charges + adspent;
  }

  return [reachlower, reachupper, adspent, charges, total];
}
