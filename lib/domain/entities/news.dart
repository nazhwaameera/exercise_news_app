class News {
  String author;
  String title;
  String description;
  String newsUrl;
  String imgUrl;
  String publishedAt;
  bool isFavorite;

  News({
    required this.author,
    required this.title,
    required this.description,
    required this.newsUrl,
    required this.imgUrl,
    required this.publishedAt,
    this.isFavorite = false
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      author: json['author'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      newsUrl: json['url'] ?? "",
      imgUrl: json['urlToImage'] ?? "",
      publishedAt: json['publishedAt'] ?? "",
      isFavorite: false
    );
  }
  News copyWith({bool? isFavorite}) {
    return News(
      author: this.author,
      title: this.title,
      description: this.description,
      newsUrl: this.newsUrl,
      imgUrl: this.imgUrl,
      publishedAt: this.publishedAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
