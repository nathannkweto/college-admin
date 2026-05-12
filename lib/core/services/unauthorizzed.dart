import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UnauthorizedInterceptorClient extends http.BaseClient {
  final http.Client _inner = http.Client();
  final VoidCallback onUnauthorized;

  UnauthorizedInterceptorClient({required this.onUnauthorized});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await _inner.send(request);

    // Check for 401, but IGNORE it if the request is for the login endpoint
    // to prevent infinite redirect loops on bad passwords.
    bool isLoginRequest = request.url.path.contains('/auth/login');

    if (response.statusCode == 401 && !isLoginRequest) {
      onUnauthorized();
    }

    return response;
  }
}