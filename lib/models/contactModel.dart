class ContactModel {
  String? name;
  String? userId;
  String? address;
  String? networkType;
  String? id;

  ContactModel(
      {this.name, this.userId, this.address, this.networkType, this.id});

  ContactModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userId = json['userId'];
    address = json['address'];
    networkType = json['networkType'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['userId'] = this.userId;
    data['address'] = this.address;
    data['networkType'] = this.networkType;
    data['id'] = this.id;
    return data;
  }
}