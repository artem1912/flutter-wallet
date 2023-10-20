class SwapQuoteModel {
  String? swapAmount;
  String? recievedSwapedAmount;
  BridgeFee? bridgeFee;
  String? srcPriceImpact;
  String? destinationPriceImpact;
  bool? isSwapPossible;
  String? total;

  SwapQuoteModel(
      {this.swapAmount,
        this.recievedSwapedAmount,
        this.bridgeFee,
        this.srcPriceImpact,
        this.destinationPriceImpact,
        this.isSwapPossible,
        this.total});

  SwapQuoteModel.fromJson(Map<String, dynamic> json) {
    swapAmount = json['swapAmount'];
    recievedSwapedAmount = json['recievedSwapedAmount'];
    bridgeFee = json['bridgeFee'] != null
        ? new BridgeFee.fromJson(json['bridgeFee'])
        : null;
    srcPriceImpact = json['srcPriceImpact'];
    destinationPriceImpact = json['destinationPriceImpact'];
    isSwapPossible = json['isSwapPossible'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['swapAmount'] = this.swapAmount;
    data['recievedSwapedAmount'] = this.recievedSwapedAmount;
    if (this.bridgeFee != null) {
      data['bridgeFee'] = this.bridgeFee!.toJson();
    }
    data['srcPriceImpact'] = this.srcPriceImpact;
    data['destinationPriceImpact'] = this.destinationPriceImpact;
    data['isSwapPossible'] = this.isSwapPossible;
    data['total'] = this.total;
    return data;
  }
}

class BridgeFee {
  String? token;
  String? symbol;
  String? amount;
  String? amountInEth;
  double? amountInUSD;

  BridgeFee(
      {this.token,
        this.symbol,
        this.amount,
        this.amountInEth,
        this.amountInUSD});

  BridgeFee.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    symbol = json['symbol'];
    amount = json['amount'];
    amountInEth = json['amountInEth'];
    amountInUSD = json['amountInUSD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['symbol'] = this.symbol;
    data['amount'] = this.amount;
    data['amountInEth'] = this.amountInEth;
    data['amountInUSD'] = this.amountInUSD;
    return data;
  }
}