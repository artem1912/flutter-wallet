import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_wallet/UI/pages/userDetails/userDetails.dart';
import 'package:crypto_wallet/models/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:crypto_wallet/UI/pages/changePassword/changePassword.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/colors.dart';
import '../../../controllers/appController.dart';
import '../../../models/coinsModel.dart';
import '../../../models/walletBalanceModel.dart';
import '../../../models/walletsModel.dart';
import '../../../services/apiService.dart';
import '../biomatric/biomatric.dart';
import '../login/login.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _biomatric = true;

  var _theme = false.obs;
  final appController = Get.find<AppController>();
  var processingLoader = false.obs;
  @override
  void initState() {
    // TODO: implement initState
    _theme.value = appController.isDark.value;
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
              systemOverlayStyle: SystemUiOverlayStyle(
                // Status bar color
                statusBarColor: primaryBackgroundColor.value,

                // Status bar brightness (optional)
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
              ),
              elevation: 0,
            ),
          ),
          backgroundColor: primaryBackgroundColor.value,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Settings",
                        style: TextStyle(
                            fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, fontSize: 26.0, letterSpacing: 0.37, color: headingColor.value),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Personalization",
                        style: TextStyle(
                            fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, fontSize: 18.0, letterSpacing: 0.37, color: headingColor.value),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _securityAndThemeContainer(
                      onTap: () {
                        Get.to(UserDetails());
                      },
                      type: "changePassword",
                      leadingIcon: CupertinoIcons.person,
                      title: "Edit Profile",
                      subTitle: "Update your Profile",
                      icon: Icons.navigate_next_sharp,
                      showSwitch: false),
                  _securityAndThemeContainer(
                      onTap: () {
                        showAlertDialog(context);
                      },
                      type: "changePassword",
                      leadingIcon: CupertinoIcons.trash,
                      title: "Delete Profile",
                      subTitle: "Delete your Profile",
                      icon: Icons.navigate_next_sharp,
                      showSwitch: false),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Security",
                        style: TextStyle(
                            fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, fontSize: 18.0, letterSpacing: 0.37, color: headingColor.value),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _securityAndThemeContainer(
                      onTap: () {
                        Get.to(ChangePassword());
                      },
                      type: "changePassword",
                      leadingIcon: CupertinoIcons.lock,
                      title: "Change Password",
                      subTitle: "Security Password",
                      icon: Icons.navigate_next_sharp,
                      showSwitch: false),
                  Divider(thickness: 1, color: Color(0xffF2F2F2)),
                  // SizedBox(height: 5,),

                  _securityAndThemeContainer(
                      onTap: () {
                        //Get.to(BioMatric());
                      },
                      leadingIcon: Icons.fingerprint_outlined,
                      type: "biomatric",
                      title: "Biometric",
                      subTitle: "Unlock with Biometric",
                      showSwitch: true),

                  SizedBox(
                    height: 5,
                  ),

                  Divider(thickness: 1, color: Color(0xffF2F2F2)),

                  SizedBox(
                    height: 5,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "App Theme",
                        style: TextStyle(
                            fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, fontSize: 18.0, letterSpacing: 0.37, color: headingColor.value),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _securityAndThemeContainer(
                      onTap: () {
                        print('jknkjnnkn');
                      },
                      type: "darkmode",
                      leadingIcon: Icons.dark_mode_outlined,
                      title: "Dark Mode",
                      subTitle: "Toggle to switch into Dark Mode",
                      showSwitch: true),

                  SizedBox(
                    height: Get.height * 0.2,
                  ),
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      await prefs.setBool('firstLaunch', false);
                      await prefs.setBool('isDarkMode', appController.isDark.value);
                      appController.shoudApiCallsRun.value = false;
                      appController.user.value = UserModel();
                      appController.userBalance.value = WalletBalanceModel();
                      appController.shouldCallDashboardApi.value = true;
                      Get.offAll(LoginScreen());
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Logout",
                            style: TextStyle(fontSize: 20, color: primaryColor.value),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.login_outlined,
                            color: primaryColor.value,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _securityAndThemeContainer(
      {required String type, required IconData leadingIcon, String? title, String? subTitle, IconData? icon, bool? showSwitch, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 58,
          decoration: BoxDecoration(
            // color:inputFieldBackgroundColor.value,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: primaryColor.value,
                      ),
                      child: Center(
                        child: Icon(
                          leadingIcon,
                          color: primaryBackgroundColor.value,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              '$title',
                              style: TextStyle(
                                fontFamily: 'sfpro',
                                color: headingColor.value,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                letterSpacing: 0.37,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '$subTitle',
                          style: TextStyle(
                            fontFamily: 'sfpro',
                            color: placeholderColor,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                            letterSpacing: 0.44,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                showSwitch == false
                    ? Icon(
                        icon,
                        color: labelColor.value,
                      )
                    : Container(
                        child: type == "darkmode"
                            ? FlutterSwitch(
                                activeText: "",
                                inactiveText: "",
                                activeColor: primaryColor.value,
                                width: 45.0,
                                height: 23.0,
                                valueFontSize: 10.0,
                                toggleSize: 19.0,
                                value: _theme.value,
                                borderRadius: 30.0,
                                padding: 2.0,
                                showOnOff: true,
                                onToggle: (val) async {
                                  _theme.value = val;
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  appController.isDark.value = _theme.value;
                                  await prefs.setBool('isDarkMode', _theme.value);
                                  appController.changeTheme();
                                },
                              )
                            : FlutterSwitch(
                                activeText: "",
                                inactiveText: "",
                                activeColor: primaryColor.value,
                                width: 45.0,
                                height: 23.0,
                                valueFontSize: 10.0,
                                toggleSize: 19.0,
                                value: appController.enabledBiometric.value,
                                borderRadius: 30.0,
                                padding: 2.0,
                                showOnOff: true,
                                onToggle: (val) {
                                  setState(() {
                                    _biomatric = val;
                                    enableBiometric(context, val);
                                  });
                                },
                              ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
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

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget ok = TextButton(
      child: Text(
        "Delete",
        style: TextStyle(
          color: redCardColor.value,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: "sfpro",
        ),
      ),
      onPressed: () {
        deleteProfile();
      },
    );
    Widget cancel = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(
          color: labelColor.value,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: "sfpro",
        ),
      ),
      onPressed: () {
        Get.back();
      },
    );
    Widget processing = Text(
      "Deleting...",
      style: TextStyle(
        color: labelColor.value,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontFamily: "sfpro",
      ),
    );

    // set up the AlertDialog
    var alert = Obx(
      () => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        backgroundColor: primaryBackgroundColor.value,
        title: Text(
          "Delete Profile",
          style: TextStyle(
            color: headingColor.value,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: "sfpro",
          ),
        ),
        content: Text(
          "Are you sure you want to delete your profile?",
          style: TextStyle(
            color: headingColor.value,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: "sfpro",
          ),
        ),
        actions: appController.deleteProfileLoader.value == false
            ? [
                cancel,
                ok,
              ]
            : [processing],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  deleteProfile() async {
    ApiService().deleteProfile().then((value) async {
      if (value == 'OK') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        await prefs.setBool('firstLaunch', false);
        await prefs.setBool('isDarkMode', appController.isDark.value);
        appController.shoudApiCallsRun.value = false;
        appController.user.value = UserModel();
        appController.userBalance.value = WalletBalanceModel();
        appController.shouldCallDashboardApi.value = true;
        Get.offAll(LoginScreen());
      }
    });
  }
}
