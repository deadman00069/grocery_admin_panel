import 'package:flutter/material.dart';
import 'package:my_grocery_admin/controller/nav_controller.dart';
import 'package:my_grocery_admin/controller/site_layout_controller.dart';
import 'package:my_grocery_admin/screens/home_screen.dart';
import 'package:my_grocery_admin/screens/products/product_screen.dart';
import 'package:my_grocery_admin/screens/responsiveness.dart';
import 'package:my_grocery_admin/screens/small_screen.dart';
import 'package:provider/provider.dart';

import 'category/category_screen.dart';
import 'coupon/coupon_screen.dart';
import 'user_screen.dart';

class SiteLayout extends StatefulWidget {
  const SiteLayout({Key? key}) : super(key: key);

  @override
  State<SiteLayout> createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SiteLayoutController>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    var navigationController = Provider.of<NavController>(context);
    var controller = Provider.of<SiteLayoutController>(context);
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: const Text('Challet'),
        leading: ResponsiveWidget.isSmallScreen(context)
            ? IconButton(
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
                icon: const Icon(Icons.menu),
              )
            : const SizedBox(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notification_add_rounded),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                controller.name!,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              controller.logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('dad'),
              accountEmail: Text('dad'),
            ),
            ListTile(
              title: Text(
                'Product',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              leading: const Icon(Icons.work),
              onTap: () {
                navigationController.navigateToPop(routeName: ProductScreen.id);
                Navigator.pop(context);
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
                Navigator.pop(context);
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
                navigationController.navigateToPop(routeName: UserScreen.id);
                Navigator.pop(context);
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
                navigationController.navigateToPop(routeName: CouponScreen.id);
                Navigator.pop(context);
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
                navigationController.navigateToPop(routeName: CouponScreen.id);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: const ResponsiveWidget(
        largeScreen: HomeScreen(),
        smallScreen: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SmallScreen(),
        ),
      ),
    );
  }
}
