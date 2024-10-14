import 'package:isar/isar.dart';

part 'article_model.g.dart';

@collection
class ArticleModel {
  Id id = Isar.autoIncrement; // Primary key

  late String sourceName;
  late String sourceId;
  String? author;
  late String title;
  String? description;
  late String url;
  String? urlToImage;
  late String publishedAt;
  String? content;

  ArticleModel({
    required this.sourceName,
    required this.sourceId,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });
}
