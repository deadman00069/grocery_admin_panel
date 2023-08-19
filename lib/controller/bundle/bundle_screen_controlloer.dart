import 'package:flutter/material.dart';
import 'package:my_grocery_admin/models/BundleModel.dart';
import 'package:my_grocery_admin/repositories/bundle_repo.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class BundleScreenController extends ChangeNotifier {
  var loading = false;
  late List<BundleModel> listOfBundles = [];
  bool isWeb = false;
  bool isMobile = false;


  void init() {
    getBundles();
    checkPlatform();
  }

  void checkPlatform() {
    if (kIsWeb) {
      isWeb = true;
    } else if (Platform.isAndroid) {
      isMobile = true;
    }
  }
  void getBundles() async {
    loading = true;
    listOfBundles = [];
    listOfBundles = await getBundlesRepo();
    loading = false;
    notifyListeners();
  }

}
