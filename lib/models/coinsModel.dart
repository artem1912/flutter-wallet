class CoinsModel {
  String? name;
  String? symbol;
  String? icon;
  String? coinNameId;
  bool? isToken;
  String? contractAddress;
  num? decimal;
  num? price;
  num? priceMarket;
  NetworkId? networkId;
  bool? isDeleted;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  num? priceChange;
  String? id;
  num? swapAmount;
  num? swapFee;

  CoinsModel(
      {this.name,
        this.symbol,
        this.icon,
        this.coinNameId,
        this.isToken,
        this.contractAddress,
        this.decimal,
        this.price,
        this.priceMarket,
        this.networkId,
        this.isDeleted,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.priceChange,
        this.swapAmount,
        this.swapFee,
        this.id});

  CoinsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    icon = json['icon'];
    coinNameId = json['coinNameId'];
    isToken = json['isToken'];
    contractAddress = json['contractAddress'];
    decimal = json['decimal'];
    price = json['price'];
    priceMarket = json['priceMarket'];
    networkId = json['networkId'] != null
        ? new NetworkId.fromJson(json['networkId'])
        : null;
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    priceChange = json['priceChange'];
    id = json['id'];
    swapAmount = json['swapAmount'];
    swapFee = json['swapFee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['icon'] = this.icon;
    data['coinNameId'] = this.coinNameId;
    data['isToken'] = this.isToken;
    data['contractAddress'] = this.contractAddress;
    data['decimal'] = this.decimal;
    data['price'] = this.price;
    data['priceMarket'] = this.priceMarket;
    if (this.networkId != null) {
      data['networkId'] = this.networkId!.toJson();
    }
    data['isDeleted'] = this.isDeleted;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['priceChange'] = this.priceChange;
    data['id'] = this.id;
    data['swapAmount'] = this.swapAmount;
    data['swapFee'] = this.swapFee;
    return data;
  }
}

class NetworkId {
  String? name;
  String? symbol;
  num? chainId;
  String? nativeCoinAddress;
  String? logoUrl;
  String? rpcUrl;
  bool? isMainnet;
  String? networkName;
  String? networkType;
  bool? isDeleted;
  bool? isActive;
  String? id;

  NetworkId(
      {this.name,
        this.symbol,
        this.chainId,
        this.nativeCoinAddress,
        this.logoUrl,
        this.rpcUrl,
        this.isMainnet,
        this.networkName,
        this.networkType,
        this.isDeleted,
        this.isActive,
        this.id});

  NetworkId.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    chainId = json['chainId'];
    nativeCoinAddress = json['nativeCoinAddress'];
    logoUrl = json['logoUrl'];
    rpcUrl = json['rpcUrl'];
    isMainnet = json['isMainnet'];
    networkName = json['networkName'];
    networkType = json['networkType'];
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['chainId'] = this.chainId;
    data['nativeCoinAddress'] = this.nativeCoinAddress;
    data['logoUrl'] = this.logoUrl;
    data['rpcUrl'] = this.rpcUrl;
    data['isMainnet'] = this.isMainnet;
    data['networkName'] = this.networkName;
    data['networkType'] = this.networkType;
    data['isDeleted'] = this.isDeleted;
    data['isActive'] = this.isActive;
    data['id'] = this.id;
    return data;
  }
}