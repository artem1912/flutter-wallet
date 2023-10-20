import 'dart:io';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constants/colors.dart';
import '../../../controllers/appController.dart';
import '../../../services/apiService.dart';
import '../../../services/utilServices.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../../common_widgets/commonWidgets.dart';
import '../../common_widgets/inputFields.dart';
import '../VerifyEmail/verifyEmail.dart';
import '../login/login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final appController = Get.find<AppController>();

  TextEditingController fNameController = new TextEditingController();
  TextEditingController lNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController confirmPassController = new TextEditingController();
  var fNameError = ''.obs;
  var lNameError = ''.obs;
  var nameError = ''.obs;
  var emailError = ''.obs;
  var passError = ''.obs;
  var confirmPassError = ''.obs;
  var currencyError = ''.obs;
  var checkBoxErr = ''.obs;

  var checkBox = false.obs;
  final jobRoleCtrl = TextEditingController();
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
            padding: const EdgeInsets.only(left: 29.0,right:29.0,),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Signup",
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
                    height: 46,
                  ),
                  InputFieldsWithSeparateIcon(headerText: "First name", hintText: "First name",svg: 'userfield (2)', onChange: (val) {
                    if(val != null && val != ''){
                      fNameError.value = '';
                    }
                  },textController: fNameController, hasHeader: true,),
                  CommonWidgets.showErrorMessage(fNameError.value),
                  InputFieldsWithSeparateIcon(headerText: "Last name", hintText: "Last name",svg: 'userfield (2)', onChange: (val) {
                    if(val != null && val != ''){
                      lNameError.value = '';
                    }
                  },textController: lNameController, hasHeader: true,),
                  CommonWidgets.showErrorMessage(lNameError.value),
                  InputFieldsWithSeparateIcon(headerText: "Email", hintText: "Email Address",svg: 'email (3)', onChange: (val) {
                    if(val != null && val != ''){
                      emailError.value = '';
                    }
                  },textController: emailController, hasHeader: true,),
                  CommonWidgets.showErrorMessage(emailError.value),

                  InputFieldPassword(headerText: "Password",svg: 'Lock', hintText: "********", onChange: (value) {
                    if(value != null && value != ''){
                      passError.value = '';
                    }
                  }, textController: passController,),
                  CommonWidgets.showErrorMessage(passError.value),

                  InputFieldPassword(headerText: "Confirm Password",svg: 'Lock', hintText: "********", onChange: (value) {
                    if(value != null && value != ''){
                      confirmPassError.value = '';
                    }
                  }, textController: confirmPassController,),
                  CommonWidgets.showErrorMessage(confirmPassError.value),

                  appController.currenciesLoader.value == true?
                  Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(0.25),
                    highlightColor: Colors.grey.withOpacity(0.5),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      width: Get.width,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey,
                      ),
                    ),
                  ) : Container(
                    width: Get.width,
                    height: 50,
                    decoration: BoxDecoration(color: inputFieldBackgroundColor.value,borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: CustomDropdown(
                      fieldSuffixIcon: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: headingColor.value,
                      ),
                      listItemStyle: TextStyle(
                        fontFamily: 'sfpro',
                        color: labelColor.value
                      ),
                      fillColor: inputFieldBackgroundColor.value,
                      selectedStyle: TextStyle(
                        color: placeholderColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'sfpro',
                      ),
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: 'sfpro',
                          color: placeholderColor),
                      hintText: 'Select Currency',
                      items: appController.selectCurrenciesList,
                      controller: jobRoleCtrl,
                      onChanged: (v){
                        print(' $v');
                        jobRoleCtrl.text = v;
                        setState(() {});
                        currencyError.value = '';
                      },
                    ),
                  ),
                  CommonWidgets.showErrorMessage(currencyError.value),
                  Row(
                    children: [
                      Checkbox(
                          activeColor: primaryColor.value,
                          checkColor: headingColor.value,
                          focusColor: headingColor.value,
                          hoverColor: headingColor.value,
                          value: checkBox.value,
                          onChanged: (bool? value) {
                            checkBox.value = value!;
                            checkBoxErr.value = '';
                          }),
                      Row(
                        children: [
                          Text(
                            "I agree to all the ",
                            style: TextStyle(color: headingColor.value, fontSize: 12, fontWeight: FontWeight.w300, fontFamily: "sfpro", height: 1.40),
                          ),
                          GestureDetector(
                            onTap: (){
                              UtilService().launchURL(context, '');
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Text(
                                "Terms & Conditions",
                                style: TextStyle(color: headingColor.value, fontSize: 12, fontWeight: FontWeight.w700, fontFamily: "sfpro", height: 1.40),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  CommonWidgets.showErrorMessage(checkBoxErr.value),

                  BottomRectangularBtn(onTapFunc: (){
                    verifyFields();

                  }, btnTitle: "Create Account",
                    color: primaryColor.value,
                    loadingText: 'Creating account...',
                    isLoading: appController.registerLoader.value,
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
                      decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(color: headingColor.value, fontSize: 12, fontWeight: FontWeight.w300, fontFamily: "sfpro", height: 1.40),
                            ),
                            Text(
                              " Sign In",
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
    print(jobRoleCtrl.text);
    if(fNameController.text.trim() == ''){
      fNameError.value = 'Please enter your first name.';
    } else if(lNameController.text.trim() == ''){
      lNameError.value = 'Please enter your last name.';
    } else if (emailController.text.trim() == '') {
      emailError.value = 'Please enter your email.';
    } else if (UtilService().isEmail(emailController.text) == false) {
      emailError.value = 'Invalid Email.';
    }  else if (passController.text.length < 8) {
      passError.value = 'Minimum length should be 8.';
    } else if (!lowerCase.hasMatch(passController.text)) {
      passError.value = 'Minimum 1 lowercase character required.';
    } else if (!upperCase.hasMatch(passController.text)) {
      passError.value = 'Minimum 1 uppercase character required.';
    } else if (!containsNumber.hasMatch(passController.text)) {
      passError.value = 'Minimum 1 digit required.';
    } else if (!hasSpecialCharacters.hasMatch(passController.text)) {
      passError.value = 'Minimum 1 special character required.';
    } else if(passController.text != confirmPassController.text) {
      confirmPassError.value = 'Passwords do not match.';
    } else if(jobRoleCtrl.text.trim() == '') {
      currencyError.value = 'Please select your currency.';
    } else if(checkBox.value == false){
      checkBoxErr.value = 'Please accept our terms & conditions.';
    } else {
      ApiService().register(email: emailController.text,pass:passController.text ,name:(fNameController.text + ' '+ lNameController.text),
          currencyID: appController.allCurrenciesList[appController.selectCurrenciesList.indexOf(jobRoleCtrl.text)].id).then((value) {
        if(value == 'OK'){
          Get.to(VerifyEmail(email: emailController.text,fromPage: 'signup',));
        }
      });
    }
  }
}
