import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_receipt/modules/article/data/models/article_model.dart';
import 'package:flutter_receipt/modules/article/data/repository/article_repository.dart';

class ArticleProvider with ChangeNotifier {
  final ArticleRepository _articleRepository = ArticleRepository();

  List<ArticleModel> _articles = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ArticleModel> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> init() async {
    setLoading(true);
    await fetchArticles(apiKey: dotenv.env['NEWS_API_KEY']!, country: 'us');
    setLoading(false);
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchArticles({
    required String apiKey,
    required String country,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _articles = await _articleRepository.getArticles(
        apiKey: apiKey,
        country: country,
      );
    } catch (e) {
      _errorMessage = 'Failed to load articles: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
