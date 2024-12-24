import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quizz/services/firebase/user/model/user_model.dart';

Future<List<User>> fetchUsers() async {
  var response =
      await http.get(Uri.parse('http://192.168.1.7:5001/user/getall'));
  // await http.get(Uri.parse('http://172.20.10.2:5001/user/getall'));
  // await http.get(Uri.parse('http://172.16.18.78:5001/user/getall'));
  print(response.body);

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body)['data'];
    return data.map((user) => User.fromJson(user)).toList();
  } else {
    throw Exception('Failed to load user');
  }
}
