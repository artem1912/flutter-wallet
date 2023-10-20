

import 'dart:ui';

import 'package:crypto_wallet/models/allCoinsModel.dart';
import 'package:crypto_wallet/models/coinHistoryModel.dart';
import 'package:crypto_wallet/models/coinsModel.dart';
import 'package:crypto_wallet/models/contactModel.dart';
import 'package:crypto_wallet/models/currencyModel.dart';
import 'package:crypto_wallet/models/feeModel.dart';
import 'package:crypto_wallet/models/sendResponseModel.dart';
import 'package:crypto_wallet/models/walletBalanceModel.dart';
import 'package:crypto_wallet/services/dataService/dataService.dart';
import 'package:crypto_wallet/services/sharedPrefs.dart';
import 'package:crypto_wallet/services/utilServices.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/appController.dart';
import 'package:get/get.dart' as getX;

import '../models/networksModel.dart';
import '../models/swapQuoteModel.dart';
import '../models/transactionsModel.dart';
import '../models/userModel.dart';
import '../models/walletsModel.dart';
import '../models/transactionsModel.dart'as transactions;



class ApiService {

  final appController = getX.Get.find<AppController>();

  Future register({String? name, String? email, String? pass, String? currencyID}) async {
    appController.registerLoader.value = true;
    SharedPref sharedPref = SharedPref();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String res = '';
    var data = {
      "fullname": name,
      "email": email,
      "password": pass,
      "currencyId": "$currencyID"
    };

    Response? response = await DataService().genericDioPostCall('auth/signup', data: data);
    print("response?.data['user'] ${response?.data}");
    print("response?.data['user'] ${response?.statusCode}");
    if (response!.statusCode! <= 201) {
      if (response.data != null) {
        UserModel newUser = UserModel.fromJson(response.data);
        appController.user.value = newUser;
        appController.registerLoader.value = false;
      }
      res = 'OK';
    } else {
      appController.registerLoader.value = false;
    }
    return res;
  }

  Future verifyEmail({String? email, String? otp}) async {
    appController.verifyEmailLoader.value = true;
    String res = '';
    var data = {
      "email": email,
      "otp":otp,
    };

    Response? response = await DataService().genericDioPostCall('auth/verifyEmail', data: data);
    if (response!.statusCode! <= 201) {
      if (response.data != null) {
        UserModel newUser = UserModel.fromJson(response.data);
        saveToken(response.data['token']['access_token']);
        print('tok==> ${response.data['token']['access_token']}');
        print('access_token ==> ${response.data['token']['access_token']}');
        appController.user.value = newUser;
        appController.verifyEmailLoader.value = false;
      }
      res = 'OK';
    } else {
      appController.verifyEmailLoader.value = false;
    }
    return res;
  }

  saveToken(token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('jwtToken', token);
  }

  Future getLoggedInUser({bool? showLoader}) async {
    if(showLoader == true){
      appController.getLoggedInUserLoader.value = true;
    }
    SharedPref sharedPref = SharedPref();
    String res = '';
    Response? response = await DataService().genericDioGetCall('auth/getLoggedInUser');
    print("response?.data['user'] ${response?.data}");
    if (response!.statusCode! <= 201) {
      if (response.data != null) {
        UserModel newUser = UserModel.fromJson(response.data);
        await sharedPref.saveJson('user', newUser);
        appController.user.value = newUser;
      }
      res = 'OK';
      appController.shoudApiCallsRun.value = true;
      appController.getLoggedInUserLoader.value = false;
    } else {
      appController.getLoggedInUserLoader.value = false;
    }
    return res;
  }

