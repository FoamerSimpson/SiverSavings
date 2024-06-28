import 'dart:math';

double investmentCalculation(double initial, int years, double percent, double monthly) {
  double r = percent / 100;  
  int n = 12;  
  int t = years;
  
  
  double FV_initial = initial * pow((1 + r/n), n*t);
  
  
  double FV_contributions = monthly * (pow((1 + r/n), n*t) - 1) / (r/n);
  
  
  double FV_total = FV_initial + FV_contributions;
  
  return double.parse(FV_total.toStringAsFixed(2));
}

String morgageCalculation(double amount, double years, double rate){

  double monthlyRate = rate / 100 / 12;
  int n = (years * 12).toInt();
  double monthlyPayment = amount * monthlyRate / (1 - pow(1 + monthlyRate, -n));
  return monthlyPayment.toStringAsFixed(2);
}

