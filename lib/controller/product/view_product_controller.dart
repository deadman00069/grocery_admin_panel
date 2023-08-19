import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_grocery_admin/models/product_model.dart';
import 'package:my_grocery_admin/repositories/product_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewProductController extends ChangeNotifier {
  bool isLoading = false;
  List<ProductModel> products = [];
  late SharedPreferences preferences;

  Future<void> getProducts() async {
    products = [];
    isLoading = true;
    var response = await getAllProductRepo();
    if (response.isNotEmpty) {
      products = response;
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String productId) async {
    preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    var response = await deleteProductRepo(
      productId,
      token!,
    );
    if (response) {
      Fluttertoast.showToast(msg: 'Product delete success');
      getProducts();
    } else {
      Fluttertoast.showToast(msg: 'Product delete fails');
    }
  }
}