  Future getAllCoins({int? limit,int? offset,String? method,bool? showRefresher}) async{
    if(method != 'add'){
      if(showRefresher != false){
        appController.getAllCoinsLoader.value = true;
      }
    }
    Response? response = await DataService().genericDioGetCall('coins/getCoins?offset=0&limit=150');
    String res = '';
    if(response!.statusCode! <= 201){
      print('networks ====> ${response.data}');
      if(response.data != null) {
        res = 'OK';
        if(method == 'add'){
          appController.allCoinsList.addAll((response.data as List).map((x) => CoinsModel.fromJson(x)).toList());
        } else {
          appController.allCoinsList.value = (response.data as List).map((x) => CoinsModel.fromJson(x)).toList();
        }
        appController.getAllCoinsLoader.value = false;
      }
    } else {
      appController.getAllCoinsLoader.value = false;
    }
    return res;
  }
  Future getWalletWithBalance({bool? showLoader}) async{
    if(showLoader != false){
      appController.getBalanceLoader.value = true;
    }
    Response? response = await DataService().genericDioGetCall('wallet/getWalletWithBalance');
    String res = '';
    if(response!.statusCode! <= 201){
      print('wallet Balance ====> ${response.data}');
      if(response.data != null) {
        res = 'OK';
        //appController.userBalance.value = (response.data as List).map((x) => CoinsModel.fromJson(x)).toList();
        appController.userBalance.value = WalletBalanceModel.fromJson(response.data);
        appController.userBalanceInNaira.value = (appController.userBalance.value.wallet?.totalBalanceInLocalCurrency??0).toString();
        // Balance? nairaBalance = Balance();
        // nairaBalance.balance = appController.userBalance.value.wallet?.totalBalanceNaira;
        // nairaBalance.symbol = 'Naira';
        // appController.userBalance.value.balance?.add(nairaBalance);


        appController.getBalanceLoader.value = false;
      }
    } else {
      appController.getBalanceLoader.value = false;
    }
    return res;
  }

  Future Login({String? email, String? pass}) async {
    appController.loginLoader.value = true;
    SharedPref sharedPref = SharedPref();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String res = '';
    var data = {'email': email, 'password': pass};
    Response? response = await DataService().genericDioPostCall('auth/login', data: data);
    print("response?.data['user'] ${response?.data}");
    print("response?.data['user'] ${response?.statusCode}");
    if (response!.statusCode! <= 201) {
      if (response.data != null) {
        UserModel newUser = UserModel.fromJson(response.data);
        saveToken(response.data['token']['access_token']);
        await sharedPref.saveJson('user', newUser);
        await prefs.setString('pass', pass!);
        print('tok==> ${response.data['token']['access_token']}');
        appController.user.value = newUser;
        appController.loginLoader.value = false;
        appController.shoudApiCallsRun.value = true;
      }
      res = 'OK';
    } else {
      appController.loginLoader.value = false;
    }
    return res;
  }

  Future updateProfile({String? imageURL, String? fullname, String? phone, String? bankName, String? accountNumber, String? accountName,bool? isAuthEnabled}) async {
    appController.updateProfileLoader.value = true;
    String res = '';
    var data = imageURL == null || imageURL == '' ? {
      "fullname": "$fullname",
      "phone": "$phone",
      "bankName": "$bankName",
      "accountNumber": "$accountNumber",
      "isAuthEnabled":"$isAuthEnabled",
      "accountName" : "$accountName"
    } : {
      "image": "$imageURL",
      "fullname": "$fullname",
      "phone": "$phone",
      "bankName": "$bankName",
      "accountNumber": "$accountNumber",
      "isAuthEnabled": "$isAuthEnabled",
      "accountName" : "$accountName"
    };
    Response? response = await DataService().genericDioPostCall('auth/updateProfile', data: data);
    print("response?.data['user'] ${response?.data}");
    print("response?.data['user'] ${response?.statusCode}");
    if (response!.statusCode! <= 201) {
      if (response.data != null) {
        //getLoggedInUser();
      }
      res = 'OK';
      appController.updateProfileLoader.value = false;
    } else {
      appController.updateProfileLoader.value = false;
    }
    return res;
  }


  Future withdrawFiat({String? amount, String? bankName,String? accountNumber, String? accountName}) async {
    appController.withdrawFiatLoader.value = true;
    String res = '';
    var data = {
      "amount": amount,
      "bankName": "$bankName",
      "accountNumber": "$accountNumber",
      "accountName": "$accountName"
    };
    Response? response = await DataService().genericDioPostCall('wallet/withdrawFiat', data: data);
    print("response?.data ${response?.data}");
    print("response?.data ${response?.statusCode}");
    if (response!.statusCode! <= 201) {
      if (response.data != null) {
        //UtilService().showToast('Withdraw Successful!',color: Color(0xFF00D339));
      }
      res = 'OK';
      appController.withdrawFiatLoader.value = false;
    } else {
      appController.withdrawFiatLoader.value = false;
    }
    return res;
  }


  Future withdrawCrypto({String? amount, String? coinId,String? networkId, String? address}) async {
    appController.withdrawCryptoLoader.value = true;
    String res = '';
    var data = {
      "coinId": coinId,
      "networkId": networkId,
      "address": "$address",
      "amount": amount
    };
    Response? response = await DataService().genericDioPostCall('wallet/withdraw', data: data);
    print("response?.data ${response?.data}");
    print("response?.data ${response?.statusCode}");
    if (response!.statusCode! <= 201) {
      if (response.data != null) {
        UtilService().showToast('Withdraw Successful!',color: Color(0xFF00D339));
      }
      res = 'OK';
      appController.withdrawCryptoLoader.value = false;
    } else {
      appController.withdrawCryptoLoader.value = false;
    }
    return res;
  }

