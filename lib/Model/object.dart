class Nesne{
  //resmi, başlığı, açıklaması, tarihi ve kaynak
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Nesne({
    required this.author,
    required this.content,
    required this.description,
    required this.publishedAt,
    required this.url,
    required this.title,
    required this.urlToImage,

  });
  factory Nesne.fromJson(Map<dynamic, dynamic> json) {
    return Nesne(
      author: json["author"]??"",
      content: json["content"]??"",
      description: json["description"]??"",
      publishedAt: json["publishedAt"]??"",
      url: json["url"]??"",
      title: json["title"]??"",
      urlToImage: json["urlToImage"]??"",
    );
  }



}