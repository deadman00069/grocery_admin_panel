import 'package:flutter/material.dart';
import 'package:my_grocery_admin/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SiteLayoutController extends ChangeNotifier {
  late SharedPreferences preferences;
  String? name;
  String? email;

  void init() async {
    preferences = await SharedPreferences.getInstance();
    name = preferences.getString('name');
    email = preferences.getString('email');
    notifyListeners();
  }

  void logout(BuildContext context) async {
    preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        ),
        (route) => false);
  }
}
