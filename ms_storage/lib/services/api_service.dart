import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Updated to match your XAMPP server URL
  static const String baseUrl = 'http://localhost:8080/flutter/api';

  static Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: data,
    );
    return response;
  }

  static Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final response = await http.get(url);
    return response;
  }
}
