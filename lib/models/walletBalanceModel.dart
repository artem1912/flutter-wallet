class WalletBalanceModel {
  Wallet? wallet;
  List<Balance>? balance;

  WalletBalanceModel({this.wallet, this.balance});

  WalletBalanceModel.fromJson(Map<String, dynamic> json) {
    wallet =
    json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
    if (json['balance'] != null) {
      balance = <Balance>[];
      json['balance'].forEach((v) {
        balance!.add(new Balance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wallet != null) {
      data['wallet'] = this.wallet!.toJson();
    }
    if (this.balance != null) {
      data['balance'] = this.balance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wallet {
  String? userId;
  String? evmAddress;
  String? evmKey;
  String? tronAddress;
  String? tronKey;
  String? btcPublicKey;
  String? btcAddress;
  String? btcKey;
  num? currentSwappedBalance;
  num? totalWithdrawnAmount;
  num? totalWithdrawnAmountLocked;
  String? createdAt;
  String? updatedAt;
  String? id;
  num? totalBalanceInLocalCurrency;
  LocalCurrency? localCurrency;
  LocalCurrency? usdCurrency;
  num? totalBalanceInUsd;
  String? accountName;
  String? accountNumber;
  String? bankName;

  Wallet(
      {this.userId,
        this.evmAddress,
        this.evmKey,
        this.tronAddress,
        this.tronKey,
        this.btcPublicKey,
        this.btcAddress,
        this.btcKey,
        this.currentSwappedBalance,
        this.totalWithdrawnAmount,
        this.totalWithdrawnAmountLocked,
        this.createdAt,
        this.updatedAt,
        this.id,
        this.totalBalanceInLocalCurrency,
        this.localCurrency,
        this.usdCurrency,
        this.totalBalanceInUsd,
        this.accountName,
        this.accountNumber,
        this.bankName});

  Wallet.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    evmAddress = json['evmAddress'];
    evmKey = json['evmKey'];
    tronAddress = json['tronAddress'];
    tronKey = json['tronKey'];
    btcPublicKey = json['btcPublicKey'];
    btcAddress = json['btcAddress'];
    btcKey = json['btcKey'];
    currentSwappedBalance = json['currentSwappedBalance'];
    totalWithdrawnAmount = json['totalWithdrawnAmount'];
    totalWithdrawnAmountLocked = json['totalWithdrawnAmountLocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    totalBalanceInLocalCurrency = json['totalBalanceInLocalCurrency'];
    localCurrency = json['localCurrency'] != null
        ? new LocalCurrency.fromJson(json['localCurrency'])
        : null;
    usdCurrency = json['usdCurrency'] != null
        ? new LocalCurrency.fromJson(json['usdCurrency'])
        : null;
    totalBalanceInUsd = json['totalBalanceInUsd'];
    accountName = json['accountName'];
    accountNumber = json['accountNumber'];
    bankName = json['bankName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['evmAddress'] = this.evmAddress;
    data['evmKey'] = this.evmKey;
    data['tronAddress'] = this.tronAddress;
    data['tronKey'] = this.tronKey;
    data['btcPublicKey'] = this.btcPublicKey;
    data['btcAddress'] = this.btcAddress;
    data['btcKey'] = this.btcKey;
    data['currentSwappedBalance'] = this.currentSwappedBalance;
    data['totalWithdrawnAmount'] = this.totalWithdrawnAmount;
    data['totalWithdrawnAmountLocked'] = this.totalWithdrawnAmountLocked;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['totalBalanceInLocalCurrency'] = this.totalBalanceInLocalCurrency;
    if (this.localCurrency != null) {
      data['localCurrency'] = this.localCurrency!.toJson();
    }
    if (this.usdCurrency != null) {
      data['usdCurrency'] = this.usdCurrency!.toJson();
    }
    data['totalBalanceInUsd'] = this.totalBalanceInUsd;
    data['accountName'] = this.accountName;
    data['accountNumber'] = this.accountNumber;
    data['bankName'] = this.bankName;
    return data;
  }
}

class LocalCurrency {
  String? name;
  String? symbol;
  String? coinGeckoId;
  String? logoUrl;
  bool? isDeleted;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  String? id;

  LocalCurrency(
      {this.name,
        this.symbol,
        this.coinGeckoId,
        this.logoUrl,
        this.isDeleted,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.id});

  LocalCurrency.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    coinGeckoId = json['coinGeckoId'];
    logoUrl = json['logoUrl'];
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['coinGeckoId'] = this.coinGeckoId;
    data['logoUrl'] = this.logoUrl;
    data['isDeleted'] = this.isDeleted;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}

class Balance {
  String? coinId;
  String? address;
  num? balance;
  String? networkId;
  String? id;
  String? name;
  String? symbol;
  String? logoUrl;
  String? networkName;
  String? networkSymbol;
  String? networkLogoUrl;
  num? price;
  num? priceInUsd;
  num? priceChange;
  num? balanceInLocalCurrency;
  num? balanceInUsd;

  Balance(
      {this.coinId,
        this.address,
        this.balance,
        this.networkId,
        this.id,
        this.name,
        this.symbol,
        this.logoUrl,
        this.networkName,
        this.networkSymbol,
        this.networkLogoUrl,
        this.price,
        this.priceInUsd,
        this.priceChange,
        this.balanceInLocalCurrency,
        this.balanceInUsd});

  Balance.fromJson(Map<String, dynamic> json) {
    coinId = json['coinId'];
    address = json['address'];
    balance = json['balance'];
    networkId = json['networkId'];
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    logoUrl = json['logoUrl'];
    networkName = json['networkName'];
    networkSymbol = json['networkSymbol'];
    networkLogoUrl = json['networkLogoUrl'];
    price = json['price'];
    priceInUsd = json['priceInUsd'];
    priceChange = json['priceChange'];
    balanceInLocalCurrency = json['balanceInLocalCurrency'];
    balanceInUsd = json['balanceInUsd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coinId'] = this.coinId;
    data['address'] = this.address;
    data['balance'] = this.balance;
    data['networkId'] = this.networkId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['logoUrl'] = this.logoUrl;
    data['networkName'] = this.networkName;
    data['networkSymbol'] = this.networkSymbol;
    data['networkLogoUrl'] = this.networkLogoUrl;
    data['price'] = this.price;
    data['priceInUsd'] = this.priceInUsd;
    data['priceChange'] = this.priceChange;
    data['balanceInLocalCurrency'] = this.balanceInLocalCurrency;
    data['balanceInUsd'] = this.balanceInUsd;
    return data;
  }
}