import 'package:flutter/cupertino.dart';

class NavController extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  Future<dynamic> navigateTo({required String routeName, var argument}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: argument);
  }

  Future<dynamic> navigateToPop({required String routeName, var argument}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: argument,
    );
  }

  goBack() => navigatorKey.currentState!.pop();
}
