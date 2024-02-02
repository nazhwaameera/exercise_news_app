import 'package:exercise_news_app/domain/entities/news.dart';
import 'package:exercise_news_app/presentation/pages/webview_page.dart';
import 'package:flutter/material.dart';

class FavoriteNewsList extends StatelessWidget {
  const FavoriteNewsList({super.key, required this.news});

  final List<News> news;
  @override
  Widget build(BuildContext context) {
    if (news.isEmpty) {
      return Center(
        child: Text(
          'No news added yet',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (ctx, index) => ListTile(
        title: Text(
          news[index].title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(url: news[index].newsUrl),
            ),
          );
        },
      ),
    );
  }
}
