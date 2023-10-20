import 'package:crypto_wallet/UI/common_widgets/bottomRectangularbtn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../controllers/appController.dart';
import '../../../services/apiService.dart';
import '../common_widgets/commonWidgets.dart';
import '../common_widgets/inputFields.dart';
import 'login/login.dart';

class EnterNewPassword extends StatefulWidget {
  const EnterNewPassword({Key? key}) : super(key: key);

  @override
  State<EnterNewPassword> createState() => _EnterNewPasswordState();
}

class _EnterNewPasswordState extends State<EnterNewPassword> {

  final appController = Get.find<AppController>();
  var passError = ''.obs;
  var confirmPassError = ''.obs;
  TextEditingController passController = new TextEditingController();
  TextEditingController confirmPassController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => SafeArea(
        child: Scaffold(
          backgroundColor: primaryBackgroundColor.value,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 29.0, vertical: 26),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Container(
                            height: 35,
                            width: 35,
                            color: Colors.transparent,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: headingColor.value,
                            )),
                      ),
                      SvgPicture.asset(
                        "assets/images/splash.svg",
                        height: 44,
                        width: 48,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 67,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Change Your Password",
                        style: TextStyle(
                          color: headingColor.value,
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          fontFamily: "sfpro",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        "Enter your new password below",
                        style: TextStyle(
                          color: headingColor.value,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: "sfpro",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 44,
                  ),
                  InputFieldPassword(
                    headerText: "Password",
                    hintText: "",
                    svg: 'Lock',
                    onChange: (value) {
                      if (value != null && value != '') {
                        passError.value = '';
                      }
                    },
                    textController: passController,
                  ),
                  CommonWidgets.showErrorMessage(passError.value),
                  InputFieldPassword(
                    headerText: "Re-enter password",
                    hintText: "",
                    svg: 'Lock',
                    onChange: (value) {
                      if (value != null && value != '') {
                        confirmPassError.value = '';
                      }
                    },
                    textController: confirmPassController,
                  ),
                  CommonWidgets.showErrorMessage(confirmPassError.value),
                  SizedBox(
                    height: 47,
                  ),
                  BottomRectangularBtn(onTapFunc: (){
                    verifyFields();
                  }, btnTitle: "Reset Password",loadingText: 'Processing...',isLoading: appController.resetPassLoader.value,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  verifyFields() async {
    if (passController.text.length < 8) {
      passError.value = 'Minimum length should be 8';
    } else if (!lowerCase.hasMatch(passController.text)) {
      passError.value = 'Minimum 1 lowercase character required';
    } else if (!upperCase.hasMatch(passController.text)) {
      passError.value = 'Minimum 1 uppercase character required';
    } else if (!containsNumber.hasMatch(passController.text)) {
      passError.value = 'Minimum 1 digit required';
    } else if (!hasSpecialCharacters.hasMatch(passController.text)) {
      passError.value = 'Minimum 1 special character required';
    } else if (passController.text != confirmPassController.text) {
      confirmPassError.value = 'Passwords do not match';
    } else {
      ApiService()
          .resetPass(
        pass: passController.text,
      )
          .then((value) {
        if (value == 'OK') {
          Get.offAll(LoginScreen());
        }
      });
    }
  }

}
