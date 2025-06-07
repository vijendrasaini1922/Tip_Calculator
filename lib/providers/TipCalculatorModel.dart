import 'package:flutter/material.dart';

class Tipcalculatormodel extends ChangeNotifier {
  int _totalPerson = 2;
  String _errorMsg = "";
  double _tipPercentage = 0.0;
  double _billTotal = 100.0;

  // Getter to retrieve current state
  double get billTotal => _billTotal;
  double get tipPercentage => _tipPercentage;
  int get totalPerson => _totalPerson;
  String get errorMsg => _errorMsg;

  
  void updateBillTotal(double billTotal){
    _billTotal = billTotal;
    notifyListeners();
  }

void updateTipPercentage(double tipPercentage) {
    _tipPercentage = tipPercentage;
    notifyListeners();
  }

  void updatePersonCount(int totalPerson){
    _totalPerson = totalPerson;
    notifyListeners();
  }

  double get tipAmount{
    return _billTotal*_tipPercentage;
  }

  double get totalPerPerson{
    return ((_billTotal*_tipPercentage) + (_billTotal))/_totalPerson;
  }

  double get grandTotal{
    return ((_billTotal*_tipPercentage) + (_billTotal));
  }



}