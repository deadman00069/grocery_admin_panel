import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_grocery_admin/models/login_model.dart';
import 'package:my_grocery_admin/repositories/user_repo.dart';
import 'package:my_grocery_admin/screens/site_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenController extends ChangeNotifier {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController emailTED = TextEditingController();
  TextEditingController phoneNoTED = TextEditingController();
  TextEditingController smsCodeTED = TextEditingController();
  var isSelected = false;
  bool codeSend = false;
  bool isLoading = false;
  bool isWeb = false;
  bool isMobile = false;
  late SharedPreferences preferences;
  late ConfirmationResult confirmationResult;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String error = '';
  late String _verificationId;

  void init() {
    isSelected = false;
    codeSend = false;
    isLoading = false;
    isWeb = false;
    isMobile = false;
    error = '';
    emailTED.clear();
    phoneNoTED.clear();
    smsCodeTED.clear();
    checkPlatform();
  }

  void onCheckBoxButtonClicked() {
    isSelected = !isSelected;
    notifyListeners();
  }

  String? validateEmailFields(String? v) {
    if (v!.isEmpty) return 'This field id required';
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(v)) return 'Please enter valid email';
    return null;
  }

  String? validatePhoneNoFields(String? v) {
    if (v!.isEmpty) return 'This field id required';
    if (v.length != 10) return 'Please enter valid phone no';
    return null;
  }

  String? validateSmsCode(String? v) {
    if (v!.isEmpty) return 'This field id required';
    if (v.length != 6) return 'Please enter valid code';
    return null;
  }

  void saveEmail(String? v) {
    emailTED.text = v!;
  }

  void savePhoneNo(String? v) {
    phoneNoTED.text = v!;
  }

  void saveSmsCode(String? v) {
    smsCodeTED.text = v!;
  }

  void login(BuildContext context) async {
    print(' i Inside login');
    LoginModel? response = await loginRepo(emailTED.text, phoneNoTED.text);

    print('gfhgfhfghfgdb');
    print(response!.status!);
    print(response.token);
    print(response.user);

    if (response != null) {
      preferences = await SharedPreferences.getInstance();
      if (isSelected) {
        preferences.setBool('remember', true);
      }
      preferences.setString('token', response.token!);
      preferences.setString('name', response.user!.name!);
      preferences.setString('email', response.user!.email!);
      preferences.setString('phone_no', response.user!.phoneNo!);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SiteLayout(),
        ),
      );
    } else {
      error = 'verification fail';
      notifyListeners();
    }
  }

  Future<void> onSendCodeWeb(BuildContext context) async {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      Fluttertoast.showToast(msg: 'sending code');
      confirmationResult = await _firebaseAuth
          .signInWithPhoneNumber('+91' + phoneNoTED.text)
          .catchError((error) {
        print('verifyPhoneNo' + error.toString());
        Fluttertoast.showToast(msg: '$error');
      });
      Fluttertoast.showToast(msg: 'code send success');
      codeSend = !codeSend;
      notifyListeners();
    }
  }

  void onVerifyCodeWeb(BuildContext context) async {
    if (key.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      try {
        UserCredential userCredential =
            await confirmationResult.confirm(smsCodeTED.text);
        isLoading = false;
        if (userCredential.user != null) {
          print(' i inside onVerifyCodeWeb');
          print(userCredential.user);
          login(context);
        } else {
          Fluttertoast.showToast(msg: 'not verified');
          error = 'verification fail';
          notifyListeners();
        }
        notifyListeners();
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
        isLoading = false;
        error = e.toString();
        notifyListeners();
      }
    }
  }

  Future<void> onSendCodeMobile() async {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      Fluttertoast.showToast(msg: 'sending code');
      void verificationDone(PhoneAuthCredential credential) async {
        await _firebaseAuth
            .signInWithCredential(credential)
            .then((value) async {
          if (value.user != null) {
            print('i auto verify');
          } else {
            Fluttertoast.showToast(msg: "Error validating OTP, try again");
          }
        }).catchError((error) {
          print('verify done error' + error);
          Fluttertoast.showToast(msg: '$error');
        });
      }

      void verificationFail(FirebaseAuthException e) {
        print('i am fail' + e.message.toString());
        Fluttertoast.showToast(msg: '${e.message}');
      }

      void codeSent(String verificationId, int? resendToken) async {
        print('i am code Sent');
        Fluttertoast.showToast(msg: 'Verification code send successfully');
        _verificationId = verificationId;
        codeSend = true;
        notifyListeners();
        // dialogBox(verificationId, resendToken);
        // Create a PhoneAuthCredential with the code
      }

      await _firebaseAuth
          .verifyPhoneNumber(
        phoneNumber: "+91${phoneNoTED.text}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationDone,
        verificationFailed: verificationFail,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        },
      )
          .catchError((error) {
        print('verifyPhoneNo' + error);
        Fluttertoast.showToast(msg: '$error');
      });
    }
  }

  Future<void> onVerifyCodeMobile(BuildContext context) async {
    try {
      AuthCredential _authCredential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: smsCodeTED.text);
      var response = await _firebaseAuth.signInWithCredential(_authCredential);
      if (response.user != null) {
        Fluttertoast.showToast(msg: 'validated');
        login(context);
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-verification-code') {
        Fluttertoast.showToast(msg: 'Invalid OTP');
      } else if (e.code == 'invalid-verification-id') {
        Fluttertoast.showToast(msg: 'Invalid OTP');
      } else {
        Fluttertoast.showToast(
            msg: 'Something went wrong,please try again later');
      }
    }
  }

  void checkPlatform() {
    if (kIsWeb) {
      isWeb = true;
    } else if (Platform.isAndroid) {
      isMobile = true;
    }
  }
}
