import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_grocery_admin/models/category_model.dart';
import 'package:my_grocery_admin/repositories/category_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryScreenController extends ChangeNotifier {
  bool loading = false;
  List<CategoryModel> categories = [];
  late SharedPreferences preferences;
  bool isWeb = false;
  bool isMobile = false;

  void init() {
    checkPlatform();
    getCategories();
  }

  void checkPlatform() {
    if (kIsWeb) {
      isWeb = true;
    } else if (Platform.isAndroid) {
      isMobile = true;
    }
  }

  Future<void> getCategories() async {
    categories = [];
    loading = true;
    categories = await getAllCategoryRepo();
    loading = false;
    notifyListeners();
  }

  Future<void> deleteCategory(String categoryId) async {
    preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    bool response = await deleteCategoryRepo(
      categoryId,
      token!,
    );
    if (response) {
      Fluttertoast.showToast(msg: 'Category delete success');
      getCategories();
    } else {
      Fluttertoast.showToast(msg: 'Category delete fails');
    }
  }
}
