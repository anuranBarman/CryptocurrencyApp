class NewsModel {
//   "id": "333978",
// "guid": "http://cryptonewsreview.com/?p=4924",
// "published_on": 1534518162,
// "imageurl": "https://images.cryptocompare.com/news/cryptonewsreview/dFrz8oic21w.jpeg",
// "title": "California allows man to pay bail in Bitcoin",
// "url": "https://cryptonewsreview.com/california-allows-man-to-pay-bail-in-bitcoin/",
// "source": "cryptonewsreview",
// "body": "A defendant in California has been allowed by the US Federal Court to pay his bail fees in the form of Bitcoin or another cryptocurrency. According to reports, the man faced charges for hacking into video games company Electronic Arts, and was required to pay $750,000 bail. The federal judge in question allowed the money [&#8230;]The post California allows man to pay bail in Bitcoin appeared first on CryptoNewsReview.",
// "tags": "Crypto|News|California",
// "categories": "BTC",
// "upvotes": "0",
// "downvotes": "0",
// "lang": "EN",
// "source_info": {
// "name": "CryptoNewsReview",
// "lang": "EN",
// "img": "https://images.cryptocompare.com/news/default/cryptonewsreview.png"
// }

  String guid;
  int published_on;
  String imageURL;
  String title;
  String url;
  String source;
  String body;
  String name;
  String img;

  NewsModel(this.guid, this.published_on, this.imageURL, this.title, this.url,
      this.source, this.body, this.name, this.img);

  factory NewsModel.fromJSON(Map<String, dynamic> json) {
    return NewsModel(
        json["guid"],
        json["published_on"],
        json["imageurl"],
        json["title"],
        json["url"],
        json["source"],
        json["body"],
        json["source_info"]["name"],
        json["source_info"]["img"]);
  }
}
