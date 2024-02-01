import 'dart:convert';

import 'package:exercise_news_app/data/datasource/news_local_data_source.dart';
import 'package:exercise_news_app/data/datasource/news_remote_data_source.dart';
import 'package:exercise_news_app/domain/entities/news.dart';

class NewsRepository {
  var remoteNewsDataSource = RemoteNewsDataSource();
  var localNewsDataSource = NewsHiveDataSource();

  Future<List<News>> getNewsData() async {
    var jsonArray = jsonDecode(await remoteNewsDataSource.getNewsData())['articles'];
    var listNews = <News>[];

    listNews = jsonArray
        .where((jsonNews) => jsonNews['urlToImage'] != '' && jsonNews['urlToImage'].isNotEmpty)
        .take(10)
        .map<News>((jsonNews) => News.fromJson(jsonNews))
        .toList();

    return listNews;
  }

  Future<List<News>> getFavoriteNews() {
    return localNewsDataSource.getFavoriteNews();
  }

  Future<void> saveFavoriteNews(News news) {
    return localNewsDataSource.saveFavoriteNews(news);
  }
}
