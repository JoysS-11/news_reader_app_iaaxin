import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iaaxin_task/constants/app_colors.dart';

import '../../controller/util_service.dart';
import '../../model/news_model.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({super.key, this.newsModel});
  final NewsModel? newsModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: AppColors.white,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        toolbarHeight: 0,
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(size.height * 0.015),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  size: size.height * 0.03,
                  color: AppColors.black,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    newsModel!.urlToImage != null
                        ? newsModel!.urlToImage!.isNotEmpty
                            ? Center(
                                child: Column(
                                  children: [
                                    Image.network(
                                      newsModel!.urlToImage.toString(),
                                    ),
                                    SizedBox(height: size.height * 0.02),
                                  ],
                                ),
                              )
                            : const SizedBox()
                        : const SizedBox(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.height * 0.015),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          newsModel!.title != null
                              ? newsModel!.title!.isNotEmpty
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          newsModel!.title.toString(),
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontSize: size.height * 0.018,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                      ],
                                    )
                                  : const SizedBox()
                              : const SizedBox(),
                          newsModel!.description != null
                              ? newsModel!.description!.isNotEmpty
                                  ? Column(
                                      children: [
                                        Text(
                                          newsModel!.description.toString(),
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontSize: size.height * 0.014,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                      ],
                                    )
                                  : const SizedBox()
                              : const SizedBox(),
                          newsModel!.publishedAt != null
                              ? newsModel!.publishedAt!.isNotEmpty
                                  ? Column(
                                      children: [
                                        Text(
                                          UtilService.formatingStringDate(
                                                  newsModel!.publishedAt
                                                      .toString(),
                                                  "dd-MM-yyyy")
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: size.height * 0.014,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                      ],
                                    )
                                  : const SizedBox()
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
