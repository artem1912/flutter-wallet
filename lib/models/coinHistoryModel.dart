class CoinHistoryModel {
  String? userId;
  String? walletId;
  String? fromAddress;
  String? toAddress;
  String? coinId;
  String? swappedCoinId;
  String? type;
  num? amount;
  num? swappedAmount;
  num? bridgeFee;
  String? trxHash;
  String? createdAt;
  Coin? coin;
  Coin? swappedCoin;
  String? id;

  CoinHistoryModel(
      {this.userId,
        this.walletId,
        this.fromAddress,
        this.toAddress,
        this.coinId,
        this.swappedCoinId,
        this.type,
        this.amount,
        this.swappedAmount,
        this.bridgeFee,
        this.trxHash,
        this.createdAt,
        this.coin,
        this.swappedCoin,
        this.id});

  CoinHistoryModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    walletId = json['walletId'];
    fromAddress = json['fromAddress'];
    toAddress = json['toAddress'];
    coinId = json['coinId'];
    swappedCoinId = json['swappedCoinId'];
    type = json['type'];
    amount = json['amount'];
    swappedAmount = json['swappedAmount'];
    bridgeFee = json['bridgeFee'];
    trxHash = json['trxHash'];
    createdAt = json['createdAt'];
    coin = json['coin'] != null ? new Coin.fromJson(json['coin']) : null;
    swappedCoin = json['swappedCoin'] != null
        ? new Coin.fromJson(json['swappedCoin'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['walletId'] = this.walletId;
    data['fromAddress'] = this.fromAddress;
    data['toAddress'] = this.toAddress;
    data['coinId'] = this.coinId;
    data['swappedCoinId'] = this.swappedCoinId;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['swappedAmount'] = this.swappedAmount;
    data['bridgeFee'] = this.bridgeFee;
    data['trxHash'] = this.trxHash;
    data['createdAt'] = this.createdAt;
    if (this.coin != null) {
      data['coin'] = this.coin!.toJson();
    }
    if (this.swappedCoin != null) {
      data['swappedCoin'] = this.swappedCoin!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Coin {
  String? name;
  String? symbol;
  String? icon;
  String? id;

  Coin({this.name, this.symbol, this.icon, this.id});

  Coin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    icon = json['icon'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['icon'] = this.icon;
    data['id'] = this.id;
    return data;
  }
}