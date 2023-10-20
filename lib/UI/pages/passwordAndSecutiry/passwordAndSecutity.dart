import 'package:crypto_wallet/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:crypto_wallet/UI/common_widgets/inputFields.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/colors.dart';
import '../../../controllers/appController.dart';
import '../../../models/userModel.dart';
import '../../../services/sharedPrefs.dart';
import '../../bottomNavBar/BottomNavBar.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../../common_widgets/commonWidgets.dart';

class PasswordAndSecurity extends StatefulWidget {
  PasswordAndSecurity({Key? key,this.fromPage,required this.walletName,this.privateKey,this.type}) : super(key: key);

  final String? fromPage;
  final String walletName;
  final String? privateKey;
  final String? type;

  @override
  State<PasswordAndSecurity> createState() => _PasswordAndSecurityState();
}

class _PasswordAndSecurityState extends State<PasswordAndSecurity> {

  final appController = Get.find<AppController>();
  TextEditingController passController = TextEditingController();
  var passError = ''.obs;
  var isChecked = false.obs;
  TextEditingController confirmPassController = TextEditingController();
  var confirmPassError = ''.obs;
  var checkBoxErr = ''.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.value,
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 110,
                padding: EdgeInsets.only(top: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CommonWidgets().appBar(hasBack: true, title: 'Crypto Wallet'),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                decoration: BoxDecoration(
                  color: primaryBackgroundColor.value,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                constraints: BoxConstraints(minHeight: Get.height - 110, minWidth: Get.width),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          widget.fromPage == 'Settings' ? 'Set New Password' : 'Security Password',
                          style: TextStyle(
                            color: headingColor.value,
                            fontFamily: 'sfpro',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            fontSize: 26.0,
                            letterSpacing: 0.36,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.fromPage == 'Settings' ? '' :'Protection for All Your Wallets & Assets.',
                          style: TextStyle(fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 16.0, letterSpacing: 0.37, color: labelColor.value),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        InputFieldPassword(
                          headerText: 'Password',
                          svg: 'Lock',
                          hintText: '• • • • • • • •',
                          textController: passController,
                          onChange: () {
                            passError.value = '';
                          },
                        ),
                        CommonWidgets.showErrorMessage(passError.value),
                        SizedBox(
                          height: 10,
                        ),
                        InputFieldPassword(
                          headerText: 'Confirm Password',
                          svg: 'Lock',
                          hintText: '• • • • • • • •',
                          textController: confirmPassController,
                          onChange: () {
                            confirmPassError.value = '';
                          },
                        ),
                        CommonWidgets.showErrorMessage(confirmPassError.value),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Biometric',
                              style: TextStyle(fontFamily: 'sfpro', color: headingColor.value),
                            ),
                            Switch(
                              splashRadius: 0.0,
                              value: appController.enabledBiometric.value,
                              activeColor: primaryColor.value,
                              inactiveThumbColor: appController.isDark.value ? inputFieldTextColor.value : lightColor,
                              inactiveTrackColor: placeholderColor.withOpacity(0.65),
                              onChanged: (value) async {
                                //enableBiometric(context, value);
                                setState(() {
                                  enableBiometric(context,value);
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Theme(
                              data: ThemeData(unselectedWidgetColor: lightColor),
                              child: Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                    checkColor: lightColor,
                                    activeColor: primaryColor.value,
                                    value: isChecked.value,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked.value = !isChecked.value;
                                        if (checkBoxErr.value != '') {
                                          checkBoxErr.value = '';
                                        }
                                      });
                                    },
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),),
                                    side: BorderSide(color: primaryColor.value, width: 1.0),),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text('I accept the terms & policy',style: TextStyle(fontFamily: 'sfpro',color: labelColor.value),)
                          ],
                        ),
                        CommonWidgets.showErrorMessage(checkBoxErr.value),
                      ],
                    ),
                    Column(
                      children: [
                        BottomRectangularBtn(onTapFunc: () {
                          if(widget.fromPage == 'Settings'){
                            Get.back();
                          } else {
                            verifyPass();
                          }
                        }, btnTitle: widget.fromPage == 'Settings' ? 'Update Password': widget.fromPage =='Import' ? 'Import Wallet' : 'Create Wallet',
                          loadingText: widget.fromPage =='Import' ? 'Importing Wallet...' : 'Creating Wallet...',
                          isLoading: widget.fromPage =='Import' ? appController.registerWithImportLoader.value : appController.registerLoader.value,
                        ),
                        SizedBox(
                          height: 45,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  verifyPass() async {
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
    } else if(passController.text != confirmPassController.text) {
      confirmPassError.value = 'Passwords do not match';
    } else if(isChecked.value == false){
      checkBoxErr.value = 'Please accept our terms & conditions.';
    } else {
      await ApiService().register(name: widget.walletName,pass: passController.text).then((value) async {
        SharedPref sharedPref = SharedPref();
        final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
        if(value == 'OK'){

          if (await sharedPrefs.containsKey('user')) {
            print('=========>${await sharedPref.readJson('user')}');
            print('=========>${await sharedPrefs.getString('jwtToken')}');
            var json = await sharedPref.readJson('user');
            //appController.user.value = UserModel.fromJson(json);
            UserModel newUser = UserModel.fromJson(json);
            appController.user.value = newUser;
          }
          if (await sharedPrefs.containsKey('pass')) {
            appController.password.value = (await sharedPrefs.getString('pass'))!;

            Get.offAll(BottomNavigationBar1());
          }

        }
      });
    }
  }
  enableBiometric(context, val) async {
    final LocalAuthentication auth = LocalAuthentication();
    final canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final isDeviceSupported = await auth.isDeviceSupported();
    if (isDeviceSupported && canAuthenticateWithBiometrics) {
      try {
        final bool didAuthenticate = await auth
            .authenticate(
          localizedReason: 'Please authenticate to show account balance',
          options: const AuthenticationOptions(useErrorDialogs: false, stickyAuth: true),
        )
            .then((value) async {
          if (value == true) {
            SharedPreferences sharedPref = await SharedPreferences.getInstance();
            await sharedPref.setBool('FingerPrintEnable', val);
            setState(() {
              appController.enabledBiometric.value = val;
            });
          }
          return value;
        });
        print('didAuth============$didAuthenticate');
        await auth.stopAuthentication();
      } on PlatformException catch (e) {
        print('ex============$e');
      }
    } else {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      await sharedPref.setBool('FingerPrintEnable', val);
      setState(() {
        appController.enabledBiometric.value = val;
      });
    }
  }
}
