import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> register(
    String name, String username, String email, String password,
    [String role = "student"]) async {
  final response = await http.post(
    Uri.parse('http://192.168.18.171:5001/user/register'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'role': role,
    }),
  );

  if (response.statusCode == 201) {
    final responseData = json.decode(response.body);

    final userId = responseData['userId'];

    print('Registration Successful. User ID: $userId');
  } else {
    final errorData = json.decode(response.body);
    print('Registration failed: ${errorData['message']}');
  }
}
