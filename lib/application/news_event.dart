part of 'news_bloc.dart';

abstract class NewsEvent {}

class GetNewsEvent extends NewsEvent {
  final String key;
  GetNewsEvent(this.key);
}

class GetTopHeadlinesEvent extends NewsEvent {
  final String key;
  GetTopHeadlinesEvent(this.key);
}

class ChanegCurrentIndexEvent extends NewsEvent {
  final int index;
  ChanegCurrentIndexEvent(this.index);
}

class ChanegCategoryEvent extends NewsEvent {
  final String name;
  ChanegCategoryEvent(this.name);
}

class GetLocalNewsEvent extends NewsEvent {
  GetLocalNewsEvent();
}
