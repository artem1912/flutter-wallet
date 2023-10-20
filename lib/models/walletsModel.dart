class WalletsModel {
  Wallet? wallet;

  WalletsModel({this.wallet});

  WalletsModel.fromJson(Map<String, dynamic> json) {
    wallet =
    json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wallet != null) {
      data['wallet'] = this.wallet!.toJson();
    }
    return data;
  }
}

class Wallet {
  String? name;
  String? logo;
  List<Wallets>? wallets;
  String? userId;
  String? type;
  String? network;
  String? createdAt;
  String? updatedAt;
  String? id;

  Wallet(
      {this.name,
        this.logo,
        this.wallets,
        this.userId,
        this.type,
        this.network,
        this.createdAt,
        this.updatedAt,
        this.id});

  Wallet.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'];
    if (json['wallets'] != null) {
      wallets = <Wallets>[];
      json['wallets'].forEach((v) {
        wallets!.add(new Wallets.fromJson(v));
      });
    }
    userId = json['userId'];
    type = json['type'];
    network = json['network'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.wallets != null) {
      data['wallets'] = this.wallets!.map((v) => v.toJson()).toList();
    }
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['network'] = this.network;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}

class Wallets {
  String? address;
  String? privateKey;
  String? type;
  String? logo;

  Wallets({this.address, this.privateKey, this.type, this.logo});

  Wallets.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    privateKey = json['privateKey'];
    type = json['type'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['privateKey'] = this.privateKey;
    data['type'] = this.type;
    data['logo'] = this.logo;
    return data;
  }
}