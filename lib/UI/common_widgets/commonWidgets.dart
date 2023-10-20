import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_wallet/UI/pages/chooseToken/chooseToken.dart';
import 'package:crypto_wallet/models/walletBalanceModel.dart';
import 'package:crypto_wallet/models/walletsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';
import '../../constants/constants.dart';
import '../../controllers/appController.dart';
import '../../models/coinsModel.dart';
import '../../services/apiService.dart';
import '../../services/utilServices.dart';
import '../pages/send/withdrawFiat.dart';
import '../pages/userDetails/userDetails.dart';
import 'bottomRectangularbtn.dart';
import 'inputFields.dart';

class CommonWidgets {
  final appController = Get.find<AppController>();

  TextEditingController amountController = new TextEditingController();
  var amountErrBox = ''.obs;
  var bankNameErrBox = ''.obs;
  var accountNumErrBox = ''.obs;
  var amountFiatErrBox = ''.obs;
  var accountNameErrBox = ''.obs;

  TextEditingController bankNameController = new TextEditingController();
  TextEditingController accountNameController = new TextEditingController();
  TextEditingController accountNumController = new TextEditingController();
  TextEditingController amountFiatController = new TextEditingController();

  static Widget showErrorMessage(String errorMessage) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 4.0, bottom: 2),
      child: Text(
        errorMessage,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 13,
          fontFamily: 'sfpro',
        ),
      ),
    );
  }

  static Widget confirmationDialogUI(context, a1, a2,
      {String? title, String? description, Function? onConfirm}) {
    return Theme(
      data: Theme.of(context).copyWith(dialogBackgroundColor: cardColor.value),
      child: Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: AlertDialog(
            elevation: 10,
            backgroundColor: cardColor.value,
            shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12.0)),
            actionsPadding:
                EdgeInsets.only(left: 18, right: 18, bottom: 18, top: 0),
            title: Center(
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: inputFieldTextColor.value,
                  fontFamily: 'sfpro',
                ),
              ),
            ),
            content: Text(
              description!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 1.4,
                color: inputFieldTextColor.value,
                fontFamily: 'sfpro',
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              Container(
                height: 38,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: primaryColor.value),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: TextButton(
                  child: Text(
                    description.contains('delete') ? 'Cancel' : 'Skip',
                    style: TextStyle(
                      fontSize: 14,
                      color: inputFieldTextColor.value,
                      fontFamily: 'sfpro',
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(width: 4),
              Container(
                height: 38,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: primaryColor.value,
                  border: Border.all(width: 1, color: primaryColor.value),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: TextButton(
                  child: Text(
                    description.contains('delete') ? 'Delete' : "Enable",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'sfpro',
                    ),
                  ),
                  onPressed: () async {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget loadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.black,
      highlightColor: Colors.white.withOpacity(0.75),
      child: Container(
        alignment: Alignment.centerLeft,
        width: 66,
        child: Text(
          'Loading...',
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'sfpro',
              color: inputFieldTextColor.value),
          maxLines: 1,
        ),
      ),
    );
  }

  Widget appBar({
    bool? hasBack,
    String? title,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        children: [
          if (hasBack != false)
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                color: Colors.transparent,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: lightColor,
                ),
              ),
            ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0),
            width: Get.width - (hasBack != false ? 105 : 65),
            child: Text(
              '$title',
              style: TextStyle(
                  fontFamily: 'sfpro',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  fontSize: 26.0,
                  letterSpacing: 0.36,
                  color: lightColor),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Future selectWithdrawBottomSheet(BuildContext context, {Balance? selectedToken}) {
    return Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: primaryBackgroundColor.value,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      Obx(
            () =>
                Container(
                  width: Get.width,
                  //color: primaryBackgroundColor.value,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Withdraw",
                            style: TextStyle(fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, fontSize: 26.0, letterSpacing: 0.44, color: headingColor.value),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.clear,
                                color: headingColor.value,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Please select a method to continue",
                        style: TextStyle(fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, fontSize: 14.0, letterSpacing: 0.44, color: placeholderColor),
                      ),
                      SizedBox(height: 36,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                                Get.to(ChooseToken(fromPage: 'send',));
                                //Get.to(WithdrawUSDT(selectedToken: selectedCoin.value,));
                              },
                              child: Container(
                                height: 100,
                                width: 112,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: primaryColor.value.withOpacity(0.06),
                                    //border: Border.all(color: primaryColor.value,width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.currency_bitcoin,color: primaryColor.value,),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Crypto",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: inputFieldTextColor.value,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "sfpro",
                                          height: 1.40),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 16,),
                            InkWell(
                              onTap: () {
                                Get.back();
                                //CommonWidgets().buildBottomSheetWithDrawBank(context);
                                Get.to(WithdrawFiat());
                              },
                              child: Container(
                                height: 100,
                                width: 112,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: primaryColor.value.withOpacity(0.06),
                                    //border: Border.all(color: primaryColor.value,width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Image.asset(
                                    //     "assets/images/image 131.png"),
                                    Icon(Icons.attach_money,color: primaryColor.value,),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Fiat",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: inputFieldTextColor.value,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "sfpro",
                                          height: 1.40),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
      ),
    );
  }
}
