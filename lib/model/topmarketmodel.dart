class TopMarketData {
  String fromSymbol;
  String toSymbol;
  String market;
  num price;

  TopMarketData(this.fromSymbol,this.toSymbol,this.market,this.price);

  factory TopMarketData.fromJSON(Map<String,dynamic> json){
    return TopMarketData(json["FROMSYMBOL"], json["TOSYMBOL"], json["MARKET"], json["PRICE"]);
  }
}