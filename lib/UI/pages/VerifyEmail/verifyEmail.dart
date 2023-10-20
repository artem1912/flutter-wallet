import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

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
import '../enterNewPassword.dart';
import '../forgotPass/forgotPass.dart';
import '../login/login.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key, required this.email, required this.fromPage}) : super(key: key);
  final String email;
  final String fromPage;
  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {

  final appController = Get.find<AppController>();
  final defaultPinTheme = PinTheme(
    width: 40,
    height: 45,
    textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(10),
    ),
  );
  var otpErr = ''.obs;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * (2 * 60);
  bool hasEnded = false;

  @override
  Widget build(BuildContext context) {
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: primaryColor.value),
      borderRadius: BorderRadius.circular(8),
    );
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
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
                    height: 22,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor.value,
                    ),
                    child: Icon(
                      Icons.email_outlined,
                      color: Color(0xff0000000),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Please check your email.",
                        style: TextStyle(
                          color: headingColor.value,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          fontFamily: "sfpro",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "We've sent a code to ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: headingColor.value,
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          fontFamily: "sfpro",
                        ),
                      ),
                      Text(
                        " ${widget.email}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: headingColor.value,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: "sfpro",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 42,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Pinput(
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onChanged: (val) => otpErr.value = '',
                        onCompleted: (pin) => verifyOTP(pin: pin),
                      )
                    ],
                  ),
                  CommonWidgets.showErrorMessage(otpErr.value),
                  SizedBox(
                    height: 42,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      CountdownTimer(
                        endTime: endTime,
                        widgetBuilder: (_, CurrentRemainingTime? time) {
                          return Text.rich(
                            TextSpan(text: "Time left: ", style: TextStyle(color: placeholderColor, fontSize: 14, fontFamily: 'sfpro'), children: [
                              TextSpan(
                                  text: "${time?.min ?? 0}:${time?.sec ?? 0}",
                                  style: TextStyle(color: inputFieldTextColor.value, fontSize: 16, fontFamily: 'sfpro'),
                                  recognizer: TapGestureRecognizer()..onTap = () {}),
                            ]),
                          );
                        },
                        onEnd: () {
                          if (mounted)
                            setState(() {
                              hasEnded = true;
                            });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text.rich(
                          TextSpan(text: "Didn't get Code? ", style: TextStyle(color: headingColor.value,
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            fontFamily: "sfpro",), children: [
                            TextSpan(
                                text: "Click to resend.",
                                style: TextStyle(color: hasEnded == true ? primaryColor.value : placeholderColor, fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "sfpro",),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    if (hasEnded == true) {
                                      if(widget.fromPage == 'forgot'){
                                        ApiService().forgotPassword(email: widget.email).then((value) {

                                        });
                                      } else {
                                        await ApiService().resendOTP(email: widget.email).then((value) {
                                          if (value == 'OK') {
                                            UtilService().showToast('Otp Sent Successfully!', color: Color(0xFF00D339));
                                            setState(() {
                                              endTime = DateTime.now().millisecondsSinceEpoch + 1000 * (2 * 60);
                                            });
                                          }
                                        });
                                      }
                                      setState(() {
                                        endTime = DateTime.now().millisecondsSinceEpoch + 1000 * (2 * 60);
                                        hasEnded = false;
                                      });
                                    }
                                  }),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  verifyOTP({String? pin}) async {

    if (widget.fromPage == 'forgot') {
      ApiService().verifyOtpForForgotPassword(email: widget.email, code: pin!).then((value) async {
        if (value == 'OK') {
          Get.to(EnterNewPassword());
        }
      });
    } else {
      await ApiService().verifyEmail(otp: pin,email: widget.email).then((value) {
        if(value == 'OK'){
          Get.offAll(BottomNavigationBar1());
        } else {

        }
      });
    }
  }

}
