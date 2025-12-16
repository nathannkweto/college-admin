import 'dart:convert';
import 'package:flutter/foundation.dart'; // For debugPrint
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Import
import '../config.dart';

class ApiService {
  // Store the token in memory (for production, use flutter_secure_storage)
  static const _storage = FlutterSecureStorage();
  static String? _authToken;

  // 1. Initialize: Try to load token from disk on startup
  static Future<String?> loadToken() async {
    _authToken = await _storage.read(key: 'jwt_token');
    return _authToken;
  }

  static Future<void> setToken(String? token) async {
    _authToken = token;
    if (token != null) {
      await _storage.write(key: 'jwt_token', value: token);
    } else {
      await _storage.delete(key: 'jwt_token');
    }
  }

  static Map<String, String> get _headers {
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    // If we have a token, add it to the headers
    if (_authToken != null) {
      headers["Authorization"] = "Bearer $_authToken";
    }
    return headers;
  }

  static Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('${Config.baseUrl}$endpoint');
    debugPrint("POST Request to: $url");

    try {
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception("Network Error: $e");
    }
  }

  static Future<Map<String, dynamic>> get(String endpoint) async {
    final url = Uri.parse('${Config.baseUrl}$endpoint');
    debugPrint("GET Request to: $url");

    try {
      final response = await http.get(url, headers: _headers);
      return _processResponse(response);
    } catch (e) {
      throw Exception("Network Error: $e");
    }
  }

  static Map<String, dynamic> _processResponse(http.Response response) {
    debugPrint("Response Code: ${response.statusCode}");

    // Attempt to decode body
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : {};

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body is Map<String, dynamic> ? body : {"data": body};
    } else {
      throw Exception(body['message'] ?? "Server Error: ${response.statusCode}");
    }
  }
}