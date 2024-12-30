import 'package:flutter_receipt/modules/article/data/models/article_model.dart';
import 'package:flutter_receipt/modules/article/data/services/article_service.dart';

class ArticleRepository {
  final ArticleService _articleService = ArticleService();

  Future<List<ArticleModel>> getArticles({
    required String apiKey,
    required String country,
  }) async {
    try {
      final response = await _articleService.fetchArticles(
        apiKey: apiKey,
        country: country,
      );

      if (response != null && response['articles'] != null) {
        // Parse the list of articles into ArticleModel objects
        print(response['articles'][0]['id']);
        print(response['articles'][0]['author']);
        print(response['articles'][0]['title']);
        print(response['articles'][0]['description']);
        print(response['articles'][0]['url']);
        print(response['articles'][0]['urlToImage']);
        print(response['articles'][0]['publishedAt']);
        print(response['articles'][0]['content']);
        List<ArticleModel> articles =
            (response['articles'] as List<dynamic>).map((articleData) => ArticleModel.fromJson(articleData)).toList();
        return articles;
      } else {
        throw Exception('No articles found');
      }
    } catch (e) {
      throw Exception('Failed to fetch articles: $e');
    }
  }
}
