import 'package:news_app/core/local_model/article_model.dart';
import 'package:news_app/main.dart';
import 'package:news_app/service/isar_service.dart';

final isarService = IsarService<ArticleModel>(isar.articleModels);
String kUserName = '';
