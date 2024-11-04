import 'package:quizz/services/firebase/course/model/course_model.dart';

class QuizModel {
  final String quizId;
  final Course course;
  final String title;
  final int totalMarks;

  QuizModel({
    required this.quizId,
    required this.course,
    required this.title,
    required this.totalMarks,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    try {
      return QuizModel(
        quizId: json['id'] ?? 'No ID',
        course: Course.fromJson(json['course']),
        title: json['title'] ?? 'No Title',
        totalMarks: json['totalMarks'] ?? 0,
      );
    } catch (e) {
      print('Error in QuizModel.fromJson: $e');
      throw Exception('Error parsing QuizModel dataaaa');
    }
  }
}
