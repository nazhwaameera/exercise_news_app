import 'package:exercise_news_app/data/repository/news_repository.dart';
import 'package:exercise_news_app/domain/entities/news.dart';

class GetNewsList {
  var repository = NewsRepository();

  Future<List<News>> execute() async {
    return repository.getNewsData();
  }


}