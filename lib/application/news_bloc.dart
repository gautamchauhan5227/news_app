import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/const/app_const.dart';
import 'package:news_app/core/local_model/article_model.dart';
import 'package:news_app/core/model/news_dto.dart';
import 'package:news_app/service/network_service.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsState.initial());

  final NetworkService networkService = NetworkService.create();
  Future<void> fetchNews(String key) async {
    emit(
      state.copyWith(
        isLoading: true,
        news: null,
      ),
    );
    try {
      final response = await networkService.searchArticles(
        key,
      );

      final bodyData = jsonDecode(response.bodyString) as Map<String, dynamic>;

      final newsResponse = NewsResponse.fromJson(bodyData);
      newsResponse.articles
          .sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
      newsResponse.articles.removeWhere((e) => e.title == '[Removed]');

      emit(
        state.copyWith(
          news: newsResponse,
          isSuccessful: true,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isFailed: true,
          isLoading: false,
        ),
      );
    }
  }

  Future<void> fetchHeadlines(String key) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    try {
      final response = await networkService.getTopHeadlines(
        key,
      );

      final bodyData = jsonDecode(response.bodyString) as Map<String, dynamic>;

      final newsResponse = NewsResponse.fromJson(bodyData);
      newsResponse.articles
          .sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
      newsResponse.articles.removeWhere((e) => e.title == '[Removed]');
      emit(
        state.copyWith(
          topHeadlinesNews: newsResponse,
          isSuccessful: true,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isFailed: true,
          isLoading: false,
        ),
      );
    }
  }

  Future<void> getLocalNews() async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    try {
      final allNews = await isarService.findAll();
      allNews.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
      allNews.removeWhere((e) => e.title == '[Removed]');
      emit(
        state.copyWith(
          localNews: allNews,
          isSuccessful: true,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isFailed: true,
          isLoading: false,
        ),
      );
    }
  }

  Future<void> changeIndex(int index) async {
    emit(
      state.copyWith(
        currentIndex: index,
      ),
    );
  }

  Future<void> changeCategory(String category) async {
    emit(
      state.copyWith(
        category: category,
      ),
    );
  }

  void onEvent(NewsEvent event) {
    if (event is GetNewsEvent) {
      fetchNews(event.key);
    } else if (event is GetTopHeadlinesEvent) {
      fetchHeadlines(event.key);
    } else if (event is ChanegCurrentIndexEvent) {
      changeIndex(event.index);
    } else if (event is ChanegCategoryEvent) {
      changeCategory(event.name);
    } else if(event is GetLocalNewsEvent){
      getLocalNews();
    }
  }
}
