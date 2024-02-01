import 'package:exercise_news_app/domain/entities/news.dart';
import 'package:exercise_news_app/domain/usecases/get_favorite_news.dart';
import 'package:exercise_news_app/domain/usecases/save_favorite_news.dart';
import 'package:riverpod/riverpod.dart';

final getFavoriteNewsList = GetFavoriteNewsList();
final saveFavoriteNewsList = SaveFavoriteNewsList();

class FavoriteNewsNotifier extends StateNotifier<List<News>> {
  FavoriteNewsNotifier() : super([]);

  void toggleFavorite(News news) {
    if (state.contains(news)) {
      state = List.from(state)..remove(news.copyWith(isFavorite: false));
      print('Unfavorite!');
    } else {
      state = List.from(state)..add(news.copyWith(isFavorite: true));
      print('Favorite!');
    }
  }

  Future<void> loadFavoriteNews() async {
    List<News> favoriteNews = await getFavoriteNewsList.execute();
    state = favoriteNews;
  }
}

final favoriteNewsProvider = StateNotifierProvider<FavoriteNewsNotifier, List<News>>((ref) {
  return FavoriteNewsNotifier();
});
