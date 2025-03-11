import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/config.dart';

class ApiService {
  
  final String baseUrl = Config.baseUrl;
  
  
  Future<dynamic> getRequest(String fichierPhp, {Map<String, String>? queryParams}) async {
    
    Uri url = Uri.parse('$baseUrl/backend/$fichierPhp').replace(queryParameters: queryParams);
    
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur serveur: ${response.statusCode}');
    }
  }

  Future<dynamic> postRequest(String fichierPhp, Map<String, dynamic> data) async {
    Uri url = Uri.parse('$baseUrl/backend/$fichierPhp');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur serveur: ${response.statusCode}');
    }
  }
}