import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductServices {
  Future fetchProduct() async {
    final url = Uri.parse('https://fakestoreapi.com/auth/Product');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final token = json.decode(response.body)['token'];
      return token;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
