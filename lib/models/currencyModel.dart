class CurrencyModel {
  String? name;
  String? symbol;
  String? coinGeckoId;
  String? logoUrl;
  bool? isDeleted;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  String? id;

  CurrencyModel(
      {this.name,
        this.symbol,
        this.coinGeckoId,
        this.logoUrl,
        this.isDeleted,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.id});

  CurrencyModel.fromJson(Map<String, dynamic> json) {
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