  Future swap({String? amount, String? coinId,String? networkId,}) async {
    appController.swapLoader.value = true;
    String res = '';
    var data = {
      "coinId": "$coinId",
      "networkId": "$networkId",
      "amount": amount
    };
    Response? response = await DataService().genericDioPostCall('wallet/swap', data: data);
    print("response?.data ${response?.data}");
    print("response?.data ${response?.statusCode}");
    if (response!.statusCode! <= 201) {
      if (response.data != null) {
        UtilService().showToast('Swap Successful!',color: Color(0xFF00D339));
      }
      res = 'OK';
      appController.swapLoader.value = false;
    } else {
      appController.swapLoader.value = false;
    }
    return res;
  }
  Future getTransactions({int? limit,int? offset,String? method,String? type}) async{
    if(method != 'add'){
      appController.getTransactionsLoader.value = true;
    }
    String str = '';
    if(type !='All') {
      if(type == 'Withdraw Fiat'){
        str = '&type=Withdraw%20Fiat';
      } else {
        str = '&type=$type';
      }
    }
    Response? response = await DataService().genericDioGetCall('wallet/getTransactions?limit=$limit&offset=$offset'+'$str');
    String res = '';
    if(response!.statusCode! <= 201) {
      print('networks ====> ${response.data}');
      if(response.data != null) {
        res = 'OK';
        if(method == 'add'){
          appController.allTransactionsList.addAll((response.data as List).map((x) => transactions.TransactionsModel.fromJson(x)).toList());
        } else {
          appController.allTransactionsList.value = (response.data as List).map((x) => transactions.TransactionsModel.fromJson(x)).toList();
        }
        appController.getTransactionsLoader.value = false;
      }
    } else {
      appController.getTransactionsLoader.value = false;
    }
    return res;
  }

  Future<Object> verifyOtpForForgotPassword({required String email, required String code}) async {
    appController.verifyOtpLoader.value = true;
    var dataObj = {
      "email": "$email",
      "otp": "$code"
    };
    String res = '';
    Response? response = await DataService().genericDioPostCall('auth/verifyOtpForForgotPassword', data: dataObj);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (response!.statusCode! <= 201) {
      res = 'OK';
      String token = response.data['token']['access_token'];
      prefs.setString('authTokenForReset', token);
      appController.verifyOtpLoader.value = false;
      UtilService().showToast('Otp Verified Successfully!',color: Color(0xFF00D339));
    } else {
      appController.verifyOtpLoader.value = false;
    }
    return res;
  }

