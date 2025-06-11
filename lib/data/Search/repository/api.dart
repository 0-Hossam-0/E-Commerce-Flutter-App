import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_commerce/data/Search/models/search.dart';

class SearchServices {
  Future<List<Search>> fetchSearch(String search) async {
    final url = Uri.parse('https://dummyjson.com/products/search?q=$search');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> productsJson = data['products'];
      return productsJson.map((json) => Search.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search products: ${response.statusCode}');
    }
  }
}