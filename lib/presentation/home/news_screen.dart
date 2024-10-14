import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/application/news_bloc.dart';
import 'package:news_app/core/const/string_const.dart';
import 'package:news_app/presentation/home/news_preview.dart';
import 'package:news_app/presentation/home/widget/custom_carousel_slider.dart';
import 'package:news_app/presentation/home/widget/news_card.dart';
import 'package:news_app/presentation/home/widget/title_row.dart';

class NewsScreen extends StatelessWidget {
  final VoidCallback onTap;
  const NewsScreen({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..onEvent(
          GetNewsEvent(StringConst.all),
        )
        ..onEvent(
          GetTopHeadlinesEvent('us'),
        ),
      child: NewsScreenConsumer(
        onTap: onTap,
      ),
    );
  }
}

class NewsScreenConsumer extends StatelessWidget {
  final VoidCallback onTap;
  const NewsScreenConsumer({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        return state.topHeadlinesNews == null || state.news == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TitleRow(
                      actionText: StringConst.viewAll,
                      onTap: onTap,
                      title: StringConst.topHeadlines,
                    ),
                    const SizedBox(height: 10),
                    CustomCarouselSlider(
                      articles: state.topHeadlinesNews!.articles,
                    ),
                    const SizedBox(height: 20),
                    TitleRow(
                      actionText: StringConst.viewAll,
                      onTap: onTap,
                      title: StringConst.recommendation,
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.news!.articles.length,
                      itemBuilder: (context, index) {
                        final article = state.news!.articles[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsPreview(
                                  webUrl: state.news!.articles[index].url,
                                ),
                              ),
                            );
                          },
                          child: NewsCard(
                            article: article,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
      },
    );
  }
}
