import 'package:crypto_wallet/services/apiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:crypto_wallet/UI/common_widgets/commonWidgets.dart';
import 'package:crypto_wallet/constants/constants.dart';
import 'package:crypto_wallet/controllers/appController.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/colors.dart';
import '../../../constants/customIcons.dart';
import '../../../services/utilServices.dart';

class History extends StatefulWidget {
  const History({Key? key,this.fromPage = ''}) : super(key: key);
  final String fromPage;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final appController = Get.find<AppController>();
  var _visible = 0;
  var coinID = ''.obs;
  List<String> historyFilters = [
    'All',
    'Deposit',
    'Swap',
    'Withdraw',
    'Withdraw Fiat'
  ];
  final dateFormatting = new DateFormat('dd-MM-yyyy');
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.fromPage == 'swap'){
      appController.selectedTabIndex1.value = 2;
    } else {
      appController.selectedTabIndex1.value = 0;
    }
    getHistory();
  }

  getHistory() async {
    Future.delayed(Duration(milliseconds: 200),(){
      ApiService().getTransactions(limit: 10, offset: 0, type: historyFilters[appController.selectedTabIndex1.value]).then((value) {
        if (value == 'OK') {
          _refreshController.refreshCompleted();
        } else {
          _refreshController.refreshCompleted();
        }
      });
    });
  }

  onLoad() async {
    ApiService().getTransactions(limit: 10, offset: appController.allTransactionsList.length, type: historyFilters[appController.selectedTabIndex1.value], method: 'add').then((value) {
      if (value == 'OK') {
        _refreshController.loadComplete();
      } else {
        _refreshController.loadComplete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: primaryColor.value,
          body: Column(
            //padding: EdgeInsets.zero,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 110,
                padding: EdgeInsets.only(top: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CommonWidgets().appBar(hasBack: true, title: 'History'),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            "Transactions",
                            style: TextStyle(
                                fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w600, fontSize: 26.0, letterSpacing: 0.37, color: headingColor.value),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: historyFilters.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: index == 0 ? EdgeInsets.only(left: 0.0, right: 15) : EdgeInsets.symmetric(horizontal: 15.0),
                            child: InkWell(
                              onTap: () {
                                appController.selectedTabIndex1.value = index;
                                if (index == 0) {
                                  coinID.value = '';
                                } else {
                                  coinID.value = appController.userBalance.value.balance![index - 1].coinId!;
                                }
                                print('===> $coinID');
                                if (mounted) {
                                  setState(() {});
                                  getHistory();
                                }
                              },
                              child: Container(
                                height: 20,
                                decoration: appController.selectedTabIndex1.value == index
                                    ? BoxDecoration(color: bSheetbtnColor, borderRadius: BorderRadius.circular(5))
                                    : BoxDecoration(color: cardColor.value, borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
                                    child: Text(
                                      "${historyFilters[index]}",
                                      style: TextStyle(
                                          fontFamily: 'sfpro',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0,
                                          letterSpacing: 0.44,
                                          color: appController.selectedTabIndex1.value == index ? primaryColor.value : placeholderColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: Get.height - 231,
                      child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        header: WaterDropMaterialHeader(
                          backgroundColor: primaryBackgroundColor.value,
                          color: primaryColor.value,
                        ),
                        controller: _refreshController,
                        onRefresh: () => getHistory(),
                        onLoading: () {
                          onLoad();
                        },
                        child: appController.getTransactionsLoader.value == true
                            ? ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(top: 16, bottom: 16),
                                itemCount: 8,
                                itemBuilder: (BuildContext context, int index) => Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.25),
                                  highlightColor: Colors.grey.withOpacity(0.5),
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    width: Get.width,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                separatorBuilder: (BuildContext context, int index) {
                                  return SizedBox(height: 16);
                                },
                              )
                            : appController.getTransactionsLoader.value == false && appController.allTransactionsList.length == 0 ? Center(
                          child: Text(
                            'No Transaction History Found!',style: TextStyle(
                            color: headingColor.value,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: "sfpro",
                          ),
                          ),
                        ) :
                      ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(bottom: 35, top: 0),
                                itemCount: appController.allTransactionsList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return historyContainer(
                                      context: context,
                                      index: index,
                                      type: appController.allTransactionsList[index].type,
                                      onTap: () {
                                        //Get.to(CoinHistory());
                                      });
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget historyContainer({required BuildContext context, int? index, required VoidCallback onTap, String? type}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 67,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: cardColor.value,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      height: 24,
                      width: 24,
                      decoration: type != 'Withdraw'  && type != 'Withdraw Fiat'
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              color: bgCintainerColor.withOpacity(0.15),
                            )
                          : BoxDecoration(
                              shape: BoxShape.circle,
                              color: bg2CintainerColor.withOpacity(0.15),
                            ),
                      child:type == 'Swap' ?  Icon(
                        CustomIcons.swap,
                        size: 15,
                        color: type == 'Withdraw'  || type == 'Withdraw Fiat' ? iconUpColor : iconDownColor,
                      ) : Icon(
                        type == 'Withdraw'  || type == 'Withdraw Fiat'? CupertinoIcons.arrow_up_right : CupertinoIcons.arrow_down_left,
                        size: 15,
                        color: type == 'Withdraw'  || type == 'Withdraw Fiat' ? iconUpColor : iconDownColor,
                      )),
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${appController.allTransactionsList[index!].type}",
                        style: TextStyle(
                            fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 14.0, letterSpacing: 0.37, color: headingColor.value),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if(type == 'Withdraw Fiat')
                        Text(
                          "${appController.allTransactionsList[index].status}",
                          style: TextStyle(
                              fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 12.0, letterSpacing: 0.37, color: headingColor.value),
                        ),
                      if(type != 'Withdraw Fiat')
                      Text(
                        type != 'Withdraw' ? "${(appController.allTransactionsList[index].fromAddress == null ? '': appController.allTransactionsList[index].fromAddress!.substring(0, 5) + '...' +
                            appController.allTransactionsList[index].fromAddress!.substring(appController.allTransactionsList[index].toAddress!.length - 4))}":

                          "${appController.allTransactionsList[index].toAddress!.substring(0, 5) + '...' +
                              appController.allTransactionsList[index].toAddress!.substring(appController.allTransactionsList[index].toAddress!.length - 4)}",
                        style: TextStyle(
                            fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 12.0, letterSpacing: 0.37, color: headingColor.value),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      "${UtilService().toFixed2DecimalPlaces((appController.allTransactionsList[index].amount ?? 0).toString(), decimalPlaces: 4)} ${type == 'Withdraw Fiat' ? appController.user.value.currency?.symbol : (appController.allTransactionsList[index].coin?.symbol)}",
                      style: TextStyle(
                          fontFamily: 'sfpro',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          letterSpacing: 0.44,
                          color: type == 'Transfer' ? iconUpColor : iconDownColor)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${dateFormatting.format(
                      DateTime.fromMillisecondsSinceEpoch(DateTime.parse(appController.allTransactionsList[index].createdAt!).millisecondsSinceEpoch),
                    )}',
                    style: TextStyle(fontFamily: 'sfpro', fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 12.0, letterSpacing: 0.44, color: headingColor.value),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
