import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:my_grocery_admin/models/user_model.dart';
import 'package:my_grocery_admin/repositories/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreenController extends ChangeNotifier {
  bool loading = false;
  List<UserModel> users = [];
  late SharedPreferences preferences;
  bool isWeb = false;
  bool isMobile = false;

  void init() {
    checkPlatform();
    getAllUsers();
  }

  void checkPlatform() {
    if (kIsWeb) {
      isWeb = true;
    } else if (Platform.isAndroid) {
      isMobile = true;
    }
  }

  void getAllUsers() async {
    users = [];
    loading = true;
    preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    users = await getAllUsersRepo(token!);
    loading = false;
    notifyListeners();
  }
}
