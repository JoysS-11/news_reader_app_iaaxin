import 'package:flutter/material.dart';
import 'package:iaaxin_task/controller/util_service.dart';
import 'package:iaaxin_task/model/news_model.dart';
import 'package:iaaxin_task/view/news/news_detail.dart';

import '../../constants/app_colors.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    this.newsModel,
    this.isLocalNews,
  });
  final NewsModel? newsModel;
  final bool? isLocalNews;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.height * 0.015),
      child: InkWell(
        onTap: isLocalNews != true
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => NewsDetailScreen(newsModel: newsModel)),
                );
              }
            : () {},
        borderRadius: BorderRadius.circular(size.height * 0.015),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(size.height * 0.015),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                color: AppColors.black.withOpacity(0.5),
                blurRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              newsModel!.urlToImage != null
                  ? newsModel!.urlToImage!.isNotEmpty
                      ? Ink(
                          height: size.height / 5,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(size.height * 0.015),
                            image: DecorationImage(
                              image: NetworkImage(
                                  newsModel!.urlToImage.toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : const SizedBox()
                  : const SizedBox(),
              SizedBox(height: size.height * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    newsModel!.title != null
                        ? newsModel!.title!.isNotEmpty
                            ? Text(
                                newsModel!.title.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: size.height * 0.018,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : const SizedBox()
                        : const SizedBox(),
                    newsModel!.description != null
                        ? newsModel!.description!.isNotEmpty
                            ? Text(
                                newsModel!.description.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: size.height * 0.014,
                                  color: AppColors.black,
                                ),
                              )
                            : const SizedBox()
                        : const SizedBox(),
                    SizedBox(height: size.height * 0.005),
                    newsModel!.publishedAt != null
                        ? newsModel!.publishedAt!.isNotEmpty
                            ? Text(
                                UtilService.formatingStringDate(
                                        newsModel!.publishedAt.toString(),
                                        "dd-MM-yyyy")
                                    .toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: size.height * 0.012,
                                  color: Colors.grey,
                                ),
                              )
                            : const SizedBox()
                        : const SizedBox(),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.01),
            ],
          ),
        ),
      ),
    );
  }
}
