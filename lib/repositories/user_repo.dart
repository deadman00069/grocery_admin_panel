import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:my_grocery_admin/config/config.dart';
import 'package:my_grocery_admin/models/login_model.dart';
import 'package:my_grocery_admin/models/user_model.dart';

Future<LoginModel?> loginRepo(String email, String phoneNo) async {
  Uri url = Uri.parse(AppConfig.BASE_API_URL + 'login');
  try {
    var response = await http.post(url, body: {
      'email': email,
      'phone_no': phoneNo,
    });
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 &&
        json.decode(response.body)['status'] == true) {
      return LoginModel.fromJson(json.decode(response.body));
    }
    Fluttertoast.showToast(
      msg: json.decode(response.body)['message'].toString(),
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 4,
    );
    return null;
  } catch (e) {
    Fluttertoast.showToast(
      msg: e.toString(),
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 4,
    );
  }
}

Future<List<UserModel>> getAllUsersRepo(String token) async {
  Uri url = Uri.parse(AppConfig.BASE_API_URL + 'get-all-users');

  var response = await http.post(url, headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });

  if (response.statusCode == 200) {
    List<UserModel> users = [];
    for (Map data in json.decode(response.body)['data']) {
      users.add(UserModel.fromJson(data));
    }
    return users;
  }
  Fluttertoast.showToast(msg: json.decode(response.body)['message']);
  return [];
}
