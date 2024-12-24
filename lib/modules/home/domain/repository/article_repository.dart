import 'package:flutter_receipt/core/resources/data_state.dart';
import 'package:flutter_receipt/modules/home/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
}