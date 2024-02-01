import 'package:exercise_news_app/domain/entities/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:exercise_news_app/data/providers/favorite_news.dart';
import 'package:exercise_news_app/domain/usecases/get_favorite_news.dart';
import 'package:exercise_news_app/domain/usecases/save_favorite_news.dart';

class CardNews extends StatelessWidget {
  final News news;
  final saveFavoriteNewsList = SaveFavoriteNewsList();
  //String author, title, description, newsUrl, imgUrl, publishedAt;

  CardNews({super.key, required this.news});

  String formatIso8601Time(String iso8601Time) {
    DateTime dateTime = DateTime.parse(iso8601Time);
    String formattedTime = DateFormat.yMMMMd().add_jms().format(dateTime);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child){
        String formattedTime = formatIso8601Time(news.publishedAt);
      return Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Stack(
          children: [Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.network(
                    news.imgUrl,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                    // if the image is null
                    errorBuilder: (BuildContext context,
                        Object exception, StackTrace? stackTrace) {
                      return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: const SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Icon(Icons.broken_image_outlined),
                        ),
                      );
                    },
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  news.title,
                  maxLines: 2,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  '${news.author} - ${formattedTime}',
                  maxLines: 2,
                  style: const TextStyle(
                      color: Colors.black54, fontSize: 14),
                ),
              ),
              SizedBox(height: 20,),

            ],
          ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(
                  news.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: news.isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  ref.read(favoriteNewsProvider.notifier).toggleFavorite(news);
                  saveFavoriteNewsList.execute(news);
                },
              ),
            ),
          ]
        ),
      );}
    );
  }
}
