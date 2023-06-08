import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '/ui/providers/product_provider.dart';
import '/ui/screens/login_screen.dart';

class AppInit extends StatelessWidget {
  const AppInit({super.key});

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return AnimatedSplashScreen.withScreenFunction(
      splash: Image.asset("assets/images/logo.png"),
      splashIconSize: 200,
      pageTransitionType: PageTransitionType.fade,
      screenFunction: () async {
        await productProvider.getAllProducts("vehicles");
        return const LoginScreen();
      },
    );
  }
}
