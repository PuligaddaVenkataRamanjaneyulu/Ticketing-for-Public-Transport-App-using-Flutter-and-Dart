import 'package:flutter/material.dart';


class UserProvider extends ChangeNotifier {
String _name = 'Rama Naidu';
String _email = 'rama@example.com';


String get name => _name;
String get email => _email;


void updateProfile({String? name, String? email}) {
if (name != null) _name = name;
if (email != null) _email = email;
notifyListeners();
}
}