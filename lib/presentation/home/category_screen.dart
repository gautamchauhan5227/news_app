import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/application/news_bloc.dart';
import 'package:news_app/core/const/string_const.dart';
import 'package:news_app/presentation/home/news_preview.dart';
import 'package:news_app/presentation/home/widget/category_chip.dart';
import 'package:news_app/presentation/home/widget/news_card.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..onEvent(
          GetNewsEvent(StringConst.all),
        ),
      child: const CategoryScreenConsumer(),
    );
  }
}

class CategoryScreenConsumer extends StatelessWidget {
  const CategoryScreenConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryChip(
                      label: StringConst.all,
                      isSelected: state.category == StringConst.all,
                    ),
                    CategoryChip(
                      label: StringConst.politic,
                      isSelected: state.category == StringConst.politic,
                    ),
                    CategoryChip(
                      label: StringConst.sports,
                      isSelected: state.category == StringConst.sports,
                    ),
                    CategoryChip(
                      label: StringConst.education,
                      isSelected: state.category == StringConst.education,
                    ),
                    CategoryChip(
                      label: StringConst.gaming,
                      isSelected: state.category == StringConst.gaming,
                    ),
                    CategoryChip(
                      label: StringConst.health,
                      isSelected: state.category == StringConst.gaming,
                    ),
                    CategoryChip(
                      label: StringConst.technology,
                      isSelected: state.category == StringConst.technology,
                    ),
                    CategoryChip(
                      label: StringConst.entertainment,
                      isSelected: state.category == StringConst.entertainment,
                    ),
                    CategoryChip(
                      label: StringConst.business,
                      isSelected: state.category == StringConst.business,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (state.isLoading)
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3,
                  ),
                  child: const CircularProgressIndicator(),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
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
              ),
          ],
        );
      },
    );
  }
}
