import 'package:flutter/material.dart';
import 'package:my_grocery_admin/controller/login_screen_controller.dart';
import 'package:my_grocery_admin/controller/nav_controller.dart';
import 'package:my_grocery_admin/navigator/route.dart';
import 'package:my_grocery_admin/screens/category/category_screen.dart';
import 'package:my_grocery_admin/screens/coupon/coupon_screen.dart';
import 'package:my_grocery_admin/screens/products/product_screen.dart';
import 'package:my_grocery_admin/screens/user_screen.dart';
import 'package:provider/provider.dart';

import 'bundle/bundle_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LoginScreenController>(context,listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    var navigationController = Provider.of<NavController>(context);

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.black, width: 1),
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Product',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    leading: const Icon(Icons.work),
                    onTap: () {
                      navigationController.navigateToPop(
                          routeName: ProductScreen.id);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Category',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    leading: const Icon(Icons.list),
                    onTap: () {
                      navigationController.navigateToPop(
                          routeName: CategoryScreen.id);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Users',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    leading: const Icon(Icons.person),
                    onTap: () {
                      navigationController.navigateToPop(
                          routeName: UserScreen.id);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Coupons',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    leading: const Icon(Icons.topic),
                    onTap: () {
                      navigationController.navigateToPop(
                          routeName: CouponScreen.id);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Bundles',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: const Icon(Icons.topic),
                    onTap: () {
                    debugPrint("kjrgjgbjkbkbk");
                    navigationController.navigateToPop(routeName: BundleScreen.id);
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white,
              child: Navigator(
                key: navigationController.navigatorKey,
                onGenerateRoute: generateRoute,
                initialRoute: ProductScreen.id,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
