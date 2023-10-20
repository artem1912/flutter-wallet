import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../controllers/appController.dart';
import '../../../services/apiService.dart';
import '../../../services/uploadMediaService.dart';
import '../../../services/utilServices.dart';
import '../../bottomNavBar/BottomNavBar.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../../common_widgets/commonWidgets.dart';
import '../../common_widgets/imagePickerActionSheet.dart';
import '../../common_widgets/inputFields.dart';
import '../Signup/singUp.dart';
import '../VerifyEmail/verifyEmail.dart';
import '../forgotPass/forgotPass.dart';
import '../login/login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final appController = Get.find<AppController>();

  TextEditingController emailController = new TextEditingController();
  var emailErr = ''.obs;
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
                    height: 92,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Forgot password",
                        style: TextStyle(
                          color: headingColor.value,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: "sfpro",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 53,
                  ),
                  InputFieldsWithSeparateIcon(
                    textController: emailController,
                    headerText: "Email",
                    onChange: (val){
                      emailErr.value = '';
                    },
                    svg: 'email (3)',
                    hasHeader: true, hintText: 'Email Address',
                  ),
                  CommonWidgets.showErrorMessage(emailErr.value),
                  SizedBox(
                    height: 31,
                  ),
                  BottomRectangularBtn(
                    onTapFunc: (){
                      verifyEmail();
                    }, btnTitle: "Recover your password",
                    color: primaryColor.value,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(LoginScreen());
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: primaryColor.value.withOpacity(0.15), borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Remembered password? ",
                                style: TextStyle(color: headingColor.value, fontSize: 12, fontWeight: FontWeight.w300, fontFamily: "sfpro", height: 1.40),
                              ),
                              Text(
                                "Login",
                                style: TextStyle(color: headingColor.value, fontSize: 12, fontWeight: FontWeight.w700, fontFamily: "sfpro", height: 1.40),
                              ),
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  verifyEmail() async {
    if(emailController.text.trim() == ''){
      emailErr.value = 'Please enter your email';
    } else if (UtilService().isEmail(emailController.text) == false) {
      emailErr.value = 'Invalid Email.';
    } else {
      ApiService().forgotPassword(email: emailController.text).then((value) {
        if(value == 'OK'){
          Get.to(VerifyEmail(email: emailController.text, fromPage: 'forgot'));
        }
      });
    }
  }

}
