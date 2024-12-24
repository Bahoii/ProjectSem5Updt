import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quizz/services/firebase/quiz/model/quiz_model.dart';

Future<List<QuizModel>> fetchQuiz() async {
  var response =
      await http.get(Uri.parse('http://192.168.1.7:5001/quiz/getall'));
  // await http.get(Uri.parse('http://172.20.10.2:5001/quiz/getall'));
  // await http.get(Uri.parse('http://172.16.18.78:5001/quiz/getall'));

  if (response.statusCode == 200) {
    var decodedResponse = json.decode(response.body);

    print(
        'Decoded Response Data Quiz Structure: ${json.encode(decodedResponse)}');

    if (decodedResponse != null && decodedResponse.containsKey('data')) {
      List<dynamic> data = decodedResponse['data'] ?? [];

      try {
        return data
            .where((quiz) => quiz != null && quiz is Map<String, dynamic>)
            .map((quiz) => QuizModel.fromJson(quiz as Map<String, dynamic>))
            .toList();
      } catch (e) {
        print('Error during parsing Quiz: $e');
        throw Exception('Error parsing Quiz dataA');
      }
    } else {
      throw Exception('Data key not found in response');
    }
  } else {
    throw Exception('Failed to fetch quiz: ${response.statusCode}');
  }
}
