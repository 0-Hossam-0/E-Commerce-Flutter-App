import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:e_commerce/data/Categories/models/categories.dart';

class CategoriesServices {
  Future fetchCategories(String category) async {
    category = category.substring(0, category.length - 4);
    final url = Uri.parse('https://dummyjson.com/products/category/$category');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> productsJson = data['products'];
      return productsJson.map((json) => Categories.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
