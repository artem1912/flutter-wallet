import 'package:crypto_wallet/services/utilServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'UI/pages/SplashScreen/splashScreen.dart';
import 'controllers/appController.dart';

void main() {
  runApp(MyApp());


  UtilService.getSavedData();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appController = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return   GetMaterialApp(
        title: 'Crypto Wallet',
        theme: ThemeData(
           primaryColor: Color(0xff27C19F),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor:  Color(0xff27C19F),
          )
        ),
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        transitionDuration: const Duration(milliseconds: 500),
        defaultTransition: Transition.rightToLeftWithFade,
        home:SplashScreen()

    );
  }
}
class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}