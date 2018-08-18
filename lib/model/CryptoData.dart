import 'QuoteData.dart';

class CryptoData {
  int id;
  String name;
  String symbol;
  String lastUpdated;
  num total_supply;
  QuoteData quoteData;

  CryptoData(this.id,this.name,this.symbol,this.total_supply,this.lastUpdated,this.quoteData);

  factory CryptoData.fromJSON(Map<String,dynamic> json) {
    return CryptoData(json["id"], json["name"], json["symbol"],json["total_supply"],json["last_updated"],QuoteData.fromJSON(json["quote"]["INR"]));
  }

}