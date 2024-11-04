import 'package:quizz/services/firebase/category/model/category_model.dart';
import 'package:quizz/services/firebase/user/model/user_model.dart';

class Course {
  final String courseId;
  final String courseName;
  final String description;
  final String mainCourse;
  User user;
  Category category;

  Course({
    required this.courseId,
    required this.mainCourse,
    required this.courseName,
    required this.description,
    required this.user,
    required this.category,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['id'] ?? 'No ID',
      mainCourse: json['course'] ?? 'No Course',
      courseName: json['course_name'] ?? 'Unknown Name',
      description: json['description'] ?? 'No Description',
      user: (json['user'] != null && json['user'] is Map<String, dynamic>)
          ? User.fromJson(json['user'])
          : User(
              userId: 'No ID',
              name: 'Unknown',
              username: '',
              email: '',
              password: '',
              role: 'Unknown'),
      category:
          (json['category'] != null && json['category'] is Map<String, dynamic>)
              ? Category.fromJson(json['category'])
              : Category(
                  categoryNumber: 0,
                  categoryId: 'Unknown',
                  categoryName: 'Unknown',
                  feedback: []),
    );
  }
}
