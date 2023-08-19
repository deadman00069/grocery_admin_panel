import 'package:flutter/material.dart';
import 'package:my_grocery_admin/controller/nav_controller.dart';
import 'package:my_grocery_admin/navigator/route.dart';
import 'package:my_grocery_admin/screens/products/product_screen.dart';
import 'package:provider/provider.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navController = Provider.of<NavController>(context);

    return Scaffold(
      body: Navigator(
        key: navController.navigatorKey,
        onGenerateRoute: generateRoute,
        initialRoute: ProductScreen.id,
      ),
    );
  }
}
