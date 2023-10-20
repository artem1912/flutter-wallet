class SendResponseModel {
  String? status;
  bool? transfer;
  TxHash? txHash;
  String? trxHash;

  SendResponseModel({this.status, this.transfer, this.txHash, this.trxHash});

  SendResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    transfer = json['transfer'];
    txHash =
    json['txHash'] != null ? new TxHash.fromJson(json['txHash']) : null;
    trxHash = json['trxHash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['transfer'] = this.transfer;
    if (this.txHash != null) {
      data['txHash'] = this.txHash!.toJson();
    }
    data['trxHash'] = this.trxHash;
    return data;
  }
}

class TxHash {
  String? blockHash;
  num? blockNumber;
  String? contractAddress;
  num? cumulativeGasUsed;
  num? effectiveGasPrice;
  String? from;
  num? gasUsed;
  List<Logs>? logs;
  String? logsBloom;
  bool? status;
  String? to;
  String? transactionHash;
  num? transactionIndex;
  String? type;

  TxHash(
      {this.blockHash,
        this.blockNumber,
        this.contractAddress,
        this.cumulativeGasUsed,
        this.effectiveGasPrice,
        this.from,
        this.gasUsed,
        this.logs,
        this.logsBloom,
        this.status,
        this.to,
        this.transactionHash,
        this.transactionIndex,
        this.type});

  TxHash.fromJson(Map<String, dynamic> json) {
    blockHash = json['blockHash'];
    blockNumber = json['blockNumber'];
    contractAddress = json['contractAddress'];
    cumulativeGasUsed = json['cumulativeGasUsed'];
    effectiveGasPrice = json['effectiveGasPrice'];
    from = json['from'];
    gasUsed = json['gasUsed'];
    if (json['logs'] != null) {
      logs = <Logs>[];
      json['logs'].forEach((v) {
        logs!.add(new Logs.fromJson(v));
      });
    }
    logsBloom = json['logsBloom'];
    status = json['status'];
    to = json['to'];
    transactionHash = json['transactionHash'];
    transactionIndex = json['transactionIndex'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blockHash'] = this.blockHash;
    data['blockNumber'] = this.blockNumber;
    data['contractAddress'] = this.contractAddress;
    data['cumulativeGasUsed'] = this.cumulativeGasUsed;
    data['effectiveGasPrice'] = this.effectiveGasPrice;
    data['from'] = this.from;
    data['gasUsed'] = this.gasUsed;
    if (this.logs != null) {
      data['logs'] = this.logs!.map((v) => v.toJson()).toList();
    }
    data['logsBloom'] = this.logsBloom;
    data['status'] = this.status;
    data['to'] = this.to;
    data['transactionHash'] = this.transactionHash;
    data['transactionIndex'] = this.transactionIndex;
    data['type'] = this.type;
    return data;
  }
}

class Logs {
  String? address;
  List<String>? topics;
  String? data;
  num? blockNumber;
  String? transactionHash;
  num? transactionIndex;
  String? blockHash;
  num? logIndex;
  bool? removed;
  String? id;

  Logs(
      {this.address,
        this.topics,
        this.data,
        this.blockNumber,
        this.transactionHash,
        this.transactionIndex,
        this.blockHash,
        this.logIndex,
        this.removed,
        this.id});

  Logs.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    topics = json['topics'].cast<String>();
    data = json['data'];
    blockNumber = json['blockNumber'];
    transactionHash = json['transactionHash'];
    transactionIndex = json['transactionIndex'];
    blockHash = json['blockHash'];
    logIndex = json['logIndex'];
    removed = json['removed'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['topics'] = this.topics;
    data['data'] = this.data;
    data['blockNumber'] = this.blockNumber;
    data['transactionHash'] = this.transactionHash;
    data['transactionIndex'] = this.transactionIndex;
    data['blockHash'] = this.blockHash;
    data['logIndex'] = this.logIndex;
    data['removed'] = this.removed;
    data['id'] = this.id;
    return data;
  }
}