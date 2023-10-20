class CoinPriceData {
  Response? response;

  CoinPriceData({this.response});

  CoinPriceData.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  String? quoteId;
  double? conversionPrice;
  double? marketConversionPrice;
  double? slippage;
  String? fiatCurrency;
  String? cryptoCurrency;
  String? paymentMethod;
  String? processingTime;
  int? fiatAmount;
  dynamic cryptoAmount;
  String? isBuyOrSell;
  String? network;
  double? feeDecimal;
  dynamic totalFee;
  List<FeeBreakdown>? feeBreakdown;
  int? nonce;
  String? cryptoLiquidityProvider;

  Response(
      {this.quoteId,
        this.conversionPrice,
        this.marketConversionPrice,
        this.slippage,
        this.fiatCurrency,
        this.cryptoCurrency,
        this.paymentMethod,
        this.processingTime,
        this.fiatAmount,
        this.cryptoAmount,
        this.isBuyOrSell,
        this.network,
        this.feeDecimal,
        this.totalFee,
        this.feeBreakdown,
        this.nonce,
        this.cryptoLiquidityProvider});

  Response.fromJson(Map<String, dynamic> json) {
    quoteId = json['quoteId'];
    conversionPrice = json['conversionPrice'].toDouble();
    marketConversionPrice = json['marketConversionPrice'].toDouble();
    slippage = json['slippage'].toDouble();
    fiatCurrency = json['fiatCurrency'];
    cryptoCurrency = json['cryptoCurrency'];
    paymentMethod = json['paymentMethod'];
    processingTime = json['processingTime'];
    fiatAmount = json['fiatAmount'];
    cryptoAmount = json['cryptoAmount'];
    isBuyOrSell = json['isBuyOrSell'];
    network = json['network'];
    feeDecimal = json['feeDecimal'].toDouble();
    totalFee = json['totalFee'];
    if (json['feeBreakdown'] != null) {
      feeBreakdown = <FeeBreakdown>[];
      json['feeBreakdown'].forEach((v) {
        feeBreakdown!.add(new FeeBreakdown.fromJson(v));
      });
    }
    nonce = json['nonce'];
    cryptoLiquidityProvider = json['cryptoLiquidityProvider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quoteId'] = this.quoteId;
    data['conversionPrice'] = this.conversionPrice;
    data['marketConversionPrice'] = this.marketConversionPrice;
    data['slippage'] = this.slippage;
    data['fiatCurrency'] = this.fiatCurrency;
    data['cryptoCurrency'] = this.cryptoCurrency;
    data['paymentMethod'] = this.paymentMethod;
    data['processingTime'] = this.processingTime;
    data['fiatAmount'] = this.fiatAmount;
    data['cryptoAmount'] = this.cryptoAmount;
    data['isBuyOrSell'] = this.isBuyOrSell;
    data['network'] = this.network;
    data['feeDecimal'] = this.feeDecimal;
    data['totalFee'] = this.totalFee;
    if (this.feeBreakdown != null) {
      data['feeBreakdown'] = this.feeBreakdown!.map((v) => v.toJson()).toList();
    }
    data['nonce'] = this.nonce;
    data['cryptoLiquidityProvider'] = this.cryptoLiquidityProvider;
    return data;
  }
}

class FeeBreakdown {
  String? name;
  dynamic value;
  String? id;
  List<String>? ids;

  FeeBreakdown({this.name, this.value, this.id, this.ids});

  FeeBreakdown.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    id = json['id'];
    ids = json['ids'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    data['id'] = this.id;
    data['ids'] = this.ids;
    return data;
  }
}