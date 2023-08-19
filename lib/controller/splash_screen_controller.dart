import 'package:flutter/material.dart';
import 'package:my_grocery_admin/screens/initial/login_screen.dart';
import 'package:my_grocery_admin/screens/site_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends ChangeNotifier {
  late SharedPreferences preferences;

  void checkIfTokenAvailable(BuildContext context) async {
    preferences = await SharedPreferences.getInstance();
    bool? remembered = preferences.getBool('remember');
    if (remembered == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SiteLayout(),
        ),
      );
    }
  }
}
