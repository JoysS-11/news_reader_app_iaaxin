import 'package:flutter/material.dart';
import 'package:iaaxin_task/model/news_model.dart';
import 'package:iaaxin_task/view/news/news_card.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key, this.news, this.isLocalNews});
  final List<NewsModel>? news;
  final bool? isLocalNews;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return ListView.separated(
      itemCount: news!.length,
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      separatorBuilder: (context, index) {
        return SizedBox(height: size.height * 0.02);
      },
      itemBuilder: (context, index) {
        return NewsCard(
          newsModel: news![index],
          isLocalNews: isLocalNews,
        );
      },
    );
  }
}
