import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:crypto_wallet/UI/pages/changePassword/setNewPassword.dart';
import 'package:crypto_wallet/UI/common_widgets/inputFields.dart';

import '../../../constants/colors.dart';
import '../../../controllers/appController.dart';
import '../../../services/apiService.dart';
import '../../../services/utilServices.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../../common_widgets/commonWidgets.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final appController = Get.find<AppController>();
  TextEditingController oldPassController = TextEditingController();
  final oldPassError = ''.obs;
  TextEditingController newPassController = TextEditingController();
  final passError = ''.obs;

  TextEditingController confirmPassController = TextEditingController();
  final confirmPassError = ''.obs;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: primaryColor.value,

              // Status bar brightness (optional)
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
            elevation: 0,
          ),
        ),
        backgroundColor: primaryColor.value,
        body: Obx(
              () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 100,
                  padding: EdgeInsets.only(top: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CommonWidgets().appBar(hasBack: true, title: 'Change Password'),
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
                  constraints: BoxConstraints(minHeight: Get.height - 100, minWidth: Get.width),
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
                            'Change Password',
                            style: TextStyle(
                              color: headingColor.value,
                              fontFamily: 'sfpro',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: 26.0,
                              letterSpacing: 0.36,
                            ),
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // Text(
                          //   'Enter your old password below to be able to set new password.',
                          //   style: TextStyle(fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 16.0, letterSpacing: 0.37, color: labelColor.value),
                          // ),
                          SizedBox(
                            height: 24,
                          ),
                          InputFieldPassword(
                            headerText: 'Old Password',
                            svg: 'Lock',
                            hintText: '• • • • • • • •',
                            textController: oldPassController,
                            onChange: (v) {
                              oldPassError.value = '';
                            },
                          ),
                          CommonWidgets.showErrorMessage(oldPassError.value),
                          SizedBox(
                            height: 10,
                          ),

                          InputFieldPassword(
                            headerText: 'New Password',
                            svg: 'Lock',
                            hintText: '• • • • • • • •',
                            textController: newPassController,
                            onChange: (v) {
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
                            onChange: (v) {
                              confirmPassError.value = '';
                            },
                          ),
                          CommonWidgets.showErrorMessage(confirmPassError.value),

                        ],
                      ),
                      Column(
                        children: [
                          BottomRectangularBtn(onTapFunc: () {
                            verifyFields();
                          }, btnTitle: 'Change Password',
                            loadingText: 'Processing...',
                            isLoading: appController.changePassLoader.value,
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
      ),
    );
  }

  verifyFields(){
    if(oldPassController.text.trim() == ''){
      oldPassError.value = 'Please enter the previous password';
    } else if (newPassController.text.length < 8) {
      passError.value = 'Minimum length should be 8';
    } else if (!lowerCase.hasMatch(newPassController.text)) {
      passError.value = 'Minimum 1 lowercase character required';
    } else if (!upperCase.hasMatch(newPassController.text)) {
      passError.value = 'Minimum 1 uppercase character required';
    } else if (!containsNumber.hasMatch(newPassController.text)) {
      passError.value = 'Minimum 1 digit required';
    } else if (!hasSpecialCharacters.hasMatch(newPassController.text)) {
      passError.value = 'Minimum 1 special character required';
    } else if(newPassController.text != confirmPassController.text) {
      confirmPassError.value = 'Passwords do not match';
    } else {
      ApiService().changePass(pass: newPassController.text,oldPass: oldPassController.text).then((value) {
        if(value == 'OK'){
          UtilService().showToast('Updated Successfully',color: greenCardColor.value);
          Get.back();
        }
      });
    }

  }
}
