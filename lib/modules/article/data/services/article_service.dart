import 'package:flutter_receipt/core/constants/api_endpoint.dart';
import 'package:flutter_receipt/core/utils/api_client.dart';

class ArticleService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>?> fetchArticles({
    required String apiKey,
    required String country,
  }) async {
    try {
      final response = await _apiClient.getRequest(
        ApiEndpoint.newsApiEndpoints.topHeadlines,
        params: {
          'apiKey': apiKey,
          'country': country,
        },
      );

      return response; // Returns the API response in a Map format
    } catch (e) {
      throw Exception('Failed to fetch articles: $e');
    }
  }
}
