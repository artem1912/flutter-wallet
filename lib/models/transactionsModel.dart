class TransactionsModel {
  String? userId;
  String? walletId;
  String? fromAddress;
  String? toAddress;
  String? coinId;
  String? type;
  num? amount;
  num? remainingBalance;
  num? swappedAmount;
  num? swappedPrice;
  String? trxHash;
  String? trxUrl;
  String? bankName;
  String? accountNumber;
  String? accountName;
  String? status;
  String? createdAt;
  User? user;
  Coin? coin;
  String? id;
  num? fee;

  TransactionsModel(
      {this.userId,
        this.walletId,
        this.fromAddress,
        this.toAddress,
        this.coinId,
        this.type,
        this.amount,
        this.remainingBalance,
        this.swappedAmount,
        this.swappedPrice,
        this.trxHash,
        this.trxUrl,
        this.bankName,
        this.accountNumber,
        this.accountName,
        this.status,
        this.createdAt,
        this.user,
        this.coin,
        this.fee,
        this.id});

  TransactionsModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    walletId = json['walletId'];
    fromAddress = json['fromAddress'];
    toAddress = json['toAddress'];
    coinId = json['coinId'];
    type = json['type'];
    amount = json['amount'];
    remainingBalance = json['remainingBalance'];
    swappedAmount = json['swappedAmount'];
    swappedPrice = json['swappedPrice'];
    trxHash = json['trxHash'];
    trxUrl = json['trxUrl'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    accountName = json['accountName'];
    status = json['status'];
    createdAt = json['createdAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    coin = json['coin'] != null ? new Coin.fromJson(json['coin']) : null;
    fee = json['fee'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['walletId'] = this.walletId;
    data['fromAddress'] = this.fromAddress;
    data['toAddress'] = this.toAddress;
    data['coinId'] = this.coinId;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['remainingBalance'] = this.remainingBalance;
    data['swappedAmount'] = this.swappedAmount;
    data['swappedPrice'] = this.swappedPrice;
    data['trxHash'] = this.trxHash;
    data['trxUrl'] = this.trxUrl;
    data['bankName'] = this.bankName;
    data['accountNumber'] = this.accountNumber;
    data['accountName'] = this.accountName;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['fee'] = this.fee;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.coin != null) {
      data['coin'] = this.coin!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class User {
  String? fullname;
  String? email;
  String? bankName;
  String? accountNumber;
  String? accountName;
  String? id;

  User(
      {this.fullname,
        this.email,
        this.bankName,
        this.accountNumber,
        this.accountName,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    email = json['email'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    accountName = json['accountName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['bankName'] = this.bankName;
    data['accountNumber'] = this.accountNumber;
    data['accountName'] = this.accountName;
    data['id'] = this.id;
    return data;
  }
}
class Coin {
  String? name;
  String? symbol;
  String? icon;
  Network? network;
  String? id;

  Coin({this.name, this.symbol, this.icon, this.network, this.id});

  Coin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    icon = json['icon'];
    network =
    json['network'] != null ? new Network.fromJson(json['network']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['icon'] = this.icon;
    if (this.network != null) {
      data['network'] = this.network!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Network {
  String? name;
  String? symbol;
  String? id;

  Network({this.name, this.symbol, this.id});

  Network.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['id'] = this.id;
    return data;
  }
}