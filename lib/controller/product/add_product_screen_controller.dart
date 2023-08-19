import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:my_grocery_admin/models/category_model.dart';
import 'package:my_grocery_admin/repositories/category_repo.dart';
import 'package:my_grocery_admin/repositories/product_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductScreenController extends ChangeNotifier {
  bool isLoading = false;
  final picker = ImagePicker();
  TextEditingController catIdTED = TextEditingController();
  TextEditingController nameTED = TextEditingController();
  TextEditingController descriptionTED = TextEditingController();
  XFile? image;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  List<CategoryModel> categories = [];
  late SharedPreferences preferences;
  bool isWeb = false;
  bool isMobile = false;

  init() {
    if (kIsWeb) {
      isWeb = true;

    } else {
      isMobile = true;
    }
  }

  Future<void> getCategories() async {
    categories = [];
    isLoading = true;
    categories = await getAllCategoryRepo();
    isLoading = false;
    notifyListeners();
  }

  void pickImage() async {
    image = await (picker.pickImage(source: ImageSource.gallery));
    notifyListeners();
  }

  String? validateFields(String? v) {
    if (v!.isEmpty) return 'This field is required';
    return null;
  }

  void saveCatId(String? v) {
    catIdTED.text = v!;
  }

  void saveName(String? v) {
    nameTED.text = v!;
  }

  void saveDescription(String? v) {
    descriptionTED.text = v!;
  }

  Future<void> addProduct() async {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');
      var response = await addProductRepo(
          catId: catIdTED.text,
          name: nameTED.text,
          desc: descriptionTED.text,
          image: image!,
          token: token!);
      print('tttttttttttt');
      print(response);
      if (response) {
        catIdTED.clear();
        nameTED.clear();
        descriptionTED.clear();
        image = null;
        notifyListeners();
      }
    }
  }
}
