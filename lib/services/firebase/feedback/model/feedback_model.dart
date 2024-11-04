import 'package:quizz/services/firebase/course/model/course_model.dart';
import 'package:quizz/services/firebase/user/model/user_model.dart';

class Feedback {
  String feedbackId;
  Course course;
  User user;
  String feedbackText;
  int rating;

  Feedback(
      {required this.feedbackId,
      required this.course,
      required this.user,
      required this.feedbackText,
      required this.rating});

  factory Feedback.fromJson(Map<String, dynamic> json) {
    return Feedback(
      feedbackId: json['id'],
      course: (json['course'] != null && json['course'] is Map<String, dynamic>)
          ? Course.fromJson(json['course'])
          : Course(
              courseId: 'No ID',
              mainCourse: 'No Course',
              courseName: 'Unknown',
              user: json['userId'],
              category: json['user Category'],
              description: 'Unknown'),
      user: (json['user'] != null && json['user'] is Map<String, dynamic>)
          ? User.fromJson(json['user'])
          : User(
              userId: 'No ID',
              name: 'Unknown',
              username: '',
              email: '',
              password: '',
              role: 'Unknown'),
      feedbackText: json['feedback_text'] ?? '',
      rating: json['rating'] ?? 0,
    );
  }
}
