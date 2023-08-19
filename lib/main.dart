import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery_admin/controller/bundle/add_bundle_controller.dart';
import 'package:my_grocery_admin/controller/bundle/add_product_to_bundle_controller.dart';
import 'package:my_grocery_admin/controller/bundle/bundle_screen_controlloer.dart';
import 'package:my_grocery_admin/controller/category/add_category_screen.dart';
import 'package:my_grocery_admin/controller/coupon/add_coupon_screen.dart';
import 'package:my_grocery_admin/controller/login_screen_controller.dart';
import 'package:my_grocery_admin/controller/nav_controller.dart';
import 'package:my_grocery_admin/controller/product/add_product_screen_controller.dart';
import 'package:my_grocery_admin/controller/product/add_product_variant_screen_controller.dart';
import 'package:my_grocery_admin/controller/site_layout_controller.dart';
import 'package:my_grocery_admin/controller/splash_screen_controller.dart';
import 'package:my_grocery_admin/controller/user_screen_controller.dart';
import 'package:my_grocery_admin/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'controller/category/category_screen_controller.dart';
import 'controller/coupon/coupon_screen_controller.dart';
import 'controller/coupon/edit_coupon_screen_controller.dart';
import 'controller/product/view_product_controller.dart';
import 'controller/product/view_product_variant_screen_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavController>(
          create: (_) => NavController(),
        ),
        ChangeNotifierProvider<SplashScreenController>(
          create: (_) => SplashScreenController(),
        ),
        ChangeNotifierProvider<LoginScreenController>(
          create: (_) => LoginScreenController(),
        ),
        ChangeNotifierProvider<SiteLayoutController>(
          create: (_) => SiteLayoutController(),
        ),
        ChangeNotifierProvider<ViewProductController>(
          create: (_) => ViewProductController(),
        ),
        ChangeNotifierProvider<ViewProductVariantScreenController>(
          create: (_) => ViewProductVariantScreenController(),
        ),
        ChangeNotifierProvider<AddProductVariantScreenController>(
          create: (_) => AddProductVariantScreenController(),
        ),
        ChangeNotifierProvider<AddProductScreenController>(
          create: (_) => AddProductScreenController(),
        ),
        ChangeNotifierProvider<CategoryScreenController>(
          create: (_) => CategoryScreenController(),
        ),
        ChangeNotifierProvider<AddCategoryScreenController>(
          create: (_) => AddCategoryScreenController(),
        ),
        ChangeNotifierProvider<UserScreenController>(
          create: (_) => UserScreenController(),
        ),
        ChangeNotifierProvider<CouponScreenController>(
          create: (_) => CouponScreenController(),
        ),
        ChangeNotifierProvider<AddCouponScreenController>(
          create: (_) => AddCouponScreenController(),
        ),
        ChangeNotifierProvider<EditCouponScreenController>(
          create: (_) => EditCouponScreenController(),
        ),
        ChangeNotifierProvider<BundleScreenController>(
          create: (_) => BundleScreenController(),
        ),
        ChangeNotifierProvider<AddBundleScreenController>(
          create: (_) => AddBundleScreenController(),
        ),
        ChangeNotifierProvider<AddProductToBundleScreenController>(
          create: (_) => AddProductToBundleScreenController(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Dem',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
