class DailyCoinData {
  DateTime time;
  num price;

  DailyCoinData(this.time,this.price);


  factory DailyCoinData.fromJSON(Map<String,dynamic> json){
    return DailyCoinData(DateTime.fromMillisecondsSinceEpoch(json["time"]*1000),json["close"],);
  }
}