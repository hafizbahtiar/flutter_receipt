class ApiEndpoint {
  // Grouped endpoints as static const for easy access
  static const NewsApiEndpoints newsApiEndpoints = NewsApiEndpoints();

  // Other standalone endpoints
  static const String listCountry = 'listCountry';
}

// Group for "News Api" related endpoints
class NewsApiEndpoints {
  const NewsApiEndpoints();
  final String topHeadlines = '/top-headlines';
}
