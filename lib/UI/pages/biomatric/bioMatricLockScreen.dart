import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:crypto_wallet/UI/pages/biomatric/passwordLockScreen.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:local_auth/local_auth.dart';

import '../../bottomNavBar/BottomNavBar.dart';

class BioMatricLockScreen extends StatefulWidget {
  BioMatricLockScreen({Key? key,this.fromPage}) : super(key: key);
  String? fromPage;

  @override
  State<BioMatricLockScreen> createState() => _BioMatricLockScreenState();
}

class _BioMatricLockScreenState extends State<BioMatricLockScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  @override
  void initState() {
    // TODO: implement initState
    authenticate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor.value,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color(0x0D27C19F)),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Welcome Back!',
                style: TextStyle(fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, fontSize: 26.0, letterSpacing: 0.37, color: headingColor.value),
              ),

              // SizedBox(height: 100),

              Column(
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      child: SvgPicture.asset(
                        "assets/svgs/biometric.svg",
                        color: primaryColor.value,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Touch ID to Open Crypto Wallet',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 16.0, letterSpacing: 0.37, color: primaryColor.value),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(PasswordLockScreen(fromPage: widget.fromPage??'',));
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Text(
                        'Use Password',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 16.0, letterSpacing: 0.37, color: primaryColor.value),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      authenticate();
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Text(
                        'Try Again!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 16.0, letterSpacing: 0.37, color: primaryColor.value),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  authenticate() async {
    try {
      final bool didAuthenticate = await auth
          .authenticate(
        localizedReason: 'Please authenticate to show account balance',
        options: const AuthenticationOptions(useErrorDialogs: false, stickyAuth: true),
      )
          .then((value) {
        print('value==========$value');
        if (value == true) {
          if(widget.fromPage == 'wallets'){
            Get.back(result: 'authenticated');
          } else {
            Get.offAll(BottomNavigationBar1(), duration: Duration(milliseconds: 300), transition: Transition.rightToLeft);
          }
        }
        return value;
      });
      print('didAuth============$didAuthenticate');
      await auth.stopAuthentication();
    } on PlatformException catch (e) {
      print('ex============$e');
    }
  }
}
