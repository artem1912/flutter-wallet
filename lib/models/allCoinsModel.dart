class AllCoinsModel {
  String? routerProtocolContractAddress;
  String? routerProtocolReserveHandlerAddress;
  bool? isUserSpecific;
  String? name;
  String? symbol;
  String? icon;
  String? coinGeckoId;
  bool? isToken;
  String? contractAddress;
  num? decimal;
  num? price;
  NetworkId? networkId;
  bool? isDeleted;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  num? priceChange;
  bool? isBuyable;
  String? id;

  AllCoinsModel(
      {this.routerProtocolContractAddress,
        this.routerProtocolReserveHandlerAddress,
        this.isUserSpecific,
        this.name,
        this.symbol,
        this.icon,
        this.coinGeckoId,
        this.isToken,
        this.contractAddress,
        this.decimal,
        this.price,
        this.networkId,
        this.isDeleted,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.priceChange,
        this.isBuyable,
        this.id});

  AllCoinsModel.fromJson(Map<String, dynamic> json) {
    routerProtocolContractAddress = json['routerProtocolContractAddress'];
    routerProtocolReserveHandlerAddress =
    json['routerProtocolReserveHandlerAddress'];
    isUserSpecific = json['isUserSpecific'];
    name = json['name'];
    symbol = json['symbol'];
    icon = json['icon'];
    coinGeckoId = json['coinGeckoId'];
    isToken = json['isToken'];
    contractAddress = json['contractAddress'];
    decimal = json['decimal'];
    price = json['price'];
    networkId = json['networkId'] != null
        ? new NetworkId.fromJson(json['networkId'])
        : null;
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    priceChange = json['priceChange'];
    isBuyable = json['isBuyable'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['routerProtocolContractAddress'] = this.routerProtocolContractAddress;
    data['routerProtocolReserveHandlerAddress'] =
        this.routerProtocolReserveHandlerAddress;
    data['isUserSpecific'] = this.isUserSpecific;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['icon'] = this.icon;
    data['coinGeckoId'] = this.coinGeckoId;
    data['isToken'] = this.isToken;
    data['contractAddress'] = this.contractAddress;
    data['decimal'] = this.decimal;
    data['price'] = this.price;
    if (this.networkId != null) {
      data['networkId'] = this.networkId!.toJson();
    }
    data['isDeleted'] = this.isDeleted;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['priceChange'] = this.priceChange;
    data['isBuyable'] = this.isBuyable;
    data['id'] = this.id;
    return data;
  }
}

class NetworkId {
  num? chainId;
  String? nativeCoinAddress;
  String? name;
  String? symbol;
  String? logoUrl;
  String? rpcUrl;
  String? chainName;
  String? networkName;
  String? networkType;
  bool? isDeleted;
  bool? isActive;
  String? id;

  NetworkId(
      {this.chainId,
        this.nativeCoinAddress,
        this.name,
        this.symbol,
        this.logoUrl,
        this.rpcUrl,
        this.chainName,
        this.networkName,
        this.networkType,
        this.isDeleted,
        this.isActive,
        this.id});

  NetworkId.fromJson(Map<String, dynamic> json) {
    chainId = json['chainId'];
    nativeCoinAddress = json['nativeCoinAddress'];
    name = json['name'];
    symbol = json['symbol'];
    logoUrl = json['logoUrl'];
    rpcUrl = json['rpcUrl'];
    chainName = json['chainName'];
    networkName = json['networkName'];
    networkType = json['networkType'];
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chainId'] = this.chainId;
    data['nativeCoinAddress'] = this.nativeCoinAddress;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['logoUrl'] = this.logoUrl;
    data['rpcUrl'] = this.rpcUrl;
    data['chainName'] = this.chainName;
    data['networkName'] = this.networkName;
    data['networkType'] = this.networkType;
    data['isDeleted'] = this.isDeleted;
    data['isActive'] = this.isActive;
    data['id'] = this.id;
    return data;
  }
}