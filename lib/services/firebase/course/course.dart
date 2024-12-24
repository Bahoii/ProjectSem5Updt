import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quizz/services/firebase/course/model/course_model.dart';

Future<List<Course>> fetchCourses() async {
  var response =
      await http.get(Uri.parse('http://192.168.1.7:5001/course/getall'));
  // await http.get(Uri.parse('http://172.20.10.2:5001/course/getall'));
  // await http.get(Uri.parse('http://172.16.18.78:5001/course/getall'));

  if (response.statusCode == 200) {
    var decodedResponse = json.decode(response.body);

    print('Decoded Response: $decodedResponse');

    if (decodedResponse != null && decodedResponse.containsKey('data')) {
      List<dynamic> data = decodedResponse['data'] ?? [];

      try {
        return data
            .where((course) => course != null && course is Map<String, dynamic>)
            .map((course) => Course.fromJson(course as Map<String, dynamic>))
            .toList();
      } catch (e) {
        print('Error during parsing Course: $e');
        throw Exception('Error parsing course data');
      }
    } else {
      throw Exception('Data key not found in response');
    }
  } else {
    throw Exception('Failed to load courses');
  }
}
