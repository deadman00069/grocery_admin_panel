import 'package:flutter/material.dart';
import 'package:my_grocery_admin/controller/splash_screen_controller.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
    ).then(
      (value) => Provider.of<SplashScreenController>(context, listen: false)
          .checkIfTokenAvailable(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'SplashScreen',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
