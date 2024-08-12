class Stock {
  String? ticker;
  double? value;

  Stock({this.ticker, this.value});

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      ticker: json['ticker'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticker': ticker,
      'value': value,
    };
  }
}