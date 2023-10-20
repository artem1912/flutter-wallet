import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:crypto_wallet/models/allCoinsModel.dart';
import 'package:crypto_wallet/services/apiService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constants/colors.dart';
import '../../../models/coinsModel.dart';
import '../../../models/walletBalanceModel.dart';
import '../../../services/utilServices.dart';
import '../../common_widgets/commonWidgets.dart';
import '../buy/buy.dart';
import '../send/send.dart';

class ChooseToken extends StatefulWidget {
  ChooseToken({Key? key, this.fromPage}) : super(key: key);
  final String? fromPage;

  @override
  State<ChooseToken> createState() => _ChooseTokenState();
}

class _ChooseTokenState extends State<ChooseToken> {
  final appController = Get.find<AppController>();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('sadasdasdas ===> ${appController.allCoinsList.length}');
    if (widget.fromPage == 'buy' || widget.fromPage == 'receive') {
      refresh();
    }
  }

  refresh() {
    ApiService().getAllCoins(
      limit: 10,
      offset: 0,
    );
    _refreshController.refreshCompleted();
  }

  onLoad() {
    ApiService().getAllCoins(limit: 10, offset: appController.allCoinsList.length, method: 'add');
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.value,
      body: Obx(
        () => Container(
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 110,
                padding: EdgeInsets.only(top: 70),
                child: CommonWidgets().appBar(
                    hasBack: true,
                    title: widget.fromPage == 'buy'
                        ? 'Select Token'
                        : widget.fromPage == 'receive'
                            ? 'Receive'
                            : 'Send'),
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
                  //constraints: BoxConstraints(minHeight: Get.height - 240, minWidth: Get.width),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        children: [
                          Text(
                            'Choose Token',
                            style: TextStyle(
                              color: headingColor.value,
                              fontFamily: 'sfpro',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: 26.0,
                              letterSpacing: 0.36,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: appController.userBalance.value.balance?.length,
                          padding: EdgeInsets.only(top: 10, bottom: 40),
                          itemBuilder: (context, i) {
                            bool inc = (appController.userBalance.value.balance?[i].priceChange ?? 0) > 0 ? true : false;
                            return Column(
                              children: [
                                _coinRow(
                                  coinName: '${appController.userBalance.value.balance?[i].symbol ?? ''}',
                                  priceInUSD: '${UtilService().toFixed2DecimalPlaces((appController.userBalance.value.balance?[i].price ?? 0).toString())}',
                                  imgName: '${appController.userBalance.value.balance?[i].logoUrl}',
                                  percentage: '${UtilService().toFixed2DecimalPlaces((appController.userBalance.value.balance?[i].priceChange ?? 0).toString(), decimalPlaces: 2)}',
                                  amountInEth: '${UtilService().toFixed2DecimalPlaces((appController.userBalance.value.balance?[i].balance ?? 0).toString(), decimalPlaces: 4)}',
                                  amountInUSD: '${UtilService().toFixed2DecimalPlaces((appController.userBalance.value.balance?[i].balanceInLocalCurrency??0).toString(),decimalPlaces: 4)}',
                                  increment: inc,
                                  token: appController.userBalance.value.balance?[i],
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            );
                          },
                        ),
                      )
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

  Widget _coinRow(
      {String? coinName,
      String? amountInEth,
      String? amountInUSD,
      String? percentage,
      String? priceInUSD,
      String? imgName,
      required bool increment,
      required Balance? token /*, AllCoinsModel? coin*/}) {
    return GestureDetector(
      onTap: () {
        widget.fromPage == 'buy'
            ? Get.to(Buy(
                coin: token,
              ))
            : widget.fromPage == 'receive'
                ? Get.back(result: token!)
                : Get.to(Send(
                    selectedToken: token!,
                  ));
      },
      child: Container(
        width: Get.width,
        height: 72,
        decoration: BoxDecoration(
          color: primaryBackgroundColor.value,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.only(top: 12, bottom: 5, right: 12),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
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
                    width: 16,
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
                        height: 3,
                      ),
                      Row(
                        children: [
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
                          SizedBox(
                            width: 8,
                          ),
                          increment == true
                              ? Text(
                            '+ $percentage%',
                            style: TextStyle(fontFamily: 'sfpro', fontWeight: FontWeight.w400, fontSize: 13.0, letterSpacing: 0.44, color: greenCardColor.value),
                          )
                              : Text(
                            ' $percentage%',
                            style: TextStyle(fontFamily: 'sfpro', fontWeight: FontWeight.w400, fontSize: 13.0, letterSpacing: 0.44, color: redCardColor.value),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
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
                    height: 3,
                  ),
                  // if(widget.fromPage != 'buy' && widget.fromPage != 'receive')
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
}
