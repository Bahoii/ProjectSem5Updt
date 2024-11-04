import 'dart:convert';
import 'package:quizz/services/firebase/feedback/model/feedback_model.dart';
import 'package:http/http.dart' as http;

Future<List<Feedback>> fetchFeedback() async {
  var response =
      // await http.get(Uri.parse('http://192.168.18.171:5001/feedback/getall'));
      await http.get(Uri.parse('http://172.20.10.2:5001/feedback/getall'));
  // await http.get(Uri.parse('http://172.16.18.78:5001/feedback/getall'));

  if (response.statusCode == 200) {
    var decodedResponse = json.decode(response.body);

    print('Decoded Response: $decodedResponse');

    if (decodedResponse != null && decodedResponse.containsKey('data')) {
      List<dynamic> data = decodedResponse['data'] ?? [];

      try {
        return data
            .where((feedback) =>
                feedback != null && feedback is Map<String, dynamic>)
            .map((feedback) =>
                Feedback.fromJson(feedback as Map<String, dynamic>))
            .toList();
      } catch (e) {
        print('Error during parsing Feedback: $e');
        throw Exception('Error parsing feedback data');
      }
    } else {
      throw Exception('Data key not found in response');
    }
  } else {
    throw Exception('Failed to fetch feedback: ${response.statusCode}');
  }
}
