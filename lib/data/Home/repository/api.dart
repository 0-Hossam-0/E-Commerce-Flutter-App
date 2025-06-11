import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:e_commerce/data/Home/models/home.dart';

class HomeServices {
  Future fetchHome({required int limit, required num skip}) async {
    final url = Uri.parse('https://dummyjson.com/products?limit=${limit}&skip=${skip}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> productsJson = data['products'];
      return productsJson.map((json) => Home.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
