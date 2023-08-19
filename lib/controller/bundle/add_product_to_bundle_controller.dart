import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_grocery_admin/models/product_model.dart';
import 'package:my_grocery_admin/repositories/bundle_repo.dart';
import 'package:my_grocery_admin/repositories/product_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductToBundleScreenController extends ChangeNotifier {
  bool loading = false;
  late SharedPreferences preferences;

  void init() {
    getProducts();
  }

  List<ProductModel> listOfProducts = [];
  var listOfProduct = [];
  ProductModel? selectedProduct;
  int? selectedVariantId;

  void onProductSelected(ProductModel productModel) {
    selectedProduct = productModel;
    notifyListeners();
  }

  void getProducts() async {
    loading = true;
    listOfProducts = [];
    var response = await getAllProductRepo();
    if (response.isNotEmpty) {
      listOfProducts = response;
      loading = false;
      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
    }
  }

  void addProductToBundle(int bundleId) async {
    preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    var response = await addProductToBundleRepo(
      token: token!,
      bundleId: bundleId,
      variantId: selectedVariantId!,
    );
    if (response) {
      Fluttertoast.showToast(msg: "Success");
      return;
    }
    Fluttertoast.showToast(msg: "Fail");
    return;
  }
}
