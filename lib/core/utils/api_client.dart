import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Singleton class for managing API requests, device information, and user session handling.
class ApiClient {
  // Singleton instance
  static final ApiClient _instance = ApiClient._internal();

  // Factory constructor for singleton instance
  factory ApiClient() => _instance;

  // Private constructor
  ApiClient._internal();

  // Dependencies
  final String _baseUrl = dotenv.env['BASE_URL']!;

  static const Duration _defaultTimeout = Duration(seconds: 30);

  // =====================================================================================
  // MARK: - REST API
  // =====================================================================================

  Future<Map<String, dynamic>?> getRequest(
    String endpoint, {
    bool includeToken = true,
    Duration timeout = _defaultTimeout,
    String? domain,
    Map<String, dynamic>? params,
  }) async {
    try {
      final token = null;
      // final token = includeToken ? await _retrieveToken() : null;
      final response = await http
          .get(
            _buildUri(endpoint, domain: domain, params: params),
            headers: _buildHeaders(token),
          )
          .timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      return _createErrorResponse('Error during GET at URL: $_baseUrl$endpoint');
    }
  }

  Future<Map<String, dynamic>?> postRequest(
    String endpoint,
    Object body, {
    bool includeToken = true,
    Duration timeout = _defaultTimeout,
    String? domain,
    Map<String, dynamic>? params,
  }) async {
    try {
      final token = null;
      // final token = includeToken ? await _retrieveToken() : null;
      final response = await http
          .post(
            _buildUri(endpoint, domain: domain, params: params),
            headers: _buildHeaders(token),
            body: jsonEncode(body),
          )
          .timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      return _createErrorResponse('Error during POST at URL: $_baseUrl$endpoint');
    }
  }

  Future<Map<String, dynamic>?> putRequest(
    String endpoint, {
    Object? body,
    bool includeToken = true,
    Duration timeout = _defaultTimeout,
    String? domain,
    Map<String, dynamic>? params,
  }) async {
    try {
      final token = null;
      // final token = includeToken ? await _retrieveToken() : null;
      final response = await http
          .put(
            _buildUri(endpoint, domain: domain, params: params),
            headers: _buildHeaders(token),
            body: jsonEncode(body),
          )
          .timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      return _createErrorResponse('Error during PUT at URL: $_baseUrl$endpoint');
    }
  }

  // =====================================================================================
  // MARK: - Helpers
  // =====================================================================================

  /// Build a URI with optional domain and query parameters.
  Uri _buildUri(String endpoint, {String? domain, Map<String, dynamic>? params}) {
    // Use the provided domain or fall back to the default base URL
    final base = domain ?? _baseUrl;

    // Construct the full URL with query parameters if provided
    final uri = Uri.parse('$base$endpoint').replace(queryParameters: params);

    return uri;
  }

  /// Build headers with an optional token
  Map<String, String> _buildHeaders(String? token) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

  /// Handle the HTTP response
  Map<String, dynamic> _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    if (response.body.isEmpty) return _createErrorResponse('No response from server');
    try {
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (statusCode == 200 || statusCode == 400) return data;
      return {'status': 'failed', 'data': data};
    } catch (e) {
      return _createErrorResponse('Invalid response format');
    }
  }

  /// Create an error response
  Map<String, dynamic> _createErrorResponse(String message) => {'status': 'error', 'message': message};

  /// Retrieves the current platform as a string (e.g., Android, iOS, macOS).
  Future<String> getPlatform() async {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'Android';
      case TargetPlatform.iOS:
        return 'iOS';
      case TargetPlatform.fuchsia:
        return 'Fuchsia';
      case TargetPlatform.linux:
        return 'Linux';
      case TargetPlatform.macOS:
        return 'macOS';
      case TargetPlatform.windows:
        return 'Windows';
    }
  }
}
