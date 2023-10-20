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
import '../forgotPass/forgotPass.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final appController = Get.find<AppController>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  var passErr = ''.obs;
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
            top: false,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(0.0),
                child: AppBar(
                  backgroundColor: primaryBackgroundColor.value,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    // Status bar color
                    statusBarColor: primaryBackgroundColor.value,

                    // Status bar brightness (optional)
                    statusBarIconBrightness: Brightness.light,
                    statusBarBrightness: appController.isDark.value == true ? Brightness.dark : Brightness.light,
                  ),
                  elevation: 0,
                ),
              ),
              backgroundColor: primaryBackgroundColor.value,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29.0, vertical: 26),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 90,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svgs/logo.svg",
                            color: primaryColor.value,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 53,
                      ),
                      InputFieldsWithSeparateIcon(
                        headerText: "Email",
                        hintText: "Email Address",
                        svg: 'email (3)',
                        onChange: (val) {
                          if (val != null && val != '') {
                            emailErr.value = '';
                          }
                        },
                        textController: emailController, hasHeader: true,
                      ),
                      CommonWidgets.showErrorMessage(emailErr.value),
                      InputFieldPassword(
                        headerText: "Password",
                        svg: 'Lock',
                        hintText: '• • • • • • • •',
                        onChange: (val) {
                          if (val != null && val != '') {
                            passErr.value = '';
                          }
                        },
                        textController: passController,
                      ),
                      CommonWidgets.showErrorMessage(passErr.value),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(ForgotPassword());
                            },
                            child: Text(
                              "forgot password?",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                fontFamily: "sfpro",
                                color: headingColor.value,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      BottomRectangularBtn(
                        onTapFunc: () {
                          verifyFields();
                        },
                        btnTitle: 'Log in',
                        loadingText: 'Processing...',
                        isLoading: appController.loginLoader.value,
                        color: primaryColor.value,
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(SignupScreen());
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(color: headingColor.value, fontSize: 12, fontWeight: FontWeight.w300, fontFamily: "sfpro", height: 1.40),
                                ),
                                Text(
                                  " Sign Up",
                                  style: TextStyle(color: primaryColor.value, fontSize: 12, fontWeight: FontWeight.w700, fontFamily: "sfpro", height: 1.40),
                                ),
                              ],
                            ),
                          ),
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


  verifyFields() async {
    if (emailController.text.trim() == '') {
      emailErr.value = 'Please enter your email.';
    } else if (UtilService().isEmail(emailController.text) == false) {
      emailErr.value = 'Invalid Email.';
    } else if (passController.text.trim() == '') {
      passErr.value = 'Please enter your password.';
    } else {
      ApiService().Login(email: emailController.text, pass: passController.text).then((value) {
        if (value == 'OK') {
          // if(appController.user.value.isAuthEnabled == false){
          //   Get.offAll(BottomNavigationBar1());
          // }
          ApiService().getLoggedInUser();
          Get.offAll(BottomNavigationBar1());
        }
      });
    }
  }

}