  Future<Object> forgotPassword({required String email}) async {
    appController.forgotPassLoader.value = true;
    var dataObj = {
      "email": "$email",
    };
    String res = '';
    Response? response = await DataService().genericDioPostCall('auth/forgotPassword', data: dataObj);
    if (response!.statusCode! <= 201) {
      res = 'OK';
      appController.forgotPassLoader.value = false;
      UtilService().showToast('Otp sent to $email!',color: Color(0xFF00D339));
    } else {
      appController.forgotPassLoader.value = false;
    }
    return res;
  }
  resetPass({required String pass}) async {
    appController.resetPassLoader.value = true;
    var dataObj = {'password': pass};
    String res = '';
    Response? response = await DataService().genericDioPostCall('auth/resetPassword', data: dataObj);
    if (response!.statusCode! <= 201) {
      res = 'OK';
      appController.resetPassLoader.value = false;
      UtilService().showToast('Password Updated Successfully!',color: Color(0xFF00D339));
    } else {
      appController.resetPassLoader.value = false;
    }
    return res;
  }
  Future<String> resendOTP({String? email}) async {
    String res = '';
    var dataObj = {'email': email};
    Response? response = await DataService().genericDioPostCall('auth/resendOtp', data: dataObj);
    if (response!.statusCode! <= 201) {
      res = 'OK';
    }
    return res;
  }
  Future getSwapQuote({String? id,String? amount,String? networkId}) async{
    appController.getSwapQuoteLoader.value = true;
    Response? response = await DataService().genericDioGetCall('coins/getCoins?coinId=$id&networkId=$networkId&amount=$amount&offset=0&limit=30');
    String res = '';
    if(response!.statusCode! <= 201){
      print('networks ====> ${response.data}');
      if(response.data != null) {

        res = 'OK';
        appController.swapQuote.value = (response.data as List).map((x) => CoinsModel.fromJson(x)).toList();
        appController.getSwapQuoteLoader.value = false;
      }
    } else {
      appController.getSwapQuoteLoader.value = false;
    }
    return res;
  }
  Future createContact({String? name, String? address,String? networkType}) async {
    String res = '';
    var data = {
      "name": "$name",
      "address": "$address",
      "networkType": "$networkType"
    };
    Response? response = await DataService().genericDioPostCall('contacts/createContact', data: data);
    print("response?.data ${response?.data}");
    print("response?.data ${response?.statusCode}");
    if (response!.statusCode! <= 201) {
      if (response.data['data'] != null) {
      }
      res = 'OK';
    } else {
    }
    return res;
  }
  Future getContacts({int? limit,int? offset,String? method}) async {
    appController.getContactsLoader.value = true;
    SharedPref sharedPref = SharedPref();
    String res = '';
    Response? response = await DataService().genericDioGetCall('contacts/getContacts?offset=$offset&limit=$limit');
    print("response?.data ${response?.data}");
    print("response?.statuscode ${response?.statusCode}");
    if (response!.statusCode! <= 201) {
      if (response.data != null) {
        if(method == 'add' || method == 'Add'){
          appController.contactsList.addAll((response.data as List).map((x) => ContactModel.fromJson(x)).toList());
        }
        appController.contactsList.value = (response.data as List).map((x) => ContactModel.fromJson(x)).toList();
      }
      appController.getContactsLoader.value = false;
      res = 'OK';
    } else {
      appController.getContactsLoader.value = false;
    }
    return res;
  }
  Future getCurrencies({int? limit,int? offset,String? method}) async {
    appController.currenciesLoader.value = true;
    String res = '';
    Response? response = await DataService().genericDioGetCall('coins/getCurrencies?offset=$offset&limit=$limit');
    print("response?.data ${response?.data}");
    print("response?.statuscode ${response?.statusCode}");
    if (response!.statusCode! <= 201) {
      if (response.data != null) {
        if(method == 'add' || method == 'Add'){
          appController.allCurrenciesList.addAll((response.data as List).map((x) => CurrencyModel.fromJson(x)).toList());
        }
        appController.allCurrenciesList.value = (response.data as List).map((x) => CurrencyModel.fromJson(x)).toList();
      }
      appController.allCurrenciesList.forEach((element) {
        String itemToAdd = element.name! + '  ' + '(${element.symbol!})';

        appController.selectCurrenciesList.add(itemToAdd);
      });
      appController.currenciesLoader.value = false;
      res = 'OK';
    } else {
      appController.currenciesLoader.value = false;
    }
    return res;
  }
  changePass({required String pass,required String oldPass}) async {
    appController.changePassLoader.value = true;
    var dataObj = {
      "oldPassword": "$oldPass",
      "password": "$pass"
    };
    String res = '';
    Response? response = await DataService().genericDioPostCall('auth/changePassword', data: dataObj);
    if (response!.statusCode! <= 201) {
      res = 'OK';
      appController.changePassLoader.value = false;
      UtilService().showToast('Password Updated Successfully!',color: Color(0xFF00D339));
    } else {
      appController.changePassLoader.value = false;
    }
    return res;
  }
  Future getFee({String? method}) async {
    appController.getFeeLoader.value = true;
    String res = '';
    Response? response = await DataService().genericDioGetCall('wallet/getFee');
    print("response?.data ${response?.data}");
    print("response?.statuscode ${response?.statusCode}");
    if (response!.statusCode! <= 201) {
      if (response.data != null) {
        if(method == 'add' || method == 'Add'){
          appController.platFormFeeList.addAll((response.data as List).map((x) => FeeModel.fromJson(x)).toList());
        }
        appController.platFormFeeList.value = (response.data as List).map((x) => FeeModel.fromJson(x)).toList();
      }
      appController.getFeeLoader.value = false;
      res = 'OK';
    } else {
      appController.getFeeLoader.value = false;
    }
    return res;
  }
  Future deleteProfile() async{
    appController.deleteProfileLoader.value = true;
    Response? response = await DataService().genericDioGetCall('auth/deleteUser');
    String res = '';
    if(response!.statusCode! <= 201){
      if(response.data != null) {

        res = 'OK';
        UtilService().showToast('Profile successfully deleted!', color: Color(0xFF00D339));
        appController.deleteProfileLoader.value = false;
      }
    } else {
      appController.deleteProfileLoader.value = false;
    }
    return res;
  }
}