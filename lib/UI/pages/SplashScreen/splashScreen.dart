import 'dart:io';

import 'package:crypto_wallet/UI/pages/home/dashboard.dart';
import 'package:crypto_wallet/services/utilServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:crypto_wallet/UI/common_widgets/bottomRectangularbtn.dart';
import 'package:crypto_wallet/UI/pages/app_introduction/intro_app.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/colors.dart';
import '../../../controllers/appController.dart';
import '../../../models/transactionsModel.dart';
import '../../../models/userModel.dart';
import '../../../services/apiService.dart';
import '../../../services/sharedPrefs.dart';
import '../../bottomNavBar/BottomNavBar.dart';
import '../biomatric/bioMatricLockScreen.dart';
import '../login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final List<Introduction> _list = [
    Introduction(
      title: 'Secure Wallet',
      subTitle: 'Secure Your Crypto, Anywhere Anytime',
      imageUrl: 'assets/imgs/onBoarding1.png',
    ),
    Introduction(
      title: 'Exchange',
      subTitle: 'Swap Crypto with Confidence',
      imageUrl: 'assets/imgs/onBoarding2.png',
    ),
    Introduction(
      title: 'All your assets in one Wallet',
      subTitle: 'Your Wallet, Your Way',
      imageUrl: 'assets/imgs/onBoarding3.png',
    ),
  ];
  final _appController = Get.find<AppController>();
  var hide = true.obs;
  bool canAuthenticateWithBiometrics = false;
  final LocalAuthentication auth = LocalAuthentication();

  bool isDeviceSupported = false;
  @override
  void initState() {
    // TODO: implement initState
    showBtn();
    checkTheme();
    redirect();
    secureScreen();
    getCurrencies();
    super.initState();
  }
  getCurrencies() async {
    ApiService().getCurrencies(limit: 100,offset: 0);
  }
  Future<void> secureScreen() async {
    //await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    if (sharedPref.containsKey('FingerPrintEnable')) {
      var verificationStats = sharedPref.getBool('FingerPrintEnable');
      _appController.enabledBiometric.value = verificationStats!;
      if (verificationStats == true) {
        canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
        isDeviceSupported = await auth.isDeviceSupported();
        final List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
        print('abc=================$canAuthenticateWithBiometrics');
        print('abc=================$isDeviceSupported');
        print('abc=================$availableBiometrics');
      }
    }
  }

  showBtn() {
    Future.delayed(Duration(milliseconds: 100), () {
      hide.value = false;
    });
  }

  checkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('isDarkMode')) {
      _appController.isDark.value = (prefs.getBool('isDarkMode'))!;
      _appController.changeTheme();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: lightColor,

              // Status bar brightness (optional)
              statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            elevation: 0,
          ),
        ),
        backgroundColor: primaryBackgroundColor.value,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 290 / 290,
                    child: Image.asset(
                      "assets/imgs/splash.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Crypto Wallet',
                    style: TextStyle(
                      fontFamily: 'sfpro',
                      color: primaryColor.value,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 39.0,
                      letterSpacing: 0.64125,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Digital wallet just got even better',
                    style: TextStyle(fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 16.0, letterSpacing: 0.37, color: labelColor.value),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              UtilService.firstLaunch == true && hide.value == false
                  ? Column(
                      children: [
                        BottomRectangularBtn(
                            onTapFunc: () {
                              Get.offAll(
                                  IntroScreenOnboarding(
                                    introductionList: _list,
                                    onTapSkipButton: () {
                                      //Get.offAll(Login(), duration: Duration(milliseconds: 300), transition: Transition.rightToLeft);
                                    },
                                  ),
                                  duration: Duration(milliseconds: 300),
                                  transition: Transition.rightToLeft);
                            },
                            btnTitle: 'Get Started'),
                        SizedBox(
                          height: 55,
                        )
                      ],
                    )
                  : Container(
                      height: 105,
                      width: Get.width,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  redirect() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    //print('await sharedPrefs.containsKey(jwtToken) ${await sharedPrefs.containsKey('jwtToken')}');
    Future.delayed(Duration(milliseconds: 1000), () async {
      SharedPref sharedPref = SharedPref();
      if (sharedPrefs.containsKey('jwtToken')) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('jwtToken');
        print(prefs.getString('jwtToken'));
        if (token != 'null' && token != '') {
          if (sharedPrefs.containsKey('user')) {
            var json = await sharedPref.readJson('user');
            _appController.user.value = UserModel.fromJson(json);
          }
          if (Platform.isIOS) {
            SharedPreferences sharedPref = await SharedPreferences.getInstance();
            if (sharedPref.containsKey('FingerPrintEnable') && await sharedPref.getBool('FingerPrintEnable') == true) {
              showModalBottomSheet(
                  isScrollControlled: true,
                  isDismissible: false,
                  enableDrag: false,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                  ),
                  context: context,
                  builder: (builder) {
                    return BioMatricLockScreen();
                  });
            } else {
              Get.offAll(BottomNavigationBar1());
            }
          } else {
            if (isDeviceSupported && canAuthenticateWithBiometrics) {
              showModalBottomSheet(
                  isScrollControlled: true,
                  isDismissible: false,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                  ),
                  context: context,
                  builder: (builder) {
                    return BioMatricLockScreen();
                  });

              //Get.offAll(FingerPrintVerification(), duration: Duration(milliseconds: 300), transition: Transition.rightToLeft);
            } else {
              Get.offAll(BottomNavigationBar1());
            }
          }
        } else {
          Get.offAll(IntroScreenOnboarding(
            introductionList: _list,
            onTapSkipButton: () {
              //Get.offAll(Login(), duration: Duration(milliseconds: 300), transition: Transition.rightToLeft);
            },
          ));
        }
      } else {
        print('=========${UtilService.firstLaunch}');
        if(UtilService.firstLaunch) {
          Get.offAll(IntroScreenOnboarding(
            introductionList: _list,
            onTapSkipButton: () {
              //Get.offAll(Login(), duration: Duration(milliseconds: 300), transition: Transition.rightToLeft);
            },
          ));
        } else {
          Get.offAll(LoginScreen());
        }
      }
    });
  }
}
