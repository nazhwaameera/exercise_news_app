import 'package:exercise_news_app/data/providers/favorite_news.dart';
import 'package:exercise_news_app/domain/entities/news.dart';
import 'package:exercise_news_app/domain/usecases/get_news.dart';
import 'package:exercise_news_app/presentation/widgets/card_news.dart';
import 'package:exercise_news_app/presentation/widgets/favorite_news_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'webview_page.dart';
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  ConsumerState<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends ConsumerState<HomePage> {
  late Future<void> _favoriteNews;
  @override
  void initState() {
    super.initState();
    _favoriteNews = ref.read(favoriteNewsProvider.notifier).loadFavoriteNews();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteNews = ref.watch(favoriteNewsProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('BSI News'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'News'),
              Tab(text: 'Favorites'),
            ],
          ),
        ),
        body: TabBarView(
            children: [
              // Content of Tab 1
              Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: FutureBuilder<List<News>>(
                future: GetNewsList().execute(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var listNews = snapshot.data!;
                    return ListView(
                        children: List.generate(listNews.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebViewScreen(url: listNews[index].newsUrl),
                                ),
                              );
                            },
                            child: CardNews(news: listNews[index]),
                          );
                        })
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return Text('There is no update on earth.');
                },
              ),
            ),
              // Content of Tab 2
              Container(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: _favoriteNews,
                  builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? const Center(child: CircularProgressIndicator())
                      : FavoriteNewsList(
                    news: favoriteNews,
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
