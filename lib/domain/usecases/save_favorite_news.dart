import 'package:exercise_news_app/data/repository/news_repository.dart';
import 'package:exercise_news_app/domain/entities/news.dart';

class SaveFavoriteNewsList {
  var repository = NewsRepository();

  Future<void> execute(News news) async {
    return repository.saveFavoriteNews(news);
  }
}