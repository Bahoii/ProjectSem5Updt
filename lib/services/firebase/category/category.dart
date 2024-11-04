import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quizz/services/firebase/category/model/category_model.dart';

Future<void> fetchCategories() async {
  // final url = Uri.parse('http://172.16.18.78:5001/categories');
  // final url = Uri.parse('http://172.20.10.2:5001/categories');
  final url = Uri.parse('http://192.168.18.171:5001/categories');
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<Category> categories = (jsonResponse['data'] as List)
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList();

      print(categories);
    } else {
      throw Exception('Failed to load categories');
    }
  } catch (error) {
    print('Error fetching categories: $error');
  }
}
