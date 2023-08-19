import 'package:flutter/material.dart';
import 'package:my_grocery_admin/screens/bundle/add_bundle_screen.dart';
import 'package:my_grocery_admin/screens/bundle/add_product_to_bundle_screen.dart';
import 'package:my_grocery_admin/screens/bundle/bundle_screen.dart';
import 'package:my_grocery_admin/screens/category/add_category_screen.dart';
import 'package:my_grocery_admin/screens/category/category_screen.dart';
import 'package:my_grocery_admin/screens/coupon/add_coupon_screen.dart';
import 'package:my_grocery_admin/screens/coupon/coupon_screen.dart';
import 'package:my_grocery_admin/screens/products/add_product_screen.dart';
import 'package:my_grocery_admin/screens/products/edit_product_screen.dart';
import 'package:my_grocery_admin/screens/products/product_screen.dart';
import 'package:my_grocery_admin/screens/user_screen.dart';
import 'package:page_transition/page_transition.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ProductScreen.id:
      return _getPageRoute(
        const ProductScreen(),
      );
    case AddProductScreen.id:
      return _getPageRoute(
        const AddProductScreen(),
      );

    case EditProductScreen.id:
      return _getPageRoute(
        const EditProductScreen(),
      );

    case CategoryScreen.id:
      return _getPageRoute(
        const CategoryScreen(),
      );
    case AddCategoryScreen.id:
      return _getPageRoute(
        const AddCategoryScreen(),
      );
    case UserScreen.id:
      return _getPageRoute(
        const UserScreen(),
      );
    case CouponScreen.id:
      return _getPageRoute(
        const CouponScreen(),
      );
    case BundleScreen.id:
      return _getPageRoute(
        const BundleScreen(),
      );

    case AddBundleScreen.id:
      return _getPageRoute(
        const AddBundleScreen(),
      );
    case AddProductToBundleScreen.id:
      return _getPageRoute(
        const AddProductToBundleScreen(

        ),
      );
    case AddCouponScreen.id:
      return _getPageRoute(
        const AddCouponScreen(),
      );

    default:
      return _getPageRoute(const ProductScreen());
  }
}

PageRoute _getPageRoute(Widget child) {
  return PageTransition(
    child: child,
    type: PageTransitionType.bottomToTop,
  );

  return MaterialPageRoute(builder: (context) => child);
}
