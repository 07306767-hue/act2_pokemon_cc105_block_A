import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);
  @override
  String toString() => message;
}

/// GET + timeout + status check + JSON decode, shared by every request.
Future<dynamic> getJson(String url) async {
  final http.Response res;
  try {
    res = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
  } on TimeoutException {
    throw const ApiException('The request timed out.');
  } catch (_) {
    throw const ApiException('Cannot reach the server. Check your connection.');
  }

  if (res.statusCode != 200) {
    throw ApiException('Server replied ${res.statusCode}.');
  }

  try {
    return jsonDecode(res.body);
  } on FormatException {
    throw const ApiException('Server sent unreadable data.');
  }
}
