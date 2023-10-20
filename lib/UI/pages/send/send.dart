import 'package:crypto_wallet/UI/pages/send/qrScanner.dart';
import 'package:crypto_wallet/models/sendResponseModel.dart';
import 'package:crypto_wallet/services/apiService.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../models/coinsModel.dart';
import '../../../models/walletBalanceModel.dart';
import '../../../services/utilServices.dart';
import '../../common_widgets/inputFields.dart';
import '../../../controllers/appController.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../../common_widgets/commonWidgets.dart';

class Send extends StatefulWidget {
  Send({Key? key, required this.selectedToken}) : super(key: key);
  final Balance selectedToken;

  @override
  State<Send> createState() => _SendState();
}

class _SendState extends State<Send> {
  final appController = Get.find<AppController>();

  var isChecked = false.obs;
  var checkBoxErr = ''.obs;
  TextEditingController amountController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var nameError = ''.obs;
  var amountErr = ''.obs;
  var addressErr = ''.obs;

  int selectedPercentage = 0;

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
                    CommonWidgets().appBar(hasBack: true, title: 'Send'),
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
                        Container(
                          width: Get.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Available Balance',
                                style: TextStyle(
                                    fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 16.0, letterSpacing: 0.37, color: labelColor.value),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${UtilService().toFixed2DecimalPlaces((widget.selectedToken.balance ?? 0).toString(), decimalPlaces: 4) + ' ' + (widget.selectedToken.symbol ?? '')}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: headingColor.value,
                                  fontFamily: 'sfpro',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 40.0,
                                  letterSpacing: 0.36,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        InputFieldsWithSeparateIcon(
                          textController: amountController,
                          headerText: 'Amount',
                          hintText: 'Amount',
                          inputType: TextInputType.number,
                          hasHeader: true,
                          onChange: (value) {
                            amountErr.value = '';
                          },
                          svg: 'walletArrow',
                          suffixIcon: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            child: Text(
                              '${widget.selectedToken.symbol ?? ''}',
                              style: TextStyle(
                                  fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 14.0, letterSpacing: 0.37, color: labelColor.value),
                            ),
                          ),
                        ),
                        CommonWidgets.showErrorMessage(amountErr.value),
                        Container(
                          width: Get.width,
                          height: Get.height * 0.042,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  amountController.text = (double.parse((widget.selectedToken.balance ?? 0).toString()) * 0.10).toStringAsFixed(4);
                                  amountController.selection = TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
                                  amountErr.value = '';
                                  setState(() {
                                    selectedPercentage = 10;
                                  });
                                },
                                child: SizedBox(
                                  height: Get.height * 0.045,
                                  width: Get.width * 0.16,
                                  child: Card(
                                    elevation: 0,
                                    color: selectedPercentage == 10
                                        ? chipChoiceColor
                                        : appController.isDark.value
                                            ? lightColor.withOpacity(0.2)
                                            : lightColor,
                                    child: Center(
                                      child: Text(
                                        '10%',
                                        style: TextStyle(
                                          color: selectedPercentage == 10
                                              ? primaryColor.value
                                              : appController.isDark.value
                                                  ? inputFieldTextColor.value
                                                  : Colors.black87,
                                          fontFamily: 'sfpro',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  amountController.text = (double.parse((widget.selectedToken.balance ?? 0).toString()) * 0.25).toStringAsFixed(4);
                                  amountController.selection = TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
                                  amountErr.value = '';
                                  setState(() {
                                    selectedPercentage = 25;
                                  });
                                },
                                child: SizedBox(
                                  height: Get.height * 0.045,
                                  width: Get.width * 0.16,
                                  child: Card(
                                    elevation: 0,
                                    color: selectedPercentage == 25
                                        ? chipChoiceColor
                                        : appController.isDark.value
                                            ? lightColor.withOpacity(0.2)
                                            : lightColor,
                                    child: Center(
                                      child: Text(
                                        '25%',
                                        style: TextStyle(
                                          color: selectedPercentage == 25
                                              ? primaryColor.value
                                              : appController.isDark.value
                                                  ? inputFieldTextColor.value
                                                  : Colors.black87,
                                          fontFamily: 'sfpro',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  amountController.text = (double.parse((widget.selectedToken.balance ?? 0).toString()) * 0.5).toStringAsFixed(4);
                                  amountController.selection = TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
                                  amountErr.value = '';
                                  setState(() {
                                    selectedPercentage = 50;
                                  });
                                },
                                child: SizedBox(
                                  height: Get.height * 0.045,
                                  width: Get.width * 0.16,
                                  child: Card(
                                    elevation: 0,
                                    color: selectedPercentage == 50
                                        ? chipChoiceColor
                                        : appController.isDark.value
                                            ? lightColor.withOpacity(0.2)
                                            : lightColor,
                                    child: Center(
                                      child: Text(
                                        '50%',
                                        style: TextStyle(
                                          color: selectedPercentage == 50
                                              ? primaryColor.value
                                              : appController.isDark.value
                                                  ? inputFieldTextColor.value
                                                  : Colors.black87,
                                          fontFamily: 'sfpro',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  amountController.text = (double.parse((widget.selectedToken.balance ?? 0).toString()) * 0.75).toStringAsFixed(4);
                                  amountController.selection = TextSelection.fromPosition(TextPosition(offset: amountController.text.length));
                                  amountErr.value = '';
                                  setState(() {
                                    selectedPercentage = 75;
                                  });
                                },
                                child: SizedBox(
                                  height: Get.height * 0.045,
                                  width: Get.width * 0.16,
                                  child: Card(
                                    elevation: 0,
                                    color: selectedPercentage == 75
                                        ? chipChoiceColor
                                        : appController.isDark.value
                                            ? lightColor.withOpacity(0.2)
                                            : lightColor,
                                    child: Center(
                                      child: Text(
                                        '75%',
                                        style: TextStyle(
                                          color: selectedPercentage == 75
                                              ? primaryColor.value
                                              : appController.isDark.value
                                                  ? inputFieldTextColor.value
                                                  : Colors.black87,
                                          fontFamily: 'sfpro',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: Text(
                            'Recipient Address',
                            style: TextStyle(
                              color: headingColor.value,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'sfpro',
                            ),
                          ),
                        ),
                        SizedBox(height: 16,),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                cursorColor: primaryColor.value,
                                cursorHeight: 20,
                                controller: addressController,
                                style: TextStyle(fontSize: 14, fontFamily: 'sfpro', color: inputFieldTextColor.value),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 14, fontFamily: 'sfpro', color: appController.isDark.value ? labelColor.value : placeholderColor),
                                  filled: true,
                                  fillColor: inputFieldBackgroundColor.value,
                                  hintText: '0x000...000',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                                    borderSide: BorderSide(color: cardColor.value, width: 0.1),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                                    borderSide: BorderSide(color: cardColor.value, width: 0.1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                                    borderSide: BorderSide(color: cardColor.value, width: 0.1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: cardColor.value, width: 0.1),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                            CommonWidgets.showErrorMessage(addressErr.value),
                            SizedBox(
                              width: 4,
                            ),
                            GestureDetector(
                              onTap: () async {
                                ScanQr();
                              },
                              child: Container(
                                width: 60,
                                height: 58,
                                decoration: BoxDecoration(
                                  color: inputFieldBackgroundColor.value,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/svgs/qr-scanner-m.svg',
                                    color: placeholderColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        /*Row(
                          children: [
                            Theme(
                              data: ThemeData(unselectedWidgetColor: lightColor),
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
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                                  side: BorderSide(color: primaryColor.value, width: 1.0)),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                color: Colors.transparent,
                                child: Text(
                                  'Save recipient',
                                  style: TextStyle(
                                    fontFamily: 'Mont',
                                    color: placeholderColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        CommonWidgets.showErrorMessage(checkBoxErr.value),
                        InputFields(
                          textController: nameController,
                          headerText: '',
                          hintText: 'Recipient Name',
                          hasHeader: true,
                          onChange: (value) {
                            nameError.value = '';
                          },
                        ),
                        CommonWidgets.showErrorMessage(nameError.value),*/
                      ],
                    ),
                    Column(
                      children: [
                        BottomRectangularBtn(
                          onTapFunc: () {
                            if(appController.withdrawCryptoLoader.value  == false){
                              verifyFields();
                            }
                          },
                          btnTitle: 'Send',
                          loadingText: 'Sending...',
                          isLoading: appController.withdrawCryptoLoader.value,
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

  _showDialogBox(BuildContext context, SendResponseModel txHash) {
    return Get.defaultDialog(
        backgroundColor: cardColor.value,
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        title: "",
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 445,
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 41),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.selectedToken.symbol}',
                          style: TextStyle(
                            color: headingColor.value,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'sfpro',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${amountController.text}',
                          style: TextStyle(
                            color: headingColor.value,
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'sfpro',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$${widget.selectedToken.price}',
                          style: TextStyle(
                            color: headingColor.value,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'sfpro',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    DottedLine(
                      direction: Axis.horizontal,
                      lineLength: double.infinity,
                      lineThickness: 1.0,
                      dashLength: 4.0,
                      dashColor: labelColor.value,
                      dashRadius: 0.0,
                      dashGapLength: 4.0,
                      dashGapColor: dividerColor.value,
                      dashGapGradient: [primaryBackgroundColor.value, primaryBackgroundColor.value],
                      dashGapRadius: 0.0,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date',
                          style: TextStyle(
                            color: labelColor.value,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'sfpro',
                          ),
                        ),
                        Text(
                          '${DateTime.now().day.toString() + '-' + DateTime.now().month.toString() + '-' + DateTime.now().year.toString()}',
                          style: TextStyle(
                            color: headingColor.value,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'sfpro',
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Status',
                          style: TextStyle(
                            color: labelColor.value,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'sfpro',
                          ),
                        ),
                        Text(
                          'Pending',
                          style: TextStyle(
                            color: headingColor.value,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'sfpro',
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recipient Address',
                          style: TextStyle(
                            color: labelColor.value,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'sfpro',
                          ),
                        ),
                        Text(
                          '${addressController.text.substring(0, 5) + '...' + addressController.text.substring(addressController.text.length - 4)}',
                          //'0x000...000',
                          style: TextStyle(
                            color: headingColor.value,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'sfpro',
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 25),
                    DottedLine(
                      direction: Axis.horizontal,
                      lineLength: double.infinity,
                      lineThickness: 1.0,
                      dashLength: 4.0,
                      dashColor: labelColor.value,
                      dashRadius: 0.0,
                      dashGapLength: 4.0,
                      dashGapColor: dividerColor.value,
                      dashGapGradient: [primaryBackgroundColor.value, primaryBackgroundColor.value],
                      dashGapRadius: 0.0,
                    ),
                    SizedBox(height: 25),
                    // Container(
                    //   height: 44,
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(color: dividerColor.value, borderRadius: BorderRadius.circular(10)),
                    //   child: Center(
                    //     child: Text(
                    //       'View on Blockchain',
                    //       style: TextStyle(
                    //         color: Color(0xff030319),
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w400,
                    //         fontFamily: 'sfpro',
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                  ],
                ),
              ),
              Positioned.fill(
                  top: -475,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Center(
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(color: iconDownColor, shape: BoxShape.circle, border: Border.all(width: 5, color: primaryBackgroundColor.value)),
                        child: Icon(
                          Icons.check,
                          color: primaryBackgroundColor.value,
                          size: 30,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }

  verifyFields() async {
    if (amountController.text.trim() == '') {
      amountErr.value = 'Please enter amount';
    } else if (double.parse(amountController.text) <= 0.0 || double.parse(amountController.text) > double.parse((widget.selectedToken.balance ?? 0).toString())) {
      amountErr.value = 'Please enter sufficient amount';
    } else if (addressController.text.isEmpty) {
      amountErr.value = 'Please enter address';
    } else if (amountController.text.isEmpty) {
      amountErr.value = 'Please enter amount';
    } else if (amountController.text.trim() == '') {
      amountErr.value = 'Please enter amount';
    } else {

      ApiService().withdrawCrypto(address: addressController.text, amount: amountController.text,coinId: widget.selectedToken.coinId,networkId: widget.selectedToken.networkId).then((value) {
        if (value != null ) {
          amountController.clear();
          addressController.clear();
          selectedPercentage = 0;
          setState(() {});
          _showDialogBox(context, value);
        }

        ApiService().getWalletWithBalance();

      });
    }
  }

  Future<void> ScanQr() async {
    addressController.text = 'Receiver address';
    setState(() {});
    Get.to(QrScanner(), duration: Duration(milliseconds: 300), transition: Transition.rightToLeft)?.then((value) {
      print("Coming Back From Qr :$value");
      if (value != null && value != 'null') {
        addressErr.value = '';
        if (value.contains('ethereum:')) {
          List<String> cutText = [];
          cutText = value.split("ethereum:");
          addressController.text = cutText[1];
          setState(() {});
        } else {
          addressController.text = value;
          setState(() {});
        }
      } else {
        addressController.clear();
        setState(() {});
      }
    });
  }
}
