class UserModel {
  String? fullname;
  String? image;
  String? email;
  String? username;
  String? phone;
  String? bankName;
  String? accountNumber;
  String? accountName;
  String? authSecret;
  String? authUrl;
  bool? isAuthEnabled;
  bool? isBiometricEnabled;
  bool? isAdmin;
  bool? isSuperAdmin;
  bool? isVerified;
  bool? isActive;
  bool? isDeleted;
  String? currencyId;
  String? createdAt;
  String? updatedAt;
  int? iV;
  Currency? currency;
  String? id;

  UserModel(
      {this.fullname,
        this.image,
        this.email,
        this.username,
        this.phone,
        this.bankName,
        this.accountNumber,
        this.accountName,
        this.authSecret,
        this.authUrl,
        this.isAuthEnabled,
        this.isBiometricEnabled,
        this.isAdmin,
        this.isSuperAdmin,
        this.isVerified,
        this.isActive,
        this.isDeleted,
        this.currencyId,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.currency,
        this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    image = json['image'];
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    accountName = json['accountName'];
    authSecret = json['authSecret'];
    authUrl = json['authUrl'];
    isAuthEnabled = json['isAuthEnabled'];
    isBiometricEnabled = json['isBiometricEnabled'];
    isAdmin = json['isAdmin'];
    isSuperAdmin = json['isSuperAdmin'];
    isVerified = json['isVerified'];
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    currencyId = json['currencyId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['image'] = this.image;
    data['email'] = this.email;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['bankName'] = this.bankName;
    data['accountNumber'] = this.accountNumber;
    data['accountName'] = this.accountName;
    data['authSecret'] = this.authSecret;
    data['authUrl'] = this.authUrl;
    data['isAuthEnabled'] = this.isAuthEnabled;
    data['isBiometricEnabled'] = this.isBiometricEnabled;
    data['isAdmin'] = this.isAdmin;
    data['isSuperAdmin'] = this.isSuperAdmin;
    data['isVerified'] = this.isVerified;
    data['isActive'] = this.isActive;
    data['isDeleted'] = this.isDeleted;
    data['currencyId'] = this.currencyId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Currency {
  String? sId;
  String? name;
  String? symbol;
  String? coinGeckoId;
  String? logoUrl;
  bool? isDeleted;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? id;

  Currency(
      {this.sId,
        this.name,
        this.symbol,
        this.coinGeckoId,
        this.logoUrl,
        this.isDeleted,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.id});

  Currency.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    symbol = json['symbol'];
    coinGeckoId = json['coinGeckoId'];
    logoUrl = json['logoUrl'];
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['coinGeckoId'] = this.coinGeckoId;
    data['logoUrl'] = this.logoUrl;
    data['isDeleted'] = this.isDeleted;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['id'] = this.id;
    return data;
  }
}