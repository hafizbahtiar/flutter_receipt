import 'package:flutter_receipt/core/resources/data_state.dart';
import 'package:flutter_receipt/modules/home/data/models/article_model.dart';
import 'package:flutter_receipt/modules/home/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() {
    throw UnimplementedError();
  }
}
