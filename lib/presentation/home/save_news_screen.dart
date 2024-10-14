import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/application/news_bloc.dart';
import 'package:news_app/core/const/string_const.dart';
import 'package:news_app/core/model/news_dto.dart';
import 'package:news_app/presentation/home/news_preview.dart';
import 'package:news_app/presentation/home/widget/news_card.dart';

class SaveNewsScreen extends StatelessWidget {
  const SaveNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..onEvent(GetLocalNewsEvent()),
      child: const SaveNewsScreenConsumer(),
    );
  }
}

class SaveNewsScreenConsumer extends StatelessWidget {
  const SaveNewsScreenConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state.localNews.isNotEmpty
                ? ListView.builder(
                    itemCount: state.localNews.length,
                    itemBuilder: (context, index) {
                      final data = state.localNews[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsPreview(
                                webUrl: data.url,
                              ),
                            ),
                          );
                        },
                        child: NewsCard(
                          article: Article(
                            source: Source(
                              name: data.sourceName,
                              id: data.id.toString(),
                            ),
                            title: data.title,
                            url: data.url,
                            publishedAt: data.publishedAt,
                            author: data.author,
                            content: data.content,
                            description: data.description,
                            urlToImage: data.urlToImage,
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(StringConst.noData),
                  );
      },
    );
  }
}
