part of 'news_bloc.dart';

class NewsState {
  final bool isLoading;
  final bool isSuccessful;
  final bool isFailed;
  final NewsResponse? news;
  final NewsResponse? topHeadlinesNews;
  final List<ArticleModel> localNews;
  final int currentIndex;
  final String category;

  const NewsState({
    required this.isLoading,
    required this.isFailed,
    this.news,
    this.topHeadlinesNews,
    required this.isSuccessful,
    this.currentIndex = 0,
    this.category = 'All',
    this.localNews = const [],
  });

  NewsState copyWith({
    bool? isLoading,
    bool? isSuccessful,
    bool? isFailed,
    NewsResponse? news,
    NewsResponse? topHeadlinesNews,
    int? currentIndex,
    String? category,
    List<ArticleModel>? localNews,
  }) {
    return NewsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccessful: isSuccessful ?? this.isSuccessful,
      isFailed: isFailed ?? this.isFailed,
      news: news ?? this.news,
      topHeadlinesNews: topHeadlinesNews ?? this.topHeadlinesNews,
      currentIndex: currentIndex ?? this.currentIndex,
      category: category ?? this.category,
      localNews: localNews ?? this.localNews,
    );
  }

  factory NewsState.initial() {
    return const NewsState(
      isLoading: false,
      isSuccessful: false,
      isFailed: false,
      currentIndex: 0,
      category: 'All',
      localNews: [],
    );
  }
}
