import 'package:flutter/material.dart';


class WalletProvider extends ChangeNotifier {
double _balance = 250.0;


double get balance => _balance;


void add(double amount) {
_balance += amount;
notifyListeners();
}


bool deduct(double amount) {
if (_balance >= amount) {
_balance -= amount;
notifyListeners();
return true;
}
return false;
}
}