
import 'package:crypto_wallet/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../constants/constants.dart';
import '../../../services/utilServices.dart';
import '../../common_widgets/inputFields.dart';
import '../../../controllers/appController.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../../common_widgets/commonWidgets.dart';
import '../userDetails/userDetails.dart';

class WithdrawFiat extends StatefulWidget {
  const WithdrawFiat({Key? key}) : super(key: key);

  @override
  State<WithdrawFiat> createState() => _WithdrawFiatState();
}

class _WithdrawFiatState extends State<WithdrawFiat> {
  final appController = Get.find<AppController>();
  var amountErrBox = ''.obs;
  var bankNameErrBox = ''.obs;
  var accountNumErrBox = ''.obs;
  var amountFiatErrBox = ''.obs;
  var accountNameErrBox = ''.obs;
  var userGets = '0'.obs;

  TextEditingController bankNameController = new TextEditingController();
  TextEditingController accountNameController = new TextEditingController();
  TextEditingController accountNumController = new TextEditingController();
  TextEditingController amountFiatController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    bankNameController.text = appController.user.value.bankName ?? '';
    accountNameController.text = appController.user.value.accountName ?? '';
    accountNumController.text = appController.user.value.accountNumber ?? '';
    super.initState();
    ApiService().getFee();
  }

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
                    CommonWidgets().appBar(hasBack: true, title: 'Withdraw'),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric( vertical: 20),
                      decoration: BoxDecoration(color: primaryBackgroundColor.value, borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 35,
                          ),

                          Text(
                            "Withdraw to Bank",
                            style: TextStyle(color: headingColor.value, fontSize: 19, fontWeight: FontWeight.w600, fontFamily: "sfpro", height: 1.40),
                          ),
                          Text(
                            "Withdraw to your bank account",
                            style: TextStyle(color: headingColor.value, fontSize: 10, fontWeight: FontWeight.w400, fontFamily: "sfpro", height: 1.40),
                          ),
                          SizedBox(
                            height: 55,
                          ),
                          InputFields(
                            headerText: "Bank name",
                            hintText: "",
                            textController: bankNameController,
                            suffixIcon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(UserDetails())!.then((value) => assignUserData());
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    padding: EdgeInsets.all(7),
                                    child: Text(
                                      "Edit?",
                                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: labelColor.value),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onChange: (val) {
                              bankNameErrBox.value = '';
                            }, hasHeader: true,
                          ),
                          CommonWidgets.showErrorMessage(bankNameErrBox.value),
                          InputFields(
                            headerText: "Account number",
                            textController: accountNumController,
                            hintText: "",
                            suffixIcon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(UserDetails())!.then((value) => assignUserData());
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Text(
                                      "Edit?",
                                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: labelColor.value),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onChange: (val) {
                              accountNumErrBox.value = '';
                            }, hasHeader: true,
                          ),
                          CommonWidgets.showErrorMessage(accountNumErrBox.value),
                          InputFields(
                            headerText: "Account title",
                            textController: accountNameController,
                            hintText: "${appController.user.value.accountName ?? ''}",
                            suffixIcon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(UserDetails())!.then((value) => assignUserData());
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Text(
                                      "Edit?",
                                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: labelColor.value),
                                    ),
                                  ),
                                ),
                              ],
                            ), hasHeader: true, onChange: (val) {
                            accountNameErrBox.value = '';
                          },),
                          CommonWidgets.showErrorMessage(accountNameErrBox.value),
                          InputFields(
                            textController: amountFiatController,
                            headerText: "Amount",
                            inputType: TextInputType.number,
                            onChange: (val) {
                              if (val == '') {
                                userGets.value = '0';
                              } else {
                                calculateAmount();
                              }
                              amountErrBox.value = '';
                            }, hintText: '', hasHeader: true,
                          ),
                          CommonWidgets.showErrorMessage(amountErrBox.value),
                          Row(
                            children: [
                              Text(
                                "Available ${appController.user.value.currency?.symbol}${formatter2.format(num.parse(UtilService().toFixed2DecimalPlaces((appController.userBalance.value.wallet?.currentSwappedBalance ?? 0).toString(),
                                    decimalPlaces: 4)))}",
                                style: TextStyle(
                                  color: headingColor.value,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "sfpro",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Platform Fee",
                                    style: TextStyle(
                                        fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 12.0, letterSpacing: 0.44, color: placeholderColor),
                                  ),
                                ],
                              ),
                              appController.getFeeLoader.value == true
                                  ? CommonWidgets.loadingShimmer()
                                  : Text(
                                '${appController.platFormFeeList[appController.platFormFeeList.indexWhere((element) => element.feeName == 'withdraw_fiat_fee')].feePercentage??0} %',
                                style: TextStyle(
                                    fontFamily: 'sfpro',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                    letterSpacing: 0.44,
                                    color: headingColor.value),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Recipient gets",
                            style: TextStyle(
                              color: headingColor.value,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              fontFamily: "sfpro",
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${appController.user.value.currency?.symbol} ${userGets.value}",
                            style: TextStyle(
                              color: headingColor.value,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: "sfpro",
                            ),
                          ),
                          SizedBox(
                            height: 23,
                          ),
                          BottomRectangularBtn(
                            color: primaryColor.value,
                            onTapFunc: () {
                              if(appController.withdrawFiatLoader.value == false){
                                verifyFieldsForWithdraw();
                              }
                            },
                            btnTitle: 'Withdraw',
                            loadingText: 'Processing...',
                            isLoading: appController.withdrawFiatLoader.value,
                          ),
                        ],
                      ),
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
  verifyFieldsForWithdraw() {
    if (bankNameController.text.trim() == '') {
      bankNameErrBox.value = "Please enter the bank's name";
    } else if (accountNumController.text.trim() == '') {
      accountNumErrBox.value = "Please enter the account number";
    } else if (accountNameController.text.trim() == '') {
      accountNameErrBox.value = "Please enter the account title";
    } else if (amountFiatController.text.trim() == '') {
      amountErrBox.value = 'Please enter the amount';
    } else if (double.parse(amountFiatController.text) <= 0) {
      amountErrBox.value = 'Amount should be greater than 0';
    } else {
      ApiService()
          .withdrawFiat(bankName: bankNameController.text, accountName: accountNameController.text, accountNumber: accountNumController.text, amount: amountFiatController.text)
          .then((value) {
        if (value == 'OK') {
          //Get.back();
          //Get.to(TransactionCompleted());
          UtilService().showToast('Transaction Successful!',color: Color(0xFF00D339));
          ApiService().getWalletWithBalance(showLoader: true);
        } else {
          //Get.back();
          //Get.to(TransactionFailed(msg: value,));

          UtilService().showToast('Transaction Failed!',color: redCardColor.value);
        }
        bankNameController.clear();
        accountNameController.clear();
        accountNumController.clear();
        amountFiatController.clear();
        userGets.value = '0';
        setState(() {

        });
      });
    }
  }
  assignUserData(){
    bankNameController.text = appController.user.value.bankName ?? '';
    accountNameController.text = appController.user.value.accountName ?? '';
    accountNumController.text = appController.user.value.accountNumber ?? '';
    setState(() {

    });
  }
  calculateAmount() {
    if(amountFiatController.text.trim() == ''){
      userGets.value = '0';
    } else {
      if(num.parse(amountFiatController.text)>0) {
        if(appController.getFeeLoader.value ==false && appController.platFormFeeList.isNotEmpty){
          print((appController.platFormFeeList[appController.platFormFeeList.indexWhere((element)
          => element.feeName == 'withdraw_fiat_fee')].feePercentage??1)/100);
          userGets.value = (num.parse(amountFiatController.text)
              - (num.parse(amountFiatController.text) *
                  ((appController.platFormFeeList[appController.platFormFeeList.indexWhere((element)
                  => element.feeName == 'withdraw_fiat_fee')].feePercentage??1)/100))).toString();
        } else {
          userGets.value = '0';
        }
      } else {
        userGets.value = '0';
      }
    }
  }
}
