import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_wallet/UI/common_widgets/bottomRectangularbtn.dart';
import 'package:crypto_wallet/UI/pages/history/history.dart';
import 'package:crypto_wallet/services/apiService.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:crypto_wallet/UI/common_widgets/commonWidgets.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/colors.dart';
import '../../../models/coinsModel.dart';
import '../../../models/walletBalanceModel.dart';
import '../../../models/walletsModel.dart';
import '../../../services/utilServices.dart';
import '../../common_widgets/inputFields.dart';

class Swap extends StatefulWidget {
  Swap({Key? key, this.showBack, this.token}) : super(key: key);
  final bool? showBack;
  Balance? token;
  @override
  State<Swap> createState() => _SwapState();
}

class _SwapState extends State<Swap> {
  final appController = Get.find<AppController>();

  var swapList = <Balance>[];
  var fromCoin = Balance().obs;
  var toCoin = Balance().obs;
  TextEditingController amountController = new TextEditingController();
  var swapError = ''.obs;
  var userGets = ''.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.token != null) {
      fromCoin.value = widget.token!;
    } else {
      if (appController.userBalance.value.balance != null && appController.userBalance.value.balance!.isNotEmpty) {
        fromCoin.value = appController.userBalance.value.balance?[0] ?? Balance();
      } else {
        fromCoin.value = Balance();
      }
    }
    amountController.text = '0';
    ApiService().getFee();
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
                statusBarColor: primaryColor.value,

                // Status bar brightness (optional)
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
              ),
              elevation: 0,
            ),
          ),
          backgroundColor: primaryColor.value,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 110,
                padding: EdgeInsets.only(top: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CommonWidgets().appBar(hasBack: widget.showBack ?? false, title: 'Swap'),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  decoration: BoxDecoration(
                    color: primaryBackgroundColor.value,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  height: Get.height - 178,
                  //constraints: BoxConstraints(minHeight: Get.height - 178, maxHeight: Get.height - 178, minWidth: Get.width),
                  child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Swap",
                            style: TextStyle(
                                fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 14.0, letterSpacing: 0.44, color: headingColor.value),
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.timer,
                                size: 18,
                                color: primaryColor.value,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  //Get.to(SwapTransactionHistory());
                                  Get.to(History(
                                    fromPage: 'swap',
                                  ));
                                },
                                child: Text(
                                  "History",
                                  style: TextStyle(
                                      fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 14.0, letterSpacing: 0.44, color: primaryColor.value),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 260,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 110,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(color: inputFieldBackgroundColor.value, borderRadius: BorderRadius.circular(16)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: InputFields(
                                              textController: amountController,
                                              headerText: '',
                                              hintText: '0',
                                              inputType: TextInputType.number,
                                              hasHeader: false,
                                              onChange: (value) {
                                                print('====> ${toCoin.value.id}');
                                                getSwapQuote();

                                              },
                                            ),
                                          ),
                                          appController.getBalanceLoader.value == true
                                              ? Shimmer.fromColors(
                                                  baseColor: Colors.black.withOpacity(0.25),
                                                  highlightColor: Colors.white.withOpacity(0.5),
                                                  child: Container(
                                                    clipBehavior: Clip.antiAlias,
                                                    width: 50,
                                                    height: 15,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(16),
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    _selectTokenBottomSheet(context, wList: appController.userBalance.value.balance, type: 'from');
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: CachedNetworkImage(
                                                          imageUrl: fromCoin.value.logoUrl ?? '',
                                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        constraints: BoxConstraints(
                                                          maxWidth: 130,
                                                        ),
                                                        child: Text(
                                                          "${fromCoin.value.symbol}",
                                                          style: TextStyle(
                                                              fontFamily: 'sfpro',
                                                              fontStyle: FontStyle.normal,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 16.0,
                                                              letterSpacing: 0.37,
                                                              color: labelColor.value),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Icon(
                                                        Icons.keyboard_arrow_down,
                                                        color: labelColor.value,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 9.0),
                                            child: Row(
                                              children: [
                                                appController.getBalanceLoader.value == true
                                                    ? Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          Shimmer.fromColors(
                                                            baseColor: Colors.black.withOpacity(0.25),
                                                            highlightColor: Colors.white.withOpacity(0.5),
                                                            child: Container(
                                                              clipBehavior: Clip.antiAlias,
                                                              width: 50,
                                                              height: 15,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(16),
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Text(
                                                        "${appController.user.value.currency?.symbol} ${UtilService().toFixed2DecimalPlaces((fromCoin.value.price ?? 0).toString(), decimalPlaces: 4)}",
                                                        style: TextStyle(
                                                            fontFamily: 'sfpro',
                                                            fontStyle: FontStyle.normal,
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.37,
                                                            color: labelColor.value),
                                                      ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              appController.getBalanceLoader.value == true
                                                  ? Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Shimmer.fromColors(
                                                          baseColor: Colors.black.withOpacity(0.25),
                                                          highlightColor: Colors.white.withOpacity(0.5),
                                                          child: Container(
                                                            clipBehavior: Clip.antiAlias,
                                                            width: 50,
                                                            height: 15,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(16),
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Text(
                                                      "Balance: ${UtilService().toFixed2DecimalPlaces(fromCoin.value.balance.toString(), decimalPlaces: 4)}",
                                                      style: TextStyle(
                                                          fontFamily: 'sfpro',
                                                          fontStyle: FontStyle.normal,
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.37,
                                                          color: labelColor.value),
                                                    ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 110,
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(color: inputFieldBackgroundColor.value, borderRadius: BorderRadius.circular(16)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            height: 0,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 9.0),
                                                child: Text(
                                                  appController.platFormFeeList.isNotEmpty
                                                      ? "${appController.getFeeLoader.value == true ?
                                                  "Loading..." : "${userGets.value}"}"
                                                      : "0.0",
                                                  style: TextStyle(
                                                      fontFamily: 'sfpro',
                                                      fontStyle: FontStyle.normal,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.37,
                                                      color: labelColor.value),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {

                                                },
                                                child: Text(
                                                  "${appController.user.value.currency?.symbol ?? ''}",
                                                  style: TextStyle(
                                                      fontFamily: 'sfpro',
                                                      fontStyle: FontStyle.normal,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.37,
                                                      color: labelColor.value),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 0,
                                          ),
                                          Divider(
                                            height: 0,
                                            color: dividerColor.value,
                                            thickness: 1,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // SizedBox(
                                              //     height: 15,
                                              //     width: 15,
                                              //     child: CircularProgressIndicator(
                                              //       strokeWidth: 2,
                                              //       value: 0.8,
                                              //       color: labelColor.value,
                                              //     )),
                                              // SizedBox(
                                              //   width: 10,
                                              // ),
                                              Text(
                                                "Balance: ${appController.user.value.currency?.symbol ?? ''} ${UtilService().toFixed2DecimalPlaces(appController.userBalance.value.wallet?.currentSwappedBalance.toString(), decimalPlaces: 4)}",
                                                style: TextStyle(
                                                    fontFamily: 'sfpro',
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.37,
                                                    color: labelColor.value),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Positioned(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 0),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: primaryColor.value,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(width: 3, color: cardColor.value),
                                    ),
                                    child: ImageIcon(
                                      AssetImage("assets/imgs/swap.png"),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Swap Fee",
                                    style: TextStyle(
                                        fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 12.0, letterSpacing: 0.44, color: placeholderColor),
                                  ),
                                ],
                              ),
                              appController.getFeeLoader.value == true
                                  ? CommonWidgets.loadingShimmer()
                                  : Text(
                                      (toCoin.value.id != null || toCoin.value.id == '')
                                          ? ""
                                          : appController.platFormFeeList.isEmpty ? '' :
                                      '${appController.platFormFeeList[appController.platFormFeeList.indexWhere((element) =>
                                      element.feeName == 'swap_fee')].feePercentage??0} %',
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
                            height: 13.5,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CommonWidgets.showErrorMessage(swapError.value),
                      SizedBox(
                        height: 85,
                      ),
                      BottomRectangularBtn(
                          isDisabled: appController.swapLoader.value,
                          isLoading: appController.swapLoader.value,
                          loadingText: 'Processing...',
                          onTapFunc: () {
                            if(amountController.text != '' && num.parse(amountController.text) > 0){
                              ApiService().swap(coinId: fromCoin.value.coinId,
                                  networkId: fromCoin.value.networkId,
                                  amount: amountController.text).then((value) {
                                amountController.clear();
                                userGets.value = '0';
                                setState(() { });
                                ApiService().getWalletWithBalance(showLoader: true);
                              });
                            } else {
                              UtilService().showToast('Amount can not be 0.',color: Colors.red);
                            }
                          },
                          btnTitle: 'Swap')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _selectTokenBottomSheet(BuildContext context, {List<Balance>? wList, String? type}) {
    return Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: primaryBackgroundColor.value,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      Container(
        padding: EdgeInsets.all(20),
        height: Get.height * 0.7,
        decoration: BoxDecoration(color: primaryBackgroundColor.value, borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Select token",
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
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: wList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (type == 'from') {
                      return toCoin.value.id == wList?[index].id
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: _tokenItems(
                                  item: wList?[index],
                                  amountInUSD: "${UtilService().toFixed2DecimalPlaces((wList?[index].balanceInLocalCurrency ?? 0).toString(), decimalPlaces: 4)}",
                                  coinName: "${wList?[index].symbol}",
                                  amountInEth: "${UtilService().toFixed2DecimalPlaces((wList?[index].balance ?? 0).toString(), decimalPlaces: 4)}",
                                  imgName: "${wList?[index].logoUrl}",
                                  percentage: "${UtilService().toFixed2DecimalPlaces((wList?[index].priceChange ?? 0).toString(), decimalPlaces: 2)}",
                                  priceInUSD: "${UtilService().toFixed2DecimalPlaces((wList?[index].price?? 0).toString(), decimalPlaces: 4)}",
                                  type: type),
                            );
                    } else {
                      return fromCoin.value.id == wList?[index].id
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: _tokenItems(
                                  item: wList?[index],
                                  amountInUSD: "${wList?[index].balance}",
                                  coinName: "${wList?[index].symbol}",
                                  amountInEth: "${wList?[index].balance}",
                                  imgName: "${wList?[index].logoUrl}",
                                  percentage: "",
                                  priceInUSD: "${wList?[index].price}",
                                  type: type),
                            );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tokenItems({String? coinName, String? type, String? amountInEth, String? amountInUSD, String? percentage, String? priceInUSD, String? imgName, Balance? item}) {
    return GestureDetector(
      onTap: () {
        print('-====== $item}');
        fromCoin.value = item!;

        getSwapQuote();
        Get.back();
      },
      child: Container(
        width: Get.width,
        height: 72,
        decoration: BoxDecoration(
          color: cardColor.value,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: lightColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imgName ?? '',
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    clipBehavior: Clip.antiAlias,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            '$coinName',
                            style: TextStyle(
                              fontFamily: 'sfpro',
                              color: headingColor.value,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                              letterSpacing: 0.37,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${appController.user.value.currency?.symbol}$priceInUSD',
                        style: TextStyle(
                          fontFamily: 'sfpro',
                          color: placeholderColor,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          letterSpacing: 0.44,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        '$amountInEth',
                        style: TextStyle(
                          fontFamily: 'sfpro',
                          color: headingColor.value,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          letterSpacing: 0.37,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${appController.user.value.currency?.symbol}$amountInUSD',
                    style: TextStyle(
                      fontFamily: 'sfpro',
                      color: placeholderColor,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                      letterSpacing: 0.44,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  getSwapQuote() async {
    if(amountController.text.trim() == ''){
      userGets.value = '0';
    } else {
      if(num.parse(amountController.text)>0) {
        if(appController.getFeeLoader.value ==false && appController.platFormFeeList.isNotEmpty){
          userGets.value = UtilService().toFixed2DecimalPlaces(((num.parse(amountController.text) * (fromCoin.value.price??0))
              - ((num.parse(amountController.text) * (fromCoin.value.price??0)) * 
              num.parse(((appController.platFormFeeList[appController.platFormFeeList.
              indexWhere((element) => element.feeName == 'swap_fee')].feePercentage??0)/100).toString()))

          ).toString(), decimalPlaces: 4);
        } else {
          userGets.value = '0';
        }
      } else {
        userGets.value = '0';
      }
    }
  }
}
