import 'package:exercise_news_app/domain/entities/news.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NewsHiveDataSource{
  static const String boxName = 'newsBox';
  static const String newsKey = 'news';
  late var box;

  Future<List<News>> getFavoriteNews() async {
    box = Hive.box(boxName);
    var favoriteNews = box.get(newsKey, defaultValue: '');
    return favoriteNews;
  }

  Future<void> saveFavoriteNews(News news) async {
    box = Hive.box(boxName);
    await box.put(newsKey, news);
  }
}