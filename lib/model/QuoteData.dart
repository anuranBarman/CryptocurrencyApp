class QuoteData {
  // "price": 446022.7284582002,
  //                   "volume_24h": 319007246257.4999,
  //                   "percent_change_1h": 0.057,
  //                   "percent_change_24h": 4.9421,
  //                   "percent_change_7d": -3.5347,
  //                   "market_cap": 7676240716425.219,
  //                   "last_updated": "2018-08-15T06:45:10.000Z"

  num price;
  num percent_1h;
  num percent_24h;
  num percent_7d;
  num market_cap;
  num volume_24h;
  String last_updated;


  QuoteData(this.price,this.percent_1h,this.percent_24h,this.percent_7d,this.volume_24h,this.market_cap,this.last_updated);

  factory QuoteData.fromJSON(Map<String,dynamic> json){
    return QuoteData(json["price"],json["percent_change_1h"],json["percent_change_24h"],json["percent_change_7d"],json["volume_24h"],json["market_cap"],json["last_updated"]);
  }
}