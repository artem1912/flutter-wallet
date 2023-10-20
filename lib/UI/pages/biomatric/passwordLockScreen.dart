import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/UI/common_widgets/inputFields.dart';
import 'package:crypto_wallet/controllers/appController.dart';

import '../../bottomNavBar/BottomNavBar.dart';
import '../../common_widgets/commonWidgets.dart';


class PasswordLockScreen extends StatefulWidget {
  const PasswordLockScreen({Key? key, required this.fromPage}) : super(key: key);
  final String fromPage;
  @override
  State<PasswordLockScreen> createState() => _PasswordLockScreenState();
}

class _PasswordLockScreenState extends State<PasswordLockScreen> {
  final appController = Get.find<AppController>();
  TextEditingController passController = TextEditingController();
  final passError = ''.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
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
                        height: 60,
                        width: 100,
                        child: SvgPicture.asset(
                          "assets/svgs/keyImage.svg",
                          color: primaryColor.value,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InputFieldPassword(
                        headerText: '',
                        svg: 'Lock',
                        hintText: '• • • • • • • •',
                        textController: passController,
                        onChange: () {
                          passError.value = '';
                          if(passController.text.trim() != '') {
                            _onChangeHandler();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                CommonWidgets.showErrorMessage(passError.value),
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Text(
                      'Use Touch ID',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 16.0, letterSpacing: 0.37, color: primaryColor.value),
                    ),
                  ),
                ),
                SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
  late Timer searchOnStoppedTyping = new Timer(Duration(milliseconds: 1), () {});

  _onChangeHandler() {
    const duration = Duration(milliseconds: 1000); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping.cancel()); // clear timer
    }
    setState(() => searchOnStoppedTyping = new Timer(duration, () {
      if (passController.text.trim() != '') {
        if(passController.text == appController.password.value){
          if(widget.fromPage == 'wallets'){
            Get.back(result: 'authenticated');
            Get.back(result: 'authenticated');
          } else {
            Get.offAll(BottomNavigationBar1(), duration: Duration(milliseconds: 300), transition: Transition.rightToLeft);
          }
        } else {
          passError.value = 'Incorrect Password';
        }
      }
    }));
  }
}
