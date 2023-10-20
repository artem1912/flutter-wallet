import 'package:crypto_wallet/models/allCoinsModel.dart';
import 'package:crypto_wallet/models/coinHistoryModel.dart';
import 'package:crypto_wallet/models/contactModel.dart';
import 'package:crypto_wallet/models/currencyModel.dart';
import 'package:crypto_wallet/models/feeModel.dart';
import 'package:crypto_wallet/models/networksModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../models/coinsModel.dart';
import '../models/swapQuoteModel.dart';
import '../models/transactionsModel.dart';
import '../models/userModel.dart';
import '../models/walletBalanceModel.dart';
import '../models/walletsModel.dart' as walletsModel;

class AppController extends GetxController {
  var isDark = false.obs;
  var enabledBiometric = false.obs;
  var selectedTabIndex = 1.obs;
  var selectedTabIndex1 = 0.obs;
  var theme = false.obs;
  var registerLoader = false.obs;
  var registerWithImportLoader = false.obs;
  var loginLoader = false.obs;
  var userWalletsLoader = false.obs;
  var getBalanceLoader = false.obs;
  var getNetworksLoader = false.obs;
  var getAllCoinsLoader = false.obs;
  var getTransactionsLoader = false.obs;
  var sendAmountLoader = false.obs;
  var getContactsLoader = false.obs;
  var importTokenLoader = false.obs;
  var changePassLoader = false.obs;
  var createNewWalletLoader = false.obs;
  var importWalletLoader = false.obs;
  var user = UserModel().obs;
  var singleCoinWalletList = <walletsModel.WalletsModel>[].obs;
  var contactsList = <ContactModel>[].obs;
  var userBalance = WalletBalanceModel().obs;
  var password = ''.obs;
  var networksList = <NetworksData>[].obs;
  var swapTransactionsList = <CoinHistoryModel>[].obs;
  var getSwapTransactionsLoader = false.obs;
  var swapLoader = false.obs;
  var seeAll = false.obs;
  var hideBalance = false.obs;
  var selectedIndex = 0.obs;
  var selectedBOttomTabIndex = 0.obs;
  var updateProfileLoader = false.obs;
  var withdrawFiatLoader = false.obs;
  var withdrawCryptoLoader = false.obs;
  var swapCryptoLoader = false.obs;
  var verifyEmailLoader = false.obs;
  var getLoggedInUserLoader = false.obs;
  var getSwapQuoteLoader = false.obs;
  var verifyOtpLoader = false.obs;
  var forgotPassLoader = false.obs;
  var resetPassLoader = false.obs;
  var currenciesLoader = false.obs;
  var getFeeLoader = false.obs;
  var allCoinsList = <CoinsModel>[].obs;
  var swapQuote = <CoinsModel>[].obs;

  var allTransactionsList = <TransactionsModel>[].obs;
  var allCurrenciesList = <CurrencyModel>[].obs;
  var platFormFeeList = <FeeModel>[].obs;
  var selectCurrenciesList = <String>[].obs;
  var userBalanceInNaira = ''.obs;
  var deleteProfileLoader = false.obs;

  var selectCoinIndex = 0.obs;
  var shoudApiCallsRun = false.obs;
  var errMsg = ''.obs;
  var shouldCallDashboardApi = true.obs;

  changeTheme() {
    if (isDark.value) {
      primaryBackgroundColor.value = Color(0xff101614);
      cardColor.value = Color(0xff131C1A);
      chatBoxBg.value = Color(0xff131C1A);
      inputFieldBackgroundColor.value = Color(0xff131C1A);
      inputFieldTextColor.value = Color(0xffcccccc);
      headingColor.value = Color(0xffffffff);
      labelColor.value = Color(0xffcccccc);
      appShadow.value = [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0).withOpacity(0.35),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ];
      Get.changeThemeMode(ThemeMode.dark);
      Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
    } else {
      headingColor.value = Color(0xFF030319);
      primaryBackgroundColor.value = Color(0xFFFFFFFF);
      inputFieldBackgroundColor.value = Color(0xFFFAFAFA);
      inputFieldTextColor.value = Color(0xFF1B2023);
      cardColor.value = Color(0xFFFCFCFC);
      labelColor.value = Color(0xFF6A6A6A);
      chatBoxBg.value = Color(0xffF8F8F8);
      appShadow.value = [
        BoxShadow(
          color: Color.fromRGBO(155, 155, 155, 15).withOpacity(0.15),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ];
    }
    Get.changeThemeMode(ThemeMode.light);
    Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
    print(primaryColor.value);
  }
}
