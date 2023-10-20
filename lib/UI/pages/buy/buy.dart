import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_wallet/models/coinPriceData.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/colors.dart';
import '../../../constants/constants.dart';
import '../../../controllers/appController.dart';
import '../../../models/coinsModel.dart';
import '../../../models/walletBalanceModel.dart';
import '../../../services/utilServices.dart';
import '../../common_widgets/bottomRectangularbtn.dart';
import '../../common_widgets/commonWidgets.dart';
import '../../common_widgets/inputFields.dart';
import '../../common_widgets/openLink.dart';
import 'package:intl/intl.dart';

class Buy extends StatefulWidget {
  Buy({super.key, this.coin});
  final Balance? coin;

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  TextEditingController amountController = new TextEditingController();
  var amountErr = ''.obs;
  var loading = false.obs;
  var selectedCoinPrice = '0.0'.obs;
  var totalFee = '0.0'.obs;
  var selectedWalletAddress = ''.obs;

  CoinPriceData coinPriceData = CoinPriceData();
  final appController = Get.find<AppController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // if (widget.coin?.symbol == 'BTC') {
    //   selectedWalletAddress.value = appController.selectedWallet.value.wallet!.wallets!.firstWhere((element) => element.type == 'BTC').address!;
    // } else if (widget.coin?.symbol == 'TRX') {
    //   selectedWalletAddress.value = appController.selectedWallet.value.wallet!.wallets!.firstWhere((element) => element.type == 'TRON').address!;
    // } else {
    //   selectedWalletAddress.value = appController.selectedWallet.value.wallet!.wallets!.firstWhere((element) => element.type == 'EVM').address!;
    // }
    selectedWalletAddress.value = (widget.coin?.networkName == 'Tron')
        ? (appController.userBalance.value.wallet?.tronAddress ?? '')
        : (widget.coin?.networkName == 'Bitcoin' || widget.coin?.networkName == 'Bitcoin (Testnet)')
        ? (appController.userBalance.value.wallet?.btcAddress ?? '')
        : (appController.userBalance.value.wallet?.evmAddress ?? '');
    print('WalletAddress ${selectedWalletAddress.value}');
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
                    CommonWidgets().appBar(hasBack: true, title: 'Buy ${widget.coin?.symbol}'),
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
                        SizedBox(
                          height: 24,
                        ),
                        InputFieldsWithSeparateIcon(
                          textController: amountController,
                          headerText: 'Amount in USD',
                          hintText: 'Amount',
                          inputType: TextInputType.number,
                          hasHeader: true,
                          onChange: (value) {
                            amountErr.value = '';
                            selectedCoinPrice.value = value;
                            if (value == '') {
                              selectedCoinPrice.value = '0.0';
                              totalFee.value = '0.0';
                            }
                            setState(() {});
                            if (value != '') {
                              _onChangeHandler();
                            }
                          },
                          svg: 'walletArrow',
                          suffixIcon: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            child: Text(
                              'USD',
                              style: TextStyle(
                                  fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 14.0, letterSpacing: 0.37, color: labelColor.value),
                            ),
                          ),
                        ),
                        CommonWidgets.showErrorMessage(amountErr.value),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'By Paying',
                              style: TextStyle(
                                color: labelColor.value,
                                fontFamily: 'sfpro',
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Text(
                                      amountController.text.isEmpty ? "0.0" : '${amountController.text}',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: labelColor.value,
                                        fontFamily: 'sfpro',
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: cardColor.value,
                                      borderRadius: BorderRadius.all(Radius.circular(40)),
                                      //boxShadow: appShadow,
                                    ),
                                    child: Text(
                                      NumberFormat.simpleCurrency(
                                        name: "USD", //currencyCode
                                        decimalDigits: 0,
                                      ).currencySymbol,
                                      style: TextStyle(
                                        color: appController.isDark.value ? inputFieldTextColor.value : labelColor.value,
                                        fontSize: 14,
                                        fontFamily: 'sfpro',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Text(
                              'You will Receive',
                              style: TextStyle(
                                color: labelColor.value,
                                fontFamily: 'sfpro',
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: loading.value
                                        ? Shimmer.fromColors(
                                            baseColor: labelColor.value,
                                            highlightColor: Colors.white,
                                            child: Text(
                                              'Loading...   ',
                                              style: TextStyle(
                                                color: labelColor.value,
                                                fontFamily: 'sfpro',
                                              ),
                                            ),
                                          )
                                        : Text(
                                            '${amountController.text == '' ? '0.0' : UtilService().toFixed2DecimalPlaces(selectedCoinPrice.value.toString(), decimalPlaces: 4)} ',
                                            style: TextStyle(
                                              color: labelColor.value,
                                              fontFamily: 'sfpro',
                                            ),
                                          ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  CachedNetworkImage(
                                    imageUrl: widget.coin?.logoUrl ?? '',
                                    width: 20,
                                    height: 20,
                                    errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.grey),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Fee',
                              style: TextStyle(
                                color: labelColor.value,
                                fontFamily: 'sfpro',
                              ),
                            ),
                            SizedBox(),
                            loading.value
                                ? Expanded(
                                    flex: 10,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Shimmer.fromColors(
                                          baseColor: labelColor.value,
                                          highlightColor: Colors.white,
                                          child: Text(
                                            'Loading...   ',
                                            style: TextStyle(
                                              color: labelColor.value,
                                              fontFamily: 'sfpro',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    flex: 10,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${UtilService().toFixed2DecimalPlaces(totalFee.value.toString(), decimalPlaces: 4)}',
                                          style: TextStyle(
                                            color: labelColor.value,
                                            fontFamily: 'sfpro',
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: cardColor.value,
                                            borderRadius: BorderRadius.all(Radius.circular(40)),
                                            //boxShadow: appShadow,
                                          ),
                                          child: Text(
                                            NumberFormat.simpleCurrency(
                                              name: "USD", //currencyCode
                                              decimalDigits: 0,
                                            ).currencySymbol,
                                            style: TextStyle(
                                              color: appController.isDark.value ? inputFieldTextColor.value : labelColor.value,
                                              fontSize: 14,
                                              fontFamily: 'sfpro',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        BottomRectangularBtn(
                            onTapFunc: () {
                              //getCoinPrice();
                              onTapBuy();
                            },
                            btnTitle: 'Buy'),
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

  onTapBuy() {
    if (amountController.text.isEmpty) {
      amountErr.value = 'Please enter amount';
    } else {
      var userData = {
        "firstName": '',
        "lastName": '',
        "email": '',
        "mobileNumber": '',
        "dob": "1990-11-26",
      };
      var queryParams = jsonEncode(userData);
      var walletAddress = selectedWalletAddress.value;
      var title = 'Payment';
      var coins = 'MATIC,ETH,AVAX,BTC,TRX,USDT,BNB,USDC,FTM';
      var fiatAmount = amountController.text;
      var faitCurrency = 'USD';
      var cryptoCurrency = widget.coin?.symbol;
      var email = '${appController.user.value.email}';
      if (widget.coin?.symbol == 'USDT (ERC20)' || widget.coin?.symbol == 'USDT (TRC20)' || widget.coin?.symbol == 'USDT (Polygon)') {
        cryptoCurrency = 'USDT';
      }
      String network = widget.coin?.symbol == 'ETH' || widget.coin?.symbol == 'USDC'
          ? 'ethereum'
          : widget.coin?.symbol == 'BTC'
              ? "mainnet"
              : widget.coin?.symbol == 'AVAX'
                  ? 'avaxcchain'
                  : widget.coin?.symbol == 'MATIC'
                      ? 'polygon'
                      : widget.coin?.symbol == 'TRX'
                          ? 'mainnet'
                          : widget.coin?.symbol == 'USDT (ERC20)'
                                  ? 'ethereum'
                                  : widget.coin?.symbol == 'USDT (TRC20)'
                                      ? 'tron'
                                      : widget.coin?.symbol == 'USDT (Polygon)'
                                          ? 'polygon'
                                          : widget.coin?.symbol == 'FTM'
                                          ? 'fantom'
                                          : widget.coin?.symbol == 'BNB'
                                              ? 'bsc'
                                              : '';

      String url = '$transakBaseUrl?apiKey=$apiKey&redirectURL=https://transak.com'
          '&cryptoCurrencyList=$coins&defaultCryptoCurrency=$cryptoCurrency&walletAddress=$walletAddress'
          '&fiatAmount=$fiatAmount&defaultFiatAmount=$fiatAmount&fiatCurrency=$faitCurrency&disableWalletAddressForm=true'
          '&exchangeScreenTitle=$title&isFeeCalculationHidden=true&email=$email&network=$network';
      print(url);
      Get.to(OpenLink(url: url, fromPage: ''), duration: Duration(milliseconds: 300), transition: Transition.rightToLeft);
    }
  }

  void getCoinPrice() async {
    loading.value = true;
    selectedCoinPrice.value = "0.0";
    String faitAmount = amountController.text;
    String fiatCurrency = 'USD';
    String paymentMethod = 'credit_debit_card';
    var cryptoCurrency = widget.coin?.symbol;
    if (widget.coin?.symbol == 'USDT (ERC 20)' || widget.coin?.symbol == 'USDT (TRC 20)' || widget.coin?.symbol == 'USDT (Polygon)') {
      cryptoCurrency = 'USDT';
    }
    String network = widget.coin?.symbol == 'ETH'
        ? 'ethereum'
        : widget.coin?.symbol == 'BTC'
            ? "mainnet"
            : widget.coin?.symbol == 'AVAX'
                ? 'avaxcchain'
                : widget.coin?.symbol == 'MATIC'
                    ? 'polygon'
                    : widget.coin?.symbol == 'TRX'
                        ? 'mainnet'
                            : widget.coin?.symbol == 'USDT (ERC20)'
                            ? 'ethereum'
                                : widget.coin?.symbol == 'USDT (TRC20)'
                                ? 'tron'
                                : widget.coin?.symbol == 'USDT (Polygon)'
                                    ? 'polygon'
                                    : widget.coin?.symbol == 'FTM'
                                        ? 'fantom'
                                        :  widget.coin?.symbol == 'BNB'
                                        ? 'bsc'
                                        : '';
    var basrUrl = '$transakUrlForPrice/';
    var _dio = Dio(BaseOptions(baseUrl: basrUrl, headers: {"Content-Type": "application/json"}));
    var apis =
        '$transakUrlForPrice?partnerApiKey=$apiKey&fiatCurrency=USD&cryptoCurrency=$cryptoCurrency&isBuyOrSell=BUY&network=$network&paymentMethod=$paymentMethod&fiatAmount=$faitAmount';
    print('--->$apis');
    var response;
    try {
      response = await _dio.get('$apis');
      print('response data ==>${response.data}');
      coinPriceData = CoinPriceData.fromJson(response.data);
      selectedCoinPrice.value = coinPriceData.response!.cryptoAmount.toString();
      loading.value = false;
      amountErr.value = '';
      amountErr.value = '';
      print('price : ${selectedCoinPrice.value}');
      print('fee : ${coinPriceData.response?.totalFee}');
      totalFee.value = (coinPriceData.response?.totalFee).toString();
      setState(() {});
    } on DioError catch (e) {
      if (e.response != null) {}
      response = e.response;
      loading.value = false;
      amountErr.value = '${e.response?.data['error']['message']}';
    }
    // print('$api' + ' Status_Code: ${response!.statusCode}');
  }

  late Timer searchOnStoppedTyping = new Timer(Duration(milliseconds: 1), () {});

  _onChangeHandler() {
    loading.value = true;
    const duration = Duration(milliseconds: 1000); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping.cancel()); // clear timer
    }
    setState(() => searchOnStoppedTyping = new Timer(duration, () {
          if (amountController.text != '') {
            getCoinPrice();
          } else {
            loading.value = false;
          }
        }));
  }
}
