import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quizz/services/firebase/user/model/user_model.dart';

Future<User?> login(String username, String password) async {
  final response = await http.post(
    Uri.parse('http://192.168.18.171:5001/user/login'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "username": username,
      "password": password,
    }),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    if (data['success']) {
      return User.fromJson(data['userData']);
    } else {
      throw Exception(data['message'] ?? 'Login failed');
    }
  } else {
    throw ('Username atau Password salah');
  }
}